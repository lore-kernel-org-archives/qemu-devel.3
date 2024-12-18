Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FEFE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0Xe-0001Pq-15; Wed, 18 Dec 2024 15:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tO0Xb-0001Lz-46
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:21:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tO0XW-0000HB-KZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:21:06 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361f796586so607075e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734553261; x=1735158061;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ztc7verGeO5qoJvGNI9kl5RyrdUcGxpKgAUza+rKw+8=;
 b=trSzbex9COswAba46bfwsK/LR6ltgmeJLG/oEaAw2ltH24YmDB7AN9mAmaBh6FqUUf
 ZdkpRPnW1gJDxLHva0k83gNlH5LCNym990orvJry3N0z/m+sOfKibG8d2FgdK5OWWqhi
 gj/p9QbNaESgjpqrz8l25Jr3yx5/9cynYw/YiVB62s2RpUAqj5vREjK3te1u8/3sRZoY
 gvB/tAVTyAzalfT4hR01gEUCeXu+UsS/B/eODyrfnC0DcKcP8QF6BSsYGaxH8QCq6Du8
 N7t0Zj1ZRvVu3Y/jZ6pymvH795ePM7lyWLCSg/O9DnCBEchTQOV/SB0mNjza1esWZiZp
 NZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734553261; x=1735158061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ztc7verGeO5qoJvGNI9kl5RyrdUcGxpKgAUza+rKw+8=;
 b=wjdgR+WTxT1nwdP3sNaKpuYEkg1ctUVxebTOiTbV9zgC12gm6ZR3gEqO9oqmzjIVUZ
 cuXaryGfhivN2coxsASOGSGTYTkku3TB8g0CCCt3uhl24G88nCt5UblL9MgN/VsPBUjt
 C/7WNIvxjWs6r1N5mv82id9iLtAsP+FeY+wxwq1eW31lpQR3WnTmEERyDdmv5KsRaB6b
 QeDItDA7ZBvo3xOMbNsHYyUYCPGbMBSvJCxq21WxsuW//qxn/qOO2ZAA2O5r84GsPtBM
 laa9nqVyNSDagKclSLKkhZXrUWxX30q0ecVZDBypFkptA/moTTidGAvCn8BXTyYxju8k
 ngFA==
X-Gm-Message-State: AOJu0Yw4EgHL65861gDJX8Xb80X4GLBQXGnoKq0/iEJOR8lfbuBKkqDi
 f7jeNq6rc9xM92aF8dacde2GJaHws5oNKAllvaj9jACxWlTiosXI/sbP8wDxudk0qxtLaMz+Pid
 6Jg==
X-Gm-Gg: ASbGnctAC5ylPJR26Q/S2zgPTZao6UHc8Od+rKrYjiFcfZuj/j7k8bkdvB+rTCcSCL3
 fpHMjCuWk6+nTjCKykKsMytd51ys841rAPB6eHqZf9Xv06btWksRJ9zxX4GckXE9jV3iak5M//u
 LbG7uMHdobgg4eUpPuOyi3tJ8CIqY6m0c4pPgOKhSFpY5y6Cb/CBv52p0Z0QzzlwHqS0VdJbo9u
 928knsArwL3aUaBNtOoCcPfLXX7OifHEXoSbqUGoazeaq99iGk8DoKaocLinHA621MxbLEG0Rxi
 ScHuFQzqGrGOxa+aL9vt4SJ/CYjEbWn+
X-Google-Smtp-Source: AGHT+IHPA+KZu/FQWP/m8kSLS2ZOhC5q0KyVHJOi1eujTJy1/EklTGbl9IjIx9Wq4iw3gxm+deNfqg==
X-Received: by 2002:a05:600c:1d15:b0:434:f739:7cd9 with SMTP id
 5b1f17b1804b1-4365c781078mr6450095e9.9.1734553260805; 
 Wed, 18 Dec 2024 12:21:00 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80120c7sm14842267f8f.13.2024.12.18.12.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 12:21:00 -0800 (PST)
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
Subject: [PATCH v15 06/15] hw: Add vmapple subdir
Date: Wed, 18 Dec 2024 21:20:27 +0100
Message-Id: <20241218202036.80064-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241218202036.80064-1-phil@philjordan.eu>
References: <20241218202036.80064-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::331;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x331.google.com
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
index 5aca2833c2d..5d9d65e6df7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2771,6 +2771,13 @@ F: hw/hyperv/hv-balloon*.h
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
index 17201b5d473..1debfd8c14e 100644
--- a/meson.build
+++ b/meson.build
@@ -3587,6 +3587,7 @@ if have_system
     'hw/usb',
     'hw/vfio',
     'hw/virtio',
+    'hw/vmapple',
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
-- 
2.39.5 (Apple Git-154)


