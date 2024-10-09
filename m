Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71323CEDD95
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 13:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syX2s-0002zG-Ou; Wed, 09 Oct 2024 09:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syX2o-0002yi-SM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syX2n-00059u-6k
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728481678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjH/P/g2QKpC8+ixdPp3xnRGLyP1oTyCqIlBOSjcPAQ=;
 b=YgUQm06ZRFgiRuBCjRDeUmPTntylshfGV/4VSFyakv2uTX4NwEDsSvPn04St+nD75R0Iwq
 2YDyEx1xg/5hM5To6+2cOyb0Kpx04R+7AjxIORv0IRpUyXkQ3kl8RB15tBotYoHR0pd3sj
 oz+Tetdq6a/HaskdjNWY841pyuJpOIo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-I4T5K-KuPdmMtE2eIcmDmw-1; Wed,
 09 Oct 2024 09:47:57 -0400
X-MC-Unique: I4T5K-KuPdmMtE2eIcmDmw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCC671956077; Wed,  9 Oct 2024 13:47:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C08619560AA; Wed,  9 Oct 2024 13:47:52 +0000 (UTC)
Date: Wed, 9 Oct 2024 14:47:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: x86 CPU properties "family", "model", "stepping", "tsc-freq"
Message-ID: <ZwaJheBeqrOC5BAv@redhat.com>
References: <87wmihr14b.fsf@pond.sub.org> <ZwZqfniI9UlHHXVG@redhat.com>
 <871q0ppf0m.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q0ppf0m.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 09, 2024 at 03:44:25PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Oct 09, 2024 at 01:01:40PM +0200, Markus Armbruster wrote:
> >> QOM properties serve several purposes: initial configuration (external
> >> interface), run time control and monitoring (external interface), and
> >> internal purposes like versioning.  Which purpose(s) a property serves
> >> is often unclear.
> 
> [...]
> 
> >> Property "tsc-freq" seems not to be used internally.  I figure changing
> >> it at run time makes no sense.  Looks like it is be meant to be set by
> >> the user: x86_cpu_parse_featurestr() seems to parse it from the argument
> >> of -cpu.  Correct?  Note that -cpu help doesn't mention it.
> >
> > "tsc-freq" is a back compat alias for 'tsc-frequency' AFAICT, and
> > we need the latter if you want to guarantee fixed TSC freq across
> > migration. eg commit 561dbb41b1d752098249128d8462aaadc56fd15d
> 
> Looking more closely...
> 
> "tsc-freq" wraps around "tsc-frequency" except the value is converted
> with qemu_strtosz_metric().
> 
> "tsc-frequency" accepts values between 0 and INT64_MAX.  The unit is Hz.
> However, the frequency is internally stored in kHz, in CPUArchState
> member tsc_khz, and the conversion from the value "tsc-frequency"
> silently truncates.  Ugh!  See x86_cpuid_set_tsc_freq().
> 
> kvm_arch_set_tsc_khz() passes the kHz value to the kernel like this:
> 
>     kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz)
> 
> I believe the kernel code consuming the value is in arch/x86/kvm/x86.c's
> kvm_arch_vcpu_ioctl().  It appears to silently truncate the value to 32
> bit unsigned:
> 
> 	case KVM_SET_TSC_KHZ: {
> 		u32 user_tsc_khz;
> 
> 		r = -EINVAL;
> --->		user_tsc_khz = (u32)arg;
> 
> 		if (kvm_caps.has_tsc_control &&
> 		    user_tsc_khz >= kvm_caps.max_guest_tsc_khz)
> 			goto out;
> 
> 		if (user_tsc_khz == 0)
> 			user_tsc_khz = tsc_khz;
> 
> 		if (!kvm_set_tsc_khz(vcpu, user_tsc_khz))
> 			r = 0;
> 
> 		goto out;
> 	}
> 
> Ugh again!
> 
> Should we reject values exceeding UINT32_MAX kHz in QEMU?

Sounds like a reasonable idea to me, as I don't think it is very likely
that someone is passing a number greater than UINT32_MAX and relying
on truncation.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


