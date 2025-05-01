Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96188C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYnd-0001ez-5s; Thu, 01 May 2025 14:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmz-0008QH-FD
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:44 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmx-00088F-EH
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:41 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8616b7ad03bso31234239f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124657; x=1746729457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkLoJeHjOZe5nRnVptyiZRscDcIvghHTBUySTfzCR5w=;
 b=M/hqND43bvbB7QLM/3v4/H4pmsw4F66fMr+AMjMTiSzC1bjQDYdBmoKzuLNR21mH/7
 fKuGAiRbaXLzJAiNYYO/u1UMAmLfVZ6/C9JHBtdc6MpHge6S33IVyJwP08BrybQ8vd5o
 lPSCfquUdAl0Si1R2ibf93zGDzCgp0eBydsikw1UgTEla23iiGyTynUiGkww6YfUPxPc
 Dd+c/7KWZjlYoD+POpGAAHA94z0or+7z0LUIBsPKOboKi8rTUti8BYBFbXaH5zQ4e5M4
 XnFirRAIA+cauJfzl1eO6HPN9Kbmv0hhaSbdVx3d1fLeuFdqmwosENh+78sySntUprIZ
 VaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124657; x=1746729457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkLoJeHjOZe5nRnVptyiZRscDcIvghHTBUySTfzCR5w=;
 b=eO/YZTJ69vlD1LGynaeIIIzwmOamlHV1M3bjccaaQMYoIYYk+D7EhCvpvr+OVBcoXl
 aH4Io+b8gmiiT612iFWqawtusuX5gSKnF43utebeaoBmQNIy/6fiB4YhHtPFNss5TegH
 fgaMym9OaTEqHmQWgOt5Akrx6m2/t68q+tiPtk5UlgIo5XAH7MsJzObuGT95OM2ToGKB
 2CF0j3b583Flq90ahYVVszYazDAfSwmskSYNeJYksNbz2FNz1Q86vkzBxwjZZeguAHzH
 YH5j1SG329Cx4sAJDZuaB4rmESKaaTu5SLUPCFsiH94GBAtqUa2YT1pRNp3slL3nO61I
 pZpA==
X-Gm-Message-State: AOJu0Yz3ev9MLugwxRvG0eWGaYc2viMsiUX7FWEMqJ5t4exW00zZcHds
 RNmqAyd8Q5CdYJM18pJyOOtNNLvZUeHJB9p/NW1qi31gu/JUDDQZ3FNy0LIkUc5/6nPatbal6MV
 4
X-Gm-Gg: ASbGnctjJP9S54D1DYmwSlEn2n8rD+d4OAFJgiTTTgKLFScV96WAbWnr4dSLXh0OW5n
 A9FOZJSJvY39DOyRiTCAnxzR7yZiKOQAx0g8lRmSPqGGBA6gWgWw0yEZfKuPPw65lLwn5izHOHQ
 CPW5ax9RLNdxkHI4a3Ru44dc+4nn+SN7QjpKRuvZLY9vWhvkLkngis/x5dHc/948aiGTnqKjxM1
 WXNhUNkOkNfvK6CJMrhcgD+PmDsp1kiHdnRrwrqNlJyur8joC+6FQd8kPBy9YmaVdU1K/4lx1MT
 j6DxlVZ+QY1+plALJH8SM3Y7F78xF0eF+L+jZTug1Iw+OZdaUE5pofZXQ1+gAIzTINHLTtF1Qhi
 dOawdr7aFrK79LfQ1O2GA
X-Google-Smtp-Source: AGHT+IFXDjXZc0X1Nly0Y+glTSr0X7/Sj0FKQ7fjb0rxaUunKYHU0v3kfAlRuXIBAbDZYKTmyKDg4g==
X-Received: by 2002:a05:6602:360e:b0:862:fc1e:43c4 with SMTP id
 ca18e2360f4ac-8669fac62f5mr38157239f.7.1746124657585; 
 Thu, 01 May 2025 11:37:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2b9400sm21179339f.3.2025.05.01.11.37.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:37:37 -0700 (PDT)
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
Subject: [PATCH v2 07/16] hw/virtio/virtio-mmio: Remove
 VirtIOMMIOProxy::format_transport_address field
Date: Thu,  1 May 2025 20:36:19 +0200
Message-ID: <20250501183628.87479-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd30.google.com
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

The VirtIOMMIOProxy::format_transport_address boolean was only set
in the hw_compat_2_6[] array, via the 'format_transport_address=off'
property. We removed all machines using that array, lets remove
that property, simplifying virtio_mmio_bus_get_dev_path().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-mmio.h |  1 -
 hw/virtio/virtio-mmio.c         | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index aa492620228..8b19ec2291a 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -66,7 +66,6 @@ struct VirtIOMMIOProxy {
     uint32_t guest_page_shift;
     /* virtio-bus */
     VirtioBusState bus;
-    bool format_transport_address;
     /* Fields only used for non-legacy (v2) devices */
     uint32_t guest_features[2];
     VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 532c67107ba..b7ee115b990 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -752,8 +752,6 @@ static void virtio_mmio_pre_plugged(DeviceState *d, Error **errp)
 /* virtio-mmio device */
 
 static const Property virtio_mmio_properties[] = {
-    DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
-                     format_transport_address, true),
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
                     VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
@@ -815,19 +813,6 @@ static char *virtio_mmio_bus_get_dev_path(DeviceState *dev)
     virtio_mmio_proxy = VIRTIO_MMIO(virtio_mmio_bus->parent);
     proxy_path = qdev_get_dev_path(DEVICE(virtio_mmio_proxy));
 
-    /*
-     * If @format_transport_address is false, then we just perform the same as
-     * virtio_bus_get_dev_path(): we delegate the address formatting for the
-     * device on the virtio-mmio bus to the bus that the virtio-mmio proxy
-     * (i.e., the device that implements the virtio-mmio bus) resides on. In
-     * this case the base address of the virtio-mmio transport will be
-     * invisible.
-     */
-    if (!virtio_mmio_proxy->format_transport_address) {
-        return proxy_path;
-    }
-
-    /* Otherwise, we append the base address of the transport. */
     section = memory_region_find(&virtio_mmio_proxy->iomem, 0, 0x200);
     assert(section.mr);
 
-- 
2.47.1


