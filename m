Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F73C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SUd-0002JJ-Rd; Tue, 01 Sep 2026 13:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUc-0002Ic-7G; Tue, 01 Sep 2026 13:41:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUZ-0001A7-PJ; Tue, 01 Sep 2026 13:41:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H4wWD1782834; Tue, 1 Sep 2026 17:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FmbjQPgbbsZQ4S3Su
 Szt0YAgZkAxY3tvdgF/o5k3rqw=; b=AV4TLBDH0ljL3Aa/pYlgDROnm18rvYutc
 hyXjyPnetXNiRjyUSr2EIHvCEep0btU8bLOrYnkurY7r/BLLahlpujPBma7lg/Or
 ySfH0cIsXpEXS4/SD1X4kXOMSMv6ZJyx9l4s/F3Z31BcFiy/IYuiYqQRcrH1noiS
 gjWyFVogvvuFx8X2WBCYqYW0k+i9+19RLIx4QAKsUW9186/eiRCB4kFT3ea9EB5W
 2FaMa+3nUGwEdgq4TC76aA44nhuCbmGvnlHF1DpJStqv9kw6fkOvbEMD01ci5NX3
 DZ1ARPdO7M1QIuPwIBf1IhhBtSB8r/Z9ddd/KxJP8gN4Xv6ODq6hg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54sfpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681HQLh3026084;
 Tue, 1 Sep 2026 17:41:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark529a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:41:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 681HfgSY46137752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 17:41:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD83220043;
 Tue,  1 Sep 2026 17:41:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53C1E2004B;
 Tue,  1 Sep 2026 17:41:39 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.219.126])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 17:41:39 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v5 2/6] ppc/spapr: Add ibm,errinjct RTAS call handler
Date: Tue,  1 Sep 2026 23:11:06 +0530
Message-ID: <20260901174110.45356-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX/Fd6vom+C7Pr
 v2fxfdKJvn1T72Or3S6LjXkLn9D3rN7DIiXbeHzcBH7OEMt/TyS32VprycYsCe+dN/9nLj4LqUs
 kC7dMRXQOc3Um4id0WaFPF2X9mJp+UeWRoj6+3VK3bqiA8TxkzlIO9C95iqB0POyhnaaIzwM6+L
 c2muIk1vI9rm1a+1/Phdg/51zaSv1B8iPUaSbh9YILOsfEeHuEGSIn7NY+mXQ6tgi8LF0r+iUWD
 tRLdTGtoIVipik3Rofo9pkr+Qt0fjvckr/JpFSeAzOKCRClljYC7pnxikr6avHcTy/QfnXAKN1p
 anB5DpIHw+t8KQmycPP+6Vn5vRLUHS2pWOHP2d+ptWmPHZiZZ4Qfpgrf/xxAqat7aiQRRYt13gl
 uif3UKYOEZJUQeb7zJFJUJfjp7dZ31Py+HdVJmfrpJDIoH5BAglydgyWaT9iq2N38a2Z48pOMuf
 J5ggqOMRp4V6ed63akQ==
X-Proofpoint-ORIG-GUID: KlxmL0Jru6BoCKGsElzgS9B5VTEx40j6
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a970e5d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ckvBqbd_4HPzd86GAI0A:9
X-Proofpoint-GUID: 6qJbETqgdJ-_MIydWgP2ZUrxm0T_mGyq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfXz5J0zNAaJcvz
 WhSnRIJjfwoRS6YQgQ4JV0UN0ex+byPlG0R0BpF9l8vhhIav71kfqMplXJ2nwldjQbNTBIJqFNZ
 HI7fIm/V5ECHmU7TSRVbWkBni1U4KZ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010155
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Implement the 'ibm,errinjct' RTAS call for PHB-level PCI error injection
via firmware.  The handler decodes the RTAS parameter buffer, validates
arguments, selects the target PHB by BUID, and delegates the injection
to the VFIO EEH backend.

IOA bus-error injection (types 0x7 and 0xF) is fully supported:
  - The BUID field in the RTAS parameter block selects the target PHB
    via spapr_pci_find_phb();
  - For addr != 0 or mask != 0 the guest BAR address is translated to
    the corresponding host resource base address before calling the VFIO
    backend.  Translation matches the guest BAR layout under the
    selected PHB, computes offset = guest_addr - guest_bar, reads the
    host sysfs resource file for the matching BAR, and yields
    host_addr = host_bar + offset.
  - For addr == 0 and mask == 0 translation is skipped and zero
    addr/mask are forwarded directly (powerpc-utils errinjct -a 0 -m 0).

