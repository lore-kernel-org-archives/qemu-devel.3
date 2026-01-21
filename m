Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C388C4451E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWUq-0005qP-FF; Wed, 21 Jan 2026 06:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWUa-0005jy-Bp
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:35:20 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWUV-0001az-4r
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:35:16 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7927541abfaso62392597b3.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 03:35:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768995314; cv=none;
 d=google.com; s=arc-20240605;
 b=F+EsqCockLvFF3zFFQnVsd96ndfv3T1J2EUIv7dzshdzb/woaS0ysvc1iyFcosqStX
 +2trn/LjsX7FHhIWuR2iFCx1YX2E0+sRHr8qqjbdL2ZIqXjo9YFp3SXCfwF11IZNuy+Y
 0TvAeX0+b6VyhUwvfNqIx5ZMFApabwue2hST3rhoJss8kKRYbP+xuqq7dprX/ODz0cZp
 ocwUDfFBqocGvspV3iHXodaGboFk/qrWorcjRTe6ZLPoCQfc5wMnREhkaswhOHAkqWyy
 CQBCK8AyYaVTL618/oQYZeLwPqiJdxUTHPL0Rh3+yXYewWsvztGwNB2tVbYd6HidqWtZ
 zrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sOy3FU1FVyZOzKUYawtQthgZ1eqLYED3LxtlLUFq+ww=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=X5rwt4/PjbeimFT2cEbhoRxfxnaQXdC2tRJfs9UuSMWxfIN70uQXIc+AirEP6tANJN
 +DdX1dvC84l3688gRkIrEp6YT2xOQptRXf6biBFw5A3T2osG58kYJe2WdOzeCdbS0+Vi
 zbDQrHOBLxE1krNiwW1C+RKpdGBDmdlrng6x81TK6ISSuG4cmhysIRmrrR+T1xmjiD4m
 YiWexaRZB/eVtXUM/3CmsHz+IcW7u/+32DhyGrOpzxxK1gX6HMt/Z4ojZ3+zIJrvQnyu
 Azf0jZseBt4wSKq3tn2Ue/pceI9s42myldkJdZGpeQ3ALGE94IBqpEMBeWbiIeTLkO1u
 uZPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768995314; x=1769600114; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOy3FU1FVyZOzKUYawtQthgZ1eqLYED3LxtlLUFq+ww=;
 b=xD+kV0AtYErz55avvTKl8krwMdAuEIh4upm4oyQB2wNJ+cervtIfG8tnEj2q+Z6yxK
 PcLSA87M4PsJgA4oX5jaO8qz38I5DjzBZGWn5YElytq3xzIZxf8b4LF8Yut/8xnfNOEZ
 EOfvCnt/QKSw5aPSvCq/jDLgIm6QoadkaPfmvVi86KNk1Q62AVr0Ui5DVpSDVLxAImfV
 RNGpw1NdMWzAnfEe/Z9yJ97xD//G8pqs715Lszz0Maq9DyrnfDg4kyCPb/qC+wsdQw1e
 VVnlEuuIFwJev3XlkgUnk/PlD52MLrZWPT+fsx891GO7pGHjx0iYdxxWtkdRUYNehjlN
 zOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768995314; x=1769600114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOy3FU1FVyZOzKUYawtQthgZ1eqLYED3LxtlLUFq+ww=;
 b=OGAO8/0BABKgH4F/67kPZhi6wSZjlK5XJUY3OZgi62MFaOqUm0uk+3Ua+iYPUuSspn
 lKOrYm2pE5JelWyeTDjkcxmcBxkW+vs2kjUtuY3qk2woeZOsBitKzqpX/3Wek5InZndX
 z9fypW94wqSVvxWTMKy9n7Cne6f179IP/uUZIypT9BP4CDxFLUvdq7budiE11iXUy9hd
 RSy/ZT8ta+NkLkjPir8lOGrhlAtunPx73nNsDBG0XJX4S3Qxb/rPtGB3CA+O+MVu7nLB
 rOXfPlUC7g9SvYjyXCE8M78zOZ49YEdxSLofbjioBEFpTg8oIIlV5Rh7Wsg+tchMOci8
 FtpA==
X-Gm-Message-State: AOJu0YyKG96b3wSaxCp3oFP9n6JLk3xm7CKLn4iZhfBc0KU3QXbtWV7H
 vXZBXpcevrW7m1vcTQbnQ5mttPq2e4Pful8rX67DDOOTMIxFvzw2mvr/ccObM4J4s1/0B3W5Cwc
 HO3YrYbRnn94s1vVvhuUwCG8wq3fMLWzYgc5VPicJsmgR/Y0pdIL+
X-Gm-Gg: AZuq6aKMvCkKefgk4+e5phlKTJbrPQmrfR89xLY2xs5cBXcIZhQZ1aMbW2hoRiNcogf
 jXHSpH9sCzFDK/X/MxePINvILzIMOB/AL230H93v8p0obPDXcT13E4xtkic5aDndqSHEsa8MOzZ
 ixj/oHc77XusmTAW6+ztCe/PEhou5JeI2AXvCVRp4NUs8HljaqYm0YniVfdCcLyi/liimQNvufk
 7qvD9Fa1ixdXqI6SnsM8AzDsYiZzTIWgcMMo7nNJtNhLUmka6dd6ipU3gL+axPo93Z36g==
X-Received: by 2002:a05:690c:c4e8:b0:78c:28b7:88e4 with SMTP id
 00721157ae682-7940a4b09c7mr38618837b3.69.1768995313694; Wed, 21 Jan 2026
 03:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20260121105932.135676-1-alex.bennee@linaro.org>
 <20260121105932.135676-2-alex.bennee@linaro.org>
In-Reply-To: <20260121105932.135676-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 11:35:01 +0000
X-Gm-Features: AZwV_Qjqb5_4XxhvuTEpTBmwvOV-e9CscKoPP3byuMJGy98n3s8Vm9O7TJ6jtto
Message-ID: <CAFEAcA_NAGoWi2Vra6nVEwQ-+FnrD++eoZQ=QnqVp=nxj3w_uQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/intc: declare NVIC regions as little endian
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 21 Jan 2026 at 10:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The NVIC should always be a little-endian device as big-endian
> behaviour is a function of the current CPU configuration not the
> system as a whole. Indeed the Armv8-M architecture reference manual
> declares:
>
>   All accesses to the Private Peripheral Bus (PPB) are always
>   little-endian, which means that the PE assumes a little-endian
>   arrangement of the PPB registers.
>
> This should have no functional effect as the NVIC cannot be
> instantiated on a BE system but will help the single binary efforts.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

