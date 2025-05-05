Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E01C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 13:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBw85-0005Z0-E0; Mon, 05 May 2025 09:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uBw83-0005Xf-WD; Mon, 05 May 2025 09:45:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1uBw80-0003Kb-TG; Mon, 05 May 2025 09:45:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso40676235e9.3; 
 Mon, 05 May 2025 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746452702; x=1747057502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=R/BWpzrI2AEDQAX4gOs0GXLgtTs2Bpzo+sRZblVyG+I=;
 b=WqIQZJfdwEFMqYmBF0pS7KgYiTbCiUe+mTIHyVoNPlT6L1yooMd4q3Np7e5nBZcO3U
 An/0JLJCq49Po+ipZWa9Fn6sBgNLbjBMSa7Jzz+1kORFnE7DiKKDwYdvNIZttD1bpOWM
 iX8qE/IMFyUhJM8pOL3TSkL/FpUro13DeCoOiQZiFz/qQh2BxUW15UYkPvsfZkTCCJxv
 cSaFUeSdRRE8oh2fmdHToYpiG4MZcSTHzogD84sr7skV6nNfaN47/bbVndKb7ExDpagG
 BayL4IeQ5xZe7v6RQokt84ATNrdAj2O/VjwluMzDylj5LkgjEvGhG8mTy4de4mNpKnxG
 3VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746452702; x=1747057502;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/BWpzrI2AEDQAX4gOs0GXLgtTs2Bpzo+sRZblVyG+I=;
 b=mE2HlleYHaVvPwBoFE0s0hl2iKCOKdQHWuUjGncWowsLveHov83BL5WtGc4zhyQDrb
 7gjRgeC0DGqWBZcl6OFng2xvzyo1QUV/sjebQ1uubcK3V60Irdwa2ezeN8smBu6MwcPg
 z6QIKAw1N4YxvxfpYjpyq8DPoW+fBx3rzBfrSJpWj1LfYcaQF+mX/dRBHD8M1PslGXjr
 /m+sS8j5NhabDgPuePRxvcCp0KnR5+6rdxYSpu/6gyLXjUytjuy1yNjyzbTnAIay1E/Y
 60jL+LF36hkQM3rZjtVb5rLEKdAAU0cSkTkubzALNRdccqXANfBn+nK3zDVcG22LDomb
 gl4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZR5rlU5TYscahaG9XgM9nK3dOijvoGU/R5aqmNQZ8eW7lziPF2QwmxGZjPY3Y2ApfYPk0Q8FNJw0=@nongnu.org
X-Gm-Message-State: AOJu0YzB7NHQBErghZqZlx8AwFbsata0fdlhlXfv1DB9NhyGm1ow76Ck
 cQPvCUrbpnWbIuFRd4CjmRX+DM0sLMplJLlFSGPhSVhePVf9y41zbPMeVA==
X-Gm-Gg: ASbGncsQ1cafj4TQvO6+0iWJpkGbWAUQhM4RmNUfUqQ66vvKTaCN2v7NCu7zR2NZUje
 DpL/UqESexNymzLhfaM/JuhG4IgtpZralERyw4IVGEZBLn4nFORkO0SQd3/FR1GzPILbzMDuQwk
 +JJBvGE4utsBq6kO7yEbHlzSdFDKmdEBQAX+DtBcBT3D3Mez4jcT0b6XnWx6y5/hJaO5SOKjtdB
 z1YSZs7voMxy3DSPohayGcItxXdBPltmEf3LzCZ3KwYfyrt26zaoZfPtuOO8iia+ircDh21T2al
 /NxqaFDRa7sb47ozEFb7S+1Eo8TOsna9lzzqFzDP8HYT84vpXg==
X-Google-Smtp-Source: AGHT+IGOiVvOuJ1CvdeyG/+JzO8VNLxmF8VZ1P2oRq2vEuZtfC4kEdfIKfUwqFDEko+Bw7yEWVCNyg==
X-Received: by 2002:a05:600c:4e88:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-441c48bdfe5mr63798295e9.10.1746452701678; 
 Mon, 05 May 2025 06:45:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-441b89ee39esm133392855e9.21.2025.05.05.06.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 06:45:00 -0700 (PDT)
