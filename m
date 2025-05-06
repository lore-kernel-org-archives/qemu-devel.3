Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A88C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKMm-0002aj-06; Tue, 06 May 2025 11:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCKMk-0002ZJ-MM
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCKMi-0003Kg-51
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skz6KJITmDsnIkiTQSvkece8gmL9zkoBs34jG2iqABE=;
 b=I43qcwV3AtulM57dBmANtXEm9PIJmKmiV6onyPZYKH3Pg12cmyGPjKIMourQ4USnaG1VA4
 +VKqQZ6PD6QJ/kX3TTIS7MvA0Y19FDzmCLnjGkbA1IPrKbpGx5jvIXThK4l9EcQMoBdUZi
 o7ZN4iPTHFwiQNhW8RswKnGZYkhSzGw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-JhNyM_QeNLqmDaCXmnUNyg-1; Tue,
 06 May 2025 11:37:49 -0400
X-MC-Unique: JhNyM_QeNLqmDaCXmnUNyg-1
X-Mimecast-MFC-AGG-ID: JhNyM_QeNLqmDaCXmnUNyg_1746545867
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 947C11955DB9; Tue,  6 May 2025 15:37:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 949271956094; Tue,  6 May 2025 15:37:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECCC921E66C3; Tue, 06 May 2025 17:37:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,  Dmitry Fleytman
 <dmitry.fleytman@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,  Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>,  Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,  Yuri Benditovich
 <yuri.benditovich@daynix.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Michael Roth <michael.roth@amd.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Lei Yang <leiyang@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/4] qdev-properties: Accept bool for OnOffAuto
