Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E89ECD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITgj-0001zC-6w; Thu, 30 Apr 2026 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wITgJ-0001sK-Py
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:52:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wITgI-0004jG-1j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:52:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U3nhT6793693; Thu, 30 Apr 2026 15:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ZJ4beGvkiLwWJgzjW
 nci8oAY86mGpI+ZZqFv1pbTuEg=; b=ooY21lzd03/eDLpwX0lpR+mh+WCderjxh
 FdhLCXlO4OEBEMEh4c2e8w0nsS9nV0wlIzA21TUs6dYd974y4u/DZxT5Y6XG9j4S
 eXUGbWWDqqY3a8sddkShyEDVicuxWLPNUrfdY719fJKdkl/8fyW/1mdeVi5OHaZx
 7GtNNwc2jtvkUwZN/ALFhocCVSeSdONyxiPh1mEGTYWPJo60OR8QUrzbKJA1n18g
 ZPeWFz43cMQ7KWkj1NkLHAJbY/eOuFQ0/XLZP37uvnpZlKPxbO0DmvBPg+DvWz8Z
 v3+pBjU00lEPljU2tE2M2moBK8iZdrhMdK/AXVUz1ta69hhVTyU3Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rgkst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:51:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFcpjH004888;
 Thu, 30 Apr 2026 15:51:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkbnj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:51:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UFpt9s32178694
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 15:51:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 863D35805C;
 Thu, 30 Apr 2026 15:51:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E17F358054;
 Thu, 30 Apr 2026 15:51:54 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 15:51:54 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com, philmd@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 1/2] tpm_emulator: Reject a buffer size different than what
 was requested
Date: Thu, 30 Apr 2026 15:51:49 +0000
Message-ID: <20260430155150.2139517-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430155150.2139517-1-stefanb@linux.ibm.com>
References: <20260430155150.2139517-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dak8eDxGGwmuITe0tuiYwM8OjKXUqkc3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2MyBTYWx0ZWRfXxNjg8xYSO/hw
 6K0q14hgAAFw3abz5W2WMQCq4A4EfDZbMHzHfKKdXpkmkoSqx4UHFwMStOafIwdOTPE06Maox2t
 wYeLUTHt6/NX9DTbXTaIJjUGwABsvSU5oEBXhjmZjPMZhpBEcalGCz0w01FJF1lkJEto9YargsO
 YN+uTPUpfpA44S8HnA1uRFMNuXVAe/Bzb3WVpVopz4BNlACGQ/bdvATBynF/Tlj4fRtnRCaj9tB
 Kr+h8gVAQP4ERg1hr+DtGI3oGFIw7wZKyzdObPCE4W7GYevk75Q1rvZdVuWCn8GUm8Rm2R0+Cy2
 JCpDH/Gc//O9qWJNUi1xpGYh6F3OzK/YFVsiEoP+oGDhgUJTihXkP4ctC9f/n6WeeU/q3BahcPW
 BagwZ0EQfO/ighTivsDqOypfu+ONJMzwpew0/NbCqjjAfvb/685OXOcJKcV5ep7aHbYbg2Rw2b/
 ylW74DGvKLwLs9oomZg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f37a9d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lp88FLx_Zl_lkmcsHRgA:9
X-Proofpoint-ORIG-GUID: dak8eDxGGwmuITe0tuiYwM8OjKXUqkc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300163
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

When the TIS, SPAPR, or CRB frontends negotiate a buffer size with the
TPM backend, then the tpm_emulator (swtpm) could still adjust this size
of the buffer to within bounds supported by swtpm+libtpms if the chosen
size was outside the acceptable range. This could theoretically lead to
the TPM 2 using a bigger buffer than what was requested and memory
allocated for. In practice this would not happend since the requested size
of 4096 bytes for TIS and SPAPR and 3968 bytes for CRB are in the
(currently) supported range of ~2.5kb to 4096 bytes. With PQC support
the range will have an upper bound of 8kb and a lower bound that will
support the (pre-PQC) CRB with 3968 bytes.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 75c33d290e..653989ac0e 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -364,6 +364,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     ptm_setbuffersize psbs;
+    size_t tpm_buffersize;
 
     if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         return -1;
@@ -387,8 +388,18 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
         return -1;
     }
 
+    tpm_buffersize = be32_to_cpu(psbs.u.resp.buffersize);
+    /* Reject different buffer size used by the TPM than what was requested. */
+    if (wanted_size != 0 && wanted_size != tpm_buffersize) {
+        error_setg(errp,
+                   "tpm-emulator: TPM did not accept the requested buffer size "
+                   "of %zu bytes but adjusted it to %zu bytes\n",
+                   wanted_size, tpm_buffersize);
+        return -1;
+    }
+
     if (actual_size) {
-        *actual_size = be32_to_cpu(psbs.u.resp.buffersize);
+        *actual_size = tpm_buffersize;
     }
 
     trace_tpm_emulator_set_buffer_size(
-- 
2.43.0


