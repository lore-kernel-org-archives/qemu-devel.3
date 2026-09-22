Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C68BC98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vF-0008Si-VH; Tue, 22 Sep 2026 16:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tv-000825-8T; Tue, 22 Sep 2026 16:15:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tr-0007fd-CV; Tue, 22 Sep 2026 16:15:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI733M1129089; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=T+KQWmZPRoeO97lmd
 waFzeiVaV6RDKH5Tl5to6h1b7s=; b=k3TXLp0sll4A8PgDEG9FXyR2KsDwbJR1z
 CPyUNcx/NuGd2lj9V97EWT21mb3Owi7INcQWooDfCHL02smaYIwWkebWD5Jis2kR
 WQSMstzwyx0bINZd4HShrrH6iw61M1ruygCuLVP7sjYh9kKyfAHlFfgrk4HO11vc
 M0WbNGPIcArLuC3PuqMNeqSqt8UanapGHJu3q6ERPcUp7A/zYCYkj9tUwIhU6+1X
 A+xN9QdINI/gXYXWpt+Xr/g0pLSMXUVKLrG05vxSKHNsxsVdGA0g3To8Z/Rs7NgR
 S3K6HZ6PNa90/8x48/7l3unjh/DpECnD1QlBUzyAso1VAbeCTqXpA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ftqv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHdPV3279475; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqbfe0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFRSd39256546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF8142004B;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A19102004E;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 70E59161693; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v3 9/9] s390x/sclp: Reject short headers in PV case
Date: Tue, 22 Sep 2026 22:15:25 +0200
Message-ID: <20260922201526.2383047-10-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tq044Pqgty29OYlnCUfe_G2TlDMtf1cs
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=pH6oLB8u_88KfPtTI8IA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX27LNpG3HOzZf
 yxkDI7RyAWQZthOrxS/U+7rGw8OhyBf41QYszsYWVIk+KHSMKbgWW+6fvaTddBpZgXEvshUL0qT
 ZxSkIK0TVYrqSwuay0jbFV2GsYP4MuJGXdzTZ4mYFgRVdqdU5V46lRpFIwgRMYEVFCIPA0QafSR
 4Gq86AaWp1KMPQ+nRGRDVc0XA0U+eTBQapdT4+6doMUYmHNssPyBpRj8wUFNL2Qh7rNkrToutJg
 WKy5YDfqIEQaWvQR9TAI1XJAxDW3XGJgcTwk7UQe8oMGUKBWclKBiuKMSemffoaOC3/AQKGNEeT
 SoCrQcMe38i3s++RdOAe9+fgYnUWzp5A7vv1QJXAJAM4TefMJTNVq3oG5jBrRX81R9seTKiBv1X
 yq1BA0yFU+vyiUPhSZscDt5lahd0wgksDyrondMHE33ZVpMMtsN5ZZ9UIPCHHz9s2Gbx0fwb0Zv
 WPCcPGpTaGMlZc6Rkcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX8J2FBeIDMj1K
 hM7q3mjxM4LfCSwt2Rq/NmwBt38xryIVn6F7WJl2xNB6ZzE100+PWsw6/OnWgMq+rTgG+EW8K+w
 36booUSNbuQvpCnY/LKtbYWU4/62RLE=
X-Proofpoint-GUID: tq044Pqgty29OYlnCUfe_G2TlDMtf1cs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220293
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

An invalid length in an SCCB header correctly generates a specification
exception for the regular (non-PV) codepath that processes an SCLP
instruction intercept. The PV case doesn't, even though such a thing
should already be sanitized. Since a short length will cause problems
later down the line with the storage that will be allocated based on
that size, put up a defensive check and return if it is too short.

Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided lengt=
h")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/sclp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d8b655efcc..ad8129a5d8 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -277,6 +277,11 @@ int sclp_service_call_protected(S390CPU *cpu, uint64=
_t sccb, uint32_t code)
=20
     s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader=
));
=20
+    /* Do nothing if the header appears malformed */
+    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
+        goto out_no_write;
+    }
+
     work_sccb =3D g_malloc0(be16_to_cpu(header.length));
     s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
                          be16_to_cpu(header.length));
@@ -290,6 +295,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_=
t sccb, uint32_t code)
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
                           be16_to_cpu(header.length));
+out_no_write:
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
--=20
2.53.0


