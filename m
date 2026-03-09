Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE88FCA19A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziye-0007nc-Dl; Mon, 09 Mar 2026 18:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vziyb-0007mm-Ln
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:21:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vziya-0007x1-2e
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:21:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so31414905e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773094881; x=1773699681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3cd9xy6/nLkzQC9860/bKo4IztW7zrPtLypSBqELmFw=;
 b=dkgkBaUb8vySO9ME1PZRWkozm/qdeZWJj/SLTeBNGFssBU/rOWn8/0/UAXE7GVaxlm
 JUhtU1/Ic9VEAfHkXdq92peodVQ1daY/fdag84LGozIKCWc/UjkOOOfUTO5MUK6r+QNH
 5Z78xNNPcmxlVizF9C/JoXG+2WMhjeJlD9UXl3+jDNLEGkCnwlo4S8uyVWX9eILPE3Yj
 xXUsm8reEbXeg3CiKEq7iNLFSGbOMXtISROa1yDk4W/leAqL95CuK6QsAou9w+jo4wNS
 360TwvH6zJSSFr726HGwlXTbPezYpupMZdcViKQDzJkK2IZ0UwYIbAhSkZ8FM3S3kjn+
 UElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773094881; x=1773699681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cd9xy6/nLkzQC9860/bKo4IztW7zrPtLypSBqELmFw=;
 b=dG/u+8CbyEXfsCsYaTGlOHjbMipFcnEyrlc49dG1JUaatCCTtBw9Q0NMBK1qBJBALn
 2ZtB9BFhGTHsNDXYW+VhPj2AMLsY77ayrCdq4eRaEMgEWixDZZJ5zvoDTNfVrfBu32n7
 vduDi9EbqhrJ4/3WfqaXIL4OOJ99spkfaFGGN3gGdCDpQsTjPOKGvS9Z0LJqxfnTi1R6
 tLNQxq38YPwKg+El9NbV3firZxxD5qbJ/6zmJOXzwgimwTXJqmuhQfOT+Hm86q2EXbTL
 PXgaOMJSeVsZJkXIusRRwdzzwEI0oiJw1Lcj9MLmEtTtdyfox7qUGNDwVx4tEbdi0NrF
 rfhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg+aP5tGxgFoOgBhiSddNFk58VtOdovvFzHAzCqYf1uVuMxHYOkUAxrhQUtseaOKqj7RKSzqQdcuOx@nongnu.org
X-Gm-Message-State: AOJu0Yx3UYEVzIl7bbCepGhzrKxM1lsuhem5dQoIQY95Zh7gKsv043gs
 C8D9een//W8v9shiFkZ4jio81bI2kxoDHBz2dmNGAnr41FcxB83CYLkugNltSJtZuEM=
X-Gm-Gg: ATEYQzz8PcB+P2h47vkWxs+yWivES/Qm2OZz9B5RcjEebXFqWj5XD0bn1pv3p5d3nBT
 hEKsafsUh67rv+L1paIWIbooBs/saWhbHDDksbkM5uNVrSiDJPRn4BDLn32b47xTNsULv/6tcNW
 Kb6CgL2sry9KMKyG+PXwtPtejf2TaB+jZB1jrt6OiJEfQ1DsJNFAMNqR6cjODIgcADTDphO/ORa
 thEKPi6OvktRCp+3ZHXo2SWentSPrV+ghqIaKxtw4pjRxZaqdKvJUihRqMC2iEcNqUwwmn2Az8/
 x/Zq8f6p91172JSX1KuJhh83W4+sFk8dFJu8UsdHqVKl0ruDI9f7XNEuJNjfNVNUncbCMtC2Qh7
 umN8SQWCpZ1cy0s0V8yRorZ1ZQWUhbpJYPcWDu2NcocoQnJY0r7TqlafXEV5BBpTEfcXMmQMLoC
 tGsJQxpk1K+mesuN4XAkP1l1Qalpo35lLi9FC8bTGckdoKq59D7IJCWb/7XgQpXPB0mQ==
X-Received: by 2002:a05:600c:4e4f:b0:485:3a27:a960 with SMTP id
 5b1f17b1804b1-4853f4214fcmr53168945e9.0.1773094881531; 
 Mon, 09 Mar 2026 15:21:21 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9c293sm19648095e9.10.2026.03.09.15.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 15:21:20 -0700 (PDT)
Message-ID: <a24c76d0-4106-4d49-b032-35f7f6310e69@linaro.org>
Date: Mon, 9 Mar 2026 23:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] vmapple: apple-gfx: make it work on the latest
 macOS release
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Alexander Graf <agraf@csgraf.de>
References: <20260306145246.10274-1-mohamed@unpredictable.fr>
 <20260306145246.10274-2-mohamed@unpredictable.fr>
 <8908689a-f5c1-490e-925d-7a664093963f@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8908689a-f5c1-490e-925d-7a664093963f@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

