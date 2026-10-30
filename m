Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F5606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=JV9Y9SR+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMdsw-0002Zj-9H; Fri, 30 Oct 2026 00:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdsj-0002Pl-JR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:06:21 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdsh-0004r8-BQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:06:21 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-36a1467ca93so40980eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793333178; x=1793937978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3TCrfqCJKuqF3SRXFHT054XbVUVtqognUB1jYv32OCw=;
 b=JV9Y9SR+cLVFt+H8KYOH51axeXLmZp2cw0wFpthEL/jXIClxYZXAYKxzK/ZvU1WElA
 1uoCDKhE0gJ3seC7d3QYiGUhHctDl3NZ8KMKWXQITDsY09v4U5bUjPls6EXyS+6tmDNv
 ReICwA2nnc8Tz1ILp2lkrqd2OSKVzAZQGSrJdwPbGnh+TwuLK1JruRB4Xw0Ak1LM+XfV
 1ok7kk7tz8YaSXIxe5vIWi2b1dhaHgzRGTiYHPA181UmIcxqBie1rzP99e4Vqs7z3R/v
 6UWvJMwUOpBtygeR3zSsr0CXdr8kuo6vkbeQGIhm/brAXNq8oTXmfuzEGoA2yjoCwKC0
 oK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793333178; x=1793937978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3TCrfqCJKuqF3SRXFHT054XbVUVtqognUB1jYv32OCw=;
 b=ppIAbupIdWARAD8kOUBba5bbr+JunwmLt4lw5CFeNLJY/YoLnI3Pl9lCg7AWY9bEHZ
 GiP56HcNzIkXmFOtVwllZFonr8l8c8cATG1+2D4MFzvoCJ6u0Jmtmc8567Xz6vWJUO1G
 kQh8kS2mbngMyLM5QHVweEaur4z6DX91gvEFO8ywN7LaGJE4fW7+J49KEfAwru0NXax7
 BxTv5mhXge9Y8T6+W8hs+7+LEGHgJZPf0G4QSMvcbOuOWU2MSRDegS5NNSiN477/0IUH
 oDOy8DS1DjlQNEtw6MuIaQmEJdR+DU1FZXAyj0YVzdKsuBbidxugiQeQGftaYBEKoVcs
 M7pA==
X-Gm-Message-State: AFq9FYLEk7RiWM20wvk2XQyOiwja3Oedbf6Zwk6bBXhtF6sNA1pldoZg
 xElv7wMR0U411RTEfWZ1Mam/8cvN6rFRqQcXzCouWEZql6u5OWvIu7kVROo/dFGxRYzGKHZRRn3
 9yQnd+ns=
X-Gm-Gg: AYBFou2c59fkwEZWl6enFv2jvqsqzIiNFEPB+5qvX/RraNjG+QbIfRaYmDl+TtlFdBE
 yUpmOcmfEjIVkZoCdMsTyqOnrmMUrxC9Ld4csKkqIVg+wzG6nlignT1cF2UNWNdl0HN89nu3L/X
 asl3ReU+UWPdgP31tEFJZTBgFu0q2+gbCk9AzqnO90Aj/XMic641rajibWpRY2nQRrSpkDg70bT
 uH0ENzmOkbLHg0DxL6VLzVCa0N59YQLmHBwbTqDAtyABToG4LkGM7SiIBM3pgGnJHLxd8iQ8dDq
 w3rcfnrZKsHZTFhnsOSndXdFmcF4fxcpNJmPOY/eRZP+T4bQ4BnOy3GmeWpEQmAG2+L/WGFg4hT
 88+M+WuG2rACNvO2jYwuAuKl4Regtsj4ouKkb9Gm9WjhiU0sYAbE+/H0ILFxRXpaVL3uG/vu5lt
 j7qnPsvcAhtzdq+i4HQ38GWDRNCmPtHOMZpQi19ZkX5j+0ryUhcd1sN2XcxDYgDuoZcW4fNqsT/
 1+iokb2OIZaLyYgKqoWaHEip3G8B5/okGPfylyjubOg1XhqXT7JkcdinUWck24rPbkKHV6Js1i9
 XZqdtZUVC1MBXpwZYIhGz2jNZeH+p2bgZb3/ztDgKaW4SmWn/CKCc2f0144q3SldxZtPaggWJmd
 DEw==
