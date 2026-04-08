Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D510F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYVi-00040U-MJ; Wed, 08 Apr 2026 15:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wAY5V-0006qj-C4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wANDX-0003xz-T6
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775632849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=twdGdBtz2kX5U5UkdpyX22YjC51uThdM2w2+VBziNvg=;
 b=AXLFWAS3pBhAkxr6h018v0ccTcgn5khLxsRiDg8/PAPvoe2dXchYgf2pvjvzl+F8iihqut
 7XwdXGZ1/zG+/Zpgfi+pFzVbMwfxPJLMAM4cy+0872uwQecHKHlb8vJCLS2OKEZHqJlSXH
 y6IHquV+AF2jbTx5ETTcJfvjOt08caM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-43EFxCbsM6CYfZzH-2ELhg-1; Wed, 08 Apr 2026 03:20:47 -0400
X-MC-Unique: 43EFxCbsM6CYfZzH-2ELhg-1
X-Mimecast-MFC-AGG-ID: 43EFxCbsM6CYfZzH-2ELhg_1775632846
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488ac66236bso4058465e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 00:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775632846; x=1776237646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=twdGdBtz2kX5U5UkdpyX22YjC51uThdM2w2+VBziNvg=;
 b=mr9MsH0SJBipbloOb8whjq5/IO8DYADw+ZKu6b/t/Ds1O+pmmrmIho3pZqJROggJsx
 dtRDwN+NhD18s0Ff4GI73fg3WFROk3cu3E63h92u552H7jq6NG9GUP93J+4zK7gV6ZFA
 23gFI6a/WZONY9ZxiQPnNayQwboqUafh8iPIjmamnuJeN6S/OJ9tpFozl8/n5h2nmJq6
 ngWhKOX4x09AcR7HUU9r+lrvQdPEHvfqqhymPCwJHSP9YJjAPJagmLrurh2YNdMGqB8q
 Ba1sFZNrV+ugcskgdU+l/ZmUpjgusoMNYh0XZDVCvIYdY00pKFAXp039DIrOIm+sAePr
 BYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775632846; x=1776237646;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twdGdBtz2kX5U5UkdpyX22YjC51uThdM2w2+VBziNvg=;
 b=tFkZH8VlqoHdegFSm1cV5yZiD2i4+MScPJgDGx7d5ex/P71EM5F+VxXIv/AB+Km6M4
 94zmEvNK9Nnxi4PhHAyu9QTvJJ8KTVnw/XjH8havsw/IOxDA+K+Axl5mBv18GMlSQHZ5
 ZmT9hAr2bx/ksrvpmqmtwn2QshF1zJV0fe9qtgKCllXkFJV1dJI9IqCSKdB+UIjE3W26
 Ficd2DQdowHGGWRl7XwCSCSBa2EiAWtZGrwlKcjEC3ZoPt6HtyiUJ7xXpcmVGrjaOup8
 EzGg/xYr44oLKfZZEXNh876Vy2+Vrum5IOkE0nEaTRNYQWcnQoQl4MS7XxlmabnUiWlr
 yxHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJg8Xe7EAJMCGycy1BtllmimD1H0VVwZMOXWXK/cdn6Rg0D1qj78lFMji4s61lcuLMA7qXfahgYLP0@nongnu.org
X-Gm-Message-State: AOJu0YwdsEziPewAJqOoX2vuuFGqcosvm+3JTYpmv9r/2MAbzpZvNLtY
 Qc88OeWGdGzJcCIIeK1ijBqsh4/tUrS5HtvYuh1zVs1nDN6dSJ2zrHPjnwHboNz8SmXm4KwB0Aw
 jv8rAPWz6HA4ZtLFEc85ZHXCKaDAeOszHFG1tkUjzHr+RszNhStV3Y24X
