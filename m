Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06984C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx253-00018R-4w; Thu, 20 Aug 2026 08:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernard.ladenthin@gmail.com>)
 id 1wx1rU-0003P4-PR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:27:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bernard.ladenthin@gmail.com>)
 id 1wx1rR-0003JU-N0
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:27:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so12832135e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787228828; x=1787833628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGWKF7Q4E594lvCa4E679e4UsbL54zM8kjCTmcNuopQ=;
 b=myflPqBFMcaIL0PRJ6htsxbNOrPqW6/OqvUsNWqQXTI6a61qcQxTPYheIZ2JbRtrKJ
 P1T9tBiFC7iAk7xPQk+LPPUtgt+EhdzYuLC5oOiY/Ba9hC/8Z8sGNgK2KpZoNRyp03YW
 ROpqi3MbQmUHnOqn42B74fj8zg7ae411f3t18ge5irnAx9wlmCqWFoW589SO6bcT5I4r
 8W5tzgiSuZdtC3DMjAvuuJEWbi6Pdu2JbkLL2zoTzEpBFwZ5KYs6A9eyUq07uuSVtBv+
 eRXTfzLVC3BIgUlbPODaSzHsNPz4FnKCDZzAJMXJj80GndSlJQ5/WtS7vW0J5uj4SFPS
 ZBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228828; x=1787833628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGWKF7Q4E594lvCa4E679e4UsbL54zM8kjCTmcNuopQ=;
 b=O4TgaBlAxgRl+7YPvUHxOXxidmFAJNTL1Z43oIPu76TfgsqHBXNbPUqSO8aAH72E7T
 5RGaaHiarQzcZlxgnTjL9vfRqLNQdCfRGRyUdCA6gWLd9wx+nhpjxM1786FrEysi1YIM
 z9XouFzzFmJXE8ajgHtMYP8vABM0ShbVbs7KllGSWcNDxSfYubf0H2IK9CmWFS7LEKA2
 XehuYwCIelgVHTQtSX1F/hNRNU9HHYUvFn0LRjkuYMQZtaQSjqeDleYgk6JeBkukmFO7
 T2MkPESgVP3Rgnk8Zu5MZrfxcYEOrRDefCtFCeH4Z9K1cJTJcnsiwysEXL+mW822qgoE
 P5bA==
X-Gm-Message-State: AOJu0YwRZ4uKToq3ICnpIyLVnmpjLA8WI7I6xB/qjhux6ioLBX3NYZrz
 MH3p4tJcLC+9gGG4vLzlhJunrmfQuSM/maBKrJ2DQF46PV/O+j6ur2R5gW2reR33
X-Gm-Gg: AR+sD13nz+LFlpOK2IpVz41SFBORif1tAem7DzQ7swCkcFPRzNgQQEHxYs6BmY634WT
 pxkz8c8DjctjR43Ub5qInE5usHHbyx5w6jjwv9v5Zv7w0OGG5bNp9QljRG7nwz7DAICZ5ATzPTr
 AseK3ApXzrDPFnO8hTQnVTG8i8iry5QgwtlP2ziqd/NuQn8khCX+yAdxRk7G215V9UMYuGqC49L
 4DEAhr7g+TX5BGE+sAOYBR3EL8pRx6Bp1eRLNfaQEtLN1oRmplzlNfDdkfOGuz2RJE8sUsJrNo1
 7XgtxMd61YeLAMM2dIVfJg0jWxggUVkq/OpKH2qVghgq6tPSFxGiGfnXq6yrFSNhoyzqnFdtUBy
 VmCg9PtyaRkNjr4mxVRg7pkHwKT3qXflTFnDcspWKoOas+Yksxkgm1ROVSo75vePy8TIq5PYeWA
 D7KnFpOhyS3Fe8eNRDzy/91ln4bJ3htmk4hWOEFgxaYCzGYQ6Je2xEyLR4eaEXOFufzjzyvWBi0
 ZVDWvb/W+rivYCkHbwXYQ5SnmoPQt3eZvfq17fMdiMDZkwsIMUiMhsRrzsf9wzT7hRiplejUKTj
 Gx9TquATLAGkvgs5dtk06t95dlRHPlWj31Up37Oe3wxw1vfj7BNpILjVA/xCMhzOSYA=
