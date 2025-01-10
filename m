Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F21E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBzP-0005kZ-S8; Fri, 10 Jan 2025 05:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tWBzN-0005kN-MY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:11:37 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tWBzL-0005Bk-An
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:11:37 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166f1e589cso37092415ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1736503893; x=1737108693;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=peRy/BjUZvhBiGZOZT6CR7hVqi0C0WLqOpRsAuXJkfU=;
 b=ar1aOXolXYLb9UiF4BRBqnMixlxYeo6O6opU99g43GMG+0RDfuiMMepVFVLA+Yibyj
 Vb9k5aHoV4fJ01mACG6pjApX9tdDOdAXTAI3Zk9yLJoap3r1QVIzasqaoExO4UaEaju1
 1ONDb4oFGMY9mRXbH7aaibUFP13Ixp7JjilNpNgPOb6Q913TBoi6vyCSN1GUuPl7hSkj
 3wLFA871CtG9oIG0M5wLSSMuJuntyJtsOrPD6CgpbZxEn1ppPt49s4UiqwjJ7PFPOCFv
 Ly1dNs/XOQlRZqtJFA32ka4xrcV4gxGRiryWx7sQrAWJb1mRapW5Np8uGwvQcpCgSJk/
 oVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736503893; x=1737108693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=peRy/BjUZvhBiGZOZT6CR7hVqi0C0WLqOpRsAuXJkfU=;
 b=EfD03+3mGZD3myYI2ybBIZbp9FFiQE6ZaU5zJlp+GjzHX++qm2ch2URLk5P89PJzKY
 Mc11DmRhlHxh/kTNP7eytyWk310LnAHTcJ/vxZV09foGP3YGFyD6mu35cSWDrVQ4vkAR
 5iiE+x4hvEkjWGGGDNt7r1n1soOhx5TdKcpCMD3FnXY3cZUh1vdLfCP9CbJlhkDn1laD
 +wXYugJf3/JZzdDYgG5fpDckenMkGYtyZg3lehmpUY6ejazmJi8ZhJNneMJgwzuJimze
 RMWCR9+u6+EqSSIsg9o0poXiD+ejfoFhQVOqqfrhbdhPAokimb0THy5nTId2+VNSgO0K
 6rew==
X-Gm-Message-State: AOJu0YwHBAzQtlj75M73lxLBXmBsP9lpLB0zvIGXRTJesE95h78W+LqM
 cj2GYhEhxPlREATj8RqLAu+qnHNls8bTn7B0jD4+6/t/4OlRSyhVJqTNZpD8a6A=
X-Gm-Gg: ASbGncuvPpfbFH6TuzD8f5AUJpjmn4v8yg63L1zv1xbgzgq9emQ9a14DF99bv0EoE0p
 YNeOJ3fykYhzd8wLb3dWaTLbBNu9bFHYIIpIre9jVh1vXGGO+df5DXmzAMm8qE9MvVFS45wzWJu
 WbeXDQae0o212CW4q3CREVXAnieqBHgnjPgg5GaePAEdbaYDfBOmfIF+wFWBvaSq/c+Q918Z+0V
 VqG+5/BGp3J2+gGZ0W2t92CDEWg5KqFAsBbrEI6vdERC51BkBhgVA8Q4UGxFOp2SXm6tAHk4NJO
 QcZXLh0=
X-Google-Smtp-Source: AGHT+IFxWdPbRdWapKcimsI9sRh9NRENBflbj4h/Lz25WkDFtylBGdKpCshNbGOHa5jOsqdO2rc+HA==
X-Received: by 2002:a17:903:2451:b0:215:b74c:d7ad with SMTP id
 d9443c01a7336-21a83fc389cmr167621805ad.36.1736503892770; 
 Fri, 10 Jan 2025 02:11:32 -0800 (PST)
