Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C813CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmc-0000bH-Up; Tue, 26 May 2026 10:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmW-0008VB-ES
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmU-0001Kd-EL
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45d96d21e82so5806444f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805757; x=1780410557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TIUc3us1uVlG1iMMYGrUqerQ4qxBTEdE41EbBJYVaeo=;
 b=aoXIWh1+aYyaBwDbvso/0PNPNZochWJDn8WSdW9wilGgBZphSXoErbbIWjf/omTNgB
 +6XJ5A5pfsH+IHw5elZgs7TWhs9eCpM8x+KGCKpthx9FlzHiiEzzOEyDE0RxOyN/yGL7
 bDs6QgBDPO1dPalYncXkHAr5KzfUrbahyvLeT43qyC/9HvTWQKOM9hZ6cked0DPD8lZc
 6mFBb2RumcHKVz56ojuXrlLCxnFt9Yko+7ggvsFgAzx18INNre2ktvE3pQyvIRBffsLZ
 m38Z0yC2WU6BsyR0KGK6Pc2g3uVne16rzxNV95i73vtbee6j1iHGv51xx9ZLZ8qTpIqL
 wk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805757; x=1780410557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TIUc3us1uVlG1iMMYGrUqerQ4qxBTEdE41EbBJYVaeo=;
 b=RbdEuDuDKenEG932FB1lDyfGeXvWv4oaF/MrQHJz237TvCz/lOCoCXl+04aXAPBGWM
 rl01vCCAgd/WpprLKqmVYiZV9kG1AvuEfqvAagy2pFAT449dk/Z8oCc9CE8lv2jxJEW2
 tokwOKnF6WsxB6tEQRoOHho/QXN31zKb51dIsuc7m/WHcVGA11goZzRiQ9WosG4qJrtZ
 0Z+wa5QfjzYvRPTNbjMD9n1+hYfeFsKmHI/52XLb+5W3gSdCGk4TX65cUsKyK5NWjclb
 3n9QW7hud3/OEo6aKVkRBRLaPU9Bf0HCAvHTt6JakDHHC8t7GdKkWDN/7hd/kswOD4Ub
 9RQw==
X-Gm-Message-State: AOJu0YztpMDgKINp0EoeWPa/dvfPWj40LwBdEtbHwBWF+uvp7xn5VFHO
 7WKZMH9aet43p/LIWCnZAk4Nh95aDF3SvCtuBe9kCqzAs7oBfFP4GkBuJWlLXavJZ08TdfJIZsf
 G3qfC
X-Gm-Gg: Acq92OHq4mCh6qit5Uq3+tP7az/9H8knkYuijw+hJFqXGwE8OZXYofoLaJF/O2tZcSL
 DbhONZdr87X/UXp8Fn64IHOhG1RMECqYh0/5j02h4YO+Bd5BPNEakW4lA6avcWgrBAMRYYtNJWM
 1+ivX8tzZuB2WU5PssdtV+7B0A3o1JHBjM4Oj8vDCFqsYahsEw9nZPCs1cjqDPzb+tq6ob6hUAt
 3QU10z3O0uUfystTm40To5GmNfKXQ+yse7zg37MWVD+S+hG0EgLAniHsdHYhHanTqKeBN1/3ig9
 Ncz3CC7ElmANuHtyUNFSt59n9bAGD42zZk7CqU/9TexKbC6dyt9D30GMds/Jw3BEXZ1XHjX2GaZ
 VgT3jpoM0QIJZwo41x8Ka8TW63qwNswxSt83XNc96aqpDkGIm8Gtr6kbsaMtok+t/Z+q3z0CH1y
 niU/LxaZ8pcNUCjXgozzVXu92saEu+jH6H3JYogH1D00bFJ46HhSxCQG/k+Rm3xu9cMwwaWHwKb
 rvl7ii93ngrWIAj7XLS7WiMYGKXTJc=
X-Received: by 2002:a05:6000:4803:b0:45e:7c19:a328 with SMTP id
 ffacd0b85a97d-45eb38a10ccmr30465550f8f.28.1779805756837; 
 Tue, 26 May 2026 07:29:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/54] target/arm/ptw: Flip sense of get_phys_addr_for_at
 return value
Date: Tue, 26 May 2026 15:28:22 +0100
Message-ID: <20260526142850.2326589-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-14-peter.maydell@linaro.org
---
 target/arm/internals.h     |  2 ++
 target/arm/ptw.c           |  2 +-
 target/arm/tcg/cpregs-at.c | 12 ++++++------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 00830b1724..139c8d1769 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1526,6 +1526,8 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  *
  * Similar to get_phys_addr, but for use by AccessType_AT, i.e.
  * system instructions for address translation.
+ *
+ * Returns: false on translation failure, true on success.
  */
 bool get_phys_addr_for_at(CPUARMState *env, vaddr address, unsigned prot_check,
                           ARMMMUIdx mmu_idx, ARMSecuritySpace space,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8cfa22fb69..d1f23340aa 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3851,7 +3851,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
      * check is handled or bypassed by .in_prot_check) and "memop = MO_8"
      * bypasses any alignment check.
      */
-    return !get_phys_addr_nogpc(env, &ptw, address,
+    return get_phys_addr_nogpc(env, &ptw, address,
                                MMU_DATA_LOAD, MO_8, result, fi);
 }
 
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 53dd67375d..1c819c1cdb 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -31,17 +31,17 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     bool format64 = false;
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
-    bool ret = get_phys_addr_for_at(env, value, prot_check,
-                                    mmu_idx, ss, &res, &fi);
+    bool ok = get_phys_addr_for_at(env, value, prot_check,
+                                   mmu_idx, ss, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
      * have to deal with the ARMCacheAttrs format for S2 only.
      * (Note that res fields are only valid on ptw success.)
      */
-    assert(ret || !res.cacheattrs.is_s2_format);
+    assert(!ok || !res.cacheattrs.is_s2_format);
 
-    if (ret) {
+    if (!ok) {
         /*
          * Some kinds of translation fault must cause exceptions rather
          * than being reported in the PAR.
@@ -144,7 +144,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     if (format64) {
         /* Create a 64-bit PAR */
         par64 = (1 << 11); /* LPAE bit always set */
-        if (!ret) {
+        if (ok) {
             par64 |= res.f.phys_addr & ~0xfffULL;
             if (!res.f.attrs.secure) {
                 par64 |= (1 << 9); /* NS */
@@ -169,7 +169,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
          * translation table format (with WnR always clear).
          * Convert it to a 32-bit PAR.
          */
-        if (!ret) {
+        if (ok) {
             /* We do not set any attribute bits in the PAR */
             if (res.f.lg_page_size == 24
                 && arm_feature(env, ARM_FEATURE_V7)) {
-- 
2.43.0


