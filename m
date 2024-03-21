Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B12BCD11C2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKhq-0002Qw-S9; Thu, 21 Mar 2024 11:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgy-000165-P1
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgu-000299-IS
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:54 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56bc753f58eso1160596a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036249; x=1711641049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBTm7fX0XnajgMEHRoXg20PUgOsEK5tp5uuFAd0ZnLA=;
 b=H1qzqjlxkFgeWoyQSFcTFl3TEpIWfvk9T4J1EQEwiTf0GuSzHlYQtWdNpZW40t9ZEo
 I6Oi62JeJe+extwbnPA2gvgFiPUsaOiE/2HoiqIU5AL1msL6rFuT9q1xHm9qd22hlmwH
 E0X80XzKOGgxRx2tJ5hwxLe4OxkgYdwvXcNngYX4jET7zCBKeQO0Pw/JgJr9MpVGikxk
 Rsw6blJCj5VxuOsN3EB6hjCEoyDcgnR+0Xmc8KUcgiKtduXfZ8eFzVlgf0/kUyrg4CjC
 rYEgs/tjkJvJ3xUR56XSestV8IVGeKCeWzvOMmZb4q04h9edFUD3fgr3ShkNdWbcKdDC
 yKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036249; x=1711641049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBTm7fX0XnajgMEHRoXg20PUgOsEK5tp5uuFAd0ZnLA=;
 b=mNk0+3kveJ9HxWOYUzGsg2kBpGIxC0i5j6o0CWe/saWeGJ0ABKQh5bN1EPBRcIE+xC
 sPOAMuxlvxPgddxvxNdRv4ckhIeFiX14XvHgx5GVwgeVh4M+spX6tEXYcLDO3eUDCqU7
 uGEAqjxRRTqaHmHpY3MngkhcIk5SGZQkBdql44aCVjg2Zhq3EGi+0YRIN324qe1vj7LQ
 oyXI1cSHzjZXZhQ/nmARzDZdtFACkksNFN3hDcSx40KKNaeRQv/uuPyeyItv71OnAFh7
 1QCdnrvC44RbKVzla681PlbI1I4C2MyD/qiryx9P7kvE1IoU3yxn0k1Zjv5+PaN8VQFX
 4gMA==
X-Gm-Message-State: AOJu0Yzb8YtSUSqEHCaNzVSX76kMLR/wwYd+hb3lLiw5Fejt2KdUl2+2
 AW7BmGo5ndlhs4I822baTS97TjoIQTRq+BHxR+8c8Li6VzHWWnRFNFZKkQWSEsMA3f7/8U38Fvm
 Sc5A=
X-Google-Smtp-Source: AGHT+IG0y8L0mGnPrFKMTIUU0M1hBiRNav6XsB7ffIMx0E+AmGpLpKoEjlnLiJMwx0BhB6oYf9DiRg==
X-Received: by 2002:a05:6402:159a:b0:568:9fc9:ec72 with SMTP id
 ij26-20020a056402159a00b005689fc9ec72mr3999872edb.35.1711036249579; 
 Thu, 21 Mar 2024 08:50:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056402028900b00568d4cf3288sm17978edv.7.2024.03.21.08.50.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 17/21] target/xtensa: Prefix MMU API with 'xtensa_'
Date: Thu, 21 Mar 2024 16:48:33 +0100
Message-ID: <20240321154838.95771-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

In order to extract the MMU API to a new "mmu.h" header,
prefix it with the target name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.h        |  4 ++--
 target/xtensa/cpu.c        |  2 +-
 target/xtensa/mmu_helper.c | 41 +++++++++++++++++++++-----------------
 target/xtensa/monitor.c    |  2 +-
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 6b8d0636d2..b2cfc78e9d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -692,8 +692,8 @@ static inline int xtensa_get_cring(const CPUXtensaState *env)
 int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
         uint32_t vaddr, int is_write, int mmu_idx,
         uint32_t *paddr, uint32_t *page_size, unsigned *access);
-void reset_mmu(CPUXtensaState *env);
-void dump_mmu(CPUXtensaState *env);
+void xtensa_reset_mmu(CPUXtensaState *env);
+void xtensa_dump_mmu(CPUXtensaState *env);
 
 static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 875cf843c9..ae0c4aab24 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -130,7 +130,7 @@ static void xtensa_cpu_reset_hold(Object *obj)
     env->exclusive_addr = -1;
 
 #ifndef CONFIG_USER_ONLY
