Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE79FCA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvjp-0001JH-73; Thu, 08 Oct 2026 17:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveY-0000Mn-LO
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveR-0002pS-82
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5ak01222646; Thu, 8 Oct 2026 21:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KAS07V8uOnJRZoQQD
 NT6BmRaXEIVAEHIT8W5c2IhWOA=; b=D/SvZqVxZdX2XgaW2HMeszcRrQElERtaB
 IT4JhXem/AHYdgRlPVpFiqx6SbZye2ziiOs5umv+cMr/DrYwzKEDwDc06NDoblGo
 TcIiawluARKt41bz06pHBTNdEMzWpyckErEsTsXhquXwfDcEKt7QFCKMqCz5XGO1
 mThh8/lV/icwZ8ql9Hgn0cus4JxUdyAtFZpesbF85FPDj8Ndxg+JA+aYua2V97v6
 19Ttf1FCaZ9Cymd7LP0i5tmP1QjfF8HKShNlG95sL3WYmxiQPdMRARw7rVK0Aa8g
 s4FKbUR7C1fMiNySyoGsnG3mr+krN9IoJ0bfhnIEw6setgLlWTIWw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1e85u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2sGA4039605; Thu, 8 Oct 2026 21:27:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek9f8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRVpP15401560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDED15805C;
 Thu,  8 Oct 2026 21:27:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76F0D58054;
 Thu,  8 Oct 2026 21:27:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL v1 08/10] hw/tpm: crb: Implement tpm_ppi_uninit and use it in
 tpm_crb_unrealize
Date: Thu,  8 Oct 2026 17:27:21 -0400
Message-ID: <20261008212723.3679685-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac80ac4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=NuoSX0e7hVvxVl9fKCIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX9wRkg7uIfr7J
 nz8cfkNnAZ1Wy0CwI3h8hkmvjfcmncrZSr1vdKKAZHht1a2FMm+oEbyPlrAFtlxKxG17rkc3eVJ
 4SQrB80uaDhuIBE3Vp+d5Kgkba1yiKogu1i/c134x8iwHkZz1QJEI0HTGUKVqZPRnI76viLy0MK
 yK+fVvwTX3Hht9JiZUJ0pmfEMTJoVfRcv9XPu02YJj09gasGPaR1uyM+6i1PWkoDWF11rGDeWZX
 x0p2vz+R5BGaN4uZ4az6fdyGZAdfw26mm1Qv0ObJGkuKt2UT+cNiYDpZ/jXp3uUKPTowY0mpUMs
 cMmM/w2tGsC+oK9KIxQqzbDmxRFdp8Bz5p52x7qrG/hdkHbf84Ef7J5QnjOIExq8dgTWR7Uq4T7
 7PAkzNWEAsfFhBKwyO+gTybkEew+MANXNhPMGEvYlOG7EUbETgXD7Fm+tCDcGn1OInHSXQY25U2
 a2tEIjO6UQ4ubz7AO4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX9+SS8QZvcaRQ
 UF5y+786vY3WtooAAptP5YOb16VQWCmyIJ140DVwI0uvNZBXkoPXzN+XWdpfUqbRHIUmpwprjrG
 ceT4FqJgIMW6E4amXwbWO0YRgG1Bux4=
X-Proofpoint-GUID: cT6MpoxgCDmj0WMEJvM-3jGlkvrlDeEW
X-Proofpoint-ORIG-GUID: cT6MpoxgCDmj0WMEJvM-3jGlkvrlDeEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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

Implement tpm_ppi_uninit and use it for proper teardown of the PPI in
tpm_crb_unrealize.

Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-9-stefanb@linux.ibm.com
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


