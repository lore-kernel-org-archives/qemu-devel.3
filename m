Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A067C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6R2Z-0003UJ-J3; Tue, 15 Sep 2026 07:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6R2X-0003To-B9
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6R2V-0006mG-Ed
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ld46SULEUSy3a8craN8ZlaKrVLpIrpEhfO8hir6sJus=;
 b=A6FPZRdYGmYEyimk3yNdB1GGMzPTRCdktKox8coo/R0N9xbq2bryMDmZp4ZN8MIPYLX4op
 pH0ZuHCB30qiZ+z8IIdjamaKDOKpww9u8EMc3S0XkhNxwgmUbb8ofH/GsJiDxUulgSAmNS
 JO4P4pElz7QA1Aqj3HJ8qGOSvPl+vkc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-AFjCj7tQOQa_I02aK94IgQ-1; Tue, 15 Sep 2026 07:09:24 -0400
X-MC-Unique: AFjCj7tQOQa_I02aK94IgQ-1
X-Mimecast-MFC-AGG-ID: AFjCj7tQOQa_I02aK94IgQ_1789470563
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc18ced1a5aso8179040a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470563; cv=none;
 d=google.com; s=arc-20260327;
 b=o+bpfZGvoCcnWmtddUYFpwv3M/0ZJhn1SdgZkbKE8fPoRIa0EhBGADBTd9m/MbNtX2
 uIjQAxsfnFj0TyJbV99QnaV7Cx24rLfvH0aY0Yrlp2yTnJ/4EPgC4vk7vNlhEypUGTw5
 WZVi7Vn5m0mAHMtErj1nK2MZx1XyOp6R9fau50RvcUj2S09qFcMYyo+2ctcA7R3rU77Q
 O5q8JRXqRh24VQiAL+wSjqxoqbGz0qi+FlB6JjuGIQEZTDgGzSB163PBx9OOVdvrKYQn
 VsOkiDKtMc5Ok1otBrsKEaTiIv2lutlINs3vYuzEsOKHPquYTzt3A4+CG8vzMxGLsyxa
 VioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ld46SULEUSy3a8craN8ZlaKrVLpIrpEhfO8hir6sJus=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=RxxaBE+QluWe0EN1j6Lm3RxkFteyo/bCfUW/J6BGAy/fSz4YxvhVEp0wOpNpmjljBK
 bijDaUpLWe+iIQ0q4lJxAJM3J3mXEGsMDlIcON8p5mgYktdvOgw7Dt8Vkr1nHN/R52gP
 CmQeznyhA+5pTlC1DJko+jqbKURKdW3q6ZFlTcGhfv/DS6FS7Tm61omSafZXlVRa/JVR
 rysOAnF43RUQ2/xrGeN3sDg9MaaTl662Ui3XUkHM5QkyTMbwBChVP9EVSWcBGrdfixNi
 FCTLCJuIlKsMb22krpFd2U71G4A+mBahG3WGnWBMSsjnnHyjjnErpgQH4li4eobaj7zg
 ORCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470563; x=1790075363; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ld46SULEUSy3a8craN8ZlaKrVLpIrpEhfO8hir6sJus=;
 b=cGxrjKMsfxPCbdCOgLYpUfkYlOfJx/9ArgAATJT8CcYvy2grpcNKabfAnGwwjy6mup
 S6j1nKW6SavzM8YpDcE/9EFQRd1e8M7nulAdMlQ2stMBkdU1fioJYyVXQb12MZiAVoDo
 S/hsi3+dbTLGzNfiwXrzQx3m3+s4yM/xA2poiL+pcTXcsTMmzRxZAOtlwoesbtsZFDvg
 1xtdIooakDkFH0nuLLq5VdZV5soByNPTVFEvN6Nr5cCWYJsXcA8Ujo+KwPksHakBmnxp
 kt+59l63g69Ivr4jHxMqTAT4a9vXMS4+OxHoY2rraHegRbUh0lFrsUKIOw9Ebk2lySZP
 KPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470563; x=1790075363;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ld46SULEUSy3a8craN8ZlaKrVLpIrpEhfO8hir6sJus=;
 b=LiZo03A8Ne4/Lu8dHClcvkies2uJWF/uzMvkOoEZY+ooiRXSFpDhSIBJZ4QKXgpXzp
 bOCuzbMmR1tcXMAuL132Glfgt7WXG5AbwMEcxh+TmLjUkaRpjc3jlFfh6K19i1q9YGfM
 LR9P+eo7XCIp2QjWwo+nAL7qfgrkXmCXgjtgiOGQUDv/525e4Q1JfLIKWtksMOMScSAV
 MhNbwNZP4GNy4J5ltJt8jkkEVdTM2G6x18fSJ1nMhXp8Vpe8ZX96AWFmGZUO+5B5/Uq5
 PtVQtpMmD2U3KM/Dhuoex0aCNug4b/nINsXzlEkLM89mR3uO15+pNAhjoly8RyT+gAFf
 choQ==
