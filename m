Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11BBD40CEB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Sos-0004w3-3D; Tue, 05 Nov 2024 18:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8Soq-0004vG-M2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:18:40 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8Soo-0002rT-TM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:18:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4314b316495so51856455e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730848713; x=1731453513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s6agi9YZXxwW2nS8NmS8Db9dmILr40JIUJhSpW0Xehc=;
 b=aKgp7m+TayUyNTsqn65SAS6QiVohPs6Wq/iQy7d4N+2WffzD+patBI0Wy6V+evICrQ
 qy8aD6nNo6terXXvxrTnOeZsqLktquu6HNPXRUiImSRSeW0XyviAxS3A8SvxzU0FY98H
 c2oh9B7SoxkMGdYzHfYvcQxxyNjx/Nyz6StHTbhvmlS9vUnfEINEYFqI0OJCWuaiOgY9
 2Q2JixsWhcLd6Adg952UYGZTMW0IUDkgKnpju6MXc4JkBgrFeJZu+jKkrX9CFia4yCU5
 /gx4xt8w/lHZ2tRN66Kc1DbFN1isFtCvarpYLIZi1cO61Mn+fdFdJa4F6ATp4YtqQEI3
 2fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730848713; x=1731453513;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6agi9YZXxwW2nS8NmS8Db9dmILr40JIUJhSpW0Xehc=;
 b=slG+yff2qc33VOE0oCGnvO9Ui3VSJzdX9vBsHH/sDPDPiuahy6+NgGOAQa91yxKlx7
 7mGsNwrfJeiBeTkE0cJYjJrdGaXHvbCVOG1v4wy6vd17X2IbyPV+z2fKhLbPHxQtuwgj
 CVk9lq6y3ifswxnQwRjMWlyDKInsMKOlFh5w9SnXyLPtSFGzxP9l8dpPY95oY1WLBK9C
 iljIc5AaUsHjPsnXhfm1Bb2W7jR3g8a+ZMkx96vGaU5PLDx42ZaygrrqW4tXXFhf3Wcu
 hFpOFO8Ibwfx/6czecJhY8k9TncbAhIgCa3gdKDfr5kwRFQjOHb3Y5y0xI6h0CmlKkQh
 gExQ==
X-Gm-Message-State: AOJu0Yx8k6YQuvqURV6buIAJ+iLw797ABh7kr+I48VJx+0Syjuz2abRy
 2OdAXMiRuk/k0VKb5LUYwgMNHCbF+y9sI+DAz2Hh/3IxfMokDQHcfxtrffr0Bk4=
X-Google-Smtp-Source: AGHT+IF0+fcj/JFyegQU/lPNIsWcOO5FJ3hNAbgkeX2f367u02biVbH0zTqCxZkUJaD6Z0fF8wrjWw==
X-Received: by 2002:a05:600c:3514:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-4327b7ea586mr178117675e9.24.1730848713377; 
 Tue, 05 Nov 2024 15:18:33 -0800 (PST)
Received: from [172.20.143.32] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b2c32sm1697405e9.10.2024.11.05.15.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 15:18:32 -0800 (PST)
Message-ID: <3f61b85c-9382-4520-a1ce-5476eb16fb56@linaro.org>
Date: Tue, 5 Nov 2024 23:18:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] target/microblaze: Rename CPU endianness property
 as 'little-endian'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-2-philmd@linaro.org> <ZyqiPrf2wjP1yAPz@zapote>
 <accdb8b5-a73e-45d0-8086-82d69c97b569@linaro.org>
Content-Language: en-US
In-Reply-To: <accdb8b5-a73e-45d0-8086-82d69c97b569@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/11/24 23:01, Philippe Mathieu-Daudé wrote:
> Hi Edgar,
> 
> On 5/11/24 23:54, Edgar E. Iglesias wrote:
>> On Tue, Nov 05, 2024 at 02:04:13PM +0100, Philippe Mathieu-Daudé wrote:
>>> Rename the 'endian' property as 'little-endian' because the 'ENDI'
>>> bit is set when the endianness is in little order, and unset in
>>> big order.
>>
>> Hi Phil,
>>
>> Unfortunately, these properties are not only QEMU internal these got 
>> named
>> from the bindings Xilinx choose way back in time.
>>
>> This will likely break many of the Xilinx flows with automatic dts to
>> qemu property conversions so I don't think it's a good idea to rename it.
>> If you like to clarify things perhaps we could keep an alias for the old
>> one?
> 
> Adding an alias is the safest way, I'll respin this patch.
> 
> Note however I'm worried about this fragile disconnect between Xilinx
> dts conversion which isn't exercised on mainstream (in particular if
> you get busy and can't review).
> 
>>
>> For example:
>> https://github.com/torvalds/linux/blob/master/arch/microblaze/boot/dts/system.dts#L73
>>
>> Cheers,
>> Edgar
>>
>>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/microblaze/petalogix_ml605_mmu.c | 2 +-
>>>   hw/microblaze/xlnx-zynqmp-pmu.c     | 2 +-
>>>   target/microblaze/cpu.c             | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)


>>> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
>>> index 135947ee800..e9f98806274 100644
>>> --- a/target/microblaze/cpu.c
>>> +++ b/target/microblaze/cpu.c
>>> @@ -368,7 +368,7 @@ static Property mb_properties[] = {
>>>       DEFINE_PROP_UINT8("use-non-secure", MicroBlazeCPU, 
>>> cfg.use_non_secure, 0),
>>>       DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, 
>>> cfg.dcache_writeback,
>>>                        false),
>>> -    DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
>>> +    DEFINE_PROP_BOOL("little-endian", MicroBlazeCPU, cfg.endi, false),
>>>       /* Enables bus exceptions on failed data accesses 
>>> (load/stores).  */
>>>       DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
>>>                        cfg.dopb_bus_exception, false),
>>> -- 

OK if I squash the following?

-- >8 --
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index e9f98806274..b322f060777 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -328,9 +328,16 @@ static void mb_cpu_initfn(Object *obj)
      qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dc, 
"ns_axi_dc", 1);
      qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ic, 
"ns_axi_ic", 1);
  #endif
+
+    /* Restricted 'endianness' property is equivalent of 'little-endian' */
+    object_property_add_alias(obj, "little-endian", obj, "endianness");
  }

  static Property mb_properties[] = {
+    /*
+     * Following properties are used by Xilinx DTS conversion tool
+     * do not rename them.
+     */
      DEFINE_PROP_UINT32("base-vectors", MicroBlazeCPU, 
cfg.base_vectors, 0),
      DEFINE_PROP_BOOL("use-stack-protection", MicroBlazeCPU, cfg.stackprot,
                       false),
@@ -368,7 +375,7 @@ static Property mb_properties[] = {
      DEFINE_PROP_UINT8("use-non-secure", MicroBlazeCPU, 
cfg.use_non_secure, 0),
      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, 
cfg.dcache_writeback,
                       false),
-    DEFINE_PROP_BOOL("little-endian", MicroBlazeCPU, cfg.endi, false),
+    DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
      /* Enables bus exceptions on failed data accesses (load/stores).  */
      DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
                       cfg.dopb_bus_exception, false),
@@ -387,6 +394,9 @@ static Property mb_properties[] = {
      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
      DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
      DEFINE_PROP_UINT32("pvr-user2", MicroBlazeCPU, cfg.pvr_user2, 0),
+    /*
+     * End of properties reserved by Xilinx DTS conversion tool.
+     */
      DEFINE_PROP_END_OF_LIST(),
  };

---

