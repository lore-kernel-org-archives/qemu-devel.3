Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888C8D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmes-0006Fx-U6; Sun, 01 Dec 2024 11:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWF-0004gJ-Rn
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:01 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWD-0000MQ-MP
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:59 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-724d8422dbaso2825773b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069394; x=1733674194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMyozJ6DBXdJ3uspS/5iXrrtagliYxbLSROJVV3WvzM=;
 b=Eg8eiNC9XVLO9J6B16aRMdiWWq7sLxXHNF6bPef7cGlPzyefVz6iKnFzv0d7uK2blH
 dFtwYEEYxBeVifmus3rqbbfZP5wZNlKd4Nb+8+NClCj4EgUApC2lYvyU3fIQXyu9zcFo
 gHg6MKJFKynABCqiSravreKubDqW8F9xP173/7hywliJK2YQSsmW4RL96OGKbbc903iN
 2teavUcSbpPfgNZ9d9nywp3Y/XPs0Z1x2uWfjBtD/bVa5tEivjeDnlxEUE+jxRRCRQDM
 otJMErkz8qPl0SR258pa2aQwqDL7ce75BcjG/P//Z/K4jEDhjdxsIEBwur6MUfP3J+lc
 wsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069394; x=1733674194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMyozJ6DBXdJ3uspS/5iXrrtagliYxbLSROJVV3WvzM=;
 b=TsO6Emh/sE+BmDzgFpObTn4iBFCMO4/zrzhzdr2WGlHunR80EqYid89tGRw/SEm3Ko
 TRn4gjulSSPYIb8V0xKWEcOuPNCNHgcBen6+uNOxsiBylAxGKYKhEsFmnrmpvmqnhpmf
 zqAdaC6nxHOPYpwa2T/SQ6sWPxhZm/aP17DhoaSg+9xB9zyCKrXFYEPMI4Gkmd8ptLIl
 ExBovVuo/zBRoDYD9QPFurrJD3sXVqO/1GYHL/VFoW51EnDX8jglvBz//Rcc4e7ipmuG
 +JNcd2xpx5W7wDLK0EvnAKlOm68N79zfeYnZzwqUeYFMUqVPWDFEKX93/DovoupZkTFe
 TO0Q==
X-Gm-Message-State: AOJu0YyyzyMDEZ6xnENZ/rCG7qM5Dx0bFrfzqGzqQkUsDzJHtNkPVOpq
 80Jl//w+kOP2TeBC/ApHL4YO7RzN2hC77r1/W7KlMnYTCpo6qxem48JteGk2x+oM
X-Gm-Gg: ASbGncuBdsNExDLRy6nNk5pgiswLKd9k/ev+5KO1aTJimZo5Qi7ku4hkaNokskus30D
 IxLFIlNh75du+kJJmcZaqhHqYWwE6bOzyv+QTzB5R70H4VMfTGbkSFyGl10gzi4+ajCCv0ue0UD
 HBvv0DrwpXC+DuGVk4VJFupAk7HHQpFN8EKq+41pSlQRcU7Z6DV3F2nmCOeJzhbKch+H5oFooKO
 +BG1R+0BJxJxBRv0qGoNJqdWrcYOPx4gP6C3e+2EaUU26o98BXYxiXh8BI=
X-Google-Smtp-Source: AGHT+IF/IvWq5CHeQmALXaR2tOpcd5B79LKQAfEDozssy8Jv5PG/NSGyx+h9vyp/u7rSURjokrlnhg==
X-Received: by 2002:a05:6a00:c8b:b0:71e:cb:e7bf with SMTP id
 d2e1a72fcca58-7253013e6aamr26713943b3a.18.1733069394593; 
 Sun, 01 Dec 2024 08:09:54 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:09:54 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/8] vfio/igd: align generation with i915 kernel driver
Date: Mon,  2 Dec 2024 00:09:34 +0800
Message-ID: <20241201160938.44355-5-tomitamoeko@gmail.com>
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
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:42 -0500
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

Define the igd device generations according to i915 kernel driver to
avoid confusion, and adjust comment placement to clearly reflect the
relationship between ids and devices.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 8f300498e4..71342863d6 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -59,33 +59,29 @@
  */
 static int igd_gen(VFIOPCIDevice *vdev)
 {
-    if ((vdev->device_id & 0xfff) == 0xa84) {
-        return 8; /* Broxton */
+    if ((vdev->device_id & 0xffe) == 0xa84) {
+        return 9;   /* Broxton/Apollo Lake, Gemini Lake */
     }
 
     switch (vdev->device_id & 0xff00) {
-    /* SandyBridge, IvyBridge, ValleyView, Haswell */
-    case 0x0100:
-    case 0x0400:
-    case 0x0a00:
-    case 0x0c00:
-    case 0x0d00:
-    case 0x0f00:
+    case 0x0100:    /* SandyBridge, IvyBridge */
         return 6;
-    /* BroadWell, CherryView, SkyLake, KabyLake */
-    case 0x1600:
-    case 0x1900:
-    case 0x2200:
-    case 0x5900:
+    case 0x0400:    /* Haswell */
+    case 0x0a00:    /* Haswell */
+    case 0x0c00:    /* Haswell */
+    case 0x0d00:    /* Haswell */
+    case 0x0f00:    /* Valleyview/Bay Trail */
+        return 7;
+    case 0x1600:    /* Broadwell */
+    case 0x2200:    /* Cherryview */
         return 8;
-    /* CoffeeLake */
-    case 0x3e00:
+    case 0x1900:    /* Skylake */
+    case 0x5900:    /* Kaby Lake */
+    case 0x3e00:    /* Coffee Lake */
         return 9;
-    /* ElkhartLake */
-    case 0x4500:
+    case 0x4500:    /* Elkhart Lake */
         return 11;
-    /* TigerLake */
-    case 0x9A00:
+    case 0x9A00:    /* Tiger Lake */
         return 12;
     }
 
-- 
2.45.2


