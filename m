Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931DDCAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Vcg-0006gK-FY; Wed, 24 Sep 2025 15:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v1Vcc-0006eZ-NO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:57:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v1VcV-0006jr-0J
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:57:50 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b2ef8e00becso45860666b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758743856; x=1759348656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gL14da6UiQA/uERa89c8BvRT+tCpiieLyUNiNSLpULw=;
 b=cGHSqmIBexNtNj/BKrWiOHRVEsU4Bh9ypO4ns+2gTrPvN1m1bZd8P+Km9RN+fGuAN/
 847aCQTAtcqu+k/58UV6rA2GGDD/Snwx6wQXspPnFFA8YYVuEzvso0XNcBMENdidCruz
 r76Bf7xWXW1taRZ1fsN5N41ouC/T7U86xhvTYcClxoY8km+akJxJDg0Zit7LX93G7Xpe
 fQI5254LVJdA+6uCJoZId7OUsuW+VRX1zFawCeHyBLsxQuIXXYF7VWt7qUWU8R5qIbEI
 GPxL4SKYzpddff/EeIPH4R70V+C4qdGDvpvpG8yAQdxdoUSrFxrgI0QEWNdLHHdQLv+/
 u+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758743856; x=1759348656;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gL14da6UiQA/uERa89c8BvRT+tCpiieLyUNiNSLpULw=;
 b=uUWAsZTwmVwlXj6d7pxAuRztbUD+7MLfdVDy3F1u5u2CMEUJRMyMmGLGjVehII5lac
 u2YHqYgCRP0lcmdkCJOcmcyuV47vRI268vWDPhvXyM4oQUw/f5I1LtrsmF0+bYY5QFX5
 Gf7/RrZLwLo17d2W7CbYO9BSfaanuO9nq/BzIBxnXYkhb6X4F6kGGHIaNyrzpkjsUQLq
 xcAwKAZG2lbPjK77KiqXljz0lYl+vZkzfUmrx2NDgYN2z/2Z4lPO+mTot62lPHR0D2ib
 WI0+5E7sYXU7vF2uGvbWrZIoXyQg19p2btrwxvKMcvA5r/Zd5UD6ORC9wmEIK6ng8Rb/
 tzAQ==
X-Gm-Message-State: AOJu0Yy/kUS3U6Hc+vrezVIQ2RendCV0R2gJJ4z3xh0FPJAl7ApBebgj
 eHG/TO3ZnT88sSMwlL80stQl6rUiaX5dhVA9cahaqUL3+cS3dyRp6JiWH5vchA==
X-Gm-Gg: ASbGnctYHOPKIDjPGsL4GaIEw9M7/a7+aNg8OEQQpDyN2KHcNWNP6M0hs/Gx8HJxTLQ
 TaNqHNIzzmlhqjKcG3yZ7yPnb2EKtHOWeaoPY+nMuYD2UjWcxBbujL/oIwUy+w7edzYqzaaOYDP
 cupGmKDGebnzfFp/hPEL5kD+MM/euChtfZuaxX+gNz7wKG+8TrELLhimoNGrly5LhEJXwfBdi5I
 JhUD+T4L7I96gVS6SrQd5UjobNXYV3JB0siO9w661hJRBO445O7+jIkjuUxcEdYEHaULlgnnHHp
 QWJWTRUAI1Y2QDSo/DCXbNQ1nlCFOLB4HK632eQhXtsq7+0xla79L5PzhbZWTRcLJByKHTdiWkF
 vXvH+Z93ab41ZuYIToBBAzlTlUwFFT1pBO5MDn3pqVkYoFNKKhoa8sF62516GAeofeOQgbYdKtA
 0iNhiDvOFYFoDSncO46E0gNGRSRufyjVaOWF23+rpT6w==
X-Google-Smtp-Source: AGHT+IHUFbA4lrWjcs/8SljtrXJEAatU1tsneAqmPcbE4fih7hKTXF4Ex/YpSkm1K9AP7xNWYuaCig==
X-Received: by 2002:a17:907:961f:b0:b04:c7c5:499d with SMTP id
 a640c23a62f3a-b34be7cef09mr95314566b.47.1758743855572; 
 Wed, 24 Sep 2025 12:57:35 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1a12-a700-a1dd-76f5-08d7-5513.310.pool.telefonica.de.
 [2a02:3100:1a12:a700:a1dd:76f5:8d7:5513])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353f87511dsm6697966b.43.2025.09.24.12.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 12:57:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 18:24:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] hw/mips/fuloong2e: Fix vt82c686b idsel
In-Reply-To: <20250914185526.3622-1-shentey@gmail.com>
References: <20250914185526.3622-1-shentey@gmail.com>
Message-ID: <343E706B-61FE-4939-ADEB-03B8C0189764@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 14=2E September 2025 18:55:26 UTC schrieb Bernhard Beschow <shentey@gma=
il=2Ecom>:
>PMON 2000 accesses the vt82c686b southbridge under device 17, not 5=2E
>Fix the FULOONG2E_VIA_SLOT define to reflect this=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>--
>
>Makes PMON 2000 work in combination with
>https://lore=2Ekernel=2Eorg/qemu-devel/20250508-bonito-v1-0-4f9f27733028@=
flygoat=2Ecom/
>`qemu-system-mips64el -M fuloong2e -bios pmon-2edev=2Ebin`=2E

Ping

>---
> hw/mips/fuloong2e=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/mips/fuloong2e=2Ec b/hw/mips/fuloong2e=2Ec
>index 2a8507b8b0=2E=2Ea6bf524b56 100644
>--- a/hw/mips/fuloong2e=2Ec
>+++ b/hw/mips/fuloong2e=2Ec
>@@ -59,7 +59,7 @@
> #define FULOONG_BIOSNAME "pmon_2e=2Ebin"
>=20
> /* PCI SLOT in Fuloong 2e */
>-#define FULOONG2E_VIA_SLOT        5
>+#define FULOONG2E_VIA_SLOT        17
> #define FULOONG2E_ATI_SLOT        6
> #define FULOONG2E_RTL8139_SLOT    7
>=20

