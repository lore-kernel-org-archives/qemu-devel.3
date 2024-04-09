Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAFACD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 17:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFeP-0006Wq-2f; Tue, 09 Apr 2024 13:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ruFeN-0006WP-Ug
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:52:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ruFeL-0003qS-8V
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 13:52:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so3609586b3a.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712685167; x=1713289967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w5C88C2zkVTCDsq5yvLZn9iz9/gb+e827a995NHxivs=;
 b=kuexNo1IqHLATbeP+k+konhfv2fOL6oDvuNe5V7ETvKM8v1F7BUM2YEv7Dtbx4/Msl
 QcuhFr4MZ8gxC6FbZoQNMlqXlBoQmKsjYioBBapXUjtvLo/QnNNsjSydOHg45JTPY2ch
 IoV3FncZ43gQaN+X5FLIl5Cz3bvWpwDEp7O+z4eAj8E3tdu1lArWe1En8lENdcwERzts
 gTuuTORgqK13qvZhLkdEzOQpWimIpbmCW3mbWGlaeRvoFYRPdT8OnDUumwchY/J+RRWz
 n33qdGdIhsOLcZ5dDw4uvs+2QOlG+GOc0Yak/qoRid1POvx7X9C3Ij6PLxgGk9Sp6pvk
 OPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685167; x=1713289967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5C88C2zkVTCDsq5yvLZn9iz9/gb+e827a995NHxivs=;
 b=n/1uFM5TAUP8uB2bF4CUg4aftovASUgMfQoFmFvIXucjgRdQGYFUzFZVjiY6smLaJy
 lwklMXO9+nVVXA7EuMamHo1t7zz4ruf/gpk6QMHvvIQVG8uRSJNbmHRgGTtip5Re5Iof
 jerZMB6IKZGOpJRDzchwSWVqzcwSCLjhJj8OTxl06H/+UdyaG/D6c/ihr21EYf240vPS
 gyFmTrA6HrRlMBNWWdC2TrjuIc7w8SIr++BNZQ7nBqhYkGYgck+sqn+G3iwbJTk8TWhQ
 8GoaiYMucKZ7DUYweBbkZzq5PIdxanfqj0lnvuMEmEyezbYsw+hsATR2GJTfQlEbutVp
 o6bA==
X-Gm-Message-State: AOJu0Yw1Jn8GGKIb5oeZ6hYySDNqi3bYiAVnxdz9E+hXYn336Odsx9NF
 PlQW1zBB+/CZztPvu+QhRp6Iww6g6qgay8ugg/eP7oSRZtUqY6yhgUDvU872eY9I+oq5fkMUsPL
 6
X-Google-Smtp-Source: AGHT+IHwuSNaqeH1q6CtQim8AiHIoUSeUhX7xzYyb3eJnWiw6hRzEOKBpPQYCcutsyS6FOjG/XLUcw==
X-Received: by 2002:a05:6a20:d80d:b0:1a5:6be8:2d70 with SMTP id
 iv13-20020a056a20d80d00b001a56be82d70mr538654pzb.21.1712685167381; 
 Tue, 09 Apr 2024 10:52:47 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 e11-20020aa7980b000000b006ece5ad143esm8598340pfl.127.2024.04.09.10.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 10:52:47 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 alexei.filippov@syntacore.com, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joseph Chan <jchan@ventanamicro.com>
Subject: [PATCH for-9.0] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Date: Tue,  9 Apr 2024 14:52:41 -0300
Message-ID: <20240409175241.1297072-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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

raise_mmu_exception(), as is today, is prioritizing guest page faults by
checking first if virt_enabled && !first_stage, and then considering the
regular inst/load/store faults.

There's no mention in the spec about guest page fault being a higher
priority that PMP faults. In fact, privileged spec section 3.7.1 says:

"Attempting to fetch an instruction from a PMP region that does not have
execute permissions raises an instruction access-fault exception.
Attempting to execute a load or load-reserved instruction which accesses
a physical address within a PMP region without read permissions raises a
load access-fault exception. Attempting to execute a store,
store-conditional, or AMO instruction which accesses a physical address
within a PMP region without write permissions raises a store
access-fault exception."

So, in fact, we're doing it wrong - PMP faults should always be thrown,
regardless of also being a first or second stage fault.

The way riscv_cpu_tlb_fill() and get_physical_address() work is
adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
reflected in the 'pmp_violation' flag. What we need is to change
raise_mmu_exception() to prioritize it.

Reported-by: Joseph Chan <jchan@ventanamicro.com>
Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU translation stage")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fc090d729a..e3a7797d00 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1176,28 +1176,30 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
     switch (access_type) {
     case MMU_INST_FETCH:
-        if (env->virt_enabled && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
+        } else if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
         }
         break;
     case MMU_DATA_LOAD:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_LOAD_PAGE_FAULT;
         }
         break;
     case MMU_DATA_STORE:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
-                RISCV_EXCP_STORE_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
         }
         break;
     default:
-- 
2.44.0


