Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A5DE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLJ8g-0001Ut-Fv; Wed, 11 Dec 2024 04:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tLJ8e-0001UQ-81
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:36:12 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tLJ8Z-0003Aj-48
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:36:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166651f752so26193205ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 01:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1733909764; x=1734514564;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9QyN7qCk8DcPHzaobhhCexw2ppY4CXt9SxSgAhsS3XA=;
 b=2ILR6uiVzKbwhIrXN5QYj0spzMYRhGMUbMNsYV7ynOhBRz21yonhUnwo9swdrluHTk
 yXtpJL9aNB8lMDrmRtmp3czJabx3kwtm7HpToHy6RMgdTRpNFghasYxgLL7Wu+nak0pk
 JQM0F4adaj6+IGbG00BFfUdwuY2JaTEOeO/1IpzoKEql+yjDWvkpDK+I1iQbbAdcoUuZ
 0Gah0Qd/nvsHIyI1F6eJ5X7Y+827U5qAKiDysanMsUGX9W7tuXZyQ0o1p8rtaWowawRJ
 3CUeWExZ0DB/Vk0Lh5L7DWEVBcQEJYFBz2LEKL+hCgRtzwShverEwA37u2tx6PdBRI5r
 XQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733909764; x=1734514564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9QyN7qCk8DcPHzaobhhCexw2ppY4CXt9SxSgAhsS3XA=;
 b=LmaBBHxoR9th4gc/Xb2VqrqK11iGe4EV3Y5gnDOByjOeQeeI+rXMKAa+78QNALVXl1
 NOCsObDD6L7BfMgOlZ9YBJG428V7qOQX8dbHiO+PYJkOBm0fbU085xJZw/g82DMcUyoS
 UBckMTsL7elBDyXp9zWwGZN+Rh3MeYUnL+nf6vVj7kry0xCsW5WbEwTt1oCyREr/X/yU
 B3RRflBmZfsqOPsYso/LIp8je8+L44a3tuoo0aVLKyZTC2MkL2naNBIoq8MSmzw/7502
 uraGz1u5z+qdU3qnOE8x7kwadw2rFDAvJkDiFtnJALFc/TFZhPBU4hhyJu4ozhIoAjHP
 NT/w==
X-Gm-Message-State: AOJu0Yx98qDUsopx6pem7WXKkstHSVUYMpml2V90tm1iMLtrZkFbtTr4
 W721CnuYYNHSA9LLxTsseCCBoqMxPv9U5sf9kEXEblcjtAmFdOdKoSUHLsbEnRA=
X-Gm-Gg: ASbGncvEaPPwBHlWvHI0Ug3QAmVzifz/58iFIuOS9DM79ZB9HEKd4AkidIan398i4DP
 Bl9pnazsrtsyZy85QtAg6UpetiSEcfNwlGWmYBq67czMm5xox7N1nkCRIL4Fd57XDSXHsFBIF9E
 dV3FsyZ8jLQHuOAv5FuM279jBAXcHEKf4JtKhVORinRWSVA7QW+zTXdO15sHu/3P2jEql4Qh3Sy
 jSUDF0lam0Ig8Vn8fry/L98AMQMjoOCx8Nq7LyA/O7g/9Haa066hNvsO14WRLPhC1R03WKRfnoe
 yFie9g==
X-Google-Smtp-Source: AGHT+IFaSoPI1VNIxxqqxNRljnB9luIHgALXB7c8o6CYQHbKCI9YCz/mT42pJYnMWMWaD1CF5sjHpw==
X-Received: by 2002:a17:903:32ca:b0:215:e98c:c5bc with SMTP id
 d9443c01a7336-217786973f7mr39559425ad.48.1733909764000; 
 Wed, 11 Dec 2024 01:36:04 -0800 (PST)
Received: from [10.16.129.170] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e5f338sm102737635ad.72.2024.12.11.01.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 01:36:03 -0800 (PST)
Message-ID: <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp>
Date: Wed, 11 Dec 2024 18:35:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp> <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp> <Z1MpY7ZIAAoBDbZU@x1n>
Content-Language: en-US
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <Z1MpY7ZIAAoBDbZU@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Sorry for late reply.

On 2024/12/07 1:42, Peter Xu wrote:
> On Fri, Dec 06, 2024 at 05:31:33PM +0900, Tomoyuki HIROSE wrote:
>> In this email, I explain what this patch set will resolve and an
>> overview of this patch set. I will respond to your specific code
>> review comments in a separate email.
> Yes, that's OK.
>
>> On 2024/12/03 6:23, Peter Xu wrote:
>>> On Fri, Nov 08, 2024 at 12:29:46PM +0900, Tomoyuki HIROSE wrote:
>>>> The previous code ignored 'impl.unaligned' and handled unaligned
>>>> accesses as is. But this implementation could not emulate specific
>>>> registers of some devices that allow unaligned access such as xHCI
>>>> Host Controller Capability Registers.
>>> I have some comment that can be naive, please bare with me..
>>>
>>> Firstly, could you provide an example in the commit message, of what would
>>> start working after this patch?
>> Sorry, I'll describe what will start working in the next version of
>> this patch set. I'll also provide an example here.  After applying
>> this patch set, a read(addr=0x2, size=2) in the xHCI Host Controller
>> Capability Registers region will work correctly. For example, the read
>> result will return 0x0110 (version 1.1.0). Previously, a
>> read(addr=0x2, size=2) in the Capability Register region would return
>> 0, which is incorrect. According to the xHCI specification, the
>> Capability Register region does not prohibit accesses of any size or
>> unaligned accesses.
> Thanks for the context, Tomoyuki.
>
> I assume it's about xhci_cap_ops then.  If you agree we can also mention
> xhci_cap_ops when dscribing it, so readers can easily reference the MR
> attributes from the code alongside with understanding the use case.
>
> Does it mean that it could also work if xhci_cap_ops.impl.min_access_size
> can be changed to 2 (together with additional xhci_cap_read/write support)?
>
> Note that I'm not saying it must do so even if it would work for xHCI, but
> if the memory API change is only for one device, then it can still be
> discussed about which option would be better on changing the device or the
> core.
>
> Meanwhile, if there's more use cases on the impl.unaligned, it'll be nice
> to share together when describing the issue.  That will be very persuasive
> input that a generic solution is needed.
OK, I understand. I will try to describe 'xhci_cap_ops' and related topics.
Currently, the actual 'xhci_cap_ops' code is as follows:

