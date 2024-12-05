Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7731DE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEim-0001bx-D1; Thu, 05 Dec 2024 11:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJEij-0001bW-Mx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJEih-0000vL-LJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733416130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dyuZQedkGWeC/t5RhOgZnANiZAS48OwM1oe3H7aK0iE=;
 b=R4SS2dHe7eKwe+nFev4D6xWfuxydq1jFKKCW48xLMh6aFcG0QZWqPK+nBnf0gKnLmGnLSv
 p8S0KQ9MUUVFL2U8J+kGoCvmfo/yhRQfW5/QXGMwXIdj42tcLQ6x1yyu66Mr5jo1m4p7lG
 c3mwsW8LcyOiOx9B4kEgil9u68q+Uhg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-h2A4vr0iMQS-0ZW5h8d-9Q-1; Thu, 05 Dec 2024 11:28:48 -0500
X-MC-Unique: h2A4vr0iMQS-0ZW5h8d-9Q-1
X-Mimecast-MFC-AGG-ID: h2A4vr0iMQS-0ZW5h8d-9Q
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-466bfd1d101so37741771cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 08:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733416128; x=1734020928;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dyuZQedkGWeC/t5RhOgZnANiZAS48OwM1oe3H7aK0iE=;
 b=auboYRdA9ngJhVdqIh4E3MlqmXJQO1QgFOQHm7aGBbpQ4D7JopWeVboiDcSgoKVC1e
 8RbbK5XwqjjQWuqDAgeDGvf/AfwlHcu72mNt5UXGuEWPx/nA/OTfqxZc/DlR7X0Sm2Tl
 HFejcDFDTSlVGXYBVm1a9BlXUNQiAEQIieMhl6UNWhUDwY1KFXM7ICYbq6bWRzgO6l5m
 ui4FoQxzfb0WmVjlWZhCrSfynpMMxrOuwkN4v3/oGJoWvKafR1+8zTEifSeDTMu9coKe
 JGsNytqzTnmxGJOtG2cbCeGMDt0PFhSvv453IwKIpSr+G7BzexgMIRTPnEUPrNwWt/xa
 bemw==
X-Gm-Message-State: AOJu0Yxhbugmu8oNQmxtaIG9KIzLHC/yi5qiIKV3ARvmG0w9xh0DuuGb
 oRiY7XXL+3VXF8CZes4FUvoQVQyLmlmwRsiTroATZHu5z1+qYlk0rq+Swmvm8k1JXS+2156PaBL
 lJea+s4sxNHMQ1S7O6A1HKSgNAFYKVCxJBb/3X5qH2FkIzRqy5eibh7e9NQkr
X-Gm-Gg: ASbGncs5Je+1l2gnRGyLmhETybZuatD/3kB8VQlMGWimQTqbIHqXbwt+eP7IaDuJFPu
 YFI8tXeCqtHA5toCmz7FoOELAyj9Nv1bB6zn5Yyp5d+c4NEygWEhzCSBHwamWAY1gSGgdH0ibCr
 7WArtD8Uh1X4kx3rzkirJLtGwVgTETjsNjEosvu0CK3YH4YN9t9K9jlZsIP+yB+mouA6gxVh5YT
 fLquODRLa6w6LKG5Y1P0fsdpOxXg8IeNdfSWDTFPJ0FuMiguq7QQc23Rw==
X-Received: by 2002:ac8:5781:0:b0:463:5261:366f with SMTP id
 d75a77b69052e-46727a76916mr59843461cf.23.1733416127755; 
 Thu, 05 Dec 2024 08:28:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKtDx8eeoZYIr+DatVQOMragStw4tldrSxKVpdZ7JUQEdHxZ0slxSxIOwhLl8lgc6BECCjtA==
X-Received: by 2002:ac8:5781:0:b0:463:5261:366f with SMTP id
 d75a77b69052e-46727a76916mr59843161cf.23.1733416127378; 
 Thu, 05 Dec 2024 08:28:47 -0800 (PST)
Received: from [192.168.101.123] ([144.121.20.163])
 by smtp.googlemail.com with ESMTPSA id
 d75a77b69052e-467296f4429sm9429601cf.41.2024.12.05.08.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 08:28:46 -0800 (PST)
