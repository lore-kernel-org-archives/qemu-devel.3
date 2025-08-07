Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAC9C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1Mu-0004WX-88; Thu, 07 Aug 2025 10:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uk1Mn-0004US-HE
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uk1Mi-0004Qy-TK
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754575986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TZeGEn5xHM1k/EW+W75gI6JAh/2Pw8L54gV9Jh0EXnc=;
 b=FWMMNZaWigSnCSpP6UIEcsXGr41rhqS/+IhA0NiHBQslchs5w713zBQ+bekIWM+iGHan1l
 EjPhFA1lsuRrhATvAWRu3xAEopMxdlZ+RRN2pGJ9XCsfK9XUP/aYXKMTm9VWrZmIoo9xKj
 IWIj8YsbqGZv2YY1biT+NiGDHPUQ56o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-j6-w7s0MOsWBhlzoHOJ_IA-1; Thu, 07 Aug 2025 10:13:04 -0400
X-MC-Unique: j6-w7s0MOsWBhlzoHOJ_IA-1
X-Mimecast-MFC-AGG-ID: j6-w7s0MOsWBhlzoHOJ_IA_1754575984
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7931d3d76so672230f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 07:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754575984; x=1755180784;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZeGEn5xHM1k/EW+W75gI6JAh/2Pw8L54gV9Jh0EXnc=;
 b=vUAM1JnEXSmuwa1ypXR2u2sZJtvoVZgnqynQuzK0eVOINYGG+chiyCm2dukAWWfpkU
 P2Hem60W31oa9iNdQXbbN0Tp0gj82j9Zv/nrab4oapwtQwcvMrSkW/6wKhoZ9PCFvz9p
 1DJoual43KFh9tnZdA6Y6w449tG4Yh2EEI/D2/ckOL8X9reZSu36dZ+RfCMM6Kx0DZR+
 Ft/eutwPpmBc60JB2SzQ//tUNHzeRSCu7KHx1UY5BfXxt786kpEZVbsrXhEK26nDtckr
 YO7ElG1kOg63s1DxnyTQiTRJ+FmIpXFkWsSRfyXcwT0XD6X5yba+P5/37MGeVXMSwGcE
 xA9g==
X-Gm-Message-State: AOJu0YwvH2mmHWDV6kOVvA4c30uxgG5Lrg3pGnZpODKddHWXC2ybh+UO
 zXZ32T1tQ2M9E7uxh/KBQcj3/79/EOXqvDdvoLmiSaEA9TAtRiysIyET1XBXZZT/z3vjE+v/yOv
 E/S3QBEj/5z7LsK0fkObH6zbY6drrSPuADtMby+6RnxiFPAW9W6Xb/1iR
X-Gm-Gg: ASbGncs3Und3EjJCrwjPcgTCm5bS0mB5Ib6soE9BNLqBFHex+X98nW6hYdeLO8+gtiN
 co7mF3vPKWdZIjsV6ZEzTCd43cWJOlvL/D1tMFhXLvh38l2lcdi9lqVn7IAUI+u6/0XNkqeHivh
 3FQzqM2F4K++Gzq6YTeEP4dQEMmNQ27uGdJ74wxMbAcLEzOzmx/H5dN7VTwpTcM1kSqURvSLbP0
 nZROxoEaPS/F9JW4IA58FiZ5Wpfaty0q4uzCVbfGm4HZ0nte3z3LgV5EiTqZYqrQ0FNXiVgm0Ah
 6ZUreUROQacir5Kzr837YhKDP+IjmLwL3Mu3+TKkONmW
X-Received: by 2002:a05:6000:2204:b0:3b4:9721:2b2d with SMTP id
 ffacd0b85a97d-3b8f48de380mr5424927f8f.9.1754575983525; 
 Thu, 07 Aug 2025 07:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIFCzEYBHd1ZGXQnwZIzcOzskL80owLj2MB3R97Q0u/w3GvlERiNbET4dj3HB6HsX4gjOD5w==
X-Received: by 2002:a05:6000:2204:b0:3b4:9721:2b2d with SMTP id
 ffacd0b85a97d-3b8f48de380mr5424890f8f.9.1754575983050; 
 Thu, 07 Aug 2025 07:13:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-459dbba5210sm165256865e9.2.2025.08.07.07.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 07:13:02 -0700 (PDT)
Message-ID: <a3272f93-8766-46a0-bda2-ddea777ef79c@redhat.com>
Date: Thu, 7 Aug 2025 16:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/26] rust/memory: Integrate the vm-memory API from rust-vmm
To: Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[Adding Hanna who's been working on vm-memory]

On 8/7/25 14:30, Zhao Liu wrote:
> Hi,
> 
> This RFC series explores integrating the vm-memory API into QEMU's
> rust/memory bindings.
> 
> Thanks to Paolo and Manos's many suggestions and feedback, I have
> resolved many issues over the past few months, but there are still
> some open issues that I would like to discuss.
> 
> This series finally provides the following safe interfaces in Rust:
>   * AddressSpace::write in Rust <=> address_space_write in C
>     - **but only** supports MEMTXATTRS_UNSPECIFIED
> 
>   * AddressSpace::read in Rust <=> address_space_read_full in C
>     - **but only** supports MEMTXATTRS_UNSPECIFIED.
> 
>   * AddressSpace::store in Rust <=> address_space_st{size} in C
>     - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.
> 
>   * AddressSpace::load in Rust <=> address_space_ld{size} in C
>     - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.

Endianness can be handled by BeNN and LeNN.  For MemTxAttrs we can use 
Bytes<(GuestAddress, MemTxAttrs)> (a variant on something you mention 
below).

Thinking out loud: maybe if we do our implementation in 
Bytes<(GuestAddress, MemTxAttrs)>, and Bytes<GuestAddress>::try_access 
wraps Bytes<(GuestAddress, MemTxAttrs)>, your downstream-only changes 
are not needed anymore?

> And this series involves changes mainly to these three parts:
>   * NEW QEMU memory APIs wrapper at C side.
>   * Extra changes for vm-memory (downstream for now).
>   * NEW QEMU memory bindings/APIs based on vm-memory at Rust side.
> 
> Although the number of line changes appears to be significant, more
> than half of them are documentation and comments.
Yep, thanks for writing them.

This is a good RFC, it's complete enough to show the challenges and the 
things that are missing stand up easily.

I'll look into what vm-memory is missing so that we can simplify QEMU's 
code further, but the basic traits match which is nice.  And the final 
outcome, which is essentially:

     let (addr, value) = (GuestAddress(self.fsb >> 32),
                          Le32(self.fsb as u32));
     ADDRESS_SPACE_MEMORY.memory().store(addr, value);

is as clean as it can be, if anything a bit wordy due to the 
GuestAddress "newtype" wrapper.  (If we decide it's too bad, the 
convenience methods in AddressSpace can automatically do the 
GuestAddress conversion...)

Paolo


