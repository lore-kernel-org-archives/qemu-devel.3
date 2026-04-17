Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1642F436B8
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDlMR-0000wf-9k; Fri, 17 Apr 2026 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDlMM-0000vl-LQ; Fri, 17 Apr 2026 11:43:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wDlML-0006TC-2G; Fri, 17 Apr 2026 11:43:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HDV5kb2205111; Fri, 17 Apr 2026 15:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BxybZn66XCrc8P0j4
 DwuJFQxCmW6tFhy0lt83D36CrQ=; b=jWy4Ph/+XD2iXFQ0FgJnoOqIhtFW5ywdH
 X98T5COynr0J61oOnSZESgyJfJ+giUYJ5rVoBwkoV9YpwRJIECbN0Jk56/3JhWPm
 2xfRJFmE+5M37ioGBtnB4dDefHRGS1igLIr6+j4Patdc/5viqky35ZC7mUny8Bia
 16zxzXGhetAem4I2Rot/VdtvaP8I6J6QQA7GxtLcaiN9StVbFPAGh8tvzCSxGufK
 zZd+3kfRzJbSn7k6VZ60G9RddGM8XLuXXadwLkFijo2ROqrBxpR/GhyOAvenXr1E
 SXPhtHwuHpJF1LwsQAeM4hJGAe6ytAPjeMwB/mtvINnTFDDKWlrwA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89ruc67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:43:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HC6VfB015621;
 Fri, 17 Apr 2026 15:43:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mt010e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 15:43:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HFhpa210158622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 15:43:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B3E15805D;
 Fri, 17 Apr 2026 15:43:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD26358052;
 Fri, 17 Apr 2026 15:43:50 +0000 (GMT)
Received: from IBM-GLTZVH3.atx-us.ibm.com (unknown [9.16.58.46])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2026 15:43:50 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, cohuck@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH RFC v1 1/1] hw/s390x/ccw: Disable legacy virtio-pci by default
 (v11.1+)
Date: Fri, 17 Apr 2026 10:43:08 -0500
Message-ID: <20260417154332.849664-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417154332.849664-1-jhkim@linux.ibm.com>
References: <20260417154332.849664-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NCBTYWx0ZWRfX6Lc06qA/F7Bh
 A1oo3fj07zfnAbeWscr9/M6C3CGllPNTsT6YIt+lE1jAbXNxT7BBuhVgtx3p7zg4HrHHWi3YHAw
 290Cu072SoK1rcoqmKtHlxEPRP3rvwja/Wm3tQ1iZf+hee8MzJCkHSriTEcOKji4S3A73160yzL
 yjWvsVpVl+ayHYy3l0BYuzPWV9KI/Vu3T+FCrq0MDxmp412w6uX6V5JdteYuD8Um+Lp3rQx5e+R
 Iy4rXdkPe4W1Pt8KeoQ+GyksQizEfWLxshapKfCMeibarTrO2i84nHQo0+oLSTnllHsQr2ZXAsd
 0WsQmujLbXYwtGzF+d8j/aZiSrbY0U2EXJ/sZ4QHjj7R28kEhUqVxHw4zwl1kG5Mkg2slcFb8SM
 F+2rpdfuoGKjIaHBikkdi328za/MrohcRArWaURE2i+x7BMfKmRvGGMseFkFx1cfFc21HWy1kdo
 nUb2QAaUCjF7Ii7BlXw==
X-Proofpoint-ORIG-GUID: zzRtW-IuBlASfYvfDchdnBokwnsWpa6H
X-Proofpoint-GUID: zzRtW-IuBlASfYvfDchdnBokwnsWpa6H
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e25538 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=my5jLqFW4fTaoRaGlZgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
zPCI implementation (commit cd24834130ac "s390/pci: base support"),
making I/O BARs unusable.

However, when virtio-pci devices operate in transitional mode, QEMU
unconditionally exposes the legacy interface via BAR0. This results in
firmware warnings during PCI enumeration, such as:

  pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size

even though BAR0 is never usable on the s390 kernel.

Close this gap by disabling legacy virtio-pci support starting from
machine version 11.1. This effectively makes virtio-pci devices
non-transitional and prevents the creation of the unusable legacy I/O
BAR.

This introduces s390x-specific global compatibility properties that
set disable-legacy=on as the default for virtio-pci devices. Machine
versions v11.0 and earlier set disable-legacy=off to maintain their
original default behavior (legacy support enabled), ensuring VMs
created with those versions continue to work identically.

Users can override the default on the command line if needed:
  - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
  - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cc768daeb0..6fbea1e289 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -788,6 +788,18 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     g_free(val);
 }
 
+/*
+ * S390x-specific global compatibility properties.
+ *
+ * Set disable-legacy=on as the default for virtio-pci devices starting
+ * from v11.1. Machine versions v11.0 and earlier set disable-legacy=off
+ * to maintain their original default behavior (legacy support enabled).
+ */
+static GlobalProperty hw_compat_s390x[] = {
+    { TYPE_VIRTIO_PCI, "disable-legacy", "on", .optional = true},
+};
+static const size_t hw_compat_s390x_len = G_N_ELEMENTS(hw_compat_s390x);
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -878,6 +890,9 @@ static const TypeInfo ccw_machine_info = {
         const void *data)                                                     \
     {                                                                         \
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
+        /* Apply global s390x-wide default properties */                      \
+        compat_props_add(mc->compat_props, hw_compat_s390x,                   \
+                         hw_compat_s390x_len);                                \
         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
         mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
         mc->init = MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__);              \
@@ -923,7 +938,15 @@ static void ccw_machine_11_0_instance_options(MachineState *machine)
 
 static void ccw_machine_11_0_class_options(MachineClass *mc)
 {
+    /*
+     * Preserve v11.0 and older version behavior:
+     * keep legacy virtio-pci enabled.
+     */
+    static GlobalProperty compat[] = {
+        { TYPE_VIRTIO_PCI, "disable-legacy", "off" },
+    };
     ccw_machine_11_1_class_options(mc);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
 }
 DEFINE_CCW_MACHINE(11, 0);
-- 
2.50.1


