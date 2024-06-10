Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E971CC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 20:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGlcN-0007i3-E4; Mon, 10 Jun 2024 16:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGlcL-0007hU-IG
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:27:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGlcJ-0007G3-9o
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 16:27:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35dc1d8867eso3809527f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718051265; x=1718656065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=F4btwY1OOhYMjhjvHvI+WM4FJW5cja8mm7X+5eEKt1o=;
 b=q/a/+sBREUEYhvpac/f/MQCSHFrzL4Nt6JXbFueHCczwMN4uMCpOjPh2KUQEdEIuO6
 7eQ/oZp7+ghLgVc57ykBhYUYMhrKpSEmYp9HscSwTFJRrMlzd6S27oycUjIjNcCzOkmL
 aNlGRHSx/ygcqSqZ3X2gI6CVUGqdCzWicBBVU1P5k5AJ5kHVNk42bUVPgcwHpKBHSf9v
 6GIlyQc9h6rT3eWSFUVmpzzfiAh7bUQN/kpc4wFmgT+O+PWpSMpe7GtdAwNX/qq94Ua5
 Q8iEB9i8CEmvhaUUz7ehXgwti4vrtJFZQDGXf5+Nr01k2s0zPCtvTRrwOar9EgvP1MMH
 CemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718051265; x=1718656065;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F4btwY1OOhYMjhjvHvI+WM4FJW5cja8mm7X+5eEKt1o=;
 b=KZ4tZWVdBSg5mFoLzZ5BFxQBGklSsLm7G8baWVXyBKiDxYakXytuOUrAMkGUSGFPdG
 7nC6nQnQIVBkktJkTH/qHtSvq2ho7mA9ZNpBPcDYLf2r/regf+aQ5lKQeWAd7elPfSLW
 +PqLQb2U/5b7tIXvqKB1Jl8kJrnA48sid1BZk+WnzQcEMJkpAGsWw2qjkJXHurhU77KM
 s3rIPNTF6oqKiSsZUo3cwa4C6SGk+Z8S71EPaTg0QzZOnflAJ2VoxVyyF9Pm5yKhjgXP
 2wTYQdjdPIgMzXuL9Euc8luLbjnSMrgCps4MipTrldSs9Q10jHCBfoAm4Nxg0aIfkdCi
 SgBw==
X-Gm-Message-State: AOJu0Yz04x6kuHGFX7E3iUpx5vIYIamuu/5Xhu99OCS/4KLbYXdfgwPb
 2fG7Sghm9/5N6qeN24m0TmGVrlGOJba7PiSD9nCw/wefxZUyapV+E1zr3VTvYDo=
X-Google-Smtp-Source: AGHT+IF0aoLUg6K85Obccggxh5PwBTXOaPl0RZF/45ScGhLvIxvoB/4qaBBlnRIlj2mWGBwgltsm7w==
X-Received: by 2002:a05:6000:2ae:b0:35f:2092:193a with SMTP id
 ffacd0b85a97d-35f209219efmr4018644f8f.32.1718051265182; 
 Mon, 10 Jun 2024 13:27:45 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d2da31sm11822963f8f.14.2024.06.10.13.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 13:27:44 -0700 (PDT)
Date: Mon, 10 Jun 2024 23:15:07 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
In-Reply-To: <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
Message-ID: <evsu7.aus3yo6r56i@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

On Mon, 10 Jun 2024 22:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> What are the issues with not using the compiler, rustc, directly?
>> -----------------------------------------------------------------
>> [whataretheissueswith] Back to [TOC]
>>
>> 1. Tooling
>>    Mostly writing up the build-sys tooling to do so. Ideally we'd
>>    compile everything without cargo but rustc directly.
>
>Why would that be ideal?

It remove the indirection level of meson<->cargo<->rustc. I don't have a 
concrete idea on how to tackle this, but if cargo ends up not strictly 
necessary, I don't see why we cannot use one build system.

>
>>
>>    If we decide we need Rust's `std` library support, we could
>>    investigate whether building it from scratch is a good solution. This
>>    will only build the bits we need in our devices.
>
>Whether or not to use std is a fundamental decision. It might be
>difficult to back from std later on. This is something that should be
>discussed in more detail.
>
>Do you want to avoid std for maximum flexibility in the future, or are
>there QEMU use cases today where std is unavailable?

For flexibility, and for being compatible with more versions.

But I do not want to avoid it, what I am saying is we can do a custom 
build of it instead of linking to the rust toolchain's prebuilt version.

