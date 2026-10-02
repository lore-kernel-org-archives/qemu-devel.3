Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3D7CA5FE4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCv-0001Ja-C2; Fri, 02 Oct 2026 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCl-0001Do-Fb
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCh-0001nm-90
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZitM628989; Fri, 2 Oct 2026 14:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ejSz+8qsil+oPW+VE
 9qbDsELOhWiD1+FFDWueBABIYk=; b=F8vTe73lbeVSqulvShpT87mWtPUkTYoPo
 FwJcuKbtyFKBRnoIA6evpMr2LGnYbMafkbxIjRg0WvYRjiI9xWMJGQmgzLnHUY+2
 yoSlzRyxWJTjU5BPts2VTOoC+I+yHY8Q+aUSGNjO2YJRAelf/P18JVh8d7CtbUML
 hOF5BFTBsyWM0PrsL4XTT51XhSIN4xeTQknrkRHxtge6aQitZge6B2/VhkXjYKRX
 XMiLHjLibUIPPVtQNH5w/p0pifrU6NMpETDcP/4uz8lLt2fmpPvsjCI36vdmh8KV
 buVJXmRzCISwYWeE497M119idWHt5jgcuGLodiYq74Ut++9zeFIgQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5smkt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHae41296300; Fri, 2 Oct 2026 14:25:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pmjgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPVcq27460126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DB0F5805D;
 Fri,  2 Oct 2026 14:25:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BC725805A;
 Fri,  2 Oct 2026 14:25:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 08/10] hw/tpm: crb: Implement tpm_ppi_uninit and use it in
 tpm_crb_unrealize
Date: Fri,  2 Oct 2026 10:25:14 -0400
Message-ID: <20261002142516.2063735-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX+Hfh3NqOQm6S
 +6q1ztad/agcaJgfys5XNBk401leCDflLWVuOiO1D+28/QduCE7dRy1zul4oJc7NmqVbYazzAEN
 SCqLIUh0N5S5O1ybdVwQYzocgYNHYQ4=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abfbedd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=RjRD9IDzg1SnJ7wAG4QA:9
X-Proofpoint-GUID: mhXUfCZxH-UzRpRP-PDKW84--WDQUeIN
X-Proofpoint-ORIG-GUID: aBcih26-I_Sym-DAVR_md3T2k7_uCumJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX8O4EcxH70YJB
 PBOPtEjU+uqKLYtfkVO/Pq6oOSalOgO5aYkKRcNOqsMhzgY05bzWgs4CLxXsIDTwvH61mUlW2CU
 BGFiTnkuOS/ojZ7YdAX+vySTjbgb1wyKscPkNilORfXMW6Bs56RN7uHtS7d8+TxRqEQdk+oek80
 eQmteVcwI9V4V2CYKa92MMyK/Lc9zVswGwglOPWwzDGtSCfm2n6MkDckPsEHa0SymNMWcS/fPbm
 BSjfrQe9dEg7OdJ7oizkYGVY6Jh41F4Qr11kx9CckbwgJkG9R2P8gkgEjfG1QAFHCXZ7CcGGapN
 1JyRC2FjTzN2BJDK9rpFCV3IRCkP1WyLIKPGz3z/OQ8USNS2yveZ26tB31i4l94JTZywssJexc/
 GyZ4plqXwPzRpj19Bo49ewD/9iAr0YMUYeT0lgoOaK+9XobofM42MNpFv9TQZS7fKZUjjSnxUCF
 9O/kPNhxToaiQo57p+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Implement tpm_ppi_uninit and use it for proper teardown of the PPI in
tpm_crb_unrealize.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c |  3 +++
 hw/tpm/tpm_ppi.c | 10 ++++++++++
 hw/tpm/tpm_ppi.h | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index cd46b2e888..5c50a79936 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -16,6 +16,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qemu/memalign.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -527,6 +528,8 @@ static void tpm_crb_unrealize(DeviceState *dev)
     if (s->migration_blocker) {
         migrate_del_blocker(&s->migration_blocker);
     }
+
+    tpm_ppi_uninit(&s->ppi, get_system_memory(), OBJECT(s));
 }
 
 static void tpm_crb_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index f0c34291dc..35baa083f2 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -57,3 +57,13 @@ void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
 
     memory_region_add_subregion(m, addr, &tpmppi->ram);
 }
+
+void tpm_ppi_uninit(TPMPPI *tpmppi, MemoryRegion *m, Object *obj)
+{
+    memory_region_del_subregion(m, &tpmppi->ram);
+
+    vmstate_unregister_ram(&tpmppi->ram, DEVICE(obj));
+
+    qemu_vfree(tpmppi->buf);
+    tpmppi->buf = NULL;
+}
diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index 88f316ee95..c173889033 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -32,6 +32,16 @@ typedef struct TPMPPI {
 void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
                   hwaddr addr, Object *obj);
 
+/**
+ * tpm_ppi_uninit:
+ * @tpmppi: a TPMPPI
+ * @m: the address-space / MemoryRegion to use
+ * @obj: the owner object
+ *
+ * Function to unregister the TPM PPI region.
+ */
+void tpm_ppi_uninit(TPMPPI *tpmppi, MemoryRegion *m, Object *obj);
+
 /**
  * tpm_ppi_reset:
  * @tpmppi: a TPMPPI
-- 
2.55.0


