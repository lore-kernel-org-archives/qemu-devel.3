Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214F5C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXcI-0001Jo-BF; Mon, 27 May 2024 06:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXcC-0001Ig-AR
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:30:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXc7-0006Do-1d
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:30:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420298ff5b1so107862355e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716805794; x=1717410594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iElVtuRS/WVqeJyzKMvqflvv7Y6B69adtgIUrjRs+BU=;
 b=OsxUqq+MrAv/7QNX1zaVldSlG6pmXdP4bYqj5pY+YBhVGiLok6SzX1Bi/SUd3dl/HQ
 37tlr6Tm2m1N0DB43a1EoyhMs7R6LV5XkBdLKh8tAinEYQb+etsocu9cb1svLcNwbPrV
 oIlsDoj/z01ooODHiwBkWKyJl71R++Ry5XaXZTYBLOuNIrhZiSUOFfayrBxgVqv/Hzvy
 ejB2MTFUGZ0XHxNPYb/hkjpCXYoSv4hejL3OI1J2aGCt0xWb2FKrgTPQIqW/GpuwK2wL
 GaLngOt1kExRah/2072iMfpmJwSmgrmMLP83WR71+1nWgwqDOAZ1BxcBNz6O37MjQm5f
 8eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716805794; x=1717410594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iElVtuRS/WVqeJyzKMvqflvv7Y6B69adtgIUrjRs+BU=;
 b=TEi5/XdkzoFdiTFlrT8NEKwECmM7HMeQQsNccPa8EmIeRRURSJuZ/kWgGWUhB1YG8Y
 +zFaAi9TRsx8boTRFIbK04Q0mg4h76RrjL7PHDnwBvzeEXrpR5BGU5PdI4yTd6p0IhSc
 0Y/MSx/MNpc2Jwy4tgbl+tbMOnYoaLlxJkFhisf1SryaW6DQN4TTg0zAJAvcqp9ztW3R
 hgr5eIPTagrZ5GoBMVGmha2dwF2UPjZFFCjc0xmWr8B9YVqI+36m8jCNBpfqsU2uq16+
 fL7s9r6R9XpahaHROj+ib88rDjQm6WceMtn4WnFz5FdtdJ+umTygVFmPua5j4jcVjXQJ
 bTIQ==
X-Gm-Message-State: AOJu0Yz3uD4PeEMGrIspC1UkM0SFciyRwh7Y4NNwjqoK2akd+y3kP7gC
 HI/Cm0C8lFJIapD26r9L8dK8XE27BTQyqgGESPmISA/wRFwtbmsoSqQUukWHlO8=
X-Google-Smtp-Source: AGHT+IH58fafvAUKH+vpT6LtFzBoorNBKfW93x4fVqYy8A/G58Jmyr+Z6lwcMk8APcbhsaIQSY9/Hg==
X-Received: by 2002:a05:600c:228b:b0:41f:ef1e:7314 with SMTP id
 5b1f17b1804b1-42108aa74efmr71983335e9.33.1716805793661; 
 Mon, 27 May 2024 03:29:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f69850sm134380055e9.26.2024.05.27.03.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:29:53 -0700 (PDT)
Message-ID: <11009e2f-36b7-4535-8e9e-1e09ccfed39b@linaro.org>
Date: Mon, 27 May 2024 12:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
To: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Cc'ing a few more Rust integration reviewers :)

