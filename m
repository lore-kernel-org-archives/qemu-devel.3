Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87636C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuaq-0001eP-Tt; Mon, 17 Aug 2026 06:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuap-0001Vo-24; Mon, 17 Aug 2026 06:29:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuan-0008Sg-4N; Mon, 17 Aug 2026 06:29:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLWK292630120; Mon, 17 Aug 2026 10:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I0l7CX
 swaN9rDgLM+LgMvHNXNymI6Rehz+sfs+rgPMc=; b=p6yXduEL25Sf/LNi3NXwdd
 Zf2JBnjRa4L7Xi6e9Dn8PwXr728RecC1MUPsY3PEB8uTyYb0uBQFTa8pDBB6cRJ7
 DaduDvSfjS2WAVezfbllmb32uD8kAGFVVkH5oGosSMnLiQc65XnwFKO7kuVPQEjY
 FP/6mnXDYDp2i1z4zaxETz9SgzlxYUdGa1yjV1hUoAo5ijvCIOkzEwqhFqGltPPE
 73A6W3lwQdyOPa2sSdYWKkHNDa8+0e30jMt0HhzkgKbXprtllluJM4iGlVbowAgo
 RNRWEM2w7LimbLx3uvl5amAeZcdshGkdZsAqUZAqf7UVuxH/d1nBK5WXgcdhTrjQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe1jgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQMoh000863;
 Mon, 17 Aug 2026 10:29:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng5e1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HATEcT21758664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:29:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F57058058;
 Mon, 17 Aug 2026 10:29:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E23D5805D;
 Mon, 17 Aug 2026 10:29:07 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:29:06 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 7/8] ppc/spapr: strip OF path argument suffix in
 path_offset
Date: Mon, 17 Aug 2026 15:57:24 +0530
Message-ID: <20260817102733.605346-8-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX2Dr82D9FNM7N
 dZh72jYMoB8YqXkajHyJ3uHQ0ZBeKhuxHzVIdzBLDXlZkqbGJCvMEJpJfh3+J9h48OJ6gsIsKOb
 DpX+o1lv2KCfrd9COodOYvVenCwSq2bWHw4gaGKzK3eXNW935oCBbgxS7JTDzucL7iwCVeBLDZU
 iUlboVI1zxqOTCRI/zzkOKGtlCiq0S3KKOttg5/BXaCaICg49fMMMWT6L5sOhEtos6CoydpNsaA
 FucQHu1R5CjSH7C4ErQ/ONjw9BZM9UXHUgjL2jVTJFHMe1L20vsapTwaSt7+sMLLjuXxLk0ro5b
 4Xd5ZIYEU5+YqomP0yEuQXZpIobq7DvQ/zZcIjflcrLMC/oW4f2eaa53VYecychxbek+ZA2EQ/Z
 cpwcuuHLq7t28kfSBKB/W4GTNipV0MWJxzGsh/jdiEltS3yLIUgZ+ydUZ2t03avUn31YjlgBUYL
 i46nrFowoSsEVaNpR7Q==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a82e27c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=qf4gfuq51q0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=gEfo2CItAAAA:8
 a=VnNF1IyMAAAA:8 a=pqpSryZqIyZLl4xueesA:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: Ilue5wghETvOVU9wGICiuvIS85hkKsYE
X-Proofpoint-GUID: S0E3uvVlhp0AizaYxUSEmVCIBvmGSzgH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX+c0GcEl9sS1Y
 ZNBY+5KmtSq4VXk+tRN1sm4POYahZgWAw3nSVj4RHJd/9RFYwcln4wOL4pKik1KwrUMH1aYgXTH
 hz0IGrBwVEW9I3zrcLT2iZtKuhrwZnY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

From: Utkarsh Verma <uverma@linux.ibm.com>

OF paths can include a ":argument" suffix on the last component (e.g.
"disk@8000000000000000:0"), which is an OF path argument such as a
partition number.  This is not part of the FDT node name and causes
fdt_path_offset() to fail.

Strip any ":<suffix>" from the last path component only, leaving
intermediate components untouched.

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/ppc/vof.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index b1c574aabf..d3b0df30e4 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -142,6 +142,8 @@ static int path_offset(const void *fdt, const char *path)
 {
     g_autofree char *p = NULL;
     char *at;
+    char *last_slash;
+    char *colon;
 
     /*
      * https://www.devicetree.org/open-firmware/bindings/ppc/release/ppc-2_1.html#HDR16
@@ -151,6 +153,20 @@ static int path_offset(const void *fdt, const char *path)
      * suppressing leading zeros".
      */
     p = g_strdup(path);
+
+    /*
+     * Strip any ":argument" suffix from the last path component (e.g.
+     * "disk@8000000000000000:0") — it is an OF path argument, not part of
+     * the FDT node name.
+     */
+    last_slash = strrchr(p, '/');
+    if (last_slash) {
+        colon = strchr(last_slash, ':');
+        if (colon) {
+            *colon = '\0';
+        }
+    }
+
     for (at = strchr(p, '@'); at && *at; ) {
             if (*at == '/') {
                 at = strchr(at, '@');
-- 
2.54.0


