Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF429108E1FA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3COQ-0005JF-Ic; Thu, 19 Mar 2026 08:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3COI-0005Es-5I
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3COG-0007g7-6J
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773922935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qC4re8eGWqqdLBNRpKozayHnHTeGvGDgVhXYTFSM3k=;
 b=ZMYyvJETrU3azzFe2BMKKnn+nSixcwinAoDToGry0P1R4ntrp44QsgnWnBQDs/GgSF76Jz
 lhO2R6OOZDqzJXqfw+FrJX5JTVQTnE4+DjVQyP8OF/Tlhq3ZhtoesN/I+fza80SNn+ly7w
 j8YCclMj0SQ7+iLCBUiioaHc0QVVGlA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-LfOGq7BRMCCkeZK0NB021w-1; Thu, 19 Mar 2026 08:22:13 -0400
X-MC-Unique: LfOGq7BRMCCkeZK0NB021w-1
X-Mimecast-MFC-AGG-ID: LfOGq7BRMCCkeZK0NB021w_1773922933
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b62da7602a0so858108a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773922933; x=1774527733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qC4re8eGWqqdLBNRpKozayHnHTeGvGDgVhXYTFSM3k=;
 b=UL2TAPPc8xLnL0iReE9zFAQaqn0Aly7ededbtxYY43tuKoSUOTjPOGaC7luVWHNy+e
 nxFLzRhnH+DNu/YNAdSfIitH3cwOzjdyiHjam8uxvp0gSNZ3VscYLvXqSjdww2R7vQEG
 urf9J3+eXf1aVhsMsAMypEB0lXNNH9d1fd1x353rg1J1HrZ7gdBtnYY/KzDkFGan2SQP
 EuTDxlNGBim/uTO+U4WtofyDU4npq0Q+emZRnNau5a5wZ2T7jL+W0glvlwHgLEnXyWpd
 qAlKUexMSK/C4mVlpE6nAnN1+ySZ738lSnqCQA5SI+FYd1xUkGrXFcvbgwVG267n2UBv
 33dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922933; x=1774527733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2qC4re8eGWqqdLBNRpKozayHnHTeGvGDgVhXYTFSM3k=;
 b=Ogs9gv1cvV2s10UwQXTS/wTmX/IgJJoREnIh4+iWOWjBlYbzCXNEGwHKlljpBs/+jB
 7BGTgw5nhLfI1V2qjHuI7qsJVbdJvl2UadvYP6q9a8quvj4m2NgiSW+JPUr5n8azfzVF
 GkECe9+LQyj0FBLuAZGQwoHwuYE3lEpMoiP8QdQ+lQ4ezDXvy++1HUTu5wAM3w6k68SU
 0DQhfyutcSrOPXvgsuPXVIIsP70bvtjnDCkabUghnzgfsjZYlayLNLOAG61QIyGHnm2A
 D/lHh/RAvlMwD+5xKSD47w+8WYJQpMRImwLOfRREps288Gz8i1d6LEdqJL+6vEp+/FkT
 6p5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7k4Aj2Fz8K9e0h4VQujLnsVbTyG+JHXPwcDHENup21hkF/uqN4JOiAjZkiiW0OUz3lW70+s9vtBht@nongnu.org
X-Gm-Message-State: AOJu0YwHsjHCRCVfSI9OK/4OEo+QIsu6Sz92c0mnSReY2YHXj24HmA7n
 /kQ93AtRQYlEb8XuoUIAj6S5BMKpW/xIhp5H29HadhLoDfCP7J2FhjmuVj1jcprAd3nNJ/9qDpw
 ErW4//nAOd+9U0b3GKgBDJrDSkCDs3qIs/ZEHg0ZM4eMxnHX1o96aZSHq
X-Gm-Gg: ATEYQzyBiFyxhECp3PYT2Gm72j2utneUnKCj/Qt08167zmf/+RXYQStCbt1HKm0JyeP
 mSiMNWCmE5t69QXx8jmCzUhNRHBR4rLDV3vWQ6QodhTtfOHYDm+1Rw8vguYN8d4K0piA2K/+89Q
 InruYVyv0vaFmjrumAxdeMj0tvYtDqEPKjHeIGSHPV7CBclE/NTuSNLnaPN7RT2Oc10YWgacsY4
 xJSsKLx6sK+dWB1fTgBdw5Lk2feN2zQrPzmI6G0Xc8+BenVWz6+IyBxxYwDoZINB7dZgz/pFvOg
 6Mhm2v1n6Q6xR7vIPcRVhhDyeSq3QC23lZ4itGj6Yyy+59o6T2iLg5bFyI9lp3/giuE+xkefy8j
 WqC+VA4/sh/I/YJT0DEkd80bt8kClYfq1zme3P1nk9D+CNMyXcvkhlkA=
