Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C537C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DtE-0008Ed-8Q; Wed, 09 Sep 2026 04:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtC-0008EN-RF
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x4DtB-0003IN-Bu
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:42:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d944747d41so61004405ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788943360; x=1789548160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YonI5g7MMuvuxfLeG4auDPo0EnkSd0OHxLNejjnXnho=;
 b=fYr+1foXHyR1S5aVBqcpdxIsWJjyy/uLQEnacmjUXNZ8+SuD9utAifLmD6Fq+wtEpG
 OSHA8s+1dvAi5/QgiCLsuJwZmNDMJ8dOTzpoRRewSTcR9DtfJwgca1HZwtK3m9+1hGv2
 kSNnudwfGhJY+vR9L25v9lbPyhC3wzce4BKzjtMx4lvDCjOipgiZPSrm4klrbhqy7mIk
 8jaIHrHmHEMTblC7TZVNQe3DW7RkLns81WfmHj2qF7GKQt7TNB2eaRJrZ1jGyGLFqm+E
 rPGJA2GtCwZ9fCHD/GAxEOmSUuum96/hfeho4SSE+pnNfkDqdtE17GufV210ynG3nCME
 V7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943360; x=1789548160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YonI5g7MMuvuxfLeG4auDPo0EnkSd0OHxLNejjnXnho=;
 b=Mg8CcinoDbWH63bp3/RN6b8RLRogshWhK+E+0CayFjw1qUyyFlQR7sWFlAVaYy3mjl
 ZaOEI86oajung6dcDwb0dPzCFylHxpH0gYQw2gKfdaSouXiZnc4V7LCY/0zMc5Wr0HQW
 0Z2CzdmGxmn7CzMHjWTxrqLhcyRJi5DrKsV77CxRd12AqZR3n+aEHmWknvM+kW5QOx5E
 B8i1HkcFjppUbC00fkqHW0C/teg2m6Qa42fDXGnnsCXfNxKM30qOcw1rLbdHEHy93AF2
 xPojKqg94qxTXgNY+TURj+E92IrnRYMiaLmAehiI2hlPNdbxGAIenRHj1HDN8neOiQsR
 pwJQ==
X-Gm-Message-State: AFuF++l9N29fZNPgERYShoPqb4tsPrP2mLcfAZVOfcroTuMkGSA92w61
 ritmNovfK+qkn1Py/8FOJ8Bmch/gzyggX6PiTrazJn9QPtmReI0y4Ln2YV/qLex3+qJuJ1Vs3hP
 UYFLNzh0PQ9Gt8YayWdEoccr7+T3iDLQzsgOEyZ1EiGzIRHPI08PeSNjxKFBS4jTVS8rQzmhLQb
 On+WokgNV8U0ee9/+/h9aRprVprHX0O3dLTnTfZNqijw==
X-Gm-Gg: AYBFou2bNhoXPMOkmeEKw9qq7vq2eUlkex5k6oF6O/u42RSi1kCZqR3tZXlIVEVF+yJ
 BvC6y/5Ma3NjgtTnvQDEg0oE3fq/Nc1T2iWeWOeDuK0f1oU64zYPxlA2EemYAJ7alURpPYyab+2
 B4Lwfrf7iJHsL6HUr0wA/0BSUn0oWx9LdB7Ipqh1Sk1hnEEroNAUPJcRHMo5XgxF2qkni///cg3
 x/mpLL/phmH+6h6/icLmmr72qyIK0ecjzF8hA53JEX+ai3WYcwHy7HTBDvp1KljBnFjIG41apek
 p4e5NCRVsAzEbKMnEYowh3kGpNBVRuf1UsqmO+RDJfxQkjTufM/DR3tciOu0awp0+UahO34T4jD
 TY3WsrG3l8IIlvzje4KiQ3/k9DDbjNG6+dBQdwIjwdKRveiteGCFW+vRXp40HvWn263VmkTZc1P
 xL0e+5QsCsosUzb5s+IthGANk5C7wcSa5dhz2nBqek/Fh/8j8g04e6rYVqsUrl4wQlILRARQHUq
 LxjE8X0kzD15dn/oDz4p28CYPvZ1DtA29mB5PNK7CP9XHYxJkdgDRHE2T6PsuHHisIPQS03FA==
X-Received: by 2002:a17:903:2a8c:b0:2d6:f988:398f with SMTP id
 d9443c01a7336-2db1259d1edmr482824065ad.12.1788943359705; 
 Wed, 09 Sep 2026 01:42:39 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db56c2a1f1sm38328225ad.78.2026.09.09.01.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:42:38 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, richard.henderson@linaro.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/6] target/riscv: Match PMP entries lying inside the checked
 range
Date: Wed,  9 Sep 2026 16:41:48 +0800
Message-ID: <20260909084154.223529-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909084154.223529-1-max.chou@sifive.com>
References: <20260909084154.223529-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62f.google.com
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

pmp_hart_has_privs decides the permissions of a byte range by testing
only the two endpoint bytes against each PMP entry. An active entry
lying strictly between the endpoints matches neither byte and is
skipped, so a lower-priority entry silently grants an access that the
higher-priority entry must deny.

Replace the endpoint sampling with interval tests, mirroring the
predicate pmp_get_tlb_size already uses.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/pmp.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8e..94224920d8d 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -299,20 +299,6 @@ void pmp_update_rule_nums(CPURISCVState *env)
     }
 }
 
-static int pmp_is_in_range(CPURISCVState *env, int pmp_index, hwaddr addr)
-{
-    int result = 0;
-
-    if ((addr >= env->pmp_state.addr[pmp_index].sa) &&
-        (addr <= env->pmp_state.addr[pmp_index].ea)) {
-        result = 1;
-    } else {
-        result = 0;
-    }
-
-    return result;
-}
-
 /*
  * Check if the address has required RWX privs when no PMP entry is matched.
  */
@@ -387,8 +373,8 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
 {
     int i = 0;
     int pmp_size = 0;
-    hwaddr s = 0;
-    hwaddr e = 0;
+    hwaddr last = 0;
+    bool size_known = size != 0;
     uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     /* Short cut if no rules */
@@ -414,12 +400,15 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
      * 1.10 draft priv spec states there is an implicit order
      * from low to high
      */
+    last = addr + pmp_size - 1;
+
     for (i = 0; i < pmp_regions; i++) {
-        s = pmp_is_in_range(env, i, addr);
-        e = pmp_is_in_range(env, i, addr + pmp_size - 1);
+        hwaddr sa = env->pmp_state.addr[i].sa;
+        hwaddr ea = env->pmp_state.addr[i].ea;
+        bool contains = (sa <= addr) && (last <= ea);
+        bool overlaps = (addr <= ea) && (sa <= last);
 
-        /* partially inside */
-        if ((s + e) == 1) {
+        if (size_known && overlaps && !contains) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "pmp violation - access is partially inside\n");
             *allowed_privs = 0;
@@ -430,7 +419,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
 
-        if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
+        if (contains && (PMP_AMATCH_OFF != a_field)) {
             /*
              * If the PMP entry is not off and the address is in range,
              * do the priv check
-- 
2.43.0


