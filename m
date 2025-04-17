Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A198C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LX6-0007R1-EL; Thu, 17 Apr 2025 05:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LX3-0007QN-9l; Thu, 17 Apr 2025 05:27:41 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LX1-00058L-8i; Thu, 17 Apr 2025 05:27:40 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30820167b47so549089a91.0; 
 Thu, 17 Apr 2025 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744882055; x=1745486855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rmq6tnV3oobqPR6ZeDk8CKR3QdvTx9T6LSTEeuuSMFg=;
 b=ShXj7x+pcQQPyjXT1u2wyIChie6Up5lNNHe4IdqMOqpVzDK1S2NDKs8CIxgjC+88Xk
 q5DJCoT718Z/ZwWCh7mzvfhu2eroIck2EMKJxXWootSdaE+YKrVaxwooxJVEc84Ocuwx
 Vj1gi2WRfA/tkUtqgDiyowqxAMRrxeAoW0NbGYqMhUd0N+ocLNd5rHYHEW6IM61kB297
 WOyNL3xuZta9eY/M0RQKZAwSCGEFaBxgQhCVUxOslRH/lMn8FMcdBUgeWoFuggDkoolx
 zhge22qfjOZNkAAYZ73WHkZWiHeSVleyJziJk7W7bAlHxKoiYP+ktPQwH+hBtWy7kyMh
 nbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882055; x=1745486855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rmq6tnV3oobqPR6ZeDk8CKR3QdvTx9T6LSTEeuuSMFg=;
 b=UTDHxJFOzaQhvXchMgCN8A3gpP3jVqAVpPQV5r4tQ/c89G7OA44Mk+AKP6Z0RUCB1K
 vFvn79CJiwCBPaOE0ijKVRs814vHCREHkGuAhz4RHSXJidq0i9KxgAEJw3ENRaxjPxrx
 MCkrD4X5PUpzYSoI2Bb36CjASpKbhyqASos5vkt90VvNVO372tTFctesZNMt4CK2lE/K
 e0mxiIjBe8w0K+pHwTEg4qywzF7FMx6eIm4voj2ylHEHg7U6t3AfM3Kmj4FJ5pMLX8rc
 Dxmn4s8EzE42gfESozvojrmHapG14vwMkmCH5BLctyMJo0EiPvP2CenUNtKsEopgMHig
 24TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4jihRAYvnt4McAUnAOZVDPrET1H/C0HNeJvK/vQSCzYQMZPXkXjAe0ZqlLvW/IDoq8ZYPcuKeZw==@nongnu.org,
 AJvYcCWY01ygwygCc04PKKQvRKI3iDQwvfKX1jeyfsfwAp3qKHWiK76UIQO94ITLVbS1OjuAh8c3qE2OB6PvPA==@nongnu.org,
 AJvYcCWcKofx3/GLS8pq12ag+gH0JUzFcsRJ/S7SRr+E9mfQ0nZ/2LBKA/1NSiuFsmw9oH+LffuggOvt133QiA==@nongnu.org,
 AJvYcCX6clYF3/37J7GGffUKPypAwSc0kfzAYGyide0zhSKu8PAAXrF5VMmMiVG7M0zuDQkTg9M0WputdrE=@nongnu.org,
 AJvYcCX7eAknn9FrdlRXm5NtLb8d0f0cgF3MXdbCaPXWjW5mHJOeC2Nd/hmF3/wQuxmez1qb3/GLsrWJ5TDD9Q==@nongnu.org
X-Gm-Message-State: AOJu0YyE0wwv9Mf85MayKyM/1yGjORVDYKSrd/uVO9Hp81vViH0+gxl2
 jhsGyh9kiCI42RrBb/MgJ4x9kFcAv8JU7RVxHR3/BF+lgUkjqD7Wr3SoimVFRNP8em3xm+yxdNU
 h3U/si90uqaYOl1syV90KGh8fjmU=