Non-IOA error types (corrupted-page, dcache, icache, tlb,
recovered-special-event) are decoded and validated, then rejected with
RTAS_OUT_NOT_SUPPORTED because their RTAS work buffers do not carry a
BUID, making safe VFIO PHB/PE selection impossible.

The translation helpers added to spapr_pci_vfio.c:
  - spapr_phb_vfio_translate_errinjct_addr() - public entry point
  - spapr_vfio_errinjct_find_bar_cb()        - per-device BAR scan
  - spapr_vfio_errinjct_get_host_bar()       - host sysfs BAR reader

config_addr is retained as a logging/debug parameter only; PHB
selection relies on BUID.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 include/hw/pci-host/spapr.h |  11 ++
 include/hw/ppc/spapr.h      |   3 +
 hw/ppc/spapr_pci.c          | 135 ++++++++++++++++++++++++
 hw/ppc/spapr_pci_vfio.c     | 203 ++++++++++++++++++++++++++++++++++++
 4 files changed, 352 insertions(+)

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 24109409f4..492f66e1ef 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -127,6 +127,10 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
 int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
                             uint32_t func, uint64_t addr, uint64_t mask);
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr);
 #else
 static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
@@ -159,6 +163,13 @@ static inline int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
 {
     return RTAS_OUT_NOT_SUPPORTED;
 }
+static inline int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                                         uint32_t config_addr,
+                                                         uint64_t guest_addr,
+                                                         uint64_t *host_addr)
+{
+    return -ENOTSUP;
+}
 #endif
 
 void spapr_phb_dma_reset(SpaprPhbState *sphb);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 253dc0e862..47791c71bd 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -274,6 +274,9 @@ struct SpaprMachineState {
     bool fadump_registered;
     bool fadump_dump_active;
     FadumpMemStruct registered_fdm;
+
+    /* ibm,errinjct session token (0 = no session open) */
+    uint32_t errinjct_token;
 };
 
 #define H_SUCCESS         0
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c1d4b7806e..cff12ef268 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -704,6 +704,138 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
+static int spapr_errinjct_parse_ioa_bus_error(target_ulong param_buf,
+                                              bool is_64bit,
+                                              uint64_t *addr, uint64_t *mask,
+                                              uint32_t *config_addr,
+                                              uint64_t *buid, uint32_t *func)
+{
+    if (is_64bit) {
+        *addr        = ((uint64_t)rtas_ld(param_buf, 0) << 32) |
+                       rtas_ld(param_buf, 1);
+        *mask        = ((uint64_t)rtas_ld(param_buf, 2) << 32) |
+                       rtas_ld(param_buf, 3);
+        *config_addr = rtas_ld(param_buf, 4);
+        *buid        = ((uint64_t)rtas_ld(param_buf, 5) << 32) |
+                       rtas_ld(param_buf, 6);
+        *func        = rtas_ld(param_buf, 7);
+    } else {
+        *addr        = rtas_ld(param_buf, 0);
+        *mask        = rtas_ld(param_buf, 1);
+        *config_addr = rtas_ld(param_buf, 2);
+        *buid        = ((uint64_t)rtas_ld(param_buf, 3) << 32) |
+                       rtas_ld(param_buf, 4);
+        *func        = rtas_ld(param_buf, 5);
+    }
+    return RTAS_OUT_SUCCESS;
+}
+
+/*
+ * Non-IOA RTAS error types (page corrupt, dcache, icache, tlb, special
+ * event) are validated but not supported for VFIO injection.  VFIO EEH
+ * is PE/PHB-scoped and those work buffers do not carry a BUID, so QEMU
+ * cannot select the right VFIO container safely.
+ */
+static void spapr_errinjct_return_non_ioa_unsupported(target_ulong rets)
+{
+    rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+}
+
+static void rtas_ibm_errinjct(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                              uint32_t token, uint32_t nargs,
+                              target_ulong args, uint32_t nret,
+                              target_ulong rets)
+{
+    SpaprPhbState *sphb = NULL;
+    target_ulong param_buf;
+    uint64_t addr = 0, mask = 0, buid = 0;
+    uint64_t inject_addr = 0;
+    uint32_t config_addr = 0;
+    uint32_t func = 0;
+    uint32_t type, o_token;
+    bool is_64bit;
+    int ret;
+
+    if (nargs != 3 || nret != 1) {
+        goto param_error_exit;
+    }
+
+    type    = rtas_ld(args, 0);
+    o_token = rtas_ld(args, 1);
+    param_buf = rtas_ld(args, 2);
+
+    if (!param_buf) {
+        goto param_error_exit;
+    }
+
+    if (!spapr->errinjct_token || o_token != spapr->errinjct_token) {
+        goto param_error_exit;
+    }
+
+    switch (type) {
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+        is_64bit = (type == RTAS_ERR_TYPE_IOA_BUS_ERROR_64);
+        ret = spapr_errinjct_parse_ioa_bus_error(param_buf, is_64bit,
+                                                 &addr, &mask,
+                                                 &config_addr, &buid, &func);
+        if (ret != RTAS_OUT_SUCCESS) {
+            goto param_error_exit;
+        }
+        break;
+
+    case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
+    case RTAS_ERR_TYPE_CORRUPTED_PAGE:
+    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
+    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
+    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
+    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
+    case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
+    case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
+        spapr_errinjct_return_non_ioa_unsupported(rets);
+        return;
+
+    default:
+        goto param_error_exit;
+    }
+
+    /* IOA path: BUID selects the target PHB */
+    if (!buid) {
+        goto param_error_exit;
+    }
+
+    sphb = spapr_pci_find_phb(spapr, buid);
+    if (!sphb) {
+        error_report("ibm,errinjct: no PHB for BUID=0x%016" PRIx64, buid);
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    inject_addr = addr;
+
+    /*
+     * addr=0, mask=0 means a non-address-scoped IOA injection.  This
+     * matches powerpc-utils errinjct -a 0 -m 0 behaviour; skip translation
+     * and forward addr/mask as zero.
+     */
+    if (addr || mask) {
+        ret = spapr_phb_vfio_translate_errinjct_addr(sphb, config_addr,
+                                                     addr, &inject_addr);
+        if (ret) {
+            rtas_st(rets, 0, ret == -EOPNOTSUPP ? RTAS_OUT_NOT_SUPPORTED
+                                                 : RTAS_OUT_PARAM_ERROR);
+            return;
+        }
+    }
+
+    ret = spapr_phb_vfio_errinjct(sphb, type, func, inject_addr, mask);
+    rtas_st(rets, 0, ret);
+    return;
+
+param_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+}
+
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
@@ -2380,6 +2512,9 @@ void spapr_pci_rtas_init(void)
     spapr_rtas_register(RTAS_IBM_SLOT_ERROR_DETAIL,
                         "ibm,slot-error-detail",
                         rtas_ibm_slot_error_detail);
+    spapr_rtas_register(RTAS_IBM_ERRINJCT,
+                        "ibm,errinjct",
+                        rtas_ibm_errinjct);
 }
 
 static void spapr_pci_register_types(void)
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 7afca0cec6..2f428531cc 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -318,6 +318,201 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
     return RTAS_OUT_SUCCESS;
 }
 
