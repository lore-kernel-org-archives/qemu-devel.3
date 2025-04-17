Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357DCC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Lcw-00011H-Ik; Thu, 17 Apr 2025 05:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Lce-0000pk-BC; Thu, 17 Apr 2025 05:33:32 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Lcc-0006Iz-GN; Thu, 17 Apr 2025 05:33:27 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso516105a91.1; 
 Thu, 17 Apr 2025 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744882404; x=1745487204; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+WYqzNVMLotLX9cRFxRZE2qJnsZT4jC37pquHkVtjqA=;
 b=KvkcH3WJyGq0Byv3w3x897urWNSJ8LDxmU1odIzEiEWw6ew5dDGBkFl/pU4oyhV6Ng
 nOwXq7VF+CEJ9I6wUnKigqrL9dTZD24lXGBy1fkU7R5PHXIuQs3+3ENO6eb9CNTVWlPj
 r+NzSgCaF4WhsWsYgTef1gprKQNsokj9GEX+JHGVH2Y3nW89TO830bkp/ZEAPP0s2VdW
 pj5JFjGU5NwJZ40+FZ40pzq2SxkxKvkg0TWUjHKefFZLtv0b5Xka1+oZ6AUJR+DUE5Wp
 j7ecP1yTOwM5WD/4+6ysNOBn/BdAsxJIBAtUXmoB6IXsqlC63wcP9QH7o269T00DEAOb
 rJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882404; x=1745487204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+WYqzNVMLotLX9cRFxRZE2qJnsZT4jC37pquHkVtjqA=;
 b=Wyrjf41jC7lAVbkwZgXFnmgTDPpDarryZ/VotlfiN8a7vgR1W7njSerIG3oi8tjp2N
 VrmdwQwu4IJhhAwI2y3gwDsjc/uurv/lqYIT6F7Gw9ViITAfEFpUSBqZGIl/8TrXu9KP
 5f1DPZwcAbWU1npN/Jak5Ph2gdNszgErNVkV5yyC+HvNERXZOrVQYOVThvapMRGt24KP
 NbUmnpLVsEz73hYKonzJx17ZebGdD3MD7xpEd2hAFbF7jZq4qMxz3w14/oQhEbb3o7o6
 hmBvh5ANxvlu7GaPqMTa5LfIbgJG87KCqIu7i6XIjycHYLNNZIuyNLSQ5r32l3AnRavI
 jy9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtwzvNYg3l3CQRNhXMlyKgDysutQnQOKOO/Aq15OvMlC76gSyPUP1gNoGLQOz93Gt8X1sKqpMQMes=@nongnu.org,
 AJvYcCVbJXHIib462BO7f0wHAPFxKIlgmtMlvOxcrHx+/4TTgWNOS7CsJw5zSfwxQQvqMh+b5nETwRTu4A==@nongnu.org,
 AJvYcCVcGAvtA19JU6p09NPt7i0euxY8pGVWL5RpTWSVI23+5YA8EvRL9XIYyoGR3zbc0Sb22fYrx/OTIF0qOQ==@nongnu.org,
 AJvYcCXABJ5rkvtAI/bO0p/Vh+iH+y1vkeA3NaI2OvxfbqIELYncYlNcI4TWBnVbp9F5ngopKFtNYNecUHMulg==@nongnu.org,
 AJvYcCXVv3CbyKNCHQi1T0m4AySUyZgLxTxpYkYONTf8i/g3oc7fKfgFHEepL8DL5xOsc8oL/YVuruflf4hHCA==@nongnu.org
X-Gm-Message-State: AOJu0YyHvK1YSYngC4+RPh/kMZtPWl7B8cCeL/w28+JNO+FskxCotXi5
 c0R0IQAq461asuDQclK9k0+4CFKM28k2rcps03LLxvqqzJG9VeSY57QXJZMJvFaLB22jqqARnXy
 xs66XbOThl+gZJRKfEHOHyUuR7aM=
X-Gm-Gg: ASbGncsDeNJE9+TbVtCb4aETsIARjOVtcRqqAXFMEMBOYgYCpajBEAPiNcjH2pmhuDt
 bIoTyxDXykInDkdSplqqqAEpVCXuLEN+4eG6P7U6ZLdIFFt9pNXD7WX4NKQJKIy0NMp6w5OIegb
 4IpBivyvNqaCA4kJQDrMB9P2i5prc0IHcjToLPxQRHmFnbBVK/cYBv
X-Google-Smtp-Source: AGHT+IHNSWCxX47tiqfKqiS2sIxUAHE7DSXrly5hav+Iq0jvcClyO+qIcG5Xdnru5UXOvEB+NY0ZRbAO8V22CojlBAE=
X-Received: by 2002:a17:90b:5410:b0:2fe:b735:87da with SMTP id
 98e67ed59e1d1-30863c503c8mr9628237a91.0.1744882403663; Thu, 17 Apr 2025
 02:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <c2e3a58825c39678fcde361b685d1bd69d2fb1dd.1744787186.git.ktokunaga.mail@gmail.com>
 <e10f052d-b098-487e-a667-a0a19630d082@linaro.org>
In-Reply-To: <e10f052d-b098-487e-a667-a0a19630d082@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:33:11 +0900
X-Gm-Features: ATxdqUEuQG4VGOWT0iulbDeHqVr0sWZL9x5AQG50DesObBgdxTbSldSIx1e34BE
Message-ID: <CAEDrbUa9AF1uZfdwTy2WL1Er8FZOh2SbQxw8zPmxbOrw5zURMw@mail.gmail.com>
Subject: Re: [PATCH 14/19] Disable options unsupported on Emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d863ee0632f61752"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1036.google.com
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

--000000000000d863ee0632f61752
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> >   #ifndef _WIN32
> > +#ifndef EMSCRIPTEN
>
> #if !defined(_WIN32) && !defined(EMSCRIPTEN)
>
> ?

Thank you for the sueggestion. I'll apply this in the next version of the
series.

--000000000000d863ee0632f61752
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br><br>&gt; &gt; =C2=A0 #ifn=
def _WIN32<br>&gt; &gt; +#ifndef EMSCRIPTEN<br>&gt; <br>&gt; #if !defined(_=
WIN32) &amp;&amp; !defined(EMSCRIPTEN)<br>&gt; <br>&gt; ?<br><br>Thank you =
for the sueggestion. I&#39;ll apply this in the next version of the series.=
<br><br></div></div>

--000000000000d863ee0632f61752--

