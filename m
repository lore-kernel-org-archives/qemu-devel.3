Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F6EC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VP-0001Uy-7A; Mon, 17 Aug 2026 14:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VN-0001Ud-Vu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VM-00064k-II
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVvxh1065735; Mon, 17 Aug 2026 18:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BTUVQXOT81uoPDQy0
 1tS81GKd68E4Vz3FAmIxFgNSIc=; b=GjyGnfnfCerJW/iKTj09vZZIizGXTn5EL
 qPfb4ciCIP+NY48CyF1Ce+h6tNxjdW75xfjz2S51p3WmNfxBDFmVl6VKEXHTd/BO
 X5/VE6+ECWC0HaRn27IH5wy8mT0+2nBU8nx1rdm8nVP7cyo6GiiQBO+gD4v2SRra
 iT+dnWMnYmMnqzhFeHO26S3HRsxDvmus9G43dIsxSEolGhUiLvFFK7qTTmI9AVWX
 trFhi3ZLjLGHLKgsMNQvQJtDJlukZyvOs/aMEbcPkXCjPbIqz2dkooKBMZqLsrn1
 FVnRZ+F1HyL2dsyeAlnjG+Me/Hvf8waakiSjZoQHG0IrA6/P4ZrjA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe3kqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfGiS004507;
 Mon, 17 Aug 2026 18:56:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epyf6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HIu4Y027918892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:56:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3614A20043;
 Mon, 17 Aug 2026 18:56:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0941C20040;
 Mon, 17 Aug 2026 18:56:01 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:56:00 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 06/10] tests/qtest/ahci: don't unmap pci bar if it wasn't
 mapped
Date: Tue, 18 Aug 2026 00:25:36 +0530
Message-ID: <20260817185539.376740-7-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX7rPqheGMMqpa
 iMoRx/oZPsMnTqne3V/B7REraL37bhtWrtOez+DgrfNHRE1yVfzrUD6Z7hKAzzQh0JaiRHG19tN
 Ogvpnyufxb32cwQwkJKF0zjnY8Ren/zCvxRcrT5Bag4LpCwdEtbcevk3EgSGJvQoGSd/nX56Ucf
 7WqQ5C1CETOfoVVgOsfWarQr+AObozPtnE9hCN7wvkf4azU7eoAgxrZ4xRvwbTDqZvIHZdspKDR
 8yPpHL7cK6BCJJJvkphJEUSpYQ1Dl3ay6bCRA8yJdA//SCaTP2xWI4+dD9nW2ZH5oOs0BHoRJLC
 US9xEKgZfBCW62jlO/v/RVTvWhYVXzpbLzNH3vwA8am6OhQ2h/NlGj/bPXhuzWaLBqRIpWoXU7T
 3KJKd7PBkXv7XEI3DfwHOmpOz7h1gunmvG3t8spwVp0+Pim4LwAbzMsRwuRfBCGFBuHxESw29AR
 mPfeX3jEyV59qKKmZuA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a835949 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=a9EiGeD2lGzYqVehPHAA:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-ORIG-GUID: sEThpcjukrQKwuZjNO512-Mca_DWyIgq
X-Proofpoint-GUID: -9WJHnghgt9FvmJJSkJxu7KEkSm0moAH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX0YaM6jZsP7Ot
 CXV2FG8QXf/4nTax6tEZ6U+EOveO3pNLR2k8eaCl5H9c/ARRnogHJbsd1DzcSaH66C9u50ie98y
 Ct44eC83qqv0YX7qVSichj9KZ3NJ+gw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170142
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

ahci-test has a bunch of tests where the pci bar was not mapped. Avoid
unmapping it in these cases, to keep iomaps balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/ahci-test.c   | 3 +++
 tests/qtest/libqos/ahci.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 64bbdd49..43b5a38b 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -85,6 +85,8 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
     uint64_t hba_base;
     AHCICommandHeader cmd;
 
+    g_assert_cmphex(ahci->hba_bar.addr, ==, hba_old);
+
     ahci_fingerprint = qpci_config_readl(ahci->dev, PCI_VENDOR_ID);
     g_assert_cmphex(ahci_fingerprint, ==, ahci->fingerprint);
 
@@ -1421,6 +1423,7 @@ static void test_reset(void)
         ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
         stop_ahci_device(ahci);
         ahci_clean_mem(ahci);
+        start_ahci_device(ahci);
     }
 
     ahci_shutdown(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index f5859c6e..71d19a44 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -224,7 +224,7 @@ void start_ahci_device(AHCIQState *ahci)
 
 void stop_ahci_device(AHCIQState *ahci)
 {
-    /* Unmap AHCI's ABAR */
+    /* Unmap AHCI's ABAR (no-op if not mapped) */
     qpci_iounmap(ahci->dev, ahci->hba_bar);
 }
 
@@ -249,6 +249,7 @@ void ahci_hba_enable(AHCIQState *ahci)
     uint8_t num_cmd_slots;
 
     g_assert(ahci != NULL);
+    g_assert(ahci->hba_bar.mapped);
 
     /* Set GHC.AE to 1 */
     ahci_set(ahci, AHCI_GHC, AHCI_GHC_AE);
-- 
2.55.0


