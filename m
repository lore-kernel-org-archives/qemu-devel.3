Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7444FC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3C3e-0002EP-R3; Fri, 11 Apr 2025 06:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3C3V-0002Bz-3f; Fri, 11 Apr 2025 06:56:17 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3C3T-0001m6-1L; Fri, 11 Apr 2025 06:56:16 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso1673198a91.0; 
 Fri, 11 Apr 2025 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744368971; x=1744973771; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kxvMv2qnqE/YwdbtiAkx2DWqRAqTN/wPwM6vw5LuxzA=;
 b=bUBDrnEQbk1Y17dQukL001kONcgVexDusx3X/uSL285cVbTcOVekvt+Ek5sS+ncUcD
 tKTCplp2IuS0FUWgo0mymf7/+kkozSEtoLzCzb75AR7UKmDcchEra56c7Zjk1JHFhAwM
 JscvFQ4X7qc7ACelFzFE/YhG+taLMGzPHP1wN5PP+SoJKIx4mwT75rrWcgFiYKjfxTsx
 COx42jAXIFv0yhn56/ZsUyv3f/CB9GnlSFUyvEFlEeqmAG/gZViqjxVpQpUKMg9CfpNv
 Z/IlYR2EuDP0AXyB72B0ThthTpFMNZnUfHhJ4fANsbryuWchTYY7NvE+QgekuLKQXJk3
 y0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744368971; x=1744973771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kxvMv2qnqE/YwdbtiAkx2DWqRAqTN/wPwM6vw5LuxzA=;
 b=g+3TXZKy71qlSq9d5cB/LnCbhZyDrtc4Zqauxq/0fNUHJuueJYRHpJvQgV+N88tN7a
 biSOhX8d4urk/mUl8B6IFZlVJROxjPjTHW5jobUlz7YKZP84JyuO2iYgyCkHeQGRxu2T
 RDAsbhJoeNmKaKa988OVe8uEVEz99eF7LqaaYzeRqBwXHPOjx9ugGjahDzRmvLJthagZ
 uFRvLq1xr7DGWdG1Nn+eAccANa+B+frKSJxxZZggVbt4sXRhzAMxpYoUXrkNtvMlfu7/
 7fcH9jxvkOrcSet2q3SWUU49PSM1KWCOMXDCl1AeFNaT8IHLxDldLoAwcihQhzUxi7Bx
 WFCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkUzZMzCpMTdlP1AiftgLNFZE/fz7bzVW1h1ZFxKlJr7yFcU8xEjdWKspUQSucnJGuoQAC9eO9qdMJEA==@nongnu.org,
 AJvYcCXJno0obnNVWOkG5+Ixz6/KaaENTl2YcnU77bJrclEvRNOU354fEAzsdypv4k0SqgEk0GIXBHnKKSmgRg==@nongnu.org,
 AJvYcCXiygSttBjubaWsDtBVXqzq4Irp3xtS+tx/Cpm8WxrhkNOaY3UM+9cmvmfRq4dT519y4Yo+eOlfvQ==@nongnu.org,
 AJvYcCXrWuKzA1DiBmauMWlserW8thwIhD9HZi1duJF/EXteLTXRWRwPGsPHiW0DCYm2uU0ZL8sPnXdxBQA+UQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz63Cw0a/hRM6GUYYpv7h7paXfpjXQdE4/xLF4QOUSEymc5ajCV
 lYY4AitQGK+085F8a09DDknvDVEmQiE+berBEvU4lzay3bL6IIUvTTa+R4NWFGhzvyGzQ5hWXW4
 Ax85SBxwZJUOFST5qbfchVwCEUP4=
X-Gm-Gg: ASbGncuxoZ3o9Kfphyv55DF3PoBmVW8J67tMKngK0jJu7v/fCh/6472hdxkCJ8ON4CQ
 OcTUwJ8zGluM7ngiJfjdASQfuvgJghJ/yaN16CCVRPnlyqDT8beTd7jmxHe8zwyMZK21f6hYWxz
 NLXY+zF6qyKbXV57cFD0inb6imAuSxY3KZzDS2ebnsXt9ww4zlbkc=
X-Google-Smtp-Source: AGHT+IH+PlUhBQNJZi6uzrl2GMJX89hNOF7AbzbbflfIk6LAc+qm3rZwoGqYwh4pcE7A5pY6WfaNrX3fMGnvPguqexI=
X-Received: by 2002:a17:90b:584b:b0:2fe:7fea:ca34 with SMTP id
 98e67ed59e1d1-308237cedabmr3256340a91.32.1744368971455; Fri, 11 Apr 2025
 03:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <2be81d2f86704662c9fa33ceb46077804e34ac77.1744032780.git.ktokunaga.mail@gmail.com>
 <65a63820-e59d-47d4-883a-4affe40f9b38@redhat.com>
In-Reply-To: <65a63820-e59d-47d4-883a-4affe40f9b38@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 19:55:59 +0900
X-Gm-Features: ATxdqUF-3ml7LwnXhwj16CrdfgMINPXrYTL6FVmqP88Q7vzlX2MEgr5SaflJhSU
Message-ID: <CAEDrbUYDtpLqUAH-7T8xPk-YneY3B6sBw5TB_diNb7g9xzpYyQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] various: Fix type conflict of GLib function pointers
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
Content-Type: multipart/alternative; boundary="000000000000e6a2b406327e8c65"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102c.google.com
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

--000000000000e6a2b406327e8c65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> > On emscripten, function pointer casts can cause function call failure.
> > This commit fixes the function definition to match to the type of the
> > function call.
> >
> > - qtest_set_command_cb passed to g_once should match to GThreadFunc
>
> Sending an alternative patch that doesn't use GOnce, this code runs in
> the main thread.

Thank you for addressing this issue. I've sent a review to that patch.

> > - object_class_cmp and cpreg_key_compare are passed to g_list_sort as
> >    GCopmareFunc but GLib cast them to GCompareDataFunc.
>
> Please use g_list_sort_with_data instead, and poison
> g_slist_sort/g_list_sort in include/glib-compat.h, with a comment
> explaining that it's done this way because of Emscripten.

Sure, I=E2=80=99ll fix this in the next version of the series.

--000000000000e6a2b406327e8c65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo,<br><br>&gt; &g=
t; On emscripten, function pointer casts can cause function call failure.<b=
r>&gt; &gt; This commit fixes the function definition to match to the type =
of the<br>&gt; &gt; function call.<br>&gt; &gt; <br>&gt; &gt; - qtest_set_c=
ommand_cb passed to g_once should match to GThreadFunc<br>&gt; <br>&gt; Sen=
ding an alternative patch that doesn&#39;t use GOnce, this code runs in<br>=
&gt; the main thread.<br><br>Thank you for addressing this issue. I&#39;ve =
sent a review to that patch.<br><br>&gt; &gt; - object_class_cmp and cpreg_=
key_compare are passed to g_list_sort as<br>&gt; &gt; =C2=A0 =C2=A0GCopmare=
Func but GLib cast them to GCompareDataFunc.<br>&gt; <br>&gt; Please use g_=
list_sort_with_data instead, and poison<br>&gt; g_slist_sort/g_list_sort in=
 include/glib-compat.h, with a comment<br>&gt; explaining that it&#39;s don=
e this way because of Emscripten.<br><br>Sure, I=E2=80=99ll fix this in the=
 next version of the series.<br><br></div></div>
</div>

--000000000000e6a2b406327e8c65--

