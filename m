Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE3CC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XJX-0002mW-DY; Mon, 07 Sep 2026 07:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XJV-0002m1-DX
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XJT-00066R-A9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkkDm/ffbL/Z02ivGrW2CgTB5BA3h8U74fBysqH5/rI=;
 b=KYhw+MGKMojR+ZWkzTFal5H0f/RDoW/hWgWJ0WPNZcva3DQ7gP5MSJxeQJjzKIGX80mPz0
 P++JdKvYaRg65depND6lTdxjMmyyk7Zogf+KWE3GGJEXoyoWt+nRzmxqj/shXqSsGVqU9W
 RgRBbliKbSOKHOTrCTtaLj554B2fz3E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Iaq6tiIgOCKwGhQRtLS2Cg-1; Mon, 07 Sep 2026 07:14:56 -0400
X-MC-Unique: Iaq6tiIgOCKwGhQRtLS2Cg-1
X-Mimecast-MFC-AGG-ID: Iaq6tiIgOCKwGhQRtLS2Cg_1788779696
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e7f98bcb9so33367896d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779696; cv=none;
 d=google.com; s=arc-20260327;
 b=dwQI6sSntWgJbpQ+so+fjRE4cnvMPx6saYUz04Li51gWWCzWQ13OSFam3pZlAIWdbv
 71sYJh1uR3mPyxMSp6RipywBoRF53XwxNa8zlHxwTek1t3sdsak9Mie6j3WHZFuEC99M
 tK7vVsG0XyeCTbAk19fLJSClYp6xgj0bD4sTXfeNqSJEUJAIp180yo/TeStUMUvdibB2
 nZYQI89YS4O66G5Vtw91fDSfSt24TDBO/1rV8nK2RUrq29oCAxVJZd3CHhhS3I7ciRhL
 mGkwB8IcucdLlM99PqZcpaq0+XWGau8W+bMzpj8hO/1BTGrMOGcpcSLdTTUfT1YAh8Pb
 KYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fkkDm/ffbL/Z02ivGrW2CgTB5BA3h8U74fBysqH5/rI=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=Q5QsOeWRRNn+aat9l7ba5CksmITdxR3Ctrpmb19xeu9vv1E6Ii9o0Z+v047dMTmPxm
 MqX6kyJ0hFMSAaNxXx5p5BGOgG02IIEihJ8RucfOfevfY61KmdNXfyjMW/36aF4PY53Z
 WizXBNq2T+KDrGqNEz1xg7+sloLt78orWS1K+furqP4iLTqo/Jv6rbkLgnXDr7+qivTL
 VozTu9BNUhnpzXI4G79Mmb/PIqsxELgWVq8UtsqvWCF0Y/1CXwEq3bbrhH2kIMXzixL6
 LSiMd/iieFRyaLE+dTY2Odsrib48n3UJ0Z808rtxvL+slZsV4rcUV6pKqsyErvvb2I+H
 kGEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788779696; x=1789384496; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fkkDm/ffbL/Z02ivGrW2CgTB5BA3h8U74fBysqH5/rI=;
 b=PMZFslPxL16FhoZ36XqhfxXQXYueg+0r62zDP0+lRaYqENzc9LLOKILgPTT4y8zbon
 5bZWLskoFQlSeqTCQFO43LY84YFIJFBN7RlQ2TUoS0EmQpa2DcZhVgB+89UM9TjWeEL6
 rsBVYkVpTkqnwzVHwvj1NaqwFEhTxLf7LXybmxGgvXnM2tWgk/7Y1L3ClPx+YFDcoYtp
 cCxhDAdrkfDi2mdSW2RHEImZ3lfnmzb7mw4RwAd2/EFK4hiHqEA8ilWoOB9iyTwiT1YO
 zFrCzZWzXgUjGHHSyGzzaF35ISZChj411nq9azlYURTSXEkdqoC4gNTdcT4rr/WrAUrh
 vV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779696; x=1789384496;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fkkDm/ffbL/Z02ivGrW2CgTB5BA3h8U74fBysqH5/rI=;
 b=BtmdapzoKFfFK/VQt6hsVha99JjaIUf1XdMqf9P6ag6V/55xgHSt2whrgIvff8Jd9y
 kVjNKNLPzs6mD8apBs8RFOqtUsHFr09rU7x8pJWIVJ8ONwCUU3fFrKErYE4BNAVCmwVL
 lklzneXZpfB1N3Xj12PMol1FlGBkCFeubu0Hei2L9YONmDhRPMqJOAUAOtx/TDzOJf8C
 YOtAR6pFyBbahVhbiDq1w3wIToDpIf2EcnyxxVG/SLgi08vO75I/gtoW+rS+pC928wLA
 tnfsAxyadw8FIjgTxeTwLOUg0NEbY+bojNTWf8+7HrbLkPLmeoXkb87ygqWpcVqVT1R3
 77sg==
