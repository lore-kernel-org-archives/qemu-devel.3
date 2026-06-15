Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978A1CD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE49-0002jI-7H; Mon, 15 Jun 2026 16:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE47-0002d8-Js
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE45-00028T-Nm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxYUP861856
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VfMD9EFRY4n
 Ex6Q8u6Yj7x37nxNgGukk970ixrAbK1A=; b=dZ0APxs8gSi//vJ6V+pPC+8Rpnc
 iU9E6OdarsJHTPW+54CXb09nLj1k1fFxlSzs8jeSGvpEiC+rsYFRH29pWVWdRnyY
 eBcMrxXorzP8CP7S2biaZjaeTBcROw2k2wGPxafvD7jIa7ElzZSYZ7pACLUL+p1z
 In+Unm2H8/gBwOjLr5hMjYnPVyrMr0uILzNTAO18RFjbDeE1Pz/sXCpzbReUQRjY
 xgMVsou57Rvj3GtoGblWBS/FOrznze1lwqUhYZ3Qm5fVE+L1IZhS3qzs1N4kS0Sq
 g6SD6fEarV6J3QJaYuSU2c1OzubV4HZblEgkTnvYSOk8G2lctFHP8BKSY7w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydavj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccd83d58d9so55867206d6.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555867; x=1782160667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfMD9EFRY4nEx6Q8u6Yj7x37nxNgGukk970ixrAbK1A=;
 b=BXhYNV4qe4TDEx9aFfR6Cvq0FTePwLGT4aRtIzKd9XaT2ZdNdZs4kTPTZxUnmOnjt5
 UbBJ3MXLhKjDkKCpCFbpXCc4oF/Lm/Oey8iA20iCxhPu/YNu6G0JC8i0Z5EmNwSRXRCW
 iN1sgfs3CCd0ALBDpfBfEK8OzcOnl9r9Nzq6vT8jU/LajF7IwmBV4EDhLE5U7evYTilu
 8eLu/kKDbmtuMw6zAii7hbOOOuUdLct16rSLyti2u/l08EJkjCAx8MfuxuTkzTytlyfN
 S1l+TIFelPs4QJevEqhaELKpmK3h3rDKVkN4EkhsoxZGbZet3h16OpHCrhnLUh2NfAQJ
 5meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555867; x=1782160667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VfMD9EFRY4nEx6Q8u6Yj7x37nxNgGukk970ixrAbK1A=;
 b=KtVsuIuE3rrz02tc719CBQBgRuEaDQlxYXDKUi5pIvUrM4GD8/vrcOvrzvnvIAHcKr
 /ApOZ/4sDlhYfSX9bQ44VkiDSaTiATk7EgIuErOJnS65AAoLA92LVqrhfSgGfgKaw/bS
 pWvlQhCWez0v17yBhKjw08Erzf8aYyjUF1HMQzG01r/OLTmJAEyNcSmaJ4gh7zyaSTZA
 yULnopQmk6ThjvbgsfBoxJ/jkqpnaAMeHzkcn+uSJTNbFE+QCeA3y5QA+HVYyOg2af6H
 PU3xTPqnEDRA+sDU57q6FhfxYUZwZhIYyU9oLWsO5Z7uLocZmLPCTXmaoOPtTP79iNNX
 TJ+g==
X-Gm-Message-State: AOJu0YxUwMEv455UA5Yc6OYgBTLz/Fo3hGhFZGKNiCLQH3E1Ju9ItESM
 Milf+DyaB3cOd0hmZJfv6lEdjYO9PRy5pz0kRWX47ASKT+2b/MIcAKAG5Rt8MYOCjA0Ygg/tDiY
 UCOP9fUi/U85nmpuxaSZwDZzrYEdDkpdnjtmApZ9Yf8nY0MVheCkMKBSQcZQaYLDqXA==
X-Gm-Gg: Acq92OEDnIx0CEjY0EfMiMRcaAzFWueoFlCSM7gKUEpIQjg6XqCqUcP244NSCrL2DfD
 s4ydcrbnxo9bywBQGOA/IyMK0iURg8yPXVFC+uuxqJExhJKIl9CxALF+jNyUs2NpC6RTOkgrzAQ
 c+8oFK1LX4YGWLCq3qRgJeBQe/FIM8P3Jm3uiREHzAotYH2XCL7sRkMJVBWEt1BKekvUAT48IUR
 qkjySCYiBEaopqx2fWd6kXmszYlGddmPAvfg+PrmBG/rZfTw02xoYyjP0ExXPx2ZOHeJndxY6d4
 KS7jqjDdHmcy69qTzgRK6txPNRna6BBicZ6bV9QkzR47Sh13U9I7gtVqmvr4XNNJjCoayDc2IUR
 rX6IKUjq0wz3wTAMIxAGHc+cs4rY5VV/FMd8g+mk1dTUiloM3vO7kKPdoJUY=
X-Received: by 2002:a05:6214:2469:b0:8d1:d1e1:8360 with SMTP id
 6a1803df08f44-8da20d0b968mr11509896d6.39.1781555867055; 
 Mon, 15 Jun 2026 13:37:47 -0700 (PDT)
X-Received: by 2002:a05:6214:2469:b0:8d1:d1e1:8360 with SMTP id
 6a1803df08f44-8da20d0b968mr11509306d6.39.1781555866435; 
 Mon, 15 Jun 2026 13:37:46 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/13] hw/riscv/numa: make numa_enabled() public
