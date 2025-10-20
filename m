Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6393CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqTN-0000Mg-VC; Mon, 20 Oct 2025 10:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqTL-0000M6-DC
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:02:51 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqTI-00068L-9R
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:02:51 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78488cdc20aso23241147b3.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760968966; x=1761573766; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6oefEeElhYPYPCx1qUppDDmR2fZgIlurlDig6wAbh7M=;
 b=x+NXrDa1TF6xQUWnPSSeBPMnOFatQexBPVsINco+01w/xqqaJW9w34+SOIgrqtKpFm
 c573Y9k8rgCRRdFf1sbDkB0THifORVvzqzOehmI2ba3s3DlE0BjfAUdMTG6svyccGGHQ
 AH4lENU4CsjXqfXtIb2ZAoSKVvBXMYieQ5pAlwHh8aC/0QsZW7yWOuRFUiWTcn2r8kp0
 0uGAiLK+xfrSkOxtAYbmz3BwPRAHQj/QMdOSPz0moZl+TxhHUAhKeUKWCkA+v13X5ZQT
 2+y/8Qym22ilmFPJum16uGKKDPmgcd4rvFBbx2bhBQ57ZYFXHqgHV4RkkLLKKpGysLrL
 ootA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760968966; x=1761573766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oefEeElhYPYPCx1qUppDDmR2fZgIlurlDig6wAbh7M=;
 b=YGzxlymgAcDoonkVFQMkD97XYb5BWDijyqd0XNIgaNnztJTxaM3iZOVoQ47j1KcCI2
 /5nxPF597zgaOHVxyXX8mib+bmI1USaQxIhrEVv61g1B2DYPjcHn4kQ+t1joS7D2GYn4
 Y/kYCP1AITJCVAMW9PxwXEbxtRdZjh7dH22vT03ThqLOZosJJ7Cvjj8lOkThzGBElgSV
 mnkyvRHEQMXFF6aKBFVSCfxgF9UpZyOWF/0RW1Hv0IYapxVYR8AY0tgmd24Fc7x2Zc9T
 B/nvYBmoLIjJprXH7AWycGhxk1B9MBXfhwm0An2urroNFmfUITrF/ywsrp3FRaD41VlN
 IT3w==
X-Gm-Message-State: AOJu0YzcmswJU3mP3i5yvlHoUk5ekWroEEQzEfDcMyjgOPcNoQ12FHWU
 q68vrMONyW306E6eH0qVmFBgpAloyzfryg2zLKvUn7cYq7NRaU3i9wRDhqFssx9JT/mTZSZUCVN
 w/fedROWjGXSnIlpkdz/8H0rTjGc1+fGSda7pOuwdnw==
X-Gm-Gg: ASbGnctznIu729JdZDaYMLNFStyGwCGQk02xBrw2fNkNeTWSpVz1S0XQyygG1w6XHWh
 yqSHYAquxpjTOYnzmky4ydC4KdHyKTUowbAyB/TtweCRZmmFI1yuu8h5NKLqdTKlCDvkvCZgzpv
 e2GbeC9oAM9dD6hkLh5mfWEKxKVu7bu8RBk5BOJ6HVUymRX+5Qurg7UpNiEkS8ejaK3OYUjxLNW
 d+Z7xp5Qk0CACY3DcCFIrxy87U2natF2ZlswdhiTByY1U/EQBC1pbQyc3hH5xznNUuuQNHzQqxC
 Y/Oz5Mc=
X-Google-Smtp-Source: AGHT+IHyR71RpTTAZYNB+rqqkildeyPeFQBbf7p05glcaf1EnasO72ZD71W/Ri0nV/PyC6JQ1ZdilqoMpy4hqcQCXLs=
X-Received: by 2002:a05:690e:134f:b0:63e:4264:878b with SMTP id
 956f58d0204a3-63e42648febmr813507d50.58.1760968965760; Mon, 20 Oct 2025
 07:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-24-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:02:34 +0100
X-Gm-Features: AS18NWBYAnMgSSKYIOOzfTHtcZVH1S3l2zaPhCouSn-oVl0S9hyz1hhcGB75uxA
Message-ID: <CAFEAcA9MUijSfAZpcQGMw5DM2qoBstviAA2HF+aJb+L7-tsS6g@mail.gmail.com>
Subject: Re: [PATCH v2 23/37] target/arm: Split out flush_if_asid_change
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 14 Oct 2025 at 21:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

