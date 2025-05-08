Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6038CC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Zc-0003xU-EQ; Thu, 08 May 2025 09:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1ZS-0003i8-3x
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:46:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1ZO-0005GV-Mg
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:45:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so1054284b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711948; x=1747316748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ns6abkUGaM6ukyij9Yk70LzU+Vns27nmI4rpIretkkk=;
 b=kdHczDAtzYUdFYPmu5hfBEzLvF8wmfwBN7007LSkfLejx1VFYJc3Rj8sfhm/JHrhcg
 Np695U8C98kezeliXhUr8sC/vp5MPaGRsIux+inELLMievxcJl8EcrNO1Qwu7dgCLUE6
 1aXCL/4dWmwoTpsnsSmJSrN3gRv9wp8tKAsP8vZdIrXj3CD8up8kfNjOlEHS7fMqKKUX
 Q8I8F9HnyBM2Iv7QtsurhJZBe8jGbuz1ESdtl1u028bAYvEk7f0ZxLDWYjO/eqLK2Ev/
 4NFTkA12MeaY5TrdVS3H/iARZiI/jUDdZ+92BaNGvABScFDocg5aPAKc45yfAdJ53Da9
 I7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711949; x=1747316749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ns6abkUGaM6ukyij9Yk70LzU+Vns27nmI4rpIretkkk=;
 b=XPs10ABV2bPMJqdHmbRNpNhR6ocQ3jXkndTnQruVvmCSs6Ri3Nsx/mDO6NGtVXmWPe
 wkxqZgtKD8G9OebHoUK0L3H3/c7FfBrDcrt/b4zxWoInXJuBopS1JjGmbZ+uuTu+/L5P
 UT6ApTKtWK/PP8kgCeYLLauKpptG8MWfh9JI0UK8ek8C9kP4SIZgEm08oY8reDi/feN/
 lR0tvvtXbtDygBLQog03trncEu+pDXDb+QCz947alXSvUc8DE19Hs80x0cW8/aqtg5xN
 PFgvzmowox7I2bW0+IL64Jzf4uE+3qXapz9LTG7lN+NGrhPpLkXgzJxDu4iuFrCAUHyU
 PBTA==
X-Gm-Message-State: AOJu0YzyrJlznWZkTfudek5MA3ljw/9MqUU8+tSe3kYF1IWO2Gs8V6F+
 +gMirk28eSB6NqPn62wUPQH/f3D2RhyFE63K8DY6gfKN4qDK4ri1Bb1wPo6VHOX/+MZOz6QCcxh
 6hMFkyg==
X-Gm-Gg: ASbGncuhy+J2cJJWj/zJ40PnlIX+fUEcplwVr6yjaFE78jCKD3SeknU855+bymWxyg8
 lRsyzTqsB4dBqNABUeC+cLysOyrGRCckJuPhtrodiHkFB3DeLSPwwMz46EzSON0atCFmPtdY2m5
 4nfSt/mH5QwoxOmV/YQTjvWxjD9FNpY6QBqyid5uettLM9tTvLvvxmu22qLC3Vc1OTfRukC+P9B
 Xqiwl500Bw4e9aSl4yoJuXVyTuj63Vv2sasD/nx2/+Otul82LMGSdVZ3ZzqEZ91DASQfTzDFeVa
 c/384J8vTCvByUoCzCnEFhA0h1hCobv6ZbIon4qj7Z03v7KPDIDCB/3xQrOsJDvPjejhcrSZgqN
 luEJSj0itycT46cM=
X-Google-Smtp-Source: AGHT+IEnO+sngRS5wIqF0he33Fpo8ZvEfqldkdJOaUMWkhexbxVM0HjmJCofWNDDAj5rwpOOd6Q5/A==
X-Received: by 2002:a05:6a00:1308:b0:740:a879:4f7b with SMTP id
 d2e1a72fcca58-740a8794fcamr6118097b3a.18.1746711948529; 
 Thu, 08 May 2025 06:45:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405906372fsm13690156b3a.148.2025.05.08.06.45.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:45:48 -0700 (PDT)
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
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 26/27] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
Date: Thu,  8 May 2025 15:35:49 +0200
Message-ID: <20250508133550.81391-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x430.google.com
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

The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
in the hw_compat_2_7[] array, via the 'emergency-write=off'
property. We removed all machines using that array, lets remove
that property. All instances have this feature bit set and
it can not be disabled. VirtIOSerial::host_features mask is
now unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-serial.h | 2 --
 hw/char/virtio-serial-bus.c       | 9 +++------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index d87c62eab7a..e6ceacec309 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -185,8 +185,6 @@ struct VirtIOSerial {
     struct VirtIOSerialPostLoad *post_load;
 
     virtio_serial_conf serial;
-
-    uint64_t host_features;
 };
 
 /* Interface to the virtio-serial bus */
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index eb79f5258b6..cfc8fa42186 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -557,7 +557,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 
     vser = VIRTIO_SERIAL(vdev);
 
-    features |= vser->host_features;
+    features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
     if (vser->bus.max_nr_ports > 1) {
         virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
     }
@@ -587,8 +587,7 @@ static void set_config(VirtIODevice *vdev, const uint8_t *config_data)
     VirtIOSerialPortClass *vsc;
     uint8_t emerg_wr_lo;
 
-    if (!virtio_has_feature(vser->host_features,
-        VIRTIO_CONSOLE_F_EMERG_WRITE) || !config->emerg_wr) {
+    if (!config->emerg_wr) {
         return;
     }
 
@@ -1039,7 +1038,7 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!virtio_has_feature(vser->host_features,
+    if (!virtio_has_feature(vdev->host_features,
                             VIRTIO_CONSOLE_F_EMERG_WRITE)) {
         config_size = offsetof(struct virtio_console_config, emerg_wr);
     }
@@ -1155,8 +1154,6 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
-    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
-                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


