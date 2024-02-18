Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2946C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZEg-0001RV-4K; Sat, 17 Feb 2024 23:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEf-0001RF-Eb
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:05 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEe-00048C-3A
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:05 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-59f80e1e259so1923729eaf.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232222; x=1708837022;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKib9lFhkqfQp/XBira3ThQ631U3FRHMXLPB53AQUH4=;
 b=txQcel8inuVnfcDcdkjzSmqHT1X2w2ws9BnIXQtHIh2cl6cdHXXGSpV+dA5xo5E2Df
 vYAU7/xRsvUCFfU5PrWP4WMLO3s82a3wmvO4vayHeKmMQix874HuYjUJYraAgLs+PjFU
 +Ip1JcsOAweHJ+KJgCymkHZHyI+Or0DvKQreth3/OWU1XJaJ765SXSFtW5osPS+EXOHv
 cr7s0uuWuGmXPt72s+90naTORSy1Fqi+EGxjyTmrYrnhM8ELrOQoQX6aGW1vNjuOfR+S
 gRa84js9Ox9+egRv7FQcYhnk2nrxIe2rBpWw6wRgQY+upDefPFitU0FjOwhg5gAJP0GW
 V/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232222; x=1708837022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKib9lFhkqfQp/XBira3ThQ631U3FRHMXLPB53AQUH4=;
 b=DBfRoppXuUGokhl96vmc3HgGCLEqPCn78cP/tjv3x37fXdsAiDRehfUCdE+GF+Dx3c
 H1GLdqFT6f3cCr9+woYV3DjgT4GegPSRJPqMnU1XG4R4MGHQjggGaSn00N1SbmQ8Erf9
 V3vqWboZq+fIjDKabNixR9scM75yrXAj3tlAqclDkSc0Fk5B0L4KRofoI2aBwLQ8yQVG
 gy5eIYDjM3jcuO4FU8dbZ5jMv6fJUygjZtyOhS+NDmIUZn+C7Z011LNrEBFnbjVnuahW
 M2AK8SZuc12SyCDzqp/Ezvts8D1C/D0jrNl9y+hh1zqbqT7uEYZy7cAotfJK2i+nVoRp
 sDlg==
X-Gm-Message-State: AOJu0Yzv8iAOeVfna2yzdGGxI8iBT1+Wy2DxDYkhlaMbqOXFrWNDKtvY
 27w3y/t2htiQ/UcZC9KCAy7JWxfP1c9Hy/wDY9AYem2CHGdevsTHs7xUpumzK7A=
X-Google-Smtp-Source: AGHT+IH3hS81efNMSBzGDSJTewpcA5P2VXLEL3H7qUlbG4dFnsPTF3SVpuPP5McdG8eOWw3vt4gZYw==
X-Received: by 2002:a05:6358:6f90:b0:17a:ebb9:d26a with SMTP id
 s16-20020a0563586f9000b0017aebb9d26amr9422483rwn.31.1708232222645; 
 Sat, 17 Feb 2024 20:57:02 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 sg15-20020a17090b520f00b002993e862145sm2699470pjb.15.2024.02.17.20.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:57:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:10 +0900
Subject: [PATCH v5 05/11] vfio: Avoid inspecting option QDict for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-5-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
2.43.1


