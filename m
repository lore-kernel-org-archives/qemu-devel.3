Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA5CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4e-00033r-E1; Mon, 15 Jun 2026 16:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4d-00033Q-H3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4b-0002Dz-PX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:23 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx6cP3578156
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wKEor47NbLS
 cwX/g4lVMu6L2DhfHhbRrWJeN0erWBWw=; b=M5azKEfAAebU62hU6qgJTHyEfGh
 m0SXGZIWgMYjQlbMhYcFQ9OZRAxeHyjeJM7YcGbqe8NM279Tft3y06o1EqhheGYd
 H6aQwcAUuMJKZZaASQPieRkTvEEkKkE/Q8UfwHQISnp9HEbYiaf0Z7KTS7DPvCtC
 /g9muR9quDtndbJMFsG0ZvYV0iVOu3pzQvXX/gXDKmwQX4MOomjNjc56yb/ezZfF
 feJdoI0vKA3W1kDtBpDkEmaE79+7NYdolJsqzH7c8LOeRZQapkWYiF7MVS6yvKAo
 +ACjMbN8Uc1VSm8TgPr2KkZKg6zGVW8YReei0CyXQFr3lrfRi61U1d/c8RA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete9832ax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:38:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5175a1e32e3so100050241cf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555889; x=1782160689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKEor47NbLScwX/g4lVMu6L2DhfHhbRrWJeN0erWBWw=;
 b=UhTLVUEIbEs5/4Zb5rjVVqt+AgVBdV7lfPvRSAaTpeuN9BLX5lIfeQ+fqVfSP8Yi25
 bc/yZ0YdnqbryWJVJgd6gqdx5eXH9SNG6NUZuy3vuv0geirlCA2xEp4wW1WGhOlaZqGE
 SDeZgajgZcvvhN00k5M4xuAA2x3iYhFz5RRtPKUKRNNpNnEuCMFdHglRHJbQz5wsbk7R
 JXM6lAJ7WM9NbJSnI31RkxscJl0/xsw8wSygezC2B02m4FINC37Ei9FUoG1ZudqmXG4B
 Xr/hfJI+GMhnqK9F7kovUvU8OkBm2PB+Ka6CQkd7DcmJzSMci+K5gAl5x30VnscVTeNM
 qwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555889; x=1782160689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wKEor47NbLScwX/g4lVMu6L2DhfHhbRrWJeN0erWBWw=;
 b=pEx1vPA2LC9LNPTpjdTSfSkz1Kn0fxt817uxx2LNnIAWOnZohXqXU79+oZ77qVp32s
 oxKnmK+KHHnD7rTFVVSe21TszYq+LVYvGGe6SJaoWFeI2R8fx//Hn5Y1H2sOLMci5Gii
 2a7tHnhhGyUd8NhkawEhzy1vcleTdGNgImBWTdvggeJArQw0uguViQ5JVuZWBFWIJzEI
 XiCBlikm+UkdEMckQzqjztuqO3mXvNjYc9Nydr/l05CiJQUkmp8kk96UwXyIvHEkfwei
 HiUm5PtkpSXxFwI0VsSeCu6G/exciWEFjtSjYVDH+wEGY2XgrdVVrbJsAKpdhpDoXcoY
 hcrQ==
X-Gm-Message-State: AOJu0YxbRdUhMNhM6C34XUMuQ4Ejydi/e6ZQN2CcW3R/4tTlibO0Dp5b
 xxanA1TFHLBOxBwks/BAVf47vkTnpjQZtS5IJnbvy8nR/UOhGqXGDdTFXWR5vUhxgA3rAKg1ITZ
 qi24LdwsAvlGf5fuzuYDumM7/OPPuTzUrROEL3QMYHTEr+A5GRWrLUtDyPGS1oQU8Iw==
