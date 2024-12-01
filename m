Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3208D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmeq-0006Eo-C8; Sun, 01 Dec 2024 11:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWN-0004mv-SN
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:08 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWM-0000dY-Bi
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:07 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7251abe0e69so2824633b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069405; x=1733674205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlBD1U7cUQj71eYm0kE5fbgBocVbBBKTOkzCfY4ss1w=;
 b=IXT4XQIlP2MGZMKQLdCp+5Thlhvkd/rUiWnyVLGWjiFGipsiPw2nBxQwu5Z9cKD5c2
 9gLtSc3psC8nHRfVdMSoHI768RYmO4ucSWosEbGuKEX/FBaE+egcqs4H9Rtt3r0wUnOl
 8zvX/3Gz1Qt5OAnO3Kfa+MTw8vAWhhXXmLaTkU5mJyc9Q1vd+MHzLtyf4ShNsqlcE++Q
 tnSx+LZLjboGm8oDlzIg8oKVzLeOTfcv6c9LqrN5/VMzfgwb4Oa3lf91mb4qjAhMWtGk
 v9Xeav75emx83x/urikVXIfaca5CaZ3H0qgKLMONLE2WqgZzfZKcfX5DNEEQV8mtpR4f
 DSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069405; x=1733674205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlBD1U7cUQj71eYm0kE5fbgBocVbBBKTOkzCfY4ss1w=;
 b=IXXL4ef9mpDhizouZTqi4y3HqgmAypTvgwYe1NJw48nW4ZRBIMTtDJkh9niatUjx3a
 9oeZLqMVJ6v1KPcCISAd/OyzoCYJkDG1WrfLsKHCeVb3NWt47uEa3YX+dqwsfx6++10O
 cy8AbTw2ygBkMuTBYImSa4Gk43h4jF5FseYkJykT6zNv3ORqBwb63tKDa3s7Z9y7uGM1
 3b9JQCGSkgjK2h99mjBXECBW9zAY/y5NMymOhKQm/Y3QXdPcAq3Egieh3PI8vzQf0mNS
 Zf3dllmII2NlKusUpDB+s48mlfc7Cqpzq66zbxH0HaWTdjJIEpTIhAuj1PEoxpa2/YH2
 NNdA==
X-Gm-Message-State: AOJu0YwQIh93jHYg5Og3vBao1uHG58bd/XlMbfcU5NtS0Rfk8i1AGVCj
 mHZsnhvFkGrwPvwPL687x1yxPPgYxPP/UCrNFEjJXga28WWrM5d6YbGLZzj0lTa8
X-Gm-Gg: ASbGncu+1wTD6yzWti5vWkwTY0jnaCHAk6LRx3Iqy3992UbKTwitzPXzSz5X1eEmo5e
 3UESN0p9e9Dq4/kIw9uMqdoSRmbIJr3rHuj55pjDwC/8WESC9vXhsg9Z160nlZ7rFpvArB+WpEJ
 1kVX26hjG4Lhhkk7k3TwgaXCRxyvBp9ddvgNbxkd/5TP2/OHzMKE/+4fc56MDcXtXHpr9QneZWC
 3LDxkTD/3WXfAZpBaQhV7uy4KT54WDvB/JBs5ydN63s7my/w5p0yTJjAH4=
X-Google-Smtp-Source: AGHT+IGb6KG4NU8D2Ap5+OW0Lyh8BWbVFNqbq9HG7fWHXuoCwdD5t0R9yzqZachLOz1TpvjAPO0l7A==
X-Received: by 2002:a05:6a00:b55:b0:71e:5950:97d2 with SMTP id
 d2e1a72fcca58-7253014343fmr26853070b3a.17.1733069404708; 
 Sun, 01 Dec 2024 08:10:04 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:10:04 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 8/8] vfio/igd: add x-igd-gms option back to set DSM region
 size for guest
Date: Mon,  2 Dec 2024 00:09:38 +0800
Message-ID: <20241201160938.44355-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201160938.44355-1-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:43 -0500
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

DSM region is likely to store framebuffer in Windows, a small DSM
region may cause display issues (e.g. half of the screen is black).
By default, QEMU uses host's original value, which is determined by
DVMT Pre-Allocated option in Intel FSP of host bios. Some vendors
do not expose this config item to users. In such cases, x-igd-gms
option can be used to manually set the data stolen memory size for
guest.

When DVMT Pre-Allocated option is available in host BIOS, user should
set DSM region size there instead of using x-igd-gms option.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 3fd822241d..614223123b 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -712,6 +712,23 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
+    /*
+     * Allow user to override dsm size using x-igd-gms option, in multiples of
+     * 32MiB. This option should only be used when the desired size cannot be
+     * set from DVMT Pre-Allocated option in host BIOS.
+     */
+    if (vdev->igd_gms) {
+        if (gen < 8 && vdev->igd_gms <= 0x10) {
+            gmch &= ~(IGD_GMCH_GEN6_GMS_MASK << IGD_GMCH_GEN6_GMS_SHIFT);
+            gmch |= vdev->igd_gms << IGD_GMCH_GEN6_GMS_SHIFT;
+        } else if (vdev->igd_gms <= 0x40) {
+            gmch &= ~(IGD_GMCH_GEN8_GMS_MASK << IGD_GMCH_GEN8_GMS_SHIFT);
+            gmch |= vdev->igd_gms << IGD_GMCH_GEN8_GMS_SHIFT;
+        } else {
+            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
+        }
+    }
+
     ggms_size = igd_gtt_memory_size(gen, gmch);
     gms_size = igd_stolen_memory_size(gen, gmch);
 
-- 
2.45.2


