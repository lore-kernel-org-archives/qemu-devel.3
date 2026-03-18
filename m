Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BB210854DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nLH-0000eg-Vl; Wed, 18 Mar 2026 05:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nL9-0000bW-UX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:37:26 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nL4-00010u-6j
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:37:21 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a12cd0bd79so8343315e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826636; cv=none;
 d=google.com; s=arc-20240605;
 b=aJAOIomnPqnpIJqldhunx55rhOHeeQQy3ByhdDz0LfrQsXyL0aKslULHj8bL8uwg7l
 sKiJd4WQ0Y6S0GXbyZOoLl3WywXmY80lxvV1qQQDPNCR69yV7T+e4HyA2RM4T/VGAdkb
 CoUpFaqyD9LvlW/pG85x45B255/PtZvaIHJBqiWVSQ4b5RwdDRfs/MohrsuYpfYa5T2d
 h3kbuh6vFe9mXcNUg4/GOSquc9mozW7QLhsGB6EtXkhsGZAIw9dV0Jv1y7mIV/93/rxQ
 ZHNguyfWzkatvgThDvcw7h6W0rkMyxptgEJ2TUBji93tuS/n1r524zmDpqRwgyykkOzb
 G//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3dtfoCsnTCrOOydrDjDAckpDLIC/q8eHsziMmKv1vY8=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=PD8ITIbQc6WghMRINoxkdEoDp3FQ3Oj4YdHITFQWnx6/u8NhfJcFPvsEIk1J5d/qgS
 xBrm2aCUsy7lSODbrlNtqc9ZcAkFdsVLB+vbRhXm6mZN1ztBcrmAGKmbWeOUVJ92+CxC
 n5RqvYaLa7/UFY86WzK8xaR/IehCH+vhOipZYzcnEtZs4KojzTBuqfAfpotDf/dgUHbb
 4vnwaKHFgXz5uU2wmdLIvggVX0WiA+J7b0d9w9EK3hccKuumB6eF0uSkLM5FQnJA26a2
 JfDhThzAURsLplDYqr6KEt8VoCe3wen2z4CJZYd2naZFA8Ksq9999YRJZbjiBr50yQM/
 YcQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773826636; x=1774431436; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dtfoCsnTCrOOydrDjDAckpDLIC/q8eHsziMmKv1vY8=;
 b=EE+wDKbvEU0yZFFbFwV2sZZAOcCGfRkQw3QiIbxYVerMa8SpFZw4ChljeizccYZ9+A
 BUs/UGLi+M2WT0L19EB6oJAjI/snl0wjTP6GwPTKJagpz1WAcEg+k/rDZY9gqNjkJLB4
 rd0Hxu7Ju/AHKB00bPxEyKtzXuFTDGNssaBwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826636; x=1774431436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3dtfoCsnTCrOOydrDjDAckpDLIC/q8eHsziMmKv1vY8=;
 b=EGhDqIo9EG1fF4EBCLF1ABBwAjpgU1tY5qx3zE3oyXnh35JZnDuxsVBEFTsEb1yNHy
 WKCKIL2LaKfKn1iyxK59XsG8+/RZgpSkYqmBxuydcudjBu2In42ar8e8UQ6qNNbOwU8Q
 jTTWOyC4/alkwI5aqj+l91clk5izkI2r0wZQPWTdzCicsuccYTgxbPmKKWdywDrNTsSp
 bsH7jED1yIsF8yVynTUIZNOt2xDpHkWt25KE3f3omfFiM2s2VzzqEczwOwvlEpdfJNYt
 GVd28OPMmZMQrD5Dc580OfWvPPvJ4yURLTwqGC4XyElDryzms9WMTlhiIMJe/Hc7Neqa
 vXjA==
X-Gm-Message-State: AOJu0Yw2iAuqYSAzQPIJrzWPplDQLNmYFbnf3trVB0zbTqdnlzgnn0ti
 /CTYEN58+vcHRsDou4euaMvXDt3MfrMd0Gnj87nku0GLwoLgQ8N5jB+4SiMWj/UbewIAxTNdC+o
 9W2WLWUbwE2Qv9Ycr1aQrBG6vrfdA2tHIEC0xfPqBgTmmDSiFk05vWjrsVw==
X-Gm-Gg: ATEYQzzdPcMolMk8OVxV88Qv+M1k6X1PzYHeCDwQU/Tl37bDXp8WbISineFpuF2oASr
 SeRzgnHFRG064N039pOsWiH5yF6gEoVP6tUWdnfh9FD2I3Lp8zjgI3IoCAPZQoWUTC4A8vtns6g
 Cu+76YtFhjxq7QmZ0bbPvSA2XHQTg8dSA5YqGnvohsxBdQddZ90Adge29V4kvP5HS0tcVfHCrdM
 D3UHfn0RYzgQ9WlC4gg1qA85hN12Z6wd8xu1/oJ4MEksiDzeEZcT9vkNog92qTS/oQOfH6bl5+t
 DahDqM5QLC60A9n7vnKdAW0IaR30tSwJq2fadUY=
X-Received: by 2002:a05:6512:60e:10b0:5a1:7e29:c10b with SMTP id
 2adb3069b0e04-5a27958ba96mr865728e87.18.1773826635995; Wed, 18 Mar 2026
 02:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-3-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-3-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:37:04 +0100
X-Gm-Features: AaiRm51DQY8sK6J-QFjtlUGixxEYpssWlceMvc1hyCfOqS_6nWlxgwCAn6IYXTc
Message-ID: <CAJqdLrp2SOySQVT7rAdtGfgWNt7y9vq8Ay_LOKsdTnRgSL4Z6A@mail.gmail.com>
Subject: Re: [PATCH RFC 02/10] vmstate: Pass in struct itself for
 VMSTATE_VARRAY_OF_POINTER_UINT32
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12b.google.com
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
> Passing in a pointer almost never helps.  Convert it to pass in struct fo=
r
> further refactoring on VMS_ARRAY_OF_POINTER.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  include/hw/intc/riscv_aclint.h | 6 +++---
>  include/migration/vmstate.h    | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclin=
t.h
> index 5310615cbf..0e0b98acb0 100644
> --- a/include/hw/intc/riscv_aclint.h
> +++ b/include/hw/intc/riscv_aclint.h
> @@ -80,8 +80,8 @@ enum {
>      RISCV_ACLINT_SWI_SIZE              =3D 0x4000
>  };
>
> -#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
> -VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
> -                                                        QEMUTimer *)
> +#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                          =
\
> +    VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer=
, \
> +                                     QEMUTimer)
>
>  #endif
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 8992fba57d..68fd954411 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -567,9 +567,9 @@ extern const VMStateInfo vmstate_info_qlist;
>      .version_id =3D (_version),                                         =
    \
>      .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t), =
    \
>      .info       =3D &(_info),                                           =
    \
> -    .size       =3D sizeof(_type),                                      =
    \
> +    .size       =3D sizeof(_type *),                                    =
      \
>      .flags      =3D VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINT=
ER, \
> -    .offset     =3D vmstate_offset_pointer(_state, _field, _type),      =
    \
> +    .offset     =3D vmstate_offset_pointer(_state, _field, _type *),    =
      \
>  }
>
>  #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version,=
 _vmsd, _type) { \
> --
> 2.50.1
>

