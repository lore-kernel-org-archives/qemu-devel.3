Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1470C3ABB6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXDV-00076z-PE; Wed, 07 May 2025 01:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uCXDT-00073k-TS; Wed, 07 May 2025 01:21:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uCXDR-0001ap-0W; Wed, 07 May 2025 01:21:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546L3SZe003934;
 Wed, 7 May 2025 05:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YGURCI
 TXgckFLvg2FDLUvRxXeyv0czX3xzmOC3jOUt0=; b=F9vfKvKYZ8cm39VehVBzKL
 q+216Fra8hkyJSV1+l73E4gC/G+M3+s9tb2QPLXhveSXswJ3LvHp+Rp341clCHxR
 pmkydbMqPH0dnJiIyEb7RR68jO6AB9MRaz5QrhtFr8QeH+ut18tMhEI/ehRU8FlB
 DuD9U7jB2SVIyeAcNgKD6uG/KvG7jaif1EeEyjI5L24DZKTVBLoeo3bVeHrsKBB+
 aXiynxcxbinZONY8sHy43GEm6KkkpdXXVykIYpc9WEJAE0BpI+VBczlsRogjV8lj
 FwUsfkvtD8cuipn8WGj7FSkGBsA1V+VS9rvfSDrZOyV7yNh1ERmFCsU7TZeWMu0g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ft0m9p02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5475CnMo006679;
 Wed, 7 May 2025 05:20:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ft0m9p01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5473cWQo001353;
 Wed, 7 May 2025 05:20:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftfaxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 05:20:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5475KtJX58655006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 05:20:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1C6F2007B;
 Wed,  7 May 2025 05:20:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD10220040;
 Wed,  7 May 2025 05:20:54 +0000 (GMT)
Received: from ltcblue8v9-lp2.aus.stglabs.ibm.com (unknown [9.40.192.95])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 May 2025 05:20:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH 2/3] ppc/spapr: remove deprecated machine pseries-3.1
Date: Wed,  7 May 2025 01:20:47 -0400
Message-ID: <20250507052048.90559-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507052048.90559-1-harshpb@linux.ibm.com>
References: <20250507052048.90559-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _nxVKjcnYyqO_lhTryj_R1c9uc5PQmVw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA0NSBTYWx0ZWRfX70ikWGHnV4Ng
 fKsoIQWnGKnFqKMVQAOFYcOo3cVZS/GDwke8H9Vho+eSxP5n5Sh8194vgFkYmKOtQXtC9wNQRJY
 tR2vJtlRDG0Lz/XAaq6qHE84NymMnbpev9Uuj8d2ep+CHysIrVmidkiPlVk5ZbkrF8xYDqFyEU8
 dJBk8c2bIbkjFD88guX+SSwAFMHjnDRJcb3En3TZ6S9i9i/N6flhZyacwTjmBf8pc/+P6qxdmR8
 8kUbqugEMKuA7EIpy2pPfXvknZaM43ngBZYaieoL0JrfYws5ad/DLjW9NJgltaHsDP8I/zjABy7
 T/p3idZ/WCTGEZPJ/x/dgihjMQXpJSWpUi2SQNFy65YRplvFmEaCJAzceGEvl7WLeYmf3+SB6i0
 yh+np/+jo+kZRGg/BdhLY6aza+8vA/GqUR4zIaPXHMjf3mDnwZE6SqG2b1Vl54aoq71x86GN
X-Authority-Analysis: v=2.4 cv=U4eSDfru c=1 sm=1 tr=0 ts=681aedba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=f7IdgyKtn90A:10 a=aow-egSQAAAA:8
 a=VnNF1IyMAAAA:8 a=Yh3J_22oyFJWg4qsq-cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: YGWPbhx5trcMsXz3vzBcYdVUxeIZ__gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070045
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  3 --
 hw/ppc/spapr.c         | 64 ++++--------------------------------------
 hw/ppc/spapr_hcall.c   |  5 ----
 3 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0c1e5132de..02b66f7ffa 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,10 +143,7 @@ struct SpaprMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
-    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
     uint32_t nr_xirqs;
-    bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d17f4b808..44b9fc3ab6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1180,7 +1180,6 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     uint32_t root_drc_type_mask = 0;
     int ret;
     void *fdt;
@@ -1211,16 +1210,10 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
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
@@ -1258,9 +1251,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
 
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
@@ -2061,9 +2053,7 @@ static const VMStateDescription vmstate_spapr_irq_map = {
 
 static bool spapr_dtb_needed(void *opaque)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
-
-    return smc->update_dt_enabled;
+    return true; /* backward migration compat */
 }
 
 static int spapr_dtb_pre_load(void *opaque)
@@ -3007,11 +2997,9 @@ static void spapr_machine_init(MachineState *machine)
      * connectors for a PHBs PCI slots) are added as needed during their
      * parent's realization.
      */
-    if (smc->dr_phb_enabled) {
-        for (i = 0; i < SPAPR_MAX_PHBS; i++) {
-            spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
-        }
-    }
+     for (i = 0; i < SPAPR_MAX_PHBS; i++) {
+         spapr_dr_connector_new(OBJECT(machine), TYPE_SPAPR_DRC_PHB, i);
+     }
 
     /* Set up PCI */
     spapr_pci_rtas_init();
@@ -4093,11 +4081,6 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
@@ -4123,16 +4106,10 @@ static bool spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
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
@@ -4258,7 +4235,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     SpaprMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(sms);
-    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_memory_hot_unplug_supported(sms)) {
@@ -4273,10 +4249,6 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
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
@@ -4637,7 +4609,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
     hc->unplug = spapr_machine_device_unplug;
 
-    smc->update_dt_enabled = true;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
@@ -4691,7 +4662,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
-    smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
     smc->smp_threads_vsmt = true;
     smc->nr_xirqs = SPAPR_NR_XIRQS;
@@ -5025,28 +4995,6 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
 
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
index 1e936f35e4..cf92a74251 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1476,16 +1476,11 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
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
2.49.0


