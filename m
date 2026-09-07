Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27ECC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Rr2-0005AC-Bu; Mon, 07 Sep 2026 01:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqz-00053d-MF; Mon, 07 Sep 2026 01:25:13 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqw-00086g-KX; Mon, 07 Sep 2026 01:25:13 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdb9C69WczBqZT;
 Mon,  7 Sep 2026 07:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758671;
 bh=SUD8vSBAhzLbzjPLo3AjYCzr2wBjl/mMjPWUqg26wgM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VoOfjmWvpM1IaNFGiJ9CXkBjugtbb6tNxTHut50Yxd1o3ijTyk6yLh3rPBjavI+cH
 sN1bGU7xf9B3E21QnmsAtEmrn1sGR5BQMyF3sDeEcI5+GnOzGM+Dt5m6mhS6T8FRLU
 b32fGrjQHoYw1P/yhA1xZq3ggtm6Mp1oZyIzdoKLVspeEclI3OnLPttodT9lNErDBG
 OtMW44xk6w9jVfxKV8aAAPd/dGOt/9zC200NNzRa8GEryElA0G4nrRzM2O5sIiZQ5z
 ZAnkWavLmeCa3g16+c301kACY1dJJC60Po/MJBvX/Vv9/7gY1x/IpUsMy9Jc9+uqwK
 x9sujPlCCRGcA==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb9C3HGgz7xqf;
 Mon,  7 Sep 2026 07:24:31 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Alistair Francis <alistair@alistair23.me>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 29/36] hw/ssi: load RP2040 UF2 flash images
Date: Mon,  7 Sep 2026 07:24:17 +0200
Message-ID: <20260907052426.24849-13-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Accept RP2040-family UF2 files through the Raspberry Pi Pico -kernel path.
Validate block framing, family IDs, payload sizes, and XIP flash bounds
before overlaying payloads onto flash storage. Flush the ROMD mapping after
loading so translated code observes the new image.

Add a focused qtest for multi-block UF2 loading and provide a host-side
converter for producing raw flash images from Pico UF2 files.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 MAINTAINERS                   |   2 +
 hw/ssi/rp2040_xip.c           | 110 ++++++++
 scripts/uf2-to-flash.py       | 462 ++++++++++++++++++++++++++++++++++
 tests/qtest/rp2040-xip-test.c |  61 +++++
 4 files changed, 635 insertions(+)
 create mode 100755 scripts/uf2-to-flash.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a03fb0575c..05ee44de37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1033,6 +1033,8 @@ S: Maintained
 F: hw/*/rp2040*
 F: include/hw/*/rp2040*
 F: hw/arm/raspi_pico.c
+F: scripts/uf2-to-flash.py
+F: tests/qtest/rp2040*
 F: tests/tcg/arm/system/rp2040*
 
 Real View
diff --git a/hw/ssi/rp2040_xip.c b/hw/ssi/rp2040_xip.c
index fdd48b0f91..4312a88b6f 100644
--- a/hw/ssi/rp2040_xip.c
+++ b/hw/ssi/rp2040_xip.c
@@ -90,6 +90,17 @@
 #define FLASH_PAGE_SIZE  256
 #define FLASH_SECTOR_SIZE 4096
 
+#define UF2_MAGIC_START0 0x0a324655
+#define UF2_MAGIC_START1 0x9e5d5157
+#define UF2_MAGIC_END    0x0ab16f30
+#define UF2_BLOCK_SIZE   512
+#define UF2_HEADER_SIZE  32
+#define UF2_MAX_PAYLOAD  476
+
+#define UF2_FLAG_NOT_MAIN_FLASH       BIT(0)
+#define UF2_FLAG_FAMILY_ID_PRESENT    BIT(13)
+#define UF2_RP2040_FAMILY_ID          0xe48bff56
+
 #define RP2040_BOOT2_SIZE 256
 #define RP2040_BOOT2_CRC_SIZE 252
 #define RP2040_BOOT2_CRC_INIT 0xffffffff
