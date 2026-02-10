Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5489EA813C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq3T-0001vu-DA; Tue, 10 Feb 2026 10:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq31-0001dR-OJ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:53:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq2c-0003hP-Aa
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:53:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A7sdRb4037824; Tue, 10 Feb 2026 15:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xIdojgdoOljs4P6nj
 z5PtnLP4GK0cKaa4WDRpbEmoes=; b=S0CHuwxQ50XJcLeIi77eGsVfILh9BV7Pt
 KMllNDTtKlYw9+lQPq5R+Z3TjJbX/qIIReE9oJLaD5cnIAWayUJxifpMFIDGLG31
 y3zSgsO5JknPhPbvd3jkGO93jnGrgtGJ0yhqseT/6BOXQmeC/e37CdfFxZKwyX/v
 RvRLqEx1v4Lf2Dnp3FtoBZxxj3tA8keX3cdC40IPOVK20ZXicvalVMU/fVbJFtLl
 IFkjNMgmixllz34yA+siLrLHdAJvJsuJT1n3tbd4WE3ra0PSCY92P88Dw3+9BZdk
 yAKlSOWY8W/Kx6JOymy+iDTypnJNgf9nOXB6SSjnK/pb9PtmZuL/w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ucybt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AFJPmI012626;
 Tue, 10 Feb 2026 15:48:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7k9ta1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AFm5c231261190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 15:48:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 999CE5805D;
 Tue, 10 Feb 2026 15:48:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10CC858054;
 Tue, 10 Feb 2026 15:48:05 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 15:48:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v1 3/3] tpm_emulator: tpm_emulator_set_state_blobs(): move to
 boolean return
Date: Tue, 10 Feb 2026 10:48:01 -0500
Message-ID: <20260210154801.1662032-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210154801.1662032-1-stefanb@linux.ibm.com>
References: <20260210154801.1662032-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698b5337 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=CJagtSCr96gRjeXOXogA:9 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: ju2MT2_ofNCDfDOAYFYEkSLHfICZWpnD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEzMiBTYWx0ZWRfXyPC9EXoXbwaP
 qsNT8QWzhasBGek+8MRfP+rM5h1LO0maWhrYct9ZqUbcdA3UjAi0xazg3q54/NubCSvBHIJAnq+
 hpPVY9JLhWKSVeCi88uOTEVpX4z19vQMRaYZ8JgCzxCf843Xxsyx0S1P/110PYyrxqqqmLMPi1M
 7BZv3VNh5d5RgJfS66fv9545Og5aIozRgVDvRM3ZmtDudV156Vs1y18Fkkl+kGT/znQjY8sK3gc
 XGuz60eAKT/FAfP00GzGMwSQgdCwAUanoQfa2jMnbEPaZ6k0r9CShtZINe9jQPVnSPwbJZkUFkQ
 c5vBjuHfvkB2+Eq55Aiftl3OYZd/S5RmL1r8HndrVt9lnxrH8DfaNBy0ucUdqc5W9gPxDc4r/lW
 TOFCFvVYGRBGNAWpJaVySp+N6IXNfzcssdyQU+9tWUyUGlD6yBZN8mlovWAYeUV0aRSV8qMcnfA
 O85yCtkQxYsR7EnzGTA==
X-Proofpoint-GUID: ju2MT2_ofNCDfDOAYFYEkSLHfICZWpnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The returned error is only used to check for success, so no reason
to use specific errno values.

Also, this is the only function with -errno contract in the file,
so converting it simplifies the whole file from three types of
contract (0/-1, 0/-errno, true/false) to only two (0/-1, true/false).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index dc84380b13..75c33d290e 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -885,10 +885,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
 
 /*
  * Set all the TPM state blobs.
- *
- * Returns a negative errno code in case of error.
  */
-static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
+static bool tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 {
     TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
     TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
@@ -897,7 +895,7 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
 
     if (tpm_emulator_stop_tpm(tb, errp) < 0) {
         trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
-        return -EIO;
+        return false;
     }
 
     if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
@@ -909,12 +907,12 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
         tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
                                     &state_blobs->savestate,
                                     state_blobs->savestate_flags, errp) < 0) {
-        return -EIO;
+        return false;
     }
 
     trace_tpm_emulator_set_state_blobs_done();
 
-    return 0;
+    return true;
 }
 
 static int tpm_emulator_pre_save(void *opaque)
@@ -957,10 +955,8 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
 static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
 {
     TPMBackend *tb = opaque;
-    int ret;
 
-    ret = tpm_emulator_set_state_blobs(tb, errp);
-    if (ret < 0) {
+    if (!tpm_emulator_set_state_blobs(tb, errp)) {
         return false;
     }
 
-- 
2.52.0


