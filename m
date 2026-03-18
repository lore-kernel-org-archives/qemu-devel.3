Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCF810854DB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nKf-0000S1-Qd; Wed, 18 Mar 2026 05:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nKd-0000RY-5U
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:36:51 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nKb-0000pj-4X
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:36:50 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5a1322af04fso717812e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826606; cv=none;
 d=google.com; s=arc-20240605;
 b=FVjMzKpDXA4v/YQz3gnqQBvTRPOp7cqwfz64hSR2AZM6Q6w43InRYOMRQ4XqrkLTyY
 YiwPEBOudlst3h5cNsEjdEwruuGMklAUq6NzhP8gvTVlYDZ5eRvZXsrbqmwAgwFuTc/a
 3yif2mSFrqIYnhp8zvU3TXCb250bfAIfsb9FIV9cM9/TTUg+ql1F09Bs0GJ8cK2d37II
 j+ki0zoFfp0saT/VaQ3ReqSTgKtOznfsogE8l613r3F6J6vWHSDeRLyfZMyGOq1Ft+ML
 +Z67kip6eld23CAVBY7882jQxEpy48wEUpHmd/ueVRcbsVUHVTQJtC/6xMcLNweS9pg5
 5bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8nJaq0kAXcR0qZ11syDrhEiS8OappPIeaFoAIf2jyT4=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=GOx5/SRrX1erTXdqPpbyOEDCecNRC/GywYz0UDKzaXKPoUqGY8ltpX1FX0pc1eq+do
 jN/KZdYeQgL4I06STMDonia6N5mYxR0ntGW6Qg4ffbjBW9FSoMmEtJKBvV1rEBno13dd
 Dsf6z5k9aLeFdPxQzIE45fSt/b6vWS5lBX2YxkG+rqTMkLOARNYjvwBVlJP5nX6R8x0E
 M+w9IDilYEqNfMmViu15S05WtEfOCJbWUpdgqvjyA0pi022D8jMNPiGA/0DHg+0ZiAM+
 qqxsg/9PqGbInVR/tiYRlrBWZjEInBkq5uvZoo/5N5i5rNOn4Mw2dsvEr+Ezxs4CjkXe
 uijA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773826606; x=1774431406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nJaq0kAXcR0qZ11syDrhEiS8OappPIeaFoAIf2jyT4=;
 b=h9GXj/Dbwss5ujxmg4FxRY/mcFCDwRWARLjf99Dsw49Z0GDnDIHx3bAkZNdbU5rDIm
 yldA+FO1DA/qZReS4VN/9HQ34HmbHO/uaYxTCBBYLwyRDYUjh1Ldw/u8BoACUVi/cq5c
 yPmj60EePKAIliFivRX38WzhPLY4U1PMKlshk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826606; x=1774431406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8nJaq0kAXcR0qZ11syDrhEiS8OappPIeaFoAIf2jyT4=;
 b=o0t/Ze6q2hBlfpqS8woO+y5XrqFd8I/hNxOQd2rIRlzsobz6/WpHtG7MvrJ/b4Htxk
 5zKUFfXpaoweHXpJJloc8j85ebJ+i4vNzKqI5PYLgTGbyr58iVJJpcsFWDbs3QIS0W42
 kdnk1+rtd7vIDpFpn17ypA+abe8Uzu4Y+OZs95tiV/gmjPgCvjgCwU2Yl2eeI1O1faU3
 COIjoteArtZotCXOiQzZqdDStZTwVb6NfseGV6D6nKWPuv2bapZPxjtr/w4c/2vi/zn4
 X25HEOAvtpIyruCZDywVAjgNzeaJy5yPT6GHxM96sYzh/q5MRMj7NOU6YNLXLaZ0eduA
 lAtQ==
X-Gm-Message-State: AOJu0YzHpumLgAXU7yYlrOe9AM1aCTULf3wEVJjSKCFI33YH+qY6vFu4
 7soe3VV7f3sJi0xteVvQ35D/BGBHHJsLP/ey9VQjYfhFspbxzr6XQ4XR0bajicU7byO1pJimyaf
 Gn7aRLd8eeXZyAPlUMOhgY+B8VW/6D6CrIVE+55jZxg==
X-Gm-Gg: ATEYQzxAFHs8E2XfXvJWLMjS5SdMg3ptNrlEmCt+wMrnvEX4kQQXDflUOvXMJty1d9U
 1/35FEoIZKlIrLLM0qkuerrgKUxYggnIdV3hcFyH5oe+vxQUU+2ihueIji+X+9D9G/qrB1DMmwh
 FsmI+reLu8VG5akoM900WvpRPjjPMMY79JDghsZ1+ekzRCJR20S5gvxYNmFZR2fvtgOSnUuN4iN
 icZJxmEsP+PBYsYUzorkBH/40A/hgcC+GfOyn0todYMW7lwIRqOPkF+UIa7vjr2CF6JFhyxCro8
 Wz2u6rvM6joE3kLv7jGRcjlEJlhDr2uOP2HpxLA=
X-Received: by 2002:a05:6512:1541:20b0:5a1:18bf:6b2 with SMTP id
 2adb3069b0e04-5a279588ba1mr720837e87.1.1773826605197; Wed, 18 Mar 2026
 02:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-2-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-2-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:36:33 +0100
X-Gm-Features: AaiRm50Jw-I6jtms175YaMmZQGr-BnQRXmJcRJn4Pmz9XijliA02U1wEzaZpNU4
Message-ID: <CAJqdLrqQeQr9VN86rSN5b+1bQmgXQkEN8eiD-eXLKue135j66g@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] vmstate: Pass in struct itself for
 VMSTATE_ARRAY_OF_POINTER
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
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
>  include/migration/vmstate.h | 6 +++---
>  tests/unit/test-vmstate.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index d4a39aa794..8992fba57d 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -547,9 +547,9 @@ extern const VMStateInfo vmstate_info_qlist;
>      .version_id =3D (_version),                                        \
>      .num        =3D (_num),                                            \
>      .info       =3D &(_info),                                          \
> -    .size       =3D sizeof(_type),                                     \
> +    .size       =3D sizeof(_type *),                                   \
>      .flags      =3D VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
> -    .offset     =3D vmstate_offset_array(_state, _field, _type, _num), \
> +    .offset     =3D vmstate_offset_array(_state, _field, _type*, _num), =
\
>  }
>
>  #define VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, _v, _vmsd, _type)=
 { \
> @@ -1093,7 +1093,7 @@ extern const VMStateInfo vmstate_info_qlist;
>      VMSTATE_TIMER_PTR_V(_f, _s, 0)
>
>  #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                             =
 \
> -    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTime=
r *)
> +    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTime=
r)
>
>  #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
>      VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index cadbab3c5e..6a42cc1a4e 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -668,7 +668,7 @@ const VMStateDescription vmsd_arpp =3D {
>      .minimum_version_id =3D 1,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
> -                AR_SIZE, 0, vmstate_info_int32, int32_t*),
> +                AR_SIZE, 0, vmstate_info_int32, int32_t),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> --
> 2.50.1
>

