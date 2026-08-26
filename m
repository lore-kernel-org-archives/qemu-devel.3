Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A55C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGo5-0006KQ-T4; Wed, 26 Aug 2026 12:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo0-0006BI-Q1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnx-0000tx-LF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDv0nd4137469
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Vm5RAtIsvyg
 P46EuGukx0Ed9N2TIajYAWhtbSzKTpiw=; b=JGzTl00yG1rw2gBZSr6wBVfNMfu
 2Y4jVmkAsJuu+wBR674+rTYH6h5i0AmjALJvKTTztLtS3Lfr6IZiYHeEpLlYfouY
 3fXRucyuRMBOh3YivaT9Sc5MiK/gTIU9RchYZzBX4VDZcORF1uBGYNu5OwdKfyMP
 BNdXgGiMvm5Dbwl9071YUIuDmN+AjQ/tt5dI7hY57+O6iXSDkQNcIgerv/RFtsE0
 O36yI+YgyJUQRGDzAEvYaa5vR7jOy5tkiP8OBVlAKJOVdKPS5s9/shYtW8G0SjWb
 bVC21Er+2KoSl+fBd+U4aJlMEo/VkW2OYq+hQk09BTG+NOVDhAMGJbehB5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9utht5p1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso17267091cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762917; x=1788367717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vm5RAtIsvygP46EuGukx0Ed9N2TIajYAWhtbSzKTpiw=;
 b=HrgvP/gRd2Rx/fqJ1bGH6pJ6MdfzPFmdR+a3++G84lXytYTRLZKp/ohj+/qMHLonAM
 QVefIkidYe8LvscyihLNzPtNy55nD4u07VHpslzTUnD5rg41gYjpQe/JW9wU4osgiQfS
 OzIbDySYmh31GRXjB6aD7D53TB6UkGBvDa/QZEa7e94EddDs+e3FOaaojv6b+1SGZ4d2
 OyIDkRY76RijtYrv65gETb9SFNljFa+7rfgE2KIBP21ZdYjcFS6u/zWmulW3tDKlXiHz
 tKHs8gt8GDAdRuAucv1x9Rs/ZEDu/9PtUPMw7NykGRPlTGyoamwYZFHfF/wUSV86vcTC
 C5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762917; x=1788367717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vm5RAtIsvygP46EuGukx0Ed9N2TIajYAWhtbSzKTpiw=;
 b=EThhYL0mSbGiPkfo9lE4D+HX2mUv+amYuJ0E23Ch8L4Nvne03xHtOmC78Ncqbwsrrj
 jFAoe4t5FvDMpyTH5qNPfnPX3Xbp+Btch2ChWfODatXUIaXuRmaLXQ6PiwFaj9/mr9dD
 HzqzzACNpSu9uOW3j95lNNwh8NC8tfhH8zveL109iNVfTK7m7OOlXu8B5xU3LaLEl1Yh
 twYj3uOU2kXoOgHbW7XgfmECUrPfGlRKH1VQlZ/L+xJqLEtgin47P1KJaVFhVfVDosDO
 W1Wr4l9oM/wfVRbvB8gFLs7iqxzkKLPU/Ew3hai5QBnaRnsjqZlpv00jX+7hHs92Bc1f
 AeXA==
X-Gm-Message-State: AFuF++kRpVGB3U6yf/h+eCMf7yVqTM+lsNcPBZo4YensFuyHqlsgl63M
 puwTvObXFAjfMGmxfNLHeP3m1ZQS5eY7A4B/UpZNsD7C18qjYVMdbt9A986/loc4gPcTiEVQlCg
 QjbAZ/UTHbtIABZ35YGEIb7bvbDZYT0NJmK56kRW/a2Iid+4mxU1gDTs+ansq1EM01A==
X-Gm-Gg: AR+sD12eioZ4P7aYGa6h6NvEjL5aDvqXjxcwSPbNll3GsX1/UXDvQbnBxESs8o1B7vZ
 koio+yZAOooJc36Fz6r6rFn+ZEXABdCfxZWc0Me38U3ObwPH7Dg0Rt495so2cWV5gyzT9ZMUNfu
 VRmwP0g2wa4/0lsnbr9aGje3fbhwSMJ+mrIn51o5JDi4259OHcFs+pLGFTcb3A9BPTZ2ccbU1SQ
 qPngudGR4JFL3MqCXGWR3wIYRJu1Jl/Z5tUOEAz8Nml8kPZrwZ4EUozhs5rA0fRQCpstAdlR6fG
 r7i3Nn34sxqorwG+f8YddhTQCH70EukINtZSk6IdsRMtoKB5Bh5tRh/CZJUjvd6gzlAxvLPuMJ6
 lJQGf+mnbyODzA0M63vIKbyjqWDqj3sz1c8CxVA==
