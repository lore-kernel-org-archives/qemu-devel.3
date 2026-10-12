Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615E8CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDjx-0005hD-6m; Mon, 12 Oct 2026 06:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjs-0005ex-6I
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDjq-0000xu-BS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:58:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2e608cd460eso8734965ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791802717; x=1792407517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+WxLx+zZjQOI7fhiqyMiVvUah5BrBJxOzJuO13wGSI=;
 b=ROCHFVdF9sZWV8OzpR8Jdtph+EZKhVZ3dhlVbLY9ifg3Bx39Td8hteih19dYbsA9Yc
 7RgTypt32xgCL6eNDnuZ1mrNr/Qlgk2SMtuThcN+XID+mohqKG7gtLD36DuUiDMW0Vpq
 1AsEG81A6Ok+0m7n3M1oCjWyJtFe2P2zkHfwSPR1DeiIir9GiPaTaUC5qIRgx4k6fEPQ
 cED3cMQbP+dIfz3pV4dmPuX8OnMJYPaie6V1515VawSF4Nthh0qXInZ5pMFK7R/c2Dp0
 xlcIJoJtErfeHMGS/IC3OBugX/Z3AXbPrx02Ww3JRMxbdoVTSkKzr8o1stRGVQxtdoua
 4G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791802717; x=1792407517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X+WxLx+zZjQOI7fhiqyMiVvUah5BrBJxOzJuO13wGSI=;
 b=KdUi7fKJB7f6gTiSHt7FQKjL668S/rdvV+9KHNG4ctCIM3HhBLK8G0qC2HJ9fbiWKK
 hRyvk+zrNgEf+OtV3d2NrBTuKjqAQ0fFJn4f7YHBBwgCpHMcZsJIe5pkPR3tq6g6BY+t
 Cm0ILNUIOcOVWBH1bHTGdFES4Iaxl+Nlwgd3uHVNrvn6m1BZKdF2Ymemqpb5BHgPidmz
 zx6Oxl0m/SJaECxEYyhLiR6jxswtt1qZxiIWreeebVWk/nAkaQjq9ZsZkmozyzh3fGCE
 0DdWc+mNoepFfE7CZ3gq9NSEgiQt8G0oq6r5ezDUFKNB8ypIHnTKYM8oVX7C358ljqCJ
 a0ug==
X-Gm-Message-State: AFq9FYJTpERRmgLU7dUmmg8YHI1ypYkC02yFxw5B7/6Q2aCtqyKsKRRQ
 TGAc9IdveC00JMOzGrtcClZHAL7uq+DDdUGf8/pynlkR2jbOSEvqzz0NgU/CZQ==
X-Gm-Gg: AYBFou0MY2Gl1XvUlsCQbm94hKFOd+7WCqMpuP9p0UNlW/5QXN2idPAGQ6Swqz8q0pJ
 UHQMgDkQwiGpEQFpNVcfgwDegfzarChk2C/C4qQCmueaapsqvcb2e2nCgsRQaFecz9QW3WL3WQC
 euKn5xg1o+6WpGs3uBEO+OMpHquz+pJwTzrISUso37tqQ4fNLsnrnNyfnPT9GcKTt91ca2c+z+/
 DDy/RLQk7EPQ+yn1y/e6xerQ9hfIZfUAtPvXDlC8wJzXAvzm9x8U7Vq/NnIhguakz+TmZMysRZ6
 94sWTSTJ8qN1YuQKN+DgEznK5QxHuq0T214F00sD3NQJr/bBl8IvcNR9o+CFQ9YWLOekdKPApYP
 WLCaiOpVii5cGMDK6hQIre8pJqQ/RGE38UaQz6u7mQc+fxHZY/KM64i1lHfdU8SWGsi6MtRypZP
 FxnLQKH24MoJlHN1lGRRYS0xfq1V7fWD+J7qZxwMaf55PiQKJsbNd/fBkH3nq2YhpYD0rhyIjOv
 5w=
X-Received: by 2002:a17:903:2283:b0:2e8:3d48:4d80 with SMTP id
 d9443c01a7336-2e842ab6dd1mr74734335ad.45.1791802716756; 
 Mon, 12 Oct 2026 03:58:36 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e6aasm41220305ad.18.2026.10.12.03.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:58:35 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stanleyjhu@google.com, pierrick.bouvier@oss.qualcomm.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 5/5] docs/system: Add UFS emulation page
