Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E069CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcsw-0007eS-Ty; Tue, 28 Oct 2025 02:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcsm-0007WS-B1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:08:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcsf-00069j-MH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:08:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4285169c005so2517178f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631703; x=1762236503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXWJQrd0lCphm6hCLWJPyr8+ILvdsszdNySmyDwYfak=;
 b=gx/apBqwKf/d9fWsN5V40f5MB+8MYNwdANXJxRTJ3XPbaxbaA0ttoO8Ub5Yh+hbHH1
 RcbiwYdAE9krmDDvc12z43i4+nDHuo458SydzEOEZ+lUada3WzUv7SfQJ5OsnHdU/i7K
 3QkDeic7kYxzzezWWHBieIf7wfYWLz7dJNLJJ8fVBtn0fn1/ecASRMf0224/03zEPYSo
 dzeQ55WcdXm8TKLO/eUEyt5nJLjapZ0xt7s8DOclCHRJGnEQdaU1NhWyWCkRNkxxebYn
 fb/D9z8jgF/WPAB0lnrIrbA/cJGXQTH8XqrH69kCNAM5qBuC3AD3e7DeHvABg2jUBUyC
 EDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631703; x=1762236503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXWJQrd0lCphm6hCLWJPyr8+ILvdsszdNySmyDwYfak=;
 b=ML3Hf1qk44JCsqh2Ezqpm9BK48rO1VWSUb89vGGYi0wW30Cre0VUUtSXSal4sT/Hr/
 r/Z7/EwoA8GtmfvBEJjoEE6uncwFdEk3x+s4wqJmEvuQ+H1QX+zYzanoWF7EciVcMfMU
 +eSDf2XJ66I4ub/xAfTaxGYFpcbQTzBIkAXHotahILVbhcz3VFTOdbZm1o8PDv+e6a+5
 feMlEpm/1RGsrQ/Aqf4Fp4W/rJoJFDrkFi885HW2Tg0K7Sg0RN3K+syhAr4pSEBdmJba
 vyDg0sxoVcteZtTbtLTAsTa9UFhgPY3WKYHt7e9M39ZH/yYEDdYG8mVGIlJxlK4chu2c
 OGaA==
X-Gm-Message-State: AOJu0Yyo0GHrVvlOBrG4q05ItxQY7tsgekzIRSAJ94fBTFJSII8uyhPQ
 p7U1Nd00nFry+f/WK29LwokNezWpaPy7phUp/d4p0UOLTwtRidJM3+XQvzcithEQH7vgSu6FPSm
 rRkyIbH8=
X-Gm-Gg: ASbGncsW8eaPaN7jmQchMIdXB3j8uZ3+f0XCaYBU+nx8gm31/sS59yN5Iw8LMhxdcZH
 /e57oU9eykObGp+TpgZezkib2L5GEoa+AQ9GUG0FQcWxXaTe2oXSEnMHaI5esA/VNvieMfgjS7n
 mVzzU+Iop3lVbRanB1OdW0w25mVXEPHk71KCbxxo5M8ARKtAhuCOPZSzPdvKMfpLgl/ydxj0Q4q
 SXYS2fVGjgmqnF7G2JKmhT4rWdj0/Evgw3H3Rf4/DRdLaKiHyNU4hcr2LfC9GsLPlwxK3nX8NqM
 wAOYeNr5gUhwH+RtKEevGkdD3pegYe13BKbXXTBXF5XxhpsXN6i6wwNQltpIbho5lWSzZCBpa/n
 c6ja7GdfsGyX+BoCT1z/ypcy5NXsVzu0L+Pm+QcOeYt9c7fCnO8RmMMxRhlTrDaD6vZxouDH2QN
 A9JZjUbh+hH7s6tUaQvM8RxlpuQ5zMGQFLsJ0n/J3VttxzuLVl8X9Ja+I=
X-Google-Smtp-Source: AGHT+IE6G3/3QL/NrzoW29LEAqzzVlCMrcwoFxl6ReO/FwEdV0ppoYrI7y7xmOU70hbENwsrmew1og==
X-Received: by 2002:a05:6000:2886:b0:426:d5bf:aa1 with SMTP id
 ffacd0b85a97d-429a7e99fbcmr1739756f8f.62.1761631703540; 
 Mon, 27 Oct 2025 23:08:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbc16sm17718151f8f.15.2025.10.27.23.08.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:08:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 36/59] accel/hvf: Simplify hvf_log_*
Date: Tue, 28 Oct 2025 06:42:12 +0100
Message-ID: <20251028054238.14949-37-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rely on the AddressSpace and MemoryRegion structures
rather than hvf_slot.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h |  3 ---
 accel/hvf/hvf-all.c      | 40 ++++++++++------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 5a57691885f..ee7ab689f45 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -24,9 +24,6 @@ typedef hv_vcpu_t hvf_vcpuid;
 typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
-/* hvf_slot flags */
-#define HVF_SLOT_LOG (1 << 0)
-
 typedef struct hvf_slot {
     uint64_t start;
     uint64_t size;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 2efecdc9f40..361d658a186 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -203,45 +203,24 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     }
 }
 
-static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
-{
-    hvf_slot *slot;
-
-    slot = hvf_find_overlap_slot(
-            section->offset_within_address_space,
-            int128_get64(section->size));
-
-    /* protect region against writes; begin tracking it */
-    if (on) {
-        slot->flags |= HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_EXEC);
-    /* stop tracking region*/
-    } else {
-        slot->flags &= ~HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
-    }
-}
-
 static void hvf_log_start(MemoryListener *listener,
                           MemoryRegionSection *section, int old, int new)
 {
-    if (old != 0) {
-        return;
+    assert(new != 0);
+    if (old == 0) {
+        hvf_protect_clean_range(section->offset_within_address_space,
+                                int128_get64(section->size));
     }
-
-    hvf_set_dirty_tracking(section, 1);
 }
 
 static void hvf_log_stop(MemoryListener *listener,
                          MemoryRegionSection *section, int old, int new)
 {
-    if (new != 0) {
-        return;
+    assert(old != 0);
+    if (new == 0) {
+        hvf_unprotect_dirty_range(section->offset_within_address_space,
+                                  int128_get64(section->size));
     }
-
-    hvf_set_dirty_tracking(section, 0);
 }
 
 static void hvf_log_sync(MemoryListener *listener,
@@ -251,7 +230,8 @@ static void hvf_log_sync(MemoryListener *listener,
      * sync of dirty pages is handled elsewhere; just make sure we keep
      * tracking the region.
      */
-    hvf_set_dirty_tracking(section, 1);
+    hvf_protect_clean_range(section->offset_within_address_space,
+                            int128_get64(section->size));
 }
 
 static void hvf_region_add(MemoryListener *listener,
-- 
2.51.0


