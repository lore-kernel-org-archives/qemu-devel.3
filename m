Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BDDE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9WX-0005RY-GB; Thu, 05 Dec 2024 05:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WV-0005RA-D6
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:55 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9WT-0003Fc-OH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:55 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7251331e756so819544b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396151; x=1734000951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lpaVTclhDlpFRzEmZQaeUmvCBh3nRuKyRkZZ569Nr4=;
 b=LR991K0jeW+5v17sSR9NPUcXMJC+UADlj4gTwZVW6OWWd7hQEWixhwDLXG7sKNn1+e
 ZIDLXnpJu8VbN1sMkq9TUSXkak84m97DDPWyOKpLnI0EF3t2ykE2DswtUbogspqbNhU8
 8nLJeYBv964Gm2vMdh0z0gJkPiz3dXnl1nwhrTqt9pySd3V09fkgAyV6Y1Cji9KQeroR
 ADwSobgZBa00uM3pS2KnyeWHIRYXQdIZQvEqUWpJKQYRFgNKVPztxPoR6cb5BfanCni8
 3mgi/hLd/T6pWTe4ElblcJI1OKRr+evStJk8Mw2yJt9Dy7BQ3VwUcnQsPoW/G07igAxF
 yqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396151; x=1734000951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lpaVTclhDlpFRzEmZQaeUmvCBh3nRuKyRkZZ569Nr4=;
 b=wn+EuvE8D+sF047Aeu8jUybc9llNlBzoQ4TIOE2fMFrGyIZlmrf2PWHCYL9evjK5On
 knZ2S8ev0Gg0rIFRsZfL9gJTJsvCpm5hiz7LP/rl+A2Aiydq9k4dw/Y04WhOdCsIi0Xd
 8kt0hgEw/DMpPxftLFEHwEPa2KAQ+tbeFQVQze7cJv3fJCgS0tHXdeYVD786QtEpG6d2
 Ok3KMd+5WROtFCdwkgzr0YLwaMIl1TJlpjPW4nkczkswrd23uTKLjK8NJWPoAY128WtH
 qOYKQPAuBTg60nAE0ybK4n8faDr21c0/FafEuZxvlf3LMuBkQqP3fQBEWdPKJwGQTvZu
 srKw==
X-Gm-Message-State: AOJu0Yzh3Sj0BgCarArieFybiaDk2KgU0CmhIMsiOPyXmK6GCSMSHks7
 tKfcb6DOz7ukrLut6gC/R1py/Nch30EkdXvuX7yy66fysn3H7fWj7T7EFJoTkg==
X-Gm-Gg: ASbGncvKcmy8D8ANMcAvAuAQQYBADOxlZ5Itj8qtIjaM0vB5+PXQhNwEuSjKb+e8P/f
 ds5N898vbVQkYSd7Tr0+/Xpvgqb/fMTxwS7WFDdCMxWkQqw5T4fqJbiDV9vW3Ir+R0t7qrKljdH
 bVzGO2ZzleasT9IAr25VTQZiJthZUnzpoyFHq9UOQk7n1HF3yHcF0uLHFeCQ61IStc38Fjb91Ct
 4YwKmYc9FaFsblTywCREbQEFh0t+IjQHmQExjflXPGvcQB7KyJ2kXIa4A==
X-Google-Smtp-Source: AGHT+IEzM4jt/xlvppyVT22xK0FgBiDw6jv1SwVcjLLLpSg8xSYPf8z09jebU1nSOeQgS2VnxceIMQ==
X-Received: by 2002:a05:6a00:3a16:b0:724:eac3:576a with SMTP id
 d2e1a72fcca58-7257fcca19fmr13553419b3a.25.1733396151340; 
 Thu, 05 Dec 2024 02:55:51 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:55:51 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 02/10] vfio/igd: align generation with i915 kernel driver
Date: Thu,  5 Dec 2024 18:55:27 +0800
Message-ID: <20241205105535.30498-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The condition of how GTT stolen memory size is calculated is changed
accordingly as GGMS is in multiple of 2 starting from gen 8.

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6ba3045bf3..18d179bc83 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -59,33 +59,34 @@
  */
 static int igd_gen(VFIOPCIDevice *vdev)
 {
-    if ((vdev->device_id & 0xfff) == 0xa84) {
-        return 8; /* Broxton */
+    /*
+     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
+     * and 0x5a85, match bit 11:1 here
+     * Prefix 0x0a is taken by Haswell, this rule should be matched first.
+     */
+    if ((vdev->device_id & 0xffe) == 0xa84) {
+        return 9;
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
 
@@ -258,7 +259,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
     ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen >= 8) {
         ggms = 1 << ggms;
     }
 
@@ -668,7 +669,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* Determine the size of stolen memory needed for GTT */
     ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
+    if (gen >= 8) {
         ggms_mb = 1 << ggms_mb;
     }
 
-- 
2.45.2