+typedef struct SpaprVFIOErrinjctBarMatch {
+    uint64_t guest_addr;
+
+    PCIDevice *pdev;
+    VFIOPCIDevice *vdev;
+    int bar;
+
+    uint64_t guest_bar_start;
+    uint64_t bar_size;
+    uint64_t offset;
+} SpaprVFIOErrinjctBarMatch;
+
+static VFIOPCIDevice *spapr_vfio_errinjct_pci_to_vfio(PCIDevice *pdev)
+{
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI)) {
+        return NULL;
+    }
+
+    return container_of(pdev, VFIOPCIDevice, parent_obj);
+}
+
+static void spapr_vfio_errinjct_find_bar_cb(PCIBus *bus,
+                                            PCIDevice *pdev,
+                                            void *opaque)
+{
+    SpaprVFIOErrinjctBarMatch *ctx = opaque;
+    VFIOPCIDevice *vdev;
+    int bar;
+
+    if (ctx->pdev) {
+        return;
+    }
+
+    vdev = spapr_vfio_errinjct_pci_to_vfio(pdev);
+    if (!vdev) {
+        return;
+    }
+
+    for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+        pcibus_t guest_bar_start;
+        uint64_t bar_size;
+        uint64_t offset;
+
+        bar_size = vdev->bars[bar].region.size;
+        if (!bar_size) {
+            continue;
+        }
+
+        guest_bar_start = pci_get_bar_addr(pdev, bar);
+        if (guest_bar_start == PCI_BAR_UNMAPPED) {
+            continue;
+        }
+
+        if (ctx->guest_addr < guest_bar_start ||
+            ctx->guest_addr - guest_bar_start >= bar_size) {
+            if (vdev->bars[bar].mem64) {
+                bar++;
+            }
+            continue;
+        }
+
+        offset = ctx->guest_addr - guest_bar_start;
+
+        ctx->pdev = pdev;
+        ctx->vdev = vdev;
+        ctx->bar = bar;
+        ctx->guest_bar_start = guest_bar_start;
+        ctx->bar_size = bar_size;
+        ctx->offset = offset;
+
+        return;
+    }
+}
+
+static int spapr_vfio_errinjct_get_host_bar(VFIOPCIDevice *vdev,
+                                            int bar,
+                                            uint64_t *host_bar_start)
+{
+    g_autofree char *path = NULL;
+    g_autofree char *contents = NULL;
+    char *line;
+    char *saveptr = NULL;
+    unsigned long long start;
+    unsigned long long end;
+    unsigned long long flags;
+    int i;
+
+    if (!vdev || !host_bar_start || bar < 0 || bar >= PCI_STD_NUM_BARS) {
+        return -EINVAL;
+    }
+
+    /*
+     * Read the host Linux sysfs resource file for the BAR.  Do not use a
+     * VFIO PCI config-space read because that may return the
+     * guest-programmed BAR value rather than the host resource address.
+     */
+    path = g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%u/resource",
+                           vdev->host.domain,
+                           vdev->host.bus,
+                           vdev->host.slot,
+                           vdev->host.function);
+
+    if (!g_file_get_contents(path, &contents, NULL, NULL)) {
+        error_report("vfio/eeh errinjct: failed to read %s", path);
+        return -ENOENT;
+    }
+
+    line = strtok_r(contents, "\n", &saveptr);
+
+    for (i = 0; line; i++, line = strtok_r(NULL, "\n", &saveptr)) {
+        if (i != bar) {
+            continue;
+        }
+
+        if (sscanf(line, "%llx %llx %llx", &start, &end, &flags) != 3) {
+            error_report("vfio/eeh errinjct: malformed %s BAR%d",
+                         path, bar);
+            return -EINVAL;
+        }
+
+        if (!start || end < start) {
+            error_report("vfio/eeh errinjct: invalid host resource BAR%d "
+                         "start=0x%llx end=0x%llx flags=0x%llx",
+                         bar, start, end, flags);
+            return -EINVAL;
+        }
+
+        *host_bar_start = start;
+        return 0;
+    }
+
+    return -EINVAL;
+}
+
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr)
+{
+    PCIHostState *phb;
+    SpaprVFIOErrinjctBarMatch ctx = {
+        .guest_addr = guest_addr,
+        .pdev       = NULL,
+        .vdev       = NULL,
+        .bar        = -1,
+    };
+    uint64_t host_bar_start;
+    int rc;
+
+    if (!sphb || !host_pci_bus_addr) {
+        return -EINVAL;
+    }
+
+    phb = PCI_HOST_BRIDGE(sphb);
+
+    /*
+     * BUID has already selected @sphb before this helper is called.
+     * config_addr is retained for logging/debug only.  Do not rely on it
+     * to find the target device; some RTAS IOA buffers may not carry a
+     * valid guest BDF-style config address.  Scan VFIO BARs under this
+     * PHB and match guest_addr against the guest BAR layout instead.
+     */
+    pci_for_each_device_under_bus(phb->bus,
+                                  spapr_vfio_errinjct_find_bar_cb,
+                                  &ctx);
+
+    if (!ctx.pdev) {
+        error_report("vfio/eeh errinjct: guest addr 0x%" PRIx64
+                     " not within any VFIO BAR under BUID=0x%016" PRIx64
+                     " config_addr=0x%08x",
+                     guest_addr, sphb->buid, config_addr);
+        return -ENODEV;
+    }
+
+    rc = spapr_vfio_errinjct_get_host_bar(ctx.vdev, ctx.bar, &host_bar_start);
+    if (rc) {
+        error_report("vfio/eeh errinjct: failed to get host BAR%d for "
+                     "dev=%s BUID=0x%016" PRIx64 " config_addr=0x%08x rc=%d",
+                     ctx.bar, ctx.pdev->name, sphb->buid, config_addr, rc);
+        return rc;
+    }
+
+    if (host_bar_start == ctx.guest_bar_start) {
+        error_report("vfio/eeh errinjct: refusing guest BAR as host BAR: "
+                     "dev=%s BAR%d guest_bar=0x%" PRIx64
+                     " host_bar=0x%" PRIx64,
+                     ctx.pdev->name, ctx.bar,
+                     ctx.guest_bar_start, host_bar_start);
+        return -EOPNOTSUPP;
+    }
+
+    *host_pci_bus_addr = host_bar_start + ctx.offset;
+    return 0;
+}
+
 static int spapr_vfio_errinjct_rtas_type_to_vfio(uint32_t rtas_type)
 {
     switch (rtas_type) {
@@ -424,4 +619,12 @@ int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
     return RTAS_OUT_NOT_SUPPORTED;
 }
 
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr)
+{
+    return -ENOTSUP;
+}
+
 #endif /* CONFIG_VFIO_PCI */
-- 
2.51.1