X-Received: by 2002:a05:622a:2614:b0:528:a8c:aa00 with SMTP id
 d75a77b69052e-52e42234b5dmr87200841cf.8.1787762916948; 
 Wed, 26 Aug 2026 09:48:36 -0700 (PDT)
X-Received: by 2002:a05:622a:2614:b0:528:a8c:aa00 with SMTP id
 d75a77b69052e-52e42234b5dmr87200011cf.8.1787762916248; 
 Wed, 26 Aug 2026 09:48:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 06/13] hw/riscv/fdt_common,
 virt.c: add create_fdt_socket_aplic()
Date: Wed, 26 Aug 2026 13:48:06 -0300
Message-ID: <20260826164814.44335-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f18e5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=IageEFNgCMQ87KM8QjoA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Gy_bG8V7jJdlUj9_3EIPdk2kJ8LjdLLr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX5PxvFXTuO4gA
 1FSvXsO/yE297IiSvjDh9MLTOVMviivSH332Fz9AmpzwtgCpAaVzsnEabJIW5tGxSC7/Itz50tI
 Wevyy533XCLPZ621t21gKjs1sfJt6ymKl0leuePlbmNhuLA20fexFEuYQXknit6d4AQJznAyR9l
 0xMpF11ws7gvi+A7+t9U3lAjDHUCI28/uKzmjlRXQrmzt3FBPWFPM9ZGbthgD60TZ1wRuyazkbJ
 HX2IDcDjR1gGKaVskKGbXbjuUnD+yRMRUC8um8CG8kxjw7uGs0fDftokphgGKRRkmvRhxhEmvmF
 ZCV8aUiKxvSwLbMi5t1t1z+DLM5tfVaPz0J/gSoFgnE+pxRmsHwRNdNbeGXkdS1Sj7cNI5EfXMF
 tzADCymL0sQGA8Ha/lAA7fDSF1pktiUpMWtqRwHfsy0gPyNky/xVT1Ha6+vi+wbQwmd04a7nSoW
 FBBMAWKZhP4kAjtcmJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfXz4YapvFGx17h
 8NDERZJJu34EyIXVhDyGjwdYIrP5IMxYQXd9WwWCyY81yH2qXZOf0G4LC1HCRzVmagQfA608Ogd
 F1JhccAWy3Sp4nEBqTLt+6UJSHXTvrM=
X-Proofpoint-GUID: Gy_bG8V7jJdlUj9_3EIPdk2kJ8LjdLLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Similar to what we did with 'imsic' in the previous patch, including
creating a helper struct to encapsulate the extra arguments required to
create the FDT.

TODO: I believe the tt-atlantis board can use this same helper too.  We
just need to verify how to map the phandles used by it and what the
helper is using (which was inherited by the 'virt' board).

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 106 +++++++++++++++++++++++++++
 hw/riscv/virt.c               | 132 +++++-----------------------------
 include/hw/riscv/fdt-common.h |  18 +++++
 3 files changed, 143 insertions(+), 113 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 6fa2543a2a..77168f5c4f 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -11,6 +11,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
+#include "hw/core/sysbus-fdt.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
@@ -589,3 +590,108 @@ void create_fdt_imsic(void *fdt, IMSICFdtProps *props,
                          imsic_num_bits(props->aia_guests + 1));
 
 }
