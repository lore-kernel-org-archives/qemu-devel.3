Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EE3C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wynAJ-0003G2-Qw; Tue, 25 Aug 2026 05:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wynAH-0003Dp-TP; Tue, 25 Aug 2026 05:09:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wynAF-0004kv-TG; Tue, 25 Aug 2026 05:09:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P8Vo8u2649851; Tue, 25 Aug 2026 09:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+ah21WNWXv0OSeLhQ
 TeeMweyXpYN4h1B5zCB2EbdSAk=; b=TpInGuPu7ASoMKmXgaQJC/637MJEvlHs5
 LLXTV/TjP6XJRqXj3yAY3CtgiYE4aIC37M2IKvOVOu6kpe4isxj/RWP208aTjsA8
 VUqxHg3DZb2R+S4p69dvzywillyZTQ8+nPK5wIOOf6EVIIq3mX1Lf6PM/mG9nlye
 WwTsfGNB21Rh132MK1KjA6pq1MTyanT+v/Q5p21cgsInh0lFetKfMHUoQ0fCbEgJ
 RhCXiI11moi/w0bURlgLCrdEL1rzQbn4nBc2iylmSbT87GYnRmG9X1D8dRkoxoXX
 0zrxFKbLf72w8ZsWNsTUg4JLSZfaQmwmZxAgb6imqT473QQv+CiPA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqq3xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 09:09:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P8uFb9029858;
 Tue, 25 Aug 2026 09:09:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragb5wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 09:09:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67P99hBM48431500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 09:09:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C77862004E;
 Tue, 25 Aug 2026 09:09:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0064020049;
 Tue, 25 Aug 2026 09:09:40 +0000 (GMT)
Received: from shivang.com (unknown [9.39.21.24])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 09:09:39 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivangu@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, mahesh@linux.ibm.com, sourabhjain@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, npiggin@gmail.com
Subject: [PATCH v3 1/1] hw/ppc/fadump: report CPU_STATE_DATA dumped_bytes as
 source_len
Date: Tue, 25 Aug 2026 14:39:32 +0530
Message-ID: <20260825090932.1748581-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825090932.1748581-1-shivangu@linux.ibm.com>
References: <20260825090932.1748581-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mmxYHQD9IKlUzPBq5f_kp0RCHjILaUzn
X-Proofpoint-ORIG-GUID: h0J7lpy4HUH0X7hacn61vaCzH2C4gLft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3NiBTYWx0ZWRfX5pOdEq+w+DZH
 LbHObpCPbtRCAfTacjACK2wXU6Qs2XhzcXhagXI+4SgXifoaAce4ymchRaHOa8py9gKP1KIZAPd
 Mn2HuFqHX8D3nFvVtUOjrNOvDCOXz1ZVPy3cPE3xxi4OehQfhxUgTJcB+CO8ftYyfW3Dbb/UbR0
 N4uorCK/0vQTGWiqwYqwpURDuWnNnq0XFmbhZ0reI0vmkdJhVV2xiFeMzzQJ4kvLdY2WEfGWEUO
 tUzEQ9Tx8LVnMfYqGSBCKF3RXGzXlkPJfyCdV64QXaEeLWG/oBMIkpnw4wt/FqMWja+xxQw2ZwG
 bDCVbWX0//lBeQ/MYR4uvJzn0YXDm4TUoHJFzn/CP93zNTwpPWksOpFlrX5cVS7PjnqbHOImAd+
 LR57atXwx68o9GpQ8ZB2V8vBcxwUSHfNY1LfjECzoisuqU6kH8fSz2a3hhOJRccGZApFNhaoIBP
 7z9hLNxLVWE+SLRndUg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8d5bde cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=9AdMxfjQAAAA:20 a=VnNF1IyMAAAA:8
 a=aOBHJuWvkIX5ObeMfrkA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3NiBTYWx0ZWRfX2FkQJjI4G5E/
 5rCUkJnZieEwek/HQ/zSfeWsbc651IGdxFjaLVrVbPvqJ6JKNw6MIZ41wqGXC3Ev1LkApZ404iq
 6dlOiejmfnCNVA2DsikWv2YFf14102I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250076
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

When system is restarted with fadump, cpu registers data is copied
to CPU_STATE_DATA region. The size of data depends on the number of
cpus that are currently present in the system. But when maxcpus config
option is provided in qemu command line, this causes the linux kernel to
allocate extra space for CPU_STATE_DATA region. If there are no hotplug
operations, this will lead to part of region being empty.

As per current Linux kernel, It expects the size of collected Fadump
region to be exactly equal to allocated size. Otherwise
kernel assumes that dump is incomplete [1].

If maxcpus option is used, This causes qemu to send partially filled
region, and Kernel then rejects to collect to any dump. As a result of
this /proc/vmcore is not generated.

To fix this, Changing fadump to always report CPU_STATE_DATA's
dumped_bytes as source_len. This behaviour is also noticed in Phyp.

[1] https://github.com/torvalds/linux/blob/66498c75b4f8017f62d720d9b59675bdf3abce91/arch/powerpc/platforms/pseries/rtas-fadump.c#L472
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>
Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 13cab0cfe1..c0f6474ae9 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -575,8 +575,9 @@ static bool do_populate_cpu_state(FadumpSection *region)
 
     if (region->source_len != region->bytes_dumped) {
         /*
-         * Log the error, but don't fail the dump collection here, let
-         * kernel handle the mismatch
+         * Log the error, but don't fail the dump collection here.
+         * This is probably because of maxcpus config. Linux kernel would
+         * not collect any dump if dumped_bytes does not match source_len.
          */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "FADump: Mismatch in CPU State region's length exported:"
@@ -584,6 +585,8 @@ static bool do_populate_cpu_state(FadumpSection *region)
                 " QEMU exported: 0x%" PRIx64 " bytes\n",
                 be64_to_cpu(region->source_len),
                 be64_to_cpu(region->bytes_dumped));
+
+        region->bytes_dumped = region->source_len;
     }
 
     return true;
-- 
2.54.0


