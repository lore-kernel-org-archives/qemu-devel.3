Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD349E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRi-00066Y-I9; Fri, 06 Dec 2024 07:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRO-0005xt-Vw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:15 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRK-00042r-2C
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:14 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-7fd10cd5b1aso1474796a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488088; x=1734092888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxafhFvYtf9jVszuSh+7ZDIex2hyUu5Kz37u7+ddEIU=;
 b=gKwc0Vn9hQRZLk6xeq/wU3gufiyejGsFufTyiTlU+W7k0YdR/GeHE4Zx52wSpgr8Sb
 P97phAt7BxEHe8uiGC+BLKLAsQExS4v1iP9Dn7NmTvz45IMmbBOwUSW7SdQusifSojKp
 pDFxm0GcCsfpanwTsVprILM98U3GdlriBMn43xtKlWkbKN2XVWiHfoR5lx4lwt3pP/Sy
 mFFfzwXtRrMmDoNa1PGPgD+Sx+kQDIweUCG+3d/z4IS+jG4yEIkvGI95vuSO7BkXhhsy
 tTXnJApPLe5DWZ0m5ECSewaL5Bzyv5ZQ6CjSQIH9SgdiswD6d03TfdZHlP1pgStmdLwv
 G5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488088; x=1734092888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxafhFvYtf9jVszuSh+7ZDIex2hyUu5Kz37u7+ddEIU=;
 b=niX4i05++tAH76OGg4tD/QI+rtSSAV00EjkaVYrK0ZlxhYruK9zo86W/FN3LqtxLTK
 1UhvGxuVHY5MumHSupK6jUGH7/eFQZrWPUkSrQNKGlApuHJ8yq7pmPmBo9LSe1MBaMCS
 qj5f8HqRX8VGM8DVvtGmDPhPU4PdEOHk9GGVJtIdHZlElp83K4LXaoN5aFjLxKhnv3xc
 z3AWiprD3H+C03D1gmzxAxjmT4XQhTDMgOL93Rqt52NTOrCR+d6pJ2TJRwCg9DpxrT3X
 91s0nRxt/c/V4tWQ0LP8n3TexHAU+Z7YzbkfrnpFxQAD7DBNjnO3iQB511f6PecQGxmD
 xIjw==
X-Gm-Message-State: AOJu0YyZjSjR9LMrWA0dCuhVA5y1uf6v2WX3G8+nq5PubclC2ZS3zVJb
 Ol/d7EZSuGzo/SU4hJ5tB22Y07HyuoBKl/w41Uyrpvynbjs6STo0fc4j03a/Lw==
X-Gm-Gg: ASbGncuDVG6pW60WZgYW1AIz7yRoStLXDbxM61C/RLMPRBlfVTu2on735+B7gKEv9DT
 wguHqACdbQ2kGKRKpGA1lVbtTMJCMkYi6l5nVSXvf1HmPv3EUfxI73qlUA5akbzVKCRT2Q4i6Vc
 +ot4ZuH5WpFMS2ME2xigB94TqW/taofUAQwIBghnUXq2mEKxn++ntAQhZ74F3RV76i0tA6QBMNT
 2V49EbW60FShMFv5DWGgXVkt7tERoWRWU6MM7FdCboR2ivULwNI4tbKiQ==
X-Google-Smtp-Source: AGHT+IFboRv/tvwJGafGbOiwKYEloWs5nD03RcrHhJJsi8BS7hfjcv/Pgu3dXM1wG0lkDiuTFfuaPQ==
X-Received: by 2002:a05:6a20:8408:b0:1db:daab:2ae7 with SMTP id
 adf61e73a8af0-1e1870c44c9mr4568666637.19.1733488087947; 
 Fri, 06 Dec 2024 04:28:07 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:28:07 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 05/10] vfio/igd: add Gemini Lake and Comet Lake device ids
Date: Fri,  6 Dec 2024 20:27:43 +0800
Message-ID: <20241206122749.9893-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x544.google.com
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

Both Gemini Lake and Comet Lake are gen 9 devices. Many user reports
on internet shows legacy mode of igd passthrough works as qemu treats
them as gen 8 devices by default before e433f208973f ("vfio/igd:
return an invalid generation for unknown devices").

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e231865d72..ed236f443a 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -81,8 +81,10 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x2200:    /* Cherryview */
         return 8;
     case 0x1900:    /* Skylake */
+    case 0x3100:    /* Gemini Lake */
     case 0x5900:    /* Kaby Lake */
     case 0x3e00:    /* Coffee Lake */
+    case 0x9B00:    /* Comet Lake */
         return 9;
     case 0x4500:    /* Elkhart Lake */
         return 11;
-- 
2.45.2


