Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EDDC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHg6a-0001YH-8s; Thu, 13 Jun 2024 04:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHg6R-0001Y0-SX
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:46:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHg6P-0006kF-43
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:46:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35e1fcd0c0fso657060f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718268395; x=1718873195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FMSlVwRCDPbsieYEYVIGAiP75H/g8EUlPmOhTqo+iuY=;
 b=ig4naBKl3De9dq40J3mJ32evwR9NmicO7u3W8cKkkhzRJf3oz03Kr4Qrs2Ui8HiAlW
 29uKJeGEmHfQr6m83HilufiRAzaWT0QCZO6S1PcKl8XIB1S1iSQHVOyf39LpH6fF3HgU
 l6Gmw6yI40Dk5jNvwWyJ8EJbSJnn4mE+cKZG2R9kGnTtIt53Hd6IEQwCGR6hl5Q4EJzr
 cqGrb6eGidmyOrxyrF0cK7fy89aTJD0isGbaMSRxi4yyx+fofpbqi9Vd9XdwIZ0y0OJp
 d9uufw/6hUpt6aNTc388U/IB8+kgsbv81gIW5/0Rw/VWDHQStIw01n8nPfb+JDLFiTqa
 ydFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718268395; x=1718873195;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FMSlVwRCDPbsieYEYVIGAiP75H/g8EUlPmOhTqo+iuY=;
 b=dc8aZQod2BwuVLht7GhHKwPvQNiOePfg6yXb770vGp/AnUnuDjQesKUAq3L7IhMhKf
 rbybf/pDQGFq9cP+PR5F+e0KDSwJchUiu64et+fYy7OjK4/JPtu/EEIEBAXjMbs41G6h
 Ylsx0KlinCR6/JIErqefUc8+ARC7HWeL4qvxhPo1YHVdXc4Wj/0YG02kva2C+u9dqs1S
 8Smnbg6YYGOmDMsvxn0yGEtm0fgFzidsFWQm7zCgSTeG/84H4Pss46QgTeVApGQxPnmp
 vmmr03xkVtRjWEStwDS1g7ddWLMchiOKj7cHJPYRbDpqrO3KdgYLsuzNgpaMQwnHsQh/
 5Ckw==
X-Gm-Message-State: AOJu0Yx7iw8ZGYwgqBEhZeCUdvubY7l5vcMXf0oXK7dclswr8IUkCK4k
 3dkl6KPm3HA+2j5VfgqINNue0q0eJ9jmMTXhQ70ItsiEoPablwX0WlHjoR0y48k=
X-Google-Smtp-Source: AGHT+IH03dDfrq+8McBUuNBclJw3CHQRWtxUflkq2KxRtXFNy7hKBMAvi165HUS+69uiisccFLEZAg==
X-Received: by 2002:a5d:6d87:0:b0:35f:18be:2275 with SMTP id
 ffacd0b85a97d-35fdf779da7mr3950689f8f.6.1718268395056; 
 Thu, 13 Jun 2024 01:46:35 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093a29sm1031899f8f.12.2024.06.13.01.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 01:46:34 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:41:38 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <ZmquNSnnVSdOe0Z3@intel.com>
In-Reply-To: <ZmquNSnnVSdOe0Z3@intel.com>
Message-ID: <f0gdl.ugeo9rfbpd5e@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

Hello Zhao :)

