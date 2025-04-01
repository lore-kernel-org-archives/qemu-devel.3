Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72403C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza3P-00031h-KV; Tue, 01 Apr 2025 07:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tza3H-0002c5-0e; Tue, 01 Apr 2025 07:45:07 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tza3E-0003kq-MN; Tue, 01 Apr 2025 07:45:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso11575152a12.1; 
 Tue, 01 Apr 2025 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743507901; x=1744112701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkjqRIowxFnTqYWsqxNLtB4fGkcNFUW57Tm2wP1HwOA=;
 b=N+WZwHE9RUYSLzjZzxMSHmEIkViaoWLohO81uBAelc2QF/WMtBYuOBHZV6pXJBEmml
 R0335FIwOtKY4BAuinNytiiLtfzdHzuAGA2dBdhajS4kAXj2CsArLs6WTWKFmcuNcKCH
 eaWtPti6/rQKaoAF2/1j/GiVSgDd+23Xdv/Yri0tGDjxgxNZxC9HgZGBPhMy0sOKIduB
 Av38dZ3M3UnEXdAHWI3nbuV1aoaen9Iux4n5CbQNieu4BXj3B4eEOsiiV8G6ZEgDVPNJ
 BsKY2MxWJESxrtZr6ooI1d4g7C1LN8LzWy+juNrljl0eKST8pm6FyrDTlRcjfC4B2/xy
 pn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507901; x=1744112701;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkjqRIowxFnTqYWsqxNLtB4fGkcNFUW57Tm2wP1HwOA=;
 b=Z1cwKwlQk0vc6HMA641I0grAmwj2S8C8i756XmRjNfOr/OTMVxo7TyihtUAFc39U6W
 uYM49Awh7ynyU5l60BbPnud/mbFMB51CnYunmoB/wtq+dxLBhXwAEhHivsCvR89nyR+W
 05TFp31jTNxB2duQInZlPkENKBkWm0UFd3lKfTWDjw1Ato4WZWKlNKBFxYXrclcDj+8L
 TAoLaYNVVaJfrmsLFWB1Dlpkhd6C48i4Yd468gaPX5a6O+szB8cDzuR0N8WZpaf317qE
 dAzX71zSMSA4qi8FE4ytJr3IO4DcrOlmiJWaxRJQODXqDbTfQfxzvEcUA/YU5Cnu1gh9
 6Ulg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPjam1i5OdwFODxCwH+uHeWr2e/vBH2b8t2AxhaTGLZ8K6f5M7z0I8SWP7ca9ZyWBZieSqLhzqaIpg@nongnu.org,
 AJvYcCWkJzjW1f2TQTMtavJfkFjJg6a/nrlNZV03c3GvgJQOgbz7D3/gW8ebacFQWXx90j6tsKuXbyLcrkEl@nongnu.org
X-Gm-Message-State: AOJu0YwoPOV0N7eD2DW08+JwpMnGy/3BW1QNzuNDdSqrUcVetPXMtKbQ
 IntF/z4B0i/Qj7bc9DOyx2ZpPB461bU1WcZMGnHdpiJDNznAUb3s
X-Gm-Gg: ASbGncuiAUb1BCX67Kl63poHJkAvavNTaDLFEDGblzXiKWvRl6cBHTwJoGNkLfJRdO/
 exNMQiBm3zQDFi6u7nqkebiR73TFORZGgdfGdfJVZgb57ZiGtm3M8A9ZzXKkCFIgev+pLteEEPO
 nvnGFk2Aq1F2eyypVdxgvlNRZJq3cYH2LZS79l/PFd0ytLrd/bqnMRCxhpiwuDwqJDeYE3brRlp
 ZJ+coquB4z6C1/GwnTra/+LY3fXehOHSY7pIhM3SeoG6OSnG+chrPdUMCxmP/KIU8R5EcR12iAx
 kk0ZDchiMGlaqv5ErPY6hl1ypzT+X52mXyxDKUkS