X-Gm-Gg: Acq92OFUnA123G816iXnOwoEQdCHNemp3bhSPuWwBu9MJmFi3aY0rWGQoDRJ5Ze5/7q
 xmljvNYN1wcSe10heVgf9acEOty5TgjfcCrcCvJVAfWweMGeQnd2w0xC8cOlT9ys3KGHlagc+mS
 zGPgRBlAiQsp8HAiGd/BpLnxSBntwPHY2/KEWtkDa8hnPNQsWOOILyazS+/g0a4+Uqm5E/xhJpk
 EOJH2VC9/uyOTzgFPs85TsLwV8W4MxotRpSuu6PMAmA1Cyka1jUVg9MWFCdly+VIQPweA7A97V7
 kWklw2WonRIcrF6WY6dmgbhbGxXBmM8rMJagTJ18fYyxzxOYkVfWVRGAH0iQpVc3JQqLiu45JEH
 /D57r2s0WHNIDQcf1lY4nuT5/2ZyLJiC+NXnYUW7LXn3kG4tRmWaO1AHK7eE=
X-Received: by 2002:a05:622a:4fc8:b0:517:7971:a234 with SMTP id
 d75a77b69052e-51953360166mr145911071cf.4.1781555888736; 
 Mon, 15 Jun 2026 13:38:08 -0700 (PDT)
X-Received: by 2002:a05:622a:4fc8:b0:517:7971:a234 with SMTP id
 d75a77b69052e-51953360166mr145910721cf.4.1781555888337; 
 Mon, 15 Jun 2026 13:38:08 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:38:07 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 12/13] hw/riscv/fdt_common.c: create
 create_fdt_socket_cpu_internal()
Date: Mon, 15 Jun 2026 17:37:32 -0300
Message-ID: <20260615203734.954428-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a3062b1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=uOZKRBi9aaBGZPAeGrsA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Faks9pys6zRduTGL-BZZ6Xg8Ct-BwtNC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOSBTYWx0ZWRfX4rrPO2+d0Ude
 CkRzDaKQVWUP1EhrXNqU/y0MMdX8mBFuqRvTYTRIK2MFo4BoCjmoYQAFnEJoV8gWtx3A3h7dC6C
 SHlvAoYIlnLLnOhseqCKgQPavrlERRU=
X-Proofpoint-ORIG-GUID: Faks9pys6zRduTGL-BZZ6Xg8Ct-BwtNC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOSBTYWx0ZWRfX69KY9CtphXW3
 +wLM3ocVqW1XkomBT3nICnuzGsl7X5AOxM1aEO1+OwrVSmwDfdKHYafheD7SSOcX6T6jpyWPmxl
 XxMB4cAWq9jtbYr+CtKsDjUppWh7EBc6ONMSIOtjwiatp02H5ABIlq6VMHzan495fhQ0gMYiYZs
 S9KHpc81fe0ZElQ25/1FDW4dJ8caw5F9H3dTcSnXymgBDNkiTe7+8kp8boM/1DanCUHAF+NZ+YM
 tjvYqetD0AcyaG+WCPVd2Ktzkei2yIJGut4tmofzj9EPVryPFasXcOiZNFzR1kFAcoIoq9OOfqx
 bQu9h8sKRO3UycE1900QD0PnOgasw6/sNrLYwNVOSIMskJ8qdvChoDR65/1aS3u4kTtGaNkJdtu
 ZGj8FLYfTdSv6TCCtDk5HRXvmEiMhRJkHBkiRPMpSun+PJIiLGbyujrvOOcF2t5CS68Gie+GlNW
 ZLK3BvquVQaaw5gVkIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The sifive_u board does not share the same CPU socket FDT bits from the
other boards.  In particular the riscv,isa creation is done using either
CPU0 from soc.e_cpus.harts, and for all other CPUs soc.u_cups.harts is
used.

It would be too cumbersome to add all these details in the common code
so we're going to add a special sifive_u only helper that shares the
common bits with the common helper used by the other boards.

create_fdt_socket_cpu_internal() contains the common bits shared between
the sifive_u board and the rest.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c | 108 +++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 43 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 6c795409a4..70168ad657 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -94,28 +94,29 @@ void fdt_create_cpu_socket_subnode(void *fdt, uint64_t timebase_frequency)
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 }
 
