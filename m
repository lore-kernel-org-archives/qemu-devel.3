Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F123C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHR4f-0003Lk-7t; Tue, 20 May 2025 13:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uHR4d-0003LT-Ny; Tue, 20 May 2025 13:48:19 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uHR4b-0001cd-Nm; Tue, 20 May 2025 13:48:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a376da332aso1453591f8f.3; 
 Tue, 20 May 2025 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747763293; x=1748368093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=qW9c+b+OrOEpHvGGv9lhdKGDzpzGTiljEXgJF63Hta8=;
 b=CQZj8jSJFyn7nwRLd1j8J/WIdlsmCaWb9VqgXyo9DiwiRa33/l1FGgekoAsqea745S
 vpQfNidBxAZymRD4ifAvJi4ctjv908jR49Y+jacoAm7+9/hqbP7llYWGeQ5mWjkjI8XR
 tBS51HoEKOfSu+wHPD/JtIZsLz+uZQj6MuBXrcy9uQZyXzimeErabV6AIf6tsOetxF4U
 n/yGS10WdbEjqXX2Stv6cuZ7qP1e7d07dHefP107FxHVnzcPLgKeiET9Hj9VnIxqarY+
 iu3yiaIHGTzTlXA8rwoNZipiLKfSn9yeZ1gpK9YyvLWv0RAHQCA9k0abD5U8MHdWGAMl
 o9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747763293; x=1748368093;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qW9c+b+OrOEpHvGGv9lhdKGDzpzGTiljEXgJF63Hta8=;
 b=uO7Z28fxkvi5+2su2WzPTpn0gT41nH7HSx4CgmDt1mGK0IGVUCTDI41rKO5RNL3U3T
 XhmS5vTGaj3iNLHUxCAPUw2WS2L8wjDjGxoPBWgkqaeh1R4lBO9hqGx+1IBj3hHMEXsh
 k/vkrEX8r8IfMcIM6uEzH6Nb6OMmfRam1ITIR/zOp2jP/WdQO5GwC1PcYpB/uinjzfZL
 /sqK0Qm8+6m4pbyif0uFFhxdDiqhAxBSGzVBX0JV9Yc4qUERMtoxxp7qxwA/MzeDPy85
 jFNgxgJJ0CX/BDxOEL0LszTaSvmupl3PiUTLOA8+APoon+4bYi8VV5fgH9FSTokjB7T5
 txXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIORKLOPogRUkHoT1slIb6BGQ4BLIY8O1MdmalKgmsbQosxDdZSQhPgcKkW7frvQ9nqY9Ubo5U+Jw=@nongnu.org
X-Gm-Message-State: AOJu0YyRsz14hLyW0ndrLjSHbVEVm2uR/U0JTubgGkW3EC7pdDSS5UXg
 jK/lMDc/3T30x2icsdVC5u+LH3DGosadIPAhCXcvjjO256yYxGEkxw0a
X-Gm-Gg: ASbGncu67RFa6MV2uOMGyj/2Kvq0eMbFFhA3NdGdGpQXmm6u9WyXUJwTP2X+dvwms+D
 tn+dGReV8U/xfxB2jmt0EhIsyAKmaoajFExYr9gaco8d9J8xY5QB7Zd2qY1+gMvk/GrtZHXapv1
 wnBh5CV3rVoP0h/gbloasbTuH3LeJ3ZbNBzuXmYCH6ZS3QQk5bRQR/S9QxQM32D0hc6nGs0DpM1
 oGUxdy8mTHf6alYsqrOXMuC6iDtFJaArGLY2BNXtq8wEtcybordxMZpLdnRKoA6AEyoGDvIGZ5u
 NO/BpjpwUBN60/BghfYxgymi0zfb8AJH5njaeA8JwRfOiIUO
X-Google-Smtp-Source: AGHT+IG0/X4Yg3WxaECijxJHiuWhchwbgduzC6f0Lf4V4/1UcEsDtlKc0RwCDrfzvZuvRV24dfBRvw==
X-Received: by 2002:a5d:5848:0:b0:3a1:4343:f834 with SMTP id
 ffacd0b85a97d-3a35fe5c5e9mr16600800f8f.2.1747763293104; 
 Tue, 20 May 2025 10:48:13 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a36835ef41sm12916814f8f.94.2025.05.20.10.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 10:48:12 -0700 (PDT)
Message-ID: <abe683f2-e679-4579-b68a-38a11d41e00b@gnu.org>
Date: Tue, 20 May 2025 19:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust in QEMU update, April 2025
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <aCysct2L8Bosqy0N@intel.com>
From: Paolo Bonzini <bonzini@gnu.org>
Content-Language: en-US
Autocrypt: addr=bonzini@gnu.org; keydata=
 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
In-Reply-To: <aCysct2L8Bosqy0N@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On 5/20/25 18:23, Zhao Liu wrote:
>> HPET does some very simple memory accesses; a good safe solution
>> for this may be the ``vm-memory`` crate.  While I have not looked into
>> using it, ``vm-memory`` and ``vm-virtio`` were written with QEMU's
>> use cases in mind.
> I'm working on this and trying to wrap simple memory access by
> vm-memory.

Ok.  Note that while the GuestAddressSpace corresponds QEMU's 
AddressSpace (so far so good :)), QEMU's MemoryRegion is completely 
unrelated to vm-memory's GuestMemoryRegion.  That's because vm-memory 
only operates on an array of non-overlapping regions, like QEMU's 
FlatRange or MemoryRegionSection structs.


The GuestMemory (GuestAddressSpace::M) corresponds to QEMU's FlatView. 
Indeed the functions in the trait match with what you expect of a FlatView:

     fn num_regions(&self) -> usize;
     fn find_region(&self, addr: GuestAddress) -> Option<&Self::R>;
     fn iter(&self) -> impl Iterator<Item = &Self::R>;

If the GuestMemory is a FlatView, the GuestAddressSpace::T, implements 
Clone + Deref<Target = FlatView>.  It's not too hard to see that 
GuestAddressSpace's memory() method must call 
address_space_get_flatview() and the GuestAddressSpace::T's drop method 
must call flatview_unref().  Let's call this (Rust-specific) struct 
FlatViewRefGuard, or something like that.


Going back to the GuestMemoryRegion (<FlatView as GuestMemory>::R), it 
could be either a QEMU FlatRange or a MemoryRegionSection.  Neither are 
good options.  Without a MemoryRegionSection you can't support IOMMU 
regions; but flatview_do_translate() returns the MemoryRegionSection by 
value, and GuestMemory's

     fn find_region(&self, addr: GuestAddress) -> Option<&Self::R>;

wants a reference instead!

Anyhow, all three types (AddressSpace, FlatView, FlatRange) are better 
wrapped with Opaque.

Looking more at FlatRange, these are easy:

     // Required methods
     fn len(&self) -> GuestUsize;
     fn start_addr(&self) -> GuestAddress;

But this one is another problem:

     fn bitmap(&self) -> &Self::B;

because it returns the "Bitmap" by reference.  QEMU's bitmap is a global 
variable indexed by ram_addr_t.  It would be better if this was declared 
like this:

    fn bitmap(&'a self) ->
       <Self::B as WithBitmapSlice<'a>>::S

I have no idea if this can be changed in upstream vm-virtio.  For now 
maybe you can leave it as ().  That's buggy but it's ok for a proof of 
concept.

So... not sure what to do there.  It seems like vm-memory is very close 
to being usable by QEMU, but maybe not completely. :(

Paolo

