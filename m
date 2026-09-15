Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B06C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Quc-0007nG-3i; Tue, 15 Sep 2026 07:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QuS-0007iu-3c
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6QuQ-0004yE-Ky
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKqY9wajiawcw6MSWp9vx7HyiNBaFJoFCBiJGjyWVbg=;
 b=FWKRPyfyEVQmDWcAr5sInUmHmoqB6V6Bpp8CO4kmuTgPMjN80rFHZ8T6aPAWk7s7f2PzIY
 e9NGiqGCfHWnSSO1dQXqQMiJ94xKrpcV2uBJkA2qcBnhbqpJo5CnABvQ9gKiOJ8L7OhlAY
 un0AI+bqrsfdaa3GT22XAFLgn2fi+T0=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-TFjqV8wGMIessxivjTXzlg-1; Tue, 15 Sep 2026 07:01:04 -0400
X-MC-Unique: TFjqV8wGMIessxivjTXzlg-1
X-Mimecast-MFC-AGG-ID: TFjqV8wGMIessxivjTXzlg_1789470064
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66988049306so5079604d50.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470064; cv=none;
 d=google.com; s=arc-20260327;
 b=jk5pA82dfuf2Kq6h1m3a9jJcXtJ8gjCydwEFe7lSvLZBPFqIEcyuOuCkEvt4vLv7YB
 lbfXwmV97t8YloStyAn/GeI5m6ks/UsgCEErDvHerURGcWlfNQb2dM/v0SuhhnxpnJCu
 NldTYzfVEK4gDE8C69vArN49t+Be6EIB7neXhRxKLOvHvUQ8yQsW+ZhJGwT3uVEFbMaP
 GMG/O4jwhDMaA4LUZaQOnbzObajKKjr5Ygp6PxPZcBMhYZx7MadEbY/i8g5eB7qhRcjs
 ioy6t2jU+rRxlkn+th/hMJG8UQC4hyJgcb/A4qICwH/UsG29XTCivI65DgsryB3tmaV/
 8msQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yKqY9wajiawcw6MSWp9vx7HyiNBaFJoFCBiJGjyWVbg=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=aYW+5VjBWc05M7OkkpgE96wAOPq6CrquFAf3LvAvWkEJKnlfvBkfLsXuP1lMXelCai
 ErXHL1ebuEBUIbm3mdDfPgftcxxg13z36ZH1t2NG2zxjBwtEwf5xdW8L/jXLM+SGBrtJ
 QAC4rGeMzSRS3N6ihXy84Hs7aoYbfHwGiQ7UG1ydiaLdXTlbhPjkEnsbPjDGIBSNo5hG
 B6Liz+1R+N7jMS2vNAcqw6R+8ycqhesgjJ83YL4WlTD5BPsI+DUwKDALsm2uttDj0E6y
 kPL6F5IaqcGsA099csgWHl4V8mAS1e3MMWL13quZSIXXqU8i8Sl6iKWd+mT/mY+kbtoi
 jdAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470064; x=1790074864; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yKqY9wajiawcw6MSWp9vx7HyiNBaFJoFCBiJGjyWVbg=;
 b=uNin+Iqkh8e1krWfY+gnXCLOLgXFv4wPqmovpoIB/b1Awz2jZuPMeyUy3csbdaQLJo
 Osl7ImC2HiAYCgxV5pO4J04b+fpU98d6u4rgWUqJQvdFD+13PGOKZGT8QAeXGiQedvMI
 Vh9NXlRW+zSkUVVCDKbSDPSKSb/0MsvOV+I0vF4/aFRGZPxa2tdHvXdqSnPh3p3HB/3b
 +ZVtiQ5LKQViOJFxjwahBtdxUsn15HJEud2JhG4Pdu37OzEyK8ksqZIzUke7ZW5D6L0u
 mKAMxJ2hsCv7f/QoQ75QV2Lt/ZJ3BI+ZHrCK6gKs88VXMPbGvg70VW4ypwRSdhJooUTh
 u+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470064; x=1790074864;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yKqY9wajiawcw6MSWp9vx7HyiNBaFJoFCBiJGjyWVbg=;
 b=JR5kcXmNhIy+1YbHUYoVU5yWkh+Dw0U/XZLk73SdFThwXsRK/E0iW9yFRTsDT5v9rb
 h8LYhCAB9v98k9Keebn+dUclylD0/zejQpKJAx0skwy5zR7sIKkdik9eS4Yv7YXWJlYa
 1S0vvNWyEQQleenvwLiZ0ANKhxCKfGc5xiGGBf54+0MSzz4xwbEJAl86F4lUo/a0m1au
 PwLCA1Yaxtk2OyCgbgESK4+9P7XUWZdT/FQ+QThEH2EP4ANVR3ys0CLeoUTJStN8OuLX
 PdMbS0gBk6GGkZp9UgFQgQqHrLS9idvQU3myf/ilzrO2vVRG1vwPCIfi0rQXcGNj4mTa
 wFiA==
