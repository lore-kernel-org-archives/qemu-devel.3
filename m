Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B46C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 07:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulN8Y-0000EH-DV; Mon, 11 Aug 2025 03:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ulN8S-00009T-Ci
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ulN8O-0000Cp-8f
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 03:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754897991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uej805sTTHSZaadFt4+gB7NuJ/KhiAiZh1qQkQxozP4=;
 b=ZQiKU3bZvRA5ESb7TmIuAvyhS2YIrnoZJXhHOfRo952gYynAI0AnARR5ZorkPdROYs4IMx
 nYOWVHQ90tU84Ixl/mctKc4JF+5thi2QaLejvge+ebHfdXy4IlYQu5pNMyWvbgiSybw5P6
 pTwlycKFfFHO1m3tebxXXdR4+t7jqsI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-4D8rvwYYPMO0nEDoszwFJw-1; Mon, 11 Aug 2025 03:39:49 -0400
X-MC-Unique: 4D8rvwYYPMO0nEDoszwFJw-1
X-Mimecast-MFC-AGG-ID: 4D8rvwYYPMO0nEDoszwFJw_1754897989
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7075d48a15bso84124606d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 00:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754897988; x=1755502788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uej805sTTHSZaadFt4+gB7NuJ/KhiAiZh1qQkQxozP4=;
 b=FpFgNI+thWHo9QI6RWw0a/HNWPEd8qWKB8i3AQXuaovA0FpITwyeJldBfMHa3k5sq5
 yf0ur0a+4JrRkwHOGj0MTV+35S1gaej5gTBY7sqm3np6HVaSdzxYumQ3jTpCpRikKCPw
 2VsKEmcHTWIQdbID5Yvk6WX6CrT2Hm4laD9EIbzNNgiW8KSlCMxd9kTw+FjK/VfL8+7P
 iosGIwnH0tKmI9EHfQflmRUSyrG/3Nfv2IPnSw1ykD1lKlODuaBAhfyEKnsHnF9VVV9u
 KWoZMbtVWTw01R5Dsqu9vrkp6mlb9NEVe+VaQU6YKvTnzn7q7xsh0I24Ixlek84lFCV+
 9aPw==
X-Gm-Message-State: AOJu0YyK1JJNWkUU91nUjTFkC0lDdEFq1NRlF0srzUH+OyujG8Dx9MUf
 woIDzVoILJLq16MkFJsgPmqXHbWPZYSgZmYQZg889ldYWsl5C8heQDZMf27kedrsm4iPgOakMWQ
 NvSPvjry9K6coX5EQqp2YwYJnovXUGS5NiICc4U6+vAFMUNSlO1UBdiVMb221lEJEz8rVEdMBNU
 4JTtwZgOcTtB/24l4+DMnE20EjbT90944=
X-Gm-Gg: ASbGncvV08fbMai3kImyRnl++1jfMCJmuV0Xu1oJSnDbO/gCK9mPs9A49av4ZRux4ic
 +BQGK1i0KVeg+rqP8ZTWSHdKA/wIebpr0SZSN1Qo+p/3i0WeJ0oTqRZ5QCmHPybUz3YwMPtpNup
 9+ezQIBihIRmX3r6uRtB3+Rto=
X-Received: by 2002:a05:6214:c29:b0:707:228e:40b9 with SMTP id
 6a1803df08f44-7099a332e82mr201616836d6.23.1754897988673; 
 Mon, 11 Aug 2025 00:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtw+Isimo1h+cdq2TXAIaVJet3KoWbuP7zrphP+7X/U7VyoFmBDxUtexFdkQ4TW4JvA4xbC6G9QIUTBnOF0Dk=
X-Received: by 2002:a05:6214:c29:b0:707:228e:40b9 with SMTP id
 6a1803df08f44-7099a332e82mr201616626d6.23.1754897988159; Mon, 11 Aug 2025
 00:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250807133221.1135453-1-den@openvz.org>
