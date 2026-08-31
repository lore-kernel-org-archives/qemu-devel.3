Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2890FC624D0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16nk-0001fF-R5; Mon, 31 Aug 2026 14:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nb-0001cI-9E; Mon, 31 Aug 2026 14:32:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nX-0001vi-DB; Mon, 31 Aug 2026 14:32:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVjaI1979904; Mon, 31 Aug 2026 18:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ugsfn1Qq73BL/AuE9
 wYztmvBT+LO0OABEDEID5RTtso=; b=tJYNtP1MqcWsHEkAsekRA2JNQyXJaRQ+v
 V/IQ4zadNaDhuNL2gu4+etiHdQ2p2cEu5Gk2+HGSko1AxxY9F6ncEkpwSO+WUNXi
 nYHS3B3SEFsbu1JYWX1usxiVl+MtNXXFSruK+/8iwcINImW5lWWlRdRaqIq4uo+H
 kcSJkJRfp1OBnkIjIGOed72dOmW/z6Ym07uu2gyF0LtjSNYPVAWh35Lj0KzlIotr
 pWrW3hc/jsesr8qmTsvMSWALPZFhpk8tnMre+O4gyqF0r8WPlmsqeuJ4k3p5le2n
 Ebvfpw2PIug2MiOmkfDeWld3xUxMSJdi8wPCOlEVDMLhjDWUybzZw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudk4d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIUABv008921;
 Mon, 31 Aug 2026 18:31:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarjyfce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VIVs4W24117878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 18:31:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B0785805A;
 Mon, 31 Aug 2026 18:31:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D28058054;
 Mon, 31 Aug 2026 18:31:53 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.20])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 18:31:53 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v4 1/4] linux-headers: Update Linux header to 7.3-rc1
Date: Mon, 31 Aug 2026 11:31:48 -0700
Message-ID: <20260831183151.12626-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831183151.12626-1-alifm@linux.ibm.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OBilPCHPQIlWIud0ZEFfWlOUaYo9U0Xz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX1hxKz7wSpYq0
 Un2CMD82Ne6aV4W3x31gRB0AwmdaDMjSmuPpZPE8OZNJXz+18YSiQfmBQoVxgNa5T1pecCYywE5
 +dA5F6wl9Qy3Cse5DbDNVFKAIsOI/tSHTLxjiaYmPfSe1ebAmjk8SVjS2s2sDDpGpeZgDOFLZNx
 Pg/ygygxOOtAjqoJbQmhU5d92p8dX80Zax+wIU6WrskjXqqoNWlg1li+/dXvSrdc03tizfgpUdw
 iAr15is08YwSxaFTpjzSwB6kVxBf6Np7pFhT/Pu9tFbR8xAxFSKtcHbnMnQSLJP2HojizZo8tKL
 c6AswS9mEz4708Cwj/6gKjt2Mv9jmeG1yTwI9Im8RfOMx1cPj5CzASZKvQbLe+qkkCuFLGzv/bf
 t8pJ8mOYS6aR45JqdtPBMiHDUVBxYip4/RIk0bLGpAgUagjWsQyvm80w8AtS0VREVw2SDejPUyk
 I37Ds9ABWLE75DfPXPQ==
X-Proofpoint-ORIG-GUID: OBilPCHPQIlWIud0ZEFfWlOUaYo9U0Xz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX5wKRWj5UMxUX
 v4MK0pFJkOvNjjsOyXUu7Ha3O1Yl9UqiaZMWZ3vWuZ3W03qJwUjPQnvJe7R/EzXQ62/mqSkmQJs
 qvDK4xJalHOfgdkJhusfdi1SCRtBejo=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95c89c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HOAY4hV2iO9qIEP-GpsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Update the headers to include VFIO and zPCI VFIO changes.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 include/standard-headers/drm/drm_fourcc.h   | 209 ++++++++++++++++++--
 include/standard-headers/linux/ethtool.h    |   6 +
 include/standard-headers/linux/fuse.h       |  63 +++++-
 include/standard-headers/linux/virtio_ids.h |   1 +
 linux-headers/asm-arm64/kvm.h               |   1 +
 linux-headers/asm-riscv/kvm.h               |  13 ++
 linux-headers/linux/iommufd.h               |  45 ++++-
 linux-headers/linux/kvm.h                   |   1 +
 linux-headers/linux/userfaultfd.h           |  54 ++++-
 linux-headers/linux/vduse.h                 |  28 +++
 linux-headers/linux/vfio.h                  |  21 ++
 linux-headers/linux/vfio_zdev.h             |   2 +
 12 files changed, 417 insertions(+), 27 deletions(-)

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index 2ba0b5c925..ca4f4e3d8c 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -1645,36 +1645,69 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
  * For multi-plane formats the above surfaces get merged into one plane for
  * each format plane, based on the required alignment only.
  *
