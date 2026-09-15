Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48277C88E7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Qu6-0007bI-Ba; Tue, 15 Sep 2026 07:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6Qtw-0007Tg-2V
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x6Qtu-0004vk-87
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mKrZOUr828JsMg1nIbQd5Y3twuXvu/UBGOzsnSpNyc=;
 b=IrrM5H3w/BOc7CoeSBAtfp1uyw2OF/WTZdSSvVf5P4+fIgQhzT96B2HDwSzN3gkr42wDh0
 Hypgwptx8xIFELNeTjOwMR+1F4y4GWcGXTvSNgWA2IacK2j6v71duBXLfGznQZGE6Da1Ew
 MqjKhjC+sN17vLGYAWzFO0Fo07jQZfg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-7MROqSl3NaSYNshwBgJiSQ-1; Tue, 15 Sep 2026 07:00:30 -0400
X-MC-Unique: 7MROqSl3NaSYNshwBgJiSQ-1
X-Mimecast-MFC-AGG-ID: 7MROqSl3NaSYNshwBgJiSQ_1789470030
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a2d361e1aso341006185a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789470030; cv=none;
 d=google.com; s=arc-20260327;
 b=o3rRsMyImkSIKKums/9qjxDIgosIM/6rWZiFqEeUOnCoC9xjooFFJ/5DcpHpyaXpff
 SOZgD/l77Qe1XILLdReiXPrio4Sp4cXlCuy+n8ApXXvE+8BSKOEWoWTYiTS/9yulkv8F
 QSDp82Y+AumtpR0zsrfqKj3JMGVCY48NgZvuhirYUrXmKUCCQQisn+h2xg818BSR7xaj
 syvCEdJNk1qcE0c53QmefqpsQtPempxOKDXqW+KsMtbpQ+YXo5xuuBKb8SacK9XpoKRx
 lso/txfbcLv0ePjeeCdKTjzPZi5fk0k9T1k5SjhmpCaRhHtqE4L+zMAktV+7iiLGd2QQ
 5MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5mKrZOUr828JsMg1nIbQd5Y3twuXvu/UBGOzsnSpNyc=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=ApPklHVQ8Mu/qGQ6m78dwde8mFiw1MX9TdMnT7i6jZKloSGAybKvWfiSBD6BHpZT/G
 79jRTcPOCO7RmM+ODmfpxQDh1IRkaqTUpn09F35Dt2IsclMoFdnDAKLfoC7taT+U2SOC
 Y3F7/PzIltRIUFxkqqmPIjqDdIM0WcLv3sCq27ZfYaDG9N4dzyEnE8eVhBIZBwqS9OFb
 xK5dELv1wWg3mW6bvMmHqMVsxKnzUtIm+cqiDNwKvFYGm9xZrKLPwF1vjZ7HR7P1Qa0/
 BcdpWOWo+7h1inTvllvoYygFzDUf+uKK4MFdICramnqkNFM3Kewz2d5+7SGEx8Uz2wZa
 x2Lg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789470030; x=1790074830; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5mKrZOUr828JsMg1nIbQd5Y3twuXvu/UBGOzsnSpNyc=;
 b=EI/JsHidz3CqdQNAvPt7S4tekX27z7Lw0AZil4wBoOUscx5n/S6FSgZuExKqX9fWXg
 /c8w9Z9QICPWnfdEJY+rxajfVm3g78lIFIXVRdLTr2P/QZoynjpBxhfkJnWlI+TT1UrX
 uozxS4Cs1nph7FyL4ifrI0YYAgGndRxJm3Fuabs1P4jhbtcMpoFbl5oELHhTlIcj76f5
 nbeS8wmTRqNVxvdnLnTTek4joxyEubcCYVm1GsRl3zfr/zNyxfm7VrG83rvw+F2SLCSL
 5sJMrFiDVgesG8Nx/XRJozoaM046FdEjrfEjw1X55cMF23I3qCqLrrLqMWGqF940KyhR
 mOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470030; x=1790074830;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5mKrZOUr828JsMg1nIbQd5Y3twuXvu/UBGOzsnSpNyc=;
 b=0ZlHZJ7/xdxeK4WgfC1O9FLwKIgoGdkmk6IcN61Zn1ZFeTk8ZnDGjzSy95maKYtD5E
 5Pw53mtK4p+V1VJtsfBpqAtdgJfZsyKEfVAbLigLj4+FdyhcIRoyCiVBRn7/BKWxJmjx
 V2GlZGYk+eIq2icb8XyI361NQV8vT1a0Uldd27bAlIdX5TUGBA7FvWfHF/RAAKUdbrmM
 VQeZVjmNPBDt69kLxXYtKroX/5eKnKLYcn83scGCmU+e62atnQHMj0JK+96JPT+8aVEC
 gTl2Tqq8VChVzBoXk6KjSUfZHftBz+sePUw7kXmrcnXSt5Z9GsZbDgsljr3EbOHEecE3
 F/DA==
