Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2D1D0C5F4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Ghl-00080j-Nd; Fri, 25 Oct 2024 05:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Ghk-00080a-25
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Ghg-0002dk-8K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729848819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HcXhPsTVug1I+o4IwdymSg2AguRbNt1geNhEj8TaX+4=;
 b=F4pgSeGScQVFT52TkSFWwrnPH9PHOcoQ/e5S8K0j+6wRqnyRtSo2xx8mCtXb2UfT8EcRnS
 e7IHO366aB/dVunnWVpj93iOYSvhNJfVsG2Bwg8rdSlsCcIhE5pin9lCM9EXpo0/d/hUSJ
 +XlR/TFRovEAUs5l4lp4RcvlZiu51V8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-J4tt5cRNP5GR2I6jrDDfjA-1; Fri, 25 Oct 2024 05:33:38 -0400
X-MC-Unique: J4tt5cRNP5GR2I6jrDDfjA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so17320175e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 02:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729848817; x=1730453617;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HcXhPsTVug1I+o4IwdymSg2AguRbNt1geNhEj8TaX+4=;
 b=cBSufLN6Nn9vgoYOoHP3PwwabEY63zKJ9ajKjr2RlGN3425WVf9fwqYt4RFAs7rIRm
 npG6MH84Ccas2IysPL+iPE1JrjH4odWJoIau+pl0WIfz4fu9VWxWcNRsPMfOmd6nZUl7
 D55qBfkCJzBS+A34yzmImiz0gXqPiij15OSBUUoqEOK/Xsnw1+wyU3RhgWKPnCf40I2/
 4bhgmhkEsdA1tiasxCaCdAqRx/hsoTJ/pK2rkKRFP5F+AGd1+UgDuSm7O0eUtYuXoYxJ
 t1WROrxmG5YZLfNa9b0NDsjp6w0oohiWsABuyKfPDYCZCuEEygWtQw+NpHyR/YjmP0+B
 8bwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeVsZs2U0MAEUJi1ADYrj1UVyGyWXJ+CxAWN47L4wvQKlNw8Jil053j3XiRy8Q+tYHfCyP14FB5Icg@nongnu.org
X-Gm-Message-State: AOJu0YxRNVPe/0JWguJ85p63JY7KBDLL6jlxvEFc+etwXxLrlZtyuGrw
 MIZn1yzgdUCasn/TZGH85963vw2Hp8PMH7nNZdXUcb+zJzb+eS2zF426i7XKLz40EiigbAQ9CNC
 gPbfXB2fZd0wdEfwXpgF41OTCXGFjpVMuQX3sPqoad4h0ZoAcfgSR
X-Received: by 2002:a05:600c:1c92:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-4318421133amr104201905e9.16.1729848815524; 
 Fri, 25 Oct 2024 02:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF1Fuw57v81IgSOOhxEa19Gh/K7Ok24Lw1IBefgzWOgSI+YmWWVm9hrR7ATZtpKBskr2r/og==
X-Received: by 2002:a05:600c:1c92:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-4318421133amr104200665e9.16.1729848813622; 
 Fri, 25 Oct 2024 02:33:33 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-431935f74b6sm12361655e9.33.2024.10.25.02.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 02:33:33 -0700 (PDT)
Message-ID: <e8e55772-906b-42cb-a744-031e6ae65f16@redhat.com>
Date: Fri, 25 Oct 2024 11:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Rust device model patches and misc cleanups
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/24/24 16:02, Manos Pitsidianakis wrote:
> Hello everyone, the pathological corrosion of QEMU code continues.
> This series expands the device model harness work performed in the
> initial Rust work from the previous month. In particular:

Wow, there's a lot of stuff here!

The very good news is that it's basically all the code that is needed to 
get CI running, after which we can start with the fun stuff.  At the 
same time, "the fun stuff" is also the one that risks introducing 
technical debt, so we need to switch to quality-over-quantity mode and 
have a serious design discussion about it.  I'll do that later as a 
reply to the patches.

>    Code and functionality duplication is not fun, and pl011 was mostly
>    done as a proof of concept for a Rust device because of its small
>    complexity. As of this moment we have not decided on a policy for how
>    to handle these things and it is not in **scope for this patch series
>    anyway**.

