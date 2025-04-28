Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD75C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Ism-0004mq-ED; Mon, 28 Apr 2025 03:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9IsW-0004fH-00
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9IsS-0008Da-IV
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CISJnPMfG/uXMv0l6JF9iE0pkiWbduTPqPP8qKQb4lc=;
 b=fH7vsYChrAznmqO8re0AV1vJzBXPUwOgh3J2XRem4nnupixrRlVA7Qc2NgCTo45yJZhP7V
 Clfnr7ylddPvPD5c2jQPJu716wxxveSaF4e/P2qVGCdmkgDv3FA05G95nTcHoK6DZ+tYbQ
 1MxVPV7FS7ODGjIHBMzOucxCZTX74wE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-P6WChWBUNwemPEoOA7SP5g-1; Mon,
 28 Apr 2025 03:26:04 -0400
X-MC-Unique: P6WChWBUNwemPEoOA7SP5g-1
X-Mimecast-MFC-AGG-ID: P6WChWBUNwemPEoOA7SP5g_1745825162
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B09618004A7; Mon, 28 Apr 2025 07:26:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7A6E1800352; Mon, 28 Apr 2025 07:26:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6E6821E66C2; Mon, 28 Apr 2025 08:12:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 2/5] i386/kvm: Support basic KVM PMU filter
In-Reply-To: <aA3sLRzZj2270cSs@intel.com> (Zhao Liu's message of "Sun, 27 Apr
 2025 16:34:53 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-3-zhao1.liu@intel.com>
 <878qnoha3j.fsf@pond.sub.org> <aA3sLRzZj2270cSs@intel.com>
Date: Mon, 28 Apr 2025 08:12:09 +0200
Message-ID: <87r01c3jd2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> ...
>
>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index dc694a99a30a..51a7c61ce0b0 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -232,7 +232,8 @@ DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>> >      "                eager-split-size=n (KVM Eager Page Split chunk size, default 0, disabled. ARM only)\n"
>> >      "                notify-vmexit=run|internal-error|disable,notify-window=n (enable notify VM exit and set notify window, x86 only)\n"
>> >      "                thread=single|multi (enable multi-threaded TCG)\n"
>> > -    "                device=path (KVM device path, default /dev/kvm)\n", QEMU_ARCH_ALL)
>> > +    "                device=path (KVM device path, default /dev/kvm)\n"
>> > +    "                pmu-filter=id (configure KVM PMU filter)\n", QEMU_ARCH_ALL)
>> 
>> As we'll see below, this property is actually available only for i386.
>> Other target-specific properties document this like "x86 only".  Please
>> do that for this one, too.
>
> Thanks! I'll change QEMU_ARCH_ALL to QEMU_ARCH_I386.

That would be wrong :)

QEMU_ARCH_ALL is the last argument passed to macro DEF().  It applies to
the entire option, in this case -accel.

I'd like you to mark the option parameter as "(x86 only)", like
notify-vmexit right above, and several more elsewhere.

>> As far as I can tell, the kvm-pmu-filter object needs to be activated
>> with -accel pmu-filter=... to do anything.  Correct?
>
> Yes,
>
>> You can create any number of kvm-pmu-filter objects, but only one of
>> them can be active.  Correct?
>
> Yes! I'll try to report error when user repeats to set this object, or
> mention this rule in doc.

Creating kvm-pmu-filter objects without using them should be harmless,
shouldn't it?  I think users can already create other kinds of unused
objects.

>> > +
>> > +static int kvm_install_pmu_event_filter(KVMState *s)
>> > +{
>> > +    struct kvm_pmu_event_filter *kvm_filter;
>> > +    KVMPMUFilter *filter = s->pmu_filter;
>> > +    int ret;
>> > +
>> > +    kvm_filter = g_malloc0(sizeof(struct kvm_pmu_event_filter) +
>> > +                           filter->nevents * sizeof(uint64_t));
>> 
>> Should we use sizeof(filter->events[0])?
>
> No, here I'm trying to constructing the memory accepted in kvm interface
> (with the specific layout), which is not the same as the KVMPMUFilter
> object.

You're right.  What about sizeof(kvm_filter->events[0])?

[...]


