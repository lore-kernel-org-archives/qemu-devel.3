Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54581CCA465
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQJ-0007Xr-0E; Thu, 15 Oct 2026 21:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNR-0001cq-1D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNK-0004PA-C9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e86dce4510so30389715ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112681; x=1792717481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=67J7/dAyvEkZLPJYh7VRut0A50m7CFCyrgy+F68cvhQ=;
 b=GVc3psNgQmwP2IW0wnlnILFb7GW2m/xs9o9TkGmHerz6K4G+3ocbhGeIq5xyMeBJz7
 7k3cxu5uVI/rkryXkCJBx0cA3/baKwRRL0TOb4n9N5hTD/ySlluA84BDfJt5ZU5feXQo
 gzkk/sUs7b37Bt4a/R52A0axCsegrSWTXKjnOFJmaRr2IUQAanuGzQiXPpMSwPTxx+EU
 AFpXgJWpjwzCDcKmuC93cRktMNsC2M4h063XAIenl9VlJu+W1ewGByLhtLUNAeHf4URk
 Rn4gpRHBddJlocrPhedNtUF55jthwaYeeZme96B19Deos/LB/ufQ5m7V39jlsbAii9vO
 Iu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112681; x=1792717481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=67J7/dAyvEkZLPJYh7VRut0A50m7CFCyrgy+F68cvhQ=;
 b=QG7PIrKCi4fO3phUEwu+YUEsSp5OSEQzv0vD2gsr8XYfTDefooecY+vMXzMPuE94s5
 dEttukIKfdm6foSGyuIkztGBPwZibE2cM7D4vH65IIgQTNPSiappZHDVB4xYXy7Isgqu
 UJop6SvAP20Z0ZGlQ4Gn64oGBmH+9CSC6K3lNzXK7rihJgbMkGQPBt52iBWzX7GnhDQ6
 Qgyid2zasf7QUR0lVpzYvlvKGcyKX65gHzlF/4kJculldzpbKH+fAKF85KUxkumay2xg
 kyxhuUkeKCh55ThlEUh7YmpAoDGKpYs/uxkpGT4DCeAS1s0KCdfZk4dDumP7ds/wC+XI
 SHsg==
X-Gm-Message-State: AFq9FYITK69tMj/j+vKj06aN17fbhaliLygwaLMTYyhaB3CGlvFvHE1d
 x+k2Bju+iHnWHpfXvTgjNNBCHmIAX8fSi/bdKlgcOOJ7xcFxoQN7mP+n/zLl7g==
X-Gm-Gg: AYBFou2Ffz5mKnhposVNMAOwZvcdRZ9uj/H4kLJxiTErbJ4kYbGNtQEhuJbOA66Uklb
 gBp/gfW75q+GFaG7Plha3U89E8dCvNRXQ1nQ13Bcfw2JpFHiUYCf/7a4qGxTTyuYZ68YOvLMJZD
 sHHWEjH/g73x3ifd0Ohm0myZ0IjCObsDjSgPGH/uplMqgbCTmTBC5VEroQXWF8JNdhHE+51wchx
 +Kq8DJFipcw/1YQlgqQrKmYIEWK33Q9u8/VZSZ+QZOlFEDGQ0GWRPdhzMsty239XpqXhQo+Kqnj
 oICgVuS3rpcv9K11RrhnSA6r4ppGzT0pACgIwBwlhvfk+Q0kUoqbyVrVCc5DT3kXk6yKea1GHm1
 lnVR2ppqyy7uXCsjYl2YiiGK6hlKaMwuGWIH+P5DxLoJgelpFyaCyNnm1K9DPocYn0K6LKn8u19
 4G31ZZIiWQUu6zdy3NT5ittMtQPNVKzIhn7GJ8W2bNaPEEp2KAsDyTbCl6Dfzi4WGzDO2UAOx86
 kLWrBBYp/3ohbDWe5zTDUdGslE=
X-Received: by 2002:a17:903:2990:b0:2e8:32c0:3495 with SMTP id
 d9443c01a7336-2e842f21208mr177093025ad.71.1792112681130; 
 Thu, 15 Oct 2026 18:04:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>
Subject: [PULL v2 39/50] docs: add riscv-server-ref.rst
Date: Fri, 16 Oct 2026 11:02:26 +1000
Message-ID: <20261016010237.1102834-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Add documentation for the new riscv-server-ref board.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Message-ID: <20260928201107.2049458-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/riscv-server-ref.rst | 65 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst           |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
new file mode 100644
index 0000000000..da043ed096
--- /dev/null
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -0,0 +1,65 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+RISC-V Server Platform Reference board (``riscv-server-ref``)
+=============================================================
+
+The RISC-V Server Platform specification `spec`_ defines a standardized
+set of hardware and software capabilities that portable system software,
+such as OS and hypervisors, can rely on being present in a RISC-V server
+platform.  This machine aims to emulate this specification, providing
+an environment for firmware/OS development and testing.
+
+`spec`_ is version 1.0 at the introduction of this board.  For each new
+supported spec version a new versioned board will be added, keeping
+"riscv-server-ref" as an alias for the newest version supported.  E.g.
+for spec version 2.0:
+
+* riscv-server-ref-1.0 - board that complies with spec version 1.0
+* riscv-server-ref-2.0 - board that complies with spec version 2.0
+* riscv-server-ref - alias for riscv-server-ref-2.0
+
+The main features included in the riscv-server-ref board are:
+
+* IOMMU platform device (riscv-iommu-sys)
+* AIA
+* No AHCI (can be added via command line)
+* No NIC (can be added via command line)
+* No virtio mmio bus
+* No fw_cfg device
+* No ACPI table
+* Minimal device tree nodes
+
+There are multiple ways of using this reference board.  The spec compliant way
+is using an EDK2 image and a TPM device.  The board was tested with the TPM
+device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
+to use this device can be found in `tpm`_.
+
+To use this board coupled with the tpm-tis device, first start the ``swtpm``
+process in a shell (the ``log`` parameter is optional):
+
+.. code-block:: bash
+
+    $ mkdir /tmp/mytpm1
+    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
+            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
+            --tpm2 \
+            --log level=20
+
+And then start QEMU with:
+
+.. code-block:: bash
+
+ qemu-system-riscv64 -M riscv-server-ref \
+     -bios fw_dynamic.bin \
+     -kernel EDK2.fd \
+     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
+     -device nvme,drive=hd0,serial=ddaaddaa \
+     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+     -tpmdev emulator,id=tpm0,chardev=chrtpm \
+     -device tpm-tis-device,tpmdev=tpm0 \
+     -netdev user,id=net0 -device e1000e,netdev=net0 \
+     -nographic
+
+
+.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
+.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 1e49055e29..cc0ef4b64f 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -71,6 +71,7 @@ undocumented; you can get a complete list by running
    riscv/microchip-icicle-kit
    riscv/milkv-duo
    riscv/mips
+   riscv/riscv-server-ref
    riscv/shakti-c
    riscv/sifive_u
    riscv/tt_atlantis
-- 
2.55.0


