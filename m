Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E16E784A6
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 09:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYi6M-0006iU-33; Thu, 25 Dec 2025 04:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vYi6J-0006i0-Qj
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 04:57:43 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vYi6H-000768-VW
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 04:57:43 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8052725de4so535011566b.0
 for <qemu-devel@nongnu.org>; Thu, 25 Dec 2025 01:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766656658; x=1767261458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UE2GoNXWFIL2IXUpa/1wvu3P6mFxDmEUgJeVUv9/LFQ=;
 b=AyF5BFa/p7POp82L/oCC7H4xD5lwrD+35sSq29CQClwJQEQkqzYWejz68Dp6Ocuvqu
 U12KYFdqvwZms8JF6gkGhvir01oy9LENrQyKbxxf6JmzauRsbeYlrfFXhpDKnuvVnMgD
 WDWo5eKRW3VriC9ikFZcnRQ0cAjOXwTUadHBgZqsYuMqvFhqmS9JQ8Ag0rRxdAJYYAiZ
 Vhl9SBt166siuqQ8Xxk2OtyU1FCRD+D09+RRmgAqbFyJxy4d021nOi6Hw+4YByBmtzkZ
 w4kiL9Frk2zG8VRcSNbyRrw2FLkNKElJ/KbX8z80s0QF4Ln4f/A8VU/q4ZojANH7BtAy
 XSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766656658; x=1767261458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UE2GoNXWFIL2IXUpa/1wvu3P6mFxDmEUgJeVUv9/LFQ=;
 b=lOUkvEyJzSPGvpHzCYV2ztuaZ/IKlFUtjP/tZvSP8NAGG0ws1jQPkyOT7t0SJAW7kf
 kgNFWA+E7z1ocDY4uCcP2GO3ILzu7PmevOEL1G6agZt3Uojt9uW8B2UeXGVEO+b7jQmm
 U2G2yfFgHvrAoQbKfO5nIsGd24yKShc125dD6Trh+svETuIQ7NYmNpo4svEo5KetX424
 E9R30SJflADddY5r8X4tty14IvPCblPTdYjPYP09IyBo4RP6mFBUDE+LXnni1pT+Dq0U
 JTgoCjpoA07n9imELvILFW3PhSAHbFoqoFoDOia2r5p0xRxHbruvrHFArEqVgRhdY44y
 pNcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWMMtVb+0unOkLm8ryZ5vpGroMIuf/pXEfozr/1J7xZs71R/mdaSEGI82aIBfjT+JsEYGYHp6ERwNA@nongnu.org
X-Gm-Message-State: AOJu0YwPXvf0nKXyWuueFQGkK5QBgw9STH2Jhm7Bia6pg+F8QKERLL4t
 7l6nc/OJXtSQ1x8FAn26KxNbBngDby3mD4fjJbxNMzeJXsJut4CReiF3psJvhE4ua/3AvcbLfpk
 N1o77j+O3o0tZGFhhd7xVa6u2Y0re340=
X-Gm-Gg: AY/fxX5fSXiEnc5em2T30Kt9yhnIce3h1nDLGT1iFydSEeiS6WqViW0nrQHeYIj7+Ix
 wo8GvyNihj55UG2cxiLhLZQULTe99UQZg2Ut545Bkip3Rc9W5tKgx7BM06QeEFD0jM7YR+J95+4
 8A9edQs/x2atTVxPSAWJo2zgnrNfCUcNL6rgPrUJkdIPCLAU4Jq9Q0yAbzfS/IAt13hmwajWt9a
 d7GVCf7qksDu6dbkBx1wbG5i/dhRjRwFMgo4YZf7jQ3dDxmJtnFvxKcqqEs7QiBNBENshI7
X-Google-Smtp-Source: AGHT+IEtbEdG4UiHAhLGl90KS4v+DggenqQoY31flklXZtJNAAtjzSo4ov3CrwPdjUnvXSVbqjvbfTvqmbLIP0LYBzY=
X-Received: by 2002:a17:907:940a:b0:b2d:830a:8c01 with SMTP id
 a640c23a62f3a-b80371df334mr1925940266b.61.1766656657823; Thu, 25 Dec 2025
 01:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20251225072442.36012-1-jasowang@redhat.com>
In-Reply-To: <20251225072442.36012-1-jasowang@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 25 Dec 2025 17:56:57 +0800
X-Gm-Features: AQt7F2qZLbBrVybm8FO4hK0Z-pr31lknM5HzXrY1S_EAn8Iyqp4WA9fMSgtxDbs
Message-ID: <CAK3tnv+NoBtYgJhJFXipvCvSM+MGTobitZUzkZfyvhiA4FAJeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/filter-buffer: make interval change take effect
 immediately
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Dec 25, 2025 at 3:24=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Previously, when the 'interval' property was modified at runtime via
> QMP, the new value would only take effect after the current timer
> period elapsed. This could lead to unexpected behavior when users
> expect immediate changes.
>
> Fix this by checking if the timer is already running when setting
> the interval property. If so, reschedule the timer with the new
> interval value immediately.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

LGTM.
Reviewed-by: Zhang Chen <zhangckid@gmail.com>

> ---
>  net/filter-buffer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
> index a36be31dc8..427da24097 100644
> --- a/net/filter-buffer.c
> +++ b/net/filter-buffer.c
> @@ -159,6 +159,7 @@ static void filter_buffer_set_interval(Object *obj, V=
isitor *v,
>                                         Error **errp)
>  {
>      FilterBufferState *s =3D FILTER_BUFFER(obj);
> +    NetFilterState *nf =3D NETFILTER(obj);
>      uint32_t value;
>
>      if (!visit_type_uint32(v, name, &value, errp)) {
> @@ -170,6 +171,11 @@ static void filter_buffer_set_interval(Object *obj, =
Visitor *v,
>          return;
>      }
>      s->interval =3D value;
> +
> +    if (nf->netdev && nf->on) {
> +        timer_mod(&s->release_timer,
> +                  qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + s->interval);
> +    }
>  }
>
>  static void filter_buffer_class_init(ObjectClass *oc, const void *data)
> --
> 2.34.1
>

