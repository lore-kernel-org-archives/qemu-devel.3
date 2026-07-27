Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA09C53200
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 03:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woC7l-0003E0-5m; Sun, 26 Jul 2026 23:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woC7k-0003DZ-BC
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woC7g-0007Pd-NX
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785123323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEvy0F8mKE31vGwd549dxWXgDdMTMZNJwTROsvaq6D0=;
 b=hXYPeKTsso6CXwthLo/Mra4CDtixKQO+KPtp+91cdd26nTotaWGPU1x4Ep7GAzq7lh/4BX
 idCs+vr14E2FFe2KEOa9ZP6855+f+/kKdgUhPFyfoswgqul3scy0EH6i+QpSB121E0FQ06
 QahZSSd/qC+ucowk6chfCZ8Rd8hxjqM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-NheGcY46PCWQHWJirRKJfA-1; Sun, 26 Jul 2026 23:35:21 -0400
X-MC-Unique: NheGcY46PCWQHWJirRKJfA-1
X-Mimecast-MFC-AGG-ID: NheGcY46PCWQHWJirRKJfA_1785123321
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso32838085ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785123320; x=1785728120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZEvy0F8mKE31vGwd549dxWXgDdMTMZNJwTROsvaq6D0=;
 b=ZHC4tYCKRKmLsXN3p6CXzGRs89+8sEMe04Wrubzy9XwuQtpBf3rgIFdJ/PIp+0MRVm
 nCLffzRsNlnk5UNThn2LjqIHbaXxWiq/atVInoGu25hLbwJ0mtwFt2LXtW95OBPJPIRr
 jnTH1vR72UHhuFkBzhaECTYXyxEh+PEkUUCm6TRRQMEmHdNH/A54dxgRClNOvDbEJ9gy
 TCDzFTxTttHS9Uq8lsJgCohi0xQYPT2Bcy/pVQlTEKLV/FYVcQLNhbUCMbP6OAj0NlPd
 JsbXWg/E+ClBvRc2BrfuVtDBvszMIWOC+dlqTlaqVCy0aLZWHclZpioxa9IQYWi3Lylm
 KNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785123320; x=1785728120;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZEvy0F8mKE31vGwd549dxWXgDdMTMZNJwTROsvaq6D0=;
 b=iHIzAlSfU0I8LHV/309QKqk6B8AHb20n5Ha8UtxEWHkrcr5O3RBqaO69QxDffTy8Zj
 FfFyhob7ceTh8iODpLP36/SCvtYfWT5TvhRHITR2mqhLN6RPdUdBnSMZrIGzkGM8XJAG
 wR71IMvYXvKiyUPx66vE6oa0H905uA9BibKvBEhxKxd+g9hcPkcM9EsEBHOA5A0h/etZ
 ecsCSMerKi6c3wVchUwEERxWCy37JbIF3yqcco5yqu90koeAyxZLmjKOrQCdtSLkvFaz
 KMp6Tp7ZTe98hplnn/fTQwhhdQXVY+Q8OFoT5T4mC/wEPUlpP/rzTqab0XFdIMEhaIJX
 zchQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0S+TWqVhphKxkcch5WbG07/G/fTQV289kN0yVVrH3WcI6r+E03iwritQZtXr3ZJOx6ceGyXOjsI8S@nongnu.org
X-Gm-Message-State: AOJu0YwGP1MUc4+FvukRhd8WCTYNQJDkCr5xhytTw0GicMnMFpAMsk9Q
 Tb4VMS2sQpdgIyeQrEsldH1THVKbRuhihDoK3wLN9RD4MOVCb6ew5uzDW8ZFj2ZbtjgyVv39rsz
 KNKZ4ajnf7bu7DBUBxDwAuKg1XypqDruTE7HAAosuZR1mXo0nkkoJX2ds
