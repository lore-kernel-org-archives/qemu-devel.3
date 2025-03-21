Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BE8C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVpz-0001HR-A3; Fri, 21 Mar 2025 02:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoY-0008Dr-Ha; Fri, 21 Mar 2025 02:25:11 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoS-00032e-Pn; Fri, 21 Mar 2025 02:25:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2240b4de12bso43014725ad.2; 
 Thu, 20 Mar 2025 23:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538295; x=1743143095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UI94a7Hw91whhjlIDY7N1S0ogpBosIVfhZhQbQGDvvE=;
 b=fQs0qkF0grf9EMVDffYpEU4cDMaie6lue/15Tqh8TugLVTI+gkB3e+4uIe7Zslf4L3
 OkpNQgJYnZCM8fLLfc3u2x6AyvLO3YMqAKcC6vN4mR4XN152dw2keRGIeqCtz1bYofwr
 EUUMrJ5+tnbPBt6h1qd3sv9VB1tG7gknaPF4JbvjzNhETmVtKcUTwKRTHlqpT+KI1l9q
 Yxs540FZF6bYRsQC/MWNyJR6T5CUvL2oX10LfmQW8FgmOannjirW9DvHME+UUHTG81R4
 1dBmGF35kZGRN+c0OD58U5Pxc7OCrvWHKS+lz9j/hAkb4TFu0ERRPiODCMvF5O6t9eXG
 SC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538295; x=1743143095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UI94a7Hw91whhjlIDY7N1S0ogpBosIVfhZhQbQGDvvE=;
 b=SpOzqVjtyOPFm/IFDkhn7PVQfLk8bD9NsUkOMlZQHXAyF5O+lDIpOghidMCL0EbJG0
 WBY9w9Xj0hxjXosRYHZ0aFt6fkpyZfv4KNAKE49yNVSw6OdMRLhNgZHfPwmvdwGN11aS
 llUCqj/SCA8WvuVB0Gk6xnREJQTLrl3gdvFXDmiKmM64scgQW0WOYAigM3+AJ3ZmMhFt
 ZH/coo4JEZX9WRnMoMVw5q37nsX3IOL4IciZxT5B5lrpWR/GpO1b5pLgA+cvXvrMiAOD
 p/coa78OGXGAd7/RQdHQv1Eh72pDd6ln/3KQg7qlj/wtAKjfCMmAKYxTPhUrmsMfi3lw
 jJzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/SCC7zvGoTlqPnCOz2n6dtNW3FvtZmC7C/Nk5+wTjeujtECfuZu6RCqS9VBPUMJeY5E/Ttq9F+w==@nongnu.org
X-Gm-Message-State: AOJu0Yw20Oa37b/N47YoBAQKHjeAY7zSb/dXGe9im3w+8QTONytQ/ZuL
 w3sVOeJ1s4Kduk7M56NKPmnAJPmXpHaUHpeZ9Sw/UWjEQjFgI3LCuFC1zQ==
X-Gm-Gg: ASbGncshaeG+6hjRpxifNi0I24sCrXeopwPtWGldxKTdnuUmrhTU2P2p9RBDJMv/w92
 Za2nxPQKtHEUnm0SakBaxl3eOQLlALytCaJzo3SYZyZLLiMJ6yxnCkaX50j4nacKUL9dN68BNAb
 O+E5f3k1vXhEo3vg2EFOALDoXAknVyfSt8RqDxV8jFDLwvH+0r2IoSPsw3RrUXI+jJp6DvdJoJg
 gsoABjx3/V1LBAD45C7mp9HXiCAULjQ687rfEqKspOkkxCe3cac3H7ynOGx4BUcIn4RIALUhUE5
 0T+DDzi5i/D72BVb4vSAJfr7XSlizr962F3C4InxG5aXZOE0hw==
X-Google-Smtp-Source: AGHT+IHchM7hVeW3NoHawa4F8N20+QV0J2N/cppA+T+l0672m/ck1m4M4Y8Yfta1LyitDdJBF1PNaQ==
X-Received: by 2002:a05:6a00:240a:b0:735:d89c:4b8e with SMTP id
 d2e1a72fcca58-7390593b951mr3120789b3a.5.1742538295049; 
 Thu, 20 Mar 2025 23:24:55 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/12] ppc/amigaone: Constify default_env
Date: Fri, 21 Mar 2025 16:24:13 +1000
Message-ID: <20250321062421.116129-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The variable holding default env is not supposed to be written.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250314200145.08E0F4E6067@zero.eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 5d787c3059..e9407a51b5 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -63,7 +63,7 @@ static const char dummy_fw[] = {
 #define NVRAM_ADDR 0xfd0e0000
 #define NVRAM_SIZE (4 * KiB)
 
-static char default_env[] =
+static const char default_env[] =
     "baudrate=115200\0"
     "stdout=vga\0"
     "stdin=ps2kbd\0"
-- 
2.47.1


