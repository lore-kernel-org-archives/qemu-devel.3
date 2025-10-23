Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B854CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtkm-0001it-Mz; Thu, 23 Oct 2025 07:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkP-0001IT-4S
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkM-0001an-Im
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7kbFT015153;
 Thu, 23 Oct 2025 11:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3evc8z
 gMd4yDoo0HZUV76MwS81vhCGcm/t7SODkPzw4=; b=fm1NWELtNtbwdn/uzHs4iy
 YAjgr6CPEAASOS0uzTpVNG/lmwfpCYrDZEJNJLyfPVxrfgqy+lfo5CelF0ZEOjUE
 uL/p5IrJgzB7pWj8lcX/vvhzSaefKMDw+8BkCRcReWpbAylEA4Ch5QtsTyiLub4M
 pfNmNdWlxZwxqtOndLAGpB9S/8HW6HNpX1rWEHMDwrSi9VLYoWBXeyxIT2Hgy2bf
 zdvsmIfI7pOPxM54cnDDfbnuYoHC7ULslmZABJUy+TclozE3ALFkXEiqtBM93Sn9
 q1WXbxAm3iHtxeezkbRLeH1HFGncbrpxpohfyIJSwkf+Np9BAMNmqLctYsq3GwRw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s9w9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAO12Q024677;
 Thu, 23 Oct 2025 11:44:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5dru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBiX8U31916532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37A062004E;
 Thu, 23 Oct 2025 11:44:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B65A20049;
 Thu, 23 Oct 2025 11:44:32 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/32] ppc/spapr: remove deprecated machine pseries-3.1
Date: Thu, 23 Oct 2025 17:13:50 +0530
Message-ID: <20251023114422.3675018-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NLp6IHAwkFYwz8Zo97dFLfqenw8b49r8
X-Proofpoint-GUID: NLp6IHAwkFYwz8Zo97dFLfqenw8b49r8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1MzE2k7Hxwpg
 z0WzcEu3QgQ8ACGPwVdh+xgRSTXD95r4LYQ3x5mdqprXofjQLseS1d090INCOQwh9sHamWy/lL6
 BsgPPBg9jK6Nv8WY4WL6x06YhbYN8u21b8no2Cl+/tKd9xk1yCJ/Ly6Omopw3lPVLiYwUUiQMMX
 YGg7Zcc2TT5OhAXPAdFtgCiu/KvKcBcY+nsQ25t7X6T8xxVKFV7/P8/9HBY9P2Sk5LKGIxlD9to
 FHARe/byep9+RnPxk8o9wPXVG05tS6PEQQH7KOsmTOi6v1Xg6+Y0AKNaqTa/Km8J2ALFarkFpfv
 wHxkRWg+tj8Q5sWQ4bi5SK6OZjv95NNcTNLcAyGcf7OLscmQEDl0KUHxigRZ01Su8cFBDxmnqnI
 rCy2z5PsYS/1Tcy2n2s1I0Ica5lMlg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fa1524 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=aow-egSQAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Yh3J_22oyFJWg4qsq-cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=gFNbaldVC-z-bsjSTzMo:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

pseries-3.1 had been deprecated and due for removal now as per policy.
Also remove backward compatibility flags and related code introduced for
pre pseries-4.0 machines.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-4-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  3 --
 hw/ppc/spapr.c         | 62 ++++--------------------------------------
 hw/ppc/spapr_hcall.c   |  5 ----
 3 files changed, 5 insertions(+), 65 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 494367fb99..1db67784de 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,9 +143,6 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
-    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7be7fdaed8..efeea03741 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1182,7 +1182,6 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     uint32_t root_drc_type_mask = 0;
     int ret;
     void *fdt;
