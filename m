Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4CACF6495
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 08:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTHw-0001Ma-SY; Sat, 28 Sep 2024 04:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHu-0001E0-S5
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:50 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTHt-0002M2-9q
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:58:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37a413085cbso2730049f8f.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513928; x=1728118728;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tyonrm+foLYYFZ1a1u7JHM0QimT+pKoC8Tlz0H3o1Zo=;
 b=B5EFXpDXAYt9YJMZmxhpiyXSuCE5xe4ecqCd8HIo+wdXquJKBnSDqrDqsni11R9uze
 X+U9EeeBtQndi2wkh+6uz3QGR45xxtOIM4VGsqdp95EvB1CbsjL6EuU/PDG4YjbkmG/x
 Co/QUaOcyg/gt4GCXZ2xgQRqu8WEBpq3bkLZN4WB/8T/2GVM1kcZ5SucDXu7SjyJ4W9R
 KOVdMaFp/7m6JJ+4cECfX2WN7Y1GAybtvaYTa9QDdY+QLvuGWoiRyeo2DjDreRgpBk1v
 RfJmeNfDqpnfm/VXyVUnXvg1OIlBS16CDs6QIPKfVGONbPdYG4fUoNK0dVM+4aSrQf4Z
 RAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513928; x=1728118728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tyonrm+foLYYFZ1a1u7JHM0QimT+pKoC8Tlz0H3o1Zo=;
 b=n9ZRgLkV0AyieEmX+OVrW+YVnrVWbnk33GtZWi9w/zn8WEYyVMTg7Mj5uMbuc1nFhz
 6paBPlYqu5h/1yLr8hw+ZVj3vSttV9UnY1ufFo9T3S3fX1B0QHaw2T01klfLfhZ8F0jf
 TQebid9GbnMp0cpIU6LH56bXNIAKbT/y8EWtNWoWNEPhX533h6lUPlW3T8uyCPHJb7nF
 1o4NEpXjFefKvuTmDV8bRnxEYmsGJbGRdp6KV5P/MAMcOlo0SIaomHrpVi2f+2+iYUnK
 EJiMkxkxdbPu8MUs3+PuMNd7s9KERxFMTD1PneFPj8AtTbovRdlU0gcX9OuV6cT2Dnzo
 ynAA==
X-Gm-Message-State: AOJu0YwajcdX17GUiR+iyPCW35EhQKiT0xDL1afvVVBKX/RQGqZv6G0c
 sL82NkwpwgGSmcnMW0sY7QUo7OWcFM/3BWLmErNxv6gGvUXsOiFXz50vccamRAMSiii9rNi0BRB
 Nkg==
X-Google-Smtp-Source: AGHT+IE8r/PcKn+itB1BeOo2k6xBWCIZlVuvxPcuoNcXS5px38c25qusCsIsyLM7eSeOCAxhVrXoPw==
X-Received: by 2002:a5d:4808:0:b0:374:d130:a43b with SMTP id
 ffacd0b85a97d-37cd5674dfemr3709937f8f.4.1727513927921; 
 Sat, 28 Sep 2024 01:58:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.58.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:58:47 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v3 06/14] hw: Add vmapple subdir
Date: Sat, 28 Sep 2024 10:57:19 +0200
Message-Id: <20240928085727.56883-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::42f;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

We will introduce a number of devices that are specific to the vmapple
target machine. To keep them all tidily together, let's put them into
a single target directory.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 MAINTAINERS             | 7 +++++++
 hw/Kconfig              | 1 +
 hw/meson.build          | 1 +
 hw/vmapple/Kconfig      | 1 +
 hw/vmapple/meson.build  | 0
 hw/vmapple/trace-events | 2 ++
 hw/vmapple/trace.h      | 1 +
 meson.build             | 1 +
 8 files changed, 14 insertions(+)
 create mode 100644 hw/vmapple/Kconfig
 create mode 100644 hw/vmapple/meson.build
 create mode 100644 hw/vmapple/trace-events
 create mode 100644 hw/vmapple/trace.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0133b874847..4e7f25e5299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2777,6 +2777,13 @@ F: hw/hyperv/hv-balloon*.h
 F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
+VMapple
+M: Alexander Graf <agraf@csgraf.de>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
+S: Maintained
+F: hw/vmapple/*
+F: include/hw/vmapple/*
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/hw/Kconfig b/hw/Kconfig
index 6fdaff1b1be..4f0ad88a310 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -42,6 +42,7 @@ source ufs/Kconfig
 source usb/Kconfig
 source virtio/Kconfig
 source vfio/Kconfig
+source vmapple/Kconfig
 source xen/Kconfig
 source watchdog/Kconfig
 
diff --git a/hw/meson.build b/hw/meson.build
index e86badc5417..0b7151f948c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -40,6 +40,7 @@ subdir('ufs')
 subdir('usb')
 subdir('vfio')
 subdir('virtio')
+subdir('vmapple')
 subdir('watchdog')
 subdir('xen')
 subdir('xenpv')
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
new file mode 100644
index 00000000000..8b137891791
--- /dev/null
+++ b/hw/vmapple/Kconfig
@@ -0,0 +1 @@
+
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
new file mode 100644
index 00000000000..9ccc5790487
--- /dev/null
+++ b/hw/vmapple/trace-events
@@ -0,0 +1,2 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
diff --git a/hw/vmapple/trace.h b/hw/vmapple/trace.h
new file mode 100644
index 00000000000..572adbefe04
--- /dev/null
+++ b/hw/vmapple/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vmapple.h"
diff --git a/meson.build b/meson.build
index f09df3f09d5..092db201b95 100644
--- a/meson.build
+++ b/meson.build
@@ -3456,6 +3456,7 @@ if have_system
     'hw/usb',
     'hw/vfio',
     'hw/virtio',
+    'hw/vmapple',
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
-- 
2.39.3 (Apple Git-145)


