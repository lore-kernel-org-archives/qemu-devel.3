Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A15C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoIG-0008B5-Hg; Sat, 24 Feb 2024 04:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoID-0008AA-UX
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:26:01 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoIA-00031w-3Z
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:26:00 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so1150181a12.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766756; x=1709371556;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iAcglpVI+76LKe4b0/x9E5DRDo/hKsQ/KwUu1WthVPU=;
 b=tHnn3/b07JnmeMnHT0VHtWLNIMzAELqdTWsQ/qtMbCRO7JXHjD2Hn4D8v5m/kg5L8l
 /icWT8betcrZAHM1XnmCU7Ewp/hLMQVtbLKwHEXuMliC4/lCaeVcDNYd2gH1LjyFQajE
 I7klNeQnyX9K9E9t0Nn/xM8FIw/46PHTsKYt6h9UNmR7ZuRLtcLlThClsnULg+9zz2FA
 jtqiyJ4ZYgHY9yQ1E83i9IvovcnGz1AAZ+ctadVL5SxW15ReMy6I70xKUAqOcOj/C0C/
 wN5X9mYdF88tSjvcyoHR6cMVOCRuirzzlq7ZADNCiOjKXx1h86uxnv8dMVMFNs6gJELm
 8WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766756; x=1709371556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAcglpVI+76LKe4b0/x9E5DRDo/hKsQ/KwUu1WthVPU=;
 b=GScibYc0TTD85XlWgyoakyluSdZOufzwvlIaZo4rSzF9ip6nnP0Yg4jZyRL2CFIbzF
 2wRReYpyedik+Xn/CWzPdWD5PHaZ1gQuSBE5kC68l0XJzSFU7F8h6zttKNuEo5HIX84Q
 dZzemaODUP1UdCNOb0ZK5OoUoi00srSyqKtQaTk3AKvmv0WM19uPfm6MV7OGxDQcHLFY
 Y+uhAu1kaJhNhpro09MKn2ZhK2GJ2ikuOgbu0uIDxV9D5Ll+m0mtnvhh6/cdz66R3M8J
 ioI2hazEFD1/xkWS8+2J8jiJCRv7k3FwD+0QON3NEPhQt7N0speKLbcOo+wuTMdXeEoR
 yiyg==
X-Gm-Message-State: AOJu0YyteRx1CEzhJEiSf7wsQePOQV4fp7e3949DOg2dcQAFg9nQKOW2
 iTcgzj5giYIiic1vfPBCLZGwCjchTYD0e1r49U4GWA9THQ1v/qW/35xcSlnweGI=
X-Google-Smtp-Source: AGHT+IExvbj0X8ZZyTTyQX6O5J5Tsv47SKGjhBwx/LkMTMX78DOGznP1q4lIcwgge8IjsHzbmhOaqg==
X-Received: by 2002:a17:902:e804:b0:1dc:6ce1:5bf7 with SMTP id
 u4-20020a170902e80400b001dc6ce15bf7mr2420801plg.1.1708766756157; 
 Sat, 24 Feb 2024 01:25:56 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 i6-20020a170902eb4600b001dc0e5ad5desm669020pli.114.2024.02.24.01.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:47 +0900
Subject: [PATCH v7 15/16] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-15-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use pci_rom_bar_explicitly_enabled() to determine if rombar is explicitly
enabled.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f0430d..647f15b2a060 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1046,7 +1045,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.2


