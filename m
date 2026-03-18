Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379BF10854DF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nWf-0006Eu-S8; Wed, 18 Mar 2026 05:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nWd-0006Ej-QM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:49:16 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nWc-0007sn-0s
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:49:15 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-38a4118c4f7so71301931fa.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773827351; cv=none;
 d=google.com; s=arc-20240605;
 b=Up7zz8oQuIuPRdC6eoMrZsGbEAdRjf7yoKxBQEFc/u7xdDjXWo9w0neyDUS5I2Dk/c
 CKXGruXKa7ZipOqjIwo6Caiu6QOcEM9t30jhPT635qwUVxaXNjO9X+OZ0Yj6uYXnCnQM
 pl0k8ziISLeMj/R88a9IWPiG5RxFJn/yO8GmWb9JgEiv23P8wo/1IzlLDqUJ9VLF0QG6
 qh2GwOthu0sPHgpBt/gDnJUXreWYdW0qcfsxOnHs/+fDJ8ti2e/T+CvXWy0n3IWhrmx6
 KccTNUKbCWFmlQ0fyoMrrFbJAW17dJgOSt1h1Oaj7AcJXtMxRTg8F6ud57G9ycjmGoZu
 a8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I0wPu/lEJmcvlbKKM5OHBGJe3tIJSA8ZXnt1tdIG+UY=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=CBmHjz7k9obFEVjRzrVNH6MjyxQo4Pwmwo3bRVyyYl8f9o6JAycD+YwwlQjMcuRj8N
 finWb9tJwVW7Gh9t+8dZnZryp9p0nwhZUhNrSToypzV9AeJBXdi8HrhaW0RSy5ELHmCi
 5BCoNN4mq19L7N8BbmdGnH6Xyp/54kCakN6tdw1CNj+lj4r5BqB/fg1sF0YWFL4XsckN
 /bsf0/OKoW1PVlxR4Giywzc/7UFD3lQ/QOCN+xs8vNkxu+TxHTjqFFxxHFH75wOQbeMO
 MZ+g3mJTjRWgARMUGLhlerI9vw8ILFKQ+2vr0AB5jaHHJNYtb6vfkWAEqwMeYdhEITHe
 upOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773827351; x=1774432151; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0wPu/lEJmcvlbKKM5OHBGJe3tIJSA8ZXnt1tdIG+UY=;
 b=ZoMC8PGvJQhA3nWdow2VbiXtlBXhjBmigCQsLPFW38WQp8OaRPEPHlxJaUOpzeCF+Y
 i3Ugn5xevYowmXC1nvlOjxHH0kISB/bQYwyYEJZPQoLh4vSoGRTyKljlGcUHMBz1w5Gd
 WS4ahd6NKAO+ChDZOfupzV2F8OAkZMQ1xrbds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773827351; x=1774432151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0wPu/lEJmcvlbKKM5OHBGJe3tIJSA8ZXnt1tdIG+UY=;
 b=EH5YnzwogxfLZMXnDQsOswWS0H/h9A6MCcHZYubcN4D0gdVKsCYoGIW3lkzkwopv/7
 Ush03359NEDO3kY/pk4f6rxhZLp/SSOnmxoWHTQXUOXMmbkhqlNMf/CRxgn+dC/qSAZr
 iCnyms7n1s4j2+9gq5c9ycbVP7Iy/EvgcNy8ONS3ft++0gvRl0i0cyIH016eTtCBXUPP
 RaRpswp0Jw3nHBp14hnwO5lr5ABdZlyqEWofHrMa7povaRgxhiwJ09tffsmlBs/0YyCY
 NQjB6n9X5Pz20QDznOMWLSjeXDU2faCPo9/+CEJfJVz86G2uhBbf4l+4YTiFLZdYadng
 ShWg==
X-Gm-Message-State: AOJu0YwCZN8WfsBc6QfgO7666TtHE/YzR1C0RE1rBw8Kg5j9/k4xAZZ1
 QgdoMqkvyGHV5f2CFuNRCCSbrc3VPQwHF5oyTReI09wleFcVkml2mJeqPDoEf7DtBRe00/DUEaG
 V1NzYfp6E+5P7SniSusfcBqvKhf7MyCMs8b0wKiVRXCLNeDdTpq5rFEmm9A==
X-Gm-Gg: ATEYQzyJHNi0/YFjsI+u9i13s0IDEFYaseu1HzelLR5jBWIC2oRC2S8ZVPd4sDc72uc
 D38O+tF8mdR0vrU3YZ8Fi1AL6MlBNJVnAT967m95RjKiWhACdkBMAbv5dLqyQa7DrkqutcaOV/M
 QS+JwP1Oy5XPW5OUs5aLQzGcTZDm7fOrULe/dBfufvzVCNdZVeR5PBzFFbHZg7/1BwmlX6t1BaU
 jeaFV8+/kRN5pN8DToDaPgb9nMcJPRnF9WrDQy6Ba9B3Huq4FEvv+U5eb63PCOcIIQ9tLoevRv2
 fxZGAcM1He/dd6aVoDE2ev6Ypl9P4EkIwBKkEpHkos69ilWTOg==
