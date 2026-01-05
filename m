Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F346BCD041D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 22:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcsx9-000414-48; Mon, 05 Jan 2026 17:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vcswO-0003mO-2P; Mon, 05 Jan 2026 17:20:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vcswL-0002QJ-H1; Mon, 05 Jan 2026 17:20:43 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605D99h6000759;
 Mon, 5 Jan 2026 22:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=y1/+WhwG+nzlaVYrg1SRxWe2ex3o9LplwmqEzGizD
 Tg=; b=PnsrnXkko6+TPMV7hdz9KxrCm7dDDyXaAtUSosv4xYet1NTozlh98OzfA
 VzmJmweX/l0mH0WsHeIyNef488c3GA7SclbKZV2MO4XefLbpYANBmDo5xTXaeHce
 YOZjABEnQ8BGdSMQklmeJezESKhDfzyT1d8yDrau6craZYcxiNbPOpk+bSqTdTHf
 nTnl+k+H9MmMZ4RdgsJdSbz/dd4Olbb9hXQMU9JEj327mkdiDLhn/+PD5vbQNJx5
 MdAr87j/7ofnAJxdxmeeA/mJu/46ptG+AaoKsgfW7earHxfCfaFfGEeJhs3YXNTr
 +aI3Lc9siby8Uo6e2gHLzh6QbJWnw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtgpwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 22:20:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605KmoUD014528;
 Mon, 5 Jan 2026 22:20:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemra58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 22:20:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 605MKXw664291248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 22:20:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B20AA58056;
 Mon,  5 Jan 2026 22:20:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF92B58052;
 Mon,  5 Jan 2026 22:20:32 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.165])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 22:20:32 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com, fam@euphon.net,
 alex@shazbot.org, clg@redhat.com, philmd@linaro.org
Subject: [PATCH v1 1/1] util/vfio-helper: Fix endianess in PCI config
 read/write functions
Date: Mon,  5 Jan 2026 14:20:29 -0800
Message-ID: <20260105222029.2423-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695c3934 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ereiXZdFKGvgvgjS8uQA:9
X-Proofpoint-GUID: a0OdMoIda9pfjtXHVLw42GSIZvb0OMUs
X-Proofpoint-ORIG-GUID: a0OdMoIda9pfjtXHVLw42GSIZvb0OMUs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE5NCBTYWx0ZWRfX53CHQfZniG29
 rp3izzqW9z55ug57xFfoYVyZpmfjLuR4qc2t+3tlAW1z9O+Ul9M0g0I66aWwXD5yHohQNndfa6j
 OZw9f1j07fujv/U/at9iOOdQeiC77MQj0HpFhdmmEf1yDyYevxkFr28X3PJj2RwfM6zqDcqmFOz
 7no/1+PdfbsewZzkNpl+raJFiFz2VVi+wv7a8arPvqv3lDYC18WGXvrL2FiFbd8EsoWieFdUBO6
 8msvM3GKoMWEmZa/NCy3EYkEHnp7RT6UQIdMZaCDRp5E+26RI74U4No+W/X8SfNZgFFVK1vQgf5
 /t3EZbk/45QdhNib3u/yjq0drhZ5QjLOKzuCHIX4g3hysDO+QNyPAxs023gRCJRzqV1VcGNBY1q
 WiS6POJMdodtlY1hsLAiU9kilgPR8ozVEVhxCc9Heho1DJCVscrDGb5i/uFKG98SytxHWK0Z230
 xLOi1pAoItdmeCs0jKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050194
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The VFIO pread/pwrite functions use little-endian data format. Currently, the
qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config() don't correctly
convert from CPU native endian format to little-endian (and vice versa) when
using the pread/pwrite functions. Fix this by limiting read/write to 32 bits
and handling endian conversion in qemu_vfio_pci_read_config() and
qemu_vfio_pci_write_config().

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 util/vfio-helpers.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

v1 -> v2
v1 https://lore.kernel.org/all/20251217184253.1520-1-alifm@linux.ibm.com/
 - Drop Philipe's r-b as code has changed.
 - Do endian conversion in  qemu_vfio_pci_read_config() and
qemu_vfio_pci_write_config().


diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 44b457c442..5a4169d1b1 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -233,31 +233,36 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
     return 0;
 }
 
-static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
+static int qemu_vfio_pci_read_config(QEMUVFIOState *s, uint32_t *buf,
                                      int size, int ofs)
 {
     int ret;
+    uint32_t val_le;
 
     trace_qemu_vfio_pci_read_config(buf, ofs, size,
                                     s->config_region_info.offset,
                                     s->config_region_info.size);
     assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
     ret = RETRY_ON_EINTR(
-        pread(s->device, buf, size, s->config_region_info.offset + ofs)
+        pread(s->device, &val_le, size, s->config_region_info.offset + ofs)
     );
+
+    *buf = le32_to_cpu(val_le);
     return ret == size ? 0 : -errno;
 }
 
-static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int ofs)
+static int qemu_vfio_pci_write_config(QEMUVFIOState *s, uint32_t *buf, int size, int ofs)
 {
     int ret;
+    uint32_t val_le;
 
+    val_le = cpu_to_le32(*buf);
     trace_qemu_vfio_pci_write_config(buf, ofs, size,
                                      s->config_region_info.offset,
                                      s->config_region_info.size);
     assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
     ret = RETRY_ON_EINTR(
-        pwrite(s->device, buf, size, s->config_region_info.offset + ofs)
+        pwrite(s->device, &val_le, size, s->config_region_info.offset + ofs)
     );
     return ret == size ? 0 : -errno;
 }
@@ -296,7 +301,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
 {
     int ret;
     int i;
-    uint16_t pci_cmd;
+    uint32_t pci_cmd;
     struct vfio_group_status group_status = { .argsz = sizeof(group_status) };
     struct vfio_iommu_type1_info *iommu_info = NULL;
     size_t iommu_info_size = sizeof(*iommu_info);
-- 
2.43.0


