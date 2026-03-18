Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCE710854DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nNk-00021H-7p; Wed, 18 Mar 2026 05:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nNf-0001zy-BY
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:40:00 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nNd-0001P4-E2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:39:59 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59dea72099eso7985594e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826795; cv=none;
 d=google.com; s=arc-20240605;
 b=Hmx6q4+vXD5nmYNNAA91caz8PYzsSSHIkR43NJLEjnLe2n81nHwkPs28EIO3cvAZ2g
 JF++shqu9kTGthY4dBVtyAU1bvfgBELFOeeXy6VWEEjpT+PzwSAHOEglq6f1PCcOZxtD
 W8Fwo+/8wwPfPYHmdc+quxmpsysIOooX9p6zEWpdn7H5s72DZMcUvltUuWSWVRIirZGU
 6ClfUyZpN7aWqgZ7/bo0pNRDZI4i+o1rCkLEu2Vkp1HIqQuU4H1Z0RBkvyamc4eVDPNL
 mDj/8vTnsMo+fvzFZ8qg0iAU7HrZPadTpWE/3ag6XWvpH9Hel/zarcyjwoguycU9sa8d
 FnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nv1909sDr9sud64jK6Xj/SS71ZB9qGUpyPMYaZ4HA48=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=dgHMDL+LTVR9N1CK2mhaCY4FwPAVMBxOBuo/hvQQN0/4hQtmsZRvFpPL1aev7j61/E
 2vfB+Pb1o7tF17OD4HbvK9yR3Un3H6m03rWTKXmXScZzgeWqeleSpeq3uJcBPNHh3yk2
 pmJPNujrJwSqS8A0W6rgcoOH/GgSVq9IcR/hCCizFST/KjDBpHnfMYoQFuotHs+buRLo
 H9/iuVVwwa3mvzM7V997S9w5HaU7zuS8YwIyPwYrQnNuVJwCpikGd4VqFCLZvS9lBLvF
 7ZqRJBKslLEe1zGuFiPbv8ILy1b09MsmfnxnxDFHPO3FADJzcM03L6SOqAEZ2IpEANx8
 T+HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773826795; x=1774431595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nv1909sDr9sud64jK6Xj/SS71ZB9qGUpyPMYaZ4HA48=;
 b=OZCP6FwodwxJs0msqUGK9ge3TE1C0Uutagy5QBLGkc6xBxVp6guMZ+M8suuLPIogcZ
 BkxSghwzh3mn1usl3PSp2hLLVVApVIrzKKN0ibfsfWWxw00rJXMFpYqmsBwU6l7WbIDz
 hQ+T50o0Tx1gn7gNHIMGADfEJNX6B8DcYdjCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826795; x=1774431595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nv1909sDr9sud64jK6Xj/SS71ZB9qGUpyPMYaZ4HA48=;
 b=EFAxx/UDuz4gNbeyUrjTr9pgp6GylzucuspKWRam5q8zSHPxQbBMruAOAbSyM9yoUH
 bt2gdUgVFidtsXBY6KAD+MC8C7IJ/qkTgjjfJMvDStDvBabHxDqqqe6zZPB7q4I60Plu
 UA0xBPFkT8/ci6k0Ht0PJM4q3pvzYOp+X+vSqzur47glq48g5MlO8NK1hYDCkFzdMtnI
 EcBB6c8hKwybK+oXpT1PvCzIRoRVnis1apB/zUb7O3Psq5N8pHqf9/nxBQjIwWHe2Z5p
 lFPgu0+8f1oApjPD1ncRdPRaBB4MqIKmmllnDXpnxxsWWORWk/QBaEmWJuzKpjOTC84b
 BnFQ==
X-Gm-Message-State: AOJu0Yxb1AbGcH/AMYAz3vb+ZFlWtPwHsgQykhVxNLxIOTv/QN65y3Lr
 aLRY2xx/UZH1qFXXp9ZhBkmYyDU1oIRMAOLVjP1iPWJwVDNGZ2c6t9hbYZ9eJ9Pii8Ar2m3Kn+T
 SWXn+rrluWCwTZml//bt99hbaKpyoUgiCVCcBl65Hti3TdhIh0bCaqkG+Nw==
