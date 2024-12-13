Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E741E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7Sw-0006ux-Ha; Fri, 13 Dec 2024 10:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7S3-0004hA-LZ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:37 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7Rp-0005LK-9M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:33 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so316721666b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734103159; x=1734707959;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFtkA3me7ERWvnCWoAANDaTDxRV9mdWjmMCXfFKS9JM=;
 b=zzzF9LdY1qpj+Kai8ldWANmutIoDQEsRhXmAXWQIcSJu0Cebs2qKJl26rmroQQj6r3
 y1qWgCgcX4vWx6dSZK4yYTuPVUasQmliMXjdbh9Z//bbl/i7Myktn6TlZlZ3IwRFjXAt
 GGrg3YgL70hc9h1MNW9zFAa5l8TcwLOyh8x/YBAiu/RsUECHBfjGSmdCcmHiW9mEnUWL
 z24n7oawiWMOxU5ijFzdGuSIoDmEJnmPlMAzMJSrwHtBbo4M20AyMgDQ7scRYqLHigK+
 5XTrqIYiRddaBJ1qQyMBhiAXAY+MJs8U/CUFjW9Bswxc6lAuu4GUKgxSnl8LfZX4p8jl
 Mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734103159; x=1734707959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFtkA3me7ERWvnCWoAANDaTDxRV9mdWjmMCXfFKS9JM=;
 b=JXDC8PxZzM/QOurVeEWr63bIZRZ/LZo/tDK7TgTPL7/7O5xgmKdW220IYVL2QUD1fT
 Nz6270pONMoP3qfE0sLneUDIyXXEu18wY4N246iwE+CSLTw0f+BnUznhysjE+2sldi9h
 wlVpCSoJNTn3MszLwhXLlSADBtHZWNV9MLgctd/6HfFPhVyDBgxwVFG/fmv0ZNJmyh+O
 hu6GWobolMrjEnI/4BiOThI6H/ZAzvcLdxkwQDF3EaNCoavCfpT5fsFO6je6koQ/h2X/
 dgpO1jSaOJXde/c94Xa+mTgRzDOVGcSiYflaitaiwPxPq+ntXNHzkDCenNsHAVZ6uWww
 7PgA==
X-Gm-Message-State: AOJu0YwzAaHYq6BrAmaxkOo95rbPyP1tPKBzcU/+5jzniv9bd9Xp4Ie0
 BO7c8cfLm//HcgnRe4/GyClBtKKG6ROs035mg7J1BSKNRu/yKkuqUE96QddG6bGb6MDl2OrNaY4
 Yiw==
X-Gm-Gg: ASbGnctehjDs91cb+/heeQEOmnKkqcLNLvOpQjn/TPO+Eb5f9KsipbtRu1CJMVytbOX
 ZU5jE9DDzH5pzZPsq2Ex8t7mpDCPAC1/55kFreslQyurNenxAEDP1JoMOWvDgQ1xLNa/VVgGBWn
 GjuiPBlY/6ccrYYCSZbJFAhs7bpavFOnR6jk5o/E0YKeP3oGGglaZ5gXaaXRlBTGP/bWTpXfNsk
 CMnjmEBV4dU5y/fY7Sapgd2UAGDm5ZShdCK0cCJvC+gytY0FL8OFxIpnFALJLprueP7uc6o28mS
 wdQ4nSVBQfg5WbXq5ctFIUs7X999JNIm
X-Google-Smtp-Source: AGHT+IGtRg694BlE+yNPc2DjwTAkEe6jAM1kFCI1lhiv6ItRLspemGqFAAJlSpO57nogcEtAL2cNGQ==
X-Received: by 2002:a17:907:7707:b0:aa6:7ec4:8bb6 with SMTP id
 a640c23a62f3a-aab778c023cmr242897066b.11.1734103158923; 
 Fri, 13 Dec 2024 07:19:18 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab8dd35b19sm29284166b.33.2024.12.13.07.19.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 07:19:18 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Subject: [PATCH v14 06/15] hw: Add vmapple subdir
Date: Fri, 13 Dec 2024 16:18:12 +0100
Message-Id: <20241213151821.65748-23-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213151821.65748-1-phil@philjordan.eu>
References: <20241213151821.65748-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::635;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x635.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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
index 09899f7407e..692872d7d1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2765,6 +2765,13 @@ F: hw/hyperv/hv-balloon*.h
 F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
+VMapple
+M: Alexander Graf <agraf@csgraf.de>
+M: Phil Dennis-Jordan <phil@philjordan.eu>
+S: Maintained
+F: hw/vmapple/*
+F: include/hw/vmapple/*
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/hw/Kconfig b/hw/Kconfig
index 1b4e9bb07f7..2871784cfdc 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -41,6 +41,7 @@ source ufs/Kconfig
 source usb/Kconfig
 source virtio/Kconfig
 source vfio/Kconfig
+source vmapple/Kconfig
 source xen/Kconfig
 source watchdog/Kconfig
 
diff --git a/hw/meson.build b/hw/meson.build
index b827c82c5d7..9c4f6d0d636 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('ufs')
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
index 1303664e167..bce1d21eec1 100644
--- a/meson.build
+++ b/meson.build
@@ -3592,6 +3592,7 @@ if have_system
     'hw/usb',
     'hw/vfio',
     'hw/virtio',
+    'hw/vmapple',
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
-- 
2.39.5 (Apple Git-154)


