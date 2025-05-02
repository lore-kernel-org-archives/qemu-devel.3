Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105B6C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvag-0006Wf-JZ; Fri, 02 May 2025 14:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvaB-0005k8-Ey
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:12 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAva7-0005Xp-T7
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:57:57 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so496270766b.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212273; x=1746817073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdDlI5qLVUtiJXLSpG9OpY8RG/p/SqrqX/ncOt5okGA=;
 b=BO/+snOkPJunjr+lJRkPsOtZSUkcRnuiexGnj5Tyy5GeTYm9QVhb7mNzD5L23pi48X
 Sb5ZcENQFPn9mX1HwPnLZe/z49BunhzofGS2i1jbGVOKgUuSttVpLDKx0LEp9CG5v604
 w0XRuYrMyGRELMTdgIHRACmnSwT1RdpUL/23tPcjAXSwCQjdo7+7o8qU/RJRwBQ0QuL+
 uTR4RGca09YaRIgGVdxPepeA3aNjgdDK0vm8LwvqOd37WKgvwoeboGMumToDByb959yW
 66T6nIWXMMXzIT1y+bNmNHQnYXBWIdGZNBYrnKALWBlMJ/aeZmoYiqBHin8z8naZXIQC
 pz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212273; x=1746817073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdDlI5qLVUtiJXLSpG9OpY8RG/p/SqrqX/ncOt5okGA=;
 b=toqFEo/dPBsVQd5MtqJSZGP9lO7+YiQbL2wHYJgxhx355YmwoEQi9/X2fZd8CIHE0z
 //ytaydwfZSFUCFhMAvasWN430NnmV3SGUVbdtE5gE7oWERGZ3D5PFRfMJ+e2H/Z/eVg
 hKAwgmuUBgiaC2HVZMXiDOaqo9ZMVWOvWsj2qp/yMhtholmKP4DknydGnq/Fjuwotgq5
 mur7X86JMFOXQHs4L1TwNonOzBh25Q3qsaQSs4TPENOgLAvmO8bdKCgD+mLtvYRYvd+H
 9iwFRD0xNRgRq/lwRGP1wh2N8yAbc9N0dwKo+gBTW2yeSlQreuh16jcnMWAIGKYvjIYx
 KwOA==
X-Gm-Message-State: AOJu0YymTikEO+LeW5oeNR5bfsAOboLQbqL8OV0kchGIXynkFGwqwSUJ
 AT/ZjkQDyjvgSW2rlW8xV3ZqTAhwB/fCi0vvsrg2DcPDUDE2MjhAe2K3EupuNa5KRuv5sCseYzF
 i
X-Gm-Gg: ASbGncuQ35SuhmyBoqlcpYDkgqGY2iy7yS3lcSOwlI33jTRZowOy9IW3nO2bKIp2ww4
 +KSqC6Mlc+PRDXF3KWeA7fmAmrO5S//o53dUzikv2e7l/JCaaOs6X5WVndNMz4E0q5S5j1/nVQc
 Wci6F0/ZY/u2rYraB3Q+SZ1m/e7RF19gYcHFTabDCgyQkflscfsuYX7fDLh3odaYlAcOnNWVtX2
 XQKp5G+lJ9XXU2txbU1DcPpm5651QCZWAfDovOcjLLZlWtWc5k0u31Ca0CQ7vD+TlrFa3lF+G93
 cgwv0mqk3BfUyXP3jHRc+/xqlBqU8yCIPr/L+w6EYrD8lPlGnT23EMIHX9Gy7XjZVVE5xD61za5
 jThhCpZ5TGUhxUMX7inIa
X-Google-Smtp-Source: AGHT+IHrvdYAFDjNqcdIEkKRem4Bg7cQDf+bliSe0OLZukX6SQZqqmBq4qIsuNtCopBQHkmeGkEY6w==
X-Received: by 2002:a17:907:7b87:b0:ac3:b613:a651 with SMTP id
 a640c23a62f3a-ad17ad87102mr421439666b.17.1746212272985; 
 Fri, 02 May 2025 11:57:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c0276sm86005966b.108.2025.05.02.11.57.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:57:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 10/19] hw/virtio/virtio-mmio: Remove
 VirtIOMMIOProxy::format_transport_address field
Date: Fri,  2 May 2025 20:56:42 +0200
Message-ID: <20250502185652.67370-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