>
>>
>> 2. Rust dependencies
>>    We could go without them completely. I chose deliberately to include
>>    one dependency in my UART implementation, `bilge`[0], because it has
>>    an elegant way of representing typed bitfields for the UART's
>>    registers.
>>
>> [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
>>      Crates.io page: https://crates.io/crates/bilge
>>      Repository: https://github.com/hecatia-elegua/bilge
>
>I guess there will be interest in using rust-vmm crates in some way.
>
>Bindings to platform features that are not available in core or std
>will also be desirable. We probably don't want to reinvent them.


Agreed.

>
>>
>> Should QEMU use third-party dependencies?
>> -----------------------------------------
>> [shouldqemuusethirdparty] Back to [TOC]
>>
>> In my personal opinion, if we need a dependency we need a strong
>> argument for it. A dependency needs a trusted upstream source, a QEMU
>> maintainer to make sure it us up-to-date in QEMU etc.
>>
>> We already fetch some projects with meson subprojects, so this is not a
>> new reality. Cargo allows you to define "locked" dependencies which is
>> the same as only fetching specific commits by SHA. No suspicious
>> tarballs, and no disappearing dependencies a la left-pad in npm.
>>
>> However, I believe it's worth considering vendoring every dependency by
>> default, if they prove to be few, for the sake of having a local QEMU
>> git clone buildable without network access.
>
>Do you mean vendoring by committing them to qemu.git or just the
>practice of running `cargo vendor` locally for users who decide they
>want to keep a copy of the dependencies?


Committing, with an option to opt-out. They are generally not big in 
size. I am not of strong opinion on this one, I'm very open to 
alternatives.


>>
>> Should QEMU provide wrapping Rust APIs over QEMU internals?
>> -----------------------------------------------------------
>> [qemuprovidewrappingrustapis] Back to [TOC]
>>
>> My personal opinion is no, with the reasoning being that QEMU internals
>> are not documented or stable. However I do not see why creating stable
>> opt-in interfaces is bad. It just needs someone to volunteer to maintain
>> it and ensure there are no breakages through versions.
>
>Rust code will need to interface with QEMU's C APIs, so Rust wrappers
>seem unavoidable. Using a protocol like vhost-user might be possible
>in some cases. It separates the two codebases so they can both be
>native and without bindings, but that won't work for all parts of the
>QEMU source tree.
>
>Stable APIs aren't necessary if most developers in the QEMU community
>are willing to work in both languages. They can adjust both C and Rust
>code when making changes to APIs. I find this preferable to having
>Rust maintainers whose job is to keep wrappers up-to-date. Those Rust
>maintainers would probably burn out. This seems like a question of
>which approach the developer community is comfortable with.


Me too.

>
>>
>> Will QEMU now depend on Rust and thus not build on my XYZ platform?
>> -------------------------------------------------------------------
>> [qemudependonrustnotbuildonxyz] Back to [TOC]
>>
>> No, worry about this in some years if this experiment takes off. Rust
>> has broad platform support and is present in most distro package
>> managers. In the future we might have gcc support for it as well.
>>
>> For now, Rust will have an experimental status, and will be aimed to
>> those who wish to try it. I leave it to the project leaders to make
>> proper decisions and statements on this if necessary.
>
>This can be discussed in a separate email thread if you prefer, but I
>do think it needs agreement soon so that people have the confidence to
>invest their time in writing Rust. They need to know that the code
>they develop will be available on most platforms where QEMU is
>available and that others in the community won't object or insist on a
>C implementation for platform support reasons.

Definitely, also it's out of scope for this RFC since we're not writing 
and rules/guidelines yet.

>
>>
>>
>> How is the compilation structured?
>> ==================================
>> [howisthecompilationstructured] Back to [TOC]
>>
>> First, a meson target that runs `bindgen` on a bunch of header files
>> (defined in `rust/wrapper.h`) is created as a target and as a dependency
>> for any rust hardware device that needs it. You can see the generated
>> bindings by running
>>
>>   ninja generated.rs
>>
>> inside your build directory.
>>
>> The devices are defined as dictionaries in rust/meson.build because they
>> depend on the bindgen dependency, which is available much later in the
>> meson process (when the static qemu lib and target emulator executables
>> are defined).
>>
>> A cargo wrapper python script under scripts/ exists to build the crate
>> library, by providing the path to the generated.rs bindings via the
>> environment. Then, the qemu-system-aarch64 binary links against the
>> staticlib archive (i.e. libpl011.a)
>>
>> The generated.rs rust file includes a bunch of junk definitions?
>> ================================================================
>> [generatedrsincludesjunk] Back to [TOC]
>>
>> Yes, bindgen allows you to block certain types and identifiers from
>> being generated but they are simply too many. I have trimmed some of the
>> fat but vast improvements can be made.
>>
>> The staticlib artifact contains a bunch of mangled .o objects?
>> ==============================================================
>> [staticlibmangledobjects] Back to [TOC]
>>
>> Yes, until we compile without the `std` module library or we compile it
>> manually instead of linking it, we will have some junk in it.
>
>What is the consequence of this? As long as the linker is bringing in
>.o files from the .a only through symbol dependencies, then unused .o
>files in the .a won't be linked into the final QEMU binary.

No consequence, I just want to warn anyone peeking into the rust output 
(not the final qemu binary) to expect junk.

