Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD50DC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 08:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0yz-0006UE-DP; Thu, 22 May 2025 04:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1uI0yv-0006Tq-MX
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:08:49 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vinayak.kh@samsung.com>)
 id 1uI0yo-0002mL-MH
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:08:46 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20250522080831epoutp03fe5693315677ec57d4f0fcd010b3ae1d~ByvuDe6pQ2648226482epoutp03r
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:08:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20250522080831epoutp03fe5693315677ec57d4f0fcd010b3ae1d~ByvuDe6pQ2648226482epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1747901312;
 bh=j5e89bxW+dUvDSFtAEe4o/9DR+/R6+jma2SiWb+OTGI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=QOhekBoYXqqY0URx8JeZjeNDfICVVv2VDnGcOADP0El9vNv/MfFtsusiL0Ga08Zy7
 YWxoXXYD/HXhQ6gC9BkoNPq3luh8YLNdDQZwu4uWK9NKYuM9MLFgij2OOHNbwFjEV1
 Xn++5pifm2wSQDmCdFweI0p9dcVApVDQDtmMhDto=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20250522080831epcas5p3f5affcf829c94f3e627c5242590ca378~ByvtR7RC_0045300453epcas5p3n;
 Thu, 22 May 2025 08:08:31 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.175]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4b31Bj2k0nz3hhT8; Thu, 22 May
 2025 08:08:29 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec~BxbR0iKUi2830428304epcas5p16;
 Thu, 22 May 2025 06:31:49 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20250522063149epsmtrp230f6db4aef1e4c0f9bee98421485facb~BxbRzvRn41208312083epsmtrp2W;
 Thu, 22 May 2025 06:31:49 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-bc-682ec4d57996
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F5.F8.07818.5D4CE286; Thu, 22 May 2025 15:31:49 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20250522063147epsmtip24a25fc88e390ec373fae9aab2a4bd8d8~BxbQXsN-y1283412834epsmtip2G;
 Thu, 22 May 2025 06:31:47 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
 a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
 <vinayak.kh@samsung.com>
Subject: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode (5501h)
Date: Thu, 22 May 2025 12:01:35 +0530
Message-Id: <20250522063135.366295-1-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvO7VI3oZBndncllMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
 +rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6MxXfeMxc8jag4/fwuWwNjn0MXIyeHhICJ
 xK8V69i7GLk4hAR2M0rMbgNxQBJSEsd2/mSDsIUlVv57DlX0j1FiW+MZJpAEm4CBxIPm42AN
 IgKSEr+7TjODFDEL/GKUeLr7PlhCWMBfoqulDaiBg4NFQFVi7cRokDCvgI3ErLXrGSEWyEvs
 P3iWGSIuKHFy5hMWEJsZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PTTYsMMxLLdcrTswt
 Ls1L10vOz93ECA5gLY0djO++NekfYmTiYDzEKMHBrCTCG7tCJ0OINyWxsiq1KD++qDQntfgQ
 ozQHi5I470rDiHQhgfTEktTs1NSC1CKYLBMHp1QDk05TfWp1t+qySdI7JbaJ/NqbVvpKTn3J
 qzVlGiyBb9Y/WfvmSf+2sA/HZMLWOHHomxavVw84q2G29PDZsv/ZOlb/s26cyUvIvbgqkP3Y
 xCrzqrVn7Wz3/2SbdeCV+An+FI0Vd7ebHm90Dv3OqH+Am8PDp+boS3F+59jlcdvmxvxViPis
 sqJ36dW1Vse/WK42Dy8y/jJrttaSm0XnAne6CKxhin1X9L2vOVktc/XBDd0JRqvrkk4khvk1
 udi6v2k3amObuOOcSw5PlTDTqn0S2q75wTuu5XLZbXuvP/12867PUYaZJdaP4qx+HExnfT67
 arKh9u7Kg2LPbr7Zd05c/E3x6tlOB2rZXDhslwWxKbEUZyQaajEXFScCALdVnTXPAgAA
X-CMS-MailID: 20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec
References: <CGME20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=vinayak.kh@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
This patch is generated against Jonathan Cameron's branch cxl-2025-03-20

 hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++
 hw/cxl/mhsld/mhsld.c        | 92 ++++++++++++++++++++++++++++++++++++-
 hw/cxl/mhsld/mhsld.h        | 26 +++++++++++
 include/hw/cxl/cxl_device.h |  6 +++
 4 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a02d130926..4f25caecea 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,7 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