- * Bits  Parameter                Notes
- * ----- ------------------------ ---------------------------------------------
+ * Bits    Parameter                Notes
+ * ------- ------------------------ ---------------------------------------------
+ *
+ * DRM format modifier fields on AMD GPUs:
+ *     7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
+ *    12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
+ *      13 DCC                      Delta Color Compression, supported on GFX8 and newer
+ *   55:14 (chip specific)          See below for details, depends on GFX block version
+ *   63:56 Vendor                   Value is DRM_FORMAT_MOD_VENDOR_AMD
+ *
+ * Chip specific fields on Gfx9 and newer:
+ *      14 DCC_RETILE
+ *      15 DCC_PIPE_ALIGN
+ *      16 DCC_INDEPENDENT_64B
+ *      17 DCC_INDEPENDENT_128B
+ *   19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
+ *      20 DCC_CONSTANT_ENCODE
+ *   23:21 PIPE_XOR_BITS            Only for some chips
+ *   26:24 BANK_XOR_BITS            Only for some chips
+ *   29:27 PACKERS                  Only for some chips
+ *   32:30 RB                       Only for some chips
+ *   35:33 PIPE                     Only for some chips
+ *   55:36 -                        Reserved for future use, must be zero
+ *
+ * Chip specific fields on Gfx6-8:
+ *   16:14 MICROTILE                Micro tile format
+ *   21:17 PIPE_CONFIG              Number of pipes and how pipes are interleaved
+ *   24:22 TILE_SPLIT               Tile split size
+ *   26:25 BANK_WIDTH               Number of tiles in the X direction in the same bank
+ *   28:27 BANK_HEIGHT              Number of tiles in the Y direction in the same bank
+ *   30:29 MACRO_TILE_ASPECT        Macro tile aspect ratio
+ *   32:31 NUM_BANKS                Number of banks
+ *   55:33 -                        Reserved for future use, must be zero
  *
- *   7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
- *  12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
- *    13 DCC
- *    14 DCC_RETILE
- *    15 DCC_PIPE_ALIGN
- *    16 DCC_INDEPENDENT_64B
- *    17 DCC_INDEPENDENT_128B
- * 19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
- *    20 DCC_CONSTANT_ENCODE
- * 23:21 PIPE_XOR_BITS            Only for some chips
- * 26:24 BANK_XOR_BITS            Only for some chips
- * 29:27 PACKERS                  Only for some chips
- * 32:30 RB                       Only for some chips
- * 35:33 PIPE                     Only for some chips
- * 55:36 -                        Reserved for future use, must be zero
  */
 #define AMD_FMT_MOD fourcc_mod_code(AMD, 0)
 
 #define IS_AMD_FMT_MOD(val) (((val) >> 56) == DRM_FORMAT_MOD_VENDOR_AMD)
 
-/* Reserve 0 for GFX8 and older */
+#define AMD_FMT_MOD_TILE_VER_GFX6 0
 #define AMD_FMT_MOD_TILE_VER_GFX9 1
 #define AMD_FMT_MOD_TILE_VER_GFX10 2
 #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
 #define AMD_FMT_MOD_TILE_VER_GFX11 4
 #define AMD_FMT_MOD_TILE_VER_GFX12 5
 