@@ -1136,6 +1147,92 @@ static bool rp2040_xip_load_elf(RP2040XipState *s, const char *filename,
     return true;
 }
 
+static bool rp2040_xip_load_uf2(RP2040XipState *s, const char *filename,
+                                Error **errp)
+{
+    g_autofree gchar *contents = NULL;
+    gsize len;
+    unsigned blocks;
+    unsigned i;
+    bool copied = false;
+
+    if (!g_file_get_contents(filename, &contents, &len, NULL)) {
+        error_setg(errp, "could not load flash image '%s'", filename);
+        return true;
+    }
+
+    if (len < UF2_BLOCK_SIZE ||
+        ldl_le_p(contents) != UF2_MAGIC_START0 ||
+        ldl_le_p(contents + 4) != UF2_MAGIC_START1) {
+        return false;
+    }
+
+    if (len % UF2_BLOCK_SIZE != 0) {
+        error_setg(errp, "invalid UF2 image '%s': size is not a multiple "
+                   "of %u bytes", filename, UF2_BLOCK_SIZE);
+        return true;
+    }
+
+    blocks = len / UF2_BLOCK_SIZE;
+    for (i = 0; i < blocks; i++) {
+        const uint8_t *block = (uint8_t *)contents + i * UF2_BLOCK_SIZE;
+        uint32_t flags;
+        uint32_t target;
+        uint32_t payload_size;
+        uint32_t family_id;
+        uint32_t offset;
+
+        if (ldl_le_p(block) != UF2_MAGIC_START0 ||
+            ldl_le_p(block + 4) != UF2_MAGIC_START1 ||
+            ldl_le_p(block + UF2_BLOCK_SIZE - 4) != UF2_MAGIC_END) {
+            error_setg(errp, "invalid UF2 image '%s': bad magic in block %u",
+                       filename, i);
+            return true;
+        }
+
+        flags = ldl_le_p(block + 8);
+        if (flags & UF2_FLAG_NOT_MAIN_FLASH) {
+            continue;
+        }
+
+        if (!(flags & UF2_FLAG_FAMILY_ID_PRESENT)) {
+            error_setg(errp, "invalid RP2040 UF2 image '%s': block %u has "
+                       "no family ID", filename, i);
+            return true;
+        }
+
+        family_id = ldl_le_p(block + 28);
+        if (family_id != UF2_RP2040_FAMILY_ID) {
+            error_setg(errp, "unsupported UF2 family ID 0x%08" PRIx32
+                       " in '%s'", family_id, filename);
+            return true;
+        }
+
+        target = ldl_le_p(block + 12);
+        payload_size = ldl_le_p(block + 16);
+        if (payload_size > UF2_MAX_PAYLOAD ||
+            target < RP2040_XIP_FLASH_BASE ||
+            target - RP2040_XIP_FLASH_BASE > s->flash_size ||
+            payload_size > s->flash_size -
+                           (target - RP2040_XIP_FLASH_BASE)) {
+            error_setg(errp, "UF2 block %u in '%s' is outside XIP flash",
+                       i, filename);
+            return true;
+        }
+
+        offset = target - RP2040_XIP_FLASH_BASE;
+        memcpy(s->storage + offset, block + UF2_HEADER_SIZE, payload_size);
+        copied = true;
+    }
+
+    if (!copied) {
+        error_setg(errp, "UF2 image '%s' contains no RP2040 flash payload",
+                   filename);
+    }
+
+    return true;
+}
+
 void rp2040_xip_load_image(RP2040XipState *s, const char *filename,
                            Error **errp)
 {
@@ -1159,6 +1256,19 @@ void rp2040_xip_load_image(RP2040XipState *s, const char *filename,
         return;
     }
 
+    if (rp2040_xip_load_uf2(s, filename, &local_err)) {
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+        if (!rp2040_xip_fixup_boot2(s, filename, errp)) {
+            return;
+        }
+        rp2040_xip_changed(s, 0, s->flash_size);
+        rp2040_xip_writeback(s, errp);
+        return;
+    }
+
     image_size = load_image_size(filename, s->storage, s->flash_size);
     if (image_size < 0) {
         error_setg(errp, "could not load flash image '%s'", filename);
diff --git a/scripts/uf2-to-flash.py b/scripts/uf2-to-flash.py
new file mode 100755
index 0000000000..f1c0fcbbbb
--- /dev/null
+++ b/scripts/uf2-to-flash.py
@@ -0,0 +1,462 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""
+uf2-to-flash.py
+
+Convert a Raspberry Pi Pico UF2 file into a raw flash image.
+
+This tool implements the simple and practical conversion model used for
+QEMU-style emulation:
+
+    UF2 target address 0x10000000 + offset  ->  flash image offset
+
+The output file is not a FAT image. It is a raw representation of the
+external QSPI flash contents after UF2 programming.
+
+Supported input model:
+    - RP2040 / Pico 1 UF2 files, family ID 0xE48BFF56.
+    - RP2350 / Pico 2 UF2 files are detected and converted linearly,
+      but RP2350 partition remapping is not implemented.
+
+Usage:
+    scripts/uf2-to-flash.py firmware.uf2 flash.img
+    scripts/uf2-to-flash.py flash.img firmware.uf2
+
+If the two arguments are provided in reverse order, the .uf2 extension is
+used to detect the input file.
+"""
+
+import os
+import sys
+import struct
+
+
+UF2_MAGIC_START0 = 0x0A324655
+UF2_MAGIC_START1 = 0x9E5D5157
+UF2_MAGIC_END = 0x0AB16F30
+
+UF2_BLOCK_SIZE = 512
+UF2_HEADER_SIZE = 32
+
+FLAG_NOT_MAIN_FLASH = 0x00000001
+FLAG_FAMILY_ID_PRESENT = 0x00002000
+
+RP2040_FAMILY_ID = 0xE48BFF56
+
+# Usual RP2350 / Pico 2 family IDs.
+# They are detected for diagnostics. This script does not implement
+# RP2350 partition table remapping.
+RP2350_FAMILY_IDS = {
+    0xE48BFF58: "rp2350-arm-secure",
+    0xE48BFF59: "rp2350-arm-nonsecure",
+    0xE48BFF5A: "rp2350-riscv",
+    0xE48BFF5B: "data-or-absolute",
+}
+
+XIP_BASE = 0x10000000
+
+# RP2040 UF2 flash window: 0x10000000 .. 0x11000000
+PICO1_FLASH_WINDOW_SIZE = 16 * 1024 * 1024
+
+# RP2350 UF2 flash window: 0x10000000 .. 0x12000000
+PICO2_FLASH_WINDOW_SIZE = 32 * 1024 * 1024
+
+
+def print_help() -> None:
+    """Print a minimal usage message."""
+
+    program_name = os.path.basename(sys.argv[0])
+
+    print("Usage:")
+    print(f"  {program_name} firmware.uf2 flash.img")
+    print()
+    print("Convert a Raspberry Pi Pico UF2 file into a raw flash image.")
+    print("Exactly one argument must have the .uf2 extension, the other")
+    print("is used as the raw flash output file.")
+    print()
+    print("Examples:")
+    print(f"  {program_name} blink.uf2 flash.img")
+    print(f"  {program_name} flash.raw blink.uf2")
+
+
+def get_extension(path: str) -> str:
+    """Return the lowercase extension of a path."""
+
+    return os.path.splitext(path)[1].lower()
+
+
+def detect_input_output(arguments: list[str]) -> tuple[str, str]:
+    """
+    Detect the UF2 input file and the raw image output file.
+
+    The arguments may be passed in either order, provided exactly one of them
+    has the .uf2 extension.
+    """
+
+    if len(arguments) != 2:
+        print_help()
+        sys.exit(2)
+
+    first_path, second_path = arguments
+    first_ext = get_extension(first_path)
+    second_ext = get_extension(second_path)
+
+    if first_ext == ".uf2" and second_ext != ".uf2":
+        return first_path, second_path
+
+    if second_ext == ".uf2" and first_ext != ".uf2":
+        print("Reversed arguments detected: using the .uf2 file as input.")
+        return second_path, first_path
+
+    print("Error: unable to determine which file is the UF2 input.")
+    print("Exactly one argument must have the .uf2 extension.")
+    print()
+    print_help()
+    sys.exit(2)
+
+
+def read_uf2_blocks(path: str):
+    """
+    Yield all 512-byte blocks from a UF2 file.
+
+    Raises ValueError if the file size is not a multiple of 512 bytes.
+    """
+
+    file_size = os.path.getsize(path)
+
+    if file_size == 0:
+        raise ValueError("empty file")
+
+    if file_size % UF2_BLOCK_SIZE != 0:
+        raise ValueError(
+            f"invalid UF2 file size: {file_size} bytes; "
+            f"expected a multiple of {UF2_BLOCK_SIZE}"
+        )
+
+    with open(path, "rb") as input_file:
+        physical_block_index = 0
+
+        while True:
+            block = input_file.read(UF2_BLOCK_SIZE)
+
+            if not block:
+                break
+
+            physical_block_index += 1
+
+            if len(block) != UF2_BLOCK_SIZE:
+                raise ValueError(
+                    f"incomplete block at physical index {physical_block_index}"
+                )
+
+            yield physical_block_index, block
+
+
+def analyze_uf2(uf2_path: str) -> dict:
+    """
+    Analyze a UF2 file and extract main-flash pages.
+
+    Returns a dictionary containing:
+        - pages: mapping from flash offset to payload bytes
+        - family_ids: detected family IDs
+        - warnings: non-fatal problems
+        - errors: fatal format problems
+        - min_offset / max_end_offset: occupied flash range
+    """
+
+    pages: dict[int, bytes] = {}
+    warnings: list[str] = []
+    errors: list[str] = []
+
+    family_ids: set[int] = set()
+    valid_block_count = 0
+    non_uf2_block_count = 0
+    ignored_not_main_flash_count = 0
+
+    min_offset = None
+    max_end_offset = 0
+
+    announced_num_blocks = None
+    seen_block_numbers: set[int] = set()
+
+    for physical_index, block in read_uf2_blocks(uf2_path):
+        (
+            magic_start0,
+            magic_start1,
+            flags,
+            target_address,
+            payload_size,
+            block_number,
+            num_blocks,
+            family_or_file_size,
+        ) = struct.unpack_from("<IIIIIIII", block, 0)
+
+        (magic_end,) = struct.unpack_from("<I", block, UF2_BLOCK_SIZE - 4)
+
+        if (
+            magic_start0 != UF2_MAGIC_START0
+            or magic_start1 != UF2_MAGIC_START1
+            or magic_end != UF2_MAGIC_END
+        ):
+            non_uf2_block_count += 1
+            errors.append(
+                f"block {physical_index}: invalid UF2 magic values"
+            )
+            continue
+
+        valid_block_count += 1
+
+        if announced_num_blocks is None:
+            announced_num_blocks = num_blocks
+        elif num_blocks != announced_num_blocks:
+            warnings.append(
+                f"block {physical_index}: inconsistent numBlocks "
+                f"({num_blocks}, expected {announced_num_blocks})"
+            )
+
+        if block_number in seen_block_numbers:
+            warnings.append(
+                f"block {physical_index}: duplicated blockNo {block_number}"
+            )
+
+        seen_block_numbers.add(block_number)
+
+        if flags & FLAG_NOT_MAIN_FLASH:
+            ignored_not_main_flash_count += 1
+            continue
+
+        if not (flags & FLAG_FAMILY_ID_PRESENT):
+            errors.append(
+                f"block {physical_index}: missing family ID; Pico boot ROM "
+                f"expects a family ID"
+            )
+            continue
+
+        family_id = family_or_file_size
+        family_ids.add(family_id)
+
+        if payload_size != 256:
+            errors.append(
+                f"block {physical_index}: payloadSize={payload_size}; "
+                f"expected 256 for Pico UF2 files"
+            )
+            continue
+
+        if target_address % 256 != 0:
+            errors.append(
+                f"block {physical_index}: target address is not "
+                f"256-byte aligned: 0x{target_address:08x}"
+            )
+            continue
+
+        pico2_window_end = XIP_BASE + PICO2_FLASH_WINDOW_SIZE
+        if not (XIP_BASE <= target_address < pico2_window_end):
+            errors.append(
+                f"block {physical_index}: target address outside Pico "
+                f"flash window: 0x{target_address:08x}"
+            )
+            continue
+
+        flash_offset = target_address - XIP_BASE
+
+        if flash_offset + payload_size > PICO2_FLASH_WINDOW_SIZE:
+            errors.append(
+                f"block {physical_index}: page exceeds Pico 2 flash window: "
+                f"offset=0x{flash_offset:x}, size={payload_size}"
+            )
+            continue
+
+        if flash_offset in pages:
+            warnings.append(
+                f"block {physical_index}: duplicated flash page at offset "
+                f"0x{flash_offset:x}; last occurrence wins"
+            )
+
+        payload = block[UF2_HEADER_SIZE:UF2_HEADER_SIZE + payload_size]
+        pages[flash_offset] = payload
+
+        if min_offset is None or flash_offset < min_offset:
+            min_offset = flash_offset
+
+        if flash_offset + payload_size > max_end_offset:
+            max_end_offset = flash_offset + payload_size
+
+    if valid_block_count == 0:
+        errors.append("no valid UF2 block found")
+
+    if (announced_num_blocks is not None
+            and len(seen_block_numbers) != announced_num_blocks):
+        warnings.append(
+            f"observed {len(seen_block_numbers)} distinct blockNo values, "
+            f"but numBlocks announces {announced_num_blocks}"
+        )
+
+    return {
+        "pages": pages,
+        "family_ids": family_ids,
+        "warnings": warnings,
+        "errors": errors,
+        "valid_block_count": valid_block_count,
+        "non_uf2_block_count": non_uf2_block_count,
+        "ignored_not_main_flash_count": ignored_not_main_flash_count,
+        "min_offset": min_offset,
+        "max_end_offset": max_end_offset,
+    }
+
+
+def diagnose_family_ids(
+    family_ids: set[int],
+    warnings: list[str],
+    errors: list[str],
+) -> None:
+    """
+    Diagnose UF2 family IDs with respect to Pico 1 and Pico 2.
+
+    RP2040 is accepted as the strict Pico 1 case.
+    RP2350 IDs are accepted with a warning because partition remapping is not
+    implemented.
+    """
+
+    if not family_ids:
+        errors.append("no usable family ID found")
+        return
+
+    if len(family_ids) > 1:
+        family_list = ", ".join(
+            f"0x{value:08x}" for value in sorted(family_ids)
+        )
+        warnings.append(f"multiple family IDs found: {family_list}")
+
+    for family_id in sorted(family_ids):
+        if family_id == RP2040_FAMILY_ID:
+            continue
+
+        if family_id in RP2350_FAMILY_IDS:
+            warnings.append(
+                f"family ID 0x{family_id:08x} detected "
+                f"({RP2350_FAMILY_IDS[family_id]}): this is probably a "
+                f"Pico 2 / RP2350 UF2 file. Linear conversion is performed, "
+                f"but RP2350 partition remapping is not implemented."
+            )
+        else:
+            warnings.append(
+                f"unknown or non-Pico family ID: 0x{family_id:08x}"
+            )
+
+    if RP2040_FAMILY_ID not in family_ids:
+        warnings.append(
+            "no RP2040 / Pico 1 family ID found (0xe48bff56); "
+            "the output may not be a strict Pico 1 flash image."
+        )
+
+
+def build_flash_image(pages: dict[int, bytes], occupied_size: int) -> bytearray:
+    """
+    Build a raw flash image initialized with erased flash bytes, 0xff.
+
+    Only the occupied part is emitted:
+        output size = highest written offset + payload size
+    """
+
+    image = bytearray([0xFF] * occupied_size)
+
+    for flash_offset, payload in pages.items():
+        image[flash_offset:flash_offset + len(payload)] = payload
+
+    return image
+
+
+def human_size(byte_count: int) -> str:
+    """Return a human-readable size string."""
+
+    if byte_count < 1024:
+        return f"{byte_count} B"
+
+    if byte_count < 1024 * 1024:
+        return f"{byte_count / 1024:.1f} KiB"
+
+    return f"{byte_count / (1024 * 1024):.2f} MiB"
+
+
+def main() -> None:
+    """Program entry point."""
+
+    uf2_path, image_path = detect_input_output(sys.argv[1:])
+
+    try:
+        analysis = analyze_uf2(uf2_path)
+    except OSError as error:
+        print(f"UF2 file access error: {error}")
+        sys.exit(1)
+    except ValueError as error:
+        print(f"UF2 format error: {error}")
+        sys.exit(1)
+
+    pages = analysis["pages"]
+    family_ids = analysis["family_ids"]
+    warnings = analysis["warnings"]
+    errors = analysis["errors"]
+
+    diagnose_family_ids(family_ids, warnings, errors)
+
+    if not pages:
+        errors.append("no main-flash page to write")
+
+    if analysis["max_end_offset"] > PICO1_FLASH_WINDOW_SIZE:
+        warnings.append(
+            "image exceeds the Pico 1 flash window "
+            "0x10000000..0x11000000; it is not strict Pico 1 compatible"
+        )
+
+    if errors:
+        print("Conversion refused: UF2 format problems were found.")
+        for error in errors:
+            print(f"ERROR: {error}")
+        for warning in warnings:
+            print(f"WARNING: {warning}")
+        sys.exit(1)
+
+    occupied_size = analysis["max_end_offset"]
+    image = build_flash_image(pages, occupied_size)
+
+    try:
+        with open(image_path, "wb") as output_file:
+            output_file.write(image)
+    except OSError as error:
+        print(f"Output image write error: {error}")
+        sys.exit(1)
+
+    programmed_size = sum(len(payload) for payload in pages.values())
+
+    print(f"UF2 input: {uf2_path}")
+    print(f"Raw output: {image_path}")
+    print(f"Valid UF2 blocks: {analysis['valid_block_count']}")
+    print("Ignored NOT_MAIN_FLASH blocks: "
+          f"{analysis['ignored_not_main_flash_count']}")
+    print(f"Written flash pages: {len(pages)}")
+    print(
+        f"Actually programmed bytes: {programmed_size} "
+        f"({human_size(programmed_size)})"
+    )
+    print(
+        f"Occupied flash size: {occupied_size} "
+        f"({human_size(occupied_size)})"
+    )
+
+    if family_ids:
+        family_id_list = ", ".join(
+            f"0x{value:08x}" for value in sorted(family_ids)
+        )
+        print(f"Family ID(s): {family_id_list}")
+
+    if warnings:
+        print()
+        print("Warnings:")
+        for warning in warnings:
+            print(f"- {warning}")
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tests/qtest/rp2040-xip-test.c b/tests/qtest/rp2040-xip-test.c
index bc1b47841d..bce4e8f25d 100644
--- a/tests/qtest/rp2040-xip-test.c
+++ b/tests/qtest/rp2040-xip-test.c
@@ -32,6 +32,15 @@
 #define XIP_STAT_FIFO_EMPTY BIT(1)
 #define XIP_STAT_FLUSH_READY BIT(0)
 
+#define UF2_BLOCK_SIZE          512
+#define UF2_PAYLOAD_OFFSET      32
+#define UF2_PAYLOAD_SIZE        256
+#define UF2_MAGIC_START0        0x0a324655
+#define UF2_MAGIC_START1        0x9e5d5157
+#define UF2_MAGIC_END           0x0ab16f30
+#define UF2_FLAG_FAMILY_ID      0x00002000
+#define UF2_RP2040_FAMILY_ID    0xe48bff56
+
 static QTestState *rp2040_start(const char *machine_args)
 {
     if (machine_args) {
@@ -76,6 +85,57 @@ static void finish_busy(QTestState *qts)
     ssi_deselect(qts);
 }
 
+static void build_uf2_block(uint8_t *block, uint32_t target, uint32_t index,
+                            const uint8_t *payload)
+{
+    memset(block, 0, UF2_BLOCK_SIZE);
+    stl_le_p(block, UF2_MAGIC_START0);
+    stl_le_p(block + 4, UF2_MAGIC_START1);
+    stl_le_p(block + 8, UF2_FLAG_FAMILY_ID);
+    stl_le_p(block + 12, target);
+    stl_le_p(block + 16, UF2_PAYLOAD_SIZE);
+    stl_le_p(block + 20, index);
+    stl_le_p(block + 24, 2);
+    stl_le_p(block + 28, UF2_RP2040_FAMILY_ID);
+    memcpy(block + UF2_PAYLOAD_OFFSET, payload, UF2_PAYLOAD_SIZE);
+    stl_le_p(block + UF2_BLOCK_SIZE - 4, UF2_MAGIC_END);
+}
+
+static void test_uf2_kernel_load(void)
+{
+    g_autoptr(GError) error = NULL;
+    g_autofree char *path = NULL;
+    uint8_t uf2[2 * UF2_BLOCK_SIZE];
+    uint8_t boot2[UF2_PAYLOAD_SIZE];
+    uint8_t payload[UF2_PAYLOAD_SIZE];
+    uint8_t actual[UF2_PAYLOAD_SIZE];
+    QTestState *qts;
+    int fd;
+    size_t i;
+
+    memset(boot2, 0x5a, sizeof(boot2));
+    for (i = 0; i < ARRAY_SIZE(payload); i++) {
+        payload[i] = i ^ 0xa5;
+    }
+    build_uf2_block(uf2, XIP_BASE, 0, boot2);
+    build_uf2_block(uf2 + UF2_BLOCK_SIZE, XIP_BASE + 0x2000, 1, payload);
+
+    fd = g_file_open_tmp("qemu-rp2040-uf2-XXXXXX", &path, &error);
+    g_assert_no_error(error);
+    g_assert_cmpint(fd, >=, 0);
+    close(fd);
+    g_assert_true(g_file_set_contents(path, (const char *)uf2, sizeof(uf2),
+                                      &error));
+    g_assert_no_error(error);
+
+    qts = qtest_initf("-machine raspi-pico -kernel %s", path);
+    qtest_memread(qts, XIP_BASE + 0x2000, actual, sizeof(actual));
+    g_assert_cmpmem(actual, sizeof(actual), payload, sizeof(payload));
+    qtest_quit(qts);
+
+    unlink(path);
+}
+
 static void read_flash_uid(QTestState *qts, uint8_t *uid)
 {
     int i;
@@ -353,6 +413,7 @@ int main(int argc, char **argv)
                    test_flash_uid_machine_option);
     qtest_add_func("/rp2040-xip/ssi-defers-unselected-data",
                    test_ssi_defers_unselected_data);
+    qtest_add_func("/rp2040-xip/uf2-kernel-load", test_uf2_kernel_load);
     qtest_add_func("/rp2040-xip/flash-program-erase",
                    test_flash_program_erase);
     qtest_add_func("/rp2040-xip/flash-persistence",
-- 
2.55.0


