Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329A0C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QvU-0008Tm-2B; Tue, 15 Sep 2026 07:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6Qv1-0008G2-0p
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6Quz-00050m-BB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNzfF/ZctILWWDFid3XzsgnvLwwiTm1bkI1E7Id/Vyw=;
 b=CoTuP6thr5T0Ifk5Tak8/yyyOEZZhZAonTcAq1xwHNoDsZBViKJf01aqfwxnL251IPkeb6
 +DwRodooSMP1jFpTO8vJLCWaEh23NF8NYivZqPaVLUG6ucFikCAIJ5IdpCeWkaO3XZ3JhA
 2a42zv3QxNtWOA8T9Lbd+8/s4QkmEt4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-eGIn_ncJMQeb0rWdJh4yVw-1; Tue, 15 Sep 2026 07:01:38 -0400
X-MC-Unique: eGIn_ncJMQeb0rWdJh4yVw-1
X-Mimecast-MFC-AGG-ID: eGIn_ncJMQeb0rWdJh4yVw_1789470098
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c82cf2652dso1520468e0c.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470098; cv=none;
 d=google.com; s=arc-20260327;
 b=k4plUBk4YlYpZboabWgRKb9pBInycHAKyJ/ggYe6g7L1VLVbwsMaDymnW2NxUt4vv6
 upUTtqcpTVdUjqVdIKOkk0Npvhyu/5uyUhZuLwJmXr7Cn5q1A0/fwzan1aoFf8AzRKEG
 YdpE+XpQSqHVg6jIShsbhh1Qr4Kp0Xhtie41qrO0k9Twjz8h4l81HxAQQKa0ODyWlwie
 wP0SG0bTU2wD2QtJ3MGt1ibuMFDtNTHwpiNAJCu0S+pZ4HjLRPdJ8wITPnYQddwWidHk
 Vi90ZZzZWR20hPf7FNSOXKuVEJk/IVQQvwBE5cSrACymqqmTIk47onsB+o+9aTHwXXM6
 telw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pNzfF/ZctILWWDFid3XzsgnvLwwiTm1bkI1E7Id/Vyw=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=sKxtp45JCGBZ/Q2EQBDTHjfn4MXN0Nf6bDD9jokyramKROYcPyD6f90vJBmzK7E6aC
 qiyZRV2iqq2HITVRvUGkjDHGK2ui/fyngy5XC4XctwMS811KM34tkyUJ/rJM/5MbSuCh
 jt89aG2DE9gdv3OoGcCA1No8M9dBoZ9MJNgCRV8s6LW/97ruVBq9bnGMKYK7zKfoyW/v
 BmQvx5BVTbsXlbLHVLM+LKd9Jq1A6hLMhRnKJfFPJrhL9GnaOo5c1Y/ge32cI489GQfd
 fiwkghP8bVsFmHydprYiHtNkuUOLc4SL1ZEHA3gnFCfIKbSqR8uP1av13EaEg2gOuoUl
 tXKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470098; x=1790074898; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pNzfF/ZctILWWDFid3XzsgnvLwwiTm1bkI1E7Id/Vyw=;
 b=ZFDr9A4z9FxZdrx/ZKd/AG6yJpd4ITriZRuO1ODFjP0mj88v9WaYXgsC/7wFHlHW7S
 QlQmrgNiUZ5VCG64aNtTh1Fy9s1D3ekhe6GewQmJLS6s6QNfl52qVIJ4eHkLsuo7gZ0s
 GclcqqAi258NP0qCKydpjqbXBEIIZqcDfoqvNiCiGC4Z4mHo8Rqgc1GKCBdIAmSMlXoO
 vabl82SIDqmhORsUgDdZsRoqsl0LLFn7umi2tdi/j0z33ncaLhzoSxrMfHO83UposRZs
 tVO3HJ8EZ54s1bNxWXv8Vy2eMhCqV5mjYA6deBF/h55cR807D6lhMPXs/SibWnLxXafJ
 tP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470098; x=1790074898;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pNzfF/ZctILWWDFid3XzsgnvLwwiTm1bkI1E7Id/Vyw=;
 b=akZ/ng4q5SqjrMthAj5qDm8BNI28NS5TT5tKtzhbqXAF2dbawlkJ21BDYStGw7J6Ma
 IKTIPtCi5mJ/W6TMEgzIj1/P6OpDPOsh0bT6BqqQ1MRtz1NCQH8LivbLz+EYeM39YED0
 wwXrwgqO4XazjXuUSckmi9dP6/yRKgKJeDhFiyst4BeJXYKDdtMxUQTDHagVUbEmF59Z
 6EW4oepsNeNU8DQSqu+KWlXdqpodwqKikBLlKHcc6l/RIsAKXNZ8c5QRmD0oNzTjYbwZ
 +uqq4FuV0qL2BA5l1UoCeY13uZ2lUv/Fzou9ylDmH0xDGHiBTiTx92h/mFqasRHc7w5U
 qqlg==