X-Gm-Message-State: AFuF++mjlZ3carIJP/iFTTpx0cdAV96XD46wQ79GI6wbAgmPRN4pKh5h
 EKGm1eQ9sEXVPWhZ2i9vk5F6VUkcVaPK831oFQEJ992xsbobCH/jP/tXWmYVpfTVotnE/UNPwcZ
 GbcHdCtlb9wlM5YX/vl8mzbkJ9ILBX1mN/tcqf4AgQxcSnMhY5YFT926Z+xEEyEia+fbr0zs5fV
 bmoCD81bXvZiX53jrbZnOLN+E8KzpSgJYfN6IetgFSSQ==
X-Gm-Gg: AYBFou0Vf+tDZxEqBm1mWBEa7WLA6Sb8mMghqb/RST0sCEZIQK3XnuLEwA/pGBpnW91
 sSajz90LxNket+QbCbWxsxwYRN+Kk0OFE5cdul4HWTWRqucU+Fm1S3i5uLUwUytZpWn4r3VAnNn
 u7/Vs89Ss7sFRTkGXPJf04O7VawXN+DHR4EilUUBEQ9+OCQwe1t0YZbz+GPa8=
X-Received: by 2002:a05:6a21:150b:b0:3d1:9166:5c68 with SMTP id
 adf61e73a8af0-3dd5280e9a5mr1662937637.8.1789470563373; 
 Tue, 15 Sep 2026 04:09:23 -0700 (PDT)
X-Received: by 2002:a05:6122:e265:b0:5c9:66f7:2f23 with SMTP id
 71dfb90a1353d-5c99394d850mr318983e0c.2.1789470082956; Tue, 15 Sep 2026
 04:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-14-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-14-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:01:12 +0300
X-Gm-Features: AcwNN1VmI0dxDkGeATtj8a5cnOMEJTheUHARC8uAs8iUhsCtWAP7K69dDSXnE8I
Message-ID: <CAPMcbCpM1P6rZ=Ebztkw=Fk=rcdM5Y3ASJBOZi266YDJZp4ouQ@mail.gmail.com>
Subject: Re: [PATCH 14/17] qga/vss-win32: check GetLastError() after
 FindNextVolumeW failure
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000a1f91a065b837834"
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

--000000000000a1f91a065b837834
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:51=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> FindNextVolumeW returning FALSE can mean either normal end of
> enumeration (ERROR_NO_MORE_FILES) or an actual error. The code
> treated both cases as end-of-list, silently skipping any remaining
> volumes on a real failure.
>
> Distinguish the two by checking GetLastError().
>
> Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as
> DLL")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index b3daa060ac01..f14c47f9f7a9 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -461,6 +461,13 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>              }
>              if (!FindNextVolumeW(volume, short_volume_name,
>                                   ARRAYSIZE(short_volume_name))) {
> +                DWORD err =3D GetLastError();
> +                if (err !=3D ERROR_NO_MORE_FILES) {
> +                    err_set(errset, err,
> +                            "failed to find next volume");
> +                    FindVolumeClose(volume);
> +                    goto out;
> +                }
>                  FindVolumeClose(volume);
>                  break;
>              }
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000a1f91a065b837834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div>Reviewed-by: Kostiantyn Kosti=
uk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@re=
dhat.com</a>&gt;</div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 7, 2026 at 1:51=E2=80=AFP=
M Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com"=
>marcandre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">FindNextVolumeW returning FALSE can mean either=
 normal end of<br>
enumeration (ERROR_NO_MORE_FILES) or an actual error. The code<br>
treated both cases as end-of-list, silently skipping any remaining<br>
volumes on a real failure.<br>
<br>
Distinguish the two by checking GetLastError().<br>
<br>
Fixes: b39297aedfab (&quot;qemu-ga: Add Windows VSS provider and requester =
as DLL&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index b3daa060ac01..f14c47f9f7a9 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -461,6 +461,13 @@ void requester_freeze(int *num_vols, void *mountpoints=
, ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!FindNextVolumeW(volume=
, short_volume_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARRAYSIZE(short_volume_name))=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD err =3D GetL=
astError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err !=3D ERROR=
_NO_MORE_FILES) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_=
set(errset, err,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed to find next volume&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Find=
VolumeClose(volume);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto=
 out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FindVolumeClo=
se(volume);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000a1f91a065b837834--


