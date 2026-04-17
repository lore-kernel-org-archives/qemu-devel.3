Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE45AF436BF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn35-0007N5-Oi; Fri, 17 Apr 2026 13:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2Y-0006pu-Ql
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2S-0002Ad-Uq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so875762f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447091; x=1777051891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shHgd5IXd9ugN2LaWGuic87n3p9WQdk8Kks9qHd+fso=;
 b=nXm9Ixy0uA6jAh8stYQ+34djH/0hWG8FwpRo891E7RRDBiR8eTlM6xgsC6o3Fwn9Pq
 j7Muja+ZPFLo8CnCPiYV4Knt6ENw42dO0NIMDqTF8WbHYa6pVRw0JhlKDXH40147N4Q2
 9jwUxCWcm88nFKAcjKnVQn9Mt4jf4FyXIj8scHM8DGrQeUrAT/sYSk0pfsWtD5eiuvDZ
 880l2LL9O440mrVo8Q4v7JeF8d5YBqriiR8yQztgqloWyQdVJa+EL//z9ozdB/d3RA/U
 fMONGlwJyBB5WgtKiR0HKzlq9gRU2A9oqrL4pDSEAkryjQjor9JZIKkIx06HHHIj+ihs
 R2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447091; x=1777051891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=shHgd5IXd9ugN2LaWGuic87n3p9WQdk8Kks9qHd+fso=;
 b=Mj4XWopU7722eRSczByY2iWcGpnjPkaUwt5izJSbfFsJR33X3LdBnHsmflSn3hdJM7
 08sn1S0wRdLOUapRWOSjbY+b/pFtf56h2oIbaEL0IrdU4wWFNVDzePc9GvPosLv0PqJf
 Vrb0XuSbpe8rn79jjCbKWEg+f0yZj/McPBOG0FIDDA4YvG9786RRwJMor3KTnRMxcjJR
 9BRSmQ52gQveA1yjc+DgH9ZEy3h3450o86sHFGOEHRy4xhh7fb2Bia23FyAM4sg+5mHq
 40WdWWDD5h3k8CJPZB1mhHHniOW81SxG9Eo5WadP0+byHxbFPW0ZxzpHjRiRY3yK6iVb
 zvqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bq22b9nP400L9LpCcNn/Bm31FmnQSOOnh8oc9n8ldim+ipYNLffDz3/HxmOjjh74PQKUC84R8cVtf@nongnu.org
X-Gm-Message-State: AOJu0YzQASnmGZJJpgwctYvZR0/TNJ3HME4s6O/7WymWQRaHgMDhbqGq
 07DWdmv4A0d7nHk1FaXXQrPmSCvtfrP3BOPB7Vfz4KYOHBu1WnGRirIV7kHzgAlbD2I=
X-Gm-Gg: AeBDievQ+MCjOegY7wGrWU2qWUrocu2bhHoEEB4vFZB49Qel37h+m0wYOnyk7Wbc6wu
 jthqLVfD/q2W/yOTCxRRh8LMNkBiswrRGaCnendTJj2D7eNl0jdtIrFHLPnF/VlTj1MOmMaxzfC
 INRXu/lwgDH3A9PV3gYvdylOA76OMwZ0uXzYHuxHW7Wa+IWa5y2OPo50Ri8/fVSO7y/RlrheOuf
 IKiPvTNUovClqH4SIJRjBrmT/DvrqQvSjubycWBicLuiYX22wtPfbLQDfzHm0qbkj2NlhrMn0Jf
 YGsa451gb4tmnTxwam/qTp1GUHNF1rFQPscbtq7Z4J4+9c8dHduladHev9lOZGp6lUG15LV8eGC
 0a/Q1sN+wWhEAVzlzSC3PBStLBSyNuypHb1VV1NRU/+0vTTwjgVbu810Yx0oS0JTBIMmkS7rBc2
 aKLnkxqQKCZMhQut3WGjyqDUTqoztMsfEjNafHsn2bsggKriTYhxu5MVvbD+kbvQ/697YJAlxgS
 B1Lgia3bA79PhTQ4awwTW+RMs4bJ1RxOtXEEe4Wzw==
X-Received: by 2002:a05:6000:1889:b0:43d:7508:c9c6 with SMTP id
 ffacd0b85a97d-43fe3e0b305mr6268752f8f.28.1776447090631; 
 Fri, 17 Apr 2026 10:31:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 11/17] target/arm: Rename arm_cpu_get_phys_page()
Date: Fri, 17 Apr 2026 18:30:59 +0100
Message-ID: <20260417173105.1648172-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The internal helper function arm_cpu_get_phys_page() is named that
way because of its use in the get_phys_page_attrs_debug method.  Now
we've renamed the method, rename the helper to match, since it can
handle non-page-aligned addresses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f5f624c7c3..8be6f243e6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3922,7 +3922,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
                              memop, result, fi);
 }
 
-static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
+static hwaddr arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
                                     MemTxAttrs *attrs, ARMMMUIdx mmu_idx)
 {
     S1Translate ptw = {
@@ -3950,7 +3950,7 @@ hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
-    hwaddr res = arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+    hwaddr res = arm_cpu_get_phys_addr(env, addr, attrs, mmu_idx);
 
     if (res != -1) {
         return res;
@@ -3964,10 +3964,10 @@ hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     switch (mmu_idx) {
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
-        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E10_0);
+        return arm_cpu_get_phys_addr(env, addr, attrs, ARMMMUIdx_E10_0);
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
-        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E20_0);
+        return arm_cpu_get_phys_addr(env, addr, attrs, ARMMMUIdx_E20_0);
     default:
         return -1;
     }
-- 
2.43.0