X-Gm-Gg: AR+sD12WNaoSL8Wk2PuvhBexcNbx+9wM/eMV/nfLiLVP1P/nl/YdCnh1Ejy0OJ4eZOw
 DKUyQEXV6z8AtEReoABZwGrA319fX2o83UyJ3/PTPW/wI0hWUNsRME5qMt0tUG636JQm08HJ/k2
 hQoRBZdWeS5ISOVAz83eVJNZI6qVvi/n5A2JkJ2IwlKEIB+nP29ZMlYMiQVWeDco6w3VRM8aF26
 6qeQIQTpYoHk25Rn+h0r+g7Ylo3mlInWvOkaJNC+/jlik4ZZtDa/vxTO5yadm2A2RXVcMko/gSP
 0NebkJ32+dA+HXb7c2piifQ/23NH8wuPDqu170hmbTVTjqk847oQukRxIBKcrNhvvQj2RivnOJC
 mjCQXVRafyqVyckCvj9G7eaWSxcanaaRNufImY1xuo7U=
X-Received: by 2002:a17:902:d485:b0:2c9:cf5d:d9bc with SMTP id
 d9443c01a7336-2cfde88614emr66277965ad.35.1785123320438; 
 Sun, 26 Jul 2026 20:35:20 -0700 (PDT)
X-Received: by 2002:a17:902:d485:b0:2c9:cf5d:d9bc with SMTP id
 d9443c01a7336-2cfde88614emr66277695ad.35.1785123319911; 
 Sun, 26 Jul 2026 20:35:19 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde59bb5asm27000415ad.8.2026.07.26.20.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 20:35:18 -0700 (PDT)
Message-ID: <a529c8bf-ca79-43d9-8987-1d6d39d517b4@redhat.com>
Date: Mon, 27 Jul 2026 13:35:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org, richard.henderson@linaro.org,
 berrange@redhat.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
 <al-eCtxGjG4HHEbl@x1.local> <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
 <20260722015422-mutt-send-email-mst@kernel.org> <amDyvgR09OJssENX@x1.local>
 <20260723015708-mutt-send-email-mst@kernel.org>
 <71d88d00-5b41-49d2-b649-8a6ea47abc4d@oss.qualcomm.com>
 <20260723045428-mutt-send-email-mst@kernel.org> <amIbUYN3teCLXTh-@x1.local>
 <b05b40b1-fffd-4be5-9289-b5bc92c16cd2@redhat.com> <amNvIMizFp7Au2c3@x1.local>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <amNvIMizFp7Au2c3@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/24/26 11:56 PM, Peter Xu wrote:
