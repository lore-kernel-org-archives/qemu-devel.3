Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2158CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30v3-0002MW-7O; Sun, 28 Sep 2025 19:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30uz-0002MH-CV
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:35:01 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30um-00069F-4F
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:34:59 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3d50882cc2so148912466b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759102480; x=1759707280; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8WmmeDeDoONnFHi1ByGVfDBiZFbMtQVsSiRfjLQszM=;
 b=ZZHN2qMnaVz3xWEum7r1/mNZGSaiyUF1yPVTJadUcP7GENHbuKQMMlITrI8ORk2kNR
 jxRnFj9oU3zi+4ooGooF9y0hZrT4CwJFeSf+HlicN0Xq4xgI23O24iQqPIuH1cHjANs/
 OCxRSDIHGWU+KwjIioLM/GaBv0hssvZsPzHjq2+6KHogZCQ9lM8bolq9WZbpWNqAwHII
 lpZyFN8m24oUNDC9gtGgaiO7Z48Do2xqMT8xeTp6WQ5hy7Zkbwj0Oyymb0idU4dXjsuI
 +QJFu6O6xcbwWX9ssc5IyaydNmItg3t1P1QOmteQgeE6yvsjMbumunRlLTEV8f1mzEy6
 GJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102480; x=1759707280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8WmmeDeDoONnFHi1ByGVfDBiZFbMtQVsSiRfjLQszM=;
 b=AA9ac/XEg/KAbMeUvNb5Waofm2BptsykrvCTpIzizEb1A6yjHVte8qYs5ecn8tlfzX
 pye7lb3HjHSWt0D6Pgr/L58If22rVF473/H9baZnwHAJ2dojKaAh5ycDzNLM7L+5hFXD
 oqvO+2q+EBlF1iKrQz7YGwQWp+jyo5YewK4W99l9PBwNLo6hKEOpIvL7zaSr94+AdLY+
 7GGNHhsOqynLshkKvl424QxLBPyvtyd8zZmupt0yflRiqRPT415sJ7OIbzON9qMa6Xes
 JMeF6bCOLC5SmFZQ49Z9rQegemap3cicmHRBds9fT1YVEskSX011wlfKuIJBTdH9RZtX
 Habw==
X-Gm-Message-State: AOJu0YwuNyBiUAzB2tftxW4yjA3s/DcbkbopX8T9SxsWpSWfJi+YMiv9
 iZWXiu34cp3cFu0uotfiQe3A50Uy2GyK692qy8WHV2KhCyNJ/hryIg2jsPZlamNc8MZWKUG6WqD
 Q6zRBjYxnOAWDjKqxJbki1hTe2BbciLw=
X-Gm-Gg: ASbGncuEaJ0l2bj2wHlm+VXhAm2CBLi+jCOjLePiGupefWEjZWEFCAJFif/eXqeLPO/
 P52tYozV3npZEvSjLz8U9Wdi/uJ25kIiHpnV9FzEJUqQBqljfs9s3n2xlmRAnIFwb51lmATH2MN
 tAqrZPpdJbZ/zzQme93nU/oi/J/uWSNwgRqGmXaphCUs2nPAkltPK0xK6vyWd1oYP6IdQVkFVjM
 uwrtgWtFycQKXJ8ffhwjpijW4ghlqnxlvglJozrt7wg+IPV
X-Google-Smtp-Source: AGHT+IGuN6TnogZqbKHMychFVgXtv5rkVd+8FcBZFBtQRxS3dnKOVwO4UBDLO4yL5cC+z9VPespeF17PrSyg9SPwRBQ=
X-Received: by 2002:a17:907:d93:b0:b3f:cc6d:e0a8 with SMTP id
 a640c23a62f3a-b3fcc7d24f9mr34315866b.17.1759102479800; Sun, 28 Sep 2025
 16:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-3-luc.michel@amd.com>