X-Gm-Message-State: AFuF++lq31Wu1AliV3zJSGjEqrr1iaAOgFNZFJYzXgtHZIVhZcjYbnhr
 zsuIRXTqnSFUf0/hWsj4FC8gk9C8Ow10VT2qMDb96l3sb27zT8KSPWT3a/aL0p82B4TtIjNYS+O
 qMlVMs0FMh9Ls6s6rGfbkOA9qdFJGXb/K/Qia7iSIqFTJp4pppUnOJXbLIekLRANeqLaRVO1CIl
 KJFViVagVAEY2wPnYQ0MF9Z0BJSwKkvOk=
X-Gm-Gg: AYBFou13Jzn3ehXloQSb/pNm9Cq1WrKLr6alSw29Kq5FrMWgoSiRZfkmJ8hbccmfmHf
 Y6D2ytr6x9Jp2z97s/X0HMqkLC1FrljSLL8MjEnlng2lWGNCUmAZt5vsuhQnkvuFXPNvURvoqGP
 DQRwFLzD7Gut/NqBJK9TYmHv6yKvApsNJ5gDBasq3nwFSaP0eKoBttJNEeWLY=
X-Received: by 2002:ad4:5c6b:0:b0:90e:93b2:3205 with SMTP id
 6a1803df08f44-9103eff88d1mr255789386d6.22.1788779696365; 
 Mon, 07 Sep 2026 04:14:56 -0700 (PDT)
X-Received: by 2002:ad4:5c6b:0:b0:90e:93b2:3205 with SMTP id
 6a1803df08f44-9103eff88d1mr255788946d6.22.1788779695955; Mon, 07 Sep 2026
 04:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-6-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-6-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:14:44 +0300
X-Gm-Features: AcwNN1UPN2RpG8-VeWXj975IyHkc_OnRaWBx2KFtah1dMjoyqI3xkRirintcJsU
Message-ID: <CAPMcbCrK3Gm5-WtGTk-77UaeZAgrJr+-17xEFcz_Da2ryZcKUQ@mail.gmail.com>
Subject: Re: [PATCH 06/17] qga/vss-win32: pass character count instead of byte
 count to volume APIs
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000005bf601065ae2ba7f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005bf601065ae2ba7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> FindFirstVolumeW, FindNextVolumeW and GetVolumePathNamesForVolumeNameW
> expect a buffer length in characters, not bytes.
>
> Use ARRAYSIZE() to pass the correct character count.
>
> Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as
> DLL")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index b9269acb5b8e..1fd73312bab2 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -432,7 +432,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>      }
>
>      if (!mountpoints) {
> -        volume =3D FindFirstVolumeW(short_volume_name,
> sizeof(short_volume_name));
> +        volume =3D FindFirstVolumeW(short_volume_name,
> ARRAYSIZE(short_volume_name));
>          if (volume =3D=3D INVALID_HANDLE_VALUE) {
>              err_set(errset, hr, "failed to find first volume");
>              goto out;
> @@ -447,7 +447,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>                      WCHAR volume_path_name[MAX_PATH];
>                      if (GetVolumePathNamesForVolumeNameW(
>                              short_volume_name, volume_path_name,
> -                            sizeof(volume_path_name), NULL) &&
> +                            ARRAYSIZE(volume_path_name), NULL) &&
>                              *volume_path_name) {
>                          display_name =3D volume_path_name;
>                      }
> @@ -459,7 +459,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>                  num_fixed_drives++;
>              }
>              if (!FindNextVolumeW(volume, short_volume_name,
> -                                 sizeof(short_volume_name))) {
> +                                 ARRAYSIZE(short_volume_name))) {
>                  FindVolumeClose(volume);
>                  break;
>              }
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--0000000000005bf601065ae2ba7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, S=
ep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">FindFirstVolumeW, F=
indNextVolumeW and GetVolumePathNamesForVolumeNameW<br>
expect a buffer length in characters, not bytes.<br>
<br>
Use ARRAYSIZE() to pass the correct character count.<br>
<br>
Fixes: b39297aedfab (&quot;qemu-ga: Add Windows VSS provider and requester =
as DLL&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index b9269acb5b8e..1fd73312bab2 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -432,7 +432,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!mountpoints) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 volume =3D FindFirstVolumeW(short_volume_name,=
 sizeof(short_volume_name));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 volume =3D FindFirstVolumeW(short_volume_name,=
 ARRAYSIZE(short_volume_name));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (volume =3D=3D INVALID_HANDLE_VALUE) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err_set(errset, hr, &quot;f=
ailed to find first volume&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
@@ -447,7 +447,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0WCHAR volume_path_name[MAX_PATH];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (GetVolumePathNamesForVolumeNameW(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0short_volume_name, volume_path_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(volume_path_name), NULL) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ARRAYSIZE(volume_path_name), NULL) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*volume_path_name) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0display_name =3D volume_path_name;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
@@ -459,7 +459,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_fixed_dri=
ves++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!FindNextVolumeW(volume=
, short_volume_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(short_volume_name))) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ARRAYSIZE(short_volume_name)))=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FindVolumeClo=
se(volume);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--0000000000005bf601065ae2ba7f--