X-Gm-Message-State: AFuF++kGJPx9MGiyEzPDBmz1BhGQUyn2l0SZK4xJqi7zUpBh5GwMFEu+
 g6GmtfTMFAJE4ylnfwYy3zhUDEo/1S/yAibDWCDsEDjsdb+BQFYrsJX2NCp5zmSjHK4YVIulC+s
 aRn9XjUu7CZUoHdFukmuzqTa3ptMEQID504AF82qhRhW682RdRvh/IuzhkzoHcn3cIvbCDPqx+x
 djVnepQ6lk6IkTQOXc3R5XbmljnHaW+VE=
X-Gm-Gg: AYBFou2IeIVlMJcVoaEt1bkACn3NMBbBhCmEecPHuMXtmzqFuxjRmfzZ/P+UwZL90bm
 BacSSjpKwBuTL9RfD0gNTu42TOpXjYiZvuSNoo2TFoavftcQgq+Ln7xytTb+D2fUxO9yCnuM6SM
 3X+k1FIGySKtXtWkBp00YidoJn7KuyWkIGP7X27gTHINTNGdU8CI4/bblOMFU=
X-Received: by 2002:a05:6122:d8d:b0:5c8:3870:ff73 with SMTP id
 71dfb90a1353d-5c993a9ac94mr259848e0c.4.1789470093478; 
 Tue, 15 Sep 2026 04:01:33 -0700 (PDT)
X-Received: by 2002:a05:6122:d8d:b0:5c8:3870:ff73 with SMTP id
 71dfb90a1353d-5c993a9ac94mr259083e0c.4.1789470091733; Tue, 15 Sep 2026
 04:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-15-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-15-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:01:19 +0300
X-Gm-Features: AcwNN1UHJ2BZ9GLS6drjlvl8oP513rC8gDck5cs2WiQepSKavcENjwEarpAJo9M
Message-ID: <CAPMcbCqwtOgLxKE9nQitxRUoeubshC53j4dG7ATTNUy+rV8BFg@mail.gmail.com>
Subject: Re: [PATCH 15/17] qga/vss-win32: initialize *num_vols at start of
 requester_freeze
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000279ee0065b8379b1"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000279ee0065b8379b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Initialize *num_vols to 0 at the top of requester_freeze() so all error
> paths and zero-volume early exits return a defined value to the caller.
> Previously, only the already-frozen path and the success path set
> *num_vols; every goto-out error path left it indeterminate.
>
> The sole caller is qga_vss_freeze(), which already sets *nr_volume =3D 0.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index f14c47f9f7a9..d36a90c17d1d 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -306,8 +306,9 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>      int num_mount_points =3D 0;
>      VSS_BACKUP_TYPE vss_bt =3D get_vss_backup_type();
>
> +    *num_vols =3D 0;
> +
>      if (vss_ctx.pVssbc) { /* already frozen */
> -        *num_vols =3D 0;
>          qga_debug("finished, already frozen");
>          return;
>      }
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000279ee0065b8379b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I=
nitialize *num_vols to 0 at the top of requester_freeze() so all error<br>
paths and zero-volume early exits return a defined value to the caller.<br>
Previously, only the already-frozen path and the success path set<br>
*num_vols; every goto-out error path left it indeterminate.<br>
<br>
The sole caller is qga_vss_freeze(), which already sets *nr_volume =3D 0.<b=
r>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index f14c47f9f7a9..d36a90c17d1d 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -306,8 +306,9 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0int num_mount_points =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0VSS_BACKUP_TYPE vss_bt =3D get_vss_backup_type();<br>
<br>
+=C2=A0 =C2=A0 *num_vols =3D 0;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (vss_ctx.pVssbc) { /* already frozen */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *num_vols =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qga_debug(&quot;finished, already frozen&=
quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000279ee0065b8379b1--


