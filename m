Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25038C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7B-0007Um-FJ; Wed, 26 Aug 2026 08:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7A-0007Ts-5v; Wed, 26 Aug 2026 08:52:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD78-0002PK-96; Wed, 26 Aug 2026 08:52:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW5Ex4057711; Wed, 26 Aug 2026 12:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6Shfh9vTJKoV0bBFC
 miG9sCE/nJNtFFKoJbrorzcNVo=; b=MTSrJonlVBzuXjDe44xuM6pS31xfZy+A2
 /CLif33W86eg45yGCxyXLL/5CL7iAUi9HvfsufSAqlBG/hHmHGKwqHvjm8pi4YHz
 vOV+4BU2iGcjvwe0joW0uNrOMJoVR9fxt7mx3K1b0iV473Y5RSqV7wP3w3EtlN93
 e2+z03VRZAj2LHJuy1ITqyTtg1xq76wXkjJkthTCbPf+oxLrjXOVqifIlSS5he6o
 /Nuq72TppF/LRm5uKHy4gQUjAGfOgGPqk1Mkdlo8mkZLVuXHZndc6rNawJCZTmmp
 DuN8IpydAiGbNRsmCSrBEYugfTf07pwN3VJWjdmvHxFktC29AB8OQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxeby1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfOuc003065;
 Wed, 26 Aug 2026 12:52:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qa5jp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:18 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCpbQc29885086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:51:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 214335805C;
 Wed, 26 Aug 2026 12:52:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4830D58059;
 Wed, 26 Aug 2026 12:52:16 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:16 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 01/37] s390x/sclp: pv: only copy the original SCCB buffer
Date: Wed, 26 Aug 2026 08:51:36 -0400
Message-ID: <20260826125213.1901252-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX/dJrHYrL2G8C
 JROaSPv6OA5inVEkbB/upCP+8i+bFHNCMtyOdzC3PyD0V1ozZUlDiojBayRvR8NCnYBoJ3HM9Qv
 /qrQU+D5a0VBgyy4bECa6xtX2b0ctH8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8ee183 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wqyRmatkV8wIHynnhxEA:9
X-Proofpoint-ORIG-GUID: ZAY-FrjshmUzznr-F7IQifcj05qxtbPT
X-Proofpoint-GUID: ZAY-FrjshmUzznr-F7IQifcj05qxtbPT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX9OtOjdwosGDn
 43J8O6WHGOsWas1ScQnPZ7zpey822dBKTI8hLESti+LILDIk7LQGHb6/2HhnZE3HKpcN3MbYnH4
 3LMvq6+C5jgNXn73HfH3zv460CU63a3aW/UBpYJ2A8Sl1IyA7T+KOHBdoNAS9TUjDhuxqSxo3+V
 JfLtrjZR4Q5SCTHo7g4izYmiLeBubFvie403RwmkXNi1vAXpkd2IqTeSlN2zZC9uWePDXkw11bc
 CoaVCf6E1i0kmh2imtjVIfTwOW4kA7FoBlyXvHnRyCevQhjmyQaT2aHog8nFrQ39UaJc+cL+H5s
 4tnSVw7Zg882JcTzmwwsSSPhhJQVlPhQEuSmj1lth39R/h79O925sm2riBS2q0wubQfOd4Gmsa3
 H2NK2Vu6v8cOfuhYRdA7jjRQWOT+giMyMSMJwcGjre5mHydEUY+gO5zUHaPfdnXcfCQ1L2vBQRs
 EFFJ/78NoVlYAWZyC0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

With variable length and EXTENDED_LENGTH_SCCB, some callbacks might
change the length field. For example read SCP info might write a new
length into the SCCB header. We must not use that new length for the
buffer copy, since the buffer was allocated with the original length.
Only the length field in the work SCCB is changed, to indicate the
"necessary" size. Using the new length reads past the allocation, so
tools like ASAN might detect a buffer overrun.

Secure guests do not have EXTENDED_LENGTH_SCCB, and the ultravisor checks
and sanitizes the length field, so no qemu heap contents are exposed to
the guest and the non pv-path already has the same header.length.

Fixes: 0f73c5b30b8b ("s390x: protvirt: SCLP interpretation")
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260814125857.1729543-1-borntraeger@de.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/sclp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 3c8cb16488..b452f2ce54 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -287,7 +287,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
-                          be16_to_cpu(work_sccb->h.length));
+                          be16_to_cpu(header.length));
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
-- 
2.55.0