+
+/* Caller must free string after use */
+static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
+{
+    return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
+                           aplic_addr);
+}
+
+static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
+                                 hwaddr aplic_addr, uint32_t aplic_size,
+                                 uint32_t msi_phandle,
+                                 uint32_t *intc_phandles,
+                                 uint32_t aplic_phandle,
+                                 uint32_t aplic_child_phandle,
+                                 bool m_mode)
+{
+    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
+    static const char * const aplic_compat[2] = {
+        "qemu,aplic", "riscv,aplic"
+    };
+    int cpu;
+
+    for (cpu = 0; cpu < props->num_harts; cpu++) {
+        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
+    }
+
+    qemu_fdt_add_subnode(fdt, aplic_name);
+    qemu_fdt_setprop_string_array(fdt, aplic_name, "compatible",
+                                  (char **)&aplic_compat,
+                                  ARRAY_SIZE(aplic_compat));
+    qemu_fdt_setprop_cell(fdt, aplic_name, "#address-cells",
+                          FDT_APLIC_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, aplic_name,
+                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
+    qemu_fdt_setprop(fdt, aplic_name, "interrupt-controller", NULL, 0);
+
+    if (props->aia_type == AIA_TYPE_APLIC) {
+        qemu_fdt_setprop(fdt, aplic_name, "interrupts-extended",
+                         aplic_cells, props->num_harts * sizeof(uint32_t) * 2);
+    } else {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "msi-parent", msi_phandle);
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, aplic_name, "reg",
+                                 2, aplic_addr, 2, aplic_size);
+    qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,num-sources",
+                          props->irqchip_num_sources);
+
+    if (aplic_child_phandle) {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,children",
+                              aplic_child_phandle);
+        qemu_fdt_setprop_cells(fdt, aplic_name, "riscv,delegation",
+                               aplic_child_phandle, 0x1,
+                               props->irqchip_num_sources);
+    }
+
+    if (props->numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "numa-node-id", props->socket);
+    }
+
+    qemu_fdt_setprop_cell(fdt, aplic_name, "phandle", aplic_phandle);
+}
+
+void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                             uint32_t msi_m_phandle,
+                             uint32_t msi_s_phandle,
+                             uint32_t *phandle,
+                             uint32_t *intc_phandles,
+                             uint32_t *aplic_phandles)
+{
+    uint32_t aplic_m_phandle, aplic_s_phandle;
+    hwaddr aplic_addr;
+
+    aplic_m_phandle = (*phandle)++;
+    aplic_s_phandle = (*phandle)++;
+
+    if (props->aplic_m) {
+        /* M-level APLIC node */
+        aplic_addr = props->aplic_m->base
+                     + (props->aplic_m->size * props->socket);
+        create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_m->size,
+                             msi_m_phandle, intc_phandles,
+                             aplic_m_phandle, aplic_s_phandle,
+                             true);
+    }
+
+    /* S-level APLIC node */
+    aplic_addr = props->aplic_s->base + (props->aplic_s->size * props->socket);
+    create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_s->size,
+                         msi_s_phandle, intc_phandles,
+                         aplic_s_phandle, 0,
+                         false);
+
+    if (!props->socket && props->platform_bus_irq) {
+        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
+                                       props->platform_bus->base,
+                                       props->platform_bus->size,
+                                       props->platform_bus_irq);
+    }
+
+    aplic_phandles[props->socket] = aplic_s_phandle;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0ab91728d9..dd8f5d9d75 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -320,113 +320,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     }
 }
 
