Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4C0C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BvI-0006YP-PO; Fri, 11 Apr 2025 06:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3BvG-0006Wc-Ih; Fri, 11 Apr 2025 06:47:46 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3BvE-0000Xx-4i; Fri, 11 Apr 2025 06:47:46 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-301302a328bso1780017a91.2; 
 Fri, 11 Apr 2025 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744368461; x=1744973261; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yvw1qpiZvXdgbFk/ijAFR0ZR5uTy5dD1wHsihqsCH4o=;
 b=CZD90Aq7XqhMOuR2Xs2ySwVe2PI/xoJZXwS71EJnmchlRDL9GSDvFTLZ5uA+/gU9Eb
 5DLNVHcRBqKhKPSeZxIaY5+8BVKNtEX/QyXdIl64kc79ighaLmCShS0hdm9FB3VzhFzm
 rMOEKeAWar/Cc8cbXfSukamB5w2mFydY7scREInxIRoBgfSBbWCwRRkaUFXzub6S3IV4
 QKIboHAY6ZVnoMkbliMj0wak2jYqUcU97kCTofa98XhCqKWKon0S8fNLxvnbW0HESONQ
 MNI31uSUFeGtSmWYWQkfpqPrYCPHxYlzITQcEvcTgIH4NWCPbJGCpIyk8LfJkSnUmWnN
 QmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744368461; x=1744973261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yvw1qpiZvXdgbFk/ijAFR0ZR5uTy5dD1wHsihqsCH4o=;
 b=Cn+4obQuHfxva4tzvaZ5DUoLHf3O3vXP/JVXej2Apkx8tabI7IV1acmE3NQr+gVa2M
 AiaNVxU0qLTUkRQOdSonwLVduY4lU7s7sYzV2096/jN6YikU7vl/SAIbX9sUKO6H3WyE
 bCiyPEJfpRlArZ1nZqAl1xOh/VzmcHPmzBEKaE9ChWFBhOp4Lncv0076yE6YdCwbhSKk
 lXX22hfFJL/1s86eLIHRNlKqF/HE6PR5XE6v9ZrSdQl+DgVwcnR2skXSbQtcIRJ980qu
 tRhrAx00RI+E2KDv+rgbzziBiMUkl42IH7aDNhid1dfWgNvCQe8ZEaNfllTMRI3MVdVO
 Ow8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYeTAbRqb4NYyL99tZipv1FR2C8VXhFV52dL3Kk/HxUPa6F2ZwJGZHQShA5I0npBRnkGYhSayc9Q==@nongnu.org,
 AJvYcCVK8vijOz6OL2N/rgwb1OtOsWqDrR9hnNllz4IhzRy7lu0xHC19E9j/yG4YD7/wkBGoJlx90/N91ZXYrA==@nongnu.org,
 AJvYcCX7ZD3mKbQQAIvJZ5vAB5K8esLFBwIS/DMko1Q06qTe5AfhBqybX2/Fqy3pB6e6+1S4BNwE8IuueVo5ZA==@nongnu.org,
 AJvYcCXL/bw1R/W0n/YefvV1bbpD8IfzjeXw6BfWbcOkV71aIrwIauymuQdDBaWcJdxRR9i0ZgFHBvpwdFazLw==@nongnu.org
X-Gm-Message-State: AOJu0YwGLsxfjDv9xlPxrvx6/XTR1gkteTaU+IUDtZdMKgDKWcmSxy8W
 sjN5AzsV41wmnAgCZKdmUpRW8CTfagdOgMXytirByTLA+zwenLpXrRxsLMV7AckFjPBM1ElKEBS
 Y2KN9QeBvKTnPmLDQQP29nE2vJWE=
X-Gm-Gg: ASbGncvvNv/dNVDI0wDawwYsBNmbxywxYeYN4Bdy83aT9zVanPlCIEknwLJH9nOnby3
 F1PT2JBhWjh9lvhP4VCNisfV6zQnJaFNlCWYOpKaMLzlRIyC30VyRzsx+2RZEMbQB4ubuJ8lvmA
 +wP2dX1TDX0CvgGRcv1rbRkeBZganmAFKLz8iWt0OiMZ5eAbsaAJw=
X-Google-Smtp-Source: AGHT+IHjbs9m+z+e94TJb3e7CG9XODeW5lUdjRpjtd5HNDd9iKKtsBGZ1SDt1OELhDLcyYh94lcP2B/5W2qgdUMSRpI=
X-Received: by 2002:a17:90b:5445:b0:2ff:5cb7:5e73 with SMTP id
 98e67ed59e1d1-3082367ee62mr3174944a91.23.1744368461443; Fri, 11 Apr 2025
 03:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <16376e4b63fad6f847ceadb39b8f9780fc288198.1744032780.git.ktokunaga.mail@gmail.com>
 <2533109.DitPQcejgS@silver>
