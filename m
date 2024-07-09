Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34CCC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRC0H-0008Oh-Rs; Tue, 09 Jul 2024 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRC0F-0008Na-VB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:39:35 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRC0E-0005dz-7p
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:39:35 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58b5f7bf3edso3262175a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720535971; x=1721140771; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nTYpZgqpBsEX/fM413Pj9V3El8+8hgmO8+MLcltRclQ=;
 b=OTsFMF9JTWKWNLJ5QUDoM58Jgg0DA2A11P+PkNKHFTBDSL6rFTYmEc0kkG+slLuk+V
 4AeOHhnV4HT4+FCwLkXbZB/nu3YKDApEdMaf6MBeoT6e2xJkuHoFDA7HzgiCtJJV6dPy
 6PwCCIW7ToXMmD88LnWCWJcDTxRTsNB3JigNNwY4jXrAiB43MSj6EP86jA+c/1lRJoRt
 T0Mq22ThpvCshV689lsG4gyhBLWircUTSm9GTxaJ2OJsKmDH8gCqnbduJJVsg9MhmE3q
 B/IIMIVfK2fbONpC1P/C2wN/WYNl9IS0vSASiAoQscLgRg7wFnSh2n418PQIziz1xkoz
 doDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720535971; x=1721140771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTYpZgqpBsEX/fM413Pj9V3El8+8hgmO8+MLcltRclQ=;
 b=s/0WWZyhsIvo6hVM6jrJZuu1/dV7lMWWDk/9AXjbGBm1lE8jXa3FqLgbtlweZ9uFsG
 vAImZROqqyRzbcvQxjbXTXUlyg5k7eTI61+wsDPoCPKcuF4om5I4zBNNPKaM1oGP0YWo
 gyx8qcqwGTESEMVLe2sNWw0Cn51Qg8K6JopK3QJSSk2bSY5USaOEBCvz4TikRyvqc0ka
 gNmIekXVnNsADRTWArC4Ug8g3r9FH3K4z2FPUCAlC7IB7hV1iK/j1ESLGbU1bBq0ekmy
 nOS1XkVGA3NLNizUfyCFm+3+XY0L6qBWNNPnKQTUzmvY3IwzPAJ+90gxI6/BeaKgVu8e
 wnag==
X-Gm-Message-State: AOJu0Yzv1dLTr0vXfuCCp+2VbD0IC76FH8V1pDyID/cCAsB8Blg7nIvc
 fPQ8kiRfAracCFQdVk+wF69HRp/KJAgvgpmgIWawwJhxPG/EqKpf3AVpEAY4+pKJ6rsKZNKgC5f
 kSIAKe/SKoneHds9ttsTv4N3uH3iJVzSmNGnneA==
X-Google-Smtp-Source: AGHT+IFFtm+lKRWZz7RgdVp+m7uGM/3J8+v/tgByi7xC687pk4mhd597OxxcxJ6pFFf43Ev5gKgw1J04jlZj2oi7c4k=
X-Received: by 2002:a05:6402:13c7:b0:57d:4f47:d9f7 with SMTP id
 4fb4d7f45d1cf-594b7e7d0f0mr2670036a12.0.1720535970941; Tue, 09 Jul 2024
 07:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240708112520.106127-1-junjiehua@tencent.com>
In-Reply-To: <20240708112520.106127-1-junjiehua@tencent.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 15:39:20 +0100
Message-ID: <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: junjiehua <halouworls@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 8 Jul 2024 at 14:24, junjiehua <halouworls@gmail.com> wrote:
>
> when building elf2dump with x86_64-w64-mingw32-gcc, fwrite is imported from
> msvcrt.dll. However, the implementation of msvcrt.dll!fwrite is buggy:
> it enters an infinite loop when the size of a single write exceeds 4GB.
> This patch addresses the issue by splitting large physical memory
> blocks into smaller chunks.

Hi; thanks for this patch.

(Does the library fwrite fail for > 4GB, or for >= 4GB ?)

> Signed-off-by: junjiehua <junjiehua@tencent.com>
> ---
>  contrib/elf2dmp/main.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index d046a72ae6..1994553d95 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -23,6 +23,8 @@
>  #define INITIAL_MXCSR   0x1f80
>  #define MAX_NUMBER_OF_RUNS  42
>
> +#define MAX_CHUNK_SIZE (128 * 1024 * 1024)

I think we could add a comment here, something like:

/*
 * Maximum size to fwrite() to the output file at once;
 * the MSVCRT runtime will not correctly handle fwrite()
 * of more than 4GB at once.
 */

That will act as a reminder about why we do it.

(Does the library fwrite fail for > 4GB, or for >= 4GB ?
Your commit message says the former, so I've gone with that,
but if it's an "overflows 32 bit variable" kind of bug then
4GB exactly probably also doesn't work.)

Is there a particular reason to use 128MB here? If the
runtime only fails on 4GB or more, maybe we should use
a larger MAX_CHUNK_SIZE, like 2GB ?



> +
>  typedef struct idt_desc {
>      uint16_t offset1;   /* offset bits 0..15 */
>      uint16_t selector;
> @@ -434,13 +436,22 @@ static bool write_dump(struct pa_space *ps,
>
>      for (i = 0; i < ps->block_nr; i++) {
>          struct pa_block *b = &ps->block[i];
> +        size_t offset = 0;
> +        size_t chunk_size;
>
>          printf("Writing block #%zu/%zu of %"PRIu64" bytes to file...\n", i,
>                  ps->block_nr, b->size);
> -        if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
> -            eprintf("Failed to write block\n");
> -            fclose(dmp_file);
> -            return false;
> +
> +        while (offset < b->size) {
> +            chunk_size = (b->size - offset > MAX_CHUNK_SIZE)
> +                         ? MAX_CHUNK_SIZE
> +                         : (b->size - offset);

You can write this as
     chunk_size = MIN(b->size - offset, MAX_CHUNK_SIZE);
which I think is clearer. (Our osdep header provides MIN().)

> +            if (fwrite(b->addr + offset, chunk_size, 1, dmp_file) != 1) {
> +                eprintf("Failed to write block\n");
> +                fclose(dmp_file);
> +                return false;
> +            }
> +            offset += chunk_size;

I think we should abstract out the bug workaround into a
separate function, with the same API as fwrite(). Call
it do_fwrite() or something, and make all the fwrite()
calls use it. I know at the moment there's only two of
them, and one of them is the header so never 4GB, but
I think this more cleanly separates out the "work around
a runtime library problem" part from the main logic of
the program, and will mean that if we ever need to rearrange
how we write out the data in future it will be simple.

thanks
-- PMM