X-Received: by 2002:a05:693c:6304:b0:368:1f8c:5f23 with SMTP id
 5a478bee46e88-36a4205b0bfmr2963105eec.0.1793333177695; 
 Thu, 29 Oct 2026 21:06:17 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm2957687eec.5.2026.10.29.21.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:06:17 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3 9/9] docs/atlantis: Update Atlantis documentation to
 include the RCPU
Date: Fri, 30 Oct 2026 14:05:15 +1000
Message-ID: <20261030040516.853444-10-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030040516.853444-1-portias@oss.tenstorrent.com>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=portias@tenstorrent.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This updates the Atlantis documentation to include new machine
properties for running the RCPU.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 docs/system/gdb.rst               |  2 ++
 docs/system/riscv/tt_atlantis.rst | 46 +++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index b6d8f8e77d..3777630337 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -79,6 +79,8 @@ debug some interaction between kernel and user-space you are better
 off running your guest program with gdb either in the guest or using
 a gdbserver exposed via a port to the outside world.
 
+.. _GDB multicore:
+
 Debugging multicore machines
 ============================
 
diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
index d94d064f4f..533b41928b 100644
--- a/docs/system/riscv/tt_atlantis.rst
+++ b/docs/system/riscv/tt_atlantis.rst
@@ -12,10 +12,38 @@ tt-atlantis QEMU model features
 -------------------------------
 
 * 8-core Ascalon-X CPU Cluster
+* RV32 Real-time CPU (RCPU)
 * RISC-V compliant Advanced Interrupt Architecture
 * DW8250 compatible UART x5
 * 4 PRCMs (Clock and Reset Controllers)
 
+Boot options
+------------
+
+* ``rcpu`` enables the RCPU model to run alongside the Ascalon cluster and is
+  disabled by default. When the RCPU is enabled, ``UART0``, the RCPU's console,
+  will be mapped to the second -serial on the command line.
+* ``bootrom`` binary to be loaded into mask ROM and run by the RCPU (no effect if the
+  rcpu is not enabled). If no bootrom is provided the RCPU will not be powered on.
+
+To enable the RCPU model with a custom binary and the RCPU console on stdio:
+
+.. code-block:: bash
+
+  -M tt-atlantis,rcpu=on,bootrom=../path/to/binary.bin -serial null -serial stdio
+
+* ``-smp cpus=`` The smp cpu field includes the RCPU count. When rcpu=on, the
+  number of Ascalon harts created is smp.cpus - 1.  When rcpu=off, the number
+  of Ascalon harts created is smp.cpus.
+
+To run with only one Ascalon hart and no RCPU:
+
+.. code-block:: bash
+
+  -M tt-atlantis,rcpu=off -smp cpus=1
+
+
+
 Known limitations
 -----------------
 
@@ -25,8 +53,9 @@ real platform. Notably:
 * There is no PCI host bridge, so virtio-pci devices cannot be
   attached. Boots that need block storage must use ``-initrd`` with
   an initramfs.
-* The Atlantis platform has 5 UARTs but only ``UART1`` is currently exposed
-  on the command line serial interface. ``UART1`` is the Ascalon console.
+* The Atlantis platform has 5 UARTs but only ``UART1`` and, optionally,
+  ``UART0`` are currently exposed on the command line serial interface.
+  ``UART1`` is the Ascalon console and ``UART0`` is the RCPU console.
 
 Supported software
 ------------------
@@ -39,3 +68,16 @@ and Linux with default configurations.
 The development board hardware will require some implementation
 specific setup in firmware which is being developed and may
 become a requirement or option for the tt-atlantis machine.
+
+Debugging
+----------
+
+Ascalon and RCPU are on separate CPUClusters which allows gdb to put Ascalon
+and RCPU on separate inferiors. This prevents issues with switching between
+RV32 (RCPU) and RV64 (Ascalon) targets.
+
+By default, gdb will connect to inferior 1, the Ascalon cluster and the RCPU
+will be on inferior 2.
+
+gdb does not handle multiple inferiors by default, see :ref:`gdb multicore`
+for how to connect to inferior 2.
-- 
2.43.0