-void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
-                            int socket_id, int num_harts_socket,
-                            int socket_hartid_base, uint32_t *phandle,
-                            uint32_t *intc_phandles, bool numa_enabled,
-                            bool is_32_bit)
+static void
+create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cpu_ptr,
+                               int cpu, int socket_id, int socket_hartid_base,
+                               uint32_t *phandle, uint32_t *intc_phandles,
+                               bool numa_enabled, bool is_32_bit)
 {
-    g_autofree char *clust_name = NULL;
-    uint32_t cpu_phandle;
-
-    clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id);
-    qemu_fdt_add_subnode(fdt, clust_name);
-
-    for (int cpu = num_harts_socket - 1; cpu >= 0; cpu--) {
-        RISCVCPU *cpu_ptr = &socket_harts[cpu];
+    g_autofree char *cpu_name = NULL;
+    g_autofree char *core_name = NULL;
+    g_autofree char *intc_name = NULL;
+    uint32_t cpu_phandle = (*phandle)++;
+    bool is_sifive_u = cpu_ptr == NULL;
+
+    cpu_name = g_strdup_printf("/cpus/cpu@%d", socket_hartid_base + cpu);
+
+    /*
+     * The sifive_u board has an exclusive satp and riscv,isa
+     * schema that can't be shared with other boards, so part
+     * of the CPU FDT creation (i.e. the /cpus/cpu@N subnode)
+     * is still being done by the board.
+     */
+    if (!is_sifive_u) {
         int8_t satp_mode_max = cpu_ptr->cfg.max_satp_mode;
-        g_autofree char *cpu_name = NULL;
-        g_autofree char *core_name = NULL;
-        g_autofree char *intc_name = NULL;
-
-        cpu_phandle = (*phandle)++;
 
-        cpu_name = g_strdup_printf("/cpus/cpu@%d", socket_hartid_base + cpu);
         qemu_fdt_add_subnode(fdt, cpu_name);
 
         if (satp_mode_max != -1) {
@@ -140,30 +141,51 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
             qemu_fdt_setprop_cell(fdt, cpu_name, "riscv,cbop-block-size",
                                   cpu_ptr->cfg.cbop_blocksize);
         }
+    }
 
-        qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
-        qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
-        qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
-                              socket_hartid_base + cpu);
-        qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
-        if (numa_enabled) {
-            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_id);
-        }
-        qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
-
-        intc_phandles[cpu] = (*phandle)++;
-
-        intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
-        qemu_fdt_add_subnode(fdt, intc_name);
-        qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
-                              intc_phandles[cpu]);
-        qemu_fdt_setprop_string(fdt, intc_name, "compatible",
-                                "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
-
-        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
-        qemu_fdt_add_subnode(fdt, core_name);
-        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+    qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+    qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+    qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                          socket_hartid_base + cpu);
+    qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+    if (numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket_id);
+    }
+    qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
+
+    intc_phandles[cpu] = (*phandle)++;
+
+    intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
+    qemu_fdt_add_subnode(fdt, intc_name);
+    qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
+                          intc_phandles[cpu]);
+    qemu_fdt_setprop_string(fdt, intc_name, "compatible",
+                            "riscv,cpu-intc");
+    qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
+
+    core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+    qemu_fdt_add_subnode(fdt, core_name);
+    qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+}
+
+void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
+                            int socket_id, int num_harts_socket,
+                            int socket_hartid_base, uint32_t *phandle,
+                            uint32_t *intc_phandles, bool numa_enabled,
+                            bool is_32_bit)
+{
+    g_autofree char *clust_name = NULL;
+
+    clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket_id);
+    qemu_fdt_add_subnode(fdt, clust_name);
+
+    for (int cpu = num_harts_socket - 1; cpu >= 0; cpu--) {
+        RISCVCPU *cpu_ptr = &socket_harts[cpu];
+
+        create_fdt_socket_cpu_internal(fdt, clust_name, cpu_ptr, cpu,
+                                       socket_id, socket_hartid_base,
+                                       phandle, intc_phandles, numa_enabled,
+                                       is_32_bit);
     }
 }
-- 
2.43.0


