Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A224BE6F086
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 20:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6yXX-0007k8-A1; Fri, 01 Nov 2024 16:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6yXU-0007j9-BP
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:46:36 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6yXS-0003LV-BY
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 16:46:36 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so2002350a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730493992; x=1731098792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WiMHInHZO3dGDguQrhtZ6hSTe8/x5FLMH5baEmYalNQ=;
 b=HJvTv7T5jHE/Ow0BjOVbPr7f82DUJ9FGjdR2zaQqjCWaGsSbGD73xhohi6Ab5ZJV3h
 uYE/94KjeRrmybRP9yQ0NPZqgE5FCFMdePdvnN222hfqH/urih8KdRzn4L1OVYy/jgqE
 18R+pBHOENLkkMBXQ/wW6V9AVhqAViGgghrsSJh3GdvNpfEWHH/QO2rAYcenaWGRapMM
 5PcGJNcpA1SOEAGX231xtKK6uVGiMZQQ1+gzfXpfihRwv22+KuGWvOtEYo80/WDDoJAV
 7ciNz2iM/bK0D3ctCzUEI1yC1Tg31ZAEBe2HWcw19JcEoA34Abx/efbiFczJ6IRMOJHJ
 54pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730493992; x=1731098792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WiMHInHZO3dGDguQrhtZ6hSTe8/x5FLMH5baEmYalNQ=;
 b=XapZZ0RcPmSGKb5ykcU4eiNV/bzTZaV4Bt0YlOjHRUs9YrHYK5gcs1JeThLCRfDMzP
 9KUvy9wM64soR0Chpms4wUub3+3OnVRTE242cHCzFP4rZatOwNYnsyBkSvQnlcM/GwnG
 A7YHzK2xoiPjcy9dUvMihSgHePDSE2a6Z2wQtCSEWj9DYy9mB7yX4cfkKS9EG+XMni0w
 0FeKSMYrFCUfkyU+8yKsKfizuINp8elTHwooPs9tq8eZNR7T/kuyxNxJpjCRgcKOzpVQ
 SzVfaaR8naWVrro2k8TOjcF/2sXSW7PJOtNlqN1TOWTzCZ3awb5/mMZxSBqW9Ig0TTM6
 TWEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU8Pof9QBjFyhlGIGJ1H4uWRfJpbjTg60FZ01cVUVQZjVd4/aGc6xwMNsPSGIMQgqEJ9+hQjCcGDdw@nongnu.org
X-Gm-Message-State: AOJu0YzCSnn3uMb7PCc1YOS2N3mKeOiDe2SrxjjmHx942ccsPXPEn1Gn
 cXmeJ8p1dxfT+h4hGhtQNpqWsCR1SEGnwuHb0smWtuQ6h76+Z7nUQfl7a7C3HpM=
X-Google-Smtp-Source: AGHT+IHCU9R4Lv9BuN1bUV21JUCtjNjOs5TJNPpGpGyXIyuDDnAqGpEGoangreh/XB9NA6uyCv4rvQ==
X-Received: by 2002:a17:90b:28c4:b0:2e2:c7f8:8ba8 with SMTP id
 98e67ed59e1d1-2e94c53c34cmr5398766a91.40.1730493992500; 
 Fri, 01 Nov 2024 13:46:32 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93dab27a8sm3169018a91.22.2024.11.01.13.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 13:46:32 -0700 (PDT)
Message-ID: <e23a19e8-3755-4fc3-8789-eca2af97104f@ventanamicro.com>
Date: Fri, 1 Nov 2024 17:46:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: fix build error with clang
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
 <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
 <CAFEAcA92CuvGUJQk5LFE1X3a8dH21ksE_QXETjVPnU3v1bVSzw@mail.gmail.com>
 <fd9ee34a-24e1-43fb-950b-aba585473085@ventanamicro.com>
 <CAFEAcA_SYAC_UsEs+xy7aZEHsA1bC0umnsAF5ZmtjmZKEVSA+Q@mail.gmail.com>
 <CAH2o1u4ZAkH-bWN8SRkNj8-n9i3NtJpodopUpQyE=pwO5mKkDw@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAH2o1u4ZAkH-bWN8SRkNj8-n9i3NtJpodopUpQyE=pwO5mKkDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52c.google.com
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