X-Received: by 2002:a05:600c:4e55:b0:499:a07d:a482 with SMTP id
 5b1f17b1804b1-499aa1a28efmr247225225e9.10.1787228827863; 
 Thu, 20 Aug 2026 05:27:07 -0700 (PDT)
Received: from localhost.localdomain
 (p2003010827046e07f1219fbed82e562c.dip0.t-ipconnect.de.
 [2003:108:2704:6e07:f121:9fbe:d82e:562c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8022sm10536183f8f.18.2026.08.20.05.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:27:07 -0700 (PDT)
From: Bernard Ladenthin <bernard.ladenthin@gmail.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 Bernard Ladenthin <bernard.ladenthin@gmail.com>
Subject: [PATCH 2/2] tests/spapr: add bare-metal reproducers for pseries
 machine behaviour
Date: Thu, 20 Aug 2026 14:26:44 +0200
Message-ID: <20260820122644.19691-3-bernard.ladenthin@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260820122644.19691-1-bernard.ladenthin@gmail.com>
References: <20260820122644.19691-1-bernard.ladenthin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=bernard.ladenthin@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:41:08 -0400
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

These are small PowerPC payloads booted with -kernel on -M pseries.  They
drive the hypervisor interface directly -- hypercalls, CRQ, SRP -- so no
guest operating system is involved and a failure is attributable to one
function in QEMU rather than to something a kernel did on the way there.

vscsibig.S is the first.  It registers a CRQ, identity-maps its pages with
H_PUT_TCE, clears the power-on unit attention, then issues a single 256 KiB
READ_10 described by one DIRECT descriptor and checks where the data landed.
The buffer is poisoned with 0xeeeeeeee first, which separates "the DMA never
happened" from "the disk really holds zeros".

Following tests/multiboot, the built payload is committed so the test can be
run without a PowerPC cross toolchain, and run_test.sh is a standalone script
rather than a meson target.  The ELF is 920 bytes: linking with -N keeps the
loader from page-aligning the load segment, which would otherwise pad a
584-byte payload out to 65 KiB of zeros.

"make check-reproducible" rebuilds from source and compares against the
committed binary, so the .S and the .elf cannot drift apart unnoticed.
Signed-off-by: Bernard Ladenthin <bernard.ladenthin@gmail.com>
---
 MAINTAINERS              |   1 +
 tests/spapr/Makefile     |  62 +++++++++
 tests/spapr/link.ld      |   3 +
 tests/spapr/run_test.sh  | 108 +++++++++++++++
 tests/spapr/vscsibig.S   | 285 +++++++++++++++++++++++++++++++++++++++
 tests/spapr/vscsibig.elf | Bin 0 -> 920 bytes
 6 files changed, 459 insertions(+)
 create mode 100644 tests/spapr/Makefile
 create mode 100644 tests/spapr/link.ld
 create mode 100644 tests/spapr/run_test.sh
 create mode 100644 tests/spapr/vscsibig.S
 create mode 100644 tests/spapr/vscsibig.elf

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..e226d254b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1658,6 +1658,7 @@ F: pc-bios/slof.bin
 F: docs/system/ppc/pseries.rst
 F: docs/specs/ppc-spapr-*
 F: tests/qtest/spapr*
+F: tests/spapr/
 F: tests/qtest/libqos/*spapr*
 F: tests/qtest/rtas*
 F: tests/qtest/libqos/rtas*
diff --git a/tests/spapr/Makefile b/tests/spapr/Makefile
new file mode 100644
index 0000000000..60af7f903f
--- /dev/null
+++ b/tests/spapr/Makefile
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Bare-metal reproducers for pseries (sPAPR) machine behaviour.
+#
+# These are tiny PowerPC payloads booted with -kernel on -M pseries.  They
+# talk to the hypervisor interface directly -- hypercalls, CRQ, SRP -- so
+# they exercise QEMU's sPAPR implementation with no guest operating system
+# anywhere in the picture.  That makes a failure attributable to one
+# function in QEMU rather than to something a kernel did on the way there.
+#
+# The built payloads are committed so the tests can be run without a
+# PowerPC cross toolchain, following tests/multiboot.  They are small:
+# linking with -N keeps the loader from page-aligning the load segment,
+# which would otherwise pad a 584-byte payload out to 65 KiB of zeros.
+#
+# Rebuild with:
+#     make CROSS=powerpc64-linux-gnu-
+#
+# and confirm the committed binary still matches its source with:
+#     make check-reproducible
+
+CROSS ?= powerpc64-linux-gnu-
+AS     = $(CROSS)as
+LD     = $(CROSS)ld
+STRIP  = $(CROSS)strip
+
+ASFLAGS = -many
+LDFLAGS = -N -T link.ld
+
+PAYLOADS = vscsibig
+ELFS     = $(PAYLOADS:%=%.elf)
+
+all: $(ELFS)
+
+%.o: %.S
+	$(AS) $(ASFLAGS) -o $@ $<
+
+%.elf: %.o link.ld
+	$(LD) $(LDFLAGS) -o $@ $<
+	$(STRIP) $@
+
+# The payloads are position-fixed and self-contained, so rebuilding from
+# the same source must produce the same bytes.  If this fails, the
+# committed ELF and the committed .S have drifted apart and one of them is
+# lying about what was tested.
+check-reproducible: $(ELFS)
+	@for p in $(PAYLOADS); do \
+	    cp $$p.elf $$p.elf.committed; \
+	    $(MAKE) --no-print-directory -B $$p.elf CROSS=$(CROSS) >/dev/null; \
+	    if cmp -s $$p.elf $$p.elf.committed; then \
+	        echo "  $$p.elf: reproducible"; \
+	    else \
+	        echo "  $$p.elf: DIFFERS from the committed binary"; \
+	        mv $$p.elf.committed $$p.elf; exit 1; \
+	    fi; \
+	    mv $$p.elf.committed $$p.elf; \
+	done
+
+clean:
+	rm -f *.o *.elf.committed vscsidisk.raw *.monitor.txt
+
+.PHONY: all clean check-reproducible
diff --git a/tests/spapr/link.ld b/tests/spapr/link.ld
new file mode 100644
index 0000000000..e901962834
--- /dev/null
+++ b/tests/spapr/link.ld
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+ENTRY(_start)
+SECTIONS { . = 0x400000; .text : { *(.text) } }
diff --git a/tests/spapr/run_test.sh b/tests/spapr/run_test.sh
new file mode 100644
index 0000000000..935b0fc2e4
--- /dev/null
+++ b/tests/spapr/run_test.sh
@@ -0,0 +1,108 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Run the bare-metal sPAPR reproducers and check the words each leaves
+# behind.
+#
+# Each payload boots with -kernel on -M pseries, drives the hypervisor
+# interface directly, and writes its results to physical 0x01000000.  This
+# script reads that buffer back through the QEMU monitor and compares it
+# against the expected words.
+#
+# Not wired into meson or CI, the same as tests/multiboot: it needs a
+# machine, it takes a few seconds per payload, and its value is in being
+# runnable by hand when someone doubts a claim.
+#
+# Usage:
+#     ./run_test.sh [/path/to/qemu-system-ppc64]
+#
+# Exit status is 0 only if every assertion held.
+
+set -u
+
+QEMU=${1:-${QEMU:-../../build/qemu-system-ppc64}}
+SETTLE=${SETTLE:-15}
+
+if [ ! -x "$QEMU" ]; then
+    echo "qemu-system-ppc64 not found at: $QEMU" >&2
+    echo "pass the path as \$1 or set \$QEMU" >&2
+    exit 2
+fi
+
+fail=0
+pass=0
+
+# Backing disk for vscsibig: sector s starts with the big-endian word
+# 0xA5000000|s, so a chunk that lands at the wrong offset names the sector
+# it really came from.  Generated rather than committed -- it is 2 MiB of
+# almost nothing.
+make_disk() {
+    perl -e '
+        open(my $f, ">", "vscsidisk.raw") or die;
+        binmode $f;
+        for my $s (0 .. 4095) {
+            print $f pack("N", 0xA5000000 | $s), (chr(0) x 508);
+        }
+        close $f;
+    '
+}
+
+# $1 payload  $2 words to dump  $3.. "index:expected:description"
+run_payload() {
+    local name=$1 words=$2; shift 2
+    local out="$name.monitor.txt"
+
+    ( sleep "$SETTLE"; printf 'x /%dxw 0x1000000\nquit\n' "$words" ) | \
+        "$QEMU" -M pseries -cpu POWER7 -m 512 \
+            -display none -vga none -nodefaults -serial none \
+            -kernel "$name.elf" \
+            -device spapr-vscsi,id=scsi0 \
+            -drive file=vscsidisk.raw,if=none,id=d0,format=raw \
+            -device scsi-hd,bus=scsi0.0,drive=d0 \
+            -monitor stdio >"$out" 2>/dev/null
+
+    # The monitor prints "0000000001000000: 0x00000000 0x00000000 ..." and,
+    # being a readline monitor on a pipe, echoes every typed character
+    # wrapped in cursor-control escapes.  Pulling out each 0x-prefixed
+    # 8-digit token sidesteps both: the echoed command contains 0x1000000,
+    # which is seven digits and does not match.
+    local got n
+    got=$(grep -oE '0x[0-9a-f]{8}' "$out" | sed 's/^0x//')
+    n=$(printf '%s\n' "$got" | grep -c .)
+
+    if [ "$n" -lt "$words" ]; then
+        echo "  $name: NOTHING MEASURED -- expected $words words, got $n"
+        echo "        A short read means the payload did not finish or the"
+        echo "        dump failed.  Raise \$SETTLE and look at $out."
+        fail=$((fail + 1))
+        return
+    fi
+
+    local spec idx expect desc actual
+    for spec in "$@"; do
+        idx=${spec%%:*}; spec=${spec#*:}
+        expect=${spec%%:*}; desc=${spec#*:}
+        actual=$(echo "$got" | sed -n "$((idx + 1))p")
+        if [ "$actual" = "$expect" ]; then
+            echo "  PASS  $desc"
+            pass=$((pass + 1))
+        else
+            echo "  FAIL  $desc"
+            echo "        expected $expect, got ${actual:-<nothing>}"
+            fail=$((fail + 1))
+        fi
+    done
+}
+
+echo "=== vscsibig: a >128 KiB transfer must not be folded onto the"
+echo "    start of the guest buffer ==="
+make_disk
+run_payload vscsibig 20 \
+    "1:00000000:H_REG_CRQ registered the queue on the vSCSI adapter" \
+    "11:00000000:the 256 KiB READ_10 reports SRP status 0 either way" \
+    "13:a5000000:sector 0 landed at buffer offset 0" \
+    "15:a5000100:sector 256 landed at buffer offset 0x20000"
+
+echo
+echo "$pass passed, $fail failed"
+[ "$fail" -eq 0 ]
diff --git a/tests/spapr/vscsibig.S b/tests/spapr/vscsibig.S
new file mode 100644
index 0000000000..6474d31f0e
--- /dev/null
+++ b/tests/spapr/vscsibig.S
@@ -0,0 +1,285 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * vscsibig.S -- guest-free reproducer for defect 7:
+ *   spapr_vscsi silently drops data on any transfer larger than 128 KiB.
+ *
+ * struct vscsi_req::cur_desc_offset is uint16_t.  scsi-disk delivers a
+ * command in SCSI_DMA_BUF_SIZE (128 KiB) chunks, so vscsi_srp_direct_data()
+ * does
+ *     req->cur_desc_offset += 0x20000;      /  0x20000 & 0xFFFF == 0  /
+ * and wraps back to zero: every chunk after the first is DMA'd over the
+ * START of the guest buffer.  The command still completes with status 0 and
+ * no sense data.
+ *
+ * This payload speaks CRQ + SRP directly -- no guest OS, no SLOF client
+ * interface. QEMU's vscsi_process_srp_iu() dispatches SRP_CMD without
+ * requiring a prior LOGIN, and SPAPR_VIO_LIOBN(reg) == reg, so the whole
+ * thing is: free any CRQ SLOF left behind, register our own, identity-map
+ * the pages we touch with H_PUT_TCE, clear the power-on UNIT ATTENTION with
+ * a TEST UNIT READY, then send one READ_10 of 512 blocks (= 256 KiB)
+ * described by a single DIRECT descriptor.
+ *
+ * The backing disk is written by mkvscsidisk.py so that sector s starts with
+ * the big-endian word 0xA5000000|s.  Therefore:
+ *
+ *   +0x30  data[0]        RED 0xa5000100 (the 2nd chunk landed at offset 0)
+ *                       GREEN 0xa5000000 (sector 0, where it belongs)
+ *   +0x38  data[0x20000]  RED 0xeeeeeeee (poison -- never written at all)
+ *                       GREEN 0xa5000100 (sector 256)
+ *
+ * Poison rather than zero matters: it separates "the DMA never happened"
+ * from "the disk really holds zeros", which is exactly the distinction that
+ * cost two measurement rounds when this was first chased through AIX.
+ *
+ * Results at physical 0x01000000; read with the monitor: x /10xg 0x1000000
+ *   +0x00  H_REG_CRQ return code (0 = registered)
+ *   +0x08  the VIO unit address that answered (0x71000000 + n)
+ *   +0x10  return code of the last H_PUT_TCE
+ *   +0x18  H_SEND_CRQ return code for the READ
+ *   +0x20  poll iterations spent waiting for the READ response
+ *          (0x04000000 = the cap: it timed out, all below is void)
+ *   +0x28  SRP RSP status byte of the READ  -- must be 0; 2 = CHECK CONDITION
+ *   +0x30  data[0]
+ *   +0x38  data[0x20000]
+ *   +0x40  SRP RSP status byte of the TEST UNIT READY (2 is normal: it eats the
+ *          power-on UNIT ATTENTION, which is exactly why it is sent first)
+ *   +0x48  poll iterations spent waiting for the TEST UNIT READY response
+ *
+ * Physical map: payload 0x00400000 (relocated by spapr, harmless -- every
+ * address here is absolute), results 0x01000000, CRQ queue 0x02000000, TUR
+ * IU 0x02002000, READ IU 0x02001000, data buffer 0x02100000 + 256 KiB.  Run
+ * at -m 512 or more.
+ */
+    .section .text
+    .globl  _start
+_start:
+    /* r11 = result buffer  0x01000000      */
+    lis     11, 0x0100
+    /* r20 = CRQ queue      0x02000000      */
+    lis     20, 0x0200
+    /* r21 = READ IU        0x02001000      */
+    addi    21, 20, 0x1000
+    /* r19 = TUR IU         0x02002000      */
+    addi    19, 20, 0x2000
+    /* r22 = data buffer    0x02100000      */
+    lis     22, 0x0210
+
+    /* ---- clear the result buffer (80 bytes) ---- */
+    li      0, 0
+    li      9, 0
+1:  stdx    0, 11, 9
+    addi    9, 9, 8
+    cmpwi   9, 80
+    blt     1b
+
+    /* ---- clear the CRQ queue page: we poll it, so it must start empty ---- */
+    li      0, 0
+    li      9, 0
+2:  stdx    0, 20, 9
+    addi    9, 9, 8
+    cmpwi   9, 0x1000
+    blt     2b
+
+    /* ---- poison the whole 256 KiB data buffer ---- */
+    lis     8, 0xEEEE
+    ori     8, 8, 0xEEEE
+    li      9, 0
+    /* 0x00040000 bytes                     */
+    lis     10, 0x0004
+3:  stwx    8, 22, 9
+    addi    9, 9, 4
+    cmpw    9, 10
+    blt     3b
+
+    /* ---- find the vSCSI unit: H_FREE_CRQ, then H_REG_CRQ ----
+     * H_REG_CRQ gives H_PARAMETER for a unit that does not exist,
+     * H_NOT_FOUND for one without a CRQ (a vty), so the first success
+     * is the vSCSI adapter.  The unit that answered is recorded, so a
+     * wrong guess is visible rather than silent. */
+    /* candidate unit 0x71000000            */
+    lis     23, 0x7100
+    li      24, 0
+/* H_FREE_CRQ                           */
+4:  li      3, 0x100
+    mr      4, 23
+    sc      1
+    /* H_REG_CRQ                            */
+    li      3, 0xFC
+    mr      4, 23
+    /* queue address (IOVA)                 */
+    mr      5, 20
+    li      6, 0
+    /* queue length 4096                    */
+    ori     6, 6, 0x1000
+    sc      1
+    cmpdi   3, 0
+    beq     5f
+    addi    23, 23, 1
+    addi    24, 24, 1
+    cmpwi   24, 8
+    blt     4b
+    /* no unit answered -- record and stop  */
+    std     3, 0(11)
+    b       99f
+/* +0x00 H_REG_CRQ rc                   */
+5:  std     3, 0(11)
+    /* +0x08 unit that answered             */
+    std     23, 8(11)
+
+    /* ---- identity-map 0x02000000..0x02200000 into the TCE window ----
+     * SPAPR_VIO_LIOBN(reg) == reg, page shift 12, window base 0,
+     * so ioba == phys. */
+    lis     25, 0x0200
+    li      26, 0
+/* H_PUT_TCE                            */
+6:  li      3, 0x20
+    /* liobn == unit                        */
+    mr      4, 23
+    /* ioba                                 */
+    mr      5, 25
+    /* tce = page | read | write            */
+    ori     6, 25, 3
+    sc      1
+    addi    25, 25, 0x1000
+    addi    26, 26, 1
+    cmpwi   26, 512
+    blt     6b
+    /* +0x10 last H_PUT_TCE rc              */
+    std     3, 16(11)
+
+    /* ================= 1. TEST UNIT READY, to eat the UNIT ATTENTION =========
+     * A freshly reset SCSI device answers its first command with
+     * sense key 0x06 / ASC 0x29 (power on, reset or bus device reset).  Without
+     * it the READ below fails with CHECK CONDITION and transfers
+     * nothing. */
+    li      0, 0
+    li      9, 0
+7:  stdx    0, 19, 9
+    addi    9, 9, 8
+    cmpwi   9, 48
+    blt     7b
+    li      0, 0x02
+    /* opcode = SRP_CMD                     */
+    stb     0, 0(19)
+                                    /* buf_fmt 0 = no data          */
+    lis     0, 0x8000
+    /* lun = 0x8000000000000000             */
+    stw     0, 20(19)
+                                    /* cdb[0] +32 = TEST UNIT READY */
+    /* H_SEND_CRQ (0x104 is H_VIO_SIGNAL!)  */
+    li      3, 0x108
+    mr      4, 23
+    lis     5, 0x8001
+    sldi    5, 5, 32
+    /* 80 01 00 00 0000 0030 (IU_length 48) */
+    ori     5, 5, 0x0030
+    mr      6, 19
+    sc      1
+
+    li      27, 0
+    /* poll cap ~67M                        */
+    lis     28, 0x0400
+/* response lands in queue slot 0       */
+8:  lbz     0, 0(20)
+    cmpwi   0, 0
+    bne     9f
+    addi    27, 27, 1
+    cmpd    27, 28
+    blt     8b
+/* +0x48 TUR poll iterations            */
+9:  std     27, 72(11)
+    /* srp_rsp.status                       */
+    lbz     0, 19(19)
+    /* +0x40 TUR status (2 = the UA)        */
+    std     0, 64(11)
+
+    /* ============ 2. the READ_10 that reproduces the defect ======== */
+    li      0, 0
+    li      9, 0
+10: stdx    0, 21, 9
+    addi    9, 9, 8
+    cmpwi   9, 64
+    blt     10b
+
+    li      0, 0x02
+    /* opcode = SRP_CMD                     */
+    stb     0, 0(21)
+    li      0, 0x01
+    /* buf_fmt: data-in = DIRECT            */
+    stb     0, 5(21)
+    li      0, 0
+    /* data_out_desc_cnt = 0                */
+    stb     0, 6(21)
+    li      0, 1
+    /* data_in_desc_cnt  = 1                */
+    stb     0, 7(21)
+    lis     0, 0x1122
+    ori     0, 0, 0x3344
+    /* tag (any)                            */
+    stw     0, 8(21)
+    lis     0, 0x5566
+    ori     0, 0, 0x7788
+    stw     0, 12(21)
+    lis     0, 0x8000
+    /* lun = 0x8000000000000000 (SAM-5 LU)  */
+    stw     0, 20(21)
+    li      0, 0
+    stw     0, 24(21)
+                                    /* add_cdb_len at +31 stays 0   */
+    li      0, 0x28
+    /* cdb[0] = READ(10)                    */
+    stb     0, 32(21)
+    li      0, 0x02
+    /* cdb[7..8] = 0x0200 = 512 blocks      */
+    stb     0, 39(21)
+
+    /* srp_direct_buf { va, key, len } at add_data (+48) */
+    li      0, 0
+    stw     0, 48(21)
+    /* va  = 0x02100000                     */
+    stw     22, 52(21)
+    /* key = 0                              */
+    stw     0, 56(21)
+    lis     0, 0x0004
+    /* len = 0x00040000 = 256 KiB           */
+    stw     0, 60(21)
+
+    /* H_SEND_CRQ                           */
+    li      3, 0x108
+    mr      4, 23
+    lis     5, 0x8001
+    sldi    5, 5, 32
+    /* 80 01 00 00 0000 0040 (IU_length 64) */
+    ori     5, 5, 0x0040
+    mr      6, 21
+    sc      1
+    /* +0x18 H_SEND_CRQ rc                  */
+    std     3, 24(11)
+
+    /* the TUR response took slot 0, so this one lands in slot 1 (offset 16) */
+    addi    29, 20, 16
+    li      27, 0
+    lis     28, 0x0400
+11: lbz     0, 0(29)
+    cmpwi   0, 0
+    bne     12f
+    addi    27, 27, 1
+    cmpd    27, 28
+    blt     11b
+/* +0x20 READ poll iterations           */
+12: std     27, 32(11)
+    /* srp_rsp.status -- must be 0          */
+    lbz     0, 19(21)
+    /* +0x28                                */
+    std     0, 40(11)
+
+    /* ---- the two witnesses ---- */
+    lwz     0, 0(22)
+    /* +0x30 data[0]                        */
+    std     0, 48(11)
+    lis     8, 0x0002
+    lwzx    0, 22, 8
+    /* +0x38 data[0x20000]                  */
+    std     0, 56(11)
+
+99: b       99b
diff --git a/tests/spapr/vscsibig.elf b/tests/spapr/vscsibig.elf
new file mode 100644
index 0000000000000000000000000000000000000000..b0d472adca3298a9e78f64c701e71156bdcc3e96
GIT binary patch
literal 920
zcmb_bKWGzC9RA)*YOciL%H={3g`?71C4@jbT=FjID^y9LLzga{t`&>WNqgXdX?he2
z8H-cEMUc9<c5}&81ZTl9gPW2`u-HQTd-vx_p>DqA`~AM(-|yYK{l}|MIA_p@!zMc+
zq-Il#e~TFjmog-B;N+{^Ld*kU8c$rAvf!P>$`GvOGqfX)=81`B;GjL^rb|f;2j~`8
z9yK1qs7_*SDZ2cn`BKK4P<#vH@uo2ztD2TXey_Yzqq=-|axIRxM=v0#r%SVX-#>-R
zz_jb*LfO5;_n|uk{8JN(uigii4sf^m8%$KdsudVC<MY`L&;c7L{PP3GqQfDi>Ip~n
z*`N6mKAlBQ^$-mcVuNb$a5aBKHGef(+3u*Pn)tv1JVZFMP@)|T)z5nuvGBNX>K~)t
z+kPAGEPP-w%A;Qbs-#CAz!a~+x?-f}{5;=5r*FYJD?;kKvh_Tv=h2s?I2+iQP<e#6
zQorC~YTC#A@{tY0!}_+5SADW?$NSl|ALWx@A)KQ+hmaFKNcsAkuUMeC>j8N}?*=`x
z_u*r#hwh~!PDn$h>)t<gIek0UH5Ziu(pPWM+-_Oc$adpLRoi{O8@voQw@?e7g#oSk
nzfO@FWj{vpzNKy*CYFBBSs=?-zOr*!;5zbQ>Q7zg^*mewP}Q64

literal 0
HcmV?d00001

-- 
2.49.0.windows.1


