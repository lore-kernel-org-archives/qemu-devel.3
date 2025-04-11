Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAA0C369A6
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 01:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u33Gi-0007Fe-Ge; Thu, 10 Apr 2025 21:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u33Gg-0007Eo-Kb; Thu, 10 Apr 2025 21:33:18 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u33Gf-0007s3-0N; Thu, 10 Apr 2025 21:33:18 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-523de538206so640509e0c.2; 
 Thu, 10 Apr 2025 18:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744335194; x=1744939994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwaTPVOtNW6mqEnqlAQT2A7WqzkGjD0hPlDEjwUIBoY=;
 b=KY+sR18dcb2y07BYHt6GUXzmB3Yim+0CvvXX5Kcx0+5t7HRb47ngpxtZMmgQ/5qZ9n
 8/XoaKiYLHwfLho57y+VN4bVwDBJD5KkGyOcaEwaAAeOVvPxFIvPOjFFLxKx2VfjtOez
 JmYrA+itnsQ4d7DeJPvUxmiokCsgGDqjBdlOCGdBwwPZo9EVqqJkhl8tZ4dvqurXEsuy
 2sEOsljQuMU6SXcJA1v1kwaTzh1suPuCIRvpkdQrjYEkdIfv1xDVguwALnhnmBptqo50
 6KRNs21fplHuNdJm4UOQDv3tUjSVf7VbP+ORmAdJJYPCQprC8qDSgynaufYYmJhVpg5Q
 NyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744335194; x=1744939994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwaTPVOtNW6mqEnqlAQT2A7WqzkGjD0hPlDEjwUIBoY=;
 b=hOHVZBDwDDQGcx2iEec803akryXYtmVvj+KmqsyXlEKnpabTqL3xb7deMjCy988sze
 dXMdd1Q7mGEsIG4GHcq7YX3QlPD8J3eGSzUpU5l4ZmxlSVIZpiyLJvVswdgrJPbXv4ay
 n2zeqqeSvrwkhkiN3zq3/C0Y2Mf7nHCYS9D2E+CAo2pwYH4Srlxzyg4ExbDqvO0djgTV
 06ELdCF38fw/AUP4ovfmxo3T4z5M7hsdCBPH+KHCTXBlGPiTqcUl64sdo5Cnk5ZQd9zL
 t4SLEq2r3zNNaCi6nScnv6zYkByRzBYSuSxFYvc/E9jvKG0WuNqYBtVQNAJZrN+sFQGE
 wJTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM4el++4fw6QxgQynFuNzZ8ykNlVfNIbKsGY9v4Ym5NpSETCAmICMbjc4hxu4JH/T2PfEL118aubwc@nongnu.org
X-Gm-Message-State: AOJu0YyQ61eJcLtVNRjFlGC99Da+PAM36Biv7UAEj3qqZyhZhuE25aPr
 HrVJmDRRP3z4/jjwnJSUZeMxnS7M66B17hztHs85OGzbqrBf2uEs8sBXQGDT6iKdjGhgAyti1Up
 tB7StSTu7xgD+rH047gU+HXzhScQ=
X-Gm-Gg: ASbGncsV3xVbUoaix7Fai+1fdppH1Q32Ctpr+VcQn01/gf35mnrUHst50bKEpFhGaox
 0fRJf38hE7ZZhh/FoHsOvoJtNsgOU7CgCkrmR2bW0vvv870rO1jK6wJP+q4IsM1SC6ygAV2GTSg
 bpET2KNfnXJzcVtPxolB5mUxtqA2s+DRpOhG1kdaXx9CNsvTE7XKth4VB4b4nlGpQ=
X-Google-Smtp-Source: AGHT+IHJsU+tbyHQ1GPm+QcZiBxiYw6VB7NlwFuI93KxvAs1V5AUNHAJafBkLCmOdmj1pSUdNyhQHEQhSnzUE/I9wvU=
X-Received: by 2002:a05:6122:a22:b0:520:3987:ce0b with SMTP id
 71dfb90a1353d-527c349533cmr1004789e0c.2.1744335193986; Thu, 10 Apr 2025
 18:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250410161722.595634-1-pbonzini@redhat.com>
In-Reply-To: <20250410161722.595634-1-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Apr 2025 11:32:47 +1000
X-Gm-Features: ATxdqUENqfrI05L3VGUXO26Xr0C7Ed90vQWT5uyKXIjebvnjstk9A_MdU8D9UZE
Message-ID: <CAKmqyKPX=q0GUQfnLT4avW069tijK84T4ZonLy1cEs91AAPMaw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: Fix type conflict of GLib function pointers
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Fri, Apr 11, 2025 at 2:19=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> qtest_set_command_cb passed to g_once should match GThreadFunc,
> which it does not.  But using g_once is actually unnecessary,
> because the function is called by riscv_harts_realize() under
> the Big QEMU Lock.
>
> Reported-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv_hart.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index a55d1566687..bb9104bae0b 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -104,8 +104,11 @@ static bool csr_qtest_callback(CharBackend *chr, gch=
ar **words)
>
>  static void riscv_cpu_register_csr_qtest_callback(void)
>  {
> -    static GOnce once;
> -    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback)=
;
> +    static bool first =3D true;
> +    if (first) {
> +        first =3D false;
> +        qtest_set_command_cb(csr_qtest_callback);
> +    }
>  }
>  #endif
>
> --
> 2.49.0
>
>

