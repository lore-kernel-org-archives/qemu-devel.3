Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DB4CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 20:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJzyH-0004Bt-46; Mon, 04 May 2026 16:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzyC-0004B0-UE
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJzy8-0000Ow-Mt
 for qemu-devel@nongnu.org; Mon, 04 May 2026 16:32:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644J7BUw815633; Mon, 4 May 2026 20:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SWgQ+1oVwDXcnry3s
 WIuIbQcPh+rrbqNDDdyBVyt2hw=; b=THcdwEgt6RKsLw8enRdsYBqkXujr7Qk5I
 J2gr/nS4vEzFrDlN7dliSmUPFOEUOf7HW0dVt/FO2hdYWK+3kWHxdgzmQmo3hEKi
 SszLo4aebpXXaffiueyfdanS9wZCxPoJlWGOxJ/Hp6Ahvsm0olP3+oozc9X3GtjT
 ro9pe2ecqh/vS5Yvi2LJRlUMgEOmQaaWwQ0mAOfYT9HJO2dqrsMVwAA9n6Bbc5pD
 YJkBmHPf1fq6tCOHimqmV5v3HeWtfaHXzvoxyHivOLcWOOD1+eXbtNRmFZMybfCV
 SENTT1Yi8yoIzKuLT9ulwQqJ2+M9HjWe5nt6cMh1kFrq6L+IXQqgg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y18t57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644KORLn000469;
 Mon, 4 May 2026 20:32:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg6jqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 20:32:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644KWeXb25756316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 20:32:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5B2E58059;
 Mon,  4 May 2026 20:32:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 885B458043;
 Mon,  4 May 2026 20:32:40 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 20:32:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 5/5] tpm-spapr: Extend buffer size to 8kb for machines >= v11.1
Date: Mon,  4 May 2026 20:32:28 +0000
Message-ID: <20260504203228.886578-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504203228.886578-1-stefanb@linux.ibm.com>
References: <20260504203228.886578-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YpPXoZzkHdL8r-aHC_G5xMu3yqCOXsPz
X-Proofpoint-GUID: YpPXoZzkHdL8r-aHC_G5xMu3yqCOXsPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE4NSBTYWx0ZWRfX4sA2vTVItAIp
 FDFkxeL4Om3SDWq1RCjK7dPiUl8Hpk67KbTrSkEobRZZZrPJkGcIJxl5jEMLqtbgTl6YF8Q21GZ
 UvPVMjD4O0QyyWjRtVsu7oK/WXW1ratTcC0worhzuQMogSqhWOK+ee30qJxJd3tZ6Y6YwnTeOwO
 tePcl8cANNSwPXki2cUJu1fhjnPxpvy6gMbAFvA5pXigoChEEQukwogCWz58BgTppdfEb8OfSox
 3ZQPNbcY9HcydjJT6JAKkrZdTcej+eTNjGNrLYJCYz6edStZ/xXUipI2jOKLPphr+R5hnmrf+hO
 8JZzh5Z0SrDaUTK/IUPfUGAkZQwDw3ns9zyvyf7dktHZsEl+0rmZS8I5wraB7rckhN0DdUV6SHE
 D2GSHFywjTCY7LDiQpRwUvgBHwy08Z+nsgOsqR9VPwr6O0uritWLtnoYQQyaGKdR3QM7pl1uC6Z
 R4xBRFnaANPvsXixcCA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f9026a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=eRoXzRw8BeJ126zY0s0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040185
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

Extend the buffer size to 8kb. Also introduce the allow-ext-buffer
property that is set to true for the 11.1 machine and to false for
git older machine. If it is set to true, allow the 8kb buffer size
and restrict the buffer to the previous 4kb otherwise.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/core/machine.c  |  1 +
 hw/tpm/tpm_spapr.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 42ea231b91..b07802c550 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -45,6 +45,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "tpm-tis", "x-allow-ext-buffer", "off" },
     { "tpm-tis-i2c", "x-allow-ext-buffer", "off" },
     { "tpm-tis-device", "x-allow-ext-buffer", "off" },
+    { "tpm-spapr", "x-allow-ext-buffer", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 19075d1f01..91f1607dd9 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -64,7 +64,7 @@ typedef struct TpmCrq {
 #define SPAPR_VTPM_ERR_COPY_IN_FAILED        0x3
 #define SPAPR_VTPM_ERR_COPY_OUT_FAILED       0x4
 
-#define TPM_SPAPR_BUFFER_MAX                 4096
+#define TPM_SPAPR_BUFFER_MAX                 8192
 
 struct SpaprTpmState {
     SpaprVioDevice vdev;
@@ -86,6 +86,7 @@ struct SpaprTpmState {
     TPMVersion be_tpm_version;
 
     size_t be_buffer_size;
+    bool allow_ext_buffer;
 };
 
 /*
@@ -293,14 +294,18 @@ static const char *tpm_spapr_get_dt_compatible(SpaprVioDevice *dev)
 static void tpm_spapr_reset(SpaprVioDevice *dev)
 {
     SpaprTpmState *s = VIO_SPAPR_VTPM(dev);
+    size_t limit = TPM_SPAPR_BUFFER_MAX;
 
     s->state = SPAPR_VTPM_STATE_NONE;
     s->numbytes = 0;
 
     s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
 
+    if (!s->allow_ext_buffer) {
+        limit = 4096;
+    }
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
-                            TPM_SPAPR_BUFFER_MAX);
+                            limit);
 
     tpm_backend_reset(s->be_driver);
 
@@ -367,6 +372,8 @@ static const VMStateDescription vmstate_spapr_vtpm = {
 static const Property tpm_spapr_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprTpmState, vdev),
     DEFINE_PROP_TPMBE("tpmdev", SpaprTpmState, be_driver),
+    DEFINE_PROP_BOOL("x-allow-ext-buffer", SpaprTpmState,
+                     allow_ext_buffer, true),
 };
 
 static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
-- 
2.53.0


