Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C456D3E78C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cjH-0003M9-DU; Wed, 06 Nov 2024 04:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8cjB-0003Lf-14
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:53:30 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8cj8-0007i0-FI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:53:28 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d808ae924so3634452f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730886804; x=1731491604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nP+NRHrvPcF/GLP+M/LO3pbc+GXA6ruKrTtZ+hPidds=;
 b=lzR91N4aKDwNBR0g9qpD55Dzw+SL859btz50XeCaY+GSXc8gJr/JtJ696vonKhqTFb
 CZ17hmNhFf5hv+QwN4nnmBtX9uFRZn9K44aNLagDOVFzAbiOIF4ZdlSy+YKS3q8M8fUs
 4ipcraN8fEc5U8oiKL9IPhhRmuTzBQR2z8+RMcIyvQk0WaYxhEKjjKEvuK3jWNI33hmt
 bWH3pKbCDAch1w/jM9x4e3YRqWAUPkXxvu7Gaq5eWukGAJsK5p9wRXWBWQimT0la/q0t
 EA0hJZA6hBZcoWghS2NOGacF9s3Ob+GYPkCYP9jS5zkukcqagiiyMV6grAOnM6RI4zuN
 K4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730886804; x=1731491604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nP+NRHrvPcF/GLP+M/LO3pbc+GXA6ruKrTtZ+hPidds=;
 b=KCB+uVNCxOrUJEpjpwXHq4XwCUEwyeLmiuBtvooPjXaDAJVteaaUW9eGuYHf+svYU3
 Srrodq2XOE1v09t04wp3c0Wckfici7swqx7XHZrkXWvncHBF4kPRj4h/ns6pasQEOOrx
 1uKZjN85YS0paQy1DZpTL9DGJdYYZYRudRNxN9KUUyKUpCcnZXQFlDLz9LM36aC1FiZE
 84WrdrvNZsd7wgetZhfqDpPl2dC2WmfaP1GCW7/AarcDu95OEjFLOk49D6GQEMlcm1ed
 e3IZdjdaVVRwMT3yCZU9V0D4qLLVowlLJdyw1dE0r3wK3tzagd7DU15XFWyzbI55Ry8Z
 K5kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8HvUBmn0spM4StBlYxN7Wmv64hPVjhgDSn6HMVC68PP3r2OOiUkqZXV7NagRI6h2756Gj2aJZYI04@nongnu.org
X-Gm-Message-State: AOJu0Yzv/yL71DdF82taNLCCMZInc2yC9vnwqKSq2EkPDdXj9VCO62UV
 VRnq1R8emXjeUWb91Fy/VLDFTzBTQ/m3xqpkCB51T2El/LC5hnAOiTdDTSq5SsY=
X-Google-Smtp-Source: AGHT+IHp/FLuLCZOu1Btd4qVkiyVer4zp+c5+VI5W6UphOYkitUKV/pyP1BFSnMopPfA6OCI4Vn8lA==
X-Received: by 2002:a5d:47cc:0:b0:381:c935:dec9 with SMTP id
 ffacd0b85a97d-381c935dff4mr16973147f8f.12.1730886804126; 
 Wed, 06 Nov 2024 01:53:24 -0800 (PST)
Received: from [172.16.22.241] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b27sm18835027f8f.19.2024.11.06.01.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 01:53:23 -0800 (PST)
Message-ID: <82295d07-796e-44f9-8185-4b1430260fe3@linaro.org>
Date: Wed, 6 Nov 2024 09:53:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] hw/net/xilinx_ethlite: Only expect big-endian
 accesses
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-13-philmd@linaro.org>
 <5f3a4435-dfd2-48cc-8b95-35b8bdd07810@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5f3a4435-dfd2-48cc-8b95-35b8bdd07810@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 5/11/24 13:30, Richard Henderson wrote:
