Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D88C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 14:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3FUd-0001j2-NB; Fri, 11 Apr 2025 10:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3FUb-0001iD-Bz; Fri, 11 Apr 2025 10:36:29 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3FUZ-0001nK-By; Fri, 11 Apr 2025 10:36:29 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e5cded3e2eso3271176a12.0; 
 Fri, 11 Apr 2025 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744382184; x=1744986984; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TlF6NDZu6E7cqFh7Nc+T41PatugtSHL1p7nnfIPlLdk=;
 b=fI8U9exj3KvkMK8FxiWNqjTZ39cE0eN34pep+s2z8Hr8jVWPI0qndzDAhSI8kXwVY3
 NQ41D5a6ugUSaSWMSqnE+xQsNAXA+PIH1aj6Pq7R1Bp5A8XGnlAIts+sV2J4WJpOzm4Z
 1xuDcetKMzkMa9EqoPbXg2ks8/i4zljnX65Q1W/2tkqO70t1bf1LnV8ja/VwApD1ooVy
 MblECbNLxvHTmuSRBAAaneSNZWw+8uraTpDkGtQCza/KKY42ufhMv+vPqc+O/Y3cRww2
 6iUp6gNpHeNb6YtnDBfMKD5j0hlLNc0+S1YDsgvp8rSId7FWSAS2Y48Q1lgSyLeZGqcm
 vGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382184; x=1744986984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TlF6NDZu6E7cqFh7Nc+T41PatugtSHL1p7nnfIPlLdk=;
 b=wSJFS4KPYxTlFCYA7tRk1fJK/8iFlpbuZq3jAt1n/lS4wxhOIiZQD+6f8sscwrG106
 VBSM2hKQQ/Wvta6i6PQEUG2IvUEqr+GVpcMM81L/IWGgueWCuktGjcWb4SZ3IUB6GC3K
 zFlN0tYMMbH1cBKg4itOgDocRvbjY/0DUZfmVuPVxUVXVuDJzibjaPsk83f/KNWg5yaI
 F4D6yJGJOSZ9apJWkPtFgMNRKl0yzud0Mb/JdB+195FjYhDmQbCh00sTNMFT2LEPykf9
 HRwe5+ogtZ4fhG4oAvUTVIRd2uXN+o5cKaQ6UVLpCUnYcK1y3DpyvvDzBJVNUZC57LBR
 8k0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Y5NJfe9KIht0ses3EhAmty4kCVx+x1RbevAS1uQJUx+m0VouuerT5zbgL+5fKwzfYQs2IMoBLqxj/g==@nongnu.org,
 AJvYcCWn4Ew03mZzaC0yp14Q/QdaIrDsh8E73lxWGBM5loe9BmQWOkqafT+giwfZj+Cni60V9NFhsZrMaA==@nongnu.org,
 AJvYcCXOtmfa5VurI/3OCSYeSvfFENlUTM1mKMJYsjyf8UZ6FLaAnm2N+SGo8qlz8zEPTcC/sH1vSjCHwJvIFg==@nongnu.org,
 AJvYcCXo4TlJC4x0M5ewXswqPFv4smk/jXz92IZ5gUDeNOy4gyrk0z0z2cwVM+g7zGqL/Ez0eoPuEPZydqQcwA==@nongnu.org
X-Gm-Message-State: AOJu0YxRV7RToOzN6m8EnuoHgoAGfXaoRLZlebkln6UaGPqEot5Hrf7d
 dVu7Y/RWuz07HiG2FsTh4bobS3yRIRSg676TRVkeUYAAAPEeYSjgoLDJkeinO5zKvmGY0sMe/p2
 G3Hy9eaxbBMsIFVIwGpDDGC+Y1HQ=
X-Gm-Gg: ASbGncusPzVB7rXYhg4FEKrnvdZmI5mBT/TG/sCacXQEIx7oSgv1MJ+I/YlirC79tDO
 DzWp+1cOPXD4sdBLJbR7TMBWAQnpuqxOzmvX8hiRyfSs1MIf2S7GDG68KnyTB1gPTPI4NBnsJUC
 85rX5gWjy/WpnBY4WpC4KVYOwaAlAATUQQ1e+WhG55ogboYDxLtsw=
X-Google-Smtp-Source: AGHT+IEK4IlWPqik4XVDKLNC42CRTXGG0nCurAmChUtUb3OKn1+5+1bmiQVlarf1wzo4Olhm09ujK8nS6X9rvaZgqTI=
X-Received: by 2002:a17:906:3551:b0:aca:d4f6:440d with SMTP id
 a640c23a62f3a-acad4f64472mr203284666b.17.1744382183784; Fri, 11 Apr 2025
 07:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <20250409192115.GA5528@fedora>
 <dc36c24e-dc4a-4c24-97b7-8b812441ffce@linaro.org>
 <CAEDrbUZ4mbCT-npk8Nha4fDd9a5PGguAxS_RD0wG96gpQRUp+g@mail.gmail.com>
 <CAEDrbUYM3aK5ErvF=+oV=q-NVLO0uzxbYjHzcxPGvTLp7yNtwA@mail.gmail.com>
 <83f44749-0eea-48f0-8aa5-3882132e30d0@linaro.org>
