Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E66C369B4
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 14:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3FaH-0005Ul-1c; Fri, 11 Apr 2025 10:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3FaB-0005UC-4T; Fri, 11 Apr 2025 10:42:15 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3Fa9-0002fQ-6y; Fri, 11 Apr 2025 10:42:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2a9a74d9cso392442766b.1; 
 Fri, 11 Apr 2025 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744382530; x=1744987330; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fSg6VV0S2nSlCQBls/gUcOoEnqiGB9k8fi2W1vxyUOk=;
 b=U49n+gGuoRsSxwDUdB1tVZYZUrkHPuO6opkjXDrBo53K0EuFTywfBwFuXJM4XuN4BC
 4YZ8mnsD3jO7dFtdX3VGQo9EFdrsoTHTnbApZoJGapVoE2n9SVm1yhzUoW2QTptjB5b9
 GUiZjcBuwc9utXlzR9AmvzNTohZ3bM3e1PKPh3jMsaUpJ2JziIKXdvZzoCaNgtkZhYAA
 y86YGYQnLCmTg7AN0BJLSdjMSsFjBMMCFfsM6lwI0W937gBMj7G+vhIQ3PLsB028GuF0
 dwT0VR0gUdUqxr6zm9sE7Nu7w1xXv2E1aiB1LA7fzrAJGXR8Pq1SKx5J/QWMH919UwWu
 fdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382530; x=1744987330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSg6VV0S2nSlCQBls/gUcOoEnqiGB9k8fi2W1vxyUOk=;
 b=pzKFtU/rog3AsEHcvHNR1cHkhCDICZ0cS4Gcjcn9nobH4NionEh4xr6YWFmWVQ+q2d
 cKHQcMLD7nDsoPrg+kzSKfdhy27UF4X1Sn3l5UAaAb9nVD9CX339ahvvvXA1KEYjRESw
 H0BH3UA9T8XCPfdal8LJVeS63En5YsgW4me+swngJtMQN77lQMkjLuH9dUdVAO2x9bpX
 HejoziikBUSi0jV7lm2/lJFVgTzL0wFvWC5b1EbUiMclTH7uHj14VBqOKM3cnqao+Uae
 ngljJ9I27lKC3LNwldNw7eReIG/QfoZnXWyO6ePjiVRBsblqo+drmhmrlQLlsvcQBHZN
 beiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFYBtPQ0jm1jwv1EsOb+GmPokxzDuAjBreZjBD/KgWH5qf898/qQ47+po68wag/PPbPlt691ct2lwGtg==@nongnu.org,
 AJvYcCVshit+X88fLEcRcvpx2ASkTFSFBS+o+nFoNFPRpACpP1xV05+n6mokX0JWsP6yfhR7uffU4Ym14CQicA==@nongnu.org,
 AJvYcCWMBXGlcWWC8AmOe7gIXf2MRHGok9bjbOnQfDUz/njK7OnJfrgn8Ih6D+cuH0MngFhfh/rBUBTW5Rqf8w==@nongnu.org,
 AJvYcCXBAllVZ7fDsJlJXk08/JQY3RpTXdSgyMbEeTSmyanyDjKLVY3DmYr+GQvu2bCQlNwEB0wG0j0qBw==@nongnu.org
X-Gm-Message-State: AOJu0YxYMqNwBI1ktWa+MPP5u5xnrj6LxRdeJ60O1PP0XvSTUYilu1IZ
 4QhI1mP52T3C39ohZMhf1TzyVhL9wIZLg165+X30GyeNqRjRgEtCQrVmgSmaoHz6pJeIaCIcga9
 xiBHxiiRdisoEhAyErAj41DbPmJw=
X-Gm-Gg: ASbGnctSWZ0E07+38UpgpHJn4Irt8FZmC7msgysy+twIISjjp7BZD+j7A5g5cIxXwKO
 iLXiSuXcR7nms52WLBXEWpUBJZIfpkl05w6CdSdRb8UiHn067Ty5UmtuPmvbA7L5fhA/Edxb2UL
 wCJIld3g81KAn4geNGxN1CY/mPWB+sQBp8kuAhQLMpACjCVIkHHAQ=
