Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D86C369AE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 14:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Eym-0006eg-2P; Fri, 11 Apr 2025 10:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3Eyb-0006dZ-C8; Fri, 11 Apr 2025 10:03:26 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3EyZ-0004tv-K3; Fri, 11 Apr 2025 10:03:25 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301c4850194so1600919a91.2; 
 Fri, 11 Apr 2025 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744380200; x=1744985000; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xFy6ACGlewwahJcQDdgO8c8GfCX47OEfeGyDlhNqeLA=;
 b=AhZpVDQ02F/MUa4jecJNQx/3FPNsbtwtNlQFQ2iQuFQ1lTIZJom6kWU+5ahVAgGubt
 1TlO5zXAIsmr+0tOi+c9YKMntLSvA9B7mTZ4ifpiPQxDLETEKk2MzhEeujt1PXMm9ZWe
 MVUMG3fdd+GyHkX384+ltsmodTC6VYrR4FcamaVrcf3U+OIoS7wHl/OTiB7zHkjN+jiG
 bRjr7xdCAsjxlyKe1nrtYcd1m5A/wBcH5nQBNnH0FfTB0KA9UmkG7H6lKj16kj33pTQL
 X9jLaCilKGGDl4L5w+i/D9CiU0kFf3+nDFRV7cd3JJzkk4BKpHqc17ABbXyq9emWc4rU
 mang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380200; x=1744985000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xFy6ACGlewwahJcQDdgO8c8GfCX47OEfeGyDlhNqeLA=;
 b=hTnkzpXjcHjLKechMUaV7TIyN6F9z0yZcclObNUWExI2ixnOLRA8eTEGadOmocJbW6
 PiLf9IUFxeUAAXDFPKjsjpwL0o9Og8+xVLdNW3t1sT32GkOBe5ItqU1yuHKzP2cnfXZe
 8lJtPBIxw/3Pymqt0pgOPQ9aO9RJvOEFze89b+krdDB8koWYdKEr8TNtna3LY68poTbi
 /AOsUJdKoULdNEbKpSegWmsrulYVYavHFXNwkIC3clEGW+9+4Mfx1X9n3wtol7hywAls
 61CDpH81FnZVUiLTfEV7iTykSTf2TFTld+w+Qv3LFCV8qP449j5q2OT2JoV9Bkk4V1al
 W7OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaP1223P4ZSpa2+bvdIFDU4p530Hm3Mq3gJ1MXA0nNowy5llAI7VkJcLjOk+dW59B+B3JYtBfmlw==@nongnu.org,
 AJvYcCVLyc0Qt7E3WLuO4ZZ2wGtmkxzhz30Hqdcut2jIsBunbdKoFlL77iDsMuZgx12423dftXOhLIAKN5Obhg==@nongnu.org,
 AJvYcCWGx26u28xmSq2KqimuYjzae168WrKrXqHK+FgVcF5cdFZRib/RGxSz2bDilnCy1yeohbn8GUr/kraObQ==@nongnu.org,
 AJvYcCXwA+EFtZFwS5cHqngMhxkoXFOUZD9QVjMOgWg494SvCxSnUy1K3Ns+BH/qBfcxHLKMATWy+iavhFxRcA==@nongnu.org
X-Gm-Message-State: AOJu0YzCPAf8MYeazqAgtlRy3cfVmxyIjsgR2ws6lqpkDpWbk/HhnHYJ
 atJAfqhdpJH/nr4vJq3I1VxEpCgkiHG2T9xYlxxr+xOi07eDlytvUAzydry9Doz71DykyosTurc
 x/9FIFvwncP8EEUK0vFTQzd7zLCg=
X-Gm-Gg: ASbGncsQiWZVWRKR6z6RGB6OpzcWZEqDMguS6OPEiAx9gzDfWrmh7P01saXQzkMqARz
 Xlt+HuzzemfLKy/rP7LCqITb1yDqxN8q0PdY34PBz5sTgFWc/V8CdseU+fNME2Y63PYevHaKEwh
 HAvGyK116zNX7qXgisa5oDV6ethIqP+wWoBZvLavsRrUOCNpNtiJw=