+Peter/Paolo

On 7/3/26 04:08, Akihiko Odaki wrote:
> On 2026/03/06 23:52, Mohamed Mediouni wrote:
>> Follow changes in memory management introduced on macOS 15.4.
>>
>> The legacy memory management API has been removed for the IOSurface 
>> mapper on that macOS version.
>>
>> Also enable process isolation for a sandboxed GPU process when on a 
>> new OS.
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>   hw/display/apple-gfx-mmio.m | 62 ++++++++++++++++++++++++++++---------
>>   hw/display/apple-gfx.h      | 18 +++++++++++
>>   hw/display/apple-gfx.m      | 43 ++++++++++++++++++++++++-
>>   3 files changed, 107 insertions(+), 16 deletions(-)


>> diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>> index e0a765fcb1..92404d20bf 100644
>> --- a/hw/display/apple-gfx.m
>> +++ b/hw/display/apple-gfx.m
>> @@ -21,6 +21,7 @@
>>   #include "system/address-spaces.h"
>>   #include "system/dma.h"
>>   #include "migration/blocker.h"
>> +#include "system/memory.h"
>>   #include "ui/console.h"
>>   #include "apple-gfx.h"
>>   #include "trace.h"
>> @@ -596,6 +597,37 @@ void apple_gfx_common_init(Object *obj, 
>> AppleGFXState *s, const char* obj_name)
>>       /* TODO: PVG framework supports serialising device state: 
>> integrate it! */
>>   }
>> +@interface PGDeviceDescriptor (IOSurfaceMapper)
>> +@property (readwrite, nonatomic, copy, nullable) 
>> PGMemoryMapDescriptor* memoryMapDescriptor;
>> +@end
>> +
>> +bool apple_gfx_register_memory_cb(Int128 start, Int128 len,
>> +                                  const MemoryRegion *mr_const,
>> +                                  hwaddr offset_in_region, void 
>> *opaque) {
>> +    MemoryRegion *mr = (MemoryRegion *)mr_const;
> 
> flatview_for_each_range() should be changed to pass non-const pointers 
> instead.

flatview_for_each_range() was added in commit fb5ef4eeecd ("memory: Add
FlatView foreach function") with memory fuzzing in mind, so const MR was
the correct choice then IMO.

FlatView is more of an internal memory API, I'm not sure it should be
used by hw/ layer.

$ git grep -w flatview_for_each_range
hw/core/loader.c:1656:    flatview_for_each_range(fv, find_rom_cb, &cbdata);
semihosting/arm-compat-semi.c:158:    flatview_for_each_range(fv, 
find_ram_cb, &info);
tests/qtest/fuzz/generic_fuzz.c:310: 
flatview_for_each_range(view, get_io_address_cb , &cb_info);

Semihosting is special, as it the ROM loader helper, and fuzzing code.


We provide MemoryRegionSection, MemoryListener and RamDiscardListener
APIs. Maybe one of them is more appropriate here? See:

  * A #RamDiscardManager coordinates which parts of specific RAM
  * #MemoryRegion regions are currently populated to be used/accessed
  * by the VM, notifying after parts were discarded (freeing up memory)
  * and before parts will be populated (consuming memory), to be used/
  * accessed by the VM.

Could this be what this code needs to do?

> Regards,
> Akihiko Odaki
> 
>> +    PGGuestPhysicalRange_t range;
>> +    PGMemoryMapDescriptor *memory_map_descriptor = opaque;
>> +    if (memory_access_is_direct(mr, true, MEMTXATTRS_UNSPECIFIED)) {
>> +        range.physicalAddress = start;
>> +        range.physicalLength = len;
>> +        range.hostAddress = memory_region_get_ram_ptr(mr);
>> +        [memory_map_descriptor addRange:range];
>> +        memory_region_ref(mr);
>> +    }
>> +    return false;
>> +}
>> +
>> +static void apple_gfx_register_memory(AppleGFXState *s,
>> +                                                     
>> PGDeviceDescriptor *desc)
>> +{
>> +    PGMemoryMapDescriptor* memoryMapDescriptor = 
>> [PGMemoryMapDescriptor new];
>> +
>> +    FlatView* fv = address_space_to_flatview(&address_space_memory);
>> +    flatview_for_each_range(fv, apple_gfx_register_memory_cb, 
>> memoryMapDescriptor);
>> +
>> +    desc.memoryMapDescriptor = memoryMapDescriptor;
>> +}

