Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C49D3517E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7veL-0003OE-6U; Wed, 01 Apr 2026 09:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7veI-0003MB-38
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:30:22 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7veG-0006Op-GD
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:30:21 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5a159c1e65aso6446707e87.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050218; cv=none;
 d=google.com; s=arc-20240605;
 b=UrpT3qhsZu1JKN0252hulSM3fF899PtpFgJjot4/0hKR+lV2vhejKiJWmegjqLcdI9
 7Fluk9x1ErIHn5Tvx3gxHZZf3/eMkMHX2930cRwyoa3Xs6O0pId0U/tqCCOKthGgYEa7
 8awvhU5Fo9wZ4v9PwEF1dGnb9V2dlf7UwTEIuGfD8nnVZnrq6w3/ugVfxo5So33P3SsA
 E6IpEvWzCzr5PDTBWegdlk6SdbrHpoixT/KvVl1BQ1azSKUWWRzjmump+1kDk9GZ5MIq
 qyGbxdG5ojZ2OefesOA6zxBbGd9aFYvAH+h30/yhw6iUZ/8zb0ScJuAdO2gTO44z3xg1
 IhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6yvsH32Jpv+V5g++5c/HZKx21J66tjsfQWFwlt+vrtE=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=XwQTrMUSpn/zjy3DCFk2UYr7cD1vo8+tApA3fzx1b2ha3Hwo95BWqlOhYNPr52VAHg
 MU21Gd5zeqBN+xr39mhdyjSEmcpWo3beF+J0f4q4YN28IgdOEkWYpUc8Yk2C5Kugx8TE
 3GkNP7vZWLkVsfYo7sJ4qP6eTXdZyj55xshVNXgjUTDjpIElEih/sDvpucQ1ThzVLn5/
 qL95PJ9Puss+KJLyobyIVqDm0YJmEXPf6mxzzlabFxcN3renav+sB+8MxhFRpduXOAQZ
 l7lOp6YH0fbNNDUJ/+Tcskh89CulkowP9M/RNQhZM5nQK2MWEBnkSqkoAxNq2LwhsgYU
 M+gg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775050218; x=1775655018; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yvsH32Jpv+V5g++5c/HZKx21J66tjsfQWFwlt+vrtE=;
 b=JUBAWL5jydeKjyXCJJElg1VclCeZ51YDUcySOZEzaWOczD0WC245cgYhTvuL9jcC+6
 B+iWg2F2F3OjxvwPiq8WIpivhdevM1I7tclj0WPwEexnAGcJhcYiWbbSSb2ZHShHj/y+
 9mqV5fjFv4pW+xkOrOr/CmMbw0ybLZDyl03Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050218; x=1775655018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6yvsH32Jpv+V5g++5c/HZKx21J66tjsfQWFwlt+vrtE=;
 b=pmf6ilGkc8RGhRiQ2FKIwMiyMQplKcKB/M5Rtr1ZzVP4doI7vqbgBq5vPNZvNuGCzp
 kicu2YiDi3Uw5VRKZCGodwZESYmEoePLx3Bm2ZopuROQTHT7s4xEh3gk/GZMpjF1Ie+T
 Z9v805kwnmZKpzeE5ZN+GEGmgMOlsHVF2xGI/DngXGx7nW9UMyAO4mgk4s6z3yZd1Nja
 zXSfMX6vwp74DtjDMPwzAgRxmTpqvoZFYytnfuAMSMYl0fpPP/ATncOOBgrsiY/paYjd
 UJnSfri+s7melmqj1Q2/gr2XA/7uaN1WAUFfCANKW3xrqdHAjXwTz+REWlkKxxciq6Ba
 7wLw==
X-Gm-Message-State: AOJu0Yz/Qk7Dnm8XupDIZ+OGEPPgesc35y34meeF2kCHLIBBrjL8Edvt
 xwrtBydHejqEI9lBzCv/1ib6L1onjhMVA5g7CefIRkeXULSJArwtXc+8W8MyKPUMvdJ5P7pZnHY
 jwqPmdnjM1b5zk03Pe6Xssk4jK6DwMN5M3gI/k1dUdd9pbdBgr6mf1g4=
X-Gm-Gg: ATEYQzy1HPjRdJ55wWTEsX7nCe5nHOwFtmZz/J7yeNXlkMdAdL95li1X3ItZ0hxzbVA
 he+qNtqd6eZSpQjj+Y3dSdq+2Rg7A1phEgyZ/w8GANZ+/3TTS4ks/4Vq8uWxafXh8IbxdtQJ6MD
 TCqH5TCAfgNBZbSKJFEpfHRa2BvR2BEnL9su1AhZT2caQt3W2eBoeUl8MRk7OJzmQKn0VGrDsIh
 8eGlquSHtFIWB/7p253lhajWVyr6Y1PEfzJCiPiM1qy8W+kEeUdOpMotLh2ZstFX4nJWPYBFPzt
 3XHe1772B+4Xv94LmTiZ8xMOGv5uVOKUOhig/A==
X-Received: by 2002:a05:6512:1091:b0:5a0:ee11:8d94 with SMTP id
 2adb3069b0e04-5a2c1ee245amr1515411e87.1.1775050218229; Wed, 01 Apr 2026
 06:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-11-peterx@redhat.com>
In-Reply-To: <20260326210532.379027-11-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 1 Apr 2026 15:30:06 +0200
X-Gm-Features: AQROBzA-aDsa_on9MPufAJXvHPVNnydmEM1KzJPoJKO44tfQDQC1DS2uv-fFkNg
Message-ID: <CAJqdLrqqMz_fkc6VnKD=wToqpUoZfWr2rVc_mcQL261NieEtQg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/11] vmstate: Stop checking size for nullptr
 compression
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Do., 26. M=C3=A4rz 2026 um 22:05 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> From: Fabiano Rosas <farosas@suse.de>
>
> The NULL pointer marker code applies only to VMS_ARRAY_OF_POINTER,
> where the size is never NULL. Move the setting of is_null under
> VMS_ARRAY_OF_POINTER, so we can stop checking the size.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  migration/vmstate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 9cd0a88ce9..1923602f3b 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -673,14 +673,14 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const =
VMStateDescription *vmsd,
>                  const VMStateField *inner_field;
>                  /* maximum number of elements to compress in the JSON bl=
ob */
>                  int max_elems =3D vmsd_can_compress(field) ? (n_elems - =
i) : 1;
> -                bool use_marker_field, is_null;
> +                bool use_marker_field, is_null =3D false;
>
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      assert(curr_elem);
>                      curr_elem =3D *(void **)curr_elem;
> +                    is_null =3D !curr_elem;
>                  }
>
> -                is_null =3D !curr_elem && size;
>                  use_marker_field =3D use_dynamic_array || is_null;
>
>                  if (use_marker_field) {
> @@ -708,7 +708,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>
>                      for (int j =3D i + 1; j < n_elems; j++) {
>                          void *elem =3D *(void **)(first_elem + size * j)=
;
> -                        bool elem_is_null =3D !elem && size;
> +                        bool elem_is_null =3D !elem;
>
>                          if (is_null !=3D elem_is_null) {
>                              max_elems =3D j - i;
> --
> 2.50.1
>

