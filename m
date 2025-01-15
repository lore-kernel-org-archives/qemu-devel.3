Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6C2C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCl0-0005oL-Uy; Wed, 15 Jan 2025 18:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkd-0004pp-Ol
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:50 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkb-000439-Jj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:43 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso314371f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983480; x=1737588280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKoFnQ5SYagANUInklr1BkIfWF4VImHQnYuMR45zsrk=;
 b=lS3q8DGEA0xb9cJ3hY/laWP1UwbfEWv+mU+dN53LHwvgB3tb/5mENVEUEAfxMVgPXw
 482zzLC1xgkFmLVWhsaljpEbZVWVjDht0QROW0qD+g1dj2wQHc8vLdeZnmOE7inGuN/s
 +IOy+jBjPbOjmHFnIL1nlVx09a6YgvNGlXK58gTn100sgZV/qDl5lKh0D4qQzzMXAi/l
 pxbzX1syytW+N8vTX4kPcIIPogmVXDHeo/jejYJseEkFGMAZUcQn+Q3wcyoH2zs/3iTp
 6heIicYUx5z0H7E6bNSO71hyls82aWoA7Aqx1d5d+oLsStIg/oIFp8o/zvKz1SBaVoAZ
 Rw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983480; x=1737588280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKoFnQ5SYagANUInklr1BkIfWF4VImHQnYuMR45zsrk=;
 b=NIy6iAzcACsi3QxBK/AoaTA+VgBTcaaP7bHXBrPfCcAPJLFNbXN0etJr7G5s2Kj0Fh
 KKi0OAfntjysBLsqIHdXZKg97fAu0Ah2Q64orCdXryyTIK0tHUZp8MKDBVIyrkdBHTb/
 65+pv4Qd7vlsn5TX6C9g7XwyBsWQyXW9k508sf6b5ZUNWK3DWtSi9MuWxnI2vpog8+Eb
 oVCQEQD39naotyZEdWv2pQbRlI4Rw3XgRtGdyDoHxriTJCfK6H+JTObLuh7/vi3Q+rMk
 BM80LHpwAu0+XAlCR6ISgK+HkQxOQMw43m/lvxCDr1SkyIfVF/y5sVKJyNytf9tCo5S9
 sTxg==
X-Gm-Message-State: AOJu0YxRaCFUp8yAmjwPtWo/inxDZhotF+yaclncXcfZ6jvAnDaAMzFo
 klfbVMN4+fQDTXKqZ8mqOlj9xPa8mcJq64toy/u/OFchUhPymJNXlaTv/KEgWszWf/msByOiKtr
 +AxA=
X-Gm-Gg: ASbGncuqGaez2W3OCl6MasXsmwBKcggj1a04mQolg97YWgblp5D460KY4UcMQgWeYQZ
 nAKCShl4u9THHTL9ocNlm6kCspZv9z6tsreBzV3qRWXkdqZridZTXGzyhJ/AFy3sVCH0H75L5fI
 ZYMNJ8rHO+qB0Fpq/X0GfrSXnKD2nMHMSGHnJ59SyKz7yJ6IKbbXHpH0C7f3uHzwFXDtL3TlGC4
 OK87VtvNYwTL4SuQAQrSb4qzW6SmpIZJL2YD8N5qLaxb3x9D18WFIqjyGxmV3dv6uYXJnq9Jp+x
 Gvmp60DFjJ0CRHxObLOTZ2GrWRlq87c=
X-Google-Smtp-Source: AGHT+IFPUzDdZaQzj4hnqyTFcfmgZfa3lry5GOEq6rqqrqnCzhKrmzNmaqFKCHW/M8dbKOhUzx0Zxg==
X-Received: by 2002:a5d:6da2:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38a872fbcdcmr175620f8f.5.1736983479636; 
 Wed, 15 Jan 2025 15:24:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d012sm18781309f8f.8.2025.01.15.15.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 20/21] hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE
 definition
Date: Thu, 16 Jan 2025 00:22:46 +0100
Message-ID: <20250115232247.30364-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

VMXNET3_COMPAT_FLAG_DISABLE_PCIE was only used by the
hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
We removed all machines using that array, lets remove all the
code around VMXNET3_COMPAT_FLAG_DISABLE_PCIE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/vmxnet3.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index a527042ab32..d8132773fad 100644
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
@@ -2467,8 +2462,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
 static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
-    DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
-                    VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
 };
 
 static void vmxnet3_realize(DeviceState *qdev, Error **errp)
@@ -2477,9 +2470,7 @@ static void vmxnet3_realize(DeviceState *qdev, Error **errp)
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