+        #define GET_MHD_HEAD_INFO 0x1
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -267,6 +268,23 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_UNSUPPORTED;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.5.2 - Get Multi-Headed Head Info (Opcode 5501h)
+ */
+static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    if (cvc->mhd_get_head_info) {
+        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
+                                 len_out, cci);
+    }
+    return CXL_MBOX_UNSUPPORTED;
+}
+
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
                                          uint8_t *payload_out, size_t *len_out,
@@ -3429,6 +3447,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
         cmd_media_get_scan_media_results, 0, 0 },
     [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
+    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
@@ -3761,6 +3780,8 @@ static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
                                      cmd_tunnel_management_cmd, ~0, 0 },
+    [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
+    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
 };
 
 void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
index 9f633b3bed..981546b5ff 100644
--- a/hw/cxl/mhsld/mhsld.c
+++ b/hw/cxl/mhsld/mhsld.c
@@ -61,9 +61,57 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.5.2 - Get Head Info (Opcode 5501h)
+ *
+ * This command retrieves the number of heads, number of supported LDs,
+ * and Head-to-LD mapping of a Multi-Headed device.
+ */
+static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
+                                        uint8_t *payload_in, size_t len_in,
+                                        uint8_t *payload_out, size_t *len_out,
+                                        CXLCCI *cci)
+{
+    CXLMHSLDState *s = CXL_MHSLD(cci->d);
+    MHDGetHeadInfoInput *input = (void *)payload_in;
+    MHDGetHeadInfoOutput *output = (void *)payload_out;
+    int i = 0;
+
+    if (input->start_head > MHSLD_HEADS) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    output->nr_heads = MIN((MHSLD_HEADS - input->start_head), input->nr_heads);
+    for (i = input->start_head; i < input->start_head + output->nr_heads; i++) {
+        output->head_info_list[i].port_number =
+                                 s->mhd_state->head_info_blocks[i].port_number;
+        output->head_info_list[i].max_link_width =
+                              s->mhd_state->head_info_blocks[i].max_link_width;
+        output->head_info_list[i].nego_link_width =
+                             s->mhd_state->head_info_blocks[i].nego_link_width;
+        output->head_info_list[i].supp_link_speeds_vector =
+                     s->mhd_state->head_info_blocks[i].supp_link_speeds_vector;
+        output->head_info_list[i].max_link_speed =
+                              s->mhd_state->head_info_blocks[i].max_link_speed;
+        output->head_info_list[i].current_link_speed =
+                          s->mhd_state->head_info_blocks[i].current_link_speed;
+        output->head_info_list[i].ltssm_state =
+                                 s->mhd_state->head_info_blocks[i].ltssm_state;
+        output->head_info_list[i].first_nego_lane_num =
+                         s->mhd_state->head_info_blocks[i].first_nego_lane_num;
+        output->head_info_list[i].link_state_flags =
+                            s->mhd_state->head_info_blocks[i].link_state_flags;
+    }
+
+    *len_out = sizeof(*output) + output->nr_heads * sizeof(MHDHeadInfoBlock);
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
     [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
         cmd_mhd_get_info, 2, 0},
+    [MHSLD_MHD][GET_MHD_HEAD_INFO] = {"GET_HEAD_INFO",
+        cmd_mhd_get_head_info, 2, 0},
 };
 
 static const Property cxl_mhsld_props[] = {
@@ -166,6 +214,47 @@ static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
     s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
 }
 
