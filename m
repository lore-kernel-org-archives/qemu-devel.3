Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C0DCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNW8q-0003pT-UQ; Mon, 24 Nov 2025 07:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNW8p-0003p0-29
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:58:03 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNW8n-0001yC-Aw
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:58:02 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7815092cd0bso38950047b3.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763989080; x=1764593880; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K614BIREjHpHDSYsrtLdXhkUTrcbrRJLRkEVq+4AviI=;
 b=hyuGiMR7Doev1+MEhUZctCMp6SQAvYN9KWxS4d2ZKUUc9UZr4+3GkUeK9/Avp9JUlR
 TXbiLn0Bx49STiTR9L7SGZG/6B7KVMXZlziYJ/p87NCpJArIrI92Tgx2PCjXiSkfZxdy
 vZKKE0+/I86YFz2+sXb9E6vsB3uZcjoUcNtJkTIVBqnB8Mh0oVcsvuQY6mPwEsgznOXc
 ZDUI8FMj4RHZoH0CPs/wBzq0Ya/EVrOZbtiPLmw1n1lMhGan4IF5mO7ooByrfp5rGXx/
 YfEqXT+xbT4S6ZqGzivgKwg5ncNJrpSzSzMn2B1eYLx0zVcFegjuDeX5k7aJsOobbHAe
 XYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763989080; x=1764593880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K614BIREjHpHDSYsrtLdXhkUTrcbrRJLRkEVq+4AviI=;
 b=mTKd8fzrVyOwP0w7kp/LakZ5ewECk4oVdMN2wtWGhStrq1LolYynOZkSOjPkOm/DO5
 tpQqm4OgPdUACl4WwoBZT8VylTkxgnOquBJ4D7CXIQCkdOdbJ7EC5XET6dtt5T1K9AUn
 AWmwpUye8ZNi+5FPifBqr1x/cTSEXcY8Q0N8zLZuw0cREXw5ENO/4hJSNLxPEdI+aIzz
 DoKgMBGwCuobtHnQAqEim6XkKA3C6NmxxRO2PVPcFnwqkSDZrOuwFyuS32h6Tqd8dHnl
 PTQZRFe4SSC6xlapJISl2i2/JJbglqRPQ0R00MNza4CwfnhbLBg7tuCg+u4OQIkARnC/
 SMhw==
X-Gm-Message-State: AOJu0YyA7Ir5S/LOpFN2Xu+zL7bo4WB+BO2kX24ED3vuMUU+QabvqERA
 IufU725GxfASvuVh+hDwor+nigj1lzu09N4Ivby+fAaSff4YlM3LxpeVUkFBIIDyyuM1XJJgVzO
 Ws5eIoFw4MG4/DPzCW6FjW44GsIxJ3dM92HVwWRRvZw==
X-Gm-Gg: ASbGncsBp+tB8JH/2ufVlKP3U8oZe9Q67zgcjO9XT+92ufs2qer5d/VUjtnSgiHz6Iv
 9j6ifaH1wVH/ODLspo5OkMCa4bcMS9+XCchtwwWQBdTrfflzBdlFDgxYSJOLVydgRHpPGrTldQ9
 zbEXyIrf7stji6SksnzEXCXDOISxnskPVtzQ1k6q5+HhLak1NNxIxHJYx7x0QX230edekJ8a9UY
 SHsPPyYqwGfhtlo2H0Hi7Jqy5c6h+ASHeyy4jfX2jxnfEsefbhAPGaBKptGRNFGTnWyOCyJ
X-Google-Smtp-Source: AGHT+IGZJ3+hVJkY5NGR8ijdSIHG/uDUCcbESDNrzf+Zm5zEdecSwzOPkmOmBHc95mlIfUpt1hyfbT9xWjXZ7Sew6jA=
X-Received: by 2002:a05:690c:d18:b0:788:201c:a170 with SMTP id
 00721157ae682-78a8b52b6a8mr182725607b3.42.1763989080194; Mon, 24 Nov 2025
 04:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20251124122224.80830-1-philmd@linaro.org>
In-Reply-To: <20251124122224.80830-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 12:57:48 +0000
X-Gm-Features: AWmQ_bkzqAQUpq2Lk4twtNv0eToHm9TsOPtMepdCGrJAseXAd_nVZBtICibLAhY
Message-ID: <CAFEAcA_55OYZLLk0U-qeSvnZagN=9ZVVGgwQzM88Wk2cEdpTNA@mail.gmail.com>
Subject: Re: [RFC-PATCH-for-11.0] loader: Add support for U-Boot
 Zstandard-compressed image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 24 Nov 2025 at 12:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> U-Boot is able to decompress Zstandard images since almost
> 6 years (u-boot commit 8509f22a).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
> ---
>  hw/core/loader.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index e5904cdafa1..97fa8248ce7 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -635,7 +635,7 @@ static ssize_t load_uboot_image(const char *filename,=
 hwaddr *ep,
>      uboot_image_header_t *hdr =3D &h;
>      uint8_t *data =3D NULL;
>      int ret =3D -1;
> -    int do_uncompress =3D 0;
> +    bool do_uncompress =3D false;
>
>      fd =3D open(filename, O_RDONLY | O_BINARY);
>      if (fd < 0)
> @@ -685,7 +685,8 @@ static ssize_t load_uboot_image(const char *filename,=
 hwaddr *ep,
>          case IH_COMP_NONE:
>              break;
>          case IH_COMP_GZIP:
> -            do_uncompress =3D 1;
> +        case IH_COMP_ZSTD:
> +            do_uncompress =3D true;
>              break;

Here we set do_uncompress whether QEMU was built with
CONFIG_ZSTD or not...

>          default:
>              fprintf(stderr,
> @@ -747,10 +748,23 @@ static ssize_t load_uboot_image(const char *filenam=
e, hwaddr *ep,
>          max_bytes =3D UBOOT_MAX_GUNZIP_BYTES;
>          data =3D g_malloc(max_bytes);
>
> -        bytes =3D gunzip(data, max_bytes, compressed_data, hdr->ih_size)=
;
> +        switch (hdr->ih_comp) {
> +        case IH_COMP_GZIP:
> +            bytes =3D gunzip(data, max_bytes, compressed_data, hdr->ih_s=
ize);
> +            break;
> +#ifdef CONFIG_ZSTD
> +        case IH_COMP_ZSTD: {
> +            size_t ret =3D ZSTD_decompress(data, max_bytes,
> +                                         compressed_data, hdr->ih_size);
> +            bytes =3D ZSTD_isError(ret) ? -1 : (ssize_t) ret;
> +            } break;
> +#endif

...so here if the user passes a ZSTD image to a QEMU
built without CONFIG_ZSTD I think we fall into the default
case and assert.

I think the neatest fix for this would be to have the
switch (hdr->ih_comp) that sets do_uncompress to have
an ifdef for CONFIG_ZSTD so that we can tell the user
"couldn't load this image because QEMU was compiled without
zstd support".

PS: do we need to cast ret to a ssize_t ? bytes is
already a ssize_t variable.

thanks
-- PMM