Message-ID: <7101782c-f642-41e6-8f3a-7061ca722c99@gnu.org>
Date: Mon, 5 May 2025 15:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust in QEMU update, April 2025
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <CAAjaMXZhq_uv-w_9TT3++HAcO7r_OhriJA0RKWs8YqY_ryjK4w@mail.gmail.com>
From: Paolo Bonzini <bonzini@gnu.org>
Content-Language: en-US
Autocrypt: addr=bonzini@gnu.org; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0f
 UGFvbG8gQm9uemluaSA8Ym9uemluaUBnbnUub3JnPsLBTQQTAQIAIwUCVEJ7AwIbAwcLCQgH
 AwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEH4VEAzNNmmxNcwOniaZVLsuy1lW/ntYCA0Caz0i
 sHpmecK8aWlvL9wpQCk4GlOX9L1emyYXZPmzIYB0IRqmSzAlZxi+A2qm9XOxs5gJ2xqMEXX5
 FMtUH3kpkWWJeLqe7z0EoQdUI4EG988uv/tdZyqjUn2XJE+K01x7r3MkUSFz/HZKZiCvYuze
 VlS0NTYdUt5jBXualvAwNKfxEkrxeHjxgdFHjYWhjflahY7TNRmuqPM/Lx7wAuyoDjlYNE40
 Z+Kun4/KjMbjgpcF4Nf3PJQR8qXI6p3so2qsSn91tY7DFSJO6v2HwFJkC2jU95wxfNmTEUZc
 znXahYbVOwCDJRuPrE5GKFd/XJU9u5hNtr/uYipHij01WXal2cce1S5mn1/HuM1yo1u8xdHy
 IupCd57EWI948e8BlhpujUCU2tzOb2iYS0kpmJ9/oLVZrOcSZCcCl2P0AaCAsj59z2kwQS9D
 du0WxUs8waso0Qq6tDEHo8yLCOJDzSz4oojTtWe4zsulVnWV+wu70AioemAT8S6JOtlu60C5
 dHgQUD1Tp+ReXpDKXmjbASJx4otvW0qah3o6JaqO79tbDqIvncu3tewwp6c85uZd48JnIOh3
 utBAu684nJakbbvZUGikJfxd887ATQRUQnHuAQgAx4dxXO6/Zun0eVYOnr5GRl76+2UrAAem
 Vv9Yfn2PbDIbxXqLff7oyVJIkw4WdhQIIvvtu5zH24iYjmdfbg8iWpP7NqxUQRUZJEWbx2CR
 wkMHtOmzQiQ2tSLjKh/cHeyFH68xjeLcinR7jXMrHQK+UCEw6jqi1oeZzGvfmxarUmS0uRuf
 fAb589AJW50kkQK9VD/9QC2FJISSUDnRC0PawGSZDXhmvITJMdD4TjYrePYhSY4uuIV02v02
 8TVAaYbIhxvDY0hUQE4r8ZbGRLn52bEzaIPgl1p/adKfeOUeMReg/CkyzQpmyB1TSk8lDMxQ
 zCYHXAzwnGi8WU9iuE1P0wARAQABwsEzBBgBAgAJBQJUQnHuAhsMAAoJEH4VEAzNNmmxp1EO
 oJy0uZggJm7gZKeJ7iUpeX4eqUtqelUw6gU2daz2hE/jsxsTbC/w5piHmk1H1VWDKEM4bQBT
 uiJ0bfo55SWsUNN+c9hhIX+Y8LEe22izK3w7mRpvGcg+/ZRG4DEMHLP6JVsv5GMpoYwYOmHn
 plOzCXHvmdlW0i6SrMsBDl9rw4AtIa6bRwWLim1lQ6EM3PWifPrWSUPrPcw4OLSwFk0CPqC4
 HYv/7ZnASVkR5EERFF3+6iaaVi5OgBd81F1TCvCX2BEyIDRZLJNvX3TOd5FEN+lIrl26xecz
 876SvcOb5SL5SKg9/rCBufdPSjojkGFWGziHiFaYhbuI2E+NfWLJtd+ZvWAAV+O0d8vFFSvr
 iy9enJ8kxJwhC0ECbSKFY+W1eTIhMD3aeAKY90drozWEyHhENf4l/V+Ja5vOnW+gCDQkGt2Y
 1lJAPPSIqZKvHzGShdh8DduC0U3xYkfbGAUvbxeepjgzp0uEnBXfPTy09JGpgWbg0w91GyfT
 /ujKaGd4vxG2Ei+MMNDmS1SMx7wu0evvQ5kT9NPzyq8R2GIhVSiAd2jioGuTjX6AZCFv3ToO
 53DliFMkVTecLptsXaesuUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
In-Reply-To: <CAAjaMXZhq_uv-w_9TT3++HAcO7r_OhriJA0RKWs8YqY_ryjK4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x329.google.com
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

On 5/5/25 14:26, Manos Pitsidianakis wrote:
>>     Something I do notice is that there's some inconsistency in
>>     how we've structured things between the two devices, e.g.:
>>
>>     * the pl011 main source file is device.rs, but the hpet one
>>       is hpet.rs
>>
>>     * some places we use the actual names of bits in registers
>>       (eg Interrupt's OE, BE, etc consts), and some places we
>>       seem to have renamed them (e.g. pl011 Flags has clear_to_send
>>       not CTS, etc)
>>
>>     * pl011 has defined named fields for its registers, but hpet does
>>       things like::
>>
>>          self.config.get() & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
>>
>>     * pl011 has a split between PL011State and PL011Registers,
>>       but HPET does not. As I mentioned in an email thread a
>>       little while back, I feel like the State/Registers split
>>       is something we should either make a more clear deliberate
>>       formalised separation that's part of how we recommend
>>       device models should be designed
>>
>>     [...]
>>
>>     I think it would be good to figure out what we think is the
>>     right, best style, for writing this kind of thing, and be
>>     consistent. We have long standing problems in the C device
>>     models where there are multiple different styles for how
>>     we write them, and it would be good to try to aim for
>>     more uniformity on the Rust side.
> 
> The pl011 stuff was deliberate decisions:
> 
> - device.rs vs pl011.rs: the device was written as a crate, so it's
> essentially its own library, plus pl011/src/pl011.rs would be
> redundant :)