Message-ID: <2f42c553-5673-4826-bc2f-14ec1306e8c0@redhat.com>
Date: Thu, 5 Dec 2024 17:28:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/13] rust: Reinvent the wheel for HPET timer in Rust
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/5/24 07:07, Zhao Liu wrote:
> * Proper bindings for MemoryRegionOps, which needs to wrap the ram
>    read/write callbacks.
>    - I think it shouldn't be complicated because qom/qdev already
>      provides good examples.

Sounds good, I have some initial work on PL011.

> * vmstate support.
>    - vmstate code for HPET is actually ready, but it will be pending (and
>      maybe re-writing) until the vmstate infra gets cleaned up.

Yeah, mostly due to the cells.

> * Error handling.
>    - Now HPET just use panic and println to replace error_setg and
>      warn_report.
> 
> * Trace support.
>    - No trace for now.

> Anything that needs to be modified within a callback should be protected
> by BqlCell/BqlRefCell.
> 
> Based on this, I am also considering how the opaque parameter in certain
> callbacks should interact with BQL cells. In the timer binding (patch
> 7), I think the opaque parameter accepted by the timer callback should
> be placed in a BQL cell. However, considering generality, I did not make
> further changes and only passed BqlRefCell<HPETTimer> as the opaque
> parameter in the HPET code.

That sounds good.

I'll review your timer bindings and post the infrastructure that I have 
for callbacks.

> Furthermore, is it possible in the future to wrap the entire state
> within a BQL cell? This could save the effort of wrapping many state
> members individually when state becomes very huge and complex.

I think it's better if we keep a split between the mutable and immutable 
parts.  For example properties are immutable.

> QDEV Property
> -------------
> 
> To support bit type property, I added another macro variant (in patch 8)
> to allow bitnr parameter. However, I think this lacks scalability.
> 
> In qdev-properties.h, it is clear that the PropertyInfo of a property is
> bound to its type. Previously, Junjie and I attempted to do the same in
> Rust by binding PropertyInfo to the type, thereby avoiding the need to
> specify too many parameters in the macro definitions:
> 
> https://lore.kernel.org/qemu-devel/20241017143245.1248589-1-zhao1.liu@intel.com/

Oops, sorry.  I have applied patch 1, but patch 2 is a bit problematic 
because I think it's not const-friendly.  Maybe it was applied to older 
code?

I haven't looked closely at whether it's possible to use trait { ... 
const TYPE: &Property = ... }, maybe only in newer Rust?  But as you 
point out there is an issue with multiple PropertyInfos that can apply 
to the same type, therefore I think the way to go here is to use a 
procedural macro and a #[property] attribute.  That also makes bit 
properties easy:

     #[property(bit=0, name="foo")
     #[property(bit=1, name="bar")
     features: u32,

> MEMTXATTRS_UNSPECIFIED
> ----------------------
> 
> MEMTXATTRS_UNSPECIFIED is another global variable. Since it is
> immutable, BQL cell is not needed.
> 
> But MemTxAttrs is a structure with bitfields, and the bindings generated
> by bindgen can only be modified through methods. Therefore, it is
> necessary to introduce lazy to initialize MEMTXATTRS_UNSPECIFIED in a
> const context (patch 6).

Ugh, that's a pity.  Maybe instead of introducing a new dependency we 
can use an always-inlined function?

In an ideal world, bindgen would produce const functions.  A hackish but 
easy possibility is to modify the generated bindgen code (with sed? :)) 
to apply const to the bitfield functions.

> Cycle Reference
> ---------------
> 
> A common pattern in QEMU devices is that a sub-member of the state
> contains a pointer to the state itself.
> 
> For HPETState, it maintains a HPETTimer array, and each HPETTimer also
> has the pointer to parent HPETState. So there's the cycle reference
> issue.
> 
> The common way to address this is to use RefCell<Weak<>> [2], but in
> practice, I found it's difficult to be applied in device code. The
> device instance is not created in Rust side, and there's only init()
> method to initialize created device instance. This way, it's hard to be
> compatible with the pattern of creating weak references (at least I
> failed).
> 
> Then, I chose NonNull to address this issue, as recommended by the
> author of NonNull and the standard collections [3].

NonNull is okay for now.  Later on we will handle it with pinned_init.

However, do not get a &mut HPETState, everything should go through 
&HPETState and cells.

> Therefore, I believe that in Rust devices, QOM members should also be
> kept private or at most `pub(crate)`. This is also why I tried to avoid
> using direct `pub` in HPET.

Yes, I agree.  I should look at unnecessarily pub things in pl011.

Paolo


