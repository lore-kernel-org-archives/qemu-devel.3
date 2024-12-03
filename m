Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88836E64AA4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT4k-00083G-7R; Tue, 03 Dec 2024 08:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4h-00082L-BC
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:23 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tIT4f-0001Gw-88
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:36:23 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-215bb7bb9f9so6991585ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232979; x=1733837779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/DuqT4YM84gPF3le/nSWMQOdJuCxA3rOOpHfejjt74=;
 b=T7iwGGkfaKp8RMbnWljRK6Ye3xJ3I4l41FrPc1SyDyfbAMl6Nb34ny08nmW0c4fAcj
 2hBPvKdckFiH9dc5gjnrgmKQ2zLEldEPLHfTpDwyrezT71KIO0WjBBR59R1OfsLi9GID
 8emkWnQe4B8YPXV1YsarKCLTsbzY1p4fIOlJxkO9tYlJngjHWw014GnGFDJWF1Rm3V/A
 C36DF8DrWNJaLSQFc6Y4ot49XySpX9twGYlpGperGAgEFOUf2QMOjU/78W0J5kUHpkbg
 C+HaUj6z/FttHzTMKSiXQ007GtQcRQfiZxdXwqD/GcmtEmpxX930bTFXes0/0EWAx/tW
 9Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232979; x=1733837779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/DuqT4YM84gPF3le/nSWMQOdJuCxA3rOOpHfejjt74=;
 b=c+28+A5CJtR5+jlejw2z2lF36YODtJWJNKesG7kGdREBxCRadGY+x/iOdxcK7kV7N8
 +Vlvtjzrd05mN/CyQcoigqBO8KBSIST4neCmWx/gEM+gp5rmHzAZEwbUkDlPzyshO6f6
 YuAZzor7TC7B6hrTpW64Nk0SzfQKMF+qDdapx3vIKgHqhfxBoo6x/scn8wG9i+aJWXZh
 +3NLlRUZAHFjQ/hiycegTWGMybixhVYreqevQ7RQOCwrS3ogEkYeJpIHp1zHegy9BFgj
 RC/oeyteuHWLYOs3pjDDuX6tKfVoq6WhnZtA6C75i685I68pG2MVtmr3lUAPdfypRe9b
 qHXg==
X-Gm-Message-State: AOJu0YztJYLwYyC0qz9pBXXaxJZORdUef3yjESq/UP/uqwuwwwHgu7fe
 xbRWUrEOkzlKoTTvIJxymwoCuAXKp3xR30LZCokKvoEEOYK1itrKhNhgR5wAzQ==
X-Gm-Gg: ASbGncvuaPocsJ+ZcW5Upf4zwB+h/WhCmgfOIH/MzPrxZYuFIRs9paa1Y700T9JPOx5
 yplsEZ43ZIvrQ7/XRVSUIOrRcjn/T+yLP6HLjJr/yx7xaUzGKBVjxDTAa4CvGtXD3Mcavd/EzvE
 Rp9sXToxChnKgW5AHoo4lC8o0PxVS/qqwZ4rBCLj46gle+Fg9w0lNveMtQYLxx18tlumxbyLyRp
 HGLT0r+F6lenVRhwPGZIQoSwIevZ6lO5H7DqVthvlL3G9Gk8ZoEYSbwMwg=
X-Google-Smtp-Source: AGHT+IGVFDaR012smf+bYJoWYBrsYjqrK1kIrAILHozHubIBXgZxpKPvnizC925vCzknUEKsT+0Brg==
X-Received: by 2002:a17:903:22c5:b0:215:6e28:8249 with SMTP id
 d9443c01a7336-215d00b96bamr2375185ad.45.1733232978933; 
 Tue, 03 Dec 2024 05:36:18 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215810cf18esm44183975ad.242.2024.12.03.05.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:36:18 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 5/9] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake
 device ids
Date: Tue,  3 Dec 2024 21:35:44 +0800
Message-ID: <20241203133548.38252-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203133548.38252-1-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

All gen 11 and 12 igd devices have 64 bit BDSM register at 0xC0 in its
config space, add them to the list to support igd passthrough on Alder/
Raptor/Rocket/Ice/Jasper Lake platforms.

Tested legacy mode of igd passthrough works properly on both linux and
windows guests with AlderLake-S GT1 (8086:4680).

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 7f389de7ac..fea9be0b2d 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -85,9 +85,14 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x3e00:    /* Coffee Lake */
     case 0x9B00:    /* Comet Lake */
         return 9;
+    case 0x8A00:    /* Ice Lake */
     case 0x4500:    /* Elkhart Lake */
+    case 0x4E00:    /* Jasper Lake */
         return 11;
     case 0x9A00:    /* Tiger Lake */
+    case 0x4C00:    /* Rocket Lake */
+    case 0x4600:    /* Alder Lake */
+    case 0xA700:    /* Raptor Lake */
         return 12;
     }
 
-- 
2.45.2


