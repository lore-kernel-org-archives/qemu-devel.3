Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D6D75E29
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 11:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tERhl-0007hN-QA; Fri, 22 Nov 2024 06:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERhg-0007eJ-Vm
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:20:02 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERhZ-00069p-DF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:20:00 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so17756965e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732274390; x=1732879190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hRSTyr9LseUA345HjOb58N9q4glOwPpxbZ3ixu2HJM=;
 b=oikOljE90Xisob9a6/Lh3s85Tkc1LtG+zrjU5dpp1zy0iBxvUvE5X2U3MYRmFoH21A
 aetkbbCssPXAXvcLuStR+LkC9SPS4bsQ31/1AMcZ6bEeSOTevI+AEdNjMhOUMgEUQlXu
 Y39rMy78xAYo7Mah4Xph8fgEylyWMTXlN/GelNJqBYaHk6YK4A+ySk12fSI4hqoAkwK5
 WgEI7XBH3xZAlMGwOWuBKe6L+ioy2wUMnOHeWW3+BsMNI95twX57zN09LfcZXVMjddfB
 PUhzu0LDQUX/gw3p8vu9SWuL5Cfrc6/IsddAHZsCnlGB9W3gPMsruJgP/Ks2HeyTsQ6V
 4F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732274390; x=1732879190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hRSTyr9LseUA345HjOb58N9q4glOwPpxbZ3ixu2HJM=;
 b=TXP8EtLcgLC844F8GVnVGW65Tas33juOd6BIXDpDP0CFQ80x53jwexWiHcx0fRUWLd
 KLYCATe+AZwlDen0dnxvq3o2kjCKeMbdWCJ2vwcHN/ViOemHtAszhe2wS5Sny1DDuaPu
 caOxxxOZian3KdOEbDzY+PINyEe4/wXR1tESc3/k/pc6a1ejCg2hjt3VAYzC0Wdf6bdA
 jEgbrRx31ssQeE0VmbwhaiQefhFrvc48A6uQ0lXcP99RtPqeVGPuu5hcB6FaKH5So0Qm
 Gi0BRr5w9hCI9cUuOs/FHYDpa1OzY5fe2GA5n+K/Owu52kgKDi735z/q4rvvULotFG6d
 kV+w==
X-Gm-Message-State: AOJu0YyCh35kDRKQ/w8wXYZwqTwYUrbzhwRec2bavzguyurZ2xuHo07b
 tV7BxoMOPJAJWSvK1yh2cGB0iRpzkiMe7liDJhtb2FmdZN2VgVKyFZkXWAeui/YRlp0550FJOum
 f
X-Gm-Gg: ASbGncv2tA8A9CdZnk06d+AHgBkcuVN+n2KzzKhZcfR7hQSx4zWYIa+3+r6QHq09PNp
 MD2787NRSOC+t08mbhTSkOrDlQTIuffkwq2pmnoSpWegKiM0afE1MKlM5izw2yeZnBYdQf3JoND
 iXDNU/79tZQJSGjI9ZjSzkxGG4i+SD1ak9uiFibJvre/MbmwaipYuC+V0qmWSb6wdW6r7MRzqyF
 ye9s3Qqe2jzqNrfddoaqFaHx19NhvxKJ4DjRBgBif15h0NLYrWkyHa0wWW8T0NSNWC9R1IjUpOp
X-Google-Smtp-Source: AGHT+IGlE04LYbgRfQK9sKvaRbhv+saNgdI9rlh2DZYBJXOWfjTBw3UWvTHYcARESYcaWuRcKIAPxQ==
X-Received: by 2002:a05:600c:4f90:b0:431:4fa0:2e0b with SMTP id
 5b1f17b1804b1-433ce4af2eemr16585165e9.28.1732274389724; 
 Fri, 22 Nov 2024 03:19:49 -0800 (PST)
Received: from localhost.localdomain ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43366cbcd17sm65040505e9.1.2024.11.22.03.19.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Nov 2024 03:19:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Helge Deller <deller@gmx.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/3] hw/scsi/spapr_vscsi: Call
 scsi_bus_legacy_handle_cmdline() in REALIZE
Date: Fri, 22 Nov 2024 12:19:37 +0100
Message-ID: <20241122111939.11936-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122111939.11936-1-philmd@linaro.org>
References: <20241122111939.11936-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Call scsi_bus_legacy_handle_cmdline() in the DeviceRealize
handler, just after scsi_bus_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/spapr_vscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index c75a6c8807..8e76bfd7ce 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1218,6 +1218,7 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
     dev->crq.SendFunc = vscsi_do_crq;
 
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev), &vscsi_scsi_info);
+    scsi_bus_legacy_handle_cmdline(&s->bus);
 
     /* ibmvscsi SCSI bus does not allow hotplug. */
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
@@ -1227,10 +1228,9 @@ void spapr_vscsi_create(SpaprVioBus *bus)
 {
     DeviceState *dev;
 
-    dev = qdev_new("spapr-vscsi");
+    dev = qdev_new(TYPE_VIO_SPAPR_VSCSI_DEVICE);
 
     qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
-    scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus);
 }
 
 static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
-- 
2.45.2


