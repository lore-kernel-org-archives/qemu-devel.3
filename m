Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B9DC982D0
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJb-0007bq-NJ; Wed, 16 Sep 2026 16:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJN-0007Zj-OC; Wed, 16 Sep 2026 16:32:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJK-00030u-Qt; Wed, 16 Sep 2026 16:32:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1ksS3041641; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=EMisayS6It8I5HN7v
 cfH++6z3hgrRUbfICDyq1tEkSQ=; b=XYwWy0YJ/TXTZKl/mRQZNgSpew+1gAUsM
 5Nw89DUwf/C+wK4FVSkiYUKI4iit93LIYwhbeKiwp+o6dfvyoRq62mmNcnD2TbCE
 Qp95Y5r9L4fktju2u3rX48MzIVxFBUQh1jgiZCKOQYkOLlbvaVipRCyDFnq5jU7c
 GYitH72fohrdelNRkM/2Hat8/xojvHMQISFBjXiGNfzTHNUyCAVxtsQjDrX32ckr
 BoRgyGSAzUeNFpoRMLrWxXriY0mvZvCFPtYilNb9uk34vZPPlMY63A7I/ONEG56G
 nD+WdSbHasVVfkSnqpHjLeC+p3AP4SF7VazqNIziexABmSm0ZAu8w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e6jwx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GItIb71699556; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vgb07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWl8B15335822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2B7A2004B;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C79EF2005A;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 89F8B161427; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 9/9] s390x/sclp: Reject short headers in PV case
Date: Wed, 16 Sep 2026 22:32:41 +0200
Message-ID: <20260916203242.2509787-10-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX2rl8hdUMBZRe
 NvenR1tJaHIXCYl4eDYT4SJhdDpejk/e7zQnj2EHpXWemdxvV4AtEergWwfgWT/2TGa8iRdj5e8
 hkzmXCChU00otCypHhXGdSGnw/s5nNMkBlwulsNAV+8EXBrhTfH2f7MStGbdJidN6VPculH69hw
 FXFaRnveQJAplHsxXSMrEgcVe28VuxhJAhqns431lrbz4jzTPjgtW3yYWskR0yP5rgUN+NEza4t
 3dTKUqT362ltxT72fABOXXnYZ0yS+r6qIe4SS7wDKnSbR+OL7HD1U9FsOfRtqYmQrUKC6Qt2cZ4
 p+eIB9AOUakp0lhPxI33Cpj0yvf7WfUnh4SBHTBYYxDhv8TW8cH2ftuhuN1p7G8m2/Vr55breh+
 PKXtmE72LpdG5xqWk8GFzJjOPBcP7yXpEYuFC0tdX7QPF3zkNGAKt7SvGG24S5vLrPbXDGHSIzx
 mnQ7hP1fmECXNodptkA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pH6oLB8u_88KfPtTI8IA:9
X-Proofpoint-ORIG-GUID: hKZTJsKM73MynN4ruFk85WBdjFAYQAm3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX5Njks9/kL8aG
 LIfLBVLF69MkSDgTalVe5gzdzEpkMh9Gujo7GzSGibTGOlbmDI2yEIXBMiy0PV8TGCH+sOtC60L
 I5KanKWb0y3+6JXfFx4yvQkhqBR7/8k=
X-Proofpoint-GUID: hKZTJsKM73MynN4ruFk85WBdjFAYQAm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160285
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

An invalid length in an SCCB header correctly generates a specification
exception for the regular (non-PV) codepath that processes an SCLP
instruction intercept. The PV case doesn't, even though such a thing
should already be sanitized. Since a short length will cause problems
later down the line with the storage that will be allocated based on
that size, put up a defensive check and return if it is too short.

Cc: Janosch Frank <frankja@linux.ibm.com>
Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided lengt=
h")
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