X-Google-Smtp-Source: AGHT+IGM/L1G5c/pGv0mWpPy9S2TrZVYAgbtjuqt00gDkNmv2LT9mD9EBklEQnolow+B7gZfjm/5nJqKbNTR9trnpjI=
X-Received: by 2002:a17:907:7f0d:b0:ac3:bd68:24f0 with SMTP id
 a640c23a62f3a-acad3457c9dmr311069566b.7.1744382529777; Fri, 11 Apr 2025
 07:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <20250409192115.GA5528@fedora>
 <dc36c24e-dc4a-4c24-97b7-8b812441ffce@linaro.org>
 <CAEDrbUZ4mbCT-npk8Nha4fDd9a5PGguAxS_RD0wG96gpQRUp+g@mail.gmail.com>
 <CAEDrbUYM3aK5ErvF=+oV=q-NVLO0uzxbYjHzcxPGvTLp7yNtwA@mail.gmail.com>
 <26951ab5-cc40-465c-88d2-d70e98bae3f6@redhat.com>
In-Reply-To: <26951ab5-cc40-465c-88d2-d70e98bae3f6@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 23:41:55 +0900
X-Gm-Features: ATxdqUHuiB3X5nnUlwjG9zchkT6JXAC7eww0fXhplrsQCQJM-9blRapTad2xPWE
Message-ID: <CAEDrbUYj9362hWQuTNA28cMRLTrjd4MeqkN8BUpZUpEVbPcsTg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000a3dd7063281b5e4"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000000a3dd7063281b5e4
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> > > The biggest problem I'm seeing is we no longer support 64-bit guests
on
> > > 32-bit hosts, and don't plan to revert that.
> >
> > Yes, so the sixth patch ("[PATCH 06/10] include/exec: Allow using 64bit
> > guest addresses on emscripten") should be considered as a temporary
> > workaround, enabled only for Emsripten builds. It will be removed once
> > wasm64 gains broader support and is adopted in the Wasm backend.
>
> Maybe there's a way though. Currently we don't support 64-bit guests on
> 32-bit hosts, but more precisely we don't support 64-bit guests with
> 32-bit host word size.
>
>
> The wasm TCG backend is able to compile with 64-bit words:
>
> +#define TCG_TARGET_HAS_div_i64          1
> +#define TCG_TARGET_HAS_rem_i64          1
> etc.
>
> and if x32 was a thing it would as well.  In fact the changes in patch
> 6/10 are not a full revert, and the "#ifdef EMSCRIPTEN" could be changed
to
>
> #if HOST_LONG_BITS >= TARGET_LONG_BITS
> ... use uintptr_t
> #else
> ... use uint64_t
> #endif

Thank you for the feedback.

Yes, the Wasm backend can be compiled with 64-bit words. The change
regarding the macro looks good to me.

--0000000000000a3dd7063281b5e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi Paolo,<br><br>&gt; &gt; &gt;=
 The biggest problem I&#39;m seeing is we no longer support 64-bit guests o=
n<br>&gt; &gt; &gt; 32-bit hosts, and don&#39;t plan to revert that.<br>&gt=
; &gt; <br>&gt; &gt; Yes, so the sixth patch (&quot;[PATCH 06/10] include/e=
xec: Allow using 64bit<br>&gt; &gt; guest addresses on emscripten&quot;) sh=
ould be considered as a temporary<br>&gt; &gt; workaround, enabled only for=
 Emsripten builds. It will be removed once<br>&gt; &gt; wasm64 gains broade=
r support and is adopted in the Wasm backend.<br>&gt; <br>&gt; Maybe there&=
#39;s a way though. Currently we don&#39;t support 64-bit guests on<br>&gt;=
 32-bit hosts, but more precisely we don&#39;t support 64-bit guests with<b=
r>&gt; 32-bit host word size.<br>&gt; <br>&gt; <br>&gt; The wasm TCG backen=
d is able to compile with 64-bit words:<br>&gt; <br>&gt; +#define TCG_TARGE=
T_HAS_div_i64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>&gt; +#define TCG_TARG=
ET_HAS_rem_i64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>&gt; etc.<br>&gt; <br=
>&gt; and if x32 was a thing it would as well.=C2=A0 In fact the changes in=
 patch<br>&gt; 6/10 are not a full revert, and the &quot;#ifdef EMSCRIPTEN&=
quot; could be changed to<br>&gt; <br>&gt; #if HOST_LONG_BITS &gt;=3D TARGE=
T_LONG_BITS<br>&gt; ... use uintptr_t<br>&gt; #else<br>&gt; ... use uint64_=
t<br>&gt; #endif<br><br>Thank you for the feedback.<br><br>Yes, the Wasm ba=
ckend can be compiled with 64-bit words. The change<br>regarding the macro =
looks good to me.<br><br></div>

--0000000000000a3dd7063281b5e4--