X-Gm-Gg: AeBDievtd45oxDMrH4JSoo6hGoHdl2iT6O1uHTA04CQ8cfwzoNnqqe+1T02dL0tY/uk
 eIUM3h7R6yqHU/xQSrdQa7a2gFS9dhzJv1zH3xHQvcrHPyOqlkNOMImCi5Ulb3w7e7NNeIwJkJy
 76h6jQ4Gz1lSS32DSrxi8OTq4DLjsi/5ppcHA5ghOpiER/4ZOAO/GAryPb6uOipWYwMQci3qIOh
 Pqurtbvo0aFEXepWUPcwuH08iI0EDzB/18BOVUlZ3N5AZ0H1rz2oKHPc5LtwiaPKuYG96gGsnMk
 eS0r4rw8TkPILBT6UehWcgQbWq20ixCqzMht/EqNII7u69K1hYcC2VxNYxC11OjGJQLGxbNtT9Q
 0Yj/voCh9DNYyvkjSFw==
X-Received: by 2002:a05:600c:450d:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-4889946a42emr70910145e9.4.1775632846012; 
 Wed, 08 Apr 2026 00:20:46 -0700 (PDT)
X-Received: by 2002:a05:600c:450d:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-4889946a42emr70909945e9.4.1775632845579; 
 Wed, 08 Apr 2026 00:20:45 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a7165aasm616071755e9.14.2026.04.08.00.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 00:20:45 -0700 (PDT)
Message-ID: <c0f772d0-e4dd-4334-bfd2-8ac8da1c9032@redhat.com>
Date: Wed, 8 Apr 2026 09:20:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
 <33ec528c-30e7-4d77-a9ef-c29c00aedc26@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <33ec528c-30e7-4d77-a9ef-c29c00aedc26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/04/2026 06.47, Pierrick Bouvier wrote:
> Hi everyone,
> 
> On 4/2/26 4:20 AM, Peter Maydell wrote:
>> On Thu, 2 Apr 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> This is a follow-up to my 3-years old patch series here, now with the
>>> universal binary initiative in mind:
>>>
>>>   https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html
>>>
>>> This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
>>> (by renaming or symlinking the binary to "qemu-system-i386" or something
>>> similar with a "-i386" suffix). After doing this, qemu-system-x86_64
>>> should be a full superset of qemu-system-i386 (apart from 32-bit KVM
>>> support, which however is not required anymore now that we removed support
>>> for 32-bit hosts). It is now possible to migrate a guest that has been
>>> started with an old "qemu-system-i386" binary to a qemu-system-x86_64
>>> binary that has been renamed with a "-i386" suffix.
>>
> 
> Thanks for posting this Thomas.
> 
>> I think my reaction here is similar to what it has been when
>> the similar idea has been raised for qemu-system-arm : we should
>> have a coordinated plan that is considering all architectures,
>> not just dropping a single binary for one architecture where
>> it happens to be more straightforward.
>>
> 
> There are two things to consider for this series, and we should clarify what 
> it is trying to do.
> 
> The first one is the possibility to have a single-binary. The second one is 
> to reduce the number of binaries qemu officially have. It does not impact 
> the number of targets, since 32-bit ones will still be supported.

Agreed, thanks for pointing this out, Pierrick!

Given the fact that the patch for declaring qemu-system-i386 as deprecated 
seems to have rather caused mixed feelings, I think we'd should rather 
postpone that discussion and focus on the patches that will be useful for 
the universal binary.

...
> Let's fast forward 5 years in the future and imagine that all QEMU targets 
> are integrated in the single-binary. Once it is done, we know that all files 
> in target/X/* will be compiled only once, and integrated selectively for 32- 
> bit or 64-bit targets. The key to understand is that in this setup, choosing 
> to keep the 32-bit does not change anything. Technically, it will just be a 
> simple target-info file, representing this 32-bit target, and a symlink for 
> representing the target binary. All the rest will already be common with 64- 
> bit.
> 
> With this projection in mind, I wonder what is the concrete value to make 
> any proper plan to deprecate 32-bit targets, since in the end, it won't 
> matter if they are present or not.
> 
> What are your thoughts?
> Which value would we get from deprecating 32-bit targets when possible?

My concern with the i386 target is that you have to maintain the clunky 
additional vmstates for migration forever that way. It's just ugly, for very 
low benefit here (who is *really* still using the i386 32-bit target in 2026?).

Also maintaining additional 32-bit targets increases our test matrix, i.e. 
we could shorten our CI times if we remove it one day.

So let's keep this in mind. We don't have to deprecate the 32-bit targets 
right now, but if it's bothering us again in the future, we might want to 
reconsider to deprecate them.

  Thomas


