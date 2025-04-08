Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F106C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 20:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2G2I-0001ns-74; Tue, 08 Apr 2025 16:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2G2G-0001n2-ND; Tue, 08 Apr 2025 16:59:08 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2G2B-0001UI-Ds; Tue, 08 Apr 2025 16:59:08 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so1050671266b.3; 
 Tue, 08 Apr 2025 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744145940; x=1744750740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvgeZJXuGJqjGQVJcXuDuxjsxY/GODPlgAzg9+X5bEg=;
 b=bEQ9GNH5ozEuJ6PKHOwnVleJgtf64k8su9+XYXbx58LfzRclTrl8BfbKhd/47oEO61
 VT9rFXRoKNXGa0ExwaGRnaVITYgIkdfh+JD1gRjuESbMtwcv7tckAnp3hMjGSTrRZwST
 OFm22E3FpUSOyHAUI7eyGeLgBJ5xW0pXRSYCiH/jkgrqyWgqwzv1aJPt3pT937Tw4L7F
 mFlQ6JNp0vCJ4BcURSGN4kD0u4ZNqfGIip4rWdC9lbf5Pk9oUwkuoflVI5vTF1vB8sAa
 QtLfjIjxny/eqxaMYzAIlwj6RcUJlyu1KBr4O4UQfIaO+XbnE5g314s1PIRg7OqnBY5W
 ZYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744145940; x=1744750740;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvgeZJXuGJqjGQVJcXuDuxjsxY/GODPlgAzg9+X5bEg=;
 b=bnWdOCH1En+Mq0tKLZc7pizbzaiHivA0yDgzMn3bNqQbm3awtmionwUM2eGrJRnSKV
 slbYxcTh3oyPMZKnQ+G/szNcQwPPvFj1AkTfy9JzcBs1qvUQNcKGidVO1GdAgWLo+YfI
 Tz8HQrrmgNjICRESNbPKclddeJxsIg351vO79lA3GayJ/l+q47buk0qHZs8xSauqeTaO
 cK3X8uhRRJBL2wNT6Vuf6X9vP5d/6sGn45fhQ30lDFvTGZiHAmmpeqzoWPkxmWBTklXG
 Ec6r1klPcrTFc6IH5/aHYokioLObmMwCSoEuYj3Sqn5SdNV3BGlNA5dFzM5ig3m7wZEj
 zbBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBGlDiw+eQFr+YGljk5EmXZwgtFvThRigdeWUz08BR2+Gde/0t/NwYApVFkXe7uxv/WqXEJpRVWb/Y@nongnu.org,
 AJvYcCWbxG4JJCISKWIOFsvj5c0lmT229VuqJ0QnIZryp6YBkTOXB+BvO2CzJOV3p+uErgbPtk8ZPbFW1ICE@nongnu.org
X-Gm-Message-State: AOJu0YxHm59YtkyblhJK8FpbVIZzk24cApnSrNoFfkN00wehusIMB2Ru
 2vyj8XSJDG4C86cJYrgRkEj7OGMl79YT1gK+pBj55thSOd1nVuA0
X-Gm-Gg: ASbGnct3wCeILW+d1t0UNqeBtJgaHCLvtCMGqLSa0H6zkBQKAGd/m718hDD25IMQiZf
 B51U2J77X2sB+qcwdLIPrJpHweG98TUPs19kGeL84LW7KDbb0Ljb4MmSWia3RW6I84CfNPByhQK
 6LfDAQ00imV97s+vI1i0PGMGPQjfvE26TVr38ZZ/c6+rwaJNvfdZjYwAbflT5+lgaR8xZw56EJS
 8sJ41NI5DB7C6d1+yJRuSO/XowWHDxIriIT8eD+aH3Cx6gshl5LnWmxqJ+MyaY7WCsVXDtgfOFg
 jIUpXsgWcKb79t03Sv+sjCrm5Z2DIbn4mF2HTw01rD2oI2TL8woPP+KOpxkTfVvBCtTxkiTLSpF
 j7lCwiOo8224Gbo6Jd+odC6lOs7rQ6Kea7VAcQVA/BrhtI4ZF0yPtuQMWMVPGXTg=
X-Google-Smtp-Source: AGHT+IGQw2jMVBjmdNEhKYTxzfn/9/FWk5MERW38k80oI8V78tFnDyb48B37ehETaH6lGf+KXfjRxg==
X-Received: by 2002:a17:907:72c4:b0:ac8:16fb:a291 with SMTP id
 a640c23a62f3a-aca9b65e399mr67448866b.18.1744145939506; 
 Tue, 08 Apr 2025 13:58:59 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-291c-6e00-b87f-49d2-cee7-5562.310.pool.telefonica.de.
 [2a02:3100:291c:6e00:b87f:49d2:cee7:5562])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe9be67sm958537566b.46.2025.04.08.13.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 13:58:59 -0700 (PDT)
