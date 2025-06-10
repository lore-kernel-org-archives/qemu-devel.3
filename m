Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BB1C61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5wY-0005Z3-FW; Tue, 10 Jun 2025 16:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5wX-0005Yn-0e; Tue, 10 Jun 2025 16:51:37 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5wU-0005Lr-Hv; Tue, 10 Jun 2025 16:51:36 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so1061429866b.1; 
 Tue, 10 Jun 2025 13:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749588692; x=1750193492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZRcIsfSaMYZb67JsNtiAQeA+N/8/wuiZqEAWRdsYRo=;
 b=hQjWLJKPPCC1LND5xTh8+zACBy/CRvp9lBgFh4wR2r4zXZ6sJHG5Ua+xCAwHPH3j4u
 cORgzuOQYCTWAwinHOdT1nFgkN7+3XTc09Imwzx2t2Zpqd2e1rk6CN84P2bJm0tpc3/I
 GdnP33Yug2oP1XUUGv2ycJLcztbu7wKkxIsAHO1d2rLVkvl203oo1aiV1lOrwFaoiRuj
 ibSRQ5AqPvvxr7KsllZNBwCu2jcEhovjIFZMpJd2LxB5cLzSSXy9MZ4Bs+h/QhkLKh9q
 oKgEaIm7Pa4UTFvb2l1FQpbXzbCfUMNzjg6wDfj1PTDyb0TBVlurrHpo3ptaWIYB2mKc
 YQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749588692; x=1750193492;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZRcIsfSaMYZb67JsNtiAQeA+N/8/wuiZqEAWRdsYRo=;
 b=WqTnC3QwzKp6EtKpKRN+Bo8HzaJ92XN0ghdXmDYiruHH/RQY8mrtJPWU2XO0eIFKxo
 tgNJfmPBMwyJbCnrFyA3lwMDYv8SM340KkzDTb+FHJbqtWwbwNiHIdvBPHHxMj7r27UW
 2U5GzxWqkkJzFdKUrT57/wgQd0eybTL2dHzzE3FUbko3ZvSe8S95+DYnIRSBeELI7g3v
 Vw68hhkp2l+iuh3/Kz5qYi4YdDrPh2Uf1z8qm0gLU1lNNpQ8qlzTp68weV4CJBAjoHLf
 a2b4gmGgYUFzJD2bOq9RnE+EOW5GXHQZYvHTlNIaTsyeTDKi/ufKYSjEwP02Dt62L3c3
 oaHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoK+033Jdl3gd6OWE4ZwSKUSX0sUnx6YtoF2QK2liZylSX4cyf9oQ7/W47YkrDTpitVQosSnULO8c=@nongnu.org
X-Gm-Message-State: AOJu0YyZyluLR/aiDgcSsTe3O19zoVm9Pn+aIYX4sWvnfCUWWqg3rnBn
 8V0vFYeFG3cabYPApInd1C8j864aukW79SIL5DefgkCTwamHpbK5gYGVDwYZbQ==
X-Gm-Gg: ASbGncs2dGFKrzgvfmyqrf4/4tc7osEe5zkHUMhqLEqWl1fvGChTEobls+fcLGwdZfI
 +Tx6ApRJr20z/ykjZCYvhQ42r4GKA2kP78l5Yz7wd8E8LY75HC87gwXM4cx4b2quACbsRHbYJ2D
 DhA6d4/LhXtTDUUFZ+hd16DlTDFzIh4EETjvCtyZG/nkT61v6CkyIQUGgC/GyJJQR7esr+gkFvE
 DtdV8flCVDBCuDi1hLO/nVk8BdSysx44QD579THkBaieoYr4nj5mXdy+wwO+N5XuYW1hWr2d/OB
 N5vYyybtXVeLW/5e72P3bnkNFLUKdV5XxNs/OQ82fvAlJdp67BVH5lI/XJv2XL9o/eFJ4DKndHc
 AgzDdkB9hmDQJko8xioLW9wGRizdiIX/XlnSVa1k=
