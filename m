Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A362FD3517E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vW4-0005sb-4w; Wed, 01 Apr 2026 09:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vW0-0005sN-D7
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:21:48 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vVw-00055N-DB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:21:47 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a2b383cefaso4727855e87.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049702; cv=none;
 d=google.com; s=arc-20240605;
 b=UKhhadVeQxlxrdbmHJwb03DfQD+WWOZuS5okQWZRZjckTQ/qsjJncz2Od1x1MzZR8t
 vfuf8si9yX+a3vbWmjaPVFo/dp1RmFq8UXiq6XoRkpxbOmpSmihLbCd6/lPFiHsQOYey
 DK6Y+2KwRmezzlSQ7az4tuONpKIdKzUeHLZbJtDJuM3a92zZ/cenlUrQZWxNapx8Ap+U
 JbYClf0PREDtWn+IJ0ZjMHjhAlscTq1wog9wTAo3gi8PZwrh0Q+M18UmAP5CPJVrx6RU
 35CBppvzOcpFiTlYSRdECH36RsXLx3C3BgzL3I1XQcEdXqqFlqBBVf9bTCAVzBv+gYcI
 q9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DhiElDP7RPMCNegLNssU6HegcytRH+OBREuD/nKoqr4=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=KaXSzaxLPUdJmVsHN1ILQQwqXcIl8JoL1xje5Ef4+Kum5RChK2zILejjpeYXLdROJ8
 eGAvMGA/KbZPb+4oAh7lVofMdX8CdPbrBAvmr+oMKkLbXj0rEo7i0MqEf5G06aMiXffl
 +ezB5VhxkHFTDD9imCbW2l8YIajlv/Z3r4XP5dl9xa9Uwqva/VOSHCMdOqmQCzh60mwO
 t2ErdZA5MzqbD6B99bHzuQZMd4UTvti4u7Vsr5WwpVraXtncPUzU0dOyv3Nge0oUohmT
 VfdiDnczfgSZ473/nztMDPZzb3kdE/R8gRd/aB/PaZbpbqIiPe6bNdxs+2PLGJ/F+HNl
 MVtw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775049702; x=1775654502; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhiElDP7RPMCNegLNssU6HegcytRH+OBREuD/nKoqr4=;
 b=V/1MprVCBzuKpAARkeQ00rl+ujpICCzKycrJR5PftwSy1+LVOv1WxmZ0BJZ2Tkcha7
 hOaJoNVKhGFhk8AOHuq9yLZ07aaMrYew8YksiII34bCxVaxiWcD3HpxxbKDPqxyDn9Vu
 6Wi0OnYyZ/Czs6WYUmzMbjLUQybYPrX1wePR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775049702; x=1775654502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DhiElDP7RPMCNegLNssU6HegcytRH+OBREuD/nKoqr4=;
 b=pOzrITYeTct1rOJ1CxXVSgQ2p8/FYHartdrDXAUBgu4UgrB4L1HNv8IaD6iy/lr4XF
 2Tw7tuTgAHFwWV4XgKuP74YARVpzL7xOtgkEaYHgogLBXhmYSu3hWa9NOeQpbJRLwQpV
 4c2cU7fjHAf8pN6b79q1TjPER8DbrwQw+k1jNTsu4A+ZdQdCz7VOkbGIGMurahximiYJ
 JSzeQ//nNCeL8t9LgSIHho1l3ufPeiYDrdk9KZ5xcXMwsnaynXZXTJCBpFOtnDZ41mf0
 LKI1G3d8URDS+UDL6UyB0F+CS1PMRbXQ50yW/Tx/qBDdVf7jkVv85bIrJcxFKg2TB3fw
 KgLQ==
X-Gm-Message-State: AOJu0Yx/NyBwWhCcwh3AsNz2s07I405NC+vZgvMjvxdw1xKMwNh8s7PY
 iJLWNFIGGCwGWN3MN62+DhlQhI37PnFkptW/FK/Q7VnMyNOT7gf9WDtWhcN8g4gt6nmhk6paCUn
 qiqS2noeTDNQ/KfZBoB+iu/Q2UNdVAvcZtTd/AGlNbQ==
X-Gm-Gg: ATEYQzzsfOGN98D9UGWy8rbq9esq56LkjbHZ1MqEeIW+y2PCR/rs5FZfjGJIOQuv8yd
 4sBuXHyqNeZixiYrSS2e3WSntdNQoGe65qN2Vioqk8T+lcda4UiPCXbR4AzUlvDUR5LHvrDcgyE
 J9+dKwkNQ3KT6Xq2RektKxft9OqK5bkWwc3aH9aYIzQ5vfOZ0MFgHHZQI3+RJcLACZXxYQPTh9o
 IKEJEqTXsjRUs/nT0a0MTJxj1m5SegoIKfx/TLkeW12Hf1b6as/rxEEbfZR1VVLEXaLSwixnwUX
 SihhzbDiLMxfJh309nUTDgXlQYycEGsIgpq0EioMH12yT53u
X-Received: by 2002:a19:7016:0:b0:5a2:c41f:5f9e with SMTP id
 2adb3069b0e04-5a2c41f60c8mr722276e87.15.1775049702069; Wed, 01 Apr 2026
 06:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-9-peterx@redhat.com>
In-Reply-To: <20260326210532.379027-9-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 1 Apr 2026 15:21:29 +0200
X-Gm-Features: AQROBzDfkGEmbJhxAWpXuJ2PY9E5U2Hf1VluxZQZvb4oSUfumzNd8OAtWO_aWY0
Message-ID: <CAJqdLrq4W=Bjehw91zArMp+prjaVcG5CupahpR_E16yiDu7_ow@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/11] vmstate: Implement load of ptr marker in
 vmstate core
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x134.google.com
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
> When at it, not check "size" anymore for existing NULL markers, and move =
it
> under the same VMS_ARRAY_OF_POINTER section because that's the only place
> that NULL marker can happen (which guarantess size=3D=3Dhost ptr size, wh=
ich is
> non-zero).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  migration/vmstate-types.c | 12 ++++------
>  migration/vmstate.c       | 46 ++++++++++++++++++++++++---------------
>  2 files changed, 32 insertions(+), 26 deletions(-)
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
> index b333aa1744..47812eb882 100644
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
> +                    if (!curr_elem) {
> +                        /* Read the marker instead of VMSD itself */
> +                        if (!vmstate_ptr_marker_load(f, &load_field, err=
p)) {
> +                            trace_vmstate_load_field_error(field->name,
> +                                                           -EINVAL);
> +                            return false;
> +                        }
> +                    }
>                  }
>
> -                if (!curr_elem && size) {
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
> -                }
> -
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