On Thu, 13 Jun 2024 11:30, Zhao Liu <zhao1.liu@intel.com> wrote:
>On Tue, Jun 11, 2024 at 01:33:32PM +0300, Manos Pitsidianakis wrote:
>> Date: Tue, 11 Jun 2024 13:33:32 +0300
>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Subject: [RFC PATCH v2 3/5] rust: add PL011 device model
>> X-Mailer: git-send-email 2.44.0
>> 
>> This commit adds a re-implementation of hw/char/pl011.c in Rust.
>> 
>> It uses generated Rust bindings (produced by `ninja
>> aarch64-softmmu-generated.rs`) to
>> register itself as a QOM type/class.
>> 
>> How to build:
>> 
>> 1. Make sure rust, cargo and bindgen (cargo install bindgen-cli) are
>>    installed
>> 2. Configure a QEMU build with:
>>    --enable-system --target-list=aarch64-softmmu --enable-with-rust
>> 3. Launching a VM with qemu-system-aarch64 should use the Rust version
>>    of the pl011 device (unless it is not set up so in hw/arm/virt.c; the
>>    type of the UART device is hardcoded).
>> 
>>    To confirm, inspect `info qom-tree` in the monitor and look for an
>>    `x-pl011-rust` device.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>
>Hi Manos,
>
>Thanks for your example!
>
>> diff --git a/rust/pl011/Cargo.toml b/rust/pl011/Cargo.toml
>> new file mode 100644
>> index 0000000000..db74f2b59f
>> --- /dev/null
>> +++ b/rust/pl011/Cargo.toml
>> @@ -0,0 +1,66 @@
>
>...
>
>> +[lints]
>> +[lints.rustdoc]
>> +broken_intra_doc_links = "deny"
>> +redundant_explicit_links = "deny"
>> +[lints.clippy]
>> +# lint groups
>> +correctness = { level = "deny", priority = -1 }
>> +suspicious = { level = "deny", priority = -1 }
>> +complexity = { level = "deny", priority = -1 }
>> +perf = { level = "deny", priority = -1 }
>> +cargo = { level = "deny", priority = -1 }
>> +nursery = { level = "deny", priority = -1 }
>> +style = { level = "deny", priority = -1 }
>> +# restriction group
>> +dbg_macro = "deny"
>> +rc_buffer = "deny"
>> +as_underscore = "deny"
>> +assertions_on_result_states = "deny"
>> +# pedantic group
>> +doc_markdown = "deny"
>> +expect_fun_call = "deny"
>> +borrow_as_ptr = "deny"
>> +case_sensitive_file_extension_comparisons = "deny"
>> +cast_lossless = "deny"
>> +cast_ptr_alignment = "allow"
>> +large_futures = "deny"
>> +waker_clone_wake = "deny"
>> +unused_enumerate_index = "deny"
>> +unnecessary_fallible_conversions = "deny"
>> +struct_field_names = "deny"
>> +manual_hash_one = "deny"
>> +into_iter_without_iter = "deny"
>> +option_if_let_else = "deny"
>> +missing_const_for_fn = "deny"
>> +significant_drop_tightening = "deny"
>> +multiple_crate_versions = "deny"
>> +significant_drop_in_scrutinee = "deny"
>> +cognitive_complexity = "deny"
>> +missing_safety_doc = "allow"
>
>...
>
>> diff --git a/rust/pl011/rustfmt.toml b/rust/pl011/rustfmt.toml
>> new file mode 120000
>> index 0000000000..39f97b043b
>> --- /dev/null
>> +++ b/rust/pl011/rustfmt.toml
>> @@ -0,0 +1 @@
>> +../rustfmt.toml
>
>...
>
>> diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
>> new file mode 100644
>> index 0000000000..ebecb99fe0
>> --- /dev/null
>> +++ b/rust/rustfmt.toml
>> @@ -0,0 +1,7 @@
>> +edition = "2021"
>> +format_generated_files = false
>> +format_code_in_doc_comments = true
>> +format_strings = true
>> +imports_granularity = "Crate"
>> +group_imports = "StdExternalCrate"
>> +wrap_comments = true
>> 
>
>About the Rust style, inspired from the discussion on my previous
>simpletrace-rust [1], it looks like people prefer the default rust style
>and use the default check without custom configurations.
>
>More style requirements are also an open, especially for unstable ones,
>and it would be better to split this part into a separate patch, so that
>the discussion about style doesn't overshadow the focus on your example.
>
>[1]: https://lore.kernel.org/qemu-devel/ZlnBGwk29Ds9FjUA@redhat.com/
>

I had read that discussion and had that in mind. There's no need to 
worry about format inconsistencies; these options are unstable  -nightly 
only- format options and they don't affect the default rust style (they 
actually follow it). If you run a stable cargo fmt you will see the code 
won't change (but might complain that these settings are nightly only).

What they do is extra work on top of the default style. If anything ends 
up incompatible with stable I agree it must be removed, there's no sense 
in having a custom Rust style when the defaults are so reasonable.

To sum it up, the style is essentially the default one, so there's no 
problem here!

Manos