In-Reply-To: <20250917114450.175892-3-luc.michel@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:34:12 +1000
X-Gm-Features: AS18NWDAVFp9EkW51ZKQ5tTgQOSPEEbtItwqmPq8mODLyAVaHuw9ceZO6D2U8q0
Message-ID: <CAKmqyKMTO3-6zdJMp8RuP1LpvNDcJYbz+0bJma52qDjQA-vpWg@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/core/register: add the REGISTER_ARRAY type
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 17, 2025 at 9:51=E2=80=AFPM Luc Michel <luc.michel@amd.com> wro=
te:
>
> Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
> RegisterInfoArray struct. When `register_init_block' is called, it create=
s
> a REGISTER_ARRAY object and parents it to the calling device. This way
> it gets finalized when the device is.
>
> The finalize function of the REGISTER_ARRAY type performs the necessary
> cleaning that used to be done by `register_finalize_block'. The latter
> is left empty and will be removed when all the register API users have
> been refactored.
>
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/register.h |  4 ++++
>  hw/core/register.c    | 24 +++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/register.h b/include/hw/register.h
> index 4d13ea183c7..65c82600e06 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -81,10 +81,12 @@ struct RegisterInfo {
>      const RegisterAccessInfo *access;
>
>      void *opaque;
>  };
>
> +#define TYPE_REGISTER_ARRAY "qemu-register-array"
> +OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
>
>  /**
>   * This structure is used to group all of the individual registers which=
 are
>   * modeled using the RegisterInfo structure.
>   *
> @@ -94,10 +96,12 @@ struct RegisterInfo {
>   *
>   * @mem: optional Memory region for the register
>   */
>
>  struct RegisterInfoArray {
> +    Object parent_obj;
> +
>      MemoryRegion mem;
>
>      int num_elements;
>      RegisterInfo **r;
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 57dde29710c..4d1cce02a55 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -243,14 +243,20 @@ static RegisterInfoArray *register_init_block(Devic=
eState *owner,
>                                                bool debug_enabled,
>                                                uint64_t memory_size,
>                                                size_t data_size_bits)
>  {
>      const char *device_prefix =3D object_get_typename(OBJECT(owner));
> -    RegisterInfoArray *r_array =3D g_new0(RegisterInfoArray, 1);
> +    Object *obj;
> +    RegisterInfoArray *r_array;
>      int data_size =3D data_size_bits >> 3;
>      int i;
>
> +    obj =3D object_new(TYPE_REGISTER_ARRAY);
> +    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
> +    object_unref(obj);
> +
> +    r_array =3D REGISTER_ARRAY(obj);
>      r_array->r =3D g_new0(RegisterInfo *, num);
>      r_array->num_elements =3D num;
>      r_array->debug =3D debug_enabled;
>      r_array->prefix =3D device_prefix;
>
> @@ -307,18 +313,30 @@ RegisterInfoArray *register_init_block64(DeviceStat=
e *owner,
>  {
>      return register_init_block(owner, rae, num, ri, (void *)
>                                 data, ops, debug_enabled, memory_size, 64=
);
>  }
>
> -void register_finalize_block(RegisterInfoArray *r_array)
> +static void register_array_finalize(Object *obj)
>  {
> +    RegisterInfoArray *r_array =3D REGISTER_ARRAY(obj);
> +
>      object_unparent(OBJECT(&r_array->mem));
>      g_free(r_array->r);
> -    g_free(r_array);
>  }
>
> +void register_finalize_block(RegisterInfoArray *r_array)
> +{
> +}
> +
> +static const TypeInfo register_array_info =3D {
> +    .name  =3D TYPE_REGISTER_ARRAY,
> +    .parent =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(RegisterInfoArray),
> +    .instance_finalize =3D register_array_finalize,
> +};
>
>  static void register_register_types(void)
>  {
> +    type_register_static(&register_array_info);
>  }
>
>  type_init(register_register_types)
> --
> 2.50.1
>
>