That's fine.

Looking at the currently posted series, it seems that we have three main 
themes:

1) small scale cleanups: duplicated and useless code, improved testing. 
These are in 
https://lore.kernel.org/qemu-devel/20241021163538.136941-1-pbonzini@redhat.com/T/ 
and they have been reviewed already.  But these two:

>        Revert "rust: add PL011 device model"
>        rust: add PL011 device model

... should definitely be moved on top to clean up the authorship in "git 
blame" and other similar tools.  Sorry about that.

2) allow using older rustc/bindgen, extend CI to cover it.  This is 
https://lore.kernel.org/qemu-devel/20241022100956.196657-1-pbonzini@redhat.com/T/ 
which still needs review.  These five:

>        rust: add support for migration in device models
>        rust/pl011: move CLK_NAME static to function scope
>        rust/pl011: add TYPE_PL011_LUMINARY device
>        rust/pl011: remove commented out C code
>        rust/pl011: Use correct masks for IBRD and FBRD

(minus the usage of #[derive()] should be included in that series, so 
that qtests pass.  It's not a huge amount of work and I can extract it, 
of course with proper attribution/authorship.

The rest are future work:

>        rust/qemu-api-macros: introduce Device proc macro

This is useful as a starting point but it has the limit of being very 
device-specific.  This is of course okay with properties and vmstate, 
but in my opinion the implementation of class_init should be as generic 
as possible, and not too specialized for methods in Object or Device.

As I said above, we first need to agree on the design.

>        rust/pl011: move pub callback decl to local scope

This depends a lot on how we go implementing bindings to chardev.  For 
example if the callbacks turn out to be a trait, it would have to be 
undone.  Possibly the C callback wrappers would move to 
rust/qemu-api/chardev.  For now I'd leave it aside.

>        rust/qemu-api: add log module
>        rust/pl011: log guest/unimp errors

This also needs design discussion.  Do we want the API to be the same as 
C, i.e. keep the qemu_* prefix?  Do we want wrapper macros that include 
the format!() call?

You also have "pub enum LogMask" to work around the fact that log masks 
are preprocessor macros.  Is that okay, or do we want to modify C code 
to make the bindings nicer?  I for example would prefer the latter and 
then declaring LogMask as a bitfield in bindgen.

Thanks,

Paolo

> 
>   rust/wrapper.h                                |   1 +
>   rust/hw/char/pl011/src/device.rs              | 419 +++++++++++++++++---------
>   rust/hw/char/pl011/src/device_class.rs        |  70 -----
>   rust/hw/char/pl011/src/lib.rs                 |   2 +-
>   rust/qemu-api-macros/src/device.rs            | 370 +++++++++++++++++++++++
>   rust/qemu-api-macros/src/lib.rs               |  46 +--
>   rust/qemu-api-macros/src/object.rs            | 107 +++++++
>   rust/qemu-api-macros/src/symbols.rs           |  57 ++++
>   rust/qemu-api-macros/src/utilities.rs         | 152 ++++++++++
>   rust/qemu-api-macros/src/vmstate.rs           | 113 +++++++
>   rust/qemu-api/meson.build                     |   5 +-
>   rust/qemu-api/src/definitions.rs              |  97 ------
>   rust/qemu-api/src/device_class.rs             | 128 --------
>   rust/qemu-api/src/lib.rs                      |  10 +-
>   rust/qemu-api/src/log.rs                      | 140 +++++++++
>   rust/qemu-api/src/objects.rs                  |  90 ++++++
>   rust/qemu-api/src/tests.rs                    |  49 ---
>   rust/qemu-api/src/vmstate.rs                  | 403 +++++++++++++++++++++++++
>   subprojects/packagefiles/syn-2-rs/meson.build |   1 +
>   19 files changed, 1726 insertions(+), 534 deletions(-)
> ---
> base-commit: 55522f72149fbf95ee3b057f1419da0cad46d0dd
> change-id: 20241024-rust-round-2-69fa10c9a0c9
> 
> --
> γαῖα πυρί μιχθήτω
> 
> 
> 


