Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA39CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAd-0008JJ-TX; Wed, 30 Sep 2026 11:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAa-0008EW-DK; Wed, 30 Sep 2026 11:24:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAY-00020S-OC; Wed, 30 Sep 2026 11:24:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5QIx1932696; Wed, 30 Sep 2026 15:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YTZwtP7DWzEx8F5LT
 CN/90pFiJhaIE8gTHU8F0ez5Mk=; b=O2BFG7D1EsWWDORi3eoXoehXZPKHHGBaz
 y7oQ3QHV4c0tlXTPXE2hez/KoGNgXkGJD08APgI9jp+w2XuwdLCEHdqtsP7spI0v
 cFbPKt8gdGGyVxTYNGsF5JOWSzuunqPIy/moc11/WWzvAvOBbKsk9qwg5aYAy059
 +eTlYz2b562LaM1Td6wB4ZnaG+fpe8fKzoSk/KnNeCRQcjQ4u/mX/gRFtk/Rfs4R
 7ifOlhdlBf3KYPFipGCHOIihQ5HEEZxtrQWGP7xbm1vrp/+13sa6Pzu13xosll4a
 q/rqUfSbqU9EWFrzV86Y416TyndotL9Fu5xZ/NeF7mBMEkUfWXM+Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fecyet-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE35ko3541457; Wed, 30 Sep 2026 15:24:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpcet7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFORke22217410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E81A85805E;
 Wed, 30 Sep 2026 15:24:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65C805805F;
 Wed, 30 Sep 2026 15:24:26 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:26 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PULL 09/23] s390x/sclp: Reject short headers in PV case
Date: Wed, 30 Sep 2026 11:24:06 -0400
Message-ID: <20260930152420.1956230-10-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd29ac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=znbey81Re8uwHDCjDHUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXywCWvFGVWC9M
 4WOBP2++aNurbc3xvhziSr3HKjL4mrnfuqaKyYtrd9FYbtCERIj6Ium28nGfk2hXAcbo/leuc+c
 4B4F4vZ4SzBWdrXUoA/ivNEiv62VdR8=
X-Proofpoint-ORIG-GUID: jQpe9fQKeCDB4adTNnXHVc2hVk7ejj3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX9tPcyEjDRcJq
 OciKZAd+6Ims8qYKYc+SGnIm/OHckKYrrcJnxQ1BJjIyM6Das1RKliVazZZbMYdU3Qujc/CMeMk
 puSsWfNanILMzcrpg7dPOB33g4qPbAAmNeNYi9zvLm+ons18fcm3H/bUV+p3hPhxfk1uUO86f2e
 JM9/foEmcnB/DlbF4a6FdfgM7Q7gg4jyqZ2B3Di8KdNTvRMxt1DGwdobSTA+LOXxEwzqlKjlolg
 W84NOZwhV6MewOWaI+HZl4ikquo4reuNOLj+J5fTUUGlXBe33fzqR1WXClXDP1dizcuTxTqwCcq
 EbES7crZzU5K1t9RVXlfF/iBGIoy0/O1a0maS+Qu2D4t8hI0BJdH4L767hDYHYC6GdYRext4qdw
 KThaVU1fn+rF3abNZr2LgsHuibhe1H2SQDwzZ0N2wa4USFm/HOL0/TN7BA/inschJ+f5JVgWXPh
 BIy4N0rbZyMCz8lkVfg==
X-Proofpoint-GUID: jQpe9fQKeCDB4adTNnXHVc2hVk7ejj3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
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
instruction intercept. The PV case doesn't, because the UV enforces
a valid length before getting to this point. The length is used to
allocate storage later down the line, so doublecheck the length here
in the (unlikely) case it is too short.

Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: c1db53a591 ("s390/sclp: read sccb from mem based on provided length")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-10-farman@linux.ibm.com
[farman@linux.ibm.com: Updated commit/comment text, per Janosch]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/sclp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d8b655efcc..ebd5e859c5 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -277,6 +277,11 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     s390_cpu_pv_mem_read(env_archcpu(env), 0, &header, sizeof(SCCBHeader));
 
+    /* We should never end up here due to UV checks, but lets be sure */
+    if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
+        goto out_no_write;
+    }
+
     work_sccb = g_malloc0(be16_to_cpu(header.length));
     s390_cpu_pv_mem_read(env_archcpu(env), 0, work_sccb,
                          be16_to_cpu(header.length));
@@ -290,6 +295,7 @@ int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
 out_write:
     s390_cpu_pv_mem_write(env_archcpu(env), 0, work_sccb,
                           be16_to_cpu(header.length));
+out_no_write:
     sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
     return 0;
 }
-- 
2.55.0


