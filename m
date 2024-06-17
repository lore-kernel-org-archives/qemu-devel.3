Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B481C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJKAW-0001Bo-Oh; Mon, 17 Jun 2024 17:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJKAW-0001Bc-4i
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:45:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sJKAU-0000Ha-6b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:45:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3608e6d14b6so1559196f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718660735; x=1719265535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7A5WiMp1B5sTrr/9+84Yjesf0yhlnw+PKRMYT9BBA0g=;
 b=goRpluvUF5J5w+ZpzB0zLFBo3fOSeestRQxf+wWpqSzfCcGLTKm89DM+gK1HI1XlkB
 HZmnozmZAXwT2WuymPJXOB2zQa9x9cX+TGixkYykEQg5uOdN4F7fPB0QC4muRWMRZYaL
 TDwzXEkAb91dFQ2dfQ03h0wMwJOKk6y3v0GBeXTu39x8sDAfltJgDX8PYfZBIzGOn5cQ
 ePs9r/Lxs/UBF0ACG0thOMaMNWioC7cz11zxYLFNhNBF6WMbZj8VnrkkysEWo9pf25XR
 9xhHBL6pPAsDx4ekr57Vh+XV1Dlna8vEuRZpqsRf8mZqXBVDK2DJ6cZcN+N86Z59SDHp
 0xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718660735; x=1719265535;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7A5WiMp1B5sTrr/9+84Yjesf0yhlnw+PKRMYT9BBA0g=;
 b=v3NrlzCGd46VuonuOoYXx+BtbZOMQL0wlMWb2agU+UyhIt/4ARie2JoEZ0sMrX5WI/
 KYCympR597+yrud4MN40tXK4IELPEYALlq7VYwzWdpgmvPDnKeRObwg4JRfripdcq0gO
 7AaIJxgnQTxd2T8i9hg/7lpGMtPm/qtBxtkUwdh2XGOC2Q7vgmq3A2pr1cDisBQ87nR7
 IVaWV8xE7F8k5ZD/5h7T0VTRNvcbxIESyb9crKBxFEH/HZS0KFaei6O2P2vSB3STgZDc
 Vz2wDTYWQMABIsszkKCmo5NG2/jY+RnshlUcoJ5hEDAVCd7uJDOQxsG/Uj29/KiKo8Ic
 1blA==
X-Gm-Message-State: AOJu0YwaqV+pUN+SvT+GzVKuSfjVohn4WQKjuvRKv5xnmIJpS8mKX1Ia
 xUSZf2HtKoEV2HqJV41GEoP2NWFrMZ7Th77Q44sMpyD0ejQaZOP7/OWmKwfUo8raDsDzTN+FXjv
 Kt7M=
X-Google-Smtp-Source: AGHT+IHBRZGMRhd6wHxckYzGkf4/w3QIVv27lfriIDf4kSYZF5DNSn0XFyStFaSRvqr8b74dBEJeDQ==
X-Received: by 2002:a05:6000:256:b0:360:7395:5aef with SMTP id
 ffacd0b85a97d-3607a762470mr6967015f8f.34.1718660734891; 
 Mon, 17 Jun 2024 14:45:34 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3609d31433dsm1437306f8f.5.2024.06.17.14.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 14:45:34 -0700 (PDT)
Date: Tue, 18 Jun 2024 00:04:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Alex Benn=?UTF-8?B?w6k=?= e" <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
 <f7vmg.s9przvzs9y9y@linaro.org>
 <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
 <f89qp.6kmlv39qhntz@linaro.org>
 <CABgObfYj3F6aoefBgcHcjkwDqK6kcDGUfPZtRbFzB5abXShfbA@mail.gmail.com>
