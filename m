Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D32D6406B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Siv-0000oL-1o; Fri, 08 Nov 2024 12:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9Sit-0000o5-0u
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:24:39 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9Sir-0005ld-1z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:24:38 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5ee3e12b191so1062596eaf.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731086675; x=1731691475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuc8Go6O6cgUUfDO/jgvBT2D0c3rxLhpYWq+3fQCZgY=;
 b=EiNwBwI9v6lIQY1GXYt3lJ4OI4Tj3htguNY/bMySSJ5pfBvzbmtIaHibP0HK0UgHlc
 xGc0rYhKijL5pnhDpOWlHNjW3SscPV8MelsDvzRYcRs2bmDaYdvE/IUYgKmf9F0ldrHC
 eODYvSl03yhXf3NdvLfc3JP+2lg0eBZYli+L8a2NRDQiQKerNDcBwAzQVa9DN4GBmZXq
 lSNjBgroO6P21yAN37eC1Zn8UEZ0izJYObkjj6VtR8oRncHMmaH55HPLmyAjqherULoN
 9IZt+q3iM0RVGbVrCeh6oBetHBTWvmuw+5/NwrFP5i7CUyuEw0qIrRYIDeFAi7FCbrzn
 bjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731086675; x=1731691475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuc8Go6O6cgUUfDO/jgvBT2D0c3rxLhpYWq+3fQCZgY=;
 b=DLzHm3R0FDL83r+F+lSFDmWOyUPiVA+nih7FDi4FNq/nICqpgCb9F1th7C0OvErPLb
 4MvXrqvjkpZHAUOvUXsFeuhEbj796iooBVqzFhE9MBhImH43i1BUU2KNPYAQ7oE0bzsl
 mQCTGnaE0kbKBYgfIqAeK/loiWQf4kenJfxqfO2Hfc2neJoyZV1NrbQuV6PD7W38iHXo
 8njeWwEtn8SAa6zYnwUl++hrjYRmHuAgL7hfJq6q8Excpv/VNXO3E7V7ikKlRlnUS0sx
 C0o+lFR17Io+2LAaHCGhjs4stq98su6c9uGGL5nnc0LqWq+jjO7FT7/R/P9mhxps8uP5
 nxag==
X-Gm-Message-State: AOJu0Yyf4O1Hoz136iwvPAAun37/1yG9ZRSnQWk71WtybI5n3zZ6RWZm
 wiSvA7uHGdHzppN4vbaZziKfyXmXDMMid+hs2LIUV3f2gKi8eCYU1aZsOA3+D3knSBogVFXhb+6
 tQiAZFJSWB1E96bY7p5c6v2kAVEU=
X-Google-Smtp-Source: AGHT+IEIPyk+Sbg58zyZwow9jV6c330NIVvw0HPgXKactC9KQknYMkbMj5Tl8zowyonvVc+vfdh5/AU7L0+/vCM4pDE=
X-Received: by 2002:a05:6218:280a:b0:1c3:89d4:e888 with SMTP id
 e5c5f4694b2df-1c641f40665mr304741855d.20.1731086674864; Fri, 08 Nov 2024
 09:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20241106174443.557557-1-pbonzini@redhat.com>
In-Reply-To: <20241106174443.557557-1-pbonzini@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 8 Nov 2024 23:24:37 +0600
Message-ID: <CAFfO_h5R0_iLLk3N=VJfXKPpYzYEvg2swk49PzVo1yoR4Auc3Q@mail.gmail.com>
Subject: Re: [PATCH] eif: cope with huge section sizes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Nov 6, 2024 at 11:44=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Check for overflow as well as allocation failure.  Resolves Coverity CID =
1564859.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/eif.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 7 deletions(-)
>
> diff --git a/hw/core/eif.c b/hw/core/eif.c
> index cbcd80de58b..25f2aedf3fa 100644
> --- a/hw/core/eif.c
> +++ b/hw/core/eif.c
> @@ -123,6 +123,10 @@ static bool read_eif_header(FILE *f, EifHeader *head=
er, uint32_t *crc,
>
>      for (int i =3D 0; i < MAX_SECTIONS; ++i) {
>          header->section_sizes[i] =3D be64_to_cpu(header->section_sizes[i=
]);
> +        if (header->section_sizes[i] > SSIZE_MAX) {
> +            error_setg(errp, "Invalid EIF image. Section size out of bou=
nds");
> +            return false;
> +        }
>      }
>
>      header->unused =3D be32_to_cpu(header->unused);
> @@ -282,7 +286,12 @@ static bool get_signature_fingerprint_sha384(FILE *e=
if, uint64_t size,
>      struct cbor_load_result result;
>      bool ret =3D false;
>
> -    sig =3D g_malloc(size);
> +    sig =3D g_try_malloc(size);
> +    if (!sig) {
> +        error_setg(errp, "Out of memory reading signature section");
> +        goto cleanup;
> +    }
> +
>      got =3D fread(sig, 1, size, eif);
>      if ((uint64_t) got !=3D size) {
>          error_setg(errp, "Failed to read EIF signature section data");
> @@ -324,7 +333,12 @@ static bool get_signature_fingerprint_sha384(FILE *e=
if, uint64_t size,
>          error_setg(errp, "Invalid signature CBOR");
>          goto cleanup;
>      }
> -    cert =3D g_malloc(len);
> +    cert =3D g_try_malloc(len);
> +    if (!cert) {
> +        error_setg(errp, "Out of memory reading signature section");
> +        goto cleanup;
> +    }
> +
>      for (int i =3D 0; i < len; ++i) {
>          cbor_item_t *tmp =3D cbor_array_get(pair->value, i);
>          if (!tmp) {
> @@ -503,7 +517,11 @@ bool read_eif_file(const char *eif_path, const char =
*machine_initrd,
>                  goto cleanup;
>              }
>
> -            ptr =3D g_malloc(hdr.section_size);
> +            ptr =3D g_try_malloc(hdr.section_size);
> +            if (!ptr) {
> +                error_setg(errp, "Out of memory reading kernel section")=
;
> +                goto cleanup;
> +            }
>
>              iov_ptr =3D g_malloc(sizeof(struct iovec));
>              iov_ptr->iov_base =3D ptr;
> @@ -528,7 +546,11 @@ bool read_eif_file(const char *eif_path, const char =
*machine_initrd,
>                  goto cleanup;
>              }
>              size =3D hdr.section_size;
> -            *cmdline =3D g_malloc(size + 1);
> +            *cmdline =3D g_try_malloc(size + 1);
> +            if (!cmdline) {
> +                error_setg(errp, "Out of memory reading command line sec=
tion");
> +                goto cleanup;
> +            }

I was looking into doing some changes on top of this patch and this
check above should be if (!(*cmdline)), right?

Regards,
Dorjoy

