Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD37D44C5E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOn7-0007Ad-MN; Thu, 15 Jan 2026 09:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOn2-00078t-Kx
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:57:36 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOn0-0006Ve-JL
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:57:35 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78d6a3c3b77so23684357b3.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768489053; x=1769093853; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLju0veGxDRCaNlNCZ9kxVtqnhSLkNS5jHDofzqZdqk=;
 b=fdaebW7ep900y9P/aSxFwOEyd6lcbTaYJwm+0zdgL9vx/gEJOsa9Q8E6RqkolcgaW5
 grWPj0ojcQyXXpvsjRdbMm5sAyDMDMnJ0t5e/gD8V6MRMjCFhsMcB6HTnT/E1rhAkD8l
 pqujt13WuRz7qtMoBxujonzpnkPmINk6ZvKT039nUCGDBpU4Rx4wJiWa78bpZE3FW3BQ
 /KLfISdbjYKn1RNTNwc/oaBWOGQTAMjFDCjRnzmxJQpCnwnA4d1Zd0nB00WPGgF1+pDo
 VQAAHTBeqLXwb9t3mQ8JiY8VhwDKIL4Zd2ximlXsFC8evhV+Mo/I0VQnm94JemuMKbeG
 WG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768489053; x=1769093853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KLju0veGxDRCaNlNCZ9kxVtqnhSLkNS5jHDofzqZdqk=;
 b=mlsjAcWZuAJWB1tPG5Fu5EASoYODrlyDDjNCqv3Q4vvt7evcUOQo2Q/dbkYJ8oMOiL
 wUELuGw3elV7nUuqMSdJU32VDD/9QvfGyjtneI1jxajEFVoNvkJtW44Lf2BW64hb3zR9
 SmvRZLkjKk28azeztSfxvy+XvyIQ7lA367HKx2fEQOsSnro3kIQQ3rB4avgi/puavJX0
 e+zMRjLvCrAudfxrsvF60IG0pmv2DConH5zsmMc5hC7heGHpIsQzNpVO57FmkOgVU/H1
 laIwaRiulySFAphPZv5+qr8C4nI7RGKtRKtGkbmu2gbsPJIFIe553WGA0DRLSLUb0JN4
 V9og==
X-Gm-Message-State: AOJu0YyFBWPy1xsuz3lRkGVwDJ8V+6BTiZb/8Y11LGk3Lq4WLwWZyU2V
 l6HavlKrzDy7ZrilrO/ebRJB8rjrgd8iMIejJNhFtUbxzMBI8O3f5MbcWleXa75djhultpBFrgx
 YINeAESPUvRiu3CjdNQjl8kQtzWU9ETpg/5FoTh48kA==
X-Gm-Gg: AY/fxX630cRmgHleNoV++6V65tZ4oTSiW0MRvavV876PbBCXZQF5dtIW3Kx6NcRJM/R
 XPOWqAs9VEHQOMP/4MsZyQsoFP4goJGqRf4ihkUdqEU/DofO8Ix/qxiPoV9QR3Tf/B+lchJrrb9
 yA7+XjrmV7aYTgEY4oDI2+RELFC5pQckAOnj+6FmxRWzYnanfBDEYEfDBrFRwu3s0H187fGYkcf
 A8YGDtIMo6n8c1n2j3nhbPHs8WXfI2D8t1HcZ6doQTg13oWdkTLBh2YrlnhLOeS2aaQ6hzZYsCB
 7BSZWWMV7GKFVDqMJxN3XpY=
X-Received: by 2002:a05:690e:16a0:b0:644:4431:5742 with SMTP id
 956f58d0204a3-6490a634d1bmr2335112d50.23.1768489053206; Thu, 15 Jan 2026
 06:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
 <20251204093502.50582-14-corvin.koehne@gmail.com>
In-Reply-To: <20251204093502.50582-14-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 14:57:21 +0000
X-Gm-Features: AZwV_QgipE8e9I0ddnG3h3pWcNpLvGxV7Tm9kKn0Nff5rlgV4Un4-Vn-kGgd7fk
Message-ID: <CAFEAcA9w2r4Od5o3BqU=Q_SHTshb1_gHB8oG0aj9spF1Z7tMGQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] hw/arm/xilinx_zynq: Add flash-type property
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>
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

On Thu, 4 Dec 2025 at 09:35, Corvin K=C3=B6hne <corvin.koehne@gmail.com> wr=
ote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Read flash-type value as machine property and set the flash type
> accordingly.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

Machine properties are user-facing : this one seems to let
the user specify any random device name with no error checking
which it will then try to instantiate. I think it would be
better to have the base class code know via some other
mechanism what kind of flash device it should create.

One approach would be to have suitable information in the
machine class struct, which is filled in by the class
init function. You can see this in hw/arm/raspi.c, for
instance, where we set a board_rev field that then the
code creating the board can look at.

thanks
-- PMM

