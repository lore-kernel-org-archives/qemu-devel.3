Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0FAC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yzu-0006FR-8U; Mon, 07 Sep 2026 09:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3Yzd-0006AB-9I
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3YzY-00050u-OR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:02:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so41908705e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788786151; x=1789390951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xHOpqk1d77YmC+yqfEv/L5VjmCn6NlRjjzjSXGyDKdg=;
 b=rPuM06huWAo/KEz0x+shpOcDwVaifkzXEtQOJv4K1mRQcNJsPFZswAxQkGV/OiDhb/
 0h1+oPRgwYiURgB6OsfVw2KEbvg96+sgyq/KVrl3fmyNUgwO7FekDTL/oI/Dx2pFsW+C
 kkXb3PTb3gt4gtQyDtOukpaSuNnM8N4gEmhk3+lBEh6c3092Dm7P477UlP7KVdE60vFs
 H1mKKp2xoFTLhraxzkCjaJF7bennpQZTq2vyJVhxkUb/pN9comAZTgpcwSPRqhfoHIPx
 66kaxg9zXskhYN7l7AlzYU++1BBbpYkCwi/mu4cglIOWQOz9fVo/CzMjBbghi7c6lnyL
 XDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786151; x=1789390951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xHOpqk1d77YmC+yqfEv/L5VjmCn6NlRjjzjSXGyDKdg=;
 b=nr+HagK2viwvOiIP/VeM4gRU3lApNGkSxM8So5t2hyIMrzjgWhnDAqnI1Lo67z/NIk
 Mu+LV/esNzB/5fMtERo2rnUIuRZ0SIm2RxXE1TLufqhSHmKMCiUz6YwWqA8NfAf6/+Ol
 aTya28e462rat0kVR7JSp8skax/mWS2+O+TBBczcBDhUOP6AIHzGXlxEvPUgSoivWuLL
 s5qsMHY5t9//G3hF647BNn7jhPVxHE7DfMeoUk1r+kmPcSByKahxvBkTUf+UkcG4ueb9
 mQJq+DuDMXHpLOrjwPNfGht3Lnj3jKGWYWbXGIAD6ijbV4j35/V8ZZsCDvu/pUqm7yNv
 N7hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQ9Z6wbUhIKblaexnjC+GAM2Fjy3HVJCl7aMFDoQas3ZIjqdhpnvQk9NsSb6cXseu1dIJ9gFCYz9+O@nongnu.org
X-Gm-Message-State: AFuF++l6TZG96tP3GTpEUwv2tsFt5ZphTe6Xe9/PbWdGMV0IAipX8WBe
 ggeWIH0TaZaMafLWeH/Pd/lFaUPVx0Jg8Vd1mcVkjLeYrf0aTlDlTMQ3EO0Z3YRsY78=
X-Gm-Gg: AYBFou2iIo2fcWBfJQJIQJR89rpcV4vYt9zrM/Pw/vehax8BRNnne23LvPf1I/nw0DJ
 zcpHe1OLC4DKE/CNBxmSY/Sn/qmIUL72FWu5Ma89ToyfIcPTDOLwap9KM/NnUOIxI6l/QgTDE9w
 d3QQokolPjYPo7qi3RB32bND+KnjMLXtQbFwjMhYmHAV0kP6l8TxNq8rC269RCpvdnojfGeZjqL
 tu0K8Dbvio4VEwsQxvktcsH6sqKH/InTRH6CUgrptGXyy3IA4Qtl90Q7m4NZtgPokOIaTc273kV
 MRTrNJ036bj//jQbA0wfiKVRBQQBTlVUjaPvjRkFzL32TMFyiA9qjGOjLnFUZ5DNe4Pq783WvS8
 fZTXZisCI+nCU6psToYuaNEuYxnwm032Pd7+XL6ycOEEJ1UGHk8IYpr8H2DOfzRynNwCtSZ6Qpr
 neeusKaTBdgf50IFmzAhoEnPYRNjBjvhVoYzyS9Fojml42VSM/IHM7qL2hkxmiTJPDKJsUfKV+O
 PmQJPUqaVVgWz9E0tg8d+s4uvnDb54DkRq8xYNzXjwQLzQ4LF0TxfEPqzhT+ZVVeQwOauo2b3lY
 tj5q
X-Received: by 2002:a05:600d:848e:20b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-49cf824f697mr161817485e9.10.1788786151186; 
 Mon, 07 Sep 2026 06:02:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm468589935e9.9.2026.09.07.06.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
Subject: [PATCH 5/8] target/arm: Move ESR_EL1 definition to
 vmsa_pmsa_cp_reginfo
Date: Mon,  7 Sep 2026 14:02:20 +0100
Message-ID: <20260907130223.3148989-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130223.3148989-1-peter.maydell@linaro.org>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Currently we define ESR_EL1 in vmsa_cp_reginfo[], but ESR_EL1 isn't
VMSA specific.  This doesn't matter for "is the register visible when
it should be?", because currently all our AArch64 CPUs are VMSA.  But
it does matter for migration, because the DFSR definition in
vmsa_pmsa_cp_reginfo[] is marked ARM_CP_ALIAS on the assumption that
the migration of cp15.dfsr_ns will be handled by migrating esr_el[1],
which is the same underlying field in the CPU state.

Move ESR_EL1 to vmsa_pmsa_cp_reginfo[]; this will fix the lack of
migration of DFSR for R-profile CPUs.  This is a migration break for
those CPUs, but none of them are used in versioned machine types.

(The S banked DFSR is already migrated, because we register ESR_EL3
in el3_cp_reginfo[] if EL3 exists, regardless of whether we have VMSA
or PMSA.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9d8f09f13b4..e4028e0eba6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2894,6 +2894,14 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
+    { .name = "ESR_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .crn = 5, .crm = 2, .opc1 = 0, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_tvm_trvm,
+      .fgt = FGT_ESR_EL1,
+      .nv2_redirect_offset = 0x138 | NV2_REDIR_NV1,
+      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 2, 0),
+      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 2, 0),
+      .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "DFSR", .cp = 15, .crn = 5, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm, .type = ARM_CP_ALIAS,
       .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.dfsr_s),
@@ -2918,14 +2926,6 @@ static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
 };
 
 static const ARMCPRegInfo vmsa_cp_reginfo[] = {
-    { .name = "ESR_EL1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 3, .crn = 5, .crm = 2, .opc1 = 0, .opc2 = 0,
-      .access = PL1_RW, .accessfn = access_tvm_trvm,
-      .fgt = FGT_ESR_EL1,
-      .nv2_redirect_offset = 0x138 | NV2_REDIR_NV1,
-      .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 5, 2, 0),
-      .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 5, 2, 0),
-      .fieldoffset = offsetof(CPUARMState, cp15.esr_el[1]), .resetvalue = 0, },
     { .name = "TTBR0_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm,
-- 
2.43.0


