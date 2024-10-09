Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E3BCEDD94
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 13:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syWzc-0001sG-4P; Wed, 09 Oct 2024 09:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syWzZ-0001ru-Pz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syWzX-0004nZ-Oz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728481478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxSlVfdwjfarqvBks71oG7plJRRcCJoM0nP4bjc59ks=;
 b=iyWhfvQ3mKe8ELi16ltgm5Hl78Xtbh5Eg/4lAXTe/+OV+GCvLmCcYb5tSy/eOUWLAe/s61
 nvY0CcgkdPwO3wWOgvbvJQg9J7mj+Zn0PRL2H9PI7NTjHBDzktu+5gayLPM8OgNbzoERiG
 QjuabEebQnZIKJAcQOv72O6vyzxtJH4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-AQHXMEqwOVKbmxEgdMUg9A-1; Wed,
 09 Oct 2024 09:44:36 -0400
X-MC-Unique: AQHXMEqwOVKbmxEgdMUg9A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D50681956080; Wed,  9 Oct 2024 13:44:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A061919560AE; Wed,  9 Oct 2024 13:44:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D2E6221E6A28; Wed,  9 Oct 2024 15:44:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: x86 CPU properties "family", "model", "stepping", "tsc-freq"
In-Reply-To: <ZwZqfniI9UlHHXVG@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 9 Oct 2024 12:35:26 +0100")
References: <87wmihr14b.fsf@pond.sub.org> <ZwZqfniI9UlHHXVG@redhat.com>
Date: Wed, 09 Oct 2024 15:44:25 +0200
Message-ID: <871q0ppf0m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 09, 2024 at 01:01:40PM +0200, Markus Armbruster wrote:
>> QOM properties serve several purposes: initial configuration (external
>> interface), run time control and monitoring (external interface), and
>> internal purposes like versioning.  Which purpose(s) a property serves
>> is often unclear.

[...]

>> Property "tsc-freq" seems not to be used internally.  I figure changing
>> it at run time makes no sense.  Looks like it is be meant to be set by
>> the user: x86_cpu_parse_featurestr() seems to parse it from the argument
>> of -cpu.  Correct?  Note that -cpu help doesn't mention it.
>
> "tsc-freq" is a back compat alias for 'tsc-frequency' AFAICT, and
> we need the latter if you want to guarantee fixed TSC freq across
> migration. eg commit 561dbb41b1d752098249128d8462aaadc56fd15d

Looking more closely...

"tsc-freq" wraps around "tsc-frequency" except the value is converted
with qemu_strtosz_metric().

"tsc-frequency" accepts values between 0 and INT64_MAX.  The unit is Hz.
However, the frequency is internally stored in kHz, in CPUArchState
member tsc_khz, and the conversion from the value "tsc-frequency"
silently truncates.  Ugh!  See x86_cpuid_set_tsc_freq().

kvm_arch_set_tsc_khz() passes the kHz value to the kernel like this:

    kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz)

I believe the kernel code consuming the value is in arch/x86/kvm/x86.c's
kvm_arch_vcpu_ioctl().  It appears to silently truncate the value to 32
bit unsigned:

	case KVM_SET_TSC_KHZ: {
		u32 user_tsc_khz;

		r =3D -EINVAL;
--->		user_tsc_khz =3D (u32)arg;

		if (kvm_caps.has_tsc_control &&
		    user_tsc_khz >=3D kvm_caps.max_guest_tsc_khz)
			goto out;

		if (user_tsc_khz =3D=3D 0)
			user_tsc_khz =3D tsc_khz;

		if (!kvm_set_tsc_khz(vcpu, user_tsc_khz))
			r =3D 0;

		goto out;
	}

Ugh again!

Should we reject values exceeding UINT32_MAX kHz in QEMU?


