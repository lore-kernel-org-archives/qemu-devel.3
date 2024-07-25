Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70934C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 06:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWrpO-0002hG-KF; Thu, 25 Jul 2024 02:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWrpN-0002gV-Ou
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:19:49 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWrpL-0006BE-7L
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:19:49 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso8439121fa.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 23:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721888385; x=1722493185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m0UXmcumamfjUjzfgaFUZpl610CiLJrhhjKD1Mn/muU=;
 b=CA+b6h8FXU1d06qqUHvYSh7DWXqmaG9L/Ws86tO5jZBeBawKZNHwiUTnHRjvv5ITDY
 FJb1dVgA0ty/64PBIAHMccW1+KeU7SOsWJP4ufRe06GbD5sEQN9Stf1hkfZuClsIvlLD
 Ct9CJHHxG2D8N3sPihHLCA0ab16vnUsbrqi/L+G7qdpskeXkMhKRkuJvPeHagwzrXZap
 z5NHsnxAOPO9eaLGV2lXHWzizSTXgniiMZQX8l/tbe+hCC/Nod+6YuxybOYsV8NER8I4
 l46nVjuDOp4V6zPuXBcuvvFWb/cVugKvlrwu8Jdd72YhwZLhQcj54zuZ8kBNAI9IthEu
 XJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721888385; x=1722493185;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0UXmcumamfjUjzfgaFUZpl610CiLJrhhjKD1Mn/muU=;
 b=ZOsmxBMlVz8FNirsqtm9JgBqBvH+deJiFGE9Vh4gq2Bqye0Rrspvx7ZQWnfkfwTg/N
 yZPFu/QkL0Uy3jY+4854zTQk93/eS36VFXiT2F6dh095vzWIvljLoJXrS7rHQZHHGzyh
 tUm7+/QfSIVkSr3tjpKUzQv5HEtVj0dQa/AFDByz3n/xxMeyuWRFQJTpf5eZuQT+snc6
 E3tv+VtKQbWzzkoof2Wjyd3Y5BgaeiPxL9wEueGjqIwwCs0buiZ19E3dugUJE5YjBjez
 vwfZ4y9okb87ahUjTWNRLk6bzupBzWLZ7ktPte19niAHpRvz1+2eqRgBoW8QmWv3r6cm
 jwZw==
X-Gm-Message-State: AOJu0Yz3qMRvF26SNYw+7ZQJPAdOj2eKWqBRuXahkg8vNMhc/WsxQAeQ
 YJJGmS76QtI0Y1Row0w2IdAwu/nxy+9fjm8Kan17Bn4UJkCq9FIKMFkn2fHef2U=
X-Google-Smtp-Source: AGHT+IGMRQcpevm+Lp3ilyc0t/LoZE6GIFv1iwtJlw8Y829Fzeuwzqi8kHtJp7vlM8wRHDX5Q46PPQ==
X-Received: by 2002:a2e:a376:0:b0:2ee:7d37:49bd with SMTP id
 38308e7fff4ca-2f039cdfff7mr12856911fa.22.1721888384363; 
 Wed, 24 Jul 2024 23:19:44 -0700 (PDT)
Received: from meli-email.org (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590d76sm459794a12.24.2024.07.24.23.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 23:19:44 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:47:40 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qeemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
In-Reply-To: <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
Message-ID: <h61ku.ipxyjqsxu75@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x234.google.com
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

On Wed, 24 Jul 2024 13:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Wed, Jul 24, 2024 at 11:58 AM Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>> >In my opinion we should start with cargo workspaces as the
>> >known-imperfect (but good enough) solution, so that it could be evolved
>> >later.  It is important that any change that deviates from common Rust
>> >conventions is documented, and v4 provided a nice basis to build upon,
>> >with documentation coming as things settle.  This is why I explicitly
>> >didn't include Kconfig in the TODO list in my review of v4.
>>
>> After working with the latest meson releases, it seems we will soon have
>> a good enough way of handling all this with meson. It makes me sceptical
>> of adding cargo wrappers and using a build system out of meson when we
>> might be able to drop all that soonish. We might as well bite the bullet
>> now to avoid working on something we know we will remove.
>
>Ehh, as you say below it's complicated. Sometimes worse is better.
>Personally I wouldn't have minded keeping the v4 approach as a "known
>evil"; but if you can make the Cargo subprojects work, that would be
>fine for me. What I don't like is the vendoring and handwritten (I
>think?) meson.build, I think that's worse than the v4.
>
>> >Also, of the code changes (as opposed to the build system changes) that
>> >I had asked for in the review of v4, almost none of them have been
>> >applied.  I'm copying them here for future reference:
>>
>> Thanks, this helps a lot.
>>
>> >❌ TODO comments when the code is doing potential undefined behavior
>>
>> Do you mean like Rust's safety comments?
>
>No I meant comments where we have known instances of undefined
>behavior. The two I had in my emails are
>
>(in pl011_init):
>// TODO: this assumes that "all zeroes" is a valid state for all fields of
>// PL011State. This is not necessarily true of any #[repr(Rust)] structs,
>// including bilge-generated types. It should instead use MaybeUninit.
>
>(before the call to qemu_chr_fe_accept_input):
>// TODO: this causes a callback that creates another "&mut self".
>// This is forbidden by Rust aliasing rules and has to be fixed
>// using interior mutability.