In-Reply-To: <CABgObfYj3F6aoefBgcHcjkwDqK6kcDGUfPZtRbFzB5abXShfbA@mail.gmail.com>
Message-ID: <f8v3w.uqub97dfqvvo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 17 Jun 2024 17:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Mon, Jun 17, 2024 at 4:04 PM Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>> I respectfully disagree and recommend taking another look at the code.
>>
>> The device actually performs all logic in non-unsafe methods and is
>> typed instead of operating on raw integers as fields/state. The C stuff
>> is the FFI boundary calls which you cannot avoid; they are the same
>> things you'd wrap under these bindings we're talking about.
>
>Indeed, but the whole point is that the bindings wrap unsafe code in
>such a way that the safety invariants hold. Not doing this, especially
>for a device that does not do DMA (so that there are very few ways
>that things can go wrong in the first place), runs counter to the
>whole philosophy of Rust.
>
>For example, you have:
>
>    pub fn realize(&mut self) {
>        unsafe {
>            qemu_chr_fe_set_handlers(
>                addr_of_mut!(self.char_backend),
>                Some(pl011_can_receive),
>                Some(pl011_receive),
>                Some(pl011_event),
>                None,
>                addr_of_mut!(*self).cast::<c_void>(),
>                core::ptr::null_mut(),
>                true,
>            );
>        }
>    }
>
>where you are implicitly relying on the fact that pl011_can_receive(),
>pl011_receive(), pl011_event() are never called from the
>MemoryRegionOps read() and write() callbacks. Otherwise you'd have two
>mutable references at the same time, one as an argument to the
>callbacks:
>
>   pub fn read(&mut self, offset: hwaddr, ...
>
>and one from e.g. "state.as_mut().put_fifo()" in pl011_receive().
>
>This is not Rust code. It makes no attempt at enforcing the whole
>"shared XOR mutable" which is the basis of Rust's reference semantics.
>In other words, this is as safe as C code---sure, it can use nice
>abstractions for register access, it has "unsafe" added in front of
>pointer dereferences, but it is not safe.
>
>Again, I'm not saying it's a bad first step. It's *awesome* if we
>treat it as what it is: a guide towards providing safe bindings
>between Rust and C (which often implies them being idiomatic). But if
>we don't accept this, if there is no plan to make the code safe, it is
>a potential huge source of technical debt.
>
>> QEMU calls the device's FFI callbacks with its pointer and arguments,
>> the pointer gets dereferenced to the actual Rust type which qemu
>> guarantees is valid, then the Rust struct's methods are called to handle
>> each functionality. There is nothing actually unsafe here, assuming
>> QEMU's invariants and code are correct.
>
>The same can be said of C code, can't it? There is nothing unsafe in C
>code, assuming there are no bugs...

Paolo, first please tone down your condescending tone, it's incredibly 
offensive. I'm honestly certain this is not on purpose otherwise I'd not 
engage at all.

Secondly, are you implying that these callbacks are not operated under 
the BQL? I'm not seeing the C UART devices using mutexes. If they are 
not running under the BQL, then gladly we add mutexes, big deal. Just 
say this directly instead of writing all these amounts of text. If it's 
true I'd just accept it and move on with a new iteration. Isn't that the 
point of code review? It is really that simple. Why not do this right 
away? I'm frankly puzzled.

Finally, this is Rust code. You cannot turn off the type system, you 
cannot turn off the borrow checker, you can only go around creating new 
types and references out of raw memory addresses and tell the compiler 
'trust me on this'. Ignoring that misses the entire point of Rust. The 
statement 'this is not Rust code but as good as C' is dishonest and 
misguided. Check for example the source code of the nix crate, which 
exposes libc and various POSIX/*nix APIs. Is it the same as C and not 
Rust code?

If you have specific scenarios in mind where such things exist in the 
code and end up doing invalid behavior please be kind and write them 
down explicitly and demonstrate them on code review. This approach of 
'yes but no' is not constructive because it is not addressing any 
specific problems directly. Instead it comes out as vague dismissive FUD 
and I'm sure that is not what you or anyone else wants.

Please take some time to understand my POV here, it'd help both of us 
immensely.

Sincerely thank you in advance,
Manos

