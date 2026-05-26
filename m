Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63936CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyKY-0005fN-5M; Tue, 26 May 2026 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyKV-0005fD-Vm
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:24:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyKT-0007Cc-Bz
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:24:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso54566455e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827082; x=1780431882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AndsXZIjubLff4r9OsiWoaXTmnLkljpauh3JUZQTkdo=;
 b=PCy38TDlM06zfI2FXlCZQKXFn/kcoVffr8SLwbAgJvWR8wCvrpf08P0dy1335FJGyz
 Vl8wG+wdMyh06rTRDh5/6Xp9350DHTv9ifKH99/BHR8sJ9iaLPIEeVUzw48IgHXo7o5n
 2y7atLVjagnDbhmh3lxAjJvgG4eUiQaWmFe43ZciQRSEIcF/4ukbBeWJppdxYg0mjk9C
 Cxo46l3+GDhrIujJuNavKE08PJnEScYGeuraJBqUpAYN+irPpXWIDjVdiJomJW7S1cFF
 1PHs33sJ5X5BqLV+qmUNKjJvHwNzxeNFqgOR4KpviD9VKEaLLbOgMDwX59NS37bfcMut
 07Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827082; x=1780431882;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AndsXZIjubLff4r9OsiWoaXTmnLkljpauh3JUZQTkdo=;
 b=aphMRSqpRPiSvCWxF23/avasA3M6ArHC2yrTmBGq6hxGj0dxqOGXQlYzWCrOqAEv0i
 tkBMPhiNXBpj8XjhYt97WmvKIwGLqqUDy65ReUynosQZPVvEq2Ie4k9DCfVjYmrp9uSo
 8itWdaPWgLLge2X2geYfeplCN65EgyAUTzDt7Y5SE6ohOF20ZZWXVs9zYlnuanRkBzAG
 4jI+R0K5E57262V/q31Vki+XX9IUceQdy+hItDNK8kevrX2JMfX4OLDrEqLhuHAO9aaP
 oh7Q/KfiZWTJpvWpIiIpdkffuOCidZLhE4SX09v+HZRM9hwKVbZsb/oOYhfZaO0MqZM2
 1zCg==
X-Gm-Message-State: AOJu0Yy6Poq6vNzFNpfkRhRvUWiI18q0PAj+bFRuulDPMkDqn7IJ0gwu
 0Pl6Kj8KzKysu3mLk+0453Zko3gtL11/6SJpafSiikwgerymhfiOlQJQeb11/aWhb3w=
X-Gm-Gg: Acq92OEDQb7Jbr7IAYPkJ37CeZ3E8OZKBXGPP9ymuD+OCEyxZ+ueCeMrZ4x2AlMnNUA
 CEAdFClHECMZSjwi16DNVqmECVD5W5sa+Tt7Ejaw/rscLB0KHuXDFUX7duZHGfkgXe9pvN4Aycc
 SJ1Oi5X5a4r6FPF9SGqlj18JGtBTUrUZlriRZuYSy/OTbJeONXpMEILxZAOVDhv7kxbE9zVYfBi
 cAT52/IDvJnQUJ+pMYqSG4A1Y2kkacHFjzY4T4rjy61zP/v28WY72LREyip/9LkLqM/SS9akRE2
 8UhSqvpDaCzKPG7ZtPOWkwiDDclwHMsmH4d3M7Q4MsGI6lTBFai7TDPLhgrW6PbS/Q859ltG/FZ
 Ur8ieP31a0AzOS8qF6A3DTTvkWVQ0NgRzwUNcfqom7c3GbyjnhKVRK92DK7K9O9GBivg/iqYVog
 eFu1gXpRqKU3ckOLQ67YJ5Sdu89k+L7vOsYBUVC4sNp6rntyXbuXX2HFrB4udzHn2laxjQbblCg
 kRQ
X-Received: by 2002:a05:600c:1d9a:b0:490:5cb3:e93f with SMTP id
 5b1f17b1804b1-4905cb3ec51mr200872275e9.2.1779827081992; 
 Tue, 26 May 2026 13:24:41 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm620002755e9.1.2026.05.26.13.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 13:24:41 -0700 (PDT)
Message-ID: <a50cad08-56d4-49db-ac14-2ad588617420@linaro.org>
Date: Tue, 26 May 2026 22:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_tis_sysbus: move PPI memory region setup to realizefn
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mohammadfaiz Bawa <mbawa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260526164716.689664-1-mbawa@redhat.com>
 <CAFEAcA-+VDZ+6Z2ZfRmcsYFa9jg-66q7T60Pcf9ZKBeMUfFG+Q@mail.gmail.com>
 <CAJg9Kkw8FLUS7dqxbm04yBHW84TM-cF9TpMVE6sJMkfLJ2f=dg@mail.gmail.com>
 <aa810589-f2ab-43ac-a3a9-7717d06df92d@linaro.org>
 <ae5c24c8-fa04-4368-8baf-9d56762c64cd@linaro.org>
