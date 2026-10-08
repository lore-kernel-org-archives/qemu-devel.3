Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A0CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEfzZ-0002ZB-7n; Thu, 08 Oct 2026 00:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEfxV-0002MR-Iu
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 00:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEfxM-0001rB-Gd
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 00:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791434531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z3NLR+jsydpS7EVhHgWwbrOJAVarsHyVv+cgpCuvGr8=;
 b=IbeMd8ozoHppcYlNgYM8DzerxuKDpR5thehenZpIXzMAV7BIJH77aMohjjULKJGf1a5uZj
 aw2cNqKgpz9mB1/OVkT5mG4zvpFaR6LRCyNL+CLelCDLo03JG+jPOwEtCVYq81dJ0nlvFD
 QpKKCifhyXLoe60YRu080tfMHo6QGCg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-E0MoPdTQMPKz0f9_CuNHqw-1; Thu,
 8 Oct 2026 04:42:07 +0000
X-MC-Unique: E0MoPdTQMPKz0f9_CuNHqw-1
X-Mimecast-MFC-AGG-ID: E0MoPdTQMPKz0f9_CuNHqw_1791434526
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DDA61834511; Thu,  8 Oct 2026 04:42:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0A881956052; Thu,  8 Oct 2026 04:42:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B87B21E6A04; Thu, 08 Oct 2026 06:42:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 03/11] qemu-option: Remove short form options support
In-Reply-To: <87y0c97kbs.fsf@suse.de> (Fabiano Rosas's message of "Wed, 07 Oct
 2026 09:43:03 -0300")
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-4-farosas@suse.de>
 <87h5iyasxn.fsf@pond.sub.org> <87y0c97kbs.fsf@suse.de>
Date: Thu, 08 Oct 2026 06:42:03 +0200
Message-ID: <874iew7qhw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Option parameters without a value (i.e. key vs. key=val) are
>>> deprecated. The missing value is currently implied to be either "on"
>>> or "off" depending on whether the parameter name starts with "no".
>>
>> Commit ccd3b3b811 (qemu-option: warn for short-form boolean options,
>> 2020-11-09).  Six years of warnings should suffice.
>>
>>> Remove the implied behavior and start rejecting option parameters
>>> without values by emitting the error message:
>>>
>>>  "Parameter 'foo' without a value."
>>>
>>> Two special cases remain:
>>>
>>> 1) The 'help' parameter is special and still supported. Keep a
>>>    positive value attached to it ("on").
>>>
>>>    Note that currently there is no validation for the value (if any)
>>>    attached to the help parameter. help, help=on, help=off, help=foo
>>>    all result in the help text being emitted. This is not changed by
>>>    this patch.
>>
>> Really?
>>
>>     $ qemu-system-x86_64 -chardev help=foo
>>     qemu-system-x86_64: -chardev help=foo: Invalid parameter 'help'
>>
>
> Ah, ok, it depends on whether the option accepts any parameter
> (i.e. opts_accepts_any()). Here's -object failing to reject the bogus
> value:
>
> $ qemu-system-x86_64 -object memory-backend-ram,id=m1,help=foo
> memory-backend-ram options:
>   dump=<bool>            - Set to 'off' to exclude from core dump
>   host-nodes=<[uint16]>  - Binds memory to the list of NUMA host nodes
>   merge=<bool>           - Mark memory as mergeable
>   policy=<HostMemPolicy> - Set the NUMA policy
>   prealloc-context=<link<thread-context>> - Context to use for creating CPU threads for preallocation
>   prealloc-threads=<int> - Number of CPU threads to use for prealloc
>   prealloc=<bool>        - Preallocate memory
>   reserve=<bool>         - Reserve swap space (or huge pages) if applicable
>   share=<bool>           - Mark the memory as private to QEMU or shared
>   size=<size>            - Size of the memory region (ex: 500M)
>   x-use-canonical-path-for-ramblock-id=<bool>

Bizarre :)

>>> 2) The empty value is allowed if the key is also empty. This can be
>>>    achieved in the command line by adding commas.
>>>    E.g.: share=on,, is parsed as:
>>>      key:"share" value:"on" and
>>>      key:"" value:"on"
>>
>> I don't think so:
>>
>>     $ qemu-system-x86_64 -object memory-backend-ram,id=mem0,share=on,,
>>     qemu-system-x86_64: -object memory-backend-ram,id=mem0,share=on,,: Parameter 'share' expects 'on' or 'off'
>>
>
> Bah, I wrote the example for the commit message but haven't tried
> it. I'm trying to refer to the single leading comma scenario, we have a
> test for it:
>
>     /* Except when it isn't */
>     opts = qemu_opts_parse(&opts_list_03, ",", false, &error_abort);
>     g_assert_cmpuint(opts_count(opts), ==, 1);
>     g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "on");

The "except when it isn't" comment refers to the test right above:

      /* Trailing comma is ignored */
      opts = qemu_opts_parse(&opts_list_03, "x=y,", false, &error_abort);
      g_assert_cmpuint(opts_count(opts), ==, 1);
      g_assert_cmpstr(qemu_opt_get(opts, "x"), ==, "y");

This is about trailing comma.  Is the exception is only possible when
the trailing comma is also the leading comma?

> The following are parsed as valid and only reject the empty key further
> down the line:
>
> $ qemu-system-x86_64 -drive ,
> qemu-system-x86_64: -drive ,: warning: short-form boolean option '' deprecated
> Please use =on instead
> qemu-system-x86_64: -drive ,: Must specify either driver or file
>
> $ qemu-system-x86_64 -drive ,file=dummy
> qemu-system-x86_64: -drive ,file=dummy: warning: short-form boolean option '' deprecated
> Please use =on instead

Looks like the answer is no.  The tests could be clearer there.  Might
not matter after your series.

> WARNING: Image format was not specified for 'dummy' and probing guessed raw.
>          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
>          Specify the 'raw' format explicitly to remove the restrictions.
> qemu-system-x86_64: -drive ,file=dummy: Block format 'raw' does not support the option ''

The entire parser should be burned with fire.

What are the remaining differences to the keyval.c parser after your
series?  Can we deprecate them?

>> Set a breakpoint on qapi_bool_parse() to see the actual value.  It's
>> "on,".  In QemuOpts syntax, double comma is an escape, so you can put
>> comma in values.
>>
>>> One effect of this change that might not be obvious is that parameter
>>> combinations of the form:
>>>
>>>  id=mem0,share,help
>>>
>>> no longer produce the help output. The lack of value for the 'share'
>>> parameter is reported with precedence. Users will need to either use a
>>> valid value or omit the parameter entirely:
>>>
>>>  id=mem0,share=on,help
>>>  id=mem0,help
>>
>> That's unfortunate.
>>
>> [...]