X-Received: by 2002:a05:651c:3248:10b0:38a:3dcb:927 with SMTP id
 38308e7fff4ca-38bd59b94a7mr8874081fa.35.1773827350532; Wed, 18 Mar 2026
 02:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-9-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-9-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:48:59 +0100
X-Gm-Features: AaiRm52AXyt-V2hOlbju6LTY94ezW_6rtskwzWd6LHT3rGuExOqsPWppYQyT1mg
Message-ID: <CAJqdLroCO105YVCdXnTv9ndmU1-UYfwuKmK6R0WkGO+cPs4suQ@mail.gmail.com>
Subject: Re: [PATCH RFC 08/10] vmstate: Implement load of ptr marker in
 vmstate core
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alexander@mihalicyn.com; helo=mail-lj1-x22a.google.com
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

Am Mi., 18. M=C3=A4rz 2026 um 00:23 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> The loader side of ptr marker is pretty straightforward, instead of playi=
ng
> the inner_field trick, just do the load manually assuming the marker layo=
ut
> is a stable ABI (which it is true already).
>
> This will remove some logic while loading VMSD, and hopefully it makes it
> slightly easier to read.  Unfortunately, we still need to keep the sender
> side because of the JSON blob we're maintaining..
>
> This paves way for future processing of non-NULL markers as well.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  migration/vmstate-types.c | 12 ++++--------
>  migration/vmstate.c       | 40 ++++++++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index b31689fc3c..ae465c5c2c 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -363,14 +363,10 @@ static bool load_ptr_marker(QEMUFile *f, void *pv, =
size_t size,
>                              const VMStateField *field, Error **errp)
>
>  {
> -    int byte =3D qemu_get_byte(f);
> -
> -    if (byte =3D=3D VMS_MARKER_PTR_NULL || byte =3D=3D VMS_MARKER_PTR_VA=
LID) {
> -        /* TODO: process PTR_VALID case */
> -        return true;
> -    }
> -
> -    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
> +    /*
> +     * Load is done in vmstate core, see vmstate_ptr_marker_load().
> +     */
> +    g_assert_not_reached();
>      return false;
>  }
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index a3a5f25946..d65fc84dfa 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -142,6 +142,21 @@ static void vmstate_handle_alloc(void *ptr, const VM=
StateField *field,
>      }
>  }
>
> +static bool vmstate_ptr_marker_load(QEMUFile *f, bool *load_field,
> +                                    Error **errp)
> +{
> +    int byte =3D qemu_get_byte(f);
> +
> +    if (byte =3D=3D VMS_MARKER_PTR_NULL) {
> +        /* When it's a null ptr marker, do not continue the load */
> +        *load_field =3D false;
> +        return true;
> +    }
> +
> +    error_setg(errp, "Unexpected ptr marker: %d", byte);
> +    return false;
> +}
> +
>  static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaqu=
e,
>                               Error **errp)
>  {
> @@ -264,30 +279,25 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDe=
scription *vmsd,
>              }
>
>              for (i =3D 0; i < n_elems; i++) {
> -                bool ok;
> +                /* If we will process the load of field? */
> +                bool load_field =3D true;
> +                bool ok =3D true;
>                  void *curr_elem =3D first_elem + size * i;
> -                const VMStateField *inner_field;
>
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      curr_elem =3D *(void **)curr_elem;
>                  }
>
>                  if (!curr_elem && size) {
> -                    /*
> -                     * If null pointer found (which should only happen i=
n
> -                     * an array of pointers), use null placeholder and d=
o
> -                     * not follow.
> -                     */
> -                    inner_field =3D vmsd_create_ptr_marker_field(field);
> -                } else {
> -                    inner_field =3D field;
> +                    /* Read the marker instead of VMSD itself */
> +                    if (!vmstate_ptr_marker_load(f, &load_field, errp)) =
{
> +                        trace_vmstate_load_field_error(field->name, -EIN=
VAL);
> +                        return false;
> +                    }
>                  }
>
> -                ok =3D vmstate_load_field(f, curr_elem, size, inner_fiel=
d, errp);
> -
> -                /* If we used a fake temp field.. free it now */
> -                if (inner_field !=3D field) {
> -                    g_clear_pointer((gpointer *)&inner_field, g_free);
> +                if (load_field) {
> +                    ok =3D vmstate_load_field(f, curr_elem, size, field,=
 errp);
>                  }
>
>                  if (ok) {
> --
> 2.50.1
>