```
static const MemoryRegionOps xhci_cap_ops = {
     .read = xhci_cap_read,
     .write = xhci_cap_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
};
```

According to the above code, the guest can access this MemoryRegion
with 1-4 bytes.  'valid.unaligned' is also not explicitly defined, so
it is treated as 'false'. This means the guest can access this MR with
1-4 bytes, as long as the access is aligned. However, the xHCI
specification does not prohibit unaligned accesses.

Simply adding '.valid.unaligned = true' will not resolve this problem
because 'impl.unaligned' is also 'false'. In this situation, where
'valid.unaligned' is 'true' but 'impl.unaligned' is 'false', we need
to emulate unaligned accesses by splitting them into multiple aligned
accesses.

An alternative solution would be to fix 'xhci_cap_{read,write}',
update '.impl.min_access_size = 1', and set '.impl.unaligned = true'
to allow the guest to perform unaligned accesses with 1-4 bytes. With
this solution, we wouldn't need to modify core memory code.

However, applying this approach throughout the QEMU codebase would
increase the complexity of device implementations. If a device allows
unaligned guest access to its register region, the device implementer
would needs to handle unaligned accesses explicitly. Additionally,
the distinction between 'valid' and 'impl' would become almost
meaningless, making it unclear why they are separated.

"Ideally", we could consider one of the following changes:

1. Introduce an emulation mechanism for unaligned accesses using
    multiple aligned accesses.
2. Remove either 'valid' or 'impl' and unify these functionality.

Solution 2 would require extensive changes to the codebase and memory
API, making it impractical.  Solution 1 seems to align with QEMU's
original intentions. Actually, there is a comment in 'memory.c' that
states:

`/* FIXME: support unaligned access? */`

This patch set implements solution 1. If there is a better way to
resolve these issues, I would greatly appreciate your suggestions.

Thanks,
Tomoyuki HIROSE
>>> IIUC things like read(addr=0x2, size=8) should already working before but
>>> it'll be cut into 4 times read() over 2 bytes for unaligned=false, am I
>>> right?
>> Yes, I also think so. I think the operation read(addr=0x2, size=8) in
>> a MemoryRegion with impl.unaligned==false should be split into
>> multiple aligned read() operations. The access size should depends on
>> the region's 'impl.max_access_size' and 'impl.min_access_size'
>> . Actually, the comments in 'include/exec/memory.h' seem to confirm
>> this behavior:
>>
>> ```
>>      /* If true, unaligned accesses are supported.  Otherwise all accesses
>>       * are converted to (possibly multiple) naturally aligned accesses.
>>       */
>>      bool unaligned;
>> ```
>>
>> MemoryRegionOps struct in the MemoryRegion has two members, 'valid'
>> and 'impl' . I think 'valid' determines the behavior of the
>> MemoryRegion exposed to the guest, and 'impl' determines the behavior
>> of the MemoryRegion exposed to the QEMU memory region manager.
>>
>> Consider the situation where we have a MemoryRegion with the following
>> parameters:
>>
>> ```
>> MemoryRegion mr = (MemoryRegion){
>>      //...
>>      .ops = (MemoryRegionOps){
>>          //...
>>      .read = ops_read_function;
>>      .write = ops_write_function;
>>      .valid.min_access_size = 4;
>>      .valid.max_access_size = 4;
>>      .valid.unaligned = true;
>>      .impl.min_access_size = 2;
>>      .impl.max_access_size = 2;
>>      .impl.unaligned = false;
>>      };
>> };
>> ```
>>
>> With this MemoryRegion 'mr', the guest can read(addr=0x1, size=4)
>> because 'valid.unaligned' is true.  But 'impl.unaligned' is false, so
>> 'mr.ops->read()' function does not support addr=0x1, which is
>> unaligned. In this situation, we need to convert the unaligned access
>> to multiple aligned accesses, such as:
>>
>> - mr.ops->read(addr=0x0, size=2)
>> - mr.ops->read(addr=0x2, size=2)
>> - mr.ops->read(addr=0x4, size=2)
>>
>> After that, we should return a result of read(addr=0x1, size=4) from
>> above mr.ops->read() results, I think.
> Yes.  I agree with your analysis and understanding.
>
> Thanks,
>