On 11/1/24 4:23 PM, Tomasz Jeznach wrote:
> On Fri, Nov 1, 2024 at 11:49 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Fri, 1 Nov 2024 at 18:13, Daniel Henrique Barboza
>> <dbarboza@ventanamicro.com> wrote:
>>>
>>> (Ccing Tomasz)
>>>
>>> On 11/1/24 2:48 PM, Peter Maydell wrote:
>>>> On Fri, 1 Nov 2024 at 17:36, Daniel Henrique Barboza
>>>> <dbarboza@ventanamicro.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 11/1/24 2:08 PM, Pierrick Bouvier wrote:
>>>>>> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>>>>>>
>>>>>> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>>>>>>
>>>>>>      187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>>>>>
>>>>>>          |                 ^
>>>>>>
>>>>>> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
>>>>>>
>>>>>>      217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>>>>>>
>>>>>>          | ^
>>>>>>
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>> ---
>>>>>>     hw/riscv/riscv-iommu.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>>>>>> index feb650549ac..f738570bac2 100644
>>>>>> --- a/hw/riscv/riscv-iommu.c
>>>>>> +++ b/hw/riscv/riscv-iommu.c
>>>>>> @@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>>>>>>     }
>>>>>>
>>>>>>     /* Portable implementation of pext_u64, bit-mask extraction. */
>>>>>> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>>>>> +static uint64_t pext_u64(uint64_t val, uint64_t ext)
>>>>>
>>>>> I suggest name it 'riscv_iommu_pext_u64' to be clear that this is a local scope function,
>>>>> not to be mistaken with anything available in clang or any other compiler.
>>>>
>>>> More generally, we should avoid using leading '_' in QEMU function
>>>> names; those are reserved for the system.
>>>>
>>>> Also, what does this function do? The comment assumes that
>>>> the reader knows what a "pext_u64" function does, but if you
>>>> don't then it's fairly inscrutable bit-twiddling.
>>>> "bit-mask extraction" suggests maybe we should be using
>>>> the bitops.h extract functions instead ?
>>>
>>> This is the function:
>>>
>>>
>>> /* Portable implementation of pext_u64, bit-mask extraction. */
>>> static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>> {
>>>       uint64_t ret = 0;
>>>       uint64_t rot = 1;
>>>
>>>       while (ext) {
>>>           if (ext & 1) {
>>>               if (val & 1) {
>>>                   ret |= rot;
>>>               }
>>>               rot <<= 1;
>>>           }
>>>           val >>= 1;
>>>           ext >>= 1;
>>>       }
>>>
>>>       return ret;
>>> }
>>
>> Yes, but what does it actually *do* ? :-)  Presumably
>> it extracts some subpart of 'val' based on 'ext', but
>> what is the format it expects 'ext' to be in, and what
>> kinds of input are valid?
>>
>> For comparison, our extract64 function says:
>>
>>   * extract64:
>>   * @value: the value to extract the bit field from
>>   * @start: the lowest bit in the bit field (numbered from 0)
>>   * @length: the length of the bit field
>>   *
>>   * Extract from the 64 bit input @value the bit field specified by the
>>   * @start and @length parameters, and return it. The bit field must
>>   * lie entirely within the 64 bit word. It is valid to request that
>>   * all 64 bits are returned (ie @length 64 and @start 0).
>>
>> so even if you haven't come across it before you can see
>> what the function is intended to do, what inputs are valid
>> and what are not, and so on, and you don't need to try to
>> reverse-engineer those from the bit operations.
>>
>> I'm not necessarily opposed to having separate implementations
>> of these things if it means the code follows the architectural
>> specifications more closely, but if we do have them can
>> we have documentation comments that describe the behaviour?
>>
> 
> Hey,
> 
> Thank you for the fix. Using a common name and underscore was not a good idea ;)
> The function is an implementation of the bit extraction function as
> documented in RISC-V IOMMU Spec [1], section '2.3.3. Process to
> translate addresses of MSIs'.
> 
> It is also known as PEXT instruction in x86/AVX2 architecture, for
> non-contiguous bits extraction, that's why I've used this name, as it
> might be more familiar to the readers, and to avoid confusion with
> existing extract64() function in bitops.h.
> 
> 
> [1] link: https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0

Thanks for clarifying!


Pierrick, I copied the description of this function from the riscv-isa spec
and put in a comment. This is how it would look like:

$ git diff
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index feb650549a..969eb56c53 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -183,8 +183,25 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
      }
  }
  
-/* Portable implementation of pext_u64, bit-mask extraction. */
-static uint64_t _pext_u64(uint64_t val, uint64_t ext)
+/*
+ * Discards all bits from 'val' whose matching bits in the same
+ * positions in the mask 'ext' are zeros, and packs the remaining
+ * bits from 'val' contiguously at the least-significant end of the
+ * result, keeping the same bit order as 'val' and filling any
+ * other bits at the most-significant end of the result with zeros.
+ *
+ * For example, for the following 'val' and 'ext', the return 'ret'
+ * will be:
+ *
+ * val = a b c d e f g h
+ * ext = 1 0 1 0 0 1 1 0
+ * ret = 0 0 0 0 a c f g
+ *
+ * This function, taken from the riscv-iommu 1.0 spec, section 2.3.3
+ * "Process to translate addresses of MSIs", is similar to bit manip
+ * function PEXT (Parallel bits extract) from x86.
+ */
+static uint64_t riscv_iommu_pext_u64(uint64_t val, uint64_t ext)



Feel free to take this diff and squash it in your v2. This way we'll fix the clang
issue and put some docs in the function, a 2 for 1.


Thanks,

Daniel


> 
> Hope this helps,
> - Tomasz
> 
>> thanks
>> -- PMM