Date: Mon, 12 Oct 2026 19:58:07 +0900
Message-ID: <c44c626e28f1c87e89decaa73756d081f069b9d3.1791802312.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791802312.git.jeuk20.kim@samsung.com>
References: <cover.1791802312.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Stanley Jhu <stanleyjhu@google.com>

The UFS host controller and logical unit devices have no user
documentation. Their properties and the way the two devices fit
together can only be found by reading hw/ufs/.

Add docs/system/devices/ufs.rst with an example command line, the
device properties, and current limitations, and list it under the UFS
entry in MAINTAINERS.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 MAINTAINERS                      |  1 +
 docs/system/device-emulation.rst |  1 +
 docs/system/devices/ufs.rst      | 88 ++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 docs/system/devices/ufs.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd8..c7f65a5a779 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2758,6 +2758,7 @@ S: Supported
 F: hw/ufs/*
 F: include/block/ufs.h
 F: tests/qtest/ufs-test.c
+F: docs/system/devices/ufs.rst
 
 megasas
 L: qemu-block@nongnu.org
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 40054bb7dfc..a7d247a270e 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -96,6 +96,7 @@ Emulated Devices
    devices/net.rst
    devices/nvme.rst
    devices/scsi/index.rst
+   devices/ufs.rst
    devices/usb-u2f.rst
    devices/usb.rst
    devices/vfio-user.rst
diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
new file mode 100644
index 00000000000..d3482e92992
--- /dev/null
+++ b/docs/system/devices/ufs.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=============
+UFS Emulation
+=============
+
+QEMU emulates a Universal Flash Storage (UFS) host controller and the
+logical units behind it. The host controller follows the UFSHCI
+register interface and reports UFS version 4.1 to the guest.
+
+Two devices are involved:
+
+``ufs``
+  The host controller on the PCI bus. A ``sysbus-ufs`` variant exists
+  for boards that place the controller on the system bus; it cannot be
+  created with ``-device``.
+
+``ufs-lu``
+  A logical unit attached to a host controller through ``bus=``. Each
+  logical unit is backed by a block device.
+
+The well-known logical units (REPORT LUNS, UFS Device, Boot and RPMB)
+are created by the host controller and need no configuration.
+
+Adding a UFS Device
+===================
+
+The following adds a host controller with MCQ enabled and one logical
+unit backed by ``ufs.img``:
+
+.. code-block:: console
+
+    -drive file=ufs.img,if=none,id=lu0,format=raw \
+    -device ufs,id=ufs0,serial=0001,mcq=on \
+    -device ufs-lu,drive=lu0,bus=ufs0,lun=0
+
+Add more ``ufs-lu`` devices with different ``lun`` values to create
+more logical units. On top of the architecture defconfig, a Linux
+guest needs ``CONFIG_SCSI_UFSHCD``, ``CONFIG_SCSI_UFSHCD_PCI`` and
+``CONFIG_BLK_DEV_SD``; each logical unit then appears as a SCSI disk.
+
+Host Controller Properties
+==========================
+
+``serial``
+  Serial number string. It is accepted but not reported to the guest
+  yet; the serial number string descriptor reads back empty.
+
+``nutrs`` (default 32, maximum 32)
+  Number of UTP transfer request slots.
+
+``nutmrs`` (default 8, maximum 8)
+  Number of UTP task management request slots advertised to the guest.
+  Task management requests are not processed yet (see Limitations).
+
+``mcq`` (default off)
+  Advertise Multi-Circular Queue (MCQ) support. When off, the guest
+  uses the single doorbell transfer request list.
+
+``mcq-maxq`` (default 2, maximum 31)
+  Number of MCQ submission and completion queue pairs.
+
+``wb-max-size``, ``wb-min-size`` (default 0x400 and 0x100)
+  Maximum and minimum WriteBooster buffer size, in allocation units.
+  ``wb-min-size`` must not exceed ``wb-max-size``.
+
+Logical Unit Properties
+=======================
+
+``drive``
+  Backing block device.
+
+``lun`` (default 0)
+  Logical unit number, 0 to 31. A host controller accepts up to 32
+  logical units.
+
+Limitations
+===========
+
+* UniPro and M-PHY are not modelled. Only the UIC commands needed for
+  link startup, DME attribute access and hibernation are handled; DME
+  reads return fixed values, and DME writes, power mode changes and
+  hibernation do not change any link state.
+* UTP task management requests are not processed, so a guest that
+  tries to abort a command or reset a logical unit gets no completion.
+* The Boot and RPMB well-known logical units only answer basic SCSI
+  commands such as INQUIRY; boot and RPMB data access are not emulated.
+* The device cannot be migrated.
-- 
2.43.0