X-Gm-Gg: ASbGnctoYg492niUDsiPPl2lurga3DTjT7znRjZiTw6oqNo1Q7Nx12O/Zy8EXCYJz40
 C0mOChJAzaRf62zx1cohFGM6sxJWy8PBjSNtUkhIDv0f3WeF3xcsB6W6TNTEOouvy1WSYSU+4vy
 YtKGHNU1NU2S0cbZ5tziqnEcAFDUZFD6vgpAvnzPoiz0SbEG4fsVlvAmOddpF1wfA=
X-Google-Smtp-Source: AGHT+IGF+Vkrm9uDjKFzLmTshgVd8s7nlzAFtbfV/yAmDU8+/yUUoSqd7K7AfX6UvmF4lqNEtvM0CwXgZobg+fDYuXY=
X-Received: by 2002:a17:90b:6cf:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-3086f3c7908mr3177332a91.3.1744882054787; Thu, 17 Apr 2025
 02:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <97a2164b3f428265136bb1c01615a16b516138c2.1744787186.git.ktokunaga.mail@gmail.com>
 <29330430-61a8-42c8-a87c-259f0cdbefe0@linaro.org>
In-Reply-To: <29330430-61a8-42c8-a87c-259f0cdbefe0@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:27:22 +0900
X-Gm-Features: ATxdqUE7DUGXiaiXQZUUdbzbb-Cv03aYAE2cd1t2TtTNMflviKjNJHtvlmo3h98
Message-ID: <CAEDrbUYu-NH4Dwkby-UTtQpiy0ApN+Z4dwt+iOs_SZjCwfM_ZA@mail.gmail.com>
Subject: Re: [PATCH 11/19] util/cacheflush.c: Update cache flushing mechanism
 for Emscripten
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
Content-Type: multipart/alternative; boundary="0000000000000cfcd70632f603c7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1032.google.com
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

--0000000000000cfcd70632f603c7
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> The "why?" isn't clearly described.

Although __builtin___clear_cache is used to flush the instruction cache for
a specified memory region[1], this operation doesn't apply to wasm, as its
memory isn't executable. Moreover, Emscripten does not support this builtin
and fails to compile it with the following error.

> fatal error: error in backend: llvm.clear_cache is not supported on wasm

To resolve this, I've removed the call to __builtin___clear_cache.

I'll update this patch to include an explicit "#elif" branch with an
explanation, like the following:

+#elif defined(EMSCRIPTEN)
+
+/* Wasm does not have an executable memory region. */
+

Please let me know if I'm missing something or if there is a preferred way
to handle this case.

[1]
https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache

--0000000000000cfcd70632f603c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br><br>&gt; The &quot;why?&q=
uot; isn&#39;t clearly described.<br><br>Although __builtin___clear_cache i=
s used to flush the instruction cache for<br>a specified memory region[1], =
this operation doesn&#39;t apply to wasm, as its<br>memory isn&#39;t execut=
able. Moreover, Emscripten does not support this builtin<br>and fails to co=
mpile it with the following error.<br><br>&gt; fatal error: error in backen=
d: llvm.clear_cache is not supported on wasm<br><br>To resolve this, I&#39;=
ve removed the call to __builtin___clear_cache.<br><br>I&#39;ll update this=
 patch to include an explicit &quot;#elif&quot; branch with an<br>explanati=
on, like the following:<br><br>+#elif defined(EMSCRIPTEN)<br>+<br>+/* Wasm =
does not have an executable memory region. */<br>+<br><br>Please let me kno=
w if I&#39;m missing something or if there is a preferred way<br>to handle =
this case.<br><br>[1] <a href=3D"https://gcc.gnu.org/onlinedocs/gcc-14.2.0/=
gcc/Other-Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcac=
he">https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other-Builtins.html#index=
-_005f_005fbuiltin_005f_005f_005fclear_005fcache</a><br><br></div></div>

--0000000000000cfcd70632f603c7--