> On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
>> The Xilinx 'ethlite' device was added in commit b43848a100
>> ("xilinx: Add ethlite emulation"), being only built back
>> then for a big-endian MicroBlaze target (see commit 72b675caac
>> "microblaze: Hook into the build-system").
>>
>> I/O endianness access was then clarified in commit d48751ed4f
>> ("xilinx-ethlite: Simplify byteswapping to/from brams"). Here
>> the 'fix' was to use tswap32(). Since the machine was built as
>> big-endian target, tswap32() use means the fix was for a little
>> endian host. While the datasheet (reference added in file header)
>> is not precise about it, we interpret such change as the device
>> expects accesses in big-endian order. Besides, this is what other
>> Xilinx/MicroBlaze devices use (see the 3 previous commits).
>>
>> Correct the MemoryRegionOps endianness. Add a 'access-little-endian'
>> property, so if the bus access expect little-endian order we swap
>> the values. Replace the tswap32() calls accordingly.
>>
>> Set the property on the single machine using this device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>>   hw/net/xilinx_ethlite.c                  | 20 ++++++++++++++++----
>>   2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c 
>> b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> index 8110be83715..8407dbee12a 100644
>> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
>> @@ -123,6 +123,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>>       qemu_configure_nic_device(dev, true, NULL);
>>       qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
>>       qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
>> +    qdev_prop_set_bit(dev, "access-little-endian", !TARGET_BIG_ENDIAN);
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
>>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
>> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
>> index ede7c172748..44ef11ebf89 100644
>> --- a/hw/net/xilinx_ethlite.c
>> +++ b/hw/net/xilinx_ethlite.c
>> @@ -3,6 +3,9 @@
>>    *
>>    * Copyright (c) 2009 Edgar E. Iglesias.
>>    *
>> + * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
>> + * LogiCORE IP XPS Ethernet Lite Media Access Controller
>> + *
>>    * Permission is hereby granted, free of charge, to any person 
>> obtaining a copy
>>    * of this software and associated documentation files (the 
>> "Software"), to deal
>>    * in the Software without restriction, including without limitation 
>> the rights
>> @@ -25,7 +28,6 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/module.h"
>>   #include "qom/object.h"
>> -#include "exec/tswap.h"
>>   #include "hw/sysbus.h"
>>   #include "hw/irq.h"
>>   #include "hw/qdev-properties.h"
>> @@ -65,6 +67,7 @@ struct xlx_ethlite
>>       NICState *nic;
>>       NICConf conf;
>> +    bool access_little_endian;
>>       uint32_t c_tx_pingpong;
>>       uint32_t c_rx_pingpong;
>>       unsigned int txbuf;
>> @@ -103,9 +106,12 @@ eth_read(void *opaque, hwaddr addr, unsigned int 
>> size)
>>               break;
>>           default:
>> -            r = tswap32(s->regs[addr]);
>> +            r = s->regs[addr];
>>               break;
>>       }
>> +    if (s->access_little_endian) {
>> +        bswap32s(&r);
>> +    }
>>       return r;
>>   }
>> @@ -117,6 +123,10 @@ eth_write(void *opaque, hwaddr addr,
>>       unsigned int base = 0;
>>       uint32_t value = val64;
>> +    if (s->access_little_endian) {
>> +        bswap32s(&value);
>> +    }
>> +
>>       addr >>= 2;
>>       switch (addr)
>>       {
>> @@ -161,7 +171,7 @@ eth_write(void *opaque, hwaddr addr,
>>               break;
>>           default:
>> -            s->regs[addr] = tswap32(value);
>> +            s->regs[addr] = value;
>>               break;
>>       }
>>   }
>> @@ -169,7 +179,7 @@ eth_write(void *opaque, hwaddr addr,
>>   static const MemoryRegionOps eth_ops = {
>>       .read = eth_read,
>>       .write = eth_write,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>>       .impl = {
>>           .min_access_size = 4,
>>           .max_access_size = 4,
>> @@ -256,6 +266,8 @@ static void xilinx_ethlite_init(Object *obj)
>>   }
>>   static Property xilinx_ethlite_properties[] = {
>> +    DEFINE_PROP_BOOL("access-little-endian", struct xlx_ethlite,
>> +                     access_little_endian, false),
> 
> I'm not a fan of performing any swapping within device code.
> The memory subsystem should do all of it.
> 
> A better solution is two tables, eth_ops_{be,le}, which differ only in 
> the setting of .endianness.  Handle the property by registering the 
> correct MemoryRegionOps during init.

Squashing this on top to have the two tables, but we still need to
swap back the effect of memory.c swapping for the binary, so I don't
think this is what you want:

-- >8 --
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 44ef11ebf89..d58757eb919 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -67,6 +67,7 @@ struct xlx_ethlite
      NICState *nic;
      NICConf conf;

+    bool model_little_endian;
      bool access_little_endian;
      uint32_t c_tx_pingpong;
      uint32_t c_rx_pingpong;
@@ -109,7 +110,7 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
              r = s->regs[addr];
              break;
      }
-    if (s->access_little_endian) {
+    if (s->access_little_endian ^ s->model_little_endian) {
          bswap32s(&r);
      }
      return r;
@@ -123,7 +124,7 @@ eth_write(void *opaque, hwaddr addr,
      unsigned int base = 0;
      uint32_t value = val64;

-    if (s->access_little_endian) {
+    if (s->access_little_endian ^ s->model_little_endian) {
          bswap32s(&value);
      }

@@ -176,7 +177,7 @@ eth_write(void *opaque, hwaddr addr,
      }
  }

-static const MemoryRegionOps eth_ops = {
+static const MemoryRegionOps eth_ops_be = {
      .read = eth_read,
      .write = eth_write,
      .endianness = DEVICE_BIG_ENDIAN,
@@ -190,6 +191,20 @@ static const MemoryRegionOps eth_ops = {
      },
  };

+static const MemoryRegionOps eth_ops_le = {
+    .read = eth_read,
+    .write = eth_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
  static bool eth_can_rx(NetClientState *nc)
  {
      struct xlx_ethlite *s = qemu_get_nic_opaque(nc);
@@ -247,6 +262,11 @@ static void xilinx_ethlite_realize(DeviceState 
*dev, Error **errp)
  {
      struct xlx_ethlite *s = XILINX_ETHLITE(dev);

+    memory_region_init_io(&s->mmio, OBJECT(dev),
+                          s->model_little_endian ? &eth_ops_le : 
&eth_ops_be, s,
+                          "xlnx.xps-ethernetlite", R_MAX * 4);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
      qemu_macaddr_default_if_unset(&s->conf.macaddr);
      s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                            object_get_typename(OBJECT(dev)), dev->id,
@@ -259,15 +279,13 @@ static void xilinx_ethlite_init(Object *obj)
      struct xlx_ethlite *s = XILINX_ETHLITE(obj);

      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    memory_region_init_io(&s->mmio, obj, &eth_ops, s,
-                          "xlnx.xps-ethernetlite", R_MAX * 4);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
  }

  static Property xilinx_ethlite_properties[] = {
      DEFINE_PROP_BOOL("access-little-endian", struct xlx_ethlite,
                       access_little_endian, false),
+    DEFINE_PROP_BOOL("model-little-endian", struct xlx_ethlite,
+                     model_little_endian, false),
      DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, 
c_tx_pingpong, 1),
      DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, 
c_rx_pingpong, 1),
      DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),

---

