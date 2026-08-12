Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbO-0001D1-0N; Wed, 12 Aug 2026 13:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZu-0000B9-5C; Wed, 12 Aug 2026 13:17:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZr-0000pa-17; Wed, 12 Aug 2026 13:17:21 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1ag74088179; Wed, 12 Aug 2026 17:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=d+bOpsQyZ4Qo+aghc
 CwFgomuFCOIi+NHh5co1tsalc4=; b=QA3UAlSqY5qPegT6Rp9rfOxmktesNi3oH
 lh8K4dklGbjeQuZomPD9flQ1NbOqQlBxpE5fDshYkGiBfHl5IpvWpBe1ifD/6qfE
 EVNFVFx8QQEkXfiTqZv5Kn898V8fuhXvydiDCUq8dFlxbyUz+c3J3j1DwbDe8A/m
 Jq6eOxrZBfSslOfyPSP7knyPuERIU96vGroSUJnZ/1wuCcGLk+fYU4iFC/OExThq
 Ce+3ZctW25Go8Rn9H7E9IyqNYwC+/uhoX+jMzgSAjYdRPX7e1J7fK5jfE6nl45IR
 OCmEval40oFczN21/jakkeHZAjhfv9C0um+F3uVazW6+8URQd8yUg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9us2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBFdZ017010;
 Wed, 12 Aug 2026 17:17:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq79yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHEMb26673810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DAAF5805E;
 Wed, 12 Aug 2026 17:17:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76A015805A;
 Wed, 12 Aug 2026 17:17:13 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:13 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 05/15] hw/char/sclpconsole-lm: avoid guest triggerable assert
Date: Wed, 12 Aug 2026 13:16:57 -0400
Message-ID: <20260812171707.1605637-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXwG4TpNsV/X6E
 NsGPZI4XqKk4cuwUkjKp4JSpnYCtikNfNFqZZnnuhwHmbETa5UVv8+2edR+hxhYOCauprqKtTi5
 v8QKUrAjXOTUrkNGMfCPDnozlgNmu4/bJBUX04wZvIgHMdQI/+672veIAjUBrFzsngsgVYN3rts
 KX+n9X19KSId5e60kWo/vLvyCpdGSKf9RysRwEEG/IbXD/TOrmDB9QCrReiyiLdJDfVWKv4fhLE
 NJJN6haQ4GHdqflkgKwPtB8DCZ5huE2nmZLZyt1UOVZLnr7Mo7RzDL8A1V4b0ER+2xmKm4hAtRc
 fQECVvOkTvmn1xmwEXDwHMU9p2mLdjme4RptUV0ORYXImNtFUeOBYTTE4MdG+BnEfwIM6O9pfNq
 39L4IB42sU6YPR9Nhu7Z5zDgd2GI8dzLxOPvL/HfxZpf/9OGqlRgpKsh67IPaiRktxUbTgPpCHA
 p/8SuKflWlltyKGSiEQ==
X-Proofpoint-ORIG-GUID: rMc0InwwmXZcvXnzCoUoCe-gfZ9RrWMF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXyjDCFUyR6NKP
 8dqCqwnY6N84t6aNcDFmjNSURJJhbXWMy+sAnXGrg2KRH9A0jj1oZcd8mLYslyB4fI9Q6nnaQLD
 exdXTIKnNp1ggVDIYXFxP0yjG6LN7YI=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7caa9c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=rU110a7sRXBWuev9ilUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: rMc0InwwmXZcvXnzCoUoCe-gfZ9RrWMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

If a guest uses incorrect message length it can trigger an assert in
process_mdb which kills the guest instead of reporting an error.  Fix
this by adding the correct length check.

Fixes: 6a444f8507 ("s390/sclplmconsole: Add support for SCLP line-mode console")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-2-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Fixed typo in commit message, added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/char/sclpconsole-lm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 9a16896d22..f6ed282f1b 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -243,7 +243,8 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *ebh)
     SCLPConsoleLM *scon = SCLPLM_CONSOLE(event);
 
     len = be16_to_cpu(data->mdb.header.length);
-    if (len < sizeof(data->mdb.header)) {
+    if (len < sizeof(data->mdb.header) ||
+        len > be16_to_cpu(data->header.length) - sizeof(EventBufferHeader)) {
         return SCLP_RC_INCONSISTENT_LENGTHS;
     }
     len -= sizeof(data->mdb.header);
-- 
2.55.0


