Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F90BD729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3HJ-0004J8-BD; Fri, 29 Nov 2024 10:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tH3HG-0004IC-Jt
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tH3HE-0004GA-SV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732895487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8GJVdazRf21ux4iTl+yQ/9gjpKS7isQK/8RyegOC2SY=;
 b=h7zP6nQtgUkpDrmZlPJoC1JCD2l4oVVVkGa0y3kp6le8+49ZjX/jvIBSIuGErcT7wBCGt0
 FeyWSXiuvfc0Tyh5HqXadeIs4sFoTRGBP0Ixm6sXQDrXZmm25J4RDc1v8QlFGkApSgNSWb
 FOk5fm3lfsmo7CEY0bH2CJ2m6qDRix0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-Zf6NAUy_PLaWPTeSmpfhhQ-1; Fri,
 29 Nov 2024 10:51:24 -0500
X-MC-Unique: Zf6NAUy_PLaWPTeSmpfhhQ-1
X-Mimecast-MFC-AGG-ID: Zf6NAUy_PLaWPTeSmpfhhQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A74DE19560B7; Fri, 29 Nov 2024 15:51:20 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16249195605A; Fri, 29 Nov 2024 15:51:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger@redhat.com, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
In-Reply-To: <CAFEAcA-Pi4GRXyY3Lf-rCYk0CDZ5cT22orHT6JDxK14k9JMkng@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_EGxj2aqc_2-kY@redhat.com>
 <63c232c2-a325-48d6-8ed4-753a7c6e3b4e@redhat.com>
 <87ikstn8sc.fsf@redhat.com> <87frnwmn2v.fsf@redhat.com>
 <b7f25d3b-6ba7-4924-9383-74c1169dfe86@redhat.com>
 <87ldx2krdp.fsf@redhat.com>
 <CAFEAcA-Pi4GRXyY3Lf-rCYk0CDZ5cT22orHT6JDxK14k9JMkng@mail.gmail.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 29 Nov 2024 16:51:15 +0100
Message-ID: <87frnakpho.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Nov 29 2024, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 29 Nov 2024 at 15:10, Cornelia Huck <cohuck@redhat.com> wrote:
>> The good news is that in many cases we only have differences in bits
>> that map to a feature (and are actually writable in current KVM.) The
>> bad news is that we have a number of exceptions.
>>
>> Comparison #1:
>>
>> ID_AA64DFR0
>> f010307009      #of breakpoints:7
>> f010305009      #of breakpoints:5
>>
>> BRPs does not match to any feature (but has a different meaning when we
>> have FEAT_Debugv8p9 and 16+ breakpoints)
>> [this is a whole can of worms in general]
>>
>> ID_AA64MMFR0
>> 2100022200101026        FEAT_ECV, FEAT_FGT, 4PB
>> 0000022200101125        mixed endian, 256TB
>>
>> FEAT_ECV -> may be 1 or 2 in ECV, with different capabilities (I guess
>> we would need to allow something like FEAT_ECV=2 to expess this?)
>
> This one was an unfortunate oversight; I expect that there
> will be a separate feature name for the =2 case in some future
> spec release. But as you note for FEAT_BBM below, not
> every different ID field value always has its own FEAT_ name.
> (FEAT_HAFDBS is another -- it allows ID_AA64MMFR1_EL1.HAFDBS to
> be 1 or 2.)

Ah yes, I actually noticed FEAT_HAFDBS as well.

>
>> support for mixed endian -> indicated in BigEnd, no feature (how
>> relevant is this in practice?)
>
> ID_AA64MMFR0_EL1.BigEnd == 1 is FEAT_MixedEnd. Relevant if your
> guest or its userspace wants to use big-endian, which is probably
> approximately nobody in a KVM context but is theoretically possible.

Ok, that one I missed in the list; if there's a feature, we should be
able to use it.

>
>> PARange (52 bits/4PB vs 48 bits/256TB) -> no feature, but some values
>> depend on other features -- we care about this when creating a cpu, but
>> migrating to another system with a mismatched range would be
>> problematic, unless configuration outside of the cpu model would take
>> care of it
>>
>> Comparison #2:
>>
>> ID_AA64PFR0
>> 1101011021111111        FEAT_AMUv1, GIC v3.0/4.0
>> 1101001020111111
>>
>> GIC == 1 indicates GIC CPU sysreg interface for 3.0/4.0, but no feature
>> (I'm not quite sure how we handle this in QEMU)
>
> We basically defer GIC emulation almost entirely to the
> kernel (which will set the GIC bit in the ID registers
> according to whether userspace asked it for a GIC or not).
>
>> ID_AA64MMFR1
>> 1000000010312122        FEAT_ECBHB, !FEAT_ETS2, FEAT_PAN3, FEAT_HPDS2, FEAT_HAFDBS
>> 0000001010211120        !FEAT_ETS2, FEAT_PAN2, FEAT_HPDS
>>
>> both ETS == 0 and ETS == 1 indicate that FEAT_ETS2 is not implememented
>> (ETS == 2 would indicate FEAT_ETS2) -- I guess we would want to
>> standardize on ETS == 0
>> FEAT_PAN3 implies FEAT_PAN2, and FEAT_HPDS2 implies FEAT_HPDS2, so
>> probably fine
>
> Yes, in general if the number in the field gets bigger
> this should be a backwards-compatible improvement in
> the feature.

Indeed, I hope that this will be the case for new features.