X-Google-Smtp-Source: AGHT+IHiedffj/SqKwpxqtaZ6rV/M49KooBe+OYB0KXRjJ5whYSY3LK9aNzukVhDCtvBzkiixZnsUw==
X-Received: by 2002:a05:6402:35ca:b0:5ec:cb95:c3ce with SMTP id
 4fb4d7f45d1cf-5edf5321d0dmr10770071a12.1.1743507900947; 
 Tue, 01 Apr 2025 04:45:00 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc16f02bdsm7009754a12.43.2025.04.01.04.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:45:00 -0700 (PDT)
Date: Tue, 01 Apr 2025 10:51:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_rust/qemu-api=3A_Add_i?=
 =?US-ASCII?Q?nitial_logging_support_based_on_C_API?=
In-Reply-To: <340649cf-9348-458d-97e7-aee73c02217c@redhat.com>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-2-shentey@gmail.com>
 <340649cf-9348-458d-97e7-aee73c02217c@redhat.com>
Message-ID: <540905F9-7DF7-436F-905C-A7F225F5E156@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 31=2E M=C3=A4rz 2025 09:53:41 UTC schrieb Paolo Bonzini <pbonzini@redha=
t=2Ecom>:
>On 3/30/25 22:58, Bernhard Beschow wrote:
>> A qemu_log_mask!() macro is provided which expects similar arguments as=
 the C
>> version=2E However, the formatting works as one would expect from Rust=
=2E
>>=20
>> To maximize code reuse the macro is just a thin wrapper around qemu_log=
()=2E
>> Also, just the bare minimum of logging masks is provided which should s=
uffice
>> for the current use case of Rust in QEMU=2E
>
>It's probably better to use an enum for this=2E  One possibility is also =
to change the #defines to a C enum, and see which enum translation of the s=
everal allowed by bindgen is best=2E

Currently the #defines contain some holes for "private" mask bits=2E Turni=
ng these into an enum without exposing all publicly, and changing the type =
of qemu_loglevel for consistency, would result in undefined behavior=2E Or =
do you suggest to convert just the public #defines into an enum to expose t=
hem to Rust, and keep the rest of the C API including the type of qemu_logl=
evel as is?

There are surely several tradeoffs and/or cleanups possible here, but that=
's way beyond for what I wanted to achieve -- which is closing a gap betwee=
n C and Rust=2E My main goal is just to get my feet wet with Rust=2E

>
>Also, while this is good for now, later on we probably want to reimplemen=
t logging at a lower level via the std::fmt::Write trait=2E  But that's jus=
t for efficiency and your macro is indeed good enough to define what the AP=
I would look like=2E

Can we live with an easy solution then for now? As you suggest below, furt=
her abstractions like log_guest_error! can be built on top which further in=
sulates client code from implementation details such as the representation =
of the mask bits=2E

> Right now I have a project for GSoC that will look at that, and the stud=
ent can look into it later on=2E

Whoops, I didn't intend to spoil the project=2E

>
>This means answering the following two questions:
>
>- the mapping the LOG_* constants into Rust
>
>- whether to keep the "qemu" prefix for the API (personal opinion: no)
>
>- whether it makes sense to add more macros such as log_guest_error! or l=
og_unimp! for the most common LOG_* values
>
>> +#[macro_export]
>> +macro_rules! qemu_log_mask {
>> +    ($mask:expr, $fmt:expr $(, $args:expr)*) =3D> {{
>
>Looking at https://doc=2Erust-lang=2Eorg/std/macro=2Ewrite=2Ehtml they ju=
st use $($arg:tt)* for what is passed to format_args! (or in your case form=
at!), so we can do the same here too=2E The main advantage is that it allow=
s giving a trailing comma to qemu_log_mask!=2E

Easy to fix=2E Before proceeding I'd like to see a solution for the topic =
above=2E

Best regards,
Bernhard

>
>Paolo
>
>> +        if unsafe {
>> +            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::=
raw::c_int)) !=3D 0
>> +        } {
>> +            let formatted_string =3D format!($fmt, $($args),*);
>> +            let c_string =3D std::ffi::CString::new(formatted_string)=
=2Eunwrap();
>> +
>> +            unsafe {
>> +                ::qemu_api::bindings::qemu_log(c_string=2Eas_ptr());
>> +            }
>> +        }
>> +    }};
>> +}
>

