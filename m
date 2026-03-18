Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E56E10854DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nMc-0001c8-LG; Wed, 18 Mar 2026 05:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nMa-0001bJ-3d
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:38:52 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nMY-00016o-Cp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:38:51 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5a10d130b37so640160e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826728; cv=none;
 d=google.com; s=arc-20240605;
 b=TdkYsOxmAzzBVSjEPGCO00GQRFaPPRoj5xiBDa1In0P+SL7RcOJxKfzHOyaBRP0RKv
 GLPQpOFg7V3ebZAH7HrFcXvnckJzM8ok6Uaqv7RcHlUQNpAwlSrWnoKv1g+hYtA3Etqd
 /mu4cOhvI1zdtYt2czhYE9klkXc2wRVVw+NIQvUEvU9Bq6jMY+gssCXixKQaEdaNxILH
 8gWdOckN+ga/+oIr6QOZsmszYSe1kjVZKXqhDmY6ixqV0sWm7rHHeMVo2MFfqypuYytI
 Nt46tzHoj/uYETDONN954SA3XGj5kP4NiElihAuvn5fUySPKtRoS/Su9wR46BPeNNEp4
 N94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ab+zInuA3FKM75/IaDM2kJCeHT8M4LO0wFVFvng94UM=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=Y4nwalEjSEW20Ll+wv4PFPcxvgWAQZLO1LY/z6Z7nSiEMaf2s8DbpIzSmcVdulhzQc
 V6JruslaexxZ9XvhdFKcMw6hmYnl+gkwMGvIZLxxDJPrVXfZQreY6iDMz/9dDGATSOKx
 v3omvkH1n/aRWdV8rARVvcRi/TotLN6N3Rz29zqezo4qZ36qReve4bTJ3tQOydMYGGXv
 z46pQ49mRTPjFtjqWXGwF6SucAHzoPzHfooXOYSex8mQeV9kLvkfVHbUizjP4hEJ8LSn
 aX2sLn7PbOIE2p5bGHh1bNENGTjhLhnOZ0BpqeWiRAJk6gjcRVIFQAZifM0D19E8VQuS
 1ZcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773826728; x=1774431528; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab+zInuA3FKM75/IaDM2kJCeHT8M4LO0wFVFvng94UM=;
 b=doPUCo+TqoMODouAj+OZbkvoY625cMhoqsrNxMNcAcmakUurC5fwtHaBNRvikI4UWW
 IR8n0GRkn5UmHYv/mWCgxfyi+hikLnBJOu6qEsl2ABNeDGbds+H44h/xBprdRfS4vbW0
 4hKVx6VIEb5hKTlgEs+54XstZYJxTqHZaGjXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826728; x=1774431528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ab+zInuA3FKM75/IaDM2kJCeHT8M4LO0wFVFvng94UM=;
 b=YMJQm5rf5VqHg9NnXVRii5KdiNITB5tHeN+5Wlf3C3evVIHmoKAS7OkrNqGVx50lRQ
 wH60jVIEv/xTb9sp4aZz28hCXwPFAThxtz0JFdsts/aeV+eKUEYg3FbEmTbnB/JNf5k5
 fAF+VIszJMFpOmdc+HFq/9Uh33mx8HuEQM4YR9V9P5NzvPZdjNh+ZzCQNeMbsjuLK10G
 uNqXKGn1knniNaZLtz00XYbrIQoUO8obKhZwElSaK2qXwtKbtbYcZfK5r1gzuo3TKZc8
 5zUO70ggfqEkKJvTCHWDmEtKhzs23/y5DgU+oFc0x8zdmh3zm4emDjVQp+hRIGgVOh71
 jvOA==
X-Gm-Message-State: AOJu0YzU38fYgpbLWmMwhBpIe5vyCmWpfx8UF1il7XuVhmkNwJfJjwgT
 a8sYVZ5aofdnuOVD0WY6gLSFfgDAf+RMAlzJEJXiE0tkNHnJEsIpesDiFpbVggR64jYFNmmKDcF
 fWLZY7iUHmNmLqoRf70vPlC213VWag/oWJm1TyKRmhg==
X-Gm-Gg: ATEYQzywsWlUsuyTHCKIwBf8AX6FoqlTl/mw/YBOnsqaIdvlAfgcxr1HkvFf9/bgIXH
 giMy+AiJWbSIlixVnmoTlYBfcRgSHsXZK8vm4/7VApnfXory2Df3jyymPqo1PAYQPM0XWtzMTZ9
 NkMEbJQ3e0kVPWK5TTrJ6UR6kPQXtz38t6w3TmhWx6gWM7Fgvfd+KuntEFkHFs9EBfopok+E6H/
 TA/zz8YLt5zSY7sW1HM4QtK82Dl7EoXu+Ca0lTBvHPgCyZoD9xOR4qTpKbmunya/rORRk0JVFDF
 oS8j2J9JvJEyn1v2vgluFE5NXZYoE/Hl0OiomY4=
X-Received: by 2002:ac2:4644:0:b0:5a1:1de2:cdca with SMTP id
 2adb3069b0e04-5a2793f9a64mr812443e87.13.1773826728033; Wed, 18 Mar 2026
 02:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-6-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-6-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:38:36 +0100
X-Gm-Features: AaiRm51DRAPb7O4FzlmowrL84hu-WDuUKapz2k-voJf1Jyeuku126ZUz7Lw-vJY
Message-ID: <CAJqdLrpaCFmOdo6L4sRtRF8Lab_Z1Kxr0cDJh4hjHrfCHDZWQg@mail.gmail.com>
Subject: Re: [PATCH RFC 05/10] vmstate: Rename VMS_NULLPTR_MARKER to
 VMS_MARKER_PTR_NULL
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x135.google.com
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
> Prepare for a new MARKER for non-NULL pointer.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  include/migration/vmstate.h | 2 +-
>  migration/vmstate-types.c   | 4 ++--
>  tests/unit/test-vmstate.c   | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index b4bc69486d..092e8f7e9a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -283,7 +283,7 @@ extern const VMStateInfo vmstate_info_uint64;
>  extern const VMStateInfo vmstate_info_fd;
>
>  /** Put this in the stream when migrating a null pointer.*/
> -#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
> +#define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
>  extern const VMStateInfo vmstate_info_nullptr;
>
>  extern const VMStateInfo vmstate_info_cpudouble;
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 23f3433696..7622cf8f01 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -363,7 +363,7 @@ static bool load_nullptr(QEMUFile *f, void *pv, size_=
t size,
>                           const VMStateField *field, Error **errp)
>
>  {
> -    if (qemu_get_byte(f) =3D=3D VMS_NULLPTR_MARKER) {
> +    if (qemu_get_byte(f) =3D=3D VMS_MARKER_PTR_NULL) {
>          return true;
>      }
>
> @@ -377,7 +377,7 @@ static bool save_nullptr(QEMUFile *f, void *pv, size_=
t size,
>
>  {
>      if (pv =3D=3D NULL) {
> -        qemu_put_byte(f, VMS_NULLPTR_MARKER);
> +        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
>          return true;
>      }
>
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index 6a42cc1a4e..dae15786aa 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -620,7 +620,7 @@ static void test_arr_ptr_str_no0_load(void)
>
>  static uint8_t wire_arr_ptr_0[] =3D {
>      0x00, 0x00, 0x00, 0x00,
> -    VMS_NULLPTR_MARKER,
> +    VMS_MARKER_PTR_NULL,
>      0x00, 0x00, 0x00, 0x02,
>      0x00, 0x00, 0x00, 0x03,
>      QEMU_VM_EOF
> --
> 2.50.1
>

