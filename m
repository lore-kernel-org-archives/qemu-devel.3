Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAF6C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYpX-0004bG-I5; Thu, 01 May 2025 14:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnx-0002hk-Mp
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:46 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnv-0008KF-Sj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:41 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-861d7a09c88so40192639f.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124718; x=1746729518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNiEylsO3oY9vgtqAxWvkDME/V5ix0NbPvey475+kvI=;
 b=rn/iI7UDZbYMHSCkBCKjbT4jk6oqEdBsaU50nfTY3rbgWen7eNfJ+R7WqbG34NctRm
 cN7YrgO3bZvppPoLu2a3pxIomMajXRfnkc7TaEwlSaPqQ2QC2PK07Gk1jZ82c/G8ZbIt
 tCwi2WO2OJdWRM7o+dvQVD8ORglorp+hq4D1gg6sBiLwNX/tNdtcASv9YG81ZdxvFIOf
 UZ3WyQXIA2NsUGuDMNt4k22gRutDaox0mCw2JJp7BkN9Ak0KQza9nT/ZdxfIjuPYhQpt
 traKkRp+t40iWprr+M8kq/ffLGS+8na3/QAaN/98q2WEGZ90+smTrEmyZ5EFOSsdAKOD
 nb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124718; x=1746729518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNiEylsO3oY9vgtqAxWvkDME/V5ix0NbPvey475+kvI=;
 b=eB15i9Ggl2ewCQfgJKXr9o/xJjZqGJD/Fre6ss8rBnUITJ4qrBUrfhmbXAacXSn1+L
 P5RBrBJVydu6FtajSOfGkBTw1GAtS0aPfVmOj7w5sv2k/83WOQ+95ug8rWjl+34U3yPV
 uvIumYt3wQWvCNYPfvgmflyQ8WF21V5BOtBL+T4lekjzzgfW2iVebQXUh6g0orZ9iWnd
 LWnbA1sKT4r/SY/b7Hz1nYnLYZoBL4shzBNoEP4UEx4Nu7ogqzT6fn2RSaykdxoxJCIk
 jITEixK2MA0u0I6R2MiQISIlAP9nLECkyQgayFE8kg8DPbfiM+t33sA9wdqNf4uAPjFU
 AEvg==
X-Gm-Message-State: AOJu0YyktAF/+30igTEYBn7nXdfJjDvTa3KDJ7WK6h1RojR4LrKPbB7g
 ejwqZDwLpl9WvTWtirGS+W60qMD8VtsC5Z3IutpxlxlNqpx1O5jms4AZdiuFnU15hnXoYQWu6gU
 O
X-Gm-Gg: ASbGncvIrXo9GNPKQz6grv8rsgvDoUJXhozef4JPxo7Ni1V0SqBLY+hMhxEsx9Cj+AW
 FEF5LgCsr/gKPPLI7bY5xPSMRuT0J5jlOd32a6JbGMGxvQ5T0cM5xP/q5N8SRSo5LYsQHVW6wRG
 Oqwsbzbe5Tg+FNaCl2Ddep5pHMgEPUo/pOVM+bv1duRHULZUdzD+ILlR93GMSUyUs0vWa+oH9hZ
 wc0ZGCvLSIOUx3qQ8xfoccXhs+Rb9WrK8zIivcmwaXoIAXlAw6aQaiSE830YSn9rfuoOFTAIBs2
 w/qPPVLsxA+IM1DcReaRnYieY2xaLMqj7p8t/wAVUcBS7v/QnuW/5T1fyvB5Wwb3pkqatnNcjdD
 EmV7LAb5qE6hXpHiA65SF
X-Google-Smtp-Source: AGHT+IEuPA22mre3z/zUSoY8T34jawnc11RnvdBmQ3Gvm9mmX0Lrg/qtlzLZ+DY2deYw18G/xAlu+A==
X-Received: by 2002:a05:6602:720e:b0:864:4911:f463 with SMTP id
 ca18e2360f4ac-866b348c723mr29008939f.10.1746124718559; 
 Thu, 01 May 2025 11:38:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882ee3c6dsm309761173.44.2025.05.01.11.38.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:38:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 14/16] hw/virtio/virtio-pci: Remove
 VirtIOPCIProxy::ignore_backend_features field
Date: Thu,  1 May 2025 20:36:26 +0200
Message-ID: <20250501183628.87479-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd35.google.com
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

The VirtIOPCIProxy::ignore_backend_features boolean was only set
in the hw_compat_2_7[] array, via the 'x-ignore-backend-features=on'
property. We removed all machines using that array, lets remove
that property, simplify by only using the default version.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 1 -
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index f962c9116c1..9838e8650a6 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -149,7 +149,6 @@ struct VirtIOPCIProxy {
     int config_cap;
     uint32_t flags;
     bool disable_modern;
-    bool ignore_backend_features;
     OnOffAuto disable_legacy;
     /* Transitional device id */
     uint16_t trans_devid;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8d68e56641a..7c965771907 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1965,8 +1965,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
      * Virtio capabilities present without
      * VIRTIO_F_VERSION_1 confuses guests
      */
-    if (!proxy->ignore_backend_features &&
-            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
+    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
         virtio_pci_disable_modern(proxy);
 
         if (!legacy) {
@@ -2351,8 +2350,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
-    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
-                     ignore_backend_features, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.47.1


