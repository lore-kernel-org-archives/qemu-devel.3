Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6BACDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNt0-0003ZS-SS; Wed, 24 Jun 2026 09:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsu-00034E-5a; Wed, 24 Jun 2026 09:43:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNss-00022d-MQ; Wed, 24 Jun 2026 09:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308007; bh=PHq0ridNjf1XruU6OjfEWU58yBhDM9HHaSZ10WkIeSU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RwxxOeRqym5nAqwj30S5eLZK6sn4PkEujDhi8iOEELbi0+y2Ev7F7KyyajAwouLE6
 nknXV9fUxvKv90zUvXZZQ70wb3gAXcYHPGC3ngROkNrE1sdJB08MshiPQlqewrNJ7d
 EOmR/F42HK6+kGigw8LbH70R2G3Znmv+TPQ7Cqs6iynKAvf9wpEO3/6h0WWnI/YKS/
 DXRnLR2lrxjRezhUUFKggzIm0nmTUhXFzT2qWrBj/jxsEaenOU1wHgrASlzjMKGzXF
 JU5X1vv012N8tYEDKAeSuDr5vG7BqA+0OnrjebaTlbAmlWVmLthEGTu1F4B2veVS7J
 AFUUtnTmHyQdw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 264F51BAA17;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B63353DEA66;
 Wed, 24 Jun 2026 16:33:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Scott J. Goldman" <scottjgo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 101/107] target/arm/hvf: Stop pre-allocating
 cpreg_vmstate arrays
Date: Wed, 24 Jun 2026 16:31:46 +0300
Message-ID: <20260624133301.403266-101-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Scott J. Goldman" <scottjgo@gmail.com>

Commit ab2ddc7b66 ("target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC
for cpreg arrays") moved cpreg_vmstate_indexes / cpreg_vmstate_values
to be allocated by VMSTATE_VARRAY_INT32_ALLOC and added an assertion
in cpu_pre_load() that they are NULL on entry. The same commit dropped
the redundant g_renew()/array_len assignments from the kvm, whpx and
helper.c cpu init paths, but the hvf cpu init path still pre-allocates
them.

The result is that loading a snapshot or migration stream into an HVF
guest immediately aborts:

    ERROR:target/arm/machine.c:1043:cpu_pre_load:
        assertion failed: (!cpu->cpreg_vmstate_indexes)

Drop the leftover cpreg_vmstate_indexes / cpreg_vmstate_values
allocations and the cpreg_vmstate_array_len assignment from
hvf_arch_init_vcpu(), matching what was already done for the other
arm accelerators.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 06fd39e426bbd3a68e50fc847892e7448174ce2f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5016783062..d8bc85f279 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1288,12 +1288,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                                      sregs_match_len);
     arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
                                     sregs_match_len);
-    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
-                                             arm_cpu->cpreg_vmstate_indexes,
-                                             sregs_match_len);
-    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
-                                            arm_cpu->cpreg_vmstate_values,
-                                            sregs_match_len);
 
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
@@ -1330,7 +1324,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
     arm_cpu->cpreg_array_len = sregs_cnt;
-    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
     /* cpreg tuples must be in strictly ascending order */
     qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u64);
-- 
2.47.3


