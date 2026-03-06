Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555CBF0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVM4-0006C9-MQ; Fri, 06 Mar 2026 08:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyVM3-0006C1-Il
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:36:35 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyVM1-0005SU-F1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:36:35 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79898953985so48514887b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 05:36:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772804190; cv=none;
 d=google.com; s=arc-20240605;
 b=jEGto0MWbclS+cJ4JnXHLicbOlWwnV20dvngugiW90jAHB0lBjissgZ5Up3JJ1kM0E
 ZsnkKpsxWUAccv+4nYUVyzJiAV6mNfhmDe1DpfNQ/43T0Lb7H9KaeCXuZ6roVQEV/kAA
 CpnAGSmxaiBQ1kifUn2RTsccwNeYavnB2xg2EW3q/zviQJtkCYrfrd8YnyH1ZVXxn2l1
 PE3mRi7ZQRUuQ8ndh5ts1BeJPHfamELvjZ5T7cTaGzzThl9dmbI7K4zHxUD5P1WXxsIH
 8JxBMODRhj1MARkvQ8MCLnft9nrvv3oe7NfQ5YSt08Zh5Wm+/ZfZZCUdvTRJSTR5H9Pv
 gSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HCQLd+EiglPdY8lR++J1vWDeZLDuOmfJaUc4kL430Hs=;
 fh=jUYsI/2acYShRiXxoUq/Pm9LQcAd+S5Ayx7Ab2mBfmk=;
 b=YPG+NiKedB+4Svu7aJaC929pFu0th5ad6QpNio3jnL8LUyXRrP5KdMoOI+54kuOdxy
 1t35eedZlWuqQUGSpkX1TQu5xpg5zd0s5y2vw60D0kVqreatQlKc2hsMnaenAfGvbOqn
 uFPaPWah/nn1iztJEwFifTDqPJT5zSnpf6LPbclyPY9yckJdFQ4eNMONT7vAhaVjyCoE
 wgpwDNBHP2kP2d6ZAZd4vI049+Eg1ScLd1hXiZJPQbO4c6bIbBmybP34TNNmXnJZ7PXd
 jMP0rFHTK8xthDE5RfN2tbiHV0YNgNLbrzoTtkPvS02fsXpTlF9TDAiuawAXQ+g+bFa5
 2yIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772804190; x=1773408990; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HCQLd+EiglPdY8lR++J1vWDeZLDuOmfJaUc4kL430Hs=;
 b=Po3taHwgFmdFr879NBBHWdjw/8SHGYBpWC8fPrZwJU4QwPbQn2BRIUf5R9e80I8gRr
 uGLcanxdyRFGCT2QhX+JPTDX2n39asAtOI1t1FoQYDozphiWZhbCeN2xfzzODLxePNeT
 llRrVS0I0HTwz/42SUVawZip2W+uonjO4DU46WNyfhA9fKy8wTbWlyUfdu3dBmY4rew1
 mlSbR9GT6eyI+zS7eHkhX25/fkh8XsIRjw6+abAwxpdibZz0DldL6DBjfO9VmBJ7sMdJ
 zMSi58/xdkp7n9XX9Wa6vI3gUaQ34DWvZjDxja087LgLoW4mV5LatWnNCjfKwuEC3fKZ
 T+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772804190; x=1773408990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCQLd+EiglPdY8lR++J1vWDeZLDuOmfJaUc4kL430Hs=;
 b=tc6y9Pekz2opya7sNeWRgQcWIZhzGeQ/pII9hYCAyzpMrWb+FigIcJw9Bnsc017e/b
 tnJteGBvGvJPpT7jWdZGav7l5BKFi8iqVeqcMzckaCANYKnFrBX49DYdY2c7+I3hLH8L
 hXylW/LgPNdswW04lri4WgHxzdNleV2OLUPQKjzm8boRgxiUpGlYPT2+lkJPFk0N42Gw
 XymniUXyH7EL6HRO8LCpDS8Ca9mZKbPaUWfCrXP2icbKV+ztwLSxErYGH+h1oKeHnXle
 X4zsceKWXckR/EeRZL4jwFdh0JeZvDxRgyx6oSGIxTNUN6YT2l8eOS1YwtElrl/TI5SV
 Z2JA==
