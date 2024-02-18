Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0ECC48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZF1-0001iu-Bm; Sat, 17 Feb 2024 23:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZF0-0001cv-7X
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:26 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEy-0004BC-Qc
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:25 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbb4806f67so2346400b6e.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232243; x=1708837043;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oEGv7dA87enISvNwWKVp+KmYZzRr7ttxpncFC9B4Uog=;
 b=urtf71ryZpdY4W6qhavqAuR0mb2G65IV87ZdtqdU50ZBCwuC6a3h/r1tElXaIXn+ig
 bWJp55ZZK/2rfTlWUsbYssO3fVJhrsTIF+OuoEeOx72F0w95d44jTTuv2pbpf6i7A2vk
 c6noIa+UtRtKAeEnhi8V6r23YFUHHAffjykow33IRU5jvDc0lf/lS2tn8u0mcHA/URZ1
 0LPYssQBpVxHHJRthWHjpVyrF8jtzxIa7rltyHJX+i1rbf8whlx1u0h6eJPqfMmi5Uul
 lfRCI38dEdyZsUOuXfNvir3Nt7CyMUzGafstzkST9SDvsCiVtlUYE5kOQ78tzXn8OEGs
 lsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232243; x=1708837043;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEGv7dA87enISvNwWKVp+KmYZzRr7ttxpncFC9B4Uog=;
 b=hf116I5Uus3zXll7p/65lzrugb3p1MSsi5+JXeqL1KmSOTzFERBW6S/ZUvucRe5V+D
 E/Xqp0knYkpaY4zp4n/EXVhN+GLCIdO+IJQJUW8918zy6cDgyIz3qxPMf7MgdP7dlg0R
 1DPWfTZ12km16+vq/yME3BXMF/Y+riEuJGLiVSSWQOFsbubEkCRbvWoInanntkRDne+B
 PyPAfYMBZ3LQCJH6HuIKxBGDHjJy8VA8l3XUZOyne4FawEvFk7FEMS6/tBamJJ0JNcvy
 QrVmTm2jYYpxNrLck5Q7qw0Rxxiye5lS2WgDYgNLIE4Q4yhB2AWf7P1w6SCZaZApvVo9
 HsHw==
X-Gm-Message-State: AOJu0YxJD/gqrUAoZCWrIzZGBMXs3c1eG8/b6lt+HEq38FkYKTJTBebd
 BBlShrz+Lpt6p06D/LAAxPiUJ6NJ7rgovXgAcu9LGkkuVLo9QnZ80GP+QI/we8I=
X-Google-Smtp-Source: AGHT+IFQIeAhqZEkL7McA06QAQGBJNuf+42mOMT5SbvhOHBo6TyBdr4TqUfgc3c8g4f1ROuuUeF1Ww==
X-Received: by 2002:a05:6808:2129:b0:3c1:547d:cfc8 with SMTP id
 r41-20020a056808212900b003c1547dcfc8mr1202231oiw.45.1708232242804; 
 Sat, 17 Feb 2024 20:57:22 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 ga15-20020a17090b038f00b002989901759bsm2600374pjb.42.2024.02.17.20.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:57:22 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:13 +0900
Subject: [PATCH v5 08/11] pcie_sriov: Do not reset NumVFs after disabling VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-8-e4fc1c19b5a9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x230.google.com
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

The spec does not NumVFs is reset after disabling VFs except when
resetting the PF. Clearing it is guest visible and out of spec, even
though Linux doesn't rely on this value being preserved, so we never
noticed.

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 51b66d1bb342..e9b23221d713 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -215,7 +215,6 @@ static void unregister_vfs(PCIDevice *dev)
     g_free(dev->exp.sriov_pf.vf);
     dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
-    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -260,6 +259,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
     unregister_vfs(dev);
 
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+
     /*
      * Default is to use 4K pages, software can modify it
      * to any of the supported bits

-- 
2.43.1


