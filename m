Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891A4C982FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izM-0005NX-AP; Mon, 21 Sep 2026 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz7-0005HX-6L; Mon, 21 Sep 2026 14:43:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-0005zm-7J; Mon, 21 Sep 2026 14:43:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF89Wx4193292; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=T+KQWmZPRoeO97lmd
 waFzeiVaV6RDKH5Tl5to6h1b7s=; b=O/0IB5Rt2d19kpakyfm4AfSss3gObiZuX
 hC8MmqtjVavPoJuh3JZB6brg+kih0vvkMywnzzJ3sHt/biQb8BNYb10DT1xuiXT2
 RFgiwe22ro8Gv3YGgU6z8jPhoWQ4+ysc1Hg0O8gDAjqUKeQwVlQJlNg9m6z13OSu
 2XayslQ3Yw8exXVSUbLL+BLWqqcJPoL1hBuB1JmL7h3j8CRLVpxYnoUsIMALVC2j
 lD+UI66zBrNcxQq6ULv64WQBw35IcrXfRjDR4p+JsnrWQGor3BwQcHVuCvdNi4+G
 BGmdFhZg8YXTaZ9h4L09NmXx9GeJoTnCTzgJW/QPYepF+mx3Pb+TA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1j78u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHf0g2400058; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy6cnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh90K35717548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC37A2004B;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B59282005A;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 786641624DF; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 9/9] s390x/sclp: Reject short headers in PV case
Date: Mon, 21 Sep 2026 20:43:05 +0200
Message-ID: <20260921184305.3791311-10-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ttWEbJkaDqaXvVGQDPtSVB1uHL1n6nE9
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=pH6oLB8u_88KfPtTI8IA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX+CFTVMOAugtF
 lb2vbbePPfBKQLpJ2nWdc7RysKQ2RWYxXFk82XfTld3zVsNhs6LsErW4dfvRNHJRwFx7GHkXwnb
 gcPyrfax6P2jWqHLopQkj9qgAn4FFik=
X-Proofpoint-GUID: ttWEbJkaDqaXvVGQDPtSVB1uHL1n6nE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX+OYaILPyoVJu
 AE9Oy2r8KHRMiMlJckPoevlY4rCubavryQlWQ8BSY4mrYvFzWh4YLGBSVDpVvpShCBL4rB++XRR
 RmkmKJrSsZ2Esfc2kN84cMoQ124nspp/iNn0Dp2gxjF4QmvheSnvAwpcDd3Sy4CLMPWBQJC9+nW
 u3JS1RYff6/dVVRpMYCX5KlHqkZI74jHh7oz62Bw7BXP1mEfUWx7gldwhGQBk1cAGiOUjdiVO4y
 0VxDfHCh/h3a3a/tOBctNISDXNQ/g/qzJ+Y6qci8Zzjn0504l7gw9hOxhgktzmuKX2jySDWTRxY
 DrcaKIvpd75GPZRqecS4LejWKxmx5voh/xNlJljULjNYm02Re+7lzuEhMQuRGNpR6afLo/W3PaF
 oOSi3DCsc9ls0qA5lV40xPdx1mhInLF2jCs2jH/sxeWQaJ1OF5qG9OB19ei9/Bxt0a2NQCNRuLv
 NCQG+AlQ2DuxL6nOJ8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
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


