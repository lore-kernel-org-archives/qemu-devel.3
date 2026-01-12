Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251D6C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDI-0001Uc-6O; Mon, 12 Jan 2026 05:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCi-00019x-MB
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCg-0001iA-Ut
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477632b0621so38631125e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213877; x=1768818677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpoVoyzKEMQOQOPpAUew9Gr5OoFiq3RIGI/UbsfUcDU=;
 b=W3EjPgWMTLckJMcOAoOX4DZw2vpEyVumMOLH9MVWiNkPVOB4CmSDaExEJ5V8oaUFDI
 9VnETgTANXgIaNbBzfTR2/VORfpYz60DxRxrao6Vf4FT4kAzwBMzdcGpys0KDzdpuTWt
 keSeCoE2v2nhxWhbLiG14R/l02wakirC2lNbMQsPBD2IhDR2Tj6L+n5ueeuW3zcbunuE
 JUHNDwjFFro+psv+AC993EQSPg47gBM9ctm8ntGsjLNmvm3qNg/x4QmAo8Tgp3WJzHt2
 zFf9xOz2jbt1irdEfeSNx2SbIlYdXngS7dhywnB1ZDhh96muwJ54v9c8R/g0Ohf4AQR5
 PP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213877; x=1768818677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NpoVoyzKEMQOQOPpAUew9Gr5OoFiq3RIGI/UbsfUcDU=;
 b=dUQjOZVdrSLu0QiGJh8p/8UcimEn1pX1Rn3eEbgFem4pkhHUomTM3DB1m5g2Kyme0R
 FzeIUXHPU11tUNzXcvvq800Tt7fEbkPpfsiNsP0lNUw5M4XQBj9URpBjrE0gksBDYXwC
 oLHwDCKIlwRNq1TUTT6QeHIZD+935NjrsF04GO5SAB8Fxj1y9SqwGl74P7K9vm7yFuZm
 1v2zJDwRI/Eeu89CHmlUDdk06YwnJU8/iF+YSFcSwQqhXgLYT6WvfkZKvfegmAh1R/IJ
 hpUBWQkSdGSrkx8u7PgQcaH5M8sRa6vtTheGz4KRD7mqgh9sCSmP3Q3umEX4JkckMbAB
 O70w==
X-Gm-Message-State: AOJu0YzMWfU3LxzVPJC5ELS4xmvS1Fj4NBV9FMdnhraWJCruW0wqfypF
 KAhdp39EJU+/zRgZ8ObVgCUDW+PruhZuiNhgvL1xc9fHYyueyxRUGnxhZx1pwuMfPXNV04Gl85a
 1sxuycAU=
X-Gm-Gg: AY/fxX4PReQcphw+MwELiyPmQeih96aSa+QvwVxF9uYiSzGj6oHT2Mok2+nNxnWnfUc
 /JyeN/d2VaK+SWWO8B674svg7QeAgAY8ixOJnPGrP3YO+HHKZW09CYpC6rCgvsOGzHjoQYMlwfQ
 3TKXMx/zq0mOjD0GAd4DqP8JeeUkIelZszDkFOHcU8t5NErS6Y+VWr5PcvxLjsWUE4nFKQzHu8h
 UvBa1O/OteC1/hUAFjFAd1WWUoK/gE7zryvM8QJHZxXV6TLIXRaXnSo1ct6alcAzk0e81n9akQb
 B4D8OeZzZw1kFNLdEGdRLdUx48pcyf+DtDr7BErorC39/Qw3sD6fY8faWOHWf/6BX1KKPbTSxmb
 nuPprS70oIWSXaG/BImWr3pXBR5TrWYh417y9rSY5jWN0wnWJ3IHyFx7NUWwIUtDtdNW1GyuVSb
 KBiuKSedgFSiTh2UCHeu9GcN0NswDC6yGML0+5MjtCh3A6fWa0yo98+mMv1FMR
X-Google-Smtp-Source: AGHT+IHi4hPEIeeCHvq5wDFHBvggzMvh+mlDjUUsbZKxfKK4A//iWzyjZqq1WMJULSisnocro/NlfA==
X-Received: by 2002:a05:600c:1e1c:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-47d84b0aa4bmr173588495e9.5.1768213877182; 
 Mon, 12 Jan 2026 02:31:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm340958915e9.8.2026.01.12.02.31.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:31:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 06/19] accel/hvf: Simplify hvf_log_*
Date: Mon, 12 Jan 2026 11:30:20 +0100
Message-ID: <20260112103034.65310-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rely on the AddressSpace and MemoryRegion structures
rather than hvf_slot.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
index 96ed79108a6..bbb0403d246 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -204,45 +204,24 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
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
@@ -252,7 +231,8 @@ static void hvf_log_sync(MemoryListener *listener,
      * sync of dirty pages is handled elsewhere; just make sure we keep
      * tracking the region.
      */
-    hvf_set_dirty_tracking(section, 1);
+    hvf_protect_clean_range(section->offset_within_address_space,
+                            int128_get64(section->size));
 }
 
 static void hvf_region_add(MemoryListener *listener,
-- 
2.52.0