You mean that we can have a call stack that looks something like...

<qemu code>
|_ pl011_read
  |_ PL011State::read()
     |_ qemu_chr_fe_accept_input()
      |_ pl011_read
        |_ PL011State::read()

If I understand correctly, this does not create another "&mut self", 
because a mutable reference of self is passed to 
qemu_chr_fe_accept_input(), and only exists until it returns.

In any case, I agree that these subtleties must be examined thoroughly 
in general. In this case though PL011State has only Copy fields and no 
side effects when dropped. This means that adding interior mutability 
e.g. with Cell would have exactly the same behavior.

But your bringing it up makes me wonder whether we can detect any bad 
behaviors with miri... It does not play well with FFI boundaries but 
it's possible to mock them in some cases. I will look into the two TODOs 
you mention and also if it's possible to verify the correct behavior 
whenever possible!


>
>> https://std-dev-guide.rust-lang.org/policy/safety-comments.html
>>
>> These can be required by lints which is really helpful. At this point
>> the UART library has safety comments (which needs to be reviewed for
>> validity). I plan on adding some at the macros in qemu-api as well.
>>
>> >
>> >❌ a trait to store the CStr corresponding to the structs
>>
>> I don't know yet if that is helpful in our usecase, because the strings
>> must be visible from C, thus be (rust, not c) statics, unmangled and
>> marked as #[used] for the linker. It makes sense from the Rust POV but
>> must also be FFI-accessible.
>
>Why do they have to be #[used]? You have
>
>+                #[used]
>+                static TYPE_NAME: &::core::ffi::CStr = $tname;
>+                $tname.as_ptr()
>
>but since the cstr crate (and c"" literal) promise to return a
>&'static CStr, I thought it could be just
>
>    $tname.as_ptr()
>
>About traits, I meant something like
>
>pub unsafe trait ObjectType: Sized {
>     const TYPE_NAME: &'static CStr;
>}
>
>So that you can put the trait declaration in the pl011 crate and the
>type_info! macro can do
>
><$t as ObjectType>::TYPE_NAME.as_ptr()
>
>(also for the parent).

That was my approach at the beginning but I was having issues with the 
linker stripping the <some const value>.as_ptr() and it would point to 
invalid memory; I checked it again and I think using #[used] just for 
the TypeInfo struct declaration might be enough so these can be removed.

>
>> >❌ a trait to generate all-zero structs without having to type "unsafe {
>> >MaybeUninit::zeroed().assume_init() }"
>>
>> Traits cannot have const fns at the moment (traits cannot have
>> type-level effects like const or async but it's WIP to get them into
>> rustc), so this cannot be used for statics and consts.
>
>Ah, I see. Anyhow, I've been looking at the Linux kernel's pinned-init
>crate (https://rust-for-linux.com/pinned-init) and it provides a
>Zeroable macro including #[derive] support. So that has gone lower in
>my priority.
>
>> >❌ I'd like to use ctor instead of non-portable linker magic,
>>
>> The linker sections are pretty much standard and in fact ctor uses the
>> same linker attributes. Would writing our own constructor macro be a
>> solution for you? My reasoning is that 1) we support our own specific
>> platforms and it's better for portability to reflect that in our source
>> tree and 2) it avoids the external dependency, linker sections do not
>> change so any ctor update would be in the API or adding more platform
>> support,  not fixes in what we target.
>
>I'd still like to give someone else the burden. :) Writing our own
>constructor macro would be more work for little gain.

Well, it's just that I personally don't view adding __attribute__ 
manually in only two places is a burden but I've no strong preference 
over it.

I'm looking at the ctor dependencies and they are a few:
https://github.com/mmastrac/rust-ctor/blob/cc3ab9160ed9dc3bdf20d735352b519abc2913e9/Cargo.lock

Do you perhaps agree with adding a FIXME comment to replace the linker 
attributes with ctor when we get the cargo dependency story in meson 
sorted out?

Manos