+/*
+ * Gfx6-8 tiling modes.
+ * A complete reference implementation is found in addrlib in the Mesa code base.
+ *
+ * - Microtiled modes (1D):
+ *   Pixel data is organized into micro tiles of 8x8 pixels.
+ *
+ * - Macrotiled modes (2D):
+ *   Micro tiles are further organized into macro tiles.
+ *   These are optimized for even load distribution among memory channels.
+ *
+ * Note that only THIN1 modes are exposed here.
+ * THICK and XTHICK are for 3D images and not relevant to DRM format modifiers.
+ */
+#define AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 0x2
+#define AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1 0x4
+
 /*
  * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
  * version.
@@ -1773,6 +1806,146 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
 #define AMD_FMT_MOD_PIPE_SHIFT 33
 #define AMD_FMT_MOD_PIPE_MASK 0x7
 
+/*
+ * MICRO_TILE_MODE, 3 bits. Determines the micro tile format.
+ * Only relevant to Gfx6-8.
+ *
+ * DISPLAY - Displayable tiling
+ * THIN - Non-displayable tiling, a.k.a thin micro tiling
+ * DEPTH, THICK - not exposed, not relevant to DRM format modifier use cases
+ * ROTATED - not exposed, not implemented in Linux or Mesa
+ */
+#define AMD_FMT_MOD_MICROTILE_SHIFT 14ULL
+#define AMD_FMT_MOD_MICROTILE_MASK 0x7
+
+#define AMD_FMT_MOD_MICROTILE_DISPLAY 0x0
+#define AMD_FMT_MOD_MICROTILE_THIN 0x1
+
+/*
+ * PIPE_CONFIG, 5 bits. Number of pipes and how pipes are interleaved on the surface,
+ * which means the shader engine tile size and packer tile size.
+ * Typically matches the number of memory channels, or number of RBs.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ *
+ * P<n>_<a>x<b>_<c>x<d>
+ * where:
+ * <n> - number of pipes
+ * <a>x<b> - shader engine tile size
+ * <c>x<d> - packer tile size
+ */
+#define AMD_FMT_MOD_PIPE_CONFIG_SHIFT 17ULL
+#define AMD_FMT_MOD_PIPE_CONFIG_MASK 0x1f
+
+#define AMD_FMT_MOD_PIPE_CONFIG_P2 0x0
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_8x16 0x4
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x16 0x5
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x32 0x6
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_32x32 0x7
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16 0x8
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_8x16 0x9
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_8x16 0xa
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_16x16 0xb
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x16 0xc
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x32 0xd
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x64_32x32 0xe
+#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16 0x10
+#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_16x16 0x11
+
+/*
+ * TILE_SPLIT, 3 bits.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ *
+ * On GFX6 (or with depth tiling modes on GFX7 and newer),
+ * the GFX block uses the GB_TILE_MODE.TILE_SPLIT field directly.
+ *
+ * On GFX7 and newer with non-depth tiling modes, the GFX block uses a
+ * split factor which is stored in the GB_TILE_MODE.SAMPLE_SPLIT field.
+ * SAMPLE_SPLIT may be: 0 - 1 byte; 1 - 2 bytes; 2 - 4 bytes; 3 - 8 bytes.
+ * The actual tile size and tile split bytes are calculated as follows:
+ *
+ *    bpp = ... <- bits per pixel in the current image
+ *    thickness = ... <- depends on array mode; may be: 1, 4, 8
+ *    num_samples = ... <- number of samples in the current image
+ *    tile_size_pixels = 8 * 8
+ *    tile_bytes_1x = thickness * tile_size_pixels * bpp / 8
+ *    sample_split_factor = 1 << SAMPLE_SPLIT
+ *    tile_split_bytes = clamp(tile_bytes_1x * sample_split_factor, 256, dram_row_size_bytes)
+ *    tile_bytes = clamp(tile_bytes_1x * num_samples, 64, tile_split_bytes)
+ *
+ * In both cases, the display block (DCE) has no SAMPLE_SPLIT
+ * and just needs the tile split bytes in the GRPH_CONTROL.GRPH_TILE_SPLIT field.
+ * To maximize compatibility between GFX6-7, we don't include the SAMPLE_SPLIT
+ * in the format modifiers.
+ *
+ * The actual tile split in bytes is: 64 << field value
+ * Possible values of this field:
+ *
+ * 0 - Tile split is 64 bytes
+ * 1 - Tile split is 128 bytes
+ * 2 - Tile split is 256 bytes
+ * 3 - Tile split is 512 bytes
+ * 4 - Tile split is 1 KiB
+ * 5 - Tile split is 2 KiB
+ * 6 - Tile split is 4 KiB
+ */
+#define AMD_FMT_MOD_TILE_SPLIT_SHIFT 22ULL
+#define AMD_FMT_MOD_TILE_SPLIT_MASK 0x7
+
+/*
+ * BANK_WIDTH, 2 bits. Number of tiles in the X direction in the same bank.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual bank width is: 1 << field value
+ * Possible values:
+ *
+ * 0 - bank width is 1
+ * 1 - bank width is 2
+ * 2 - bank width is 4
+ * 3 - bank width is 8
+ */
+#define AMD_FMT_MOD_BANK_WIDTH_SHIFT 25ULL
+#define AMD_FMT_MOD_BANK_WIDTH_MASK 0x3
+
+/*
+ * BANK_HEIGHT, 2 bits. Number of tiles in the Y direction in the same bank.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual bank height is: 1 << field value
+ * Possible values:
+ *
+ * 0 - bank height is 1
+ * 1 - bank height is 2
+ * 2 - bank height is 4
+ * 3 - bank height is 8
+ */
+#define AMD_FMT_MOD_BANK_HEIGHT_SHIFT 27ULL
+#define AMD_FMT_MOD_BANK_HEIGHT_MASK 0x3
+
+/*
+ * MACRO_TILE_ASPECT, 2 bits. Macro tile aspect ratio.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * Possible values:
+ *
+ * 0 - aspect ratio is 1:1
+ * 1 - aspect ratio is 4:1
+ * 2 - aspect ratio is 16:1
+ * 3 - aspect ratio is 64:1
+ */
+#define AMD_FMT_MOD_MACRO_TILE_ASPECT_SHIFT 29ULL
+#define AMD_FMT_MOD_MACRO_TILE_ASPECT_MASK 0x3
+
+/*
+ * NUM_BANKS, 2 bits. Number of banks.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual number of banks is: 2 << field value
+ * Possible values:
+ *
+ * 0 - number of banks is 2
+ * 1 - number of banks is 4
+ * 2 - number of banks is 8
+ * 3 - number of banks is 16
+ */
+#define AMD_FMT_MOD_NUM_BANKS_SHIFT 31ULL
+#define AMD_FMT_MOD_NUM_BANKS_MASK 0x3
+
 #define AMD_FMT_MOD_SET(field, value) \
 	((uint64_t)(value) << AMD_FMT_MOD_##field##_SHIFT)
 #define AMD_FMT_MOD_GET(field, value) \
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 55f608c3a7..622d634d04 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2015,7 +2015,13 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT	= 39,
 	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT		= 40,
 	ETHTOOL_LINK_MODE_1000baseX_Full_BIT	= 41,
+
+	/* Despite the "baseCR" in 10000baseCR, this is not an IEEE 802.3 baseCR
+	 * It represents SFF-8431 Appendix-E SFP+ Direct Attach (10G-SFI-DA).
+	 * The name is kept as-is for uAPI backward compatibility.
+	 */
 	ETHTOOL_LINK_MODE_10000baseCR_Full_BIT	= 42,
+
 	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT	= 43,
 	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT	= 44,
 	ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT	= 45,
diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index abf3a78858..cee8342d4e 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -240,6 +240,14 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.46
+ *  - add FUSE_IO_URING_CMD_ADD_QUEUE
+ *  - add FUSE_HAS_IO_URING_BUFPOOL
+ *  - add fuse_uring_cmd_req bufpool struct
+ *  - add bufpool offset field to fuse_uring_ent_in_out struct
+ *  - add FUSE_URING_ZERO_COPY, FUSE_URING_ENT_ZERO_COPY, and
+ *    FOPEN_IO_URING_ZERO_COPY flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -271,7 +279,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 45
+#define FUSE_KERNEL_MINOR_VERSION 46
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -379,6 +387,12 @@ struct fuse_file_lock {
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
+ * FOPEN_IO_URING_ZERO_COPY: use io-uring zero-copy for reads/writes on this
+ *                           open file. Honored only when the serving io-uring
+ *                           queue was set up for zero-copy
+ *                           (FUSE_URING_ZERO_COPY) and the request carries page
+ *                           payload. Otherwise reads/writes fall back to
+ *                           copying.
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -388,6 +402,7 @@ struct fuse_file_lock {
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 #define FOPEN_PASSTHROUGH	(1 << 7)
+#define FOPEN_IO_URING_ZERO_COPY (1 << 8)
 
 /**
  * INIT request/reply flags
@@ -444,6 +459,7 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_HAS_IO_URING_BUFPOOL: kernel supports io-uring buffer pools
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -491,6 +507,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_HAS_IO_URING_BUFPOOL (1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
@@ -1247,6 +1264,13 @@ struct fuse_supp_groups {
 #define FUSE_URING_IN_OUT_HEADER_SZ 128
 #define FUSE_URING_OP_IN_OUT_SZ 128
 
+/**
+ * fuse_uring_ent_in_out flags
+ *
+ * FUSE_URING_ENT_ZERO_COPY: Set if the ent's payload is zero-copied
+ */
+#define FUSE_URING_ENT_ZERO_COPY	(1 << 0)
+
 /* Used as part of the fuse_uring_req_header */
 struct fuse_uring_ent_in_out {
 	uint64_t flags;
@@ -1259,7 +1283,9 @@ struct fuse_uring_ent_in_out {
 
 	/* size of user payload buffer */
 	uint32_t payload_sz;
-	uint32_t padding;
+
+	/* Offset into the bufpool, if bufpools are used */
+	uint32_t offset;
 
 	uint64_t reserved;
 };
@@ -1288,8 +1314,22 @@ enum fuse_uring_cmd {
 
 	/* commit fuse request result and fetch next request */
 	FUSE_IO_URING_CMD_COMMIT_AND_FETCH = 2,
+
+	/* add a queue */
+	FUSE_IO_URING_CMD_ADD_QUEUE = 3,
+
+	/* add a bufpool to a queue */
+	FUSE_IO_URING_CMD_ADD_BUFPOOL = 4,
 };
 
+/*
+ * fuse_uring_cmd_req flags for FUSE_IO_URING_CMD_ADD_QUEUE
+ *
+ * FUSE_URING_ZERO_COPY is only supported for queues with bufpools on privileged
+ * servers
+ */
+#define FUSE_URING_ZERO_COPY		(1 << 0)
+
 /**
  * In the 80B command area of the SQE.
  */
@@ -1302,6 +1342,25 @@ struct fuse_uring_cmd_req {
 	/* queue the command is for (queue index) */
 	uint16_t qid;
 	uint8_t padding[6];
+
+	union {
+		struct {
+			/* base address of bufpool */
+			uint64_t uaddr;
+			uint32_t len;
+			uint32_t reserved;
+		} bufpool;
+
+		/*
+		 * Index of this entry's slot in the server's io_uring
+		 * registered buffer table, where the kernel registers the
+		 * request's pages for zero-copy. Set for
+		 * FUSE_IO_URING_CMD_REGISTER cmds only, and only on queues
+		 * created with FUSE_URING_ZERO_COPY. On a non-zero-copy queue
+		 * this must be 0
+		 */
+		uint16_t ent_zero_copy_buf_index;
+	};
 };
 
 #endif /* _LINUX_FUSE_H */
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6c12db16fa..f9056af0c6 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -69,6 +69,7 @@
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
+#define VIRTIO_ID_MEDIA			48 /* virtio media */
 
 /*
  * Virtio Transitional IDs
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 6aefe79738..780cc7f729 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -106,6 +106,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 #define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
 #define KVM_ARM_VCPU_HAS_EL2_E2H0	8 /* Limit NV support to E2H RES0 */
+#define KVM_ARM_VCPU_PMU_V3_STRICT	9 /* No default PMU creation */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index 504e733053..20d9959ca4 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -102,6 +102,11 @@ struct kvm_riscv_smstateen_csr {
 	unsigned long sstateen0;
 };
 
+/* Zicfiss CSR for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
+struct kvm_riscv_zicfiss_csr {
+	unsigned long ssp;
+};
+
 /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_timer {
 	__u64 frequency;
@@ -199,6 +204,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZCLSD,
 	KVM_RISCV_ISA_EXT_ZILSD,
 	KVM_RISCV_ISA_EXT_ZALASR,
+	KVM_RISCV_ISA_EXT_ZICFILP,
+	KVM_RISCV_ISA_EXT_ZICFISS,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
@@ -240,6 +247,9 @@ struct kvm_riscv_sbi_fwft_feature {
 struct kvm_riscv_sbi_fwft {
 	struct kvm_riscv_sbi_fwft_feature misaligned_deleg;
 	struct kvm_riscv_sbi_fwft_feature pointer_masking;
+	struct kvm_riscv_sbi_fwft_feature pte_ad_hw_updating;
+	struct kvm_riscv_sbi_fwft_feature landing_pad;
+	struct kvm_riscv_sbi_fwft_feature shadow_stack;
 };
 
 /* If you need to interpret the index values, here is the key: */
@@ -263,12 +273,15 @@ struct kvm_riscv_sbi_fwft {
 #define KVM_REG_RISCV_CSR_GENERAL	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_AIA		(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_SMSTATEEN	(0x2 << KVM_REG_RISCV_SUBTYPE_SHIFT)
+#define KVM_REG_RISCV_CSR_ZICFISS	(0x3 << KVM_REG_RISCV_SUBTYPE_SHIFT)
 #define KVM_REG_RISCV_CSR_REG(name)	\
 		(offsetof(struct kvm_riscv_csr, name) / sizeof(unsigned long))
 #define KVM_REG_RISCV_CSR_AIA_REG(name)	\
 	(offsetof(struct kvm_riscv_aia_csr, name) / sizeof(unsigned long))
 #define KVM_REG_RISCV_CSR_SMSTATEEN_REG(name)  \
 	(offsetof(struct kvm_riscv_smstateen_csr, name) / sizeof(unsigned long))
+#define KVM_REG_RISCV_CSR_ZICFISS_REG(name)  \
+	(offsetof(struct kvm_riscv_zicfiss_csr, name) / sizeof(unsigned long))
 
 /* Timer registers are mapped as type 4 */
 #define KVM_REG_RISCV_TIMER		(0x04 << KVM_REG_RISCV_TYPE_SHIFT)
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 10c600d71e..3c61caadbf 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
 };
 
 /**
@@ -219,6 +220,33 @@ struct iommu_ioas_map {
 };
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
+/**
+ * struct iommu_ioas_noiommu_get_pa - ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
+ * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
+ * @flags: Reserved, must be 0 for now
+ * @ioas_id: IOAS ID to query IOVA to PA mapping from
+ * @__reserved: Must be 0
+ * @iova: IOVA to query
+ * @length: On input, non-zero maximum number of bytes to query starting from
+ *          @iova. On output, number of physically contiguous bytes starting
+ *          from @out_phys, capped by the input length.
+ * @out_phys: Output physical address the IOVA maps to
+ *
+ * Query the physical address backing an IOVA range. The beginning of the
+ * range must be mapped already and length must be non-zero. For noiommu
+ * devices doing unsafe DMA only.
+ */
+struct iommu_ioas_noiommu_get_pa {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__u32 __reserved;
+	__aligned_u64 iova;
+	__aligned_u64 length;
+	__aligned_u64 out_phys;
+};
+#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA)
+
 /**
  * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
  * @size: sizeof(struct iommu_ioas_map_file)
@@ -574,11 +602,22 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
+ * @IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI:
+ *    If set, user space must issue TLBI/CFGI+SYNC commands twice due to
+ *    hardware erratum T264-SMMU-3. See the description at
+ *    arm_smmu_erratum_repeat_tlbi_cfgi_key.
+ */
+enum iommu_hw_info_arm_smmuv3_flags {
+	IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
  *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
  *
- * @flags: Must be set to 0
+ * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
  * @__reserved: Must be 0
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
@@ -594,7 +633,7 @@ struct iommu_hw_info_vtd {
  * idr[0]: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN , CD2L, ASID16, TTF
  * idr[1]: SIDSIZE, SSIDSIZE
  * idr[3]: BBML, RIL
- * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K
+ * idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K, DS
  *
  * - S1P should be assumed to be true if a NESTED HWPT can be created
  * - VFIO/iommufd only support platforms with COHACC, it should be assumed to be
@@ -602,7 +641,7 @@ struct iommu_hw_info_vtd {
  * - ATS is a per-device property. If the VMM describes any devices as ATS
  *   capable in ACPI/DT it should set the corresponding idr.
  *
- * This list may expand in future (eg E0PD, AIE, PBHA, D128, DS etc). It is
+ * This list may expand in future (eg E0PD, AIE, PBHA, D128 etc). It is
  * important that VMMs do not read bits outside the list to allow for
  * compatibility with future kernels. Several features in the SMMUv3
  * architecture are not currently supported by the kernel for nesting: HTTU,
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index aea4ab5c69..f21c47bf8d 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -987,6 +987,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
+#define KVM_CAP_ARM_PMU_V3_STRICT 251
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
index 4283de22d5..c8e99df952 100644
--- a/linux-headers/linux/userfaultfd.h
+++ b/linux-headers/linux/userfaultfd.h
@@ -25,7 +25,8 @@
 #define UFFD_API ((__u64)0xAA)
 #define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |	\
 				 UFFDIO_REGISTER_MODE_WP |	\
-				 UFFDIO_REGISTER_MODE_MINOR)
+				 UFFDIO_REGISTER_MODE_MINOR |	\
+				 UFFDIO_REGISTER_MODE_RWP)
 #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
 			   UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
@@ -42,10 +43,13 @@
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
-			   UFFD_FEATURE_MOVE)
+			   UFFD_FEATURE_MOVE |			\
+			   UFFD_FEATURE_RWP |			\
+			   UFFD_FEATURE_RWP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
+	 (__u64)1 << _UFFDIO_SET_MODE |		\
 	 (__u64)1 << _UFFDIO_API)
 #define UFFD_API_RANGE_IOCTLS			\
 	((__u64)1 << _UFFDIO_WAKE |		\
@@ -54,13 +58,15 @@
 	 (__u64)1 << _UFFDIO_MOVE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -79,6 +85,8 @@
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
+#define _UFFDIO_RWPROTECT		(0x09)
+#define _UFFDIO_SET_MODE		(0x0A)
 #define _UFFDIO_API			(0x3F)
 
 /* userfaultfd ioctl ids */
@@ -103,6 +111,10 @@
 				      struct uffdio_continue)
 #define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
 				      struct uffdio_poison)
+#define UFFDIO_RWPROTECT	_IOWR(UFFDIO, _UFFDIO_RWPROTECT,	\
+				      struct uffdio_rwprotect)
+#define UFFDIO_SET_MODE		_IOW(UFFDIO, _UFFDIO_SET_MODE,	\
+				     struct uffdio_set_mode)
 
 /* read() structure */
 struct uffd_msg {
@@ -158,6 +170,7 @@ struct uffd_msg {
 #define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
 #define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
 #define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is VM_UFFD_MINOR */
+#define UFFD_PAGEFAULT_FLAG_RWP		(1<<3)	/* If reason is VM_UFFD_RWP */
 
 struct uffdio_api {
 	/* userland asks for an API number and the features to enable */
@@ -230,6 +243,18 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
 	 * existing page contents from userspace.
+	 *
+	 * UFFD_FEATURE_RWP indicates that the kernel supports
+	 * UFFDIO_REGISTER_MODE_RWP for read-write protection tracking.
+	 * Pages are made inaccessible via UFFDIO_RWPROTECT and faults
+	 * are delivered when the pages are re-accessed.
+	 *
+	 * UFFD_FEATURE_RWP_ASYNC indicates asynchronous mode for
+	 * UFFDIO_REGISTER_MODE_RWP.  When set, faults on read-write
+	 * protected pages are auto-resolved by the kernel (PTE
+	 * permissions restored immediately) without delivering a message
+	 * to the userfaultfd handler.  Use PAGEMAP_SCAN with inverted
+	 * PAGE_IS_ACCESSED to find pages that were not re-accessed.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -248,6 +273,8 @@ struct uffdio_api {
 #define UFFD_FEATURE_POISON			(1<<14)
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
 #define UFFD_FEATURE_MOVE			(1<<16)
+#define UFFD_FEATURE_RWP			(1<<17)
+#define UFFD_FEATURE_RWP_ASYNC			(1<<18)
 	__u64 features;
 
 	__u64 ioctls;
@@ -263,6 +290,7 @@ struct uffdio_register {
 #define UFFDIO_REGISTER_MODE_MISSING	((__u64)1<<0)
 #define UFFDIO_REGISTER_MODE_WP		((__u64)1<<1)
 #define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
+#define UFFDIO_REGISTER_MODE_RWP	((__u64)1<<3)
 	__u64 mode;
 
 	/*
@@ -356,6 +384,14 @@ struct uffdio_poison {
 	__s64 updated;
 };
 
+struct uffdio_rwprotect {
+	struct uffdio_range range;
+	/* !RWP means undo RWP-protection */
+#define UFFDIO_RWPROTECT_MODE_RWP		((__u64)1<<0)
+#define UFFDIO_RWPROTECT_MODE_DONTWAKE		((__u64)1<<1)
+	__u64 mode;
+};
+
 struct uffdio_move {
 	__u64 dst;
 	__u64 src;
@@ -374,6 +410,16 @@ struct uffdio_move {
 	__s64 move;
 };
 
+struct uffdio_set_mode {
+	/*
+	 * Toggle async mode for features at runtime.
+	 * Supported: UFFD_FEATURE_RWP_ASYNC.
+	 * Setting a bit in both enable and disable is invalid.
+	 */
+	__u64 enable;
+	__u64 disable;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/linux-headers/linux/vduse.h b/linux-headers/linux/vduse.h
index e19b3c0f51..bab47129db 100644
--- a/linux-headers/linux/vduse.h
+++ b/linux-headers/linux/vduse.h
@@ -14,6 +14,12 @@
 
 #define VDUSE_API_VERSION_1	1
 
+/* The VDUSE instance expects a request for vq ready */
+#define VDUSE_F_QUEUE_READY	0
+
+/* The VDUSE instance expects a request for suspend */
+#define VDUSE_F_SUSPEND		1
+
 /*
  * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSION).
  * This is used for future extension.
@@ -63,6 +69,12 @@ struct vduse_dev_config {
  */
 #define VDUSE_DESTROY_DEV	_IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_MAX])
 
+/* Get the VDUSE supported features */
+#define VDUSE_GET_FEATURES	_IOR(VDUSE_BASE, 0x04, __u64)
+
+/* Set the VDUSE features */
+#define VDUSE_SET_FEATURES	_IOW(VDUSE_BASE, 0x05, __u64)
+
 /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
 
 /**
@@ -325,6 +337,8 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_SET_VQ_GROUP_ASID,
+	VDUSE_SET_VQ_READY,
+	VDUSE_SUSPEND,
 };
 
 /**
@@ -372,6 +386,15 @@ struct vduse_iova_range_v2 {
 	__u32 padding;
 };
 
+/**
+ * struct vduse_vq_ready - Virtqueue ready request message
+ * @num: Virtqueue number
+ */
+struct vduse_vq_ready {
+	__u32 num;
+	__u32 ready;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -382,6 +405,7 @@ struct vduse_iova_range_v2 {
  * @iova: IOVA range for updating
  * @iova_v2: IOVA range for updating if API_VERSION >= 1
  * @vq_group_asid: ASID of a virtqueue group
+ * @vq_ready: Virtqueue ready request
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -399,6 +423,10 @@ struct vduse_dev_request {
 		 */
 		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group_asid vq_group_asid;
+
+		/* Only if VDUSE_F_QUEUE_READY is negotiated */
+		struct vduse_vq_ready vq_ready;
+
 		__u32 padding[32];
 	};
 };
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index f3282b8e86..c85dcbfe30 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1534,6 +1534,27 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/**
+ * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
+ * userspace for vfio-pci devices on s390. On s390, PCI error recovery
+ * involves platform firmware and notification to operating systems is done
+ * by architecture specific mechanism. Exposing this information to
+ * userspace allows it to take appropriate actions to handle an
+ * error on the device.
+ *
+ * Userspace provides an opaque buffer of fixed length, and the kernel
+ * fills it with the zpci_ccdf_err data structure. The length of
+ * zpci_ccdf_err is provided to userspace via the
+ * VFIO_DEVICE_INFO_CAP_ZPCI_BASE capability.
+ *
+ * The ioctl returns -ENOMSG if there are no pending PCI errors.
+ */
+struct vfio_device_feature_zpci_err {
+	__aligned_u64 data;
+};
+
+#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
index 77f2aff1f2..d6c1175c88 100644
--- a/linux-headers/linux/vfio_zdev.h
+++ b/linux-headers/linux/vfio_zdev.h
@@ -32,6 +32,8 @@ struct vfio_device_info_cap_zpci_base {
 	/* End of version 1 */
 	__u32 fh;		/* PCI function handle */
 	/* End of version 2 */
+	__u32 ccdf_err_length;	/* PCI CCDF length */
+	/* End of version 3 */
 };
 
 /**
-- 
2.43.0


