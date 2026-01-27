Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC313D34082
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkl8c-00028D-5l; Tue, 27 Jan 2026 10:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8Y-000234-Su; Tue, 27 Jan 2026 10:37:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vkl8W-00024W-N4; Tue, 27 Jan 2026 10:37:50 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R89d1R005646;
 Tue, 27 Jan 2026 15:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vqDXri
 juYD9KEX3PYVErMrFONPQQKLMeoFaQW/jTcxE=; b=nc8zGt3C4Ig6HowbxbZlbn
 +UqWtUYeYOXTaBjDXXBUT9D14L2u/DAHb3tynsMKD6Tx0yg/lnpyaKx8df8VJhAk
 BKawLBpEseFvAbWfiH+eKL8XlRYaC42CbLTkdl81Sg0ZQMoUjhhxILBKh4fbQsZW
 6GyOHzvH9NeR2IkEl0X/F0E5grclsOp9aRRJRqNFwiYmxKeGB2o9MQ1fLLVIdb3M
 ZT75DnRHuktuVcnf6ToNz/lxmcfaAcerb7IBPIpLWJ6DW/MoioDP94NETcXpNdGG
 Rw4u1tJD4qmJnlwARkd1JchqX+lRbeDbDUzEgG7K0AE0GxWgFhlZGeuPE3Gduytw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6x8ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDBBZs006725;
 Tue, 27 Jan 2026 15:37:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy99we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 15:37:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RFbcaN30015994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 15:37:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35CA520049;
 Tue, 27 Jan 2026 15:37:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B669E20040;
 Tue, 27 Jan 2026 15:37:37 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.80.246])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 15:37:37 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/4] target/s390x: Dump Floating-Point-Control Register
Date: Tue, 27 Jan 2026 16:31:42 +0100
Message-ID: <20260127153736.62730-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127153736.62730-1-iii@linux.ibm.com>
References: <20260127153736.62730-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M-0pcQYqGL8DZvhCiY4NanDlpthSJr3l
X-Proofpoint-ORIG-GUID: M-0pcQYqGL8DZvhCiY4NanDlpthSJr3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX6TAIOGxueIvV
 MJ6px3/U8xS3vm7SwHTdfosr4l4Dnf/K+JHJBmqLP8QI+oyv70999PFmJ7Gl3S81nXKjx8ZkvOx
 /tladkaF7RqZqSAw0r8NSu61osQtS7aE0ShvDkSlTOL1J1UKaGyi9AqlYf6QBtGR4hXJmHmaFv9
 HnzhqvYl9UXkvjAtNA1LQTnHMVUoKxJk0yUtTySQ8dlzH5wOSJ47E22faUEOSssHDwdbExYQmFs
 ocUIM85U+Jj5/A8VNs1pO/cge2P1uel0v6OLeWhWMwNJMG9ZgY4rIr96D38aoR/A/lg1zn61kXf
 17JFWmP8tvqBYAGunBbh1dWEh17jzQvg6maxnJOjXkb2k+8kpylMCZSOVgNdLarjiCbny4j6SnU
 dMp/PwyRVOV2KEsoy+9FLPQVzhe6mogeX7CQXcrtOwueocEBq3IKhJ9usYMqn/Uw67t6c1IhTF2
 Rhv5HBNTm5r8MIw4wxQ==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978dbc5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=WEarJFB7UarLcg5xSFgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