In-Reply-To: <2533109.DitPQcejgS@silver>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 19:47:29 +0900
X-Gm-Features: ATxdqUEAuriu9KMt6MEeuc8iKnkGaLyjjVKXC_7kL7uGQCcBfZujtuc6BXyjNkE
Message-ID: <CAEDrbUakVwwn228nSb0rD1C9qiZ-tpcHBzLRDVyGRNsim97=JQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Greg Kurz <groug@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000080787106327e6e7b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1034.google.com
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

--00000000000080787106327e6e7b
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

> > Emscripten's fiber does not support submitting coroutines to other
> > threads. So this commit modifies hw/9pfs/coth.h to disable this behavior
> > when compiled with Emscripten.
>
> The lack of being able to dispatch a coroutine to a worker thread is one
> thing, however it would probably still make sense to use fibers in 9pfs as
> replacement of its coroutines mechanism.
>
> In 9pfs coroutines are used to dispatch blocking fs I/O syscalls from main
> thread to worker thread(s):
>
> https://wiki.qemu.org/Documentation/9p#Control_Flow
>
> If you just remove the coroutine code entirely, 9p server might hang for
good,
> and with it QEMU's main thread.
>
> By using fibers instead, it would not hang, as it seems as if I/O
syscalls are
> emulated in Emscripten, right?

Thank you for the feedback. Yes, it would be great if Emscripten's fiber
could be used to address this limitation. Since Emscripten's fiber is
cooperative, I believe a blocking code_block can still block the 9pfs server
unless an explicit yield occurs within it. I'll continue exploring better
solutions for this. Please let me know if I'm missing anything.

> Missing
>
>     errno = ENOTSUP;

Sure, I'll fix this in the next version of the series.

> Looks like you just copied the macOS errno translation code. That probably
> doesn't make sense.

Errno values differ between Emscripten and Linux, so conversion is required
here. I've used the same mappings as macOS for now, but I'm happy to add
more conversions if needed.

--00000000000080787106327e6e7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Hi Christian,<br><br>&gt; &gt; =
Emscripten&#39;s fiber does not support submitting coroutines to other<br>&=
gt; &gt; threads. So this commit modifies hw/9pfs/coth.h to disable this be=
havior<br>&gt; &gt; when compiled with Emscripten.<br>&gt; <br>&gt; The lac=
k of being able to dispatch a coroutine to a worker thread is one<br>&gt; t=
hing, however it would probably still make sense to use fibers in 9pfs as<b=
r>&gt; replacement of its coroutines mechanism.<br>&gt; <br>&gt; In 9pfs co=
routines are used to dispatch blocking fs I/O syscalls from main<br>&gt; th=
read to worker thread(s):<br>&gt; <br>&gt; <a href=3D"https://wiki.qemu.org=
/Documentation/9p#Control_Flow">https://wiki.qemu.org/Documentation/9p#Cont=
rol_Flow</a><br>&gt; <br>&gt; If you just remove the coroutine code entirel=
y, 9p server might hang for good,<br>&gt; and with it QEMU&#39;s main threa=
d.<br>&gt; <br>&gt; By using fibers instead, it would not hang, as it seems=
 as if I/O syscalls are<br>&gt; emulated in Emscripten, right?<br><div><br>=
</div><div>Thank you for the feedback. Yes, it would be great if Emscripten=
&#39;s fiber</div>could be used to address this limitation. Since Emscripte=
n&#39;s fiber is<br>cooperative, I believe a blocking code_block can still =
block the 9pfs server<br>unless an explicit yield occurs within it. I&#39;l=
l continue exploring better<br>solutions for this. Please let me know if I&=
#39;m missing anything.<br><br>&gt; Missing<br>&gt; <br>&gt; =C2=A0 =C2=A0 =
errno =3D ENOTSUP;<br><br>Sure, I&#39;ll fix this in the next version of th=
e series.<br><br>&gt; Looks like you just copied the macOS errno translatio=
n code. That probably<br>&gt; doesn&#39;t make sense.<br><br>Errno values d=
iffer between Emscripten and Linux, so conversion is required<br>here. I&#3=
9;ve used the same mappings as macOS for now, but I&#39;m happy to add<br>m=
ore conversions if needed.<br><br><br></div>

--00000000000080787106327e6e7b--