+
+static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
+{
+    uint16_t lnksta = 0;
+    uint16_t current_link_speed = 0;
+    uint16_t negotiated_link_width = 0;
+    uint16_t lnkcap = 0, lnkcap2 = 0;
+    uint16_t max_link_width = 0;
+    uint16_t max_link_speed = 0;
+    uint16_t supported_link_speeds_vector = 0;
+
+    lnksta = pdev->config_read(pdev,
+                               pdev->exp.exp_cap + PCI_EXP_LNKSTA,
+                               sizeof(lnksta));
+    lnkcap = pdev->config_read(pdev,
+                               pdev->exp.exp_cap + PCI_EXP_LNKCAP,
+                               sizeof(lnkcap));
+    lnkcap2 = pdev->config_read(pdev,
+                                pdev->exp.exp_cap + PCI_EXP_LNKCAP2,
+                                sizeof(lnkcap2));
+    supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
+    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
+    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
+    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
+
+    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;
+    s->mhd_state->head_info_blocks[s->mhd_head].max_link_width = max_link_width;
+    s->mhd_state->head_info_blocks[s->mhd_head].nego_link_width =
+                                                          negotiated_link_width;
+    s->mhd_state->head_info_blocks[s->mhd_head].supp_link_speeds_vector =
+                                                   supported_link_speeds_vector;
+    s->mhd_state->head_info_blocks[s->mhd_head].max_link_speed =
+                                                                 max_link_speed;
+    s->mhd_state->head_info_blocks[s->mhd_head].current_link_speed =
+                                                             current_link_speed;
+    s->mhd_state->head_info_blocks[s->mhd_head].ltssm_state = 0x7;
+    s->mhd_state->head_info_blocks[s->mhd_head].first_nego_lane_num = 0;
+    s->mhd_state->head_info_blocks[s->mhd_head].link_state_flags = 0;
+}
+
 /* Returns starting index of region in MHD map. */
 static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
                                                     CXLDCRegion *r)
@@ -376,7 +465,7 @@ static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     cxl_mhsld_state_initialize(s, dc_size);
-
+    cxl_mhsld_init_head_info(s, pci_dev);
     /* Set the LD ownership for this head to this system */
     s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
     return;
@@ -428,6 +517,7 @@ static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
 
     CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
     cvc->mhd_get_info = cmd_mhd_get_info;
+    cvc->mhd_get_head_info = cmd_mhd_get_head_info;
     cvc->mhd_access_valid = cxl_mhsld_access_valid;
     cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
     cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
index e7ead1f0d2..c9fbec71ca 100644
--- a/hw/cxl/mhsld/mhsld.h
+++ b/hw/cxl/mhsld/mhsld.h
@@ -23,6 +23,18 @@
  */
 #define MHSLD_HEADS  (8)
 
+typedef struct MHDHeadInfoBlock {
+    uint8_t port_number;
+    uint8_t max_link_width;
+    uint8_t nego_link_width;
+    uint8_t supp_link_speeds_vector;
+    uint8_t max_link_speed;
+    uint8_t current_link_speed;
+    uint8_t ltssm_state;
+    uint8_t first_nego_lane_num;
+    uint8_t link_state_flags;
+} QEMU_PACKED MHDHeadInfoBlock;
+
 /*
  * The shared state cannot have 2 variable sized regions
  * so we have to max out the ldmap.
@@ -32,6 +44,7 @@ typedef struct MHSLDSharedState {
     uint8_t nr_lds;
     uint8_t ldmap[MHSLD_HEADS];
     uint64_t nr_blocks;
+    MHDHeadInfoBlock head_info_blocks[MHSLD_HEADS];
     uint8_t blocks[];
 } MHSLDSharedState;
 
@@ -52,6 +65,7 @@ struct CXLMHSLDClass {
 enum {
     MHSLD_MHD = 0x55,
         #define GET_MHD_INFO 0x0
+        #define GET_MHD_HEAD_INFO 0x1
 };
 
 /*
@@ -72,4 +86,16 @@ typedef struct MHDGetInfoOutput {
     uint16_t resv2;
     uint8_t ldmap[];
 } QEMU_PACKED MHDGetInfoOutput;
+
+typedef struct MHDGetHeadInfoInput {
+    uint8_t start_head;
+    uint8_t nr_heads;
+} QEMU_PACKED MHDGetHeadInfoInput;
+
+typedef struct MHDGetHeadInfoOutput {
+    uint8_t nr_heads;
+    uint8_t rsvd[3];
+    MHDHeadInfoBlock head_info_list[];
+} QEMU_PACKED MHDGetHeadInfoOutput;
+
 #endif
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..c93c71c45d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -732,6 +732,12 @@ struct CXLType3Class {
                                uint8_t *payload_out,
                                size_t *len_out,
                                CXLCCI *cci);
+    CXLRetCode (*mhd_get_head_info)(const struct cxl_cmd *cmd,
+                               uint8_t *payload_in,
+                               size_t len_in,
+                               uint8_t *payload_out,
+                               size_t *len_out,
+                               CXLCCI *cci);
     bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
     bool (*mhd_reserve_extents)(PCIDevice *d,
                                 CxlDynamicCapacityExtentList *records,
-- 
2.34.1


