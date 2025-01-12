Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B54EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX55V-0004Tp-5R; Sun, 12 Jan 2025 16:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55U-0004Si-0s
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:36 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55Q-0006N8-6e
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:35 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so9287836a12.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736715691; x=1737320491;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PED+OkjeNa2COzbeigOKtDA5aSMGopzRCwYcuxwx6AQ=;
 b=ll9ZzqnxSrcntQUptpkvVO5lyp9kllRUC4t1oGwi5RkoYvxopTWpZVfuHxl/85DiNj
 5y9z9WFnOO9q1tZUfpDShTCPS2HkCgmym/eABFYyShY7e9ZVO3dnAMrKCtJWBYKNF8pI
 tAl9Q0t1jTxnSQFvAp+oGGK/lg6YfGFat5cWCMQqAGaAOYtTEHdd25QixSZyQnAZACW/
 YDSKOODnsI8Po1DE29+8YO1vqSe96L8s92M3Fctie/dBIzM4zOH25QfoKs5bdqBdKwdA
 9f2vVkfpoXU20PfywfzA2jPTVrxaEkHaa+Pa3MvyUbCNii9lsDTtcOj4Jl92S9GVN1rx
 XSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736715691; x=1737320491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PED+OkjeNa2COzbeigOKtDA5aSMGopzRCwYcuxwx6AQ=;
 b=ZFmWAvKagJLpthWasb9eeE93M8QsbN9PVW9KZwWiSDEDVzhUzdVq1TrTeYKWFSahhj
 u/mCKGdmWCnSFvlcV5MCxMhRGI0gmjYJCYYk/xOxXmHoUqUQ7XepH/MpkST247JOyXHa
 NPgRRlq8Amw0AUyJZ2I9ftMw70+ggm5dV5T0hZ3MNcwAeDI1slyFkq+ZTd3dq4IQWSqV
 GuCcL2Nyo+rro8BVDAxffFqSSlya/UmtWoMlz1TQkTzglSZNwAFNiHwXVCY2Ubifp++i
 WUKnRQLVXIrzlhy2W6kLSvpmvqxmiraJHHdGkRBgRLHltITcKPdRjlVVK19u0m8xjKrx
 6emg==
X-Gm-Message-State: AOJu0YxufzbOeOKNTPEWWhd5pHUcdJa54L1M8VN6hV6yjnldnj5PEFWH
 i4YS/klIfgT8sznZRolNSvW+uKMWCfkBCIBs3ak2pxNJyl1LPHEpbsugTYIUfsTtwe3x0ycwXOB
 WsA==
X-Gm-Gg: ASbGncv5KxbmIXmRURG1WmXx025VLbjb2zP/E1b8XxnnlM2kLbTeB22dB1zw7vFkejJ
 nt+dRX1ONVqzCabRdKFovGRjLlgzqI55kdr9s4m6Ueo0tVZp5Xh6GVlD69YrRzRwZKatxnOu0nv
 XqrOAi1ZEBFt5W1nU4UCmqFRo4lLmgj+xTM3/14xdhdH8sVwOFUWMtS/tTqYLAu7ksPVnJwpUKN
 ioZdhEzVYmacx9zgAF2y3NT19M4JIy2I8Qfh7qi3uwRG/Z7XWJq8M4D+fKcUGI61QWKgXcR1hZ7
 mSCIKdAlMtXXQktVkCHlWXDo1Md51akJ
X-Google-Smtp-Source: AGHT+IEM+1jEFM8kBX0RaIGRdMlpbkaKWVH8jbeWBf/DzNOrsFkHmFvkwaavdQHaVbPem/VE2M/q8A==
X-Received: by 2002:a17:907:6d1e:b0:aa5:53d4:8876 with SMTP id
 a640c23a62f3a-ab2c3d4d2afmr1289102666b.20.1736715690182; 
 Sun, 12 Jan 2025 13:01:30 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm418276666b.31.2025.01.12.13.01.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:01:29 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Alexander Graf <graf@amazon.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v17 03/11] hw: Add vmapple subdir
Date: Sun, 12 Jan 2025 22:00:48 +0100
Message-Id: <20250112210056.16658-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112210056.16658-1-phil@philjordan.eu>
References: <20250112210056.16658-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::533;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x533.google.com
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
index d06f59095c..812ef33550 100644
--- a/meson.build
+++ b/meson.build
@@ -3588,6 +3588,7 @@ if have_system
     'hw/usb',
     'hw/vfio',
     'hw/virtio',
+    'hw/vmapple',
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
-- 
2.39.5 (Apple Git-154)


