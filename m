Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E01E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 22:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPqkE-0002Ol-Q2; Mon, 23 Dec 2024 17:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqjp-000230-My
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqjm-0006xw-CX
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso45869935e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 14:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734992228; x=1735597028;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qw9Ap9MzAofQSmvBtZk/PM+/8Z9AYBMY7VkjFbhHfB4=;
 b=klt39jszSm61snLkuI0i5Uflsa5j49cPejytQM4s6qwdL1nUy9BmhXtO2OiKbM372h
 ZYxWKl/WxyqsNJI8J9XNGW0A6P0AM8yUGCgGf9w/8kbEbaTc1wmZ3hd/CYYoAB+7KAvf
 s1vvc4GNQUpPrMLQNB2Hce1TA5TWSFUZRTbPJJ6ZHJKgD9TiK8aCIqeW79nsM94sZv3x
 YKRHABnZNmYxeEKC45F16C77vh2d7y4XjimMaRJWX0g5T9/qfVoFbHtIBpDXb+59TOYR
 jeaqj3r4jsVmfRQwmJHO1M/vVmh7V07RwSJ0Ec944lmr3oFAtcUR/AiPOcfoRgwpAQ6K
 pdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734992228; x=1735597028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qw9Ap9MzAofQSmvBtZk/PM+/8Z9AYBMY7VkjFbhHfB4=;
 b=AmRSLSxPPuAThz8fqWkPnfoJ1fxaL7R0JZqx8aoZqTUuPirzGrfF3jXZ/8k0TSJtx3
 XMFHsJy/yjzwkYjdsrqR/SWQnQ9qD5AKsDy9oikHmsGzn8HRO+Ph+zdtrjcRG0waEniX
 2DEoBTsfKXwL+MPz6GZQwn7lEhLmPd/bmeGWfOTFcTgo+SBfzfoL5zBB1namVv4Pf9YN
 56zew2QTMDD7OnQ9v3+iyvL0H21ujRnGi685k3KtnGvOVaHuGFUzMs9XuRWowuaxolHV
 k4Ii9lqfjKw7VlbfEkeF3WkmzKoE0lvjeS6+z+4G28IGapmmypl/3QkqNRL37uhrIY1K
 DjRQ==
X-Gm-Message-State: AOJu0Yx3EU6rXFOodR2f9eQBkSatZiPuy3U0uJeHN/9Y8flW4dlZCSjs
 SMzT+aTTKV9U2n38OdXQ6vFxHiaMHjpSPtmrCdjRnXgWvwUiAeMe3hOrU2hci/p8OyYapUDQvlk
 9fw==
X-Gm-Gg: ASbGncs5SmS/t3WV3Jnq9nUaHIOag8rtYUV9x22cRe65JRLwJYk5S+n9KhlRy4hB+tN
 3qe+cQcyeN24Zxwg4K3zTP1v+8ZNIHm4rh0AVbHBktaCkN+RBdUeTbkF0LhAptiF+r9w7+HxDKd
 AU67Kp59GJGZGUJkKuthPo734uC1TPQio1Qd3B5JYgyG3vmwGZZSSarRf7xrQz6X56i04kg/tYQ
 dlUX5RWinlRitBXq64FBcZPG8QOuUf0skjOqHn0O8AUT62ykWBOAhiRWZRkJwyzme0YvCPiZ2BB
 88lHFkLkw3MOUfxC9hg/9sN35fpoeRvk
X-Google-Smtp-Source: AGHT+IGhL6L/m6Bulwe+bA/0BACNUfVEWFl95xfZUgL6cKFfpFibZEWCDOTSpjO34YpTzdLfib4gQA==
X-Received: by 2002:a05:600c:3b0c:b0:434:f5d1:f10f with SMTP id
 5b1f17b1804b1-43668645f1cmr130793155e9.17.1734992228218; 
 Mon, 23 Dec 2024 14:17:08 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc161sm147561075e9.10.2024.12.23.14.17.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Dec 2024 14:17:07 -0800 (PST)
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
Subject: [PATCH v16 06/14] hw: Add vmapple subdir
Date: Mon, 23 Dec 2024 23:16:37 +0100
Message-Id: <20241223221645.29911-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241223221645.29911-1-phil@philjordan.eu>
References: <20241223221645.29911-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::329;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x329.google.com
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
index 2101b51217..e220744abf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2785,6 +2785,13 @@ F: hw/hyperv/hv-balloon*.h
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
index 1b4e9bb07f..2871784cfd 100644
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
index b827c82c5d..9c4f6d0d63 100644
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
index 0000000000..8b13789179
--- /dev/null
+++ b/hw/vmapple/Kconfig
@@ -0,0 +1 @@
+
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
new file mode 100644
index 0000000000..9ccc579048
--- /dev/null
+++ b/hw/vmapple/trace-events
@@ -0,0 +1,2 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
diff --git a/hw/vmapple/trace.h b/hw/vmapple/trace.h
new file mode 100644
index 0000000000..572adbefe0
--- /dev/null
+++ b/hw/vmapple/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vmapple.h"
diff --git a/meson.build b/meson.build
index e62251c7ca..1b77955d46 100644
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