In-Reply-To: <20250807133221.1135453-1-den@openvz.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 11 Aug 2025 10:39:37 +0300
X-Gm-Features: Ac12FXzx0VWeMPba8tZZ3szVQDEnPdy8hDLZIsTisN8uJPP5TLmkGKOvp-UEklw
Message-ID: <CAPMcbCros9Wxg8DtWpCT87t+6e3=BqcNU=qsAjsx-5+RYW4+_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] qga: fix potentially not initialized nr_volumes in
 qga_vss_fsfreeze()
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000033a535063c12074d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000033a535063c12074d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>


On Thu, Aug 7, 2025 at 4:33=E2=80=AFPM Denis V. Lunev via <qemu-devel@nongn=
u.org>
wrote:

> In this function we could have this variable not initialized. If this
> could be acceptable on error, the variable could be left not initialized
> f.e. as follows:
>
> void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
> {
>     ...
>     if (mountpoints) {
>         ...
>         if (num_mount_points =3D=3D 0) {
>             /* If there is no valid mount points, just exit. */
>             goto out;
>         }
>     }
>     ...
>     if (!mountpoints) {
>         ...
>         if (num_fixed_drives =3D=3D 0) {
>             goto out; /* If there is no fixed drive, just exit. */
>         }
>     }
>     ...
> }
>
> Stay on safe side, initialize the variable at the beginning.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> CC: Michael Roth <michael.roth@amd.com>
> ---
>  qga/vss-win32.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/qga/vss-win32.c b/qga/vss-win32.c
> index f444a25a70..b272bfc782 100644
> --- a/qga/vss-win32.c
> +++ b/qga/vss-win32.c
> @@ -157,6 +157,8 @@ void qga_vss_fsfreeze(int *nr_volume, bool freeze,
>          .errp =3D errp,
>      };
>
> +    *nr_volume =3D 0;
> +
>      g_assert(errp);             /* requester.cpp requires it */
>      func =3D (QGAVSSRequesterFunc)GetProcAddress(provider_lib, func_name=
);
>      if (!func) {
> --
> 2.45.2
>
>
>

--00000000000033a535063c12074d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Re=
viewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" ta=
rget=3D"_blank">kkostiuk@redhat.com</a>&gt;</div></div></div><br></div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Thu, Aug 7, 2025 at 4:33=E2=80=AFPM Denis V. Lunev via &lt;<=
a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">In this functi=
on we could have this variable not initialized. If this<br>
could be acceptable on error, the variable could be left not initialized<br=
>
f.e. as follows:<br>
<br>
void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)<b=
r>
{<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 if (mountpoints) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (num_mount_points =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If there is no valid mount poi=
nts, just exit. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 if (!mountpoints) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (num_fixed_drives =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out; /* If there is no fixed=
 drive, just exit. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 ...<br>
}<br>
<br>
Stay on safe side, initialize the variable at the beginning.<br>
<br>
Signed-off-by: Denis V. Lunev &lt;<a href=3D"mailto:den@openvz.org" target=
=3D"_blank">den@openvz.org</a>&gt;<br>
CC: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D=
"_blank">kkostiuk@redhat.com</a>&gt;<br>
CC: Michael Roth &lt;<a href=3D"mailto:michael.roth@amd.com" target=3D"_bla=
nk">michael.roth@amd.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/qga/vss-win32.c b/qga/vss-win32.c<br>
index f444a25a70..b272bfc782 100644<br>
--- a/qga/vss-win32.c<br>
+++ b/qga/vss-win32.c<br>
@@ -157,6 +157,8 @@ void qga_vss_fsfreeze(int *nr_volume, bool freeze,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.errp =3D errp,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
+=C2=A0 =C2=A0 *nr_volume =3D 0;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0g_assert(errp);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* requester.cpp requires it */<br>
=C2=A0 =C2=A0 =C2=A0func =3D (QGAVSSRequesterFunc)GetProcAddress(provider_l=
ib, func_name);<br>
=C2=A0 =C2=A0 =C2=A0if (!func) {<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div>

--00000000000033a535063c12074d--