> On Fri, Jul 24, 2026 at 11:42:09AM +1000, Gavin Shan wrote:
>> On 7/23/26 11:46 PM, Peter Xu wrote:
>>> On Thu, Jul 23, 2026 at 05:05:08AM -0400, Michael S. Tsirkin wrote:
>>>> On Thu, Jul 23, 2026 at 10:52:11AM +0200, Philippe Mathieu-Daudé wrote:
>>>>> On 23/7/26 08:04, Michael S. Tsirkin wrote:
>>>>>> On Wed, Jul 22, 2026 at 12:41:34PM -0400, Peter Xu wrote:
>>>>>>> On Wed, Jul 22, 2026 at 01:58:18AM -0400, Michael S. Tsirkin wrote:
>>>>>>>> On Wed, Jul 22, 2026 at 10:53:27AM +1000, Gavin Shan wrote:
>>>>>>>>> On 7/22/26 2:27 AM, Peter Xu wrote:
>>>>>>>>>> On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
>>>>>>>>>>> If Peter is fine with two variants for x86 and non-x86 architectures.
>>>>>>>>>>> I can post (v4) for further review. That will be something like below
>>>>>>>>>>> and let me know if there are any other improvements are needed.
>>>>>>>>>>
>>>>>>>>>> I have a generic question on the "unaligned access for x86": I think the
>>>>>>>>>> question is about the one Michael raised here on unaligned access may break
>>>>>>>>>> x86 here:
>>>>>>>>>>
>>>>>>>>>>       https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
>>>>>>>>>>
>>>>>>>>>>       3. (theoretical concern) also on x86, unaligned accesses are
>>>>>>>>>>       possible on guest and host, so converting an unaligned access to a
>>>>>>>>>>       series of aligned ones can in theory break devices.
>>>>>>>>>>
>>>>>>>>>> Is that a real problem we need to consider, or can we start with unified
>>>>>>>>>> approach and leave it for later?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I'm leaving this question to Michael.
>>>>>>>>
>>>>>>>> Knowing what I know about hardware designers, it's something someone
>>>>>>>> somewhere does)
>>>>>>>> It can be made a separate patch, just to show - it should be all of
>>>>>>>> ~10LOC.
>>>>>>>
>>>>>>> It's only about removal of anything that might be controversial for now,
>>>>>>> thanks.  I also wonder if anything would break, then it's more solid proof
>>>>>>> that per-arch change is required.
>>>>>>
>>>>>> Repeating:
>>>>>> 	I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
>>>>>> 	offset 0x1 within a dword. This maps nicely to even classical PCI byte
>>>>>> 	enable mechanism and so yes it works if your CPU can initiate these
>>>>>> 	things, and it's atomic.
>>>>>
>>>>> Isn't this out of the CPU arch, dealt with at the bus level?
>>>>>
>>>>> It looks we try to be clever with modern PCI code by optimizing this
>>>>> access -- not saying we can change that, I know it is too late after
>>>>> 20+ years -- relying on hw behavior that was done that way to support
>>>>> legacy hw, in particular broken I/O accesses.
>>>>
>>>> Not sure what the question is.  We were dicussing how to emulate unaligned
>>>> accesses from x86 guests if they happen.
>>>> On an x86 host we can do that easily, and it's just a couple of LOC.
>>>> Though Peter Maydell dislikes host arch specific code. But I hope
>>>> if it's a separate patch on top and it is visible how small it is,
>>>> he will reconsider)
>>>
>>> Yes, if we still want x86 specific change, it would be better to be put
>>> separately.
>>>
>>> Said so, I don't think the e1000e LEDCTL test illustrated what might
>>> break..  Isn't that only an exmaple showing unaligned access is
>>> "supported", however nothing breaks even if we use 1B*2?
>>>
>>> My question was more about a real breakage, hence whenever it happened
>>> "it's more solid proof that per-arch change is required".
>>>
>>>> On other hosts we can't emulate them 100%, we either need to split
>>>> to byte accesses or over-access and mask. Byte accesses feel safer.
>>>> What qemu currently does with memmove is clearly not safe in the
>>>> general case.
>>>
>>> We should have another option that is not arch-dependent but keep the
>>> unaligned behavior.
>>>
>>> For current master, AFAIU we do unaligned access for both ram_device and
>>> rest. Say, even with ram_device_mem_ops, it has both .unaligned=true for
>>> both .valid & .impl.  I think it means indeed we have unaligned behavior
>>> even for ram_device.  It also means what matters in regards to the Realtek
>>> bug was only about aligned access (with subpage presence).
>>>
>>> I think it means we can always keep unaligned to stick with
>>> memcpy()/memmove(), but only use atomic ops for the aligned cases of
>>> 1/2/4/8.  With that, I think we can also remove ram_device_mem_ops and fix
>>> the bounce buffer issue.
>>>
>>> I think it means we'll stick with memcpy()/memmove() for all archs for
>>> unaligned, which is again not safe... but that can be an existing but
>>> separate problem to solve too.
>>>
>>
>> Lets see if Peter Maydell and Michael are happy with this option. At least,
>> we will have unified qemu_ram_move() for all architectures with this option.
>> Note that qemu_ram_copy() won't be needed.
>>
>> I'm putting note on what's to be done in (v4) if this option is to be picked
>> up. Let me know if there are missed points. It's basically combing what's done
>> by ram_device_mem_ops to upper layer (e.g. in qemu_ram_move()).
>>
>>    address_space_write
>>      address_space_to_flatview
>>      flatview_write
>>        flatview_translate
>>        flatview_write_continue
>>          flatview_write_continue_step
>>            memmove                     // (A) to replace it with qemu_ram_move()
>>
>> /**
>>   * qemu_ram_move: move data to ramblock
>>   *
>>   * @dst: destination where the data is moved to
>>   * @src: source where the data is moved from
>>   * @n: length of data to be moved
>>   *
>>   * Move @n bytes from @src to @dst with the assumption that @src and @dst
>>   * can overlap. The access is atomic if the source and destination buffer
>>   * aren't overlapped for a well aligned and small-sized access. Otherwise,
>>   * fall back to the standard memmove().
>>   */
>> static void qemu_ram_move(void *dst, const void *src, size_t n)
>> {
>>      uintptr_t test, len;
>>
>>      if (src == dst || n == 0) {
>>          return;
>>      }
>>
>>      /* Overlapped buffers */
>>      if (src < (dst + n) && dst < (src + n)) {
> 
> s/&&/||/?
> 
> It's a bit weird to request memmove() for overlapped, e.g. I don't know if
> P2P can overlap too when some fuzzer fills in some MMIO address shifted for
> src/dst.. but I think I get what you want to simplify and it looks fine.
> 
> Otherwise it looks good.
> 

The condition is correct to check if src/dst are overlapped. As Michael
pointed out the overlapping case can be well handled by "if (n > 8 || len != n)",
so this check has been dropped in v4.

     https://lore.kernel.org/qemu-arm/20260727032649.145381-1-gshan@redhat.com/

I don't think src/dst can be overlapped since p2p happens on two separate
devices. My idea to ignore the overlapping case is that would happen very
rarely, maybe only valid in the fuzzer case.

>>          memmove(dst, src, n);
>>          return;
>>      }
>>
>>      test = (uintptr_t)src | (uintptr_t)dst | n;
>>      len = test & -test;
>>
>>      /* Unaligned or oversized access */
>>      if (n > 8 || len != n) {
>>          memmove(dst, src, n);
>>          return;
>>      }
>>
>>      switch (len) {
>>      case 1:
>>          qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
>>          break;
>>      case 2:
>>          qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
>>          break;
>>      case 4:
>>          qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
>>          break;
>>      case 8:
>>          qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
>>          break;
>>      default:
>>          g_assert_not_reached();
>>      }
>> }
> 
> [...]
> 
>> Yes, I think one preparatory patch can added in (v4) to replace memcpy() with
>> memmove() in the following paths, extending commit 4a73aee8814 ("softmmu: Use
>> memmove in flatview_write_continue"). With this replacement, qemu_ram_copy()
>> won't be needed in (v4).
>>
>>      hw/remote/vfio-user-obj.c::vfu_object_mr_rw
>>      include/system/memory.h::address_space_read
>>      system/physmem.c::flatview_read_continue_step
>>      system/physmem.c::address_space_write_rom
> 
> Now after a second look, I think it's safe to drop
> address_space_write_rom() in the change list because it always directly
> manipulates the real RAM (that plays the ROM role).  I recall it was used
> to be used in debugging path, but at least now when I look at master branch
> it's not.  So we can drop.
> 

Ack, address_space_write_rom() is dropped in v4.

> I see you already ruled out address_space_read(), I'm not sure if it's
> about having that __builtin_constant_p() early check: I think it's still
> better to switch that to the new API too, then we get rid of implicit
> assumptions of memcpy() over builtin constants.
> 

Yes, qemu_ram_move() is also used for __builtin_constant_p() case in v4.

Thanks,
Gavin


