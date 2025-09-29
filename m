Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4B0CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 08:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v39cy-00087r-TW; Mon, 29 Sep 2025 04:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v39ct-00085K-Gh
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:52:56 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v39ci-0001AE-Sh
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 04:52:55 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32e715cbad3so5199283a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759135957; x=1759740757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lafyTkYT1Ex9v+/Ov2/t60VCq/hVRywmsYuicIahjLI=;
 b=AwhIIdBaHUqHC6rEhjRb0LkyH6NUpihHvBdCyK6ApOWSGXhT3jQfY6lrY5n0DIk5oo
 Ij96SsLsaRRSAMUb1YqExh+2ODEU4mEbtsujSTUeowWGccT1vSMrWLpOsETOVKWxWzqY
 9+odKlBGUbCXkrIyZ21IEIUxuReNwFwvAgYUOQfjTNjL9nVSg/CDr137xcBIQsRBVIph
 FeXEzfxLRsXy7SiNIAiQ8xOgvPsXhRwVlH6SXLMcEt/b7vDqRZzieAOxuWhwPw8kC7rk
 nM1zPtrtN9OpTYy8ZyYUGrXlNjpqzXxDeRyVgEOxPngjmQ064d1v/q+Naii1aG8PXEW3
 LUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759135957; x=1759740757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lafyTkYT1Ex9v+/Ov2/t60VCq/hVRywmsYuicIahjLI=;
 b=djn66w7f8uCfdKr1LatSTV/39sHnQu4o1Hgx86AIt42ynWpjQe1fz++Q2qXS0G1bha
 0VpKbZdJy9psd16f0nxr2pOWClicfIzNWfWIUj04Sw9/8fJnyU0yxY1q/gkOlp1+cjIc
 y/4N6n2aMQqTOIOaoUGtrN5JGdztQHt7Gsv0hJ4nDuosV08enKEvaC6WptVHjifowOPs
 SDVPnE6wLs9uxr+iop2+rzRHaZVJ6f9GiTtFj3gVk6eH1DKFBQOkiZdayxcs6DqgNeXf
 MdLjavQXzs4bbWhI5mZzsiavSEmKLHf3iyVUPrbtg7aul54yejodiloDTsEBT+Odcea4
 coJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyUDrtR1Bg+CIgBhI/9PTMgbwYrnoPDDALbkF0UtzMC+VbD2GKWx4tyfOIEl9oSIodR/eP71DnlrgZ@nongnu.org
X-Gm-Message-State: AOJu0Yy1MGZKF14bH6PcLjDEqCreoKUAPrfcOoJ8YaKWbAp9aL8Nn3Wr
 E73VXYH6evNRXG8s5ENAI5hf2d4q3NT7h3yauCwwkWvjbwDwJwyQFSddjGHodyWrFKJ/TeC5ir1
 xrn/VN88B1EtcTZuFQbRzxp0tFrilWxk=
X-Gm-Gg: ASbGncuTEagpem6YPJh60OdUlL/HAfwqN6UeZvuCwSEV0viTuwUfCn1KVTb57AgNX97
 Gv/9UMewes1CAWxcFIDbLraByr5Ebu6VUiNMIwDSy04wvmfOlwj3n/mpx0mUDBzOOMGhZy/Y7y+
 P8z6wn0cVi/XBFjps9NBU19iNNLRb52LW2o1IenOAJez0Jqr6sYjqYfnlNG2zAdmg2eS+PhwUH8
 XPD/o/l9X9nbQCPmVR/5wEGS2P91TwkWhqKJsjMu86fBMSn
X-Google-Smtp-Source: AGHT+IFkH+L4hE8LeLLWqYd01Zs54AFlNhodlCJYMweIL//Z3HDNqEDpsa8zTPyQRH14KZrJKif2WgP98Ke2simc2LE=
X-Received: by 2002:a17:90b:1a8f:b0:32b:c5a9:7be9 with SMTP id
 98e67ed59e1d1-3342a2c6a0bmr14756810a91.25.1759135957314; Mon, 29 Sep 2025
 01:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-28-marcandre.lureau@redhat.com>
In-Reply-To: <20250924120426.2158655-28-marcandre.lureau@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Mon, 29 Sep 2025 17:52:25 +0900
X-Gm-Features: AS18NWD1-qwZmnd1dinzPXohwgLqCxRefqg_5VIJeSlNYmT6-h2wzUvtSpicHxQ
Message-ID: <CAEDrbUbOWp24F_wO88Tb9ZCM8Q+jXEK_1BzwGMwC3MG=3TzgAA@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] WIP: enable rust for wasm/emscripten
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>, 
 Yonggang Luo <luoyonggang@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, 
 qemu-rust@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d8efe4063fecc195"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000d8efe4063fecc195
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc-Andr=C3=A9,