In-Reply-To: <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com> (Akihiko
 Odaki's message of "Thu, 6 Feb 2025 19:16:44 +0900")
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-2-cbf0aa04c9f9@daynix.com>
 <87cyfwxveo.fsf@pond.sub.org>
 <44b21e4c-b076-41bb-9564-1e7a8cf4a450@daynix.com>
 <87r04bs8sj.fsf@pond.sub.org>
 <6e6935dd-fae7-4cce-acad-69609eba9b6e@daynix.com>
Date: Tue, 06 May 2025 17:37:41 +0200
Message-ID: <87r011rbqy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/02/06 18:48, Markus Armbruster wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:

[...]

>> I understand we have something like this:
>> 
>> * true: on if possible, else off
>> 
>> * false: off (always possible)
>> 
>> Which one is the default?
>
> It depends. Some properties have true by default. The others have false.
>
>> 
>> There is no way to reliably configure "on", i.e. fail if it's not
>> possible.  I agree that's a problem.
>> 
>>>                                              This problem can be solved
>>> using an existing mechanism, OnOffAuto, which differentiates the "auto"
>>> state and explicit the "on" state.
>> 
>> I guess you're proposing something like this:
>> 
>> * auto: on if possible, else off
>> 
>> * on: on if possible, else error
>> 
>> * off: off (always possible)
>> 
>> Which one is the default?
>
> I converted on to auto and off to false in a following patch.
>
>> 
>>> However, converting bool to OnOffAuto surfaces another problem: they
>>> disagree how "on" and "off" should be written. Please note that the
>>> disagreement already exists and so it is nice to solve anyway.
>> 
>> Yes, converting bool to OnOffAuto is an incompatible change.
>
> Not just about conversion, but this inconsistency require users to know 
> whether a property is bool or OnOffAuto and change how the values are 
> written in JSON accordingly. This somewhat hurts usability.
>
>> 
>>> This patch tries to solve it by tolerating bool values for OnOffAuto. As
>>> you pointed out, this approach has a downside: it makes OnOffAuto more
>>> complicated by having multiple ways to express the same thing.
>> 
>> It also affects existing uses of OnOffAuto, where such a change is
>> unnecessary and undesirable.

To be clear: this is pretty much a deal-breaker for me.

We established above that you need certain boolean properties to take a
third state.  I'm willing to discuss patches that change exactly these
properties.  I'm going to reject patches that affect properties that do
not need such a change.

>>> Another approach is to have one unified way to express "on"/"off" for
>>> bool and OnOffAuto. This will give three options in total:
>>>
>>> 1. Let OnOffAuto accept JSON bool and "on"/"off" (what this patch does)
>> 
>> The parenthesis is inaccurate.  This patch only affects qdev properties.
>> It does not affect use of OnOffAuto elsewhere, e.g. QOM object
>> "sev-guest" property "legacy-vm-type", or QMP command blockdev-add
>> argument "locking" with driver "file".
>> 
>>> 2. Let OnOffAuto and bool accept JSON bool and deprecate "on"/"off"
>>> 3. Let OnOffAuto and bool accept "on"/"off" and deprecate JSON bool
>> 
>> For each of these options:
>> 
>> (a) Change exactly the uses of OnOffAuto that need to become tri-state
>> 
>> (b) Change all qdev properties (currently a superset of (a); what this
>>     patch does)
>> 
>> (c) Change all uses of OnOffAuto
>> 
>> I dislike (c) and especially (b).
>> 
>>> I'm fine with either of these approaches; they are at least better than
>>> the current situation where users need to care if the value is OnOffAuto
>>> or bool when they just want to express on/off. Please tell me what you
>>> prefer.
>> 
>> We managed to maneuver ourselves into a bit of a corner in just a few
>> simple steps:
>> 
>> * The obvious type for a flag is bool.
>> 
>> * The obvious type for a small set of values is enum.
>> 
>> * Thus, the obvious type for a tri-state is enum.
>> 
>> * But this prevents growing a flag into a tri-state compatibly.  Which
>>   is what you want to do.
>> 
>> However, we actually have a second way to do a tri-state: optional bool,
>> i.e. present and true, present and false, absent.
>> 
>> Permit me a digression...  I'm not a fan of assigning "absent" a meaning
>> different from any present value.  But it's a design choice QAPI made.
>
> It's a new insight I didn't know. Properties in qdev have a default 
> value instead of special "absent". But if QAPI does have special 
> "absent", perhaps qdev may be modified to align with.

Nothing stops you from creating qdev properties with a special "absent"
value.  All you need is a special value that cannot be set.

In fact, the humble "str" property already works that way: it's a char *
where null means "absent".

Code can recognize "absent" and do whatever needs doing then.  For
instance, consider device "ide-cd".  It has three such properties:
"ver", "serial", and "model".  "ver" defaults to "2.5+", "serial" to
some unique string, but "model" defaults to NULL.  Since you cannot set
such a value, it effectively means "absent".  The code responsible for
this is in ide_dev_initfn():

    if (!dev->version) {
        dev->version = g_strdup(s->version);
    }
    if (!dev->serial) {
        dev->serial = g_strdup(s->drive_serial_str);
    }

Note it leaves a null dev->model null.

>> Using optional that way can occasionally lead to trouble.  Consider
>> migrate-set-parameters.  Its arguments are all optional.  For each
>> argument present, the respective migration parameter is set to the
>> argument value.  You cannot use this to reset a migration parameter from
>> present to absent.  Matters for parameters where "absent" has a meaning
>> different from any "present" value.
>> 
>> End of digression.
>> 
>> Start of next digression :)
>> 
>> Note that qdev properties are generally optional.  The only way to make
>> them mandatory is to reject their default value in .realize().  When
>> users set this default value explicitly, the error message will almost
>> certainly be confusing.
>> 
>> End of digression.
>> 
>> Optional bool may enable a fourth solution:
>> 
>> 4. Make "absent" mean on if possible, else off, "present and true" mean
>>    on if possible, else error, and "present and false" mean off (always
>>    possible).
>> 
>>    This changes the meaning of "present and true", but it's precisely
>>    the change you want, isn't it?
>
> We have "false by default" properties so it unfortunately does not work.

Then make the code make "absent" mean what you need it to mean.  Just
like the code from ide_dev_initfn() I quoted above.

>> Yet another solutions:
>> 
>> 5. Alternate of bool and an enum with a single value "auto".
>> 
>>     Falls apart with the keyval visitor used for the command line.
>>     Fixable, I believe, but a good chunk of work and complexity.
>
> I may have missed something, but I think that will break JSON string 
> literals "on" and "off".

Unbreaking it will be a good chunk of work and complexity, I believe.

>> My gut feeling: explore 4. first.