In-Reply-To: <83f44749-0eea-48f0-8aa5-3882132e30d0@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 23:36:10 +0900
X-Gm-Features: ATxdqUG2wUVfL0Bc-xKm6Ed3L3KzqObfzFH1fQHjiBHOvWTFvTqQyENfOv92ae8
Message-ID: <CAEDrbUbjD0d-pP_s1oV7gSuFoDpKTDiXd7bQf6p5hQUcN_iT+g@mail.gmail.com>
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006acb94063281a09e"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-ed1-x534.google.com
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

--0000000000006acb94063281a09e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierrick, thank you for the feedback.

> first, congrats for this work!
> It would be really nice to have this available upstream, starting with a
> modest TCI port, before having the tcg backend also.

Sure, I'll split the patch series, starting with the TCI port.

> Do you have recent information about wasm64? It seems to be something
> that has been discussed for several years, without really seeing any
> progress.

According to the adoption status=E2=80=AF[1], wasm64 is supported by recent=
 versions
of Chrome and Firefox. Emscripten also supports wasm64=E2=80=AF[2]. However=
, it is
not yet supported by Safari or libffi=E2=80=AF[3], and I haven't found a ro=
admap for
the adoption.

[1] https://webassembly.org/features/
[2]
https://emscripten.org/docs/tools_reference/settings_reference.html#memory6=
4
[3]
https://github.com/libffi/libffi/blob/6a99edb8082f75e523e0d6ebaba42218b80e1=
0c8/README.md#supported-platforms

> As Philippe said, we can't really revert that (it's now an assumption
> for our softmmu implementation, and would break code if we enabled it
> again now.)
>
> That said, we can always have a first version supporting only 32 bits
> targets. And later, when wasm64 will be available, we can extend this to
> all remaining ones.

The main challenge I'm seeing is that I couldn't find a clear timeline for
wasm64 adoption so it's difficult to predict when it will be widely
available.

Regarding the revert, the wasm backend supports 64-bit words, so the revert
introduced in patch 06/10 is partial, as also pointed out by Paolo.

--0000000000006acb94063281a09e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Pierrick, thank you for the feedback.<=
/div><br>&gt; first, congrats for this work!<br>&gt; It would be really nic=
e to have this available upstream, starting with a<br>&gt; modest TCI port,=
 before having the tcg backend also.<br><br>Sure, I&#39;ll split the patch =
series, starting with the TCI port.<br><br>&gt; Do you have recent informat=
ion about wasm64? It seems to be something<br>&gt; that has been discussed =
for several years, without really seeing any<br>&gt; progress.<br><br>Accor=
ding to the adoption status=E2=80=AF[1], wasm64 is supported by recent vers=
ions<br>of Chrome and Firefox. Emscripten also supports wasm64=E2=80=AF[2].=
 However, it is<br>not yet supported by Safari or libffi=E2=80=AF[3], and I=
 haven&#39;t found a roadmap for<br>the adoption.<br><br>[1] <a href=3D"htt=
ps://webassembly.org/features/">https://webassembly.org/features/</a><br>[2=
] <a href=3D"https://emscripten.org/docs/tools_reference/settings_reference=
.html#memory64">https://emscripten.org/docs/tools_reference/settings_refere=
nce.html#memory64</a><br>[3] <a href=3D"https://github.com/libffi/libffi/bl=
ob/6a99edb8082f75e523e0d6ebaba42218b80e10c8/README.md#supported-platforms">=
https://github.com/libffi/libffi/blob/6a99edb8082f75e523e0d6ebaba42218b80e1=
0c8/README.md#supported-platforms</a><br><br>&gt; As Philippe said, we can&=
#39;t really revert that (it&#39;s now an assumption <br>&gt; for our softm=
mu implementation, and would break code if we enabled it <br>&gt; again now=
.)<br>&gt; <br>&gt; That said, we can always have a first version supportin=
g only 32 bits <br>&gt; targets. And later, when wasm64 will be available, =
we can extend this to <br>&gt; all remaining ones.<br><br>The main challeng=
e I&#39;m seeing is that I couldn&#39;t find a clear timeline for<br>wasm64=
 adoption so it&#39;s difficult to predict when it will be widely<br>availa=
ble.<br><br>Regarding the revert, the wasm backend supports 64-bit words, s=
o the revert<br>introduced in patch 06/10 is partial, as also pointed out b=
y Paolo.<br><br></div>

--0000000000006acb94063281a09e--