X-Gm-Message-State: AFuF++lhHxriJxI2jvYAQ6vv+wdcJZfVpG7wZ/o0vauaCQIiwsL/tQ8o
 Pqz7SU9eU2RlN+GTVbLezHUCYToHU6DFq4PlbUf8AQgsoZAY5a97kieLxiwsRTOnLyOFwwQOZQY
 6oAlyFAPGysWnnJLTmh1negUDlrtfvEB3FAUJ6isw5t6Iz9LWc9X/2oMGXqvr7xsOpG2AVb8Hib
 HVt+hGEGk1Lq1MpDrFAE2R+oBRDTiKT84=
X-Gm-Gg: AYBFou1w3QJKk5IqQqHtOuBKwfmNS1wteyTHlDmzS9nzrYOLDFvhm+CreY6g79kTbiQ
 kriUggnwSs5NXilR1MbeKvtI3lKJsCWlMfW5ZfsaKFmn+6ZdsfXs6jdC8wxbFMzzBXDORf1UDhL
 TlvXd0hgitOELbf0JUCWjnzkqepM9Sl4O+yvbeq1rZIuzDdVGPV5o5PaijvzM=
X-Received: by 2002:a05:690e:1913:b0:66f:c1bc:c079 with SMTP id
 956f58d0204a3-6715cbaf458mr126865d50.65.1789470063474; 
 Tue, 15 Sep 2026 04:01:03 -0700 (PDT)
X-Received: by 2002:a05:690e:1913:b0:66f:c1bc:c079 with SMTP id
 956f58d0204a3-6715cbaf458mr126860d50.65.1789470062890; Tue, 15 Sep 2026
 04:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-13-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-13-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:00:51 +0300
X-Gm-Features: AcwNN1VDw67wFN5AB5q6Ox428CiCIOqCYzVVVx0Scgkf35nVgdWFzzzqOIJWOVo
Message-ID: <CAPMcbCqfFPDqr1DAq0DHBfzQ8Y9g_yE48Hr4Yq5UM6=1558PRQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] qga/vss-win32: report QueryStatus return value on
 failure
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000006fc336065b8377c8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000006fc336065b8377c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> When IVssAsync::QueryStatus fails, the error was reported using its
> output parameter `hr` rather than its return value `hr2`. Since the
> output parameter is not guaranteed to be written on failure, this could
> report a stale or uninitialized HRESULT, masking the actual error.
>
> Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as
> DLL")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index e3a15f83bf90..b3daa060ac01 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -506,7 +506,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>      for (i =3D 0; i < VSS_TIMEOUT_FREEZE_MSEC/VSS_TIMEOUT_EVENT_MSEC; i+=
+) {
>          HRESULT hr2 =3D vss_ctx.pAsyncSnapshot->QueryStatus(&hr, NULL);
>          if (FAILED(hr2)) {
> -            err_set(errset, hr, "failed to do snapshot set");
> +            err_set(errset, hr2, "failed to query snapshot set status");
>              goto out;
>          }
>          if (hr !=3D VSS_S_ASYNC_PENDING) {
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--0000000000006fc336065b8377c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">W=
hen IVssAsync::QueryStatus fails, the error was reported using its<br>
output parameter `hr` rather than its return value `hr2`. Since the<br>
output parameter is not guaranteed to be written on failure, this could<br>
report a stale or uninitialized HRESULT, masking the actual error.<br>
<br>
Fixes: b39297aedfab (&quot;qemu-ga: Add Windows VSS provider and requester =
as DLL&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index e3a15f83bf90..b3daa060ac01 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -506,7 +506,7 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; VSS_TIMEOUT_FREEZE_MSEC/VSS_TIMEOU=
T_EVENT_MSEC; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HRESULT hr2 =3D vss_ctx.pAsyncSnapshot-&g=
t;QueryStatus(&amp;hr, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (FAILED(hr2)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, hr, &quot;failed=
 to do snapshot set&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, hr2, &quot;faile=
d to query snapshot set status&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hr !=3D VSS_S_ASYNC_PENDING) {<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--0000000000006fc336065b8377c8--