Date: Mon, 15 Jun 2026 17:37:23 -0300
Message-ID: <20260615203734.954428-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ROb426S_m_MUSNh4JOb8tmqCWKJaE7si
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX6XFSAMBisJ1O
 sfVVLyAgHA9Wrg4CPGTMTbMPouPOIMYRXlzCvLzcNRrxrY+3RU+JYjsZRpVsZ5MYLNOpWLx6KQp
 BVj9bqZTjuQkiMtzMAx8UfjcigKIY2I=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a30629c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=LPFoBd4iDjH1i6fID-MA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: ROb426S_m_MUSNh4JOb8tmqCWKJaE7si
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfXy+rlk9n02e2j
 nuNyjTJX8ArgYD+gBkHSkxi7U3JsSTUN6tG8g2uD4GCK5sw7Nqd5JDuAkLksf/tkXTfGYDXszdJ
 Re2yda829VsqBxZDilnvdDJxSqSe4Ne3OnUORCLKGJrBiffNJUuDfhYBOWf5W8z4134nNJatIiB
 rSBB0wuqTJvPfporeyHn5B+Tj3gwt6T11iBzg8hj4IvkN9bCcmxla3Xp4xUO3qhau7eZoJUQ8OT
 jLP6XS9oHEh2QUpRhKPobvD/VE4gzfhrYI92we2oIRb4YaqFXtoLIAvr/9KkeQNk0y4Oa2oSzXB
 fb0POFufjjSyRV8x6GxLYsPwTZZxCsbdWuPZbIGVWGJVkJidBOscMWhsBZY682wASgP5RvynmtZ
 s9XYC0LTq3Qxb/cDxSb2sZesirGKwdMQh+GVGV6I92JNawJAD/cMBm3D8d0xExFcVck/iWrIkAC
 ieCu+IXi9gHoNRNcTvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150218
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

There's FDT logic gated around 'numa_enabled()' in virt.c and spike.c.
We want to move the FDT code to a common helper without having to call
hw/riscv/numa.c functions from it, but at the same time being aware of
the FDT changes if numa is enabled.

To do that the boards will inform the FDT helpers if we have
numa_enabled in the env or not.  And for the boards to be able to do
that we need the static 'numa_enabled' function to be public.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/numa.c         | 20 ++++++++++----------
 include/hw/riscv/numa.h |  8 ++++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
index 8a144925c1..8933d9d81f 100644
--- a/hw/riscv/numa.c
+++ b/hw/riscv/numa.c
@@ -25,21 +25,21 @@
 #include "hw/riscv/numa.h"
 #include "system/device_tree.h"
 
-static bool numa_enabled(const MachineState *ms)
+bool riscv_numa_enabled(const MachineState *ms)
 {
     return (ms->numa_state && ms->numa_state->num_nodes) ? true : false;
 }
 
 int riscv_socket_count(const MachineState *ms)
 {
-    return (numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
+    return (riscv_numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
 }
 
 int riscv_socket_first_hartid(const MachineState *ms, int socket_id)
 {
     int i, first_hartid = ms->smp.cpus;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? 0 : -1;
     }
 
@@ -59,7 +59,7 @@ int riscv_socket_last_hartid(const MachineState *ms, int socket_id)
 {
     int i, last_hartid = -1;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? ms->smp.cpus - 1 : -1;
     }
 
@@ -79,7 +79,7 @@ int riscv_socket_hart_count(const MachineState *ms, int socket_id)
 {
     int first_hartid, last_hartid;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? ms->smp.cpus : -1;
     }
 
@@ -104,7 +104,7 @@ bool riscv_socket_check_hartids(const MachineState *ms, int socket_id)
 {
     int i, first_hartid, last_hartid;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? true : false;
     }
 
@@ -132,7 +132,7 @@ uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id)
     int i;
     uint64_t mem_offset = 0;
 
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return 0;
     }
 
@@ -148,7 +148,7 @@ uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id)
 
 uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
 {
-    if (!numa_enabled(ms)) {
+    if (!riscv_numa_enabled(ms)) {
         return (!socket_id) ? ms->ram_size : 0;
     }
 
@@ -159,7 +159,7 @@ uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
 void riscv_socket_fdt_write_id(const MachineState *ms, const char *node_name,
                                int socket_id)
 {
-    if (numa_enabled(ms)) {
+    if (riscv_numa_enabled(ms)) {
         qemu_fdt_setprop_cell(ms->fdt, node_name, "numa-node-id", socket_id);
     }
 }
@@ -170,7 +170,7 @@ void riscv_socket_fdt_write_distance_matrix(const MachineState *ms)
     g_autofree uint32_t *dist_matrix = NULL;
     uint32_t dist_matrix_size;
 
-    if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
+    if (riscv_numa_enabled(ms) && ms->numa_state->have_numa_distance) {
         dist_matrix_size = riscv_socket_count(ms) * riscv_socket_count(ms);
         dist_matrix_size *= (3 * sizeof(uint32_t));
         dist_matrix = g_malloc0(dist_matrix_size);
diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
index e68ce8e8af..ac07786555 100644
--- a/include/hw/riscv/numa.h
+++ b/include/hw/riscv/numa.h
@@ -23,6 +23,14 @@
 #include "hw/core/sysbus.h"
 #include "system/numa.h"
 
+/**
+ * riscv_numa_enabled:
+ * @ms: pointer to machine state
+ *
+ * Returns: true if NUMA is enabled in the machine state.
+ */
+bool riscv_numa_enabled(const MachineState *ms);
+
 /**
  * riscv_socket_count:
  * @ms: pointer to machine state
-- 
2.43.0


