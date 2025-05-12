Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3249CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOlf-0003mM-Tm; Mon, 12 May 2025 04:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOk7-0002Aw-51
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOk5-0001rl-2I
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so41149075e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039351; x=1747644151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7mzFRrb3yOGmhUTPeHBYB68PxuCxaodYF8btQSDpv0=;
 b=aSLd9Ta0ZrCwFGgE6iHi5/p9Qy8gZ7s1DonFdppbzlED6FWhB2ZJywME9wZgE9YpTO
 /Y904PR75Yi62WiJYg4x9XRCtUF6Z7S0/uYXKdqUpkrO+9A71UQUQGhKpVDYriQZu6ho
 tZWjgcSx47oWsscV5e7MpgrQQxTSwysAlMAFo+lmwdhSqgR/JBqfBoGxqDa1JqfOp6Yk
 zm2Mt1foVtAVshnMOmjkrXQ0Vt3cWCDpeEydwxpaHHf7cLyugOWK1knmpzGAnLBuZDg2
 6GKpzybuAcaHzg8pGkd/xVIoA0MJNxwxBfz2JQrURHNealQR6zAZ0icFNIXi2D9A14WV
 4MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039351; x=1747644151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7mzFRrb3yOGmhUTPeHBYB68PxuCxaodYF8btQSDpv0=;
 b=Ea0UoKm1tPjbojLQ3B53oeBdLFO2wERs2n0n/s4s0Y/eFImRs/EpeluizQZc6iEjUD
 WJOZ3qptXGdI6z4gjDvxpRs5nMeqwtr6ZcHCCNqtpH64dYtwH6E2wM+6lIbMHU5s7IfE
 r9yZ4RO4TmMzgrbbwaePOb6Lauhy3dkA6/6iq3JZc2efrNjSx8NzaiuCvCACQCQt6zR2
 FLhxKMGiP7LnAcXDNcPRCXOpcNeC0HY2/jldNOkt4qb45s7Gkz8yVdwG/dqNyP7D9k3z
 yljqahL07gRZVE4OwjaRfKw0Splm62X7B+OiDGIoLUfmPlp5zUb5LJtbj1bkmi+qc1l/
 S/KQ==
X-Gm-Message-State: AOJu0YyYL7ErOF1tKvYWFQmtSx8CuCwyU5RDcyl+bXkmfmo93JU33WC/
 gxNgT9WBFfi/Br8NeS3+CXindzEKQQ+h0oUNlcbsohBqNTXziqKZ7iriKym/v+Jm4l9c9gQA24n
 8LiV55w==
X-Gm-Gg: ASbGncuMHjS2IVDzugA68MdaVYNIs47Gyyl9KU9F7sfI+JLDxmVU/8sZ75Do3c55nrB
 Ru0xA7cbVyru+kZOePvP7tQ6H5UYXEBAj0BK3NEifTCT1zyFJOh80A5ieuuCI+YH+yoOKCHn86x
 JZgcMUbaXZwAUHzFLHEraGVvKmO/AKTNXji1fYulpSYJvmYfzNaVN/auOwkgMHI9622FfMfG4Pt
 IipJ30i5SgKkKyQzlHX9xw6HA7MFuqf72Txvb0bt8Hstk3RyJMIBe+Bj7ojjtAlhrrEriWxcNOk
 m1vsW7uu2xP3+AqJNSDaWr6XLnz/862FXrVLfu6IvgSpb4Q/yzOs+qKE/RfGIJ10o7pLy8TlCuz
 /Z4rTyJxOPfVXB3x76vfJ0ag/+hH1WCsEZg==
X-Google-Smtp-Source: AGHT+IGpK40vgkVgDoT7W5UO/7Xh/zoeFQBuCQ6tkPPby7bH143HFGDBH/cmqmGSaQRb2KuFWICQwQ==
X-Received: by 2002:a05:600c:6487:b0:43d:7a:471f with SMTP id
 5b1f17b1804b1-442d6d5d178mr102814645e9.18.1747039351104; 
 Mon, 12 May 2025 01:42:31 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2f65sm11877250f8f.55.2025.05.12.01.42.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:42:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 18/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
Date: Mon, 12 May 2025 10:39:47 +0200
Message-ID: <20250512083948.39294-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VMXNET3_COMPAT_FLAG_DISABLE_PCIE was only used by the
hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
We removed all machines using that array, lets remove all the
code around VMXNET3_COMPAT_FLAG_DISABLE_PCIE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/net/vmxnet3.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 3cf5d71f478..d080fe9b38a 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -41,11 +41,6 @@
 #define PCI_DEVICE_ID_VMWARE_VMXNET3_REVISION 0x1
 #define VMXNET3_MSIX_BAR_SIZE 0x2000
 
-/* Compatibility flags for migration */
-#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
-#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
-    (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
-
 #define VMXNET3_EXP_EP_OFFSET (0x48)
 #define VMXNET3_MSI_OFFSET    (0x84)
 #define VMXNET3_MSIX_OFFSET   (0x9c)
@@ -2466,8 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
 static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
-    DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
-                    VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
 };
 
 static void vmxnet3_realize(DeviceState *qdev, Error **errp)
@@ -2476,9 +2469,7 @@ static void vmxnet3_realize(DeviceState *qdev, Error **errp)
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
     VMXNET3State *s = VMXNET3(qdev);
 
-    if (!(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE)) {
-        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-    }
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 
     vc->parent_dc_realize(qdev, errp);
 }
-- 
2.47.1