Received: from [10.16.129.24] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f22ebb9sm10940635ad.179.2025.01.10.02.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 02:11:32 -0800 (PST)
Message-ID: <6a4dd6ef-9d0c-4f1f-81eb-0d55fa32daf5@igel.co.jp>
Date: Fri, 10 Jan 2025 19:11:27 +0900
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
 <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp> <Z1oYIn5cMZeA4tes@x1n>
 <1ab0a747-e2c4-4545-bae9-31e19c77bd75@igel.co.jp> <Z1sFUxCiQp3Nziu_@x1n>
 <2e2dba3c-2bfc-478a-988d-fbf2e58cc293@igel.co.jp> <Z36su8G_hlkdBFy6@x1n>
Content-Language: en-US
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <Z36su8G_hlkdBFy6@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pl1-x62d.google.com
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


On 2025/01/09 1:50, Peter Xu wrote:
> Hi, Tomoyuki,
>
> On Wed, Jan 08, 2025 at 11:58:10AM +0900, Tomoyuki HIROSE wrote:
>> Happy new year, Peter.
>> I had another job and was late in replying to your email, sorry.
> Happy new year.  That's fine. :)
>
> [...]
>
>>> So.. it turns out we shouldn't drop impl.unaligned?  Because above two
>>> seems to be the real user of such.  What we may want to do is:
>>>
>>>     - Change above two use cases, adding impl.unaligned=true.
>>>
>>>       This step should hopefully have zero effect in reality on the two
>>>       devices.  One thing to mention is both of them do not look like to have
>>>       an upper bound of max_access_size (either 8 which is the maximum, or
>>>       not specified).
>> This might be a good way. In this way, we need to add 'impl.unaligned
>> = true' to the xHCI Capability Register's MR. We also need to fix the
> We need to keep xHCI's impl.unaligned to FALSE?  IIUC only if it's FALSE
> would it start to use your new code in this series to automatically convert
> the unaligned access request into one or multiple aligned accesses (without
> changing xHCI's MR ops implementation, IOW resolve this in memory core).

Yes, we need to keep it to 'false' because xHCI's MR implementation
does not supported unaligned accesses.

> I just had another look at your last patch:
>
> https://lore.kernel.org/qemu-devel/20241108032952.56692-6-tomoyuki.hirose@igel.co.jp/
>
> index d85adaca0d..f35cbe526f 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3165,9 +3165,11 @@ static const MemoryRegionOps xhci_cap_ops = {
>       .read = xhci_cap_read,
>       .write = xhci_cap_write,
>       .valid.min_access_size = 1,
> -    .valid.max_access_size = 4,
> +    .valid.max_access_size = 8,
> +    .valid.unaligned = true,
>       .impl.min_access_size = 4,
>       .impl.max_access_size = 4,
> +    .impl.unaligned = false,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>
> I think that should keep being valid.  So "valid.unaligned = true" will
> start enable unaligned accesses from the API level which will start to
> follow the xHCI controller's spec, then ".impl.unaligned = false" tells the
> memory core to _not_ pass unaligned accesses to MR ops, instead break them
> down properly.
>
>> MR implementation to be safe when unaligned accessing (current xHCI
>> implementation does not handle unaligned accesses but the spec allows
>> unaligned accesses).
>>
>> In addition, maybe it would be better to document the constraint that
>> the situation where 'valid.unaligned = true' and 'impl.unaligned =
>> false' is not supported.
> Do you perhaps mean this instead?
>
>    valid.unaligned = FALSE && impl.unaligned == TRUE
>
> If so, I agree.  I think we could even consider adding an assertion into
> memory_region_init_io() to make sure it won't be set.
>
> Thanks,
>

I'm sorry if I've misunderstood, but are the following understandings
correct?:
- Need to merge my patch that converts an unaligned access to aligned
   accesses.
- Need to add 'impl.unaligned = true' in the following two places.
   - hw/xtensa/mx_pic.c
   - hw/ssi/npcm7xx_fiu.c
- Add an assertion that to check for invalid patterns, additionally.

Thanks,
Tomoyuki HIROSE


