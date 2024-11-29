Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44EAD729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH2s6-0008Th-Od; Fri, 29 Nov 2024 10:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH2s2-0008Q2-Hb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:25:26 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH2s0-00026H-8P
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:25:26 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso284529f8f.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732893922; x=1733498722;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok/yEO/gGUTeG6NUYNOLxdO1P3nDxIlqx8Wu3BE+nrY=;
 b=EActY1ns+GlmpC0zbpzGrR3Pozi/Kud0jlo7A5Q84Wy+QVFxCZ/AJCuzgefwgVBNIV
 8cQ5ntkrDCU9/RLFrnuFYSuKLTtCmXWpr+cHS5MTDBBtjAckrby3cvXrD78LgQpSI/vI
 IuklzwTy4Il9vObYi7i3nQEBdf6a0BHN5rVitOUzpeZ/ChU772dsG5w3pG4rpJPScxM5
 O1mnVo3H18QH736rsZrk6g1TE12qAAGAtgM87qntrD3wip7mWdWEZBCiNwhw8BKOOYlV
 ZIhZb9MQCwY9UZ57gXuFZIIOIurgLHppV47j06jD1s48qSi8R9z9gNwf/AM5O1tAZ8M7
 OIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732893922; x=1733498722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ok/yEO/gGUTeG6NUYNOLxdO1P3nDxIlqx8Wu3BE+nrY=;
 b=Mp8FO95uKImUAO2p9TvMLjw4VTDmG7E8cTbyfkel2RM2NfqABtWfe6yiyreqfeHrUb
 r1eqrd4aNMNhHiHF8LUMSP0rxLulUXhIuWoJTsAj8AcXDge96vfSNoOYN1jB+Q2SdUzY
 D0hJJjHu+1IGmUakkfugn1qX8lljQ6w24TDr4rXBruMHt92s9QRrpLMpzpvwKKT/Ouab
 LctKUU9ViSOh02Zf6h639+N7sf8KtvVsShKJ4Cdfgq7MWlAhXkMJFuUi30dynVpg5Ncz
 18buWxUxuquePpJ8NXFPtCCoG7vzt8HIFo8jyZpSRUHBrY8Oy2sH6MFntCV4YKzraqS6
 SIxQ==
X-Gm-Message-State: AOJu0YxHkh2S6b8HPfqMlcSd7lhcYQNSJnGyyeDoAnM/Nh+fyiLjzKt5
 lIyXX389Xrwe7gF7+dhBsHjracdOseAmwhc9bjaaEayIDB9V0NifjFqmUZGF3vpB2VCGuWJn+Zb
 4SA==
X-Gm-Gg: ASbGnctuvq6GPtzjttaJhqYKXVtZrXxZ3pHY50pQJnE8thW05u8xbYd5V/izbKuYIqc
 IK6OngUpSzFcCh/JOF2HX7xh7A88UBoshif1CZK7kXEJBnLpfNK23THP1v86QvEdfpL4qHarsM/
 nk7ED7KPnuDOYqnZFE2hca/Kd/feFcX4sR6sYP+G02554wFKp2dhlgFvEe9pBWVcYJZPzRTnGNI
 dXukYfm/6Kwg2p6YHmB1wHTBzGOpgdm0mHmqZQUOSHcg0GEQ2Io7AqplgvjaBIjMXQmprVtbpLb
 aPTeBBXS+Hy7pIZo80u7kYxgMw==
X-Google-Smtp-Source: AGHT+IE3RfefrJDeDVvtQeB8uAVxFp8vTdz6S9TpOwVeuZ74KZCwfit8IG9XdYLjsNdiX1E36r1tRw==
X-Received: by 2002:a05:6000:184d:b0:382:462f:c5e5 with SMTP id
 ffacd0b85a97d-385c6ed74bemr10786413f8f.45.1732893922165; 
 Fri, 29 Nov 2024 07:25:22 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd2db2dsm4685119f8f.14.2024.11.29.07.25.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 07:25:21 -0800 (PST)
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
Subject: [PATCH v12 06/15] hw: Add vmapple subdir
Date: Fri, 29 Nov 2024 16:24:57 +0100
Message-Id: <20241129152506.59390-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241129152506.59390-1-phil@philjordan.eu>
References: <20241129152506.59390-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::433;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x433.google.com
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
index 08780eca5d1..9e7fc6c050a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2763,6 +2763,13 @@ F: hw/hyperv/hv-balloon*.h
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
index 48215a06cd5..4a4a033ab40 100644
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