-    reset_mmu(env);
+    xtensa_reset_mmu(env);
     cs->halted = env->runstall;
 #endif
     set_no_signaling_nans(!dfpu, &env->fp_status);
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 47063b0a57..31ee3fa957 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -139,7 +139,8 @@ static uint32_t xtensa_tlb_get_addr_mask(const CPUXtensaState *env,
  * Get bit mask for the 'VPN without index' field.
  * See ISA, 4.6.5.6, data format for RxTLB0
  */
-static uint32_t get_vpn_mask(const CPUXtensaState *env, bool dtlb, uint32_t way)
+static uint32_t xtensa_get_vpn_mask(const CPUXtensaState *env, bool dtlb,
+                                    uint32_t way)
 {
     if (way < 4) {
         bool is32 = (dtlb ?
@@ -168,9 +169,10 @@ static uint32_t get_vpn_mask(const CPUXtensaState *env, bool dtlb, uint32_t way)
  * Split virtual address into VPN (with index) and entry index
  * for the given TLB way
  */
-static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
-                                     bool dtlb, uint32_t *vpn,
-                                     uint32_t wi, uint32_t *ei)
+static void xtensa_split_tlb_entry_spec_way(const CPUXtensaState *env,
+                                            uint32_t v,
+                                            bool dtlb, uint32_t *vpn,
+                                            uint32_t wi, uint32_t *ei)
 {
     bool varway56 = dtlb ?
         env->config->dtlb.varway56 :
@@ -224,13 +226,15 @@ static void split_tlb_entry_spec_way(const CPUXtensaState *env, uint32_t v,
  * Split TLB address into TLB way, entry index and VPN (with index).
  * See ISA, 4.6.5.5 - 4.6.5.8 for the TLB addressing format
  */
-static bool split_tlb_entry_spec(CPUXtensaState *env, uint32_t v, bool dtlb,
-                                 uint32_t *vpn, uint32_t *wi, uint32_t *ei)
+static bool xtensa_split_tlb_entry_spec(CPUXtensaState *env,
+                                        uint32_t v, bool dtlb,
+                                        uint32_t *vpn, uint32_t *wi,
+                                        uint32_t *ei)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         *wi = v & (dtlb ? 0xf : 0x7);
         if (*wi < (dtlb ? env->config->dtlb.nways : env->config->itlb.nways)) {
-            split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
+            xtensa_split_tlb_entry_spec_way(env, v, dtlb, vpn, *wi, ei);
             return true;
         } else {
             return false;
@@ -254,14 +258,14 @@ static xtensa_tlb_entry *xtensa_tlb_get_entry(CPUXtensaState *env, bool dtlb,
         env->itlb[wi] + ei;
 }
 
-static xtensa_tlb_entry *get_tlb_entry(CPUXtensaState *env,
+static xtensa_tlb_entry *xtensa_get_tlb_entry(CPUXtensaState *env,
         uint32_t v, bool dtlb, uint32_t *pwi)
 {
     uint32_t vpn;
     uint32_t wi;
     uint32_t ei;
 
-    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+    if (xtensa_split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
         if (pwi) {
             *pwi = wi;
         }
@@ -405,7 +409,7 @@ static void reset_tlb_region_way0(CPUXtensaState *env,
     }
 }
 
-void reset_mmu(CPUXtensaState *env)
+void xtensa_reset_mmu(CPUXtensaState *env)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         env->sregs[RASID] = 0x04030201;
@@ -470,7 +474,7 @@ static int xtensa_tlb_lookup(const CPUXtensaState *env,
     for (wi = 0; wi < tlb->nways; ++wi) {
         uint32_t vpn;
         uint32_t ei;
-        split_tlb_entry_spec_way(env, addr, dtlb, &vpn, wi, &ei);
+        xtensa_split_tlb_entry_spec_way(env, addr, dtlb, &vpn, wi, &ei);
         if (entry[wi][ei].vaddr == vpn && entry[wi][ei].asid) {
             unsigned ring = get_ring(env, entry[wi][ei].asid);
             if (ring < 4) {
@@ -493,10 +497,11 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
-        const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
+        const xtensa_tlb_entry *entry = xtensa_get_tlb_entry(env, v, dtlb, &wi);
 
         if (entry) {
-            return (entry->vaddr & get_vpn_mask(env, dtlb, wi)) | entry->asid;
+            return (entry->vaddr & xtensa_get_vpn_mask(env, dtlb, wi))
+                   | entry->asid;
         } else {
             return 0;
         }
@@ -507,7 +512,7 @@ uint32_t HELPER(rtlb0)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 
 uint32_t HELPER(rtlb1)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 {
-    const xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, NULL);
+    const xtensa_tlb_entry *entry = xtensa_get_tlb_entry(env, v, dtlb, NULL);
 
     if (entry) {
         return entry->paddr | entry->attr;
@@ -520,7 +525,7 @@ void HELPER(itlb)(CPUXtensaState *env, uint32_t v, uint32_t dtlb)
 {
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_MMU)) {
         uint32_t wi;
-        xtensa_tlb_entry *entry = get_tlb_entry(env, v, dtlb, &wi);
+        xtensa_tlb_entry *entry = xtensa_get_tlb_entry(env, v, dtlb, &wi);
         if (entry && entry->variable && entry->asid) {
             tlb_flush_page(env_cpu(env), entry->vaddr);
             entry->asid = 0;
@@ -559,7 +564,7 @@ void HELPER(wtlb)(CPUXtensaState *env, uint32_t p, uint32_t v, uint32_t dtlb)
     uint32_t vpn;
     uint32_t wi;
     uint32_t ei;
-    if (split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
+    if (xtensa_split_tlb_entry_spec(env, v, dtlb, &vpn, &wi, &ei)) {
         xtensa_tlb_set_entry(env, dtlb, wi, ei, vpn, p);
     }
 }
@@ -818,7 +823,7 @@ static int get_physical_addr_mmu(CPUXtensaState *env, bool update_tlb,
         may_lookup_pt && get_pte(env, vaddr, &pte)) {
         ring = (pte >> 4) & 0x3;
         wi = 0;
-        split_tlb_entry_spec_way(env, vaddr, dtlb, &vpn, wi, &ei);
+        xtensa_split_tlb_entry_spec_way(env, vaddr, dtlb, &vpn, wi, &ei);
 
         if (update_tlb) {
             wi = ++env->autorefill_idx & 0x3;
@@ -1192,7 +1197,7 @@ static void dump_mpu(CPUXtensaState *env,
     }
 }
 
-void dump_mmu(CPUXtensaState *env)
+void xtensa_dump_mmu(CPUXtensaState *env)
 {
     if (xtensa_option_bits_enabled(env->config,
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index fbf60d5553..ce1b791a5c 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -35,5 +35,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(env1);
+    xtensa_dump_mmu(env1);
 }
-- 
2.41.0


