Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B7F588E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpvM-0007HM-N6; Mon, 20 Apr 2026 10:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wEpv4-0007DW-Ti; Mon, 20 Apr 2026 10:48:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wEpv2-00043s-HO; Mon, 20 Apr 2026 10:48:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JMxEEO3987518; Mon, 20 Apr 2026 14:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bbee+mJ4QD1RQq4eM
 GJeyWU3Gcfnd+tOzJ9Ywx3bZh8=; b=exEaRoRfTGlOaSPxZ9H7DnNoD/4AqAe2i
 bVGZBdCqkZN0PAnMFA/gbbSsh7Ksmk+Mt2UluzgkXK7+ZzJDp5o7vnwM541QsdB9
 NS20TpWY0CrhWrcCY1rTF8kyz09PSjsla9KTWIdSsKQOq4rp6HFDuNvn/HXhgbGN
 QbHMp9l80QZN9G6AWZi5PXPT6ZmkNONLUiSvc3e0C7SEo6Xg0FxbECJHspuL4o/d
 K4QiSeEfKzBahq2O9ntEOq5yVs5yKvK0lwp7Xky0tZxVKvqvgqIYgCUxHk+sEf8K
 ePRyqAFZGSC6BJU19faQDSfdtEJ1yGJut55c8E44t3nweY+6OLuvQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0qk8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 14:48:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KEcdCG010575;
 Mon, 20 Apr 2026 14:48:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg50de-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 14:48:07 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63KEm5i77537360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 14:48:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AE855803F;
 Mon, 20 Apr 2026 14:48:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1ECD58054;
 Mon, 20 Apr 2026 14:48:04 +0000 (GMT)
Received: from IBM-GLTZVH3.atx-us.ibm.com (unknown [9.16.58.46])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 14:48:04 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, cohuck@redhat.com,
 Jaehoon Kim <jhkim@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 1/1] hw/s390x/ccw: Disable legacy virtio-pci by default
 (v11.1+)
Date: Mon, 20 Apr 2026 09:47:34 -0500
Message-ID: <20260420144759.2970726-2-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420144759.2970726-1-jhkim@linux.ibm.com>
References: <20260420144759.2970726-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BiXcPx_nXbwyAQWg-y7hCn5cVr4WVXdr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEzOSBTYWx0ZWRfX/ihP8h4NPRmc
 Ltl+rpDxKQ3SyJzeCSim2NP9cuDcH9TiqsWOwmjZYCsP7jjB47cL/f0KnzARLPtYE1mnoEWgMyX
 4k/3HmpN5xTmdwljFNzxzyhHmLf2Z/psLTU2ptNDw2zNCs0pttSQKH0nIeyeFgvSOH/U5d1mlrX
 vTYroQKyWqLsix4dOhHhhorOaIKxI8UsgiPiJC4oCyRTmm7RAiDmYIKoLfzrLDY18IwI4rC92eS
 xsj9ZV2IRMYCLt9sBvGOREM4dDqOQN5Fp929uPz++BwvWNxJp5D0LmHDjlFnXj6SeU6GGmYvrid
 hNnDxdN3PkQNYsZldVv1tYAthFFblo2+OjGTSneWx79pEmO3O6l05o+dNZQGEGteRk4mmonlm8Q
 HRsgPvO4afEoxIag5uQ44Y6e2DKejj/ry/n1FKHb3W4FiwjJ+mAuIo/Br7fh0l37XgU3gNWZO1r
 QcMMc3SL6vSVwpG5sEQ==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e63ca8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=my5jLqFW4fTaoRaGlZgA:9
X-Proofpoint-GUID: BiXcPx_nXbwyAQWg-y7hCn5cVr4WVXdr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/s390x/s390-virtio-ccw.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cc768daeb0..4d35f9b10b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -788,6 +788,21 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     g_free(val);
 }
 
+ /*
+  * S390x-specific global compatibility properties.
+  *
+  * On the s390 kernel, legacy virtio-pci is not usable because I/O BARs
+  * are not supported (IO_SPACE_LIMIT is 0), and would only result in
+  * unusable BARs and firmware warnings.
+  *
+  * Therefore, starting from v11.1, disable legacy virtio-pci by default,
+  * while older machine types keep legacy behavior for compatibility.
+  */
+static GlobalProperty hw_compat_s390x[] = {
+    { TYPE_VIRTIO_PCI, "disable-legacy", "on", .optional = true},
+};
+static const size_t hw_compat_s390x_len = G_N_ELEMENTS(hw_compat_s390x);
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -878,6 +893,9 @@ static const TypeInfo ccw_machine_info = {
         const void *data)                                                     \
     {                                                                         \
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
+        /* Apply global s390x-wide default properties */                      \
+        compat_props_add(mc->compat_props, hw_compat_s390x,                   \
+                         hw_compat_s390x_len);                                \
         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
         mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
         mc->init = MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__);              \
@@ -923,7 +941,15 @@ static void ccw_machine_11_0_instance_options(MachineState *machine)
 
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