@@ -1213,16 +1212,10 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
     /* Host Model & Serial Number */
     if (spapr->host_model) {
         _FDT(fdt_setprop_string(fdt, 0, "host-model", spapr->host_model));
-    } else if (smc->broken_host_serial_model && kvmppc_get_host_model(&buf)) {
-        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
-        g_free(buf);
     }
 
     if (spapr->host_serial) {
         _FDT(fdt_setprop_string(fdt, 0, "host-serial", spapr->host_serial));
-    } else if (smc->broken_host_serial_model && kvmppc_get_host_serial(&buf)) {
-        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
-        g_free(buf);
     }
 
     _FDT(fdt_setprop_cell(fdt, 0, "#address-cells", 2));
@@ -1260,9 +1253,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 
     /* ibm,drc-indexes and friends */
     root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_LMB;
-    if (smc->dr_phb_enabled) {
-        root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
-    }
+    root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PHB;
+
     if (mc->nvdimm_supported) {
         root_drc_type_mask |= SPAPR_DR_CONNECTOR_TYPE_PMEM;
     }
@@ -2063,9 +2055,7 @@ static const VMStateDescription vmstate_spapr_irq_map = {
 
 static bool spapr_dtb_needed(void *opaque)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
-
-    return smc->update_dt_enabled;
+    return true; /* backward migration compat */
 }
 
 static int spapr_dtb_pre_load(void *opaque)
@@ -3009,10 +2999,8 @@ static void spapr_machine_init(MachineState *machine)
      * connectors for a PHBs PCI slots) are added as needed during their
      * parent's realization.
      */
-    if (smc->dr_phb_enabled) {
-        for (i = 0; i < SPAPR_MAX_PHBS; i++) {
-            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
-        }
+    for (i = 0; i < SPAPR_MAX_PHBS; i++) {
+        spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
     }
 
     /* Set up PCI */
@@ -4095,11 +4083,6 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const unsigned windows_supported = spapr_phb_windows_supported(sphb);
     SpaprDrc *drc;
 
-    if (dev->hotplugged && !smc->dr_phb_enabled) {
-        error_setg(errp, "PHB hotplug not supported for this machine");
-        return false;
-    }
-
     if (sphb->index == (uint32_t)-1) {
         error_setg(errp, "\"index\" for PAPR PHB is mandatory");
         return false;
@@ -4125,16 +4108,10 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
 static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
-    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(dev);
     SpaprDrc *drc;
     bool hotplugged = spapr_drc_hotplugged(dev);
 
-    if (!smc->dr_phb_enabled) {
-        return;
-    }
-
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
     /* hotplug hooks should check it's enabled before getting this far */
     assert(drc);
@@ -4260,7 +4237,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     SpaprMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_memory_hot_unplug_supported(sms)) {
@@ -4275,10 +4251,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
         }
         spapr_core_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
-        if (!smc->dr_phb_enabled) {
-            error_setg(errp, "PHB hot unplug not supported on this machine");
-            return;
-        }
         spapr_phb_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
         spapr_tpm_proxy_unplug(hotplug_dev, dev);
@@ -4634,7 +4606,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
     hc->unplug = spapr_machine_device_unplug;
 
-    smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
@@ -4688,7 +4659,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
-    smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
     smc->smp_threads_vsmt = true;
     xfc->match_nvt = spapr_match_nvt;
@@ -5032,28 +5002,6 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(4, 0);
 
-/*
- * pseries-3.1
- */
-static void spapr_machine_3_1_class_options(MachineClass *mc)
-{
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
-
-    spapr_machine_4_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
-
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
-    smc->update_dt_enabled = false;
-    smc->dr_phb_enabled = false;
-    smc->broken_host_serial_model = true;
-    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
-    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
-}
-
-DEFINE_SPAPR_MACHINE(3, 1);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8c1e0a4817..8f03b3e776 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1475,16 +1475,11 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_ulong dt = ppc64_phys_to_real(args[0]);
     struct fdt_header hdr = { 0 };
     unsigned cb;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     void *fdt;
 
     cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
     cb = fdt32_to_cpu(hdr.totalsize);
 
-    if (!smc->update_dt_enabled) {
-        return H_SUCCESS;
-    }
-
     /* Check that the fdt did not grow out of proportion */
     if (cb > spapr->fdt_initial_size * 2) {
         trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
-- 
2.43.5


