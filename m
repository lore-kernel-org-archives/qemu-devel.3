Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F73CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 05:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCVpQ-0000L6-Ps; Fri, 02 Oct 2026 01:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVow-0008Rc-7L; Fri, 02 Oct 2026 01:28:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xCVot-000831-U6; Fri, 02 Oct 2026 01:28:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922ZYww2274814; Fri, 2 Oct 2026 05:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UjaDBl
 3aAWup+nFCgC7djZBfi0f+vNkd4Lcrii64EVg=; b=YrV6uU6OgrcJh4nVesFEto
 0kNCxnU44sM2LBIITEOQSrsjXzh9t1ZWEBcby4BxcSrJ3ry8OR2i3y2t49gBlA79
 32eiol90m2DngLYf4VYzF+M8FRTudsKup+L8YytlDe2BB2vOJ+xkFHTfe3Fhk00K
 YnTBrmxiFKVTGdNxLgZiADb1DkpXQXGbtnuufwT/pK3gTUIQkq19l8GUm2qkWgue
 LLtbAnf8CbojW/LX/WaBUW3zLXfGPebrn7sa2NvrnCoMKdT5l/QpK7ofeDTAOzS/
 CaEv3EHkMNz03oa+Ifx4RPzY1zRcy4LXO0Noxfmfqcd62OliRfDa7g7BTnS1ShYA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fepafa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6922KBUT1897679; Fri, 2 Oct 2026 05:28:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7xhfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 05:28:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6925SLka32047740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 05:28:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A427858062;
 Fri,  2 Oct 2026 05:28:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E30B258056;
 Fri,  2 Oct 2026 05:28:12 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.111.176]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 05:28:12 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@linaro.org, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, alex.bennee@linaro.org,
 richard.henderson@linaro.org, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH v2 7/8] ppc/spapr: strip OF path argument suffix in
 path_offset
Date: Fri,  2 Oct 2026 10:55:46 +0530
Message-ID: <20261002052605.605858-8-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002052605.605858-1-uverma@linux.ibm.com>
References: <20261002052605.605858-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abf40f8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pqpSryZqIyZLl4xueesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfXxzGL4to0KZFN
 9UWARA72hnoyepaBylcC0sKYDoVWTw9qHqMO8jm811/18vmem5XDZSlk8OoKK2G5g57nIJ7yn3M
 1irZAYkyAgTnWF7hw9WbZ4nnIAh6VzY=
X-Proofpoint-ORIG-GUID: f2y8GdRwNo0UuoalH2jcpb3R4cfUDO5o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyMCBTYWx0ZWRfX+i6jaizvYM+b
 G0P8sByA3KCKAsBQqY83eUKXcqkb1QzFHG1oe7SuzNuZSsC1T+3II4XW4nv4WiZxt+s2f+auxpd
 3r5gyHVjfCFiLyOwKKUnk+cqS/gIJNdOofvIaEfwdXXKokwI2IeXGW2hTI75XlB7DKJr0iQqUnl
 muGSjWA/4pg86SOQjPdv4AT6SUORFPWvU3jccOaWEdzLXfmtQjXuapuYQ4h5ieLaknCwmYd0KdO
 fkxFYrox571geKaYEzztOeadGi4fgWos+KRDnnz0ZngbsXv0m3baWQA7RejJWAAgpxaN0G2X+EB
 leuFaNi5N5NfbHrW/sQ/ja/wgdiE3AsYLpdMinLcNGN361Ei1uyR3w9HglYrLNpA1QfsR+T1eJn
 6IcQ4iiXJw33T6KDrwwjvuH1OqFfHK9qzZG8+paM0boL7jRv+1zF+1HnUKXMpn7sCsexyTBQoXj
 BnVvgzbCai3b59k+QLA==
X-Proofpoint-GUID: gY34ceRdIJiGdwh4eYCVHduA0NGRt51E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
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
 hw/ppc/vof.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index d4b57b3b46..75b2398ae7 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -146,6 +146,7 @@ static int path_offset(const void *fdt, const char *path)
     g_autofree char *p = NULL;
     char *at;
     char *last_slash;
+    char *colon;
     int offset;
 
     /*
@@ -156,6 +157,20 @@ static int path_offset(const void *fdt, const char *path)
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
2.55.0


