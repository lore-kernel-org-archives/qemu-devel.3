Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC107CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFraK-0006dY-MT; Mon, 03 Nov 2025 05:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFraG-0006Tw-Et
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:44 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFraB-00033m-9J
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:43 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso1631240f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164873; x=1762769673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c57WLejTczCDPIZIT4ByZo9teKQW5zfA4LdyJABPRTg=;
 b=EL+kTxskJNIOFprVuMUOo4cBwehT2S5s7PRmOnAGr1QqHKhlC5nv7do9AatoeZFcLL
 sk8uhKGA/i7OBuwh8CK6ng4tB0t3X4MIJcX+HydLxGPdng4RpsXjrsZA3g4ReNbBUvVT
 FOKUHw23+VJD9hcgCVeOShlb3SjSB5QxuSPQ8/jG5200qCOv8a0fVpufwpGofItkoLpJ
 OR+aZz0ok8lMOm9qluNltpx9j3rhJWmUPdYMe183Sg0kf5pO05nnf/Lekfj0/LZ39mIo
 iB9xieErpbw6lLfPrZyjkbCF2Z+VbOGJcuw2rP+TbSMGTn/4gsla5dSredbH3QTJmm3w
 6OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164873; x=1762769673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c57WLejTczCDPIZIT4ByZo9teKQW5zfA4LdyJABPRTg=;
 b=czD8b7seEgJ2bmk7FtDFOxKC8SAR+0H9KbryDcSinzr1pA8s2miQsCRqULKnWXDxc3
 ofAjiS+wUSkiYr7aNof5JBOwkVPDyK6Mo/OzJlRKRpfjbdhba3K6OxIXxq33+wR9c6C3
 1+yrr7Z0SIKK8B25oeX2hSmlL5bkrosqhDn9oSdfx2W3M261RS6pwaUEothAAEkNJLjK
 fzYFqMjB59tIt6m0jC9T9rzob32T4Wm//9bUd2UsBETsaoXC4icUDTFzE+7TWSXpdfzi
 5bmYjVxs6YuXkuU2+1rVVdKWyzLtoNB1+MGNm5wa63SJh3ZhFa9tqvuJ5/gqI7hol8SW
 zIrw==
X-Gm-Message-State: AOJu0YyfPCzwqdxtfwxbmKBbOyAME8sT3wn8vak+ca3sFpqIt2PGrJou
 wBZOXO/Gm9RAMufSuHmgb/w+ZeeyAeiLLvJrJlS3PdVhp+y/Cagq9+tq/z5pkKRX+IGYpNf3eG0
 2FLaSsQQ=
X-Gm-Gg: ASbGncs0N/5u82vqFAaxHa6xIU7Xq7pPT2PrxsmP9h4Ly7s9yuU2afA0qCKW+/ulcwz
 WRUMhpe7hQk+b0d+LKPxzI3I5R2Xkmm0RCmqaCaz6jOPouM9fI9qn87CJHLyU9Kw1/TQ9nwU0Ai
 DPKprgA7rJ3PCB6ORAUxWvBWMzL/rj7CsQzNMqFkBg1VNoIEBiXHfxSe1l2gAkaLv/kSX31BkIt
 +lC4JwgKVHQg5Hz8Yr7lIqM1STKmh5+phYtDklOn6vpd9FzyAybr/WlG6M0rvv5iSjIxpT8eP/F
 aK5nHywfOiHMdAx4JC4IDDUhthn+TWA86nlyk9svSXSKdeAJrlhtLMRjbIpDy2uNLmTRKFk2KiN
 b1rxeSjvWNNgraviBkQUucDQgvcTwlXaQT58LU+QEiIqukv90rDH+04k1XiOoiDHvBzeI6xTpSa
 rNCn4LkopZl8++llfzVOf+Xj97zgmovsF0l1BQ0/88InW2i9dbnA3WjmkRnJM=
X-Google-Smtp-Source: AGHT+IFNM//af+kU4SVUq3YIQ7Pdv0I8MFFAY6t26nglj2Kg/iaETdq9BfD/XJqFue8hAbPWKrGQJA==
X-Received: by 2002:a05:6000:26c2:b0:429:d41b:9fd8 with SMTP id
 ffacd0b85a97d-429d41ba2e9mr1711762f8f.20.1762164873082; 
 Mon, 03 Nov 2025 02:14:33 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c11182e3sm19869172f8f.11.2025.11.03.02.14.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:14:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 09/23] accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
Date: Mon,  3 Nov 2025 11:10:18 +0100
Message-ID: <20251103101034.59039-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

These are now unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  | 13 -------------
 accel/hvf/hvf-accel-ops.c | 14 --------------
 2 files changed, 27 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index ee7ab689f45..d842d4b2b99 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -24,15 +24,6 @@ typedef hv_vcpu_t hvf_vcpuid;
 typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
-typedef struct hvf_slot {
-    uint64_t start;
-    uint64_t size;
-    uint8_t *mem;
-    int slot_id;
-    uint32_t flags;
-    MemoryRegion *region;
-} hvf_slot;
-
 typedef struct hvf_vcpu_caps {
     uint64_t vmx_cap_pinbased;
     uint64_t vmx_cap_procbased;
@@ -45,9 +36,6 @@ typedef struct hvf_vcpu_caps {
 struct HVFState {
     AccelState parent_obj;
 
-    hvf_slot slots[32];
-    int num_slots;
-
     hvf_vcpu_caps *hvf_caps;
     uint64_t vtimer_offset;
     QTAILQ_HEAD(, hvf_sw_breakpoint) hvf_sw_breakpoints;
@@ -70,7 +58,6 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3e5feecd8a7..bbb0b385fe9 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -64,20 +64,6 @@ HVFState *hvf_state;
 
 /* Memory slots */
 
-hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
-{
-    hvf_slot *slot;
-    int x;
-    for (x = 0; x < hvf_state->num_slots; ++x) {
-        slot = &hvf_state->slots[x];
-        if (slot->size && start < (slot->start + slot->size) &&
-            (start + size) > slot->start) {
-            return slot;
-        }
-    }
-    return NULL;
-}
-
 static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
     if (!cpu->vcpu_dirty) {
-- 
2.51.0


