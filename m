Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA0DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6Fy-0001yP-TK; Mon, 19 Feb 2024 11:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6Fv-0001yA-CE
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:12:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6Fs-0005iO-DM
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:12:35 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdnWz1d5Cz6K66L;
 Tue, 20 Feb 2024 00:08:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 1B367140B54;
 Tue, 20 Feb 2024 00:12:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 16:12:27 +0000
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <richard.henderson@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables entries
 in MMIO during PTW.
Date: Mon, 19 Feb 2024 16:12:29 +0000
Message-ID: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I'm far from confident this handling here is correct. Hence
RFC.  In particular not sure on what locks I should hold for this
to be even moderately safe.

The function already appears to be inconsistent in what it returns
as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
the previous value.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Thanks Peter for reviewing.
 - Handle the address space as in arm_ldq_ptw() - I should have looked
   at the code immediately above :(
   The result ends up a little more convoluted than I'd like. Could factor
   this block of code out perhaps. I'm also not sure on the fault type
   that is appropriate here.
 - Switch to 'need_lock' as per Philippe's feedback on the x86 fixes.
   likely() doesn't seem appropriate here though.
 
target/arm/ptw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5eb3577bcd..ba1a27ca2b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -711,8 +711,68 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     void *host = ptw->out_host;
 
     if (unlikely(!host)) {
-        fi->type = ARMFault_UnsuppAtomicUpdate;
-        return 0;
+        /* Page table in MMIO Memory Region */
+        CPUState *cs = env_cpu(env);
+        MemTxAttrs attrs = {
+            .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
+        };
+        AddressSpace *as = arm_addressspace(cs, attrs);
+        MemTxResult result = MEMTX_OK;
+        bool need_lock = !bql_locked();
+
+        if (need_lock) {
+            bql_lock();
+        }
+        if (ptw->out_be) {
+            cur_val = address_space_ldq_be(as, ptw->out_phys, attrs, &result);
+            if (unlikely(result != MEMTX_OK)) {
+                fi->type = ARMFault_SyncExternalOnWalk;
+                fi->ea = arm_extabort_type(result);
+                if (need_lock) {
+                    bql_unlock();
+                }
+                return old_val;
+            }
+            if (cur_val == old_val) {
+                address_space_stq_be(as, ptw->out_phys, new_val, attrs, &result);
+                if (unlikely(result != MEMTX_OK)) {
+                    fi->type = ARMFault_SyncExternalOnWalk;
+                    fi->ea = arm_extabort_type(result);
+                    if (need_lock) {
+                        bql_unlock();
+                    }
+                    return old_val;
+                }
+                cur_val = new_val;
+            }
+        } else {
+            cur_val = address_space_ldq_le(as, ptw->out_phys, attrs, &result);
+            if (unlikely(result != MEMTX_OK)) {
+                fi->type = ARMFault_SyncExternalOnWalk;
+                fi->ea = arm_extabort_type(result);
+                if (need_lock) {
+                    bql_unlock();
+                }
+                return old_val;
+            }
+            if (cur_val == old_val) {
+                address_space_stq_le(as, ptw->out_phys, new_val, attrs, &result);
+                if (unlikely(result != MEMTX_OK)) {
+                    fi->type = ARMFault_SyncExternalOnWalk;
+                    fi->ea = arm_extabort_type(result);
+                    if (need_lock) {
+                        bql_unlock();
+                    }
+                    return old_val;
+                }
+                cur_val = new_val;
+            }
+        }
+        if (need_lock) {
+            bql_unlock();
+        }
+        return cur_val;
     }
 
     /*
-- 
2.39.2


