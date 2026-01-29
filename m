Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36083D73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXOK-0003I0-Lj; Thu, 29 Jan 2026 14:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOD-0003G6-R1; Thu, 29 Jan 2026 14:09:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vlXOC-0003Aj-6T; Thu, 29 Jan 2026 14:09:13 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEq0DI012136;
 Thu, 29 Jan 2026 19:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vqDXri
 juYD9KEX3PYVErMrFONPQQKLMeoFaQW/jTcxE=; b=ANAxTxkoYYFI+0Hb1B2ZSH
 lYzj8Ll+PqM4pGf3bUiU2/WhD5h5IFXaMjoTGcLmYFrG1XCRdSDcILk5oFz2El1x
 X+zUgQ3GJm4hNc57KVoPztd17ybxwU9btJRIZq8w/WDuiU67BJ+RWHtVQMvPBeNj
 0ocuOwLUDl5WpYw5ry/EomcdLsp121MPUsaqCBe5WRFlwHcVrtBFFjqXFidyBamy
 OSISIwJVk++KmpW/lbg5eIjK3ulrNwdrdjD+ESGXzpkQ34gHVHNrwPxHT35so+oo
 3NUIhaqoKT3Egzrlu2KdFIG2sT45jZ4F2aFbwr/suYEJl52owVP0UGiveG/ayhJQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr6fjw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TGRSB9026340;
 Thu, 29 Jan 2026 19:09:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkk6uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 19:09:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TJ95Dc36176130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 19:09:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EC492004D;
 Thu, 29 Jan 2026 19:09:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11DE820040;
 Thu, 29 Jan 2026 19:09:05 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.137.8])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 19:09:04 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 1/5] target/s390x: Dump Floating-Point-Control Register
Date: Thu, 29 Jan 2026 19:57:21 +0100
Message-ID: <20260129190902.196262-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129190902.196262-1-iii@linux.ibm.com>
References: <20260129190902.196262-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNCBTYWx0ZWRfX1GseVeKjdpkQ
 +Y9xqBmYgFhhtVfjRgBd126XXvhgDMNI2ZVQxRPbG/2DwvBKJk5JCBeZiUwiHHvF9h535hmthKj
 yMd70PlduQ/hxia2BX/liBkymU/zKCT3Nlta8ONnKS4CU8n1IVGMS0mbxj5IHncB93sbvQ2rynj
 rdHsmpOJ7WsCOxKo2Oo4KYiXybbxc0X9qiFlrKrxHteYuKrH9+V6Paua7gvGccW6mETWfCb7lrc
 9GFuWyEVB0K6oUh5T8Jr9DsO8XEWxxBYRUZ9+YbQyadKgO1skSKgHmBAGvu8ihsxpk3uwp49xnP
 kS0l2iwwN5TxmtBRRD4ft2W2cYa2RTjyHGzsPCzVf579hrrIx4fuooC1riRGcZQZCeZ/QjZdHAU
 TPC3UDrlf2QXVnlpOAye2KcThx7NLW/VWjGnF+K4TqAXI6IpxPekqczbVD+2C9I0tDzfkRcyelG
 EZNMmtfIFuoJOEzZdzQ==
X-Proofpoint-GUID: FZEt0Bt-zbFF2YAJDO_DPSeqhIBJuYK8
X-Proofpoint-ORIG-GUID: FZEt0Bt-zbFF2YAJDO_DPSeqhIBJuYK8
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697bb054 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=WEarJFB7UarLcg5xSFgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Knowing the value of this register is very useful for debugging
floating-point code.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/cpu-dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu-dump.c b/target/s390x/cpu-dump.c
index 869d3a4ad54..5b852928031 100644
--- a/target/s390x/cpu-dump.c
+++ b/target/s390x/cpu-dump.c
@@ -63,6 +63,7 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                              (i % 4) == 3 ? '\n' : ' ');
             }
         }
+        qemu_fprintf(f, "FPC=%08" PRIx32 "\n", env->fpc);
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.52.0


