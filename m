Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A963CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VmB-0004rY-O4; Tue, 30 Sep 2025 04:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vm9-0004r7-4B
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:31:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vlu-0003fX-2Y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:31:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso35954905e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759221096; x=1759825896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPblYzRdSvAbjbwbh03+CbSDEcFIuNHCFm6Gcm76lBw=;
 b=LjlP9j+5y/pcofGW/of2tpD+AAcYq+p9jqeJ7eDmhf6SnDG3JnztGE2W/oDOIhyZmQ
 MUSXgVbVeWfh7yJtxmAAOKmQwfmPAKWZik7iYJZdOH1nH18XoWWtrCCSrnMn71Vvb7oi
 uCAHe5eSrG/pekKyzOd/pO34BPiXQUVt3T2+fHfvrjeKHAR6ja+ZzCA/XNlnXqrlK+L1
 96dQ1sfaKTqIA3Vheqbn4YpyaL8YnSyHa5chj2CzDqDfj6w6fb6NVyh2LRs2twEL2neA
 XFDXHQxeoqFnHTpGExbTKCDYVb3NI1Q+J0nqz5q/IGNqlFNcv/jvmo4/hjlguSxB99CM
 p7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759221096; x=1759825896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPblYzRdSvAbjbwbh03+CbSDEcFIuNHCFm6Gcm76lBw=;
 b=YktO9D6v6NTPcYEF4/3I7YM7ABaVJSusF7lHbvQX4VKeamgPVTwwEyLlnXOZUpInG2
 yxofPdsE4V8s6ANWH8RRkQSY04D9UYdPp/BMbiZ05WZufwl+m+ulAiywAk6nLcDGnSP1
 UrBIVdYVuN8IvptBU3J8ix+SyT2+f23/M6KLYJFHN7gBH7dT+bPsS6OTpKk89ONj/q2J
 yWDVVqY5ASzKAoi5ckO2HCPBlbToO0f3ikrnqiXvkaGsaiZrzIakArPApZy+CZOAMHLx
 px19UX3s9K2RxG1YVLxConTKiaJ9dcyi06/ZwmXjq7Ep90gtEFiIODfZMl8U3WuLiWm9
 tR9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF/pnBPYypKKjffJ7SkoRAjaYEv/J0y3Ht8ACaUWDju8KjUKiNw1N13nk1J1ZubaBi+SySChMtC1IZ@nongnu.org
X-Gm-Message-State: AOJu0YwAd+fNSo5Aow2ytHRVJFK5I3h/zKmJqvOUHq9cv5taMY8ztNVK
 dZDaWgDCZDgGOBp5Avh7U7apamwL72p6RKGWVIONdT2lwVUFulohKpFsJN6YRaEc+tU=
X-Gm-Gg: ASbGnctgrvjcYAjg+lkvWOpS7UQL+U7J6zEAFGnqTOtA/Q7Lto0Rezr8sdFk/jaMG02
 919UOedg7SFsLqWFsHPe1iWlJEH1Mw61VjEv+EaCp/POj1NdKNsr3Df3vg0TjYkSBru3yYRNQh4
 snWGj6ozdKEYAU2H/P6VkX9tESQNCREqcHp0Sdii2zpPKwxJuKMaO828DVlBx60Qt0LQ02WHuBP
 d+JKc1B3PO6tSxWXJOoCC6zcUzGYY8T0Xs04G8vBYlaSSzyXmhg5fyCefv913EHvjdoUBUoQZWD
 i4H9VdONJmF2dQiQlFAYsUcN5OfbOtToEcCalsXFj/H5w0SMxbV2nclq/n4RXN4w/1n/j9XGWCk
 +iY5KRR/ytNJEWDbjdeSh1mrgKlrNjNEId7kfV9qZt3oC+NOH5y5mBQr5C/X4pBgcti3aeTubSn
 x9EBE9f85wWdesng==
