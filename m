Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7601DD729E7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH38W-0005cC-19; Fri, 29 Nov 2024 10:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH38T-0005bU-RA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:42:25 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH38R-00010b-S1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:42:25 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cfadf851e2so2894499a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732894940; x=1733499740; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UhwMp6LZ6FzsyEphdvEGwu2rBtsdacgIuy/U+/WBjQg=;
 b=dlXj0A6SFfWGZpbofJkrATy8D6yXlCDLcNbzeKeedcQNsQv8SVSy5q4K2nfGme7bif
 52jAseJsZlBPTkTaFXJSThWQmsOZAWQ3NN7j5kS/GmuGzMeEFebtzHkO+GsXLnbkB3wD
 8Pjl5ArNxjO3A8RQT3YJMljXP7Yj3X2P97X3cuLb1fYEKf7gx1Fob6iFGdIsqSOfXeb6
 OEZKX7QX8pSbSWhmclNoTfgNermD2O3m0ClPb6mMNYSabUMT9lqUPxUn2BpQZ+6kUOYG
 47Pu8GQDc9wFD1qXn1+8a8gr+iVcy/LF3X8MiQ+qxU6bMxXn7/AV0Z5jYHeDbQswvH/q
 NlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732894940; x=1733499740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UhwMp6LZ6FzsyEphdvEGwu2rBtsdacgIuy/U+/WBjQg=;
 b=Jqyp7gfZNPdxjORfgm4qwD80ybHHD94p4iYgD1MKGFxN9JW43gChM3RsIXNcsx6wTI
 NYjgzi8hJKZFsbNOT01KVNXpm651VyE9ie4bxo0WjlujKHNgT1Uly53R0ScdT0IRAOTL
 Zy+b3xLJo1HuWMmrBNcTuDIGr5U91cZn8YDlcNN8uMah+aiQjdh5on+AZi3wtA1xUpyu
 jM9c7vaVgEztWgK1f/jP+2JjNRVP3dUQMabyxJBj5HpZ/lWt8IisUEmypbqPWvY4CcZL
 W6Y5kurQ9JKyFMO6n0CRJMW2n1jGrGit30LzoqAiuxf+x2XraxzBTTLr4Qp8EZTvmXCa
 f/XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsHkcAz+a8osUtMXTVnHZuQSk2LGtR0V5A7cz/wbFBiZShCiKk8v1Z/xd/hJpqDKsObdGRyB+uLH+I@nongnu.org
X-Gm-Message-State: AOJu0YxI0Qo6pkgfyQuu36KxAHOlWH5ZvtiUChHxyoarX1rq0zKxdY2n
 oeupmU/106RXpCuxXv0LQuamjrjRDxp5JfBJPmsUXUFh4QR8ZsGNH9B11uQX/bD2gB9rnH2CH52
 uFQLNx0Gvl0IEeHeW0zLyV+yxELKaFpI0AfKwhQ==
X-Gm-Gg: ASbGnctTnP9gANsQfl+qrDthsBmDbYLnvqqQ6QNtbJURp6cGr0lARAiooA5gyltqrFf
 ka/sDAr7l/mSYb1t3njNsy87/u/pQbUSY
X-Google-Smtp-Source: AGHT+IGLUvSKDH+4UWkxaWi8YnuLMe/vbJeTiNyrWy7eOGtt6PR+y7mTJNIziLOVYADYe6pHiOAUq59zWmrBSrZaB04=
X-Received: by 2002:a05:6402:13ce:b0:5cf:ab23:1f07 with SMTP id
 4fb4d7f45d1cf-5d080bdb609mr14641790a12.15.1732894939616; Fri, 29 Nov 2024
 07:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com> <ZxuX4i9NjVRizB72@redhat.com>
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
In-Reply-To: <87ldx2krdp.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2024 15:42:08 +0000
Message-ID: <CAFEAcA-Pi4GRXyY3Lf-rCYk0CDZ5cT22orHT6JDxK14k9JMkng@mail.gmail.com>
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, richard.henderson@linaro.org, alex.bennee@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, 
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com, 
 philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 29 Nov 2024 at 15:10, Cornelia Huck <cohuck@redhat.com> wrote:
> The good news is that in many cases we only have differences in bits
> that map to a feature (and are actually writable in current KVM.) The
> bad news is that we have a number of exceptions.
>
> Comparison #1:
>
> ID_AA64DFR0
> f010307009      #of breakpoints:7
> f010305009      #of breakpoints:5
>
> BRPs does not match to any feature (but has a different meaning when we
> have FEAT_Debugv8p9 and 16+ breakpoints)
> [this is a whole can of worms in general]
>
> ID_AA64MMFR0
> 2100022200101026        FEAT_ECV, FEAT_FGT, 4PB
> 0000022200101125        mixed endian, 256TB
>
> FEAT_ECV -> may be 1 or 2 in ECV, with different capabilities (I guess
> we would need to allow something like FEAT_ECV=2 to expess this?)

This one was an unfortunate oversight; I expect that there
will be a separate feature name for the =2 case in some future
spec release. But as you note for FEAT_BBM below, not
every different ID field value always has its own FEAT_ name.
(FEAT_HAFDBS is another -- it allows ID_AA64MMFR1_EL1.HAFDBS to
be 1 or 2.)

> support for mixed endian -> indicated in BigEnd, no feature (how
> relevant is this in practice?)

ID_AA64MMFR0_EL1.BigEnd == 1 is FEAT_MixedEnd. Relevant if your
guest or its userspace wants to use big-endian, which is probably
approximately nobody in a KVM context but is theoretically possible.

> PARange (52 bits/4PB vs 48 bits/256TB) -> no feature, but some values
> depend on other features -- we care about this when creating a cpu, but
> migrating to another system with a mismatched range would be
> problematic, unless configuration outside of the cpu model would take
> care of it
>
> Comparison #2:
>
> ID_AA64PFR0
> 1101011021111111        FEAT_AMUv1, GIC v3.0/4.0
> 1101001020111111
>
> GIC == 1 indicates GIC CPU sysreg interface for 3.0/4.0, but no feature
> (I'm not quite sure how we handle this in QEMU)

We basically defer GIC emulation almost entirely to the
kernel (which will set the GIC bit in the ID registers
according to whether userspace asked it for a GIC or not).

> ID_AA64MMFR1
> 1000000010312122        FEAT_ECBHB, !FEAT_ETS2, FEAT_PAN3, FEAT_HPDS2, FEAT_HAFDBS
> 0000001010211120        !FEAT_ETS2, FEAT_PAN2, FEAT_HPDS
>
> both ETS == 0 and ETS == 1 indicate that FEAT_ETS2 is not implememented
> (ETS == 2 would indicate FEAT_ETS2) -- I guess we would want to
> standardize on ETS == 0
> FEAT_PAN3 implies FEAT_PAN2, and FEAT_HPDS2 implies FEAT_HPDS2, so
> probably fine

Yes, in general if the number in the field gets bigger
this should be a backwards-compatible improvement in
the feature.

thanks
-- PMM