Date: Tue, 08 Apr 2025 20:58:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_rust/qemu-api=3A_Add_i?=
 =?US-ASCII?Q?nitial_logging_support_based_on_C_API?=
In-Reply-To: <540905F9-7DF7-436F-905C-A7F225F5E156@gmail.com>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-2-shentey@gmail.com>
 <340649cf-9348-458d-97e7-aee73c02217c@redhat.com>
 <540905F9-7DF7-436F-905C-A7F225F5E156@gmail.com>
Message-ID: <CABC6E67-C4C7-481F-BB96-BF60957D7A84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 1=2E April 2025 10:51:06 UTC schrieb Bernhard Beschow <shentey@gmail=2E=
com>:
>
>
>Am 31=2E M=C3=A4rz 2025 09:53:41 UTC schrieb Paolo Bonzini <pbonzini@redh=
at=2Ecom>:
>>On 3/30/25 22:58, Bernhard Beschow wrote:
>>> A qemu_log_mask!() macro is provided which expects similar arguments a=
s the C
>>> version=2E However, the formatting works as one would expect from Rust=
=2E
>>>=20
>>> To maximize code reuse the macro is just a thin wrapper around qemu_lo=
g()=2E
>>> Also, just the bare minimum of logging masks is provided which should =
suffice
>>> for the current use case of Rust in QEMU=2E
>>
>>It's probably better to use an enum for this=2E  One possibility is also=
 to change the #defines to a C enum, and see which enum translation of the =
several allowed by bindgen is best=2E
>
>Currently the #defines contain some holes for "private" mask bits=2E Turn=
ing these into an enum without exposing all publicly, and changing the type=
 of qemu_loglevel for consistency, would result in undefined behavior=2E Or=
 do you suggest to convert just the public #defines into an enum to expose =
them to Rust, and keep the rest of the C API including the type of qemu_log=
level as is?
>
>There are surely several tradeoffs and/or cleanups possible here, but tha=
t's way beyond for what I wanted to achieve -- which is closing a gap betwe=
en C and Rust=2E My main goal is just to get my feet wet with Rust=2E
>
>>
>>Also, while this is good for now, later on we probably want to reimpleme=
nt logging at a lower level via the std::fmt::Write trait=2E  But that's ju=
st for efficiency and your macro is indeed good enough to define what the A=
PI would look like=2E
>
>Can we live with an easy solution then for now? As you suggest below, fur=
ther abstractions like log_guest_error! can be built on top which further i=
nsulates client code from implementation details such as the representation=
 of the mask bits=2E

Ping

>
>> Right now I have a project for GSoC that will look at that, and the stu=
dent can look into it later on=2E
>
>Whoops, I didn't intend to spoil the project=2E
>
>>
>>This means answering the following two questions:
>>
>>- the mapping the LOG_* constants into Rust
>>
>>- whether to keep the "qemu" prefix for the API (personal opinion: no)
>>
>>- whether it makes sense to add more macros such as log_guest_error! or =
log_unimp! for the most common LOG_* values
>>
>>> +#[macro_export]
>>> +macro_rules! qemu_log_mask {
>>> +    ($mask:expr, $fmt:expr $(, $args:expr)*) =3D> {{
>>
>>Looking at https://doc=2Erust-lang=2Eorg/std/macro=2Ewrite=2Ehtml they j=
ust use $($arg:tt)* for what is passed to format_args! (or in your case for=
mat!), so we can do the same here too=2E The main advantage is that it allo=
ws giving a trailing comma to qemu_log_mask!=2E
>
>Easy to fix=2E Before proceeding I'd like to see a solution for the topic=
 above=2E
>
>Best regards,
>Bernhard
>
>>
>>Paolo
>>
>>> +        if unsafe {
>>> +            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os:=
:raw::c_int)) !=3D 0
>>> +        } {
>>> +            let formatted_string =3D format!($fmt, $($args),*);
>>> +            let c_string =3D std::ffi::CString::new(formatted_string)=
=2Eunwrap();
>>> +
>>> +            unsafe {
>>> +                ::qemu_api::bindings::qemu_log(c_string=2Eas_ptr());
>>> +            }
>>> +        }
>>> +    }};
>>> +}
>>

