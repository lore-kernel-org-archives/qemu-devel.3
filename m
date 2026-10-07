Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6373CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENkB-0007b8-GR; Wed, 07 Oct 2026 05:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xELlv-0006xW-TJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xELlr-0006oa-9U
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791356938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBj0ZMrggthS2oSnf8LAMOIoq8LTiUp93b3x9e5k2x8=;
 b=UYL1HyHqcqXiAMctnPaUeaQv2BdNKwtzlG+l8xrT/dM7UN5dcZYtTHjp1AKnDjNuChVhOO
 U3Y7pYIHf3jLkc/MiaP4/x6chMWghCkrOSM3SC75qvX5NWYuhNiyjH7oI8vXTobT3FwRLE
 XaaRE7RgQm+jXNGGvSjetydiiScz8qg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-zPxc12yeNz-ChPnVSznCdw-1; Wed,
 07 Oct 2026 03:08:56 -0400
X-MC-Unique: zPxc12yeNz-ChPnVSznCdw-1
X-Mimecast-MFC-AGG-ID: zPxc12yeNz-ChPnVSznCdw_1791356935
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68760195E909; Wed,  7 Oct 2026 07:08:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16A881956044; Wed,  7 Oct 2026 07:08:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8074C21E6A04; Wed, 07 Oct 2026 09:08:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 03/11] qemu-option: Remove short form options support
In-Reply-To: <20260930221105.2262063-4-farosas@suse.de> (Fabiano Rosas's
 message of "Wed, 30 Sep 2026 19:10:57 -0300")
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-4-farosas@suse.de>
Date: Wed, 07 Oct 2026 09:08:52 +0200
Message-ID: <87h5iyasxn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Option parameters without a value (i.e. key vs. key=val) are
> deprecated. The missing value is currently implied to be either "on"
> or "off" depending on whether the parameter name starts with "no".

Commit ccd3b3b811 (qemu-option: warn for short-form boolean options,
2020-11-09).  Six years of warnings should suffice.

> Remove the implied behavior and start rejecting option parameters
> without values by emitting the error message:
>
>  "Parameter 'foo' without a value."
>
> Two special cases remain:
>
> 1) The 'help' parameter is special and still supported. Keep a
>    positive value attached to it ("on").
>
>    Note that currently there is no validation for the value (if any)
>    attached to the help parameter. help, help=on, help=off, help=foo
>    all result in the help text being emitted. This is not changed by
>    this patch.

Really?

    $ qemu-system-x86_64 -chardev help=foo
    qemu-system-x86_64: -chardev help=foo: Invalid parameter 'help'

> 2) The empty value is allowed if the key is also empty. This can be
>    achieved in the command line by adding commas.
>    E.g.: share=on,, is parsed as:
>      key:"share" value:"on" and
>      key:"" value:"on"

I don't think so:

    $ qemu-system-x86_64 -object memory-backend-ram,id=mem0,share=on,,
    qemu-system-x86_64: -object memory-backend-ram,id=mem0,share=on,,: Parameter 'share' expects 'on' or 'off'

Set a breakpoint on qapi_bool_parse() to see the actual value.  It's
"on,".  In QemuOpts syntax, double comma is an escape, so you can put
comma in values.

> One effect of this change that might not be obvious is that parameter
> combinations of the form:
>
>  id=mem0,share,help
>
> no longer produce the help output. The lack of value for the 'share'
> parameter is reported with precedence. Users will need to either use a
> valid value or omit the parameter entirely:
>
>  id=mem0,share=on,help
>  id=mem0,help

That's unfortunate.

[...]