X-Gm-Gg: ATEYQzzxiE5xE7ytzass4tZ6QnAN4Sr+Krynbs0v4A7AszSBilQfFDF3fSHbxI24Yho
 7YyQ4NBH1xNN7+bMdkOxOhy1ofq3a8ExtQ09KpXTz9gxF4oNHZFDhqwEvIQ0hMhbyCXk4kBHXJj
 s+XLGit8k7L9MZlgeVFkDsfAUkxaj8G/pvWNlQ2Ndh6i3SBP1OxO+ICcsW9dfrUw+YTa+4WqAoX
 Cuq7bLgt3aPlAaAxIhuFMQ39O1TzKN2cOW5Yw+2ECW4wJ/0nybEe0fJH1GYx43Hd7xGJlossMnn
 2FiKVE8ss9EZuFTCOX+dUlfxnHlM0Uup2d01MIGqAOlTcbpdDw==
X-Received: by 2002:ac2:46fc:0:b0:5a0:ff97:4374 with SMTP id
 2adb3069b0e04-5a27957d8e8mr688642e87.7.1773826795042; Wed, 18 Mar 2026
 02:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-7-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-7-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:39:43 +0100
X-Gm-Features: AaiRm50wsN_M9lDAMIVeLWVtpOhobrzTGbIG8KuFp_bYi32UrDvUtovlpJrubw4
Message-ID: <CAJqdLrpA-Qw7p6qQqJe4Ae6fEP3DPcX1r4km7uYy=JHPn5mMKg@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] vmstate: Introduce
 vmstate_save_field_with_vmdesc()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
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

Am Mi., 18. M=C3=A4rz 2026 um 00:23 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> Introduce a helper to do both the JSON blob dump and vmstate dump.  This
> further shrinks the function a bit.  More importantly, we'll need to dump
> two fields in one loop very soon in the future with the JSON blob.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  migration/vmstate.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index caa7b50bce..5a6b352764 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -514,6 +514,30 @@ static bool vmstate_save_field(QEMUFile *f, void *pv=
, size_t size,
>      return true;
>  }
>
> +/*
> + * Dump a whole VMSD field, including its JSON blob separately when @vmd=
esc
> + * is specified.
> + */
> +static inline bool
> +vmstate_save_field_with_vmdesc(QEMUFile *f, void *pv, size_t size,
> +                               const VMStateDescription *vmsd,
> +                               const VMStateField *field, JSONWriter *vm=
desc,
> +                               int i, int max, Error **errp)
> +{
> +    uint64_t old_offset, written_bytes;
> +    bool ok;
> +
> +    vmsd_desc_field_start(vmsd, vmdesc, field, i, max);
> +
> +    old_offset =3D qemu_file_transferred(f);
> +    ok =3D vmstate_save_field(f, pv, size, field, vmdesc, errp);
> +    written_bytes =3D qemu_file_transferred(f) - old_offset;
> +
> +    vmsd_desc_field_end(vmsd, vmdesc, field, written_bytes);
> +
> +    return ok;
> +}
> +
>  static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *v=
msd,
>                                  void *opaque, JSONWriter *vmdesc,
>                                  int version_id, Error **errp)
> @@ -542,7 +566,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>              void *first_elem =3D opaque + field->offset;
>              int i, n_elems =3D vmstate_n_elems(opaque, field);
>              int size =3D vmstate_size(opaque, field);
> -            uint64_t old_offset, written_bytes;
>              JSONWriter *vmdesc_loop =3D vmdesc;
>              bool is_prev_null =3D false;
>
> @@ -558,7 +581,6 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                  bool is_null;
>                  int max_elems =3D n_elems - i;
>
> -                old_offset =3D qemu_file_transferred(f);
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      assert(curr_elem);
>                      curr_elem =3D *(void **)curr_elem;
> @@ -606,15 +628,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const V=
MStateDescription *vmsd,
>                      }
>                  }
>
> -                vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
> -                                      i, max_elems);
> -
> -                ok =3D vmstate_save_field(f, curr_elem, size, inner_fiel=
d,
> -                                        vmdesc_loop, errp);
> -
> -                written_bytes =3D qemu_file_transferred(f) - old_offset;
> -                vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
> -                                    written_bytes);
> +                ok =3D vmstate_save_field_with_vmdesc(f, curr_elem, size=
, vmsd,
> +                                                    inner_field, vmdesc_=
loop,
> +                                                    i, max_elems, errp);
>
>                  /* If we used a fake temp field.. free it now */
>                  if (is_null) {
> --
> 2.50.1
>