In-Reply-To: <ae5c24c8-fa04-4368-8baf-9d56762c64cd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/5/26 22:16, Philippe Mathieu-Daudé wrote:
> +Paolo/Peter
> 
> On 26/5/26 21:45, Philippe Mathieu-Daudé wrote:
>> +Richard/Pierrick
>>
>> On 26/5/26 20:07, Mohammadfaiz Bawa wrote:
>>> On Tue, May 26, 2026 at 11:13 PM Peter Maydell 
>>> <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Tue, 26 May 2026 at 17:49, Mohammadfaiz Bawa <mbawa@redhat.com> 
>>>> wrote:
>>>>>
>>>>> memory_region_init_ram_device_ptr() requires the target page
>>>>> size to be finalized, which has not happened during
>>>>> instance_init. Calling it from tpm_tis_sysbus_initfn() causes
>>>>> an assertion failure when the device is introspected without
>>>>> being realized, for example:
>>>>>
>>>>>    $ qemu-system-aarch64 -device tpm-tis-device,help
>>>>>    qemu-system-aarch64: ../system/physmem.c:2524:
>>>>>    qemu_ram_alloc_internal:
>>>>>    Assertion 'target_page.decided' failed.
>>>>>    Aborted (core dumped)
> 
> I can not reproduce this error, however en macOS this command triggers:
> 
> (lldb) bt
> * thread #1, queue = 'com.apple.main-thread', stop reason = hit program 
> assert
>      frame #0: 0x000000019c642388 libsystem_kernel.dylib`__pthread_kill + 8
>      frame #1: 0x000000019c67b848 libsystem_pthread.dylib`pthread_kill + 
> 296
>      frame #2: 0x000000019c584b50 libsystem_c.dylib`abort + 124
>      frame #3: 0x000000019c583d84 libsystem_c.dylib`__assert_rtn + 284
>    * frame #4: 0x0000000100a3870c qemu-system- 
> aarch64`qemu_mutex_lock_impl.cold.1 at qemu-thread-posix.c:107:5
>      frame #5: 0x0000000100981e78 qemu-system- 
> aarch64`qemu_mutex_lock_impl(mutex=<unavailable>, file=<unavailable>, 
> line=<unavailable>) at qemu-thread-posix.c:107:5
>      frame #6: 0x0000000100345d08 qemu-system- 
> aarch64`qemu_mutex_lock_ramlist at physmem.c:1454:5
>      frame #7: 0x0000000100345ce4 qemu-system- 
> aarch64`ram_block_add(new_block=0x0000000133104f10, 
> errp=0x000000016fdfe650) at physmem.c:2161:5
>      frame #8: 0x0000000100346c34 qemu-system- 
> aarch64`qemu_ram_alloc_internal(size=16384, max_size=16384, 
> resized=0x0000000000000000, host=0x000000013380c000, ram_flags=1, 
> mr=0x000000013380a910, errp=0x0000000101c37c20) at physmem.c:2540:5
>      frame #9: 0x00000001003469c8 qemu-system- 
> aarch64`qemu_ram_alloc_from_ptr(size=<unavailable>, host=<unavailable>, 
> mr=<unavailable>, errp=<unavailable>) at physmem.c:2552:12 [artificial]
>      frame #10: 0x000000010033b56c qemu-system- 
> aarch64`memory_region_set_ram_ptr(mr=0x000000013380a910, size=1024, 
> ptr=0x000000013380c000) at memory.c:1664:20 [inlined]
>      frame #11: 0x000000010033b550 qemu-system- 
> aarch64`memory_region_init_ram_device_ptr(mr=0x000000013380a910, 
> owner=<unavailable>, name=<unavailable>, size=1024, 
> ptr=0x000000013380c000) at memory.c:1684:5
>      frame #12: 0x00000001002ca594 qemu-system- 
> aarch64`tpm_tis_sysbus_initfn(obj=0x0000000133809400) at 
> tpm_tis_sysbus.c:114:5
>      frame #13: 0x00000001007e8e58 qemu-system- 
> aarch64`object_initialize_with_type(obj=0x0000000133809400, size=5680, 
> type=0x0000000131f4e250) at object.c:504:5
>      frame #14: 0x00000001007e964c qemu-system- 
> aarch64`object_new_with_type(type=0x0000000131f4e250) at object.c:707:5
>      frame #15: 0x00000001007e95fc qemu-system- 
> aarch64`object_new_with_class(klass=<unavailable>) at object.c:716:12 
> [artificial]
>      frame #16: 0x00000001008ca264 qemu-system- 
> aarch64`qmp_device_list_properties(typename="tpm-tis-device", 
> errp=0x000000016fdfe8a0) at qom-qmp-cmds.c:206:11
>      frame #17: 0x000000010034c7a0 qemu-system- 
> aarch64`qdev_device_help(opts=<unavailable>) at qdev-monitor.c:315:17
>      frame #18: 0x000000010033179c qemu-system- 
> aarch64`device_help_func(opaque=<unavailable>, opts=<unavailable>, 
> errp=<unavailable>) at vl.c:1209:12 [artificial]
>      frame #19: 0x000000010098aa10 qemu-system- 
> aarch64`qemu_opts_foreach(list=<unavailable>, func=(qemu-system- 
> aarch64`device_help_func at vl.c:1208), opaque=0x0000000000000000, 
> errp=0x0000000000000000) at qemu-option.c:1148:14
>      frame #20: 0x000000010032d45c qemu-system- 
> aarch64`qemu_process_help_options at vl.c:2642:9 [inlined]
>      frame #21: 0x000000010032d408 qemu-system- 
> aarch64`qemu_init(argc=<unavailable>, argv=0x000000016fdff148) at 
> vl.c:3738:5
>      frame #22: 0x00000001008dcef8 qemu-system- 
> aarch64`main(argc=<unavailable>, argv=<unavailable>) at main.c:71:5
>      frame #23: 0x000000019c2dab98 dyld`start + 6076
> 
>>>>>
>>>>> Property introspection only calls instance_init, never
>>>>> realizefn, so moving the memory region setup to realizefn
>>>>> avoids the crash while keeping the device fully functional
>>>>> when actually used in a VM.
>>>>>
>>>>> Move the PPI buffer allocation, memory_region_init_ram_device_ptr()
>>>>> and the corresponding sysbus_init_mmio() from
>>>>> tpm_tis_sysbus_initfn() to tpm_tis_sysbus_realizefn(), placing
>>>>> them just before the existing vmstate_register_ram() call.
>>>>>
>>>>> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
>>>>> ---
>>>>>   hw/tpm/tpm_tis_sysbus.c | 13 ++++++-------
>>>>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
>>>>> index 6bec30c36f..33fe9e332c 100644
>>>>> --- a/hw/tpm/tpm_tis_sysbus.c
>>>>> +++ b/hw/tpm/tpm_tis_sysbus.c
>>>>> @@ -100,7 +100,6 @@ static void tpm_tis_sysbus_initfn(Object *obj)
>>>>>   {
>>>>>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
>>>>>       TPMState *s = &sbdev->state;
>>>>> -    size_t host_page_size = qemu_real_host_page_size();
>>>>
>>>> This is asking about the host page size, so why does it wind up
>>>> asserting about the target page size not being fixed ?
>>>>
>>>> thanks
>>>> -- PMM
>>>
>>> The host_page_size line itself doesn't cause the crash -
>>> qemu_real_host_page_size() is safe to call anywhere. It was
>>> moved simply because it has no other consumers in initfn.
>>>
>>> The actual crash comes from memory_region_init_ram_device_ptr()
>>> - which calls qemu_ram_alloc_internal(). In there, line 2522
>>> evaluates TARGET_PAGE_SIZE: align = MAX(align, TARGET_PAGE_SIZE);
>>>
>>> With CONFIG_DEBUG_TCG, TARGET_PAGE_SIZE expands through
>>> TARGET_PAGE_MASK which contains: assert(target_page.decided)
>>>
>>> That's where it blows up: the target page size hasn't been
>>> finalized yet during instance_init.

When a realize() can fail, deferring resources allocation to it
(after checking any failure) is indeed preferred pattern (but it
should come with these resources being released in a unrealize
handler, which this file lacks -- pre-existing).

With that in mind I'd also move tpm-tis-mmio allocation:

-- >8 --
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 6bec30c36fc..aae9ffd8392 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -102,7 +102,2 @@ static void tpm_tis_sysbus_initfn(Object *obj)
      TPMState *s = &sbdev->state;
-    size_t host_page_size = qemu_real_host_page_size();
-
-    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
-                          s, "tpm-tis-mmio",
-                          TPM_TIS_NUM_LOCALITIES << 
TPM_TIS_LOCALITY_SHIFT);

@@ -111,6 +106,2 @@ static void tpm_tis_sysbus_initfn(Object *obj)

-    s->ppi.buf = qemu_memalign(host_page_size,
-                                ROUND_UP(TPM_PPI_ADDR_SIZE, 
host_page_size));
-    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
-                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
@@ -122,2 +113,3 @@ static void tpm_tis_sysbus_realizefn(DeviceState 
*dev, Error **errp)
      TPMState *s = &sbdev->state;
+    const size_t host_page_size = qemu_real_host_page_size();

@@ -133,2 +125,10 @@ static void tpm_tis_sysbus_realizefn(DeviceState 
*dev, Error **errp)

+    s->ppi.buf = qemu_memalign(host_page_size,
+                               ROUND_UP(TPM_PPI_ADDR_SIZE, 
host_page_size));
+    memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
+                          s, "tpm-tis-mmio",
+                          TPM_TIS_NUM_LOCALITIES << 
TPM_TIS_LOCALITY_SHIFT);
+
+    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
+                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
      vmstate_register_ram(&s->ppi.ram, dev);
---

At any rate the commit description has to be reworded.

