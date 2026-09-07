Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD64EC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XHR-0001UX-V9; Mon, 07 Sep 2026 07:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XHQ-0001Ta-1j
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XHO-00056X-BA
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bBrm2OsJ950ZeYb8Gr9ssqRSvm0kKG/gqdwPgN1ev2w=;
 b=MI2PgBIvxSGYSBV3eIs7wMxCYPQU9119/taPtb3CxZ2wFgGDdFCwGOvo1D5FObo+/EmlvQ
 5XQnafzgB8fNuxz7usgaLwWRQyqbgnIno1BjwQgVjH+VirFx630Xn30deKiYw+eSVeHMMK
 ICkk+g4QAxcHyRD+2NAtfD9Y6j4pWbI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-1LOjC0MQMEeUHAmJoeSWOw-1; Mon, 07 Sep 2026 07:12:48 -0400
X-MC-Unique: 1LOjC0MQMEeUHAmJoeSWOw-1
X-Mimecast-MFC-AGG-ID: 1LOjC0MQMEeUHAmJoeSWOw_1788779567
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e98e74535so58638216d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779567; cv=none;
 d=google.com; s=arc-20260327;
 b=kUtE0uaBD44Mqq6eoyuI3OarVhZhGY0JYoex41VrlB0T5Y09y01sZ0qluPeHuES5Kh
 pcl2AiRFwIzK1tN8RgcI8U6lmLNm/kXbzQS5W0e3Z7K7415p8O7vvEfVDTVG88JReVGs
 GQI8seB0syHj/TSNkNMEzxrn3TQvKkJutSkzGLsL0ryCzkd2uaN4aEr47KHO1DOpqCfu
 cMir5uQU+IQwaMbbk5hSgz1wgpcaosqkeeGUCHfB73777yV/dfEkNdEC3wgCNOLXoeS2
 mFN4z6JbrApZrnhME5d+YJn2KoePqL2LwxYRaR3cmcMfT77JPYwTnuNBzfKZ/jfz5ilM
 kMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bBrm2OsJ950ZeYb8Gr9ssqRSvm0kKG/gqdwPgN1ev2w=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=BeJ5vycKQxo9IEZD4/xstY6c5gjzaN+7eq5HljhJpVW5mW0CGVA7g4c2kI06DPE8F6
 qZDkVIBwyizJ8k4Ruw/P0k4BEqh0ox1gQxzkCLr3gRm3D8lUJY4uT7syq+hLD/dwI4N9
 iduEXI6Xtvew9Ku0ZAngqzIITevKGbmBV3OEw0ESTedeugPIfFuEEAg0J6rcpxppJoBA
 +AFfCXEi4HWeCOjSKAgvcvzGTbGvsDNX38LpaRjl8ow5s+6FdLKzU/9kgkvTM3ENTXDw
 Jm5phvr1aQPbbK6KG3JjAO+HodJTXyDzrgzJNkCNDODUIxVo7cqGD7UG/5FbBVUL/F02
 3CSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788779567; x=1789384367; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bBrm2OsJ950ZeYb8Gr9ssqRSvm0kKG/gqdwPgN1ev2w=;
 b=kI1ULZYPImSQuJ+iUeqIi/fsH79vb/B+RRRAd5fy9+63hy1GRMik9A6tqITuhtCoIj
 I7sQ2mkNRuf8hqNjodBv8o5oydy1ghvIO0xx4fkcozsuQ4mKo67gfc2nS/sF8+KnuhCQ
 u2DfzmHcvN2jNXjkZ43c9M57SnrRL6W3t/iEtogzBXoWhS0fdTSEoc/TRw/NjxMwpIrk
 npjd506OQsgXueTXl0yF6z04dq7StsuyU768sDVIpHu/NkCTWYa+7iJFQOpd6evMHG55
 uOEbmllMEgtmbQgxZyKeIoxYv25m5VqT8T0KhY0EPebI/Cuxs4uQ/cSWUpWi+LmmINTO
 4wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779567; x=1789384367;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bBrm2OsJ950ZeYb8Gr9ssqRSvm0kKG/gqdwPgN1ev2w=;
 b=tCQpxYaRdHTY23zRmKqkivgzwSXiXj6CYDRDZwSJWh/f3kHJYOM9P73hMEa4wVQsCt
 WjLF+y2LFsEFP/31W3dAO0YxuqVvu0DdjlE+VOss5vusEY0jHiy/06WosajK7hQRNhoA
 7BK/KF4yDlEim1TRSA4+GEirm1Gx8Gj6eZujye/Ulk24ae2A/6g9Wu1FvjJRM0J0ewP8
 mx6OV9z2ueyDgvJ/qIrqhbFeVZxmcraDyFaAyquRyPBiuNwL5uhztNwtSZ1go1e033Sl
 IwsryqIgw/Z70YXVB+dYbc1QVqqAa0XJI8Iqyaz4v+or9Nu6FIn7XTCfSuqN03glwh/E
 Om7Q==
