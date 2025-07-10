Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA3BC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 11:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZp6E-0007E5-68; Thu, 10 Jul 2025 07:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZp6B-0007BY-MI
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:05:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZp69-0004oQ-GI
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:05:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso559334f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752145551; x=1752750351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUrUNylgxfGzYiFM2vDeDH2gHmeuIo37iKUZUfmdw+4=;
 b=USMvgqUIloWZXpbcvIgdWfBkUeSgx+rZgy50Y1d+SYoWez+cU2sKiMQoeqP9zjQqHY
 pu5WcNSydCFD4IrdjrsseOjkRLfaTacfCat9McKhHRbTlD+zjkCBzs294RnTGWVEYH79
 peN0qHFbrrHtIjSHsNpC4mkky5BMbR+uYAma8b5WH3qMNcN1NQUOMfXJIXGpL2NWtNjS
 eum83+IawaPdjogXclt2saZNGYRTFBZKC4SUr1uwbpuyHzWSRnky+BlzARgJJArAZVGE
 LZx9hGhY0/B0LnxlPgtrFeXwYvx6wGwF2kq3HhwkVGA8vnY+R8E6xkxyshtl8OYAsnCy
 wloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752145551; x=1752750351;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GUrUNylgxfGzYiFM2vDeDH2gHmeuIo37iKUZUfmdw+4=;
 b=lMSv7UMevJ6EVnuNfiPU+zFufU6NFEO9SCZIVERG5tdR/WErGb/ohj7jSbUnhBGFUN
 5XjcYx4wV76zf0+hG0y2kaAx6wj6VzQgTgcp7NKWCYMZIS8eeKzZ5y3QRuKX82apxqqd
 xTNkQix1sYtRV+P3vlUj5HEjyosUs6hiOKgIunAxi9CcarNyJyFJPXFqZa/1QQ2JZCSG
 xTus3JlWGN4J72D4Eid18Bwkr2atuT2lx9UxzJpoE5wTEqAcia/k9jin+C02GUHpFILr
 GDwXTMVNOI2wIlkv86qiv/dCK+MwUBisLprr3KV+W5ZiHhuoqvMusOfUbf/kRArR2SjL
 TWUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNIaZsOTsFTS6zR5xYoYGRTxxnmHjucEdJLG24iIwupmsvxiv8Z46qKPVGXIEDvigpbIOyfFyGEZUj@nongnu.org
X-Gm-Message-State: AOJu0YxXLTz8reu5Vp42v4ooSkeClFmcL3MbYQy6HmQE8iOj0ZZEWWFK
 wNIQK54iRX9jdzex4nWMftPFsiTKWO2+wJ65MviWZGzV5TGxTu3VECNhdPYvFcOZ3hs=
X-Gm-Gg: ASbGnct7B1TWVSNBjb1D94CrhMf82oLmdM8Zztp5pJgCb/W0X5lI7Ir3ZmOWRqkSmw9
 tjYaU+LCbf011nbAqI/5Lh6BsHmIoPObMcIQs5eHyze7yOHam90wFhaCgYv4M+S6jFLnr4lYjFh
 YOQd04xkHdJkY5z451PR1oVdFJGZt6DOX3NToFHXahyGWBscyDxdcFiwpBUxy1tKIGCjqn1N7kq
 7gVkr10rg5i+A0bc+9BLzrWg0WUzMK51ow5LPeWd8kwxTu/ochfWWEv7/91D9bwHMWW0nOZaFhY
 U+GKttVxnmntWH53AYg7NMwafWLBojpBxPElVI/ZPXn5DfiQN9nWRyANEIueDSjgYx4Ktdf7lD/
 5ZYSootsW9Dm8PpXg43RVhqQODE2ID4ueUNgbJWRiJYI=
X-Google-Smtp-Source: AGHT+IGMTXMR3u+VCFr7vLDwX0yvOWj6Q89IIUCAe8AL3av47d5JgaZGLLY3gaKjms9VrTQ3QLkCug==
X-Received: by 2002:a05:6000:2282:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3b5e45430d8mr5051398f8f.54.1752145551485; 
 Thu, 10 Jul 2025 04:05:51 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1a2bsm1609368f8f.14.2025.07.10.04.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 04:05:50 -0700 (PDT)
Message-ID: <695cf9b8-3e5e-4560-9847-688917796648@linaro.org>
Date: Thu, 10 Jul 2025 13:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] hw/i386/isapc.c: replace rom_memory with
 system_memory
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-19-mark.caveayland@nutanix.com>
 <8e9e90f3-eb41-47db-8286-9d96a97c9cac@linaro.org>
Content-Language: en-US
In-Reply-To: <8e9e90f3-eb41-47db-8286-9d96a97c9cac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 10/7/25 12:53, Philippe Mathieu-Daudé wrote:
> On 10/7/25 10:52, Mark Cave-Ayland wrote:
>> Now that we can guarantee the isapc machine will never have a PCI bus, 
>> any
>> instances of rom_memory can be replaced by system_memory and rom_memory
>> removed completely.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/i386/isapc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>> index bb22083821..27c075b5f3 100644
>> --- a/hw/i386/isapc.c
>> +++ b/hw/i386/isapc.c
>> @@ -35,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>>       ISABus *isa_bus;
>>       GSIState *gsi_state;
>>       MemoryRegion *ram_memory;
>> -    MemoryRegion *rom_memory = system_memory;
>>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>       uint32_t irq;
>>       int i;
>> @@ -73,7 +72,7 @@ static void pc_init_isa(MachineState *machine)
>>       /* allocate ram and load rom/bios */
>>       if (!xen_enabled()) {
>> -        pc_memory_init(pcms, system_memory, rom_memory, 0);
>> +        pc_memory_init(pcms, system_memory, system_memory, 0);
> 
> I'd prefer just call here:
> 
>    x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
> 
> and in pc_system_firmware_init(): assert(pcmc->pci_enabled).
> 
> WDYT?

What I have in mind (untested):

-- >8 --
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 27c075b5f32..a7c2146916c 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -74,3 +74,4 @@ static void pc_init_isa(MachineState *machine)
      if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, system_memory, 0);
+        pc_memory_init(pcms, system_memory, NULL, 0);
+        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", system_memory, 
true);
      } else {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b2116335752..2952d3ee4ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -811,3 +811,3 @@ void pc_memory_init(PCMachineState *pcms,
                      MemoryRegion *system_memory,
-                    MemoryRegion *rom_memory,
+                    MemoryRegion *pci_memory,
                      uint64_t pci_hole64_size)
@@ -826,2 +826,3 @@ void pc_memory_init(PCMachineState *pcms,

+    assert(pcmc->pci_enabled ^ !!pci_memory);
      assert(machine->ram_size == x86ms->below_4g_mem_size +
@@ -955,3 +956,5 @@ void pc_memory_init(PCMachineState *pcms,
      /* Initialize PC system firmware */
-    pc_system_firmware_init(pcms, rom_memory);
+    if (pcmc->pci_enabled) {
+        pc_system_firmware_init(pcms, pci_memory);
+    }

@@ -969,3 +972,3 @@ void pc_memory_init(PCMachineState *pcms,
          }
-        memory_region_add_subregion_overlap(rom_memory,
+        memory_region_add_subregion_overlap(pci_memory,
                                              PC_ROM_MIN_VGA,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 821396c16e9..0c29e4188fc 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -221,6 +221,3 @@ void pc_system_firmware_init(PCMachineState *pcms,

-    if (!pcmc->pci_enabled) {
-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
-        return;
-    }
+    assert(pcmc->pci_enabled);

---

