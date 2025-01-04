Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB385E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz6G-0003ah-Ig; Sat, 04 Jan 2025 03:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6F-0003aH-OV
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:35 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6E-0006fe-63
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:35 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so18120247a91.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977693; x=1736582493;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oTbvY0b5lrRZQshDH0+J48N1NJEpTN8UFElTBKrhUcs=;
 b=rl+4k3LnU+Rvp6mHB1ULnmK+0fWQtUcJs3PpozabOgIcrlp3yF7a5ojBN7na4dapmU
 fgjVtOGDF9RM6beqWY7UxJ69IyYKOpZjNkfrG/C07AXGDogPMUcjPbTFcXIthCs3cINQ
 OLD5zmg0gT9ltDKIdtIUE9nvc5RWw3JWe5P4Fnetc/UN4I8ZEn9Vyv3tncyAc1u6/4nW
 o5Uz8aFO3Vvsza2vDO7xgS89FFzdnsxTpSMTRzEtDG173+zpwXWajW9X58K3Nn99KhF4
 exvw4aBmYUTfucqy+6Oh/f7tYn9SC6nBiQtpsxF06qch7bd5p+2moD8ulPHBm4AynxOI
 rfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977693; x=1736582493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTbvY0b5lrRZQshDH0+J48N1NJEpTN8UFElTBKrhUcs=;
 b=LN/G1YDf6ib73/2lLVUPSVf7umg5RMth8kWqiuJsP1S2WzWOXBqzNADecS/9nCAY/B
 XD/2C6wutCseMZcbyPtK7PZHPclWGOF/e6cx4teiY2Z2cNm4eY1x3DimCxcKx/shQfsr
 GEScNqzIuCqnZwu9Fxn+hx2NbvHnduiv4YjjrsRS6gJS95Mcglrc9d8zQk1vcYpjkHIf
 IRp9RT8iLVtTNgJecximkoCFyfTdoAuq5bYRbmx1rwz+4I4zDigCc9PwBsza2EcSOJ5N
 ffTcemVXiCAi2BZVnzGw02R0Zqx3/L2BAAFa99MDE/2gNV4RvNcuWSLgm0nd1sUMnStC
 4RjA==
X-Gm-Message-State: AOJu0YxBe5RzIwKQrE8Rk1fJTXxw04Sh5nvg7CMhiqimXSMt9I0NB+de
 XXFhPkklJB5HcVQR26Mq5n78j6BPSyqBwunb2ieYDExdwP4LWdA2EJesS4LcRJo=
X-Gm-Gg: ASbGncvTX82R3iyBmfXtW4VRHG1Ge7LDelHwHtfKMEKyOZqD+kZfI8AqXg7ASuGr8S/
 0JJo0a9utK9ZTphs7Z5S2FK9Zrcfu98a72oUb+b+mWxnjSodUWKnbl2Az54UIC9B24ARo07R0yV
 Jvdxp+Ux33cdcwUgoRjN/LJTIuuf2OfI8dTzXW4MT8hBtmgSuOWNlHYauelYXszprgPYZop4uOz
 FJIs7BJFjcKk+v1jzROZc7uuTycUKgyXde4m/6aVgYLUaLyH+7Fa3thjvx1
X-Google-Smtp-Source: AGHT+IGYhht4fS5uvygWsYjit6SAtOcgp0RXCGcdpU+Oy+lSBg44NM7nxdYMVucHmaBjs3L+SqS6xA==
X-Received: by 2002:a05:6a00:410d:b0:727:3c37:d5fb with SMTP id
 d2e1a72fcca58-72abde8461bmr69433018b3a.16.1735977692940; 
 Sat, 04 Jan 2025 00:01:32 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad816305sm27327642b3a.31.2025.01.04.00.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:32 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:00:56 +0900
Subject: [PATCH v8 3/9] pcie_sriov: Ensure PF and VF are mutually exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-3-56144cfdc7d9@daynix.com>
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 1eb4358256de..109b2ebcccba 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
+        return false;
+    }
+
     if (total_vfs &&
         (uint32_t)devfn + (uint32_t)(total_vfs - 1) * vf_stride >= PCI_DEVFN_MAX) {
         error_setg(errp, "VF addr overflows");

-- 
2.47.1