Thank you for working on this patch.

> wasm-ld: error: unable to find library -llibqemuutil.a

This issue looks similar to the one in "[PATCH v2 24/27] WIP: cirrus/macos:
enable Rust" so I tried the upcoming meson change[1] mentioned in that
patch for the wasm build. By also applying a patch for disabling the
"verbatim" modifier for the Emscripten build[2], I was able to avoid the
error.

However the test build still fails with the following error[3] which I'm
currently investigating. It seems that meson invokes rustc with duplicated
linker flags (e.g. I saw three "-lstatic:-bundle=3Dglib-2.0" flags in a sin=
gle
rustc invocation) and rustc doesn't seem capable of handling them.

> error: overriding linking modifiers from command line is not supported

Aside from the test build, I also tried building the qemu binary. The build
succeeded after rebuilding the Rust standard library as suggested in the
documentation[4]. If you're interested, I've stored the patch to [5].

[1] https://github.com/mesonbuild/meson/pull/15024
[2]
https://github.com/ktock/meson/commit/afd0366d1fafe0cee2915d4b60bc2b523e3c1=
c02
[3] https://gitlab.com/ktock/qemu/-/jobs/11529682431#L3287
[4]
https://github.com/rust-lang/rust/blob/5b9007bfc358817cf066ee27c6b440440727=
d3a7/src/doc/rustc/src/platform-support/wasm32-unknown-emscripten.md#emscri=
pten-abi-compatibility
[5] https://gitlab.com/ktock/qemu/-/commits/test-rust-emscripten-c

Regards,
Kohei

--000000000000d8efe4063fecc195
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Marc-Andr=C3=A9,</div><div dir=3D=
"ltr"><br></div><div dir=3D"ltr">Thank you for working on this patch.</div>=
<br>&gt; wasm-ld: error: unable to find library -llibqemuutil.a<br><br>This=
 issue looks similar to the one in &quot;[PATCH v2 24/27] WIP: cirrus/macos=
:<br>enable Rust&quot; so I tried the upcoming meson change[1] mentioned in=
 that<br>patch for the wasm build. By also applying a patch for disabling t=
he<br>&quot;verbatim&quot; modifier for the Emscripten build[2], I was able=
 to avoid the<br>error.<br><br>However the test build still fails with the =
following error[3] which I&#39;m<br>currently investigating. It seems that =
meson invokes rustc with duplicated<br>linker flags (e.g. I saw three &quot=
;-lstatic:-bundle=3Dglib-2.0&quot; flags in a single<br>rustc invocation) a=
nd rustc doesn&#39;t seem capable of handling them.<br><br>&gt; error: over=
riding linking modifiers from command line is not supported<br><br>Aside fr=
om the test build, I also tried building the qemu binary. The build<br>succ=
eeded after rebuilding the Rust standard library as suggested in the<br>doc=
umentation[4]. If you&#39;re interested, I&#39;ve stored the patch to [5].<=
br><br>[1] <a href=3D"https://github.com/mesonbuild/meson/pull/15024">https=
://github.com/mesonbuild/meson/pull/15024</a><br>[2] <a href=3D"https://git=
hub.com/ktock/meson/commit/afd0366d1fafe0cee2915d4b60bc2b523e3c1c02">https:=
//github.com/ktock/meson/commit/afd0366d1fafe0cee2915d4b60bc2b523e3c1c02</a=
><br>[3] <a href=3D"https://gitlab.com/ktock/qemu/-/jobs/11529682431#L3287"=
>https://gitlab.com/ktock/qemu/-/jobs/11529682431#L3287</a><br>[4] <a href=
=3D"https://github.com/rust-lang/rust/blob/5b9007bfc358817cf066ee27c6b44044=
0727d3a7/src/doc/rustc/src/platform-support/wasm32-unknown-emscripten.md#em=
scripten-abi-compatibility">https://github.com/rust-lang/rust/blob/5b9007bf=
c358817cf066ee27c6b440440727d3a7/src/doc/rustc/src/platform-support/wasm32-=
unknown-emscripten.md#emscripten-abi-compatibility</a><br>[5] <a href=3D"ht=
tps://gitlab.com/ktock/qemu/-/commits/test-rust-emscripten-c">https://gitla=
b.com/ktock/qemu/-/commits/test-rust-emscripten-c</a><br><br>Regards,<br>Ko=
hei<br><br></div>

--000000000000d8efe4063fecc195--