X-Gm-Message-State: AFuF++k+kJ35WdvI+QiQGumQQ4EjhbfX6tWR9v9lMUN5jJj0kPz68kSl
 zhwh2nmr2uqoCtREwsLi6vC85w0VCAYBu7KdL9nE3jtDvA0aC8FFJbuMg57WRF45W99ipliHz/K
 DtlJwfqSeFNJ/FFsbGL5oSQhajhSjBE+AMXNUABqEU3sMmqNLYj9tTLu1ExFhr3QTFTiG4n2EcR
 F0tLeKwO5A6gAxXl9RYeoxxrfFWqFYsQ4=
X-Gm-Gg: AYBFou2DKVKjJryWK6F2XHG+Gtr07OqjucD5qmUexPX0aLOIQk/6TNeG8wmapJYDS/U
 NJwS2/OJqKbMPq5oCCPWEbHQF2eFOIh0BitNdXO56xdLf/5TYRRYb9syR+pGVcorfZyK/h1Nif2
 B0eYWW0xqWyuVRdwYZ5076ZPMjTz8qNefIFdTtMXxYwy6MzzwjCKunMhMTe9E=
X-Received: by 2002:a05:6214:62a:b0:910:1989:a61a with SMTP id
 6a1803df08f44-9103efc94d3mr273206986d6.9.1788779567431; 
 Mon, 07 Sep 2026 04:12:47 -0700 (PDT)
X-Received: by 2002:a05:6214:62a:b0:910:1989:a61a with SMTP id
 6a1803df08f44-9103efc94d3mr273201046d6.9.1788779562154; Mon, 07 Sep 2026
 04:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-3-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-3-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:12:31 +0300
X-Gm-Features: AcwNN1U4301PweVUIbe2pkWH0CXWlcGtHGQHz1NbPYVrCXT3ZZeCd_g3zYiN3K0
Message-ID: <CAPMcbCpawPhn53kS_q2aLxktDAKgYxoaxEH4bXyG5mBbuDbQng@mail.gmail.com>
Subject: Re: [PATCH 03/17] qga/vss-win32: pass valid SERVICE_STATUS to
 ControlService
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000625482065ae2b2ac"
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

--000000000000625482065ae2b2ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> ControlService requires a non-NULL lpServiceStatus parameter ([out] vs
> [out, optional]).
> Passing NULL is undefined behavior per MSDN and can crash on
> some Windows versions.
>
> Fixes: 917ebcb17027 ("qga-win: Fix QGA VSS Provider service stop failure"=
)
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/install.cpp | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 5b7a8e9bc529..f89658d277e9 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -572,6 +572,7 @@ namespace _com_util
>  /* Stop QGA VSS provider service using Winsvc API  */
>  STDAPI StopService(void)
>  {
> +    SERVICE_STATUS status;
>      qga_debug_begin;
>
>      HRESULT hr =3D S_OK;
> @@ -590,7 +591,7 @@ STDAPI StopService(void)
>          hr =3D  E_FAIL;
>          goto out;
>      }
> -    if (!(ControlService(service, SERVICE_CONTROL_STOP, NULL))) {
> +    if (!(ControlService(service, SERVICE_CONTROL_STOP, &status))) {
>          errmsg(E_FAIL, "Failed to stop service");
>          hr =3D E_FAIL;
>      }
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--000000000000625482065ae2b2ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, S=
ep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">ControlService requ=
ires a non-NULL lpServiceStatus parameter ([out] vs<br>
[out, optional]).<br>
Passing NULL is undefined behavior per MSDN and can crash on<br>
some Windows versions.<br>
<br>
Fixes: 917ebcb17027 (&quot;qga-win: Fix QGA VSS Provider service stop failu=
re&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 5b7a8e9bc529..f89658d277e9 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -572,6 +572,7 @@ namespace _com_util<br>
=C2=A0/* Stop QGA VSS provider service using Winsvc API=C2=A0 */<br>
=C2=A0STDAPI StopService(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 SERVICE_STATUS status;<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
<br>
=C2=A0 =C2=A0 =C2=A0HRESULT hr =3D S_OK;<br>
@@ -590,7 +591,7 @@ STDAPI StopService(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hr =3D=C2=A0 E_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (!(ControlService(service, SERVICE_CONTROL_STOP, NULL))) =
{<br>
+=C2=A0 =C2=A0 if (!(ControlService(service, SERVICE_CONTROL_STOP, &amp;sta=
tus))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errmsg(E_FAIL, &quot;Failed to stop servi=
ce&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hr =3D E_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--000000000000625482065ae2b2ac--


