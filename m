Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F48C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Vo-0002jH-Pw; Thu, 08 May 2025 09:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Vm-0002hX-SY
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:42:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Vj-0004ee-GS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:42:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22fb33898bbso5794435ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711721; x=1747316521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvLizXjiSVqZDvieXMhXwGlqnaF81TYck8XbLuFhLlo=;
 b=mXVvzg6HqhzKM+DmrgHd8/SaaSWYIvtsXGxk1NUpcVOIFdOKzY3MLKdgtLMPUdpM5v
 j8CPSG4ACkXcdCQ18Xxvu2hbC9aJhFFXA/h5yuu3wBacOJQcni0OMS7iToZBHlOmrxUh
 8j8wgukB7h4UjGeOJwqNBrUpDPXWI3EX19gfwQHJ5z3al3ItDk4txOHB8BEA+Ckii4mK
 mRGu9eXt5cJxz7anCexeSlYt7vrSsCBe0iatPfUFBA5iTbOzoYYrQBQbLZUzqZG7mS0s
 4LzLtKOFKsWAffrsxI/wvRFEkWCEz54i8bm8I5M41PM8avRR5CpEuCxFY5/Bq3Ct/5Hw
 skpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711721; x=1747316521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvLizXjiSVqZDvieXMhXwGlqnaF81TYck8XbLuFhLlo=;
 b=ogKym3s6glkyJJ30UYnNEAREVPNyuc1gM0bAtpOy0nLI69eHiH/jM8uS9vcKC+f6/8
 y4x2fw9PVBNXL9MjIdZKezpo5pwVAN6bad6qgQ0Vak0CSJ5Mg7UMXCZkoKtIHFo94f2K
 Ceqz7AKDRHp2ZUuho14pnTTCErrd5GU+ozAENkoh5PKgc9fGC936Jly1uGSHFnG6qGH6
 rZgy/D1+m2+zjoRcdxNliZ1PRl0poT5i8NJkhj76YZJfSTEFqIRqRXEC7AnoMCi2prUO
 mVC3phl1vvM/X/9Wk4Wwc+3pVqNqPy/bPwxrf6V3CgCuNGkb1TBEX33NLxpKu5W3MR+f
 ZZZA==
X-Gm-Message-State: AOJu0Ywn9XGqwoZ2vm5LvS5J4N6khfYtnWmJWzsEdYtOlNFFRjLQQwf/
 McBDjUMeJLzTMYFILcLcfYst1qw0T/LMvjJqNHruGeyCJIQCKhu/ixS5bnJPGWkyJQcCFXTZeDl
 9l+SwSw==
X-Gm-Gg: ASbGnct9jpjIxbD5LCtucAGA3EvEZojtRnfDfG3AT+NnW6CBndE91x9BbMin6Rohcdb
 MbmXzO1pthBKmTsaiYTBPWsUeXfhu7ZJGf/L8AF6zQIph/gRgxR3EVov1//JhvyzXx66s/ngIqR
 Pdem9nMNYuuipcSsvBRdFMXFSnQdnVaZTqJ7nlZDxcikCbXiLqKWcAdjxS26WVo/MXS6qginHnS
 lxdPWAWdMbZBY4m5ebU+z0bH5Yn8b+M/owfWOifIt889fyPTXbOcGbaGjTPI0eAlhyl0HKzLM75
 1KvJX8JwQA2P9uK9puh+6ZH+rbxlv9WJfVx+1QbGveFv/UFIyV2Hm2NpAWR3q8Gc2SX5OIIZyNG
 Es32VbiBL4PzuRIk=
X-Google-Smtp-Source: AGHT+IH5BYgtEVsF3UjuNdxEmc61R/ao7c1/1iBgmrXnG9lSYRtLalmf3eGNlXKix7bxAIso/rU7wQ==
X-Received: by 2002:a17:902:e38a:b0:22e:634b:14cd with SMTP id
 d9443c01a7336-22e634b171emr74212065ad.39.1746711721364; 
 Thu, 08 May 2025 06:42:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522911bsm112537925ad.191.2025.05.08.06.41.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:42:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 16/27] hw/virtio/virtio-mmio: Remove
 VirtIOMMIOProxy::format_transport_address field
Date: Thu,  8 May 2025 15:35:39 +0200
Message-ID: <20250508133550.81391-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62e.google.com
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

The VirtIOMMIOProxy::format_transport_address boolean was only set
in the hw_compat_2_6[] array, via the 'format_transport_address=off'
property. We removed all machines using that array, lets remove
that property, simplifying virtio_mmio_bus_get_dev_path().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


