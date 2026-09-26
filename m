Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53373C9832A
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAcG0-0006Wm-GS; Sat, 26 Sep 2026 19:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFs-0006Vd-FW
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:32 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAcFp-0004OL-75
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 19:56:30 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso1179544a91.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790466987; x=1791071787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0gz45yMIIVliy3SWUWlZVaKuMixUM+jElZ8dLueySp0=;
 b=EYdm+biwFbhsxClvL5NauDoTJUPei8OnDnWtuu97hefjmTgaDEvzJJRPc7HRNtwCxF
 CfpO6xXtmUTaxhJasDz5iGOXyjUWUwuz7n76Q6VZQOKlW1UgTrtm20VyzlgR5scTid1C
 a9s2ejtTvGmz83AmnRjdz5t5Td+SPnYoVp+JtN37XBRecyRYxFi3iOEgiOWz+Tg/6VDl
 zP7m5NlbBxuNCl0PL2F+yb2lZDbwEYcD12aBSUHOvpLr1peIXcwCYdzRTxoM95ucc9gz
 0U5OHkfp04Gl7JPYq9XMDfGm0+j7mmZet6JvZrntvrsbgBNB/gCYEcId0loo5fnjvP4X
 O6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790466987; x=1791071787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0gz45yMIIVliy3SWUWlZVaKuMixUM+jElZ8dLueySp0=;
 b=l3EL6mAC0/veZCsR5r5F8lofpcr+cdvIoyR5bf6qLRBjZ2qC440f1zXhjJPipr3HEa
 u+e6XH0UiUdAVtovqcGYX3Jv5f/JeP8WnIySJAKYZpVJdCZJX9Gt8Dxyx5QGJzg1oQw0
 vUk503hBIskOU+O8e43TIydA4bOt6c4/qU91tOMFOX1htdN5tTjcLxKpLDj7PZ84evor
 kWCLHINnIP7Hxb/zTbth4MT9vsrX9QWKTRQYhjerSLUHRWH6rNKy/uAWC5BAd61dxGJj
 ZUeM6blpIwbSOTkICY1emU1yqltQAmhTpfgz/cIIzuxzxMZCus8hSRcxHg+yYmaSgHIb
 maMA==
X-Gm-Message-State: AFq9FYJycm4mdve7b0P9yteL5L/675fkYqYRINT4n8bthkv2tzhHy+yu
 gitL1k/DczRco00TJt0JW86fDOPXRCzA+odNZ0dXpiuHBbjFLigq91jJy8a5QYWKeyCOLNuIUWA
 +XgGO
X-Gm-Gg: AYBFou3RfojEZLunCCfPDHBj9mMJ6V4fFM635PupCJUhrAMV6kFcrVBXBZEufSHbf52
 2xK+vuL47BuXAAXE5EYwe6RgHtLyX3XJe9Zhe0K5fU8dAO4IDtdTnKQJpjep8uAyQMZW8CX/eK3
 vAkYiMvwb27W+GiW6vqC1Gqs6qzl4wantb3HGnkYijSQnzXf8amQZLPBP0uTDk0m68SV1RyAtI2
 IT0i3lPLJdHPp3E2tG81llYYVMM4n9FEMEHKLdnWlahXOjRmMOltholwY7ljnZvwl09ZbKMSiz4
 h4rWeCKXgDfzU8CpzrZfpQyKHsC5jrIDztLqIOB0S2BE7g4WbyBt491G0ucMULovsObyHJhndwn
 Z0QMsSP21wQl60hYo0R9KPmDt2syhVZhgzkFMIfPjFwKzsJYZf/LtbOFfeHPsilJV6QUfbHYi9U
 cYSGcgEPsxWWW0SJrSC9FX5VnDuXXvet8beZLoSCpQXozMV6dS/vbeDr3Gs3f2Mn8CYkr+jlcne
 J86Qgrqil9nHv2MCSA3dbuA/1MrlQ==
X-Received: by 2002:a17:90b:49:b0:3a0:9ed5:5420 with SMTP id
 98e67ed59e1d1-3a0bb6139bdmr4296117a91.44.1790466987279; 
 Sat, 26 Sep 2026 16:56:27 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09773e7c3sm18136031a91.17.2026.09.26.16.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 16:56:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: paul@galbraiths.ca,
	pbonzini@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH v4 2/3] target/i386/tcg: fix EIP truncation for wrapping near
 branches
Date: Sat, 26 Sep 2026 16:56:19 -0700
Message-ID: <20260926235620.851099-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926235620.851099-1-richard.henderson@linaro.org>
References: <20260926235620.851099-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A 16-bit near branch that wraps through 0xFFFF must truncate EIP.
TCG skipped this when the target was on the same page, which can
happen when the CS base is not page aligned.

There was an existing test for this further up that attempted to
test this, but was restricted to a 16-bit branch in 32-bit mode,
which can be subsumed.

The previous test for pc being on the same page, rather than eip, is
only relevant to using goto_tb not to eip wrapping.  There is another
test for pc on the same page further down, via translator_use_goto_tb.

Cc: qemu-stable@nongnu.org
Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL")
Reported-by: Paul Galbraith <paul@galbraiths.ca>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a38cc2c15d0..18706ec8a74 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2015,9 +2015,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     if (!CODE64(s)) {
         if (ot == MO_16) {
             mask = 0xffff;
-            if (tb_cflags(s->base.tb) & CF_PCREL && CODE32(s)) {
-                use_goto_tb = false;
-            }
         } else {
             mask = 0xffffffff;
         }
@@ -2025,15 +2022,20 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     new_eip &= mask;
 
     if (tb_cflags(s->base.tb) & CF_PCREL) {
+        assert(s->pc_save_valid);
         tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
-        /*
-         * If we can prove the branch does not leave the page and we have
-         * no extra masking to apply (data16 branch in code32, see above),
-         * then we have also proven that the addition does not wrap.
-         */
-        if (!use_goto_tb || !translator_is_same_page(&s->base, new_pc)) {
-            tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
-            use_goto_tb = false;
+
+        if (mask != -1) {
+            /*
+             * If eip "page" doesn't change, then the addition cannot
+             * leave [0, mask] on any rerun of this TB, which only
+             * ever shifts EIP by whole pages.
+             */
+            target_ulong old_eip = s->pc_save - s->cs_base;
+            if ((old_eip ^ new_eip) & TARGET_PAGE_MASK) {
+                tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
+                use_goto_tb = false;
+            }
         }
     } else if (!CODE64(s)) {
         new_pc = (uint32_t)(new_eip + s->cs_base);
-- 
2.53.0