X-Gm-Message-State: AFuF++ngjcvc8dlEoRn6wfJ5iPueavOEddlWjgAa4CtWKQq13lLQukoW
 OQCTZeH41ZgjJRLaSEm8jDiMF0ekHPH6uo0ggPTSL5cSnA5oOzlkuJvoAlIzugJueGsT41WKfo3
 fb08RC/GjWVJxmYVkeokDsU87uBKfWXwf6iYDFj2/M0kzd+ChiFpKWzmeuu97xDMIOHenIUHZgu
 6KWns5cytX4dQJXGOHwKaAMhuNNptXGLc=
X-Gm-Gg: AYBFou3LZgFyg8OL3Ep75X+Cnp8KN/oXj/MKLtbljmNw4UQXWwS2U4aIOog+XYdZAe9
 LW+aJv0eMXeheXMTNW2Ve/pwaB6UlP+lATjGbUa3eLtpELC5BDKmSQKIs/3aJKM0raYLnjKtHoY
 4gkzGI/z9TQ2pkQmwysX2LUAXNBqSz57fQAxk97OWjurDkI9h+vo08yua4Zzc=
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id
 af79cd13be357-93a29bbcd86mr889132385a.46.1789470029964; 
 Tue, 15 Sep 2026 04:00:29 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:939:d913:9a74 with SMTP id
 af79cd13be357-93a29bbcd86mr889126185a.46.1789470029488; Tue, 15 Sep 2026
 04:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-10-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-10-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 15 Sep 2026 14:00:18 +0300
X-Gm-Features: AcwNN1XYgJ_ZdfhyH8YO33vNOV3EG7h-Dj7sNCYjnj6gy7oWWeuaSpy1ib9aMtw
Message-ID: <CAPMcbCoEwwRyitrKe6W+=TpFOmWSqkL+Vzh8HgsCzRDU=L5+0g@mail.gmail.com>
Subject: Re: [PATCH 10/17] qga/vss-win32: guard CloseServiceHandle calls
 against NULL handles
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000071ff52065b837599"
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

--00000000000071ff52065b837599
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> StopService() unconditionally calls CloseServiceHandle() on both
> the service and manager handles in the cleanup path, even when
> OpenSCManager() or OpenService() failed and the handles are NULL.
>
> Fixes: 917ebcb17027 ("qga-win: Fix QGA VSS Provider service stop failure"=
)
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/install.cpp | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 12b045e2074f..9e8db79c122c 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -597,8 +597,12 @@ STDAPI StopService(void)
>      }
>
>  out:
> -    CloseServiceHandle(service);
> -    CloseServiceHandle(manager);
> +    if (service) {
> +        CloseServiceHandle(service);
> +    }
> +    if (manager) {
> +        CloseServiceHandle(manager);
> +    }
>      qga_debug_end;
>      return hr;
>  }
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--00000000000071ff52065b837599
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Sep 7, 2026 at 1:50=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;=
<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">S=
topService() unconditionally calls CloseServiceHandle() on both<br>
the service and manager handles in the cleanup path, even when<br>
OpenSCManager() or OpenService() failed and the handles are NULL.<br>
<br>
Fixes: 917ebcb17027 (&quot;qga-win: Fix QGA VSS Provider service stop failu=
re&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp | 8 ++++++--<br>
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 12b045e2074f..9e8db79c122c 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -597,8 +597,12 @@ STDAPI StopService(void)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0out:<br>
-=C2=A0 =C2=A0 CloseServiceHandle(service);<br>
-=C2=A0 =C2=A0 CloseServiceHandle(manager);<br>
+=C2=A0 =C2=A0 if (service) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseServiceHandle(service);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (manager) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseServiceHandle(manager);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
=C2=A0 =C2=A0 =C2=A0return hr;<br>
=C2=A0}<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--00000000000071ff52065b837599--


