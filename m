Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9D4C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VS-0001Wa-EX; Mon, 17 Aug 2026 14:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VR-0001WO-Jh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VQ-000659-1O
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:21 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVQri2173662; Mon, 17 Aug 2026 18:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YWONUb8LHD+X+enpt
 rMDKnLvNdmA1LQ4pKulQb3SgyI=; b=FIbd2DZ+KbSnk5Wp5m4HoheKdLwv8pAuK
 5x3JhzqO9k/2bx7dJ9Je4THnuQ4sKzDzL6dRgys9UtnXEGjM4vgePkZoWCjwpDtC
 yDKoSeUqQgH/0OWHNvemhKEY9bq6kikW3cCRs+I9jS/3QRdQutIagI+nDAiF7CSr
 7FU23VAbN+pkuudvdGX26rvrRD+hMq/2o0AgZjorP3z61KUezCp0+wUw6ingWXYO
 A/q6YmaQD4tR/hkVUZdpj7jZQblJCKo0tgoB+NhizDSKQ2lcOvi7sTCmrG0gv01L
 YadMsXyMXFCn8racMET2+yFoED9mLGVCw0Hgke4twRqShUtGYM+Qg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4kvqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfIKi004521;
 Mon, 17 Aug 2026 18:56:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epyf6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HIu7BR37683648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:56:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71ACC20043;
 Mon, 17 Aug 2026 18:56:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97B5F20040;
 Mon, 17 Aug 2026 18:56:04 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:56:04 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 07/10] tests/qtest/libquos/pci: Add migration fixup helper
 for pci devices
Date: Tue, 18 Aug 2026 00:25:37 +0530
Message-ID: <20260817185539.376740-8-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: JSkAzvCPnMEnlHPFFwwlM-uBbFrKvUNd
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a83594c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=z4glEzOvAAAA:8
 a=V4iHYd2UAC7gJwQCrJwA:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfXwDr0ceFPIInW
 xqjWSkhAqzIyJQ8UL5BLuM5eKVtVJ6XExPFS2WwKMo+QfXe+R17AExs+zMOWvkfJJnA+VgjfWsg
 xOr2WEQDvr4JtaELdZbLgJos25NkNJU=
X-Proofpoint-ORIG-GUID: gGSA9LIt0VvNZ8i_sUVXuK5dojzWQsLx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX+eKyfz3q7y2N
 Sv6/1qV9SB9k/+iD8QzRvFjQEgFLKTGM9yUWA7ca3njeQte5y6oNO9NIZ7TzqGLNS7maMmMeXmb
 zuZJ+4snIdkDIklAIYlEtsIBzbZUZzjL8Hi327TzswB+eDAfxToDpk07FiTbLT1JkYRJLcHB4f/
 BaohkD/eOqnMSpvJxFXWRPcHYJJ/RQ1yJFxmVSSx/ufIfABuraKv9UZ/WQR3UKVe5MYiSRTKeYX
 F5Tnl/M2NRIK1EMmlw/PvHXnIo5q7IZXaYcKX6i1tpu5nbEcYEUOzjuq3geZ4pV4zp5wiG8s2Qf
 bp164rfjFtPF3DUpBvSAs2Kl4hruYIDpOU/a2seX1pwOn7u8z0dBG5OlCZaezvEP69ukfG6xFp6
 s8H202N+xqZiMT/NXm7nOdKK9C4AnU+HHmvAUsWifeATKzaPtU94xRJxEFL+4jyUcFUsXb1/6/w
 1D89cnQcHXepu/ZXnfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170142
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Migration tests can create new QPCI devices for the destination
machine which may need to take on some state of the source machine
after destination is complete.

Add a migration fixup helper and call it from ahci migration tests.
This is currently a noop and will be used subsequently.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/ahci-test.c  | 1 +
 tests/qtest/libqos/pci.c | 4 ++++
 tests/qtest/libqos/pci.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 43b5a38b..1c45d5f3 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -137,6 +137,7 @@ static void ahci_migrate(AHCIQState *from, AHCIQState *to, const char *uri)
     memcpy(to, from, sizeof(AHCIQState));
     to->parent = tmp;
     to->dev = dev;
+    qpci_migrate_fixup(to->dev, from->dev);
 
     tmp = from->parent;
     dev = from->dev;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 76b13ade..cda3c56c 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -625,6 +625,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
     return bar;
 }
 
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
+{
+}
+
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
 {
     g_assert(addr);
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index ef40a691..19f1dd13 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -120,6 +120,7 @@ void qpci_memwrite(QPCIDevice *bus, QPCIBar token, uint64_t off,
                    const void *buf, size_t len);
 QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
 void qpci_unplug_acpi_device_test(QTestState *qs, const char *id, uint8_t slot);
-- 
2.55.0