Right, I think Peter's comment was more about moving hpet.rs to 
device.rs, and merging PL011's device_class.rs into its device.rs.

>    That said, it's not important, we can choose either convention. I
> like the less redundancy and separation of concerns: if pl011 gets
> converted into a module in a future refactor, it could keep its
> functionality split into different submodules and `pl011.rs` or
> `pl011/mod.rs` would be the device module.

I think it's okay to decide that Rust devices will have mini 
directories: it's just the style of the language and Cargo more or less 
relies on having lib.rs.

In a vacuum I would prefer to have hw/char/pl011.rs for what is now 
rust/hw/char/pl011/lib.rs, and place the other files in hw/char/pl011; 
IIRC rustc accepts that style.  However we still rely on Cargo for some 
things(*), and as long as we do there's not much we can do about it.

     (*) notably "cargo fmt".  Everything else is more or less handled
         by Meson starting with 1.8.0.

> - Using typed registers instead of constants: yes coming from C I can
> understand it can feel unfamiliar. I specifically wanted to make the
> register fields typed to avoid making the implementation a "C port",
> and I think it's worthwhile to use the type system as much as
> possible.

Peter's comments (especially the second and third) were about two kinds 
of inconsistencies:

1) HPET not using bilge.  This was because Zhao looked at HPET from the 
opposite direction compared to what you did on pl011, namely avoiding 
unsafe and modeling the BQL properly, and sacrificed a bit the usage of 
idiomatic code like what bilge provides.

I think that you made the right choice for the first device and he made 
the right choice for the second device.  But now someone should look at 
HPET and do the work that you did to adopt bilge.

2) The choice between bilge on one side, and bitflags or integers on the 
other.  For pl011 you kept interrupt bits as integers for example, and 
this is related to the topic of (non-)availability of const in traits...

>    A straight C port would result into integer constants with integer
> typed fields everywhere for registers/flags.
>    Yes, From/Into aren't const, at least yet, but it's not really a
> hotpath performance wise. I think non-dynamically dispatched trait
> methods can be inlined by annotating the `fn from(..)` impl with a
> `#[inline(always)]` hint but I haven't confirmed this, just
> speculation.

It's not about hot paths, it's more that 1) you cannot use From/Into in 
a "static"'s initializer 2) bilge relies a lot on non-const methods in 
its internal implementation, which makes it quite messy to use it in 
some places.  See for example this thing for which I take all the blame:

     impl Data {
         // bilge is not very const-friendly, unfortunately
         pub const BREAK: Self = Self { value: 1 << 10 };
     }

and the same would be true of interrupt constants and the IRQMASK array.

The separate bilge and bitflags worlds are what bothers me the most in 
the experimental devices.  I can see why they would be very confusing 
for someone who's not had much experience with Rust, and therefore 
doesn't know *why* they are separate.

>    Again, no strong opinions here. I like the "everything is typed"
> approach and I think it's worth it to explore it because it allows us
> to "make invalid/illegal states unrepresentable" as one sage article
> goes.

I agree, and it's why I think you made the right choice using it for 
pl011.  With all the unsafe code that you had to use, strong-typing at 
least showed *something* that Rust could provide compared to C(*).  And 
I like the strong typing too, even if I'm not sure I like bilge's 
*implementation* that much anymore.

I'm not really up for rewriting it, but then I've also done more stupid 
rewrites in the past. :)

    (*) when we were discussing safety vs. unsafety last summer, I may
        have sounded dismissive of this kind of benefit.  My point at the
        time was that unsafe code was so much more complex than C, that
        the benefit of strong-typing wasn't enough to *offset* the
        complexity of unsafe code.  But it is absolutely present.

>> Related to this I have found recently the `attrs crate
>> <https://docs.rs/attrs/>`__, which provides an easy way to parse the
>> contents of attributes in a procedural macro.
> 
> I actually have some WIP patches for this I put a pause on and can
> continue e.g. https://gitlab.com/epilys/rust-for-qemu/-/commit/c2c97caaaf03273fabc14aee5a4d1499668ddbe3

The repository is private, but I look forward to seeing it!  If you want 
to post an RFC without even any code, just to show what the device code 
looks like, that would be helpful as it will catch stuff like lack of 
type safety.

BTW, if you need it to model reflection better I think it is acceptable 
to assume const_refs_to_static is present.

Paolo