X-Gm-Message-State: AOJu0YzsEN2111AQVxgn4D9dh80KBa3scphHy+Ea8HmbJ6hqpT6/PgAX
 fnAMDFVfEKdQFaQhcBgeUjOjQZTMXXGkF9+lzNFQSeE6QS4wc33O54B3xLaJ0oQ31052xbCDvqz
 UJuq0KMgif+0v52NlRgudJXnWiYAFuXnm07f+FTYuwgoZNw8M+cmr
X-Gm-Gg: ATEYQzwDlPi34fSvXef+4FrXwQFM+FD7etNV81oCxeCoObrUK0IpXi/HvNFWe/8rj8r
 c8GE//YzT4Z7fwgYaDIis65Ts8WehKqms896DMfyV9UaTs0dvWxpFwfI4olrCU3QXAO8lrrAnaf
 6D50+DsMyOUqq0vVKJLl61OdFPD3sTzP3tivYLVTRoi/X8vFimVBhzMb3riojGYCMubzhaijydZ
 YwpAW4jkBfqF5YyCE6f7CpRDKU0/gRA5WY8Cjkk4iwR42AZaLoSPecG5SAdPhROUW1bG+fLCASU
 YXW2dM4ojhH8nf/OgUlOGUkOMf7LpW1sOz4Hgh2tAmaAovu+6SV06/l9uwsywZlMTxw=
X-Received: by 2002:a05:690c:6d83:b0:794:ede8:16c with SMTP id
 00721157ae682-798dd7d07d5mr18565807b3.60.1772804189543; Fri, 06 Mar 2026
 05:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <20260306130107.35359-17-mohamed@unpredictable.fr>
 <CAFEAcA-bh0s0mkUEsunwDRAjRsCDJaJkzHToUg77e-6X=ejbyw@mail.gmail.com>
 <38911692-67DC-4212-AF8B-E647F488390D@unpredictable.fr>
In-Reply-To: <38911692-67DC-4212-AF8B-E647F488390D@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 13:36:17 +0000
X-Gm-Features: AaiRm52CPQ59ijZV9yxcu93XNoafMzYAV-is9X3aSFUE-_yXXGf0SGtosf0SR3w
Message-ID: <CAFEAcA_dzEjy8knHkARmAhCqc1rRxAK8S5ptaj3kzu54rT=x0A@mail.gmail.com>
Subject: Re: [PATCH v15 16/17] hvf: arm: disable SME when nested virt is active
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 6 Mar 2026 at 13:34, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
>
>
> > On 6. Mar 2026, at 14:32, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 6 Mar 2026 at 13:02, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> >>
> >> Currently, Apple doesn't support the nested virtualisation + SME combination.
> >>
> >> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> >> ---
> >> target/arm/hvf/hvf.c | 3 +++
> >> target/arm/hvf_arm.h | 5 +++++
> >> 2 files changed, 8 insertions(+)
> >>
> >> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> >> index 0183dd8a60..61ba5acce4 100644
> >> --- a/target/arm/hvf/hvf.c
> >> +++ b/target/arm/hvf/hvf.c
> >> @@ -1181,6 +1181,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> >>
> >>     if (hvf_nested_virt_enabled()) {
> >>         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
> >> +        /* SME is not implemented with nested virt on the Apple side */
> >> +        SET_IDREG(&host_isar, ID_AA64PFR1,
> >> +              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);
> >
> > This is
> >  FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
> >
> > isn't it?
> >
> Hi,
>
> That's an equivalent sequence indeed. Should I respin for this?

No, I'll fix it locally.

thanks
-- PMM

