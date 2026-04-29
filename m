Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93206FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9jQ-0007gh-6n; Wed, 29 Apr 2026 14:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jO-0007er-DZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9jL-0007A3-Jl
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TGQlud1262225
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iwUegkPNy92tT2KKI
 BBdK8pxen6+oU6N9huKkWVXJZc=; b=BsevSLtORCugGtagGaRUGLVBk6abidOg7
 mdZs/bueqSdE1AcUcd/9pnuRH+CxKcalHocF2fsdgDitbdUZe3P6RaeBzQEGJVF3
 gPQ/fVV/EYliqauA2Q6TERRis3LhfkdYITHztoX8V/E0sNOnMQ/8MMZNvly9O+qt
 N+XyTdZ9w0XFkRRn/TWWa8BT/BI7spOK+Y0zeQoJab+HNCLrAW804cTdFo1c6V7q
 NwZlveV1MPzVSljPloswd65MVJ8dpEz3QrQmb2mXOExKDMzPTPotPFOvceYadVHY
 4EJ6+nRmttzFYbtAbaGByX7mVcaFNB0mbA7EYUNwd0HU/Yy7vUF1g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rc22j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINn5W004858
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyfbje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIXiIB40042788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 18:33:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DC8920049;
 Wed, 29 Apr 2026 18:33:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBC652004E;
 Wed, 29 Apr 2026 18:33:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 18:33:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 06/13] pnv/mpipl: Set thread entry size to be allocated by
 firmware
Date: Thu, 30 Apr 2026 00:02:56 +0530
Message-ID: <20260429183310.12455-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429183310.12455-1-harshpb@linux.ibm.com>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8pozYHaVQOxvEfJWWajN51Dq1PXk7ifw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfXzPrNr7BWqeWy
 JRlkVOTSQqyWJbLKc/zpIYl24qD94e3o8SZTX4DNNZ/unttGueeBi1FDOfH4eXS7Imox4ly1xVX
 mzUYW0s+SiCyCIZDFFrQPnfsdouKDTHBW+WYheoWrd4VglArtLmlCtd+P3ERY0l1V5+NRwadCxh
 H8R21CSxn4jC7RgElfSdLNEExS4p/J/PcujLBT+NzRlIB4I8XPriN5aNrF3+GU6MThRDJwX7Xka
 5aAxZjaDG90Paax6fQSOQw+fDK7f18zEvIDunAIyY/06Ro2qXYCpTgM/yUKhEHG/mr3FpL7yojw
 2FRgBKF4lb1YIUcHWeLzff9Joy94101ieiI3hRit3EC5pVz8wxl6NQ1UERIiQBSQjvBbl1OpGxv
 /mSez/gG1d2latixDRfQ3lnDDJqIH0hI2q6CywPTGyDcNdlJvd3TKDP8tpYnDqNizufnj4puSja
 Ark/lBy/5G8QDsl52Jw==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f24f0c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bbZZDkM4wAf7KGCsbpkA:9
X-Proofpoint-ORIG-GUID: 8pozYHaVQOxvEfJWWajN51Dq1PXk7ifw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

Set the "Thread Register State Entry Size" that is required by firmware
(OPAL), to know size of memory to allocate to capture CPU state, in the
event of a crash

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260424083837.214947-7-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 524563dcfc..09b69c355a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -748,10 +748,35 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
 
 static void pnv_reset(MachineState *machine, ResetType type)
 {
+    PnvMachineState *pnv = PNV_MACHINE(machine);
     void *fdt;
 
     qemu_devices_reset(type);
 
+    if (!pnv->mpipl_state.is_next_boot_mpipl) {
+        /*
+         * Set the "Thread Register State Entry Size", so that firmware can
+         * allocate enough memory to capture CPU state in the event of a
+         * crash
+         */
+
+        MpiplProcDumpArea proc_area;
+
+        proc_area.version = PROC_DUMP_AREA_VERSION_P9;
+        proc_area.thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
+
+        /* These are to be allocated & assigned by the firmware */
+        proc_area.alloc_addr = 0;
+        proc_area.alloc_size = 0;
+
+        /* These get assigned after crash, when QEMU preserves the registers */
+        proc_area.dest_addr = 0;
+        proc_area.act_size = 0;
+
+        cpu_physical_memory_write(PROC_DUMP_AREA_OFF, &proc_area,
+                sizeof(proc_area));
+    }
+
     fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 }
-- 
2.52.0