X-Google-Smtp-Source: AGHT+IF0LgtI7pDkBA/eYAeHLSMtAuwN7D6X/YI2HPPLpuFu6atvuEp5p5mznrjKdUvD2ZsGu34EiA==
X-Received: by 2002:a05:6000:2385:b0:405:8ef9:ee6e with SMTP id
 ffacd0b85a97d-40e4a8f9b38mr19131448f8f.25.1759221095990; 
 Tue, 30 Sep 2025 01:31:35 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc749b8f9sm21268471f8f.50.2025.09.30.01.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 01:31:35 -0700 (PDT)
Message-ID: <ededf937-5424-4cf7-8ea1-e07709db27f1@linaro.org>
Date: Tue, 30 Sep 2025 10:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] system/memory: Better describe @plen argument of
 flatview_translate()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Jason Herne
 <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-3-philmd@linaro.org>
 <525dd07f-ae64-4ba7-b3ec-b9fcd86aa8a5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <525dd07f-ae64-4ba7-b3ec-b9fcd86aa8a5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

Hi Thomas,

On 30/9/25 10:24, Thomas Huth wrote:
> On 30/09/2025 10.21, Philippe Mathieu-Daudé wrote:
>> flatview_translate()'s @plen argument is output-only and can be NULL.
>>
>> When Xen is enabled, only update @plen_out when non-NULL.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/system/memory.h | 5 +++--
>>   system/physmem.c        | 9 +++++----
>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index aa85fc27a10..3e5bf3ef05e 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -2992,13 +2992,14 @@ IOMMUTLBEntry 
>> address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>>    * @addr: address within that address space
>>    * @xlat: pointer to address within the returned memory region 
>> section's
>>    * #MemoryRegion.
>> - * @len: pointer to length
>> + * @plen_out: pointer to valid read/write length of the translated 
>> address.
>> + *            It can be @NULL when we don't care about it.
>>    * @is_write: indicates the transfer direction
>>    * @attrs: memory attributes
>>    */
>>   MemoryRegion *flatview_translate(FlatView *fv,
>>                                    hwaddr addr, hwaddr *xlat,
>> -                                 hwaddr *len, bool is_write,
>> +                                 hwaddr *plen_out, bool is_write,
>>                                    MemTxAttrs attrs);
>>   static inline MemoryRegion *address_space_translate(AddressSpace *as,
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 8a8be3a80e2..86422f294e2 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -566,7 +566,7 @@ iotlb_fail:
>>   /* Called from RCU critical section */
>>   MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr 
>> *xlat,
>> -                                 hwaddr *plen, bool is_write,
>> +                                 hwaddr *plen_out, bool is_write,
>>                                    MemTxAttrs attrs)
>>   {
>>       MemoryRegion *mr;
>> @@ -574,13 +574,14 @@ MemoryRegion *flatview_translate(FlatView *fv, 
>> hwaddr addr, hwaddr *xlat,
>>       AddressSpace *as = NULL;
>>       /* This can be MMIO, so setup MMIO bit. */
>> -    section = flatview_do_translate(fv, addr, xlat, plen, NULL,
>> +    section = flatview_do_translate(fv, addr, xlat, plen_out, NULL,
>>                                       is_write, true, &as, attrs);
>>       mr = section.mr;
>> -    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
>> +    if (xen_enabled() && plen_out && memory_access_is_direct(mr, 
>> is_write,
>> +                                                             attrs)) {
>>           hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) 
>> - addr;
>> -        *plen = MIN(page, *plen);
>> +        *plen_out = MIN(page, *plen_out);
>>       }
> 
> My question from the previous version is still unanswered:
> 
> https://lore.kernel.org/qemu- 
> devel/22ff756a-51a2-43f4-8fe1-05f17ff4a371@redhat.com/

This patches
- checks for plen not being NULL
- describes it as
   "When Xen is enabled, only update @plen_out when non-NULL."
- mention that in the updated flatview_translate() documentation
   "It can be @NULL when we don't care about it." as documented for
   the flatview_do_translate() callee in commit d5e5fafd11b ("exec:
   add page_mask for flatview_do_translate")

before:

   it was not clear whether we can pass plen=NULL without having
   to look at the code.

after:

   no change when plen is not NULL, we can pass plen=NULL safely
   (it is documented).

I shouldn't be understanding your original question, do you mind
rewording it?

Thanks,

Phil.

