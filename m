Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9481CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeWQ-0000Iz-Ic; Wed, 22 Oct 2025 15:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBeVn-000834-31; Wed, 22 Oct 2025 15:28:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBeVl-0001gc-6U; Wed, 22 Oct 2025 15:28:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MEnsvD027350;
 Wed, 22 Oct 2025 19:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Gq/WHDlUh8spgPYBp
 EywHSfRNf6ahpKsKuWx0r0w/P0=; b=dnVebv4i7SKr6jPanpTmsf7Xqdjlbqoi0
 gHMo47X4Ad+61IjUMnphGwRGFtNffq2ppWoMujJjGgSI60z87tS3KrOFZ8RqLC2e
 jonRPTGwA7/vxMppT5jMWMVaRHyRGIiI64PVe/PsfMjirWDWpwURwEcmP2jszgNC
 F/PvOvd6r0hvvG6ye8FnGqv2ETfGSg/856b8LHW8i3bjCvLowqwGC5Yi9OfQW5xR
 VlyQgK88kptHjhd/zlzFT8p5VnXk6TaMSZzfpkuqnx7saAmzlT3B+rZeF/t1X/Jy
 43kkSegYjmZDwVQX8wAijc/aNYciP8A+bgQZ1rbaZ7NeptYNUDqoA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s6p02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:28:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MJSZPH012286;
 Wed, 22 Oct 2025 19:28:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s6nyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:28:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHwNBb002381;
 Wed, 22 Oct 2025 19:28:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejhydg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:28:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MJSUee36635074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 19:28:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A930520043;
 Wed, 22 Oct 2025 19:28:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDDB720040;
 Wed, 22 Oct 2025 19:28:27 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.25.30])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Oct 2025 19:28:27 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v7 3/5] hw/core/loader: add check for zero size in
 load_image_targphys_as
Date: Thu, 23 Oct 2025 00:57:18 +0530
Message-ID: <20251022192717.1644251-7-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022192717.1644251-1-vishalc@linux.ibm.com>
References: <20251022192717.1644251-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q4GSKFsuhYfi50gdpAXZRH1M8VqDEVuh
X-Proofpoint-GUID: j1buwe5WdYYeLhVh5UHNPXlVg6gagJXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2vS3obQdsmzS
 rHBfS7CXFtgcJFoYQ1+h7NhOsQlH09vi3Lp8f+8sOcpsFwQyaeF0fuPm3k99UONMa7XQ4NuVoU0
 Q8w4niX+oh6Qa7XrY0XLFl92HIjnbPboOuJOJHv/l4m1VAKyqVVt4DvoW8LvCP8skKm+apNYq2q
 sJRwc4nYqJPt1vjnyQ1PaRAdYbJYVbf+t7zoAR6MLXtzPElCRWimvHs3nq4SgCP9XqHK4RHiDMg
 +nq8AqSmJERkTSTcFrWVuBMjfjT87cuJC2aS1lYlT2jHe+wLlTHBvWUEdoN6BwmCCcstUhVvNld
 JLLLQ3wq7xomlEBg6LyewEAnTtvGYfvM6VyF7wCqn1HSbb0nv8FHvhk5kp1iPJU0ZFrVuS0rm/S
 lZvxsaP+7B4hJqRc4SljjzJqLGQo3w==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f93063 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=EMG23Z06JWfOmfJaRK0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Currently load_image_targphys_as() returns -1 on file open failure or
when max size is exceeded. Add an explicit check for zero-sized files
to catch this error early, since some callers check for size <= 0.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 48dd4e7b33..6717324527 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -141,6 +141,11 @@ ssize_t load_image_targphys_as(const char *filename,
         return -1;
     }
 
+    if (size == 0) {
+        error_setg(errp, "empty file: %s", filename);
+        return -1;
+    }
+
     if (size > max_sz) {
         error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
                    filename, max_sz / MiB);
-- 
2.51.0