X-Received: by 2002:a05:6a00:6caa:b0:824:195e:c382 with SMTP id
 d2e1a72fcca58-82a6af0be59mr6597512b3a.58.1773922932785; 
 Thu, 19 Mar 2026 05:22:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:6caa:b0:824:195e:c382 with SMTP id
 d2e1a72fcca58-82a6af0be59mr6597483b3a.58.1773922932208; 
 Thu, 19 Mar 2026 05:22:12 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbe1ffbsm7876649b3a.43.2026.03.19.05.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 05:22:09 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
Subject: [PATCH for-11.0 v2 1/2] i386/pc_sysfw: stub out x86_firmware_configure
Date: Thu, 19 Mar 2026 17:51:35 +0530
Message-ID: <20260319122137.142178-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260319122137.142178-1-anisinha@redhat.com>
References: <20260319122137.142178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

x86_firmware_configure requires ovmf support. Add a stub for this function call
for cases where OVMF is not supported.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc_sysfw.c            | 31 -------------------------------
 hw/i386/pc_sysfw_ovmf-stubs.c |  5 +++++
 hw/i386/pc_sysfw_ovmf.c       | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index d8a86756ca..0a073c4285 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -283,34 +283,3 @@ void pc_system_firmware_init(PCMachineState *pcms,
         }
     }
 }
-
-void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
-{
-    int ret;
-
-    /*
-     * OVMF places a GUIDed structures in the flash, so
-     * search for them
-     */
-    pc_system_parse_ovmf_flash(ptr, size);
-
-    if (sev_enabled()) {
-
-        /* Copy the SEV metadata table (if it exists) */
-        pc_system_parse_sev_metadata(ptr, size);
-
-        ret = sev_es_save_reset_vector(ptr, size);
-        if (ret) {
-            error_report("failed to locate and/or save reset vector");
-            exit(1);
-        }
-
-        sev_encrypt_flash(gpa, ptr, size, &error_fatal);
-    } else if (is_tdx_vm()) {
-        ret = tdx_parse_tdvf(ptr, size);
-        if (ret) {
-            error_report("failed to parse TDVF for TDX VM");
-            exit(1);
-        }
-    }
-}
diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
index aabe78b271..b53906a052 100644
--- a/hw/i386/pc_sysfw_ovmf-stubs.c
+++ b/hw/i386/pc_sysfw_ovmf-stubs.c
@@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size)
 {
     g_assert_not_reached();
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index da947c3ca4..2f7d15c9f3 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -28,6 +28,8 @@
 #include "hw/i386/pc.h"
 #include "exec/target_page.h"
 #include "cpu.h"
+#include "target/i386/sev.h"
+#include "kvm/tdx.h"
 
 #define OVMF_TABLE_FOOTER_GUID "96b582de-1fb2-45f7-baea-a366c55a082d"
 
@@ -160,3 +162,34 @@ bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
     }
     return false;
 }
+
+void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
+{
+    int ret;
+
+    /*
+     * OVMF places a GUIDed structures in the flash, so
+     * search for them
+     */
+    pc_system_parse_ovmf_flash(ptr, size);
+
+    if (sev_enabled()) {
+
+        /* Copy the SEV metadata table (if it exists) */
+        pc_system_parse_sev_metadata(ptr, size);
+
+        ret = sev_es_save_reset_vector(ptr, size);
+        if (ret) {
+            error_report("failed to locate and/or save reset vector");
+            exit(1);
+        }
+
+        sev_encrypt_flash(gpa, ptr, size, &error_fatal);
+    } else if (is_tdx_vm()) {
+        ret = tdx_parse_tdvf(ptr, size);
+        if (ret) {
+            error_report("failed to parse TDVF for TDX VM");
+            exit(1);
+        }
+    }
+}
-- 
2.42.0


