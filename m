Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F10D61017
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSJ0-000267-4j; Thu, 29 Jan 2026 08:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSIy-00024Y-CJ
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:43:28 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSIx-0007Ht-0T
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:43:28 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-794265fb73bso9905927b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:43:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769694206; cv=none;
 d=google.com; s=arc-20240605;
 b=YOXw0/uX4FUkqznOZYaOzIKQpmSQzi+/49aWHIfyk5jaOGIeROrf3urRjHqxwd7kch
 4XeSVviCSoRqN6P0krEHKe9lMHicCT7Z6sXA/hVrkWcvjp0CXXS3RfZ1DmiY1uahs4Dw
 klxevI1pjm4IaqSH0POwwAdgvlHeHUzHv0kBBz3xrFmoLo3JbK74P50NtNBvVE8yzb35
 Ca4sENLSpCsqYuRnXXKbwz0o49RWBC88p7PbiTid9GS+23T4sKekkRrLr7Rn1y+40oJb
 ymXMDNecuj9x9aCnJfYO2mHbnMX41hQ0VZh8arCVsJlhJT9BuifUtRaXWD0YHYUcJ9bz
 9OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Md5I0aTcr8F50pYxJ+1sHfeFLLBh1p3/a3B1F764Nws=;
 fh=xY81o1QTnI2XKDfOt2g2HcXUXRE4KU2wXXSPt0G4hU4=;
 b=hlGJ6AWqHLD3iyhKu+t8XQNv6+4tozQJg81vMsyEFtWBHlPoj3TcDkTe0/la0IzZFn
 +nmgulk9xpNsWC1+FwWUeL4G15Ws79MvFcQ11rQBwg+TFCqLYrRpisrCx5wvTcRfSm5H
 AipTxgvQp4DGRggM9XR1qEy9Q+MPC71h6VAob60a+7LEw6g+wYDwv9zObjxhQ4NIU+w9
 QyoMLpLiuLNJMogx0N8Fo0u+suwp0rFoG4QuT8LKkNieSQYElpMNQTupRFkVBjjdMu0e
 L+JsOpF306KohH7pgBtg11GWfuzMSAK0eOgbakOmroYrWMWZLTpxUJB6GxH0gVee5/Ez
 5sew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769694206; x=1770299006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Md5I0aTcr8F50pYxJ+1sHfeFLLBh1p3/a3B1F764Nws=;
 b=O8mNBPcvMsZh6JFXp4VEsEmcKt0/8pv3tI/ZCqE+vEONAhKdS+5+AYV9AzkvuVnJSx
 AvRdoAH66L1NIPrcQRqzvFGRDL6U8q03Yc+xfL1cmfROLDGZNTbimjpK3RezdTOBmg1N
 zViMQ20t3LGJnnfsTJdv2uk8BsWZI2yTGTV566d1ud5sRcbCLzAmuX2+CxYG34j5xt+6
 W4A1sPsBcmvpmic5+JvEMIw4rGAiCTELSmHyrBKa9UfkEQ/pSXCloXm2ESS0NLtlNgI1
 sxlpJu5YA8Ax7mBHZPVHFEnFC+2jLOYxTu4aUnm84FSBmK67cVte7WMF9sWdVmJWWlXe
 9LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769694206; x=1770299006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Md5I0aTcr8F50pYxJ+1sHfeFLLBh1p3/a3B1F764Nws=;
 b=ZvFn0PRiXL0Xh2rWsMJmlQCEeHRn5zJAgDFy9N29MaCkniszYO81TLftEuaDkSk6wc
 Enp+vbtRU9x6+cyZhyfzOwHMcOu1khNmIQwhsNPfwtPP8g7KFa4wX8aaq3G2zapqLjKZ
 XAEd2WdfD4wCG98qYc2L6lC/yqx0xBGlO0YGWWFBBbnoi852Y+0VacdgYSXOf7mI04Pb
 pF536mO6zlYaMST+fh7d91HI181hjfRCNk08HatuNO+fi3SkmiAPwk5WiahVtLQ3XPqM
 8CLzKTjDRq5/Klhak7ckAG8ZZPZVvWW91rUZRL6MSL536DM7N4l4GT55TZCoW7KlxoHO
 J9bg==
X-Gm-Message-State: AOJu0Yw+0Ck9fGfiQD40B0paEvRx7XXTO8yQBReI9u7nMiOjpA7HtH6g
 ndNvZ6o5ZE7dywqIpP2D4ofFCmB9cafYHmWNkkPRi/iKZeo8H2EGTwkcm0nE3VQn0HdafH9C59b
 ZC1oqUt+gbMlKiExM6v1dgVcYZSy1FpPwcn8qX0BwoVhaPN8+xDYQ
X-Gm-Gg: AZuq6aI+Ab87j2i1lLKpbDpwBgQI3jgeuid5oJtQMdLhFQj7hjG4NBnBexIzbnMePtk
 Q6xrrqHK1rAo9TmxDO9sZBQjAl+nQRYu7rFfHC0WDFZVXr8y10gO8jVgYPk59ZyydKdl5Ku5C+8
 Z1gLsnpL5gvUQgt7X6yJc0RjjaKEXCpJ/TSW6w25VbWt8qmhY/BDf9fogJ75+KfG2qHbg9NhXQD
 pVEr5jmFvduANuq+QmL2DSKSmwwEWJrczd5kDpW/NJcNh6+yA7G7RGP5wSFU23Tvd14BQ==
X-Received: by 2002:a05:690c:7012:b0:794:9317:bab3 with SMTP id
 00721157ae682-7949317c252mr19544167b3.24.1769694205783; Thu, 29 Jan 2026
 05:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20260127145555.3070590-1-alex.bennee@linaro.org>
In-Reply-To: <20260127145555.3070590-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 13:43:13 +0000
X-Gm-Features: AZwV_Qj_GycrwoEsgUt82Vrywgqw7oiDY_fsiSdoHVB4hW0K6PxbgqIfhbl4eiU
Message-ID: <CAFEAcA8Uw1BEcrg-UzEMxT5-9bQWQUrUQXgb-khaW9jV0afeyw@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: update FEAT_BBML[12] references
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 27 Jan 2026 at 14:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It looks like the features were renamed to include the levels at some
> point. To make it easier to match features up to the Arm ARM update to
> use the full name.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---



Applied to target-arm.next, thanks.

-- PMM