On 27/5/24 10:14, Zhao Liu wrote:
> Hi maintainers and list,
> 
> This RFC series attempts to re-implement simpletrace.py with Rust, which
> is the 1st task of Paolo's GSoC 2024 proposal.
> 
> There are two motivations for this work:
> 1. This is an open chance to discuss how to integrate Rust into QEMU.
> 2. Rust delivers faster parsing.
> 
> 
> Introduction
> ============
> 
> Code framework
> --------------
> 
> I choose "cargo" to organize the code, because the current
> implementation depends on external crates (Rust's library), such as
> "backtrace" for getting frameinfo, "clap" for parsing the cli, "rex" for
> regular matching, and so on. (Meson's support for external crates is
> still incomplete. [2])
> 
> The simpletrace-rust created in this series is not yet integrated into
> the QEMU compilation chain, so it can only be compiled independently, e.g.
> under ./scripts/simpletrace/, compile it be:
> 
>      cargo build --release
> 
> The code tree for the entire simpletrace-rust is as follows:
> 
> $ script/simpletrace-rust .
> .
> ├── Cargo.toml
> └── src
>      └── main.rs   // The simpletrace logic (similar to simpletrace.py).
>      └── trace.rs  // The Argument and Event abstraction (refer to
>                    // tracetool/__init__.py).
> 
> My question about meson v.s. cargo, I put it at the end of the cover
> letter (the section "Opens on Rust Support").
> 
> The following two sections are lessons I've learned from this Rust
> practice.
> 
> 
> Performance
> -----------
> 
> I did the performance comparison using the rust-simpletrace prototype with
> the python one:
> 
> * On the i7-10700 CPU @ 2.90GHz machine, parsing and outputting a 35M
> trace binary file for 10 times on each item:
> 
>                        AVE (ms)       Rust v.s. Python
> Rust   (stdout)       12687.16            114.46%
> Python (stdout)       14521.85
> 
> Rust   (file)          1422.44            264.99%
> Python (file)          3769.37
> 
> - The "stdout" lines represent output to the screen.
> - The "file" lines represent output to a file (via "> file").
> 
> This Rust version contains some optimizations (including print, regular
> matching, etc.), but there should be plenty of room for optimization.
> 
> The current performance bottleneck is the reading binary trace file,
> since I am parsing headers and event payloads one after the other, so
> that the IO read overhead accounts for 33%, which can be further
> optimized in the future.
> 
> 
> Security
> --------
> 
> This is an example.
> 
> Rust is very strict about type-checking, and it found timestamp reversal
> issue in simpletrace-rust [3] (sorry, haven't gotten around to digging
> deeper with more time)...in this RFC, I workingaround it by allowing
> negative values. And the python version, just silently covered this
> issue up.
> 
> 
> Opens on Rust Support
> =====================
> 
> Meson v.s. Cargo
> ----------------
> 
> The first question is whether all Rust code (including under scripts)
> must be integrated into meson?
> 
> If so, because of [2] then I have to discard the external crates and
> build some more Rust wheels of my own to replace the previous external
> crates.
> 
> For the main part of the QEMU code, I think the answer must be Yes, but
> for the tools in the scripts directory, would it be possible to allow
> the use of cargo to build small tools/program for flexibility and
> migrate to meson later (as meson's support for rust becomes more
> mature)?
> 
> 
> External crates
> ---------------
> 
> This is an additional question that naturally follows from the above
> question, do we have requirements for Rust's external crate? Is only std
> allowed?
> 
> Welcome your feedback!
> 
> 
> [1]: https://wiki.qemu.org/Google_Summer_of_Code_2024
> [2]: https://github.com/mesonbuild/meson/issues/2173
> [3]: https://lore.kernel.org/qemu-devel/20240509134712.GA515599@fedora.redhat.com/
> 
> Thanks and Best Regards,
> Zhao
> 
> ---
> Zhao Liu (6):
>    scripts/simpletrace-rust: Add the basic cargo framework
>    scripts/simpletrace-rust: Support Event & Arguments in trace module
>    scripts/simpletrace-rust: Add helpers to parse trace file
>    scripts/simpletrace-rust: Parse and check trace recode file
>    scripts/simpletrace-rust: Format simple trace output
>    docs/tracing: Add simpletrace-rust section
> 
>   docs/devel/tracing.rst                 |  35 ++
>   scripts/simpletrace-rust/.gitignore    |   1 +
>   scripts/simpletrace-rust/.rustfmt.toml |   9 +
>   scripts/simpletrace-rust/Cargo.lock    | 370 +++++++++++++++
>   scripts/simpletrace-rust/Cargo.toml    |  17 +
>   scripts/simpletrace-rust/src/main.rs   | 633 +++++++++++++++++++++++++
>   scripts/simpletrace-rust/src/trace.rs  | 339 +++++++++++++
>   7 files changed, 1404 insertions(+)
>   create mode 100644 scripts/simpletrace-rust/.gitignore
>   create mode 100644 scripts/simpletrace-rust/.rustfmt.toml
>   create mode 100644 scripts/simpletrace-rust/Cargo.lock
>   create mode 100644 scripts/simpletrace-rust/Cargo.toml
>   create mode 100644 scripts/simpletrace-rust/src/main.rs
>   create mode 100644 scripts/simpletrace-rust/src/trace.rs
> 


