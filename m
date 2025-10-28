Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867F7CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcul-0000tT-9y; Tue, 28 Oct 2025 02:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcuj-0000sQ-Im
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:10:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcug-0006SV-RP
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:10:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4710022571cso57362795e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 23:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761631831; x=1762236631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c57WLejTczCDPIZIT4ByZo9teKQW5zfA4LdyJABPRTg=;
 b=e+3EopaeLuu4KrQfz+SwgD8vObeTmIHGTdivkMvDd1/cpvg5bA/56OVDs1W1lh99+W
 n5ATWWfe2FeV3zzjbtBVPu0UCjHxPMGc/5P0x7Tg3oTHk1kLvmJiV7uT0xLQBNrDCdIL
 DlHtk1ll/Cem4sCSZ0D0AdsMW6smWgxqwZO8I5ASntyOsn8cwXnPLV7M60sMKGty/sSf
 mdxiTmgYVMSCNeXR4LqQXIq7jjdt4OIB0gje1OdHMxboxMaVdpKFXEu6bqWbwuAAw02D
 aksK7ENeRGlFK9wDdUKe5/74ynhfL4/Xa4zxxwlSt97AOuqlbbfGvgtQRrETu5CS959n
 w+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761631831; x=1762236631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c57WLejTczCDPIZIT4ByZo9teKQW5zfA4LdyJABPRTg=;
 b=ZRwOPkD79e1OuI62nwTUyDyQf3PauPCRY64a0Pn/DrdqZoghf1Glebu1/9GTbyvRBx
 8U/Gyb9VyObeWqILCulV3K0WEgYlzCp+C9iQXTgrH3m/JvcTMn+JlllrBFfjt8dN/kgy
 VtGoUMSu5WPBNa2CFD5YVCT1OSK7B9ub07iFLnY+tPyOkb0xMlxt6IdiFX2BLy3Lw2l4
 rxJ5BLvTZUHErS3vzp8QNAyMUwZI81DXgCeuH6S+VGPCdAsnFqjFukIaYgcFG5Lbecvm
 scatxHUA1zn9iHiOdSP511PNKcYji2m7jLxNcFkYZTDFY3ta1q+xjKayfCFOBEBhDXZO
 hTaw==
X-Gm-Message-State: AOJu0YzO5jR9BKnvmOZPsDlxsKXnavuTGluyHc0y9qYJktPlKJO1Ss6U
 8REQZuCVhDUyc559ZzLofesNEWA0GoBP/BLdZC+/DI1avBN+AGDyGu94NU3gfaixfEsHEzECTzr
 gnAYtmPI=
X-Gm-Gg: ASbGncuvDqbShLACTmm2gterkk9uzz2glCzDJukngRIGEw0c6SxU8tmLFe+Dpg0T49r
 JEDzHq3jQXVoH3B5XP/WzmXPrHXZMwKTB0a0j5tL2PVGVYSijmrTzkGoIhO/D+RwXseHS5mj++h
 Y7YUFJT5EdY4ZxAg75MrvpIR+OL64u17cFlYzazfwF54iTX4NvZdL9V57G3mvjBw0ZlhZ3TolzV
 Xr388Ds6xajCT0QnzIUOO06HHHH35uQpFst+1MgFtTtDncj4Yu+aSgmB6xuuMUbMyV09h746sar
 hWTdvesvoafqZEjZ1nvafUK1bCuVKA9vOS3UTeXtJ9EynXLxJpSTM1kNr34e/Sw79bVhIKeYj+E
 uXw/sJkySn0TlzUKO9alVwhJpoi+MbgwEMUqVy+Ubkt2X1DAwK5bJ+dxfsXVULo21IiHfAE62Z5
 p04kwAzIBz0K7AgJPr1UbN+pcLzBiFWqg4JTTwFXv3WXklgR1EbAz8KFn1qnKetPd/hw==
X-Google-Smtp-Source: AGHT+IHfJ5PxhF6cWtNYzpntxnGThsRWzPMjp3stikE2ehcpZppLxfF/MIxk0pp5kh2TUQfMjKQDew==
X-Received: by 2002:a05:600c:6303:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-47717e40960mr21540015e9.34.1761631830787; 
 Mon, 27 Oct 2025 23:10:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd035e05sm174667875e9.7.2025.10.27.23.10.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 23:10:30 -0700 (PDT)
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
Subject: [PATCH v3 39/59] accel/hvf: Drop hvf_slot and hvf_find_overlap_slot
Date: Tue, 28 Oct 2025 06:42:15 +0100
Message-ID: <20251028054238.14949-40-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