X-Google-Smtp-Source: AGHT+IHazCXxnMA+xyqZPveubVFBv52IbAgpmh1CjzAbeFtFPVX6/q3G/iRq8FPnP60DzPRxeHXfocU9HqCUX5JBXWc=
X-Received: by 2002:a17:90a:d888:b0:2ee:f677:aa14 with SMTP id
 98e67ed59e1d1-30823664084mr4622603a91.13.1744380199557; Fri, 11 Apr 2025
 07:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <16376e4b63fad6f847ceadb39b8f9780fc288198.1744032780.git.ktokunaga.mail@gmail.com>
 <2e9cb17e-47a4-49d3-a815-612bcbdcc92d@redhat.com>
In-Reply-To: <2e9cb17e-47a4-49d3-a815-612bcbdcc92d@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 23:03:07 +0900
X-Gm-Features: ATxdqUGygzKUhd7MGEXS4tYylx2kmA9QydAJS9i_XTLSV_ewkssT5HpuuxRtrHA
Message-ID: <CAEDrbUYDsZo_XO_prUnz8yZ_+gU1UgNiba48svDmANuqcTMyWw@mail.gmail.com>
Subject: Re: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000025e5270632812a75"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1033.google.com
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

--00000000000025e5270632812a75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> > Emscripten's fiber does not support submitting coroutines to other
> > threads.
>
> Does it work as long as the thread does not rewind?

The structure used by Fiber includes a thread-specific field related to
rewind=E2=80=AF[1], which prevents it from being shared across threads. The=
 behavior
of the remaining fields in multi-threaded contexts is not documented, so
further experimentation is needed to determine whether they can be safely
shared.

[1]
https://emscripten.org/docs/api_reference/fiber.h.html#c.asyncify_data_t.re=
wind_id

> You can add all these to the stubs/emscripten.c file that I suggested
> elsewhere.

Sure, I'll apply this reorganization in the next verison of the series.

> You could extracting v9fs_co_run_in_worker()'s bodies into separate
> functions.  It is tedious but not hard; all you have to do is define
> structs for the to parameters and return values of v9fs_co_*(), unpack
> them in the callback functions, and retrieve the return value in
> v9fs_co_*().  Many functions
>
> The advantage is that, instead of all the bottom half and yielding dance
> that is done by v9fs_co_run_in_worker() and co_run_in_worker_bh(), you
> can just use thread_pool_submit_co().

Thank you for the suggestion. I'll explore this approach, though it's still
unclear whether thread_pool_submit_co() can be used with Emscripten's Fiber
due to the limitations mentioned above.

--00000000000025e5270632812a75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Paolo,</div><div><br></div><div>&gt; &gt; Emscript=
en&#39;s fiber does not support submitting coroutines to other<br>&gt; &gt;=
 threads.<br>&gt;<br>&gt; Does it work as long as the thread does not rewin=
d?<br><br>The structure used by Fiber includes a thread-specific field rela=
ted to<br>rewind=E2=80=AF[1], which prevents it from being shared across th=
reads. The behavior<br>of the remaining fields in multi-threaded contexts i=
s not documented, so<br>further experimentation is needed to determine whet=
her they can be safely<br>shared.<br><br>[1] <a href=3D"https://emscripten.=
org/docs/api_reference/fiber.h.html#c.asyncify_data_t.rewind_id">https://em=
scripten.org/docs/api_reference/fiber.h.html#c.asyncify_data_t.rewind_id</a=
><br><br>&gt; You can add all these to the stubs/emscripten.c file that I s=
uggested<br>&gt; elsewhere.<br><br>Sure, I&#39;ll apply this reorganization=
 in the next verison of the series.<br><br>&gt; You could extracting v9fs_c=
o_run_in_worker()&#39;s bodies into separate<br>&gt; functions.=C2=A0 It is=
 tedious but not hard; all you have to do is define<br>&gt; structs for the=
 to parameters and return values of v9fs_co_*(), unpack<br>&gt; them in the=
 callback functions, and retrieve the return value in<br>&gt; v9fs_co_*().=
=C2=A0 Many functions<br>&gt;<br>&gt; The advantage is that, instead of all=
 the bottom half and yielding dance<br>&gt; that is done by v9fs_co_run_in_=
worker() and co_run_in_worker_bh(), you<br>&gt; can just use thread_pool_su=
bmit_co().<br><br>Thank you for the suggestion. I&#39;ll explore this appro=
ach, though it&#39;s still<br>unclear whether thread_pool_submit_co() can b=
e used with Emscripten&#39;s Fiber<br>due to the limitations mentioned abov=
e.<br><br><br><br></div><br></div>

--00000000000025e5270632812a75--

