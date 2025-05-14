Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10594C3ABCB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 04:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF3T0-0001yI-Rq; Wed, 14 May 2025 00:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uF3Sz-0001v5-Cb
 for qemu-devel@nongnu.org; Wed, 14 May 2025 00:11:37 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uF3Sx-0001j7-9c
 for qemu-devel@nongnu.org; Wed, 14 May 2025 00:11:36 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af51596da56so5589122a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 21:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1747195893; x=1747800693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wN3YlUiAm/cXhzU0srk9qkT9z264xyyEyveTz+GbTJA=;
 b=M6yPX538in0Z4Dqc65a6aEj7L09vPhguqfjeSDrbCICOLmzpY43kxOznfAnzyTD5wp
 h7dDTCgFMA17xef45yNkSBnwr1Vrud+ECctbKTpdZhgEuVimcemYKnOuHEuv+QyV4dua
 hlae9uy8s3T5XndSG/3x6ZuV/5fyRiYc13M6h6Ad84waBO+BwuIo8u04xXLQ3uGHCh2W
 nFmnjfq/bnCyk+UhQGgC0WMMMsrHBaWCEsH7Mfqs1iLS70thyuTEyhTEouCkrSVHSg0a
 wi0X3w7sFIlpSjvRRV8dLGNNLR2EX10gkn7gHPexFz03g1KauqHItuvL1rWir4giyKhU
 VsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747195893; x=1747800693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wN3YlUiAm/cXhzU0srk9qkT9z264xyyEyveTz+GbTJA=;
 b=BtyOO7O1C7KK5l89HTgdVuqqGe+4U9cCp705chqU9y5VAVC5gYGOMOX5cMN8AqSG/Y
 CUfC4zj0rhq+WsMXuftNpF4luJPR79YYaiFrjZkjtLgPwNP+UyShrF+FGWWo+PBoGwQ0
 HymAiXuaJCqXH60v//fAxLeOW+c9KrjpaE2tesyjk6TLWifoglgFp39k2n1Tcc3IUSI7
 duoEYFvDRISx2Q37juB7IRDQGZZc3rYuNq9Z02Bu88XvpaodxZgSSv+YMg/Kh1d+DGyo
 C0qpWrRKdgHbDoJtXry6ZyZLwMCUJGqichfIwSdxB9cC6EJ+hu/L9qbwfc3pRY5g9y1a
 pnSg==
X-Gm-Message-State: AOJu0Yw6wX2gOronWcT9stsaHA3IDWvHMA0Sbm4r9/B5FKNuSrvBHXOs
 BhT9xyYIaN3UOcfNfL9NJvuZEOK0pnwY+3NOQxJl//z4nwExIvCFGGz0lZo4SoncywQty4G8O4V
 Z7t4B/YQUcqDwHXzSf+3gPfjq4iywLAG7p8z81nOKIEonmw217zfOZYA9HaLkELL6MhZYy6JcMV
 jIjsl8i7ImbavhdXbY4zEez0CThFfMwelAoaTfPrNaLA==
X-Gm-Gg: ASbGncvGIKPYoolIXVbe7FmuzCZGynONxftRaoTI7XKpfW6QJaDyDa0sKwVnT2NrfzW
 Mg5Bb99cnBAPQYDXLd7f3M3MPdckULcEOnC17bxu+dcO9NeJAcrdNV28YSwuSuRUtmXP1wQIHbb
 SEi7ROUbLj4xp/RRw8VJiyUW4UWPMRxW45Qbg2N4z0qnACUl8ha2af/TeSiKAat3fE2Eb9yq0Qk
 eHqt6G4FHeShFo+1x8qfhklTBxU0iuttC1JBqzLIM8zOZ2xGmyIw3BsltOBowaXSgFO5CyFgTfA
 IJEz1jMXAXoTINVrjko7kDgvmdAkTKU4q4kjpN0+I4W47c4+hT7f5WVPX0Pkt4HjjfLk050WF2t
 7bQu7XiIlcR9lZQ==
X-Google-Smtp-Source: AGHT+IEp8KcgB4TqXNlmrxHCZxS+26fan2NPyOUD68baPR7U3/AybFUsRdgXVTVVh4DEn98r4MtJHQ==
X-Received: by 2002:a17:90b:5148:b0:2fe:b937:2a51 with SMTP id
 98e67ed59e1d1-30e2e643b39mr3881160a91.33.1747195892562; 
 Tue, 13 May 2025 21:11:32 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e3354b633sm533552a91.49.2025.05.13.21.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:11:32 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Jim Shu <jim.shu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 1/2] target/riscv: Add the implied rule for G extension
Date: Wed, 14 May 2025 12:11:17 +0800
Message-ID: <20250514041118.1614-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x536.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Add the missing implied rule from G to imafd_zicsr_zifencei.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d92874baa0..27edd5af62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2520,6 +2520,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
+    .is_misa = true,
+    .ext = RVG,
+    .implied_misa_exts = RVI | RVM | RVA | RVF | RVD,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+        CPU_CFG_OFFSET(ext_zifencei),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2898,7 +2910,7 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-- 
2.49.0


