Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62D7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCb2-0000n7-Ni; Wed, 12 Aug 2026 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCa1-0000D4-Nc; Wed, 12 Aug 2026 13:17:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZw-0000sE-4Y; Wed, 12 Aug 2026 13:17:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1edT3994427; Wed, 12 Aug 2026 17:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ADIKM5DZN6RQjOVun
 8HuFP5MmkgrDtqqGtx9FiosaVg=; b=gQF2c3kSiaSs4+hPIOla4ERqHoJlOzxFX
 cH5wN/rbU9qVIHtsOTBde7Dx77dE7ba7usKy5eU4vyLnWnhiJ8hqfxSpS2glJhfd
 LVwqvi+4UJHV+vDAoGclvLos4exV37O2slZhMrgkYh5LrQ4zvs1iyDsoByVX7K7H
 EFocFLMAgkPGBs1VVYSNz9743QL+63sQ/f7dfRAjsmSxk8twl/UicPpJiuzIa5L+
 Labnaz0LukyHVN0V/UpbD3GfPXzDSKVNFx/JXJ0lRiP/o7qktacq99Qct8BcNDMi
 7HM21NwyB38ycGdgSSO5M6lOdTrC+aq+gIX2KKdRZXTn6cn5f5xPA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32vpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBG5j017015;
 Wed, 12 Aug 2026 17:17:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq79yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHKAP19202696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A8D958051;
 Wed, 12 Aug 2026 17:17:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B1A85805A;
 Wed, 12 Aug 2026 17:17:19 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:19 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PULL 13/15] target/s390x: Allow 2G hugepages guest backing
Date: Wed, 12 Aug 2026 13:17:05 -0400
Message-ID: <20260812171707.1605637-14-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7caaa2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PXhQOlaz77BmCqgndx4A:9
X-Proofpoint-GUID: RaoSlZj-0Npc9_Ows0VQjTUY58d_Vhmq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX1DcXcKV75aBa
 xi3VXWRyOnjrUW/HbW/WSY2T3VYq0VmmvXCO5aJ2Gd7UaXHCCO/ltW/VLOc1wnZfC6nEGtyTzLB
 7/Ha9K3Bcb4E84womGL/RLOgmjZCTBEbcVp0A1kDHFj9TVaUV0vEnjuUhPDy9q3HWz6Hl4yEHn9
 GXlnA5VP/U1X2YYESku5rvsgaoZjV5r8A5nFyLRudVjUcg8/KwPVcywIDQZrow+KMf29Rmnq2Hi
 jMhSZKUyIY+iYl2RgGqQTJ4vJGwSGYseolcyy+EwTu3OYoap8yXi5jxWSICAz6YENrZ86qY3Jx1
 rWpW6IWZOgOQG7OECUrTM0Ig+REVJeAFiA9zGrRaH7cvS/mYuaplP7WcSviL6yDeLBG1TEAbsa5
 R+khvIAQXAqL/B4xRxQLFLYo4g0CR64Lr1WQTk+mUiZxp8Iu2EH8FLja5KUA2vgOtN2UyWNwSY+
 Ms4viugmcGoJGnH+kdg==
X-Proofpoint-ORIG-GUID: RaoSlZj-0Npc9_Ows0VQjTUY58d_Vhmq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX0imanhOGYfKd
 Z/ujzRAHcPxQWl5MxCV5B18+Cg4mtLgw96emZx2qJVUSqPTnjdFCO3sQzPKcusD4V90WWnpiVKq
 nIZx2V3TKXRm+iniqzRI0cGg8SUN4FY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Allow mapping guest with 2G hugepages on hosts that support it.

Rename kvm_s390_get_hpage_1m() to kvm_s390_get_hpage() to reflect that
it is not anymore limited only to 1m hpages.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260805103728.97602-2-imbrenda@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/diag.c          |  2 +-
 target/s390x/kvm/kvm.c       | 36 +++++++++++++++++-------------------
 target/s390x/kvm/kvm_s390x.h |  2 +-
 target/s390x/kvm/stubs.c     |  2 +-
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 80f0958478..46d191b87d 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -185,7 +185,7 @@ out:
             return false;
         }
 
-        if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
+        if (kvm_enabled() && kvm_s390_get_hpage()) {
             error_report("Protected VMs can currently not be backed with "
                          "huge pages");
             env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 72031a5714..803b878b4f 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -145,7 +145,7 @@ static int cap_mem_op;
 static int cap_mem_op_extension;
 static int cap_s390_irq;
 static int cap_ri;
-static int cap_hpage_1m;
+static int cap_hpage;
 static int cap_vcpu_resets;
 static int cap_protected;
 static int cap_zpci_op;
@@ -231,7 +231,7 @@ static void kvm_s390_enable_cmma(void)
         .attr = KVM_S390_VM_MEM_ENABLE_CMMA,
     };
 
-    if (cap_hpage_1m) {
+    if (cap_hpage) {
         warn_report("CMM will not be enabled because it is not "
                     "compatible with huge memory backings.");
         return;
@@ -292,30 +292,28 @@ void kvm_s390_crypto_reset(void)
     }
 }
 
-void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+static bool kvm_s390_pgsize_cap(uint32_t capa, const char *s, Error **errp)
 {
-    if (pagesize == 4 * KiB) {
-        return;
-    }
-
-    if (pagesize != 1 * MiB) {
-        error_setg(errp, "Memory backing with 2G pages was specified, "
-                   "but KVM does not support this memory backing");
-        return;
+    if (kvm_vm_enable_cap(kvm_state, capa, 0)) {
+        error_setg(errp, "Memory backing with %s pages was specified, "
+                   "but KVM does not support this memory backing", s);
+        return false;
     }
+    return true;
+}
 
-    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
-        error_setg(errp, "Memory backing with 1M pages was specified, "
-                   "but KVM does not support this memory backing");
-        return;
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+{
+    if (pagesize == MiB) {
+        cap_hpage = kvm_s390_pgsize_cap(KVM_CAP_S390_HPAGE_1M, "1M", errp);
+    } else if (pagesize != 4 * KiB) {
+        cap_hpage = 2 * kvm_s390_pgsize_cap(KVM_CAP_S390_HPAGE_2G, "2G", errp);
     }
-
-    cap_hpage_1m = 1;
 }
 
-int kvm_s390_get_hpage_1m(void)
+int kvm_s390_get_hpage(void)
 {
-    return cap_hpage_1m;
+    return cap_hpage;
 }
 
 static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 7b1cce3e60..3c4fa0489c 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -25,7 +25,7 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
-int kvm_s390_get_hpage_1m(void);
+int kvm_s390_get_hpage(void);
 int kvm_s390_get_protected_dump(void);
 int kvm_s390_get_ri(void);
 int kvm_s390_get_zpci_op(void);
diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 196127baa5..ebf3c83994 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -143,7 +143,7 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
     g_assert_not_reached();
 }
 
-int kvm_s390_get_hpage_1m(void)
+int kvm_s390_get_hpage(void)
 {
     g_assert_not_reached();
 }
-- 
2.55.0


