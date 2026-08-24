Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1615CC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOj9-0003FU-B4; Mon, 24 Aug 2026 03:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wyOj7-0003F4-6Z; Mon, 24 Aug 2026 03:04:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wyOj5-0007xg-LZ; Mon, 24 Aug 2026 03:04:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5W9cu858587; Mon, 24 Aug 2026 07:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vrIX+DqtusjLBeYBhOPo2Pbt5LIN3pkz2CS34loIG
 Ng=; b=LqtKYCvRvfFvFeQPMC1KcgxzaQDWxlPo07Jm0fmOFytCDVKAF0rTzoxd0
 QP+Xb9nJrAGGjRuTURlvNu6rQZ+7PxaCaeTGMQexCwWNQkqp7hQxRlDzzbtTovht
 sDR9gTkIN5W+RRKk8qyuMfVUa/WKjKjSVYR1sB40npPBPAvB0nfYQ+lu/ovOnnaQ
 YmUDOPfghjh4DjG5/PT/7CtLu0VZkrSl3mYhjGv8+Vq3mWMtCeGCHHUZQYP0G8bG
 ZbstaVZvvOiucUUR3aTc79ZoQn8bcC38CEevj38zJwcFcsCN7Wby00iLoIwSO3E7
 5jAEGMh1zPZrpIr1PcX4cOWO42xBA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hfxy3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 07:04:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O6uJXZ007801;
 Mon, 24 Aug 2026 07:04:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvvm1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 07:04:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67O73uX046072252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 07:03:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D59E2004D;
 Mon, 24 Aug 2026 07:03:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 350A220043;
 Mon, 24 Aug 2026 07:03:55 +0000 (GMT)
Received: from dhcp-9-123-15-208.bl1-in.ibm.com (unknown [9.123.15.208])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 07:03:55 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: milesg@linux.ibm.com, clg@kaod.org, harshpb@linux.ibm.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] ppc/xive: Trigger the pending interrupt for a guest after
 migration
Date: Mon, 24 Aug 2026 12:33:52 +0530
Message-ID: <20260824070353.40016-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfX8PXqUB6iYLsL
 aQ13/dL7GlpthH8uq6qkJpMWPd5vPgxhtjSlx6JGHkutgqurLiTeozlHTtIyK798VYF6l5gD1ZY
 ewa7V+AtfWxa6Cf0BLYPox+J0ob+Bws=
X-Proofpoint-GUID: SyhQcWW5tzS0l5BC_W_9ykzX3J7Nrmzb
X-Proofpoint-ORIG-GUID: SyhQcWW5tzS0l5BC_W_9ykzX3J7Nrmzb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MCBTYWx0ZWRfX6jH24Lg/VjXi
 hcWcjoGwN5sNKrIzr7xgVQ/M8kHEnaN7nIpLx/nVRTrsoH8RIkeQHKxbAxuxObbbjzgRk8Qtuns
 iM7BtoDk5fXkbzFN4LAUsw5bYsW4OHI8nX89HGKrZPQpreCL0ij07C0nw5PXRu+tu7WTF1xS3Lo
 DE530JTYeNbNs1nqN8KgdpQOp0OY/rKhstQqUH4QmuNhhcNbBneX69FJZNG2f1D2DIJSZmxdDDi
 Yof6lsHSk93dCLlb7oA91VCrFqq+q9PbDf6zbx3hf2wm2Ep9yVq/CqxfYXREDX+TtT5laAHfb8+
 mdL71MrfQRabr0bnl78d5lHlKWABZJB6hlyfvROi2Mfv2Wr2wHBIOTJv/ZzyfNhaFKd2ndDefak
 o2K3RWdtecfLORuxbiRPVlnhiF+lmDyaQN1ECtXCQvN5ZPd2CWcOmVBFRPnyImWes6MOoSHQ9VI
 HDhTp3KQ8YOZjiiM4ug==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8bece1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=FGLFIaoaJNZaP0LMaNcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
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

When a KVM guest is migrated to another LPAR while a stress-ng workload
is running, lockups are seen when the guest resumes on the destination
LPAR. This root cause is that if there was a pending interrupt for a cpu
on the source machine but it was not presented yet when the migration
started, the interrupt is not retriggered on the destination LPAR. This
is evident when running 'info pic' on the destination LPAR:

$ virsh qemu-monitor-command --hmp migrate 'info pic' | grep -e OS -e MSI
CPU[0000]:   OS    00   ff  00    ff   ff  00  ff   ff  80000400
CPU[0001]:   OS    00   ff  00    ff   ff  00  ff   ff  80000401
CPU[0002]:   OS    00   ff  00    ff   ff  00  ff   ff  80000402
CPU[0003]:   OS    00   ff  00    ff   ff  00  ff   ff  80000403
CPU[0004]:   OS    00   ff  00    ff   ff  00  ff   ff  80000404
CPU[0005]:   OS    00   ff  00    ff   ff  00  ff   ff  80000405
CPU[0006]:   OS    80   ff  02    ff   ff  00  ff   06  80000406
CPU[0007]:   OS    00   ff  00    ff   ff  00  ff   ff  80000407
  00000000 MSI --    00000010   0/6   3071/16384 @3710000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000001 MSI --    00000010   1/6   1852/16384 @3980000 ^1 [ 80000010 80000033 80000033 80000033 80000033 ^00000000 ]
  00000002 MSI --    00000010   2/6   4424/16384 @40c0000 ^1 [ 80000020 80000020 80000020 80000010 80000010 ^00000000 ]
  00000003 MSI --    00000010   3/6   1913/16384 @4220000 ^1 [ 80000010 80000032 80000010 80000010 80000010 ^00000000 ]
  00000004 MSI --    00000010   4/6   2946/16384 @4360000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000005 MSI --    00000010   5/6   2313/16384 @44a0000 ^1 [ 80000010 80000010 80000010 80000010 80000010 ^00000000 ]
  00000006 MSI P-    00000010   6/6   5825/16384 @45f0000 ^1 [ 80000024 80000024 80000024 80000010 80000016 ^00000000 ]
  00000007 MSI --    00000010   7/6   2346/16384 @4760000 ^1 [ 80000032 80000032 80000010 80000032 80000032 ^00000000 ]

Fix this by calling xive_tctx_pipr_set() in
vmstate_xive_tctx_post_load(), which ends up calling qemu_irq_raise() to
present the interrupt.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 hw/intc/xive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f473e6ac77..712498d4af 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1080,6 +1080,9 @@ static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
             error_report_err(local_err);
             return ret;
         }
+    } else {
+        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
+        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
     }
 
     return 0;
-- 
2.53.0