-/* Caller must free string after use */
-static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
-{
-    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
-}
-
-static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
-                                 unsigned long aplic_addr, uint32_t aplic_size,
-                                 uint32_t msi_phandle,
-                                 uint32_t *intc_phandles,
-                                 uint32_t aplic_phandle,
-                                 uint32_t aplic_child_phandle,
-                                 bool m_mode, int num_harts)
-{
-    int cpu;
-    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
-    MachineState *ms = MACHINE(s);
-    static const char * const aplic_compat[2] = {
-        "qemu,aplic", "riscv,aplic"
-    };
-
-    for (cpu = 0; cpu < num_harts; cpu++) {
-        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
-    }
-
-    qemu_fdt_add_subnode(ms->fdt, aplic_name);
-    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
-                                  (char **)&aplic_compat,
-                                  ARRAY_SIZE(aplic_compat));
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
-                          FDT_APLIC_ADDR_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
-                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
-    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
-
-    if (s->aia_type == VIRT_AIA_TYPE_APLIC) {
-        qemu_fdt_setprop(ms->fdt, aplic_name, "interrupts-extended",
-                         aplic_cells, num_harts * sizeof(uint32_t) * 2);
-    } else {
-        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
-    }
-
-    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
-                                 2, aplic_addr, 2, aplic_size);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
-                          VIRT_IRQCHIP_NUM_SOURCES);
-
-    if (aplic_child_phandle) {
-        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
-                              aplic_child_phandle);
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
-                               aplic_child_phandle, 0x1,
-                               VIRT_IRQCHIP_NUM_SOURCES);
-    }
-
-    riscv_socket_fdt_write_id(ms, aplic_name, socket);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle);
-}
-
-static void create_fdt_socket_aplic(RISCVVirtState *s,
-                                    int socket,
-                                    uint32_t msi_m_phandle,
-                                    uint32_t msi_s_phandle,
-                                    uint32_t *phandle,
-                                    uint32_t *intc_phandles,
-                                    uint32_t *aplic_phandles,
-                                    int num_harts)
-{
-    unsigned long aplic_addr;
-    MachineState *ms = MACHINE(s);
-    uint32_t aplic_m_phandle, aplic_s_phandle;
-
-    aplic_m_phandle = (*phandle)++;
-    aplic_s_phandle = (*phandle)++;
-
-    if (!kvm_enabled()) {
-        /* M-level APLIC node */
-        aplic_addr = s->memmap[VIRT_APLIC_M].base +
-                     (s->memmap[VIRT_APLIC_M].size * socket);
-        create_fdt_one_aplic(s, socket, aplic_addr,
-                             s->memmap[VIRT_APLIC_M].size,
-                             msi_m_phandle, intc_phandles,
-                             aplic_m_phandle, aplic_s_phandle,
-                             true, num_harts);
-    }
-
-    /* S-level APLIC node */
-    aplic_addr = s->memmap[VIRT_APLIC_S].base +
-                 (s->memmap[VIRT_APLIC_S].size * socket);
-    create_fdt_one_aplic(s, socket, aplic_addr, s->memmap[VIRT_APLIC_S].size,
-                         msi_s_phandle, intc_phandles,
-                         aplic_s_phandle, 0,
-                         false, num_harts);
-
-    if (!socket) {
-        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
-                                       s->memmap[VIRT_PLATFORM_BUS].base,
-                                       s->memmap[VIRT_PLATFORM_BUS].size,
-                                       VIRT_PLATFORM_BUS_IRQ);
-    }
-
-    aplic_phandles[socket] = aplic_s_phandle;
-}
-
 static void create_fdt_pmu(RISCVVirtState *s)
 {
     g_autofree char *pmu_name = g_strdup_printf("/pmu");
@@ -453,6 +346,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     int socket_count = riscv_socket_count(ms);
     bool numa_enabled = riscv_numa_enabled(ms);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
+    APLICFdtProps aplic_props;
 
     fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
@@ -508,15 +402,26 @@ static void create_fdt_sockets(RISCVVirtState *s,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
+    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
+        aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
+        aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
+        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
+        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
+        aplic_props.socket = 0;
+        aplic_props.num_harts = ms->smp.cpus;
+        aplic_props.numa_enabled = numa_enabled;
+        aplic_props.irqchip_num_sources = VIRT_IRQCHIP_NUM_SOURCES;
+        aplic_props.aia_type = s->aia_type;
+    }
+
     /*
      * With KVM AIA aplic-imsic, using an irqchip without split
      * mode, we'll use only one APLIC instance.
      */
     if (!virt_use_emulated_aplic(s->aia_type)) {
-        create_fdt_socket_aplic(s, 0,
+        create_fdt_socket_aplic(ms->fdt, &aplic_props,
                                 msi_m_phandle, msi_s_phandle, phandle,
-                                &intc_phandles[0], xplic_phandles,
-                                ms->smp.cpus);
+                                &intc_phandles[0], xplic_phandles);
 
         *irq_mmio_phandle = xplic_phandles[0];
         *irq_virtio_phandle = xplic_phandles[0];
@@ -531,11 +436,12 @@ static void create_fdt_sockets(RISCVVirtState *s,
                                        &intc_phandles[phandle_pos],
                                        xplic_phandles);
             } else {
-                create_fdt_socket_aplic(s, socket,
+                aplic_props.socket = socket;
+                aplic_props.num_harts = s->soc[socket].num_harts;
+                create_fdt_socket_aplic(ms->fdt, &aplic_props,
                                         msi_m_phandle, msi_s_phandle, phandle,
                                         &intc_phandles[phandle_pos],
-                                        xplic_phandles,
-                                        s->soc[socket].num_harts);
+                                        xplic_phandles);
             }
         }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index ab77bbda12..7a7e3ad7af 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -12,6 +12,7 @@
 #include "target/riscv/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "exec/hwaddr.h"
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
@@ -50,6 +51,17 @@ typedef struct IMSICFdtProps {
     int aia_guests;
 } IMSICFdtProps;
 
+typedef struct APLICFdtProps {
+    const MemMapEntry *aplic_m;
+    const MemMapEntry *aplic_s;
+    const MemMapEntry *platform_bus;
+    int platform_bus_irq;
+    int socket;
+    int num_harts;
+    bool numa_enabled;
+    int irqchip_num_sources;
+    int aia_type;
+} APLICFdtProps;
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
@@ -94,4 +106,10 @@ void create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
 void create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
                       uint32_t *phandle, uint32_t *intc_phandles,
                       uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
+void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                             uint32_t msi_m_phandle,
+                             uint32_t msi_s_phandle,
+                             uint32_t *phandle,
+                             uint32_t *intc_phandles,
+                             uint32_t *aplic_phandles);
 #endif
-- 
2.43.0