X-Google-Smtp-Source: AGHT+IHJgXbHoRDLqvYqMT7USDT2ZGwh/PepPjMq57CKxXdrcKmLtcC5RJ8BwCApewqZr+8h9IV32Q==
X-Received: by 2002:a17:907:7255:b0:ad5:eff:db32 with SMTP id
 a640c23a62f3a-ade8c9406c5mr23015466b.48.1749588691894; 
 Tue, 10 Jun 2025 13:51:31 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-237-205.77.183.pool.telefonica.de.
 [77.183.237.205]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc39c3fsm780113966b.140.2025.06.10.13.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 13:51:31 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:51:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_rust/qemu-api=3A_Add_i?=
 =?US-ASCII?Q?nitial_logging_support_based_on_C_API?=
In-Reply-To: <CABgObfbD-yHee4TXKqQ2gw7N8dtuB1wKqPLD5jLKXtJ8hx2xSw@mail.gmail.com>
References: <20250330205857.1615-1-shentey@gmail.com>
 <20250330205857.1615-2-shentey@gmail.com>
 <340649cf-9348-458d-97e7-aee73c02217c@redhat.com>
 <540905F9-7DF7-436F-905C-A7F225F5E156@gmail.com>
 <CABC6E67-C4C7-481F-BB96-BF60957D7A84@gmail.com>
 <CABgObfbD-yHee4TXKqQ2gw7N8dtuB1wKqPLD5jLKXtJ8hx2xSw@mail.gmail.com>
Message-ID: <1C6601BE-B21C-4607-ABE1-02B1C1A6D10F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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



Am 12=2E Mai 2025 15:32:08 UTC schrieb Paolo Bonzini <pbonzini@redhat=2Eco=
m>:
>Hi, now that GSoC selection is over I'm back=2E Sorry for the delay;
>Tanish Desai will work mostly on tracing, so logging can remain yours=2E
>
>On Tue, Apr 8, 2025 at 10:59=E2=80=AFPM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>> >Currently the #defines contain some holes for "private" mask bits=2E T=
urning these into an
>> >enum without exposing all publicly, and changing the type of qemu_logl=
evel for
>> >consistency, would result in undefined behavior=2E Or do you suggest t=
o convert just
>> >the public #defines into an enum to expose them to Rust, and keep the =
rest of
>> >the C API including the type of qemu_loglevel as is?
>
>Yes, only in Rust=2E
>
>> >There are surely several tradeoffs and/or cleanups possible here, but =
that's way beyond for
>> >what I wanted to achieve -- which is closing a gap between C and Rust=
=2E My main goal is just
>> >to get my feet wet with Rust=2E
>
>I understand, however there is no point in defining an API and then chang=
ing it=2E
>
>So we need to answer the questions I wrote a few messages ago, namely:
>
>- the mapping the LOG_* constants into Rust (e=2Eg=2E whether to keep the
>uppercase SNAKE_CASE or switch to something like Log::GuestError)=2E
>
>- whether to keep the "qemu" prefix for the API (personal opinion: no)

Sorry for the long delay, the imx8mp desired my attention=2E

Paolo, I tried both of your suggestions and found them to be convincing en=
ough that I sent a v2: <https://lore=2Ekernel=2Eorg/qemu-devel/202506102021=
10=2E2243-1-shentey@gmail=2Ecom/T/#t>

Best regards,
Bernhard

>
>I agree with not having macros such as log_guest_error! for now, or
>not wrapping functions like qemu_log_trylock/qemu_log_unlock that
>would be implemented as RAII (i=2Ee=2E returning a "guard" object) in
>Rust=2E
>
>> >>Also, while this is good for now, later on we probably want to reimpl=
ement logging at a lower level via the std::fmt::Write trait=2E  But that's=
 just for efficiency and your macro is indeed good enough to define what th=
e API would look like=2E
>> >
>> >Can we live with an easy solution then for now? As you suggest below, =
further abstractions like log_guest_error! can be built on top which furthe=
r insulates client code from implementation details such as the representat=
ion of the mask bits=2E
>
>Yes, of course=2E
>
>Paolo
>

