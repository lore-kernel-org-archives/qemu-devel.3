Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE198D5B87C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 06:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVOWS-0002Pm-Dv; Tue, 16 Dec 2025 01:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vVOWB-0002PT-Ao
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vVOW7-0008DX-JF
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765866395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3Fm+mgS/RGcJGNsaFKUENZMYAk0DZlnA3/Zg6UmWWE=;
 b=g4qHqT7lv10eLa1utU61nVt4NybmmnlL83amJV38Y06dFdOEW75uU53dhH1zsmS8zD9FM+
 aE/ZcPMBpHuXjXUFz8EIliD4y6ZL7Tw1ZyMGasXx063ENVG1eLQNtz3H3f0z6h5FtxCs9G
 L/uncAp5FehcU7316UQp1J67muIqz7E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-KbMkucISOrObCEDHq7IZxQ-1; Tue, 16 Dec 2025 01:26:33 -0500
X-MC-Unique: KbMkucISOrObCEDHq7IZxQ-1
X-Mimecast-MFC-AGG-ID: KbMkucISOrObCEDHq7IZxQ_1765866392
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0d59f0198so32978775ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 22:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765866392; x=1766471192; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x3Fm+mgS/RGcJGNsaFKUENZMYAk0DZlnA3/Zg6UmWWE=;
 b=Syj14CDVUYvTGDejgdCjZF7c5AptZFAEPAhy29lBIW/5gTKMWOpXnH+mYHCh9pVvht
 Iqk2kxLk9Kt1RvJhZnGxnmlH5lDP8yF+4HXJZ8cOae8XJQHdZD1IRLAkpLqm75uqfHzN
 YxC3trOod/GofEelElkpsRlM2ZUL7gGrvF/JXLEc8jFKLoeznkFOU6DbQc4kM5opcjWp
 NogkHkciQk8pb0YgAjor4ekTlqi7V7WbajycWFvLJs3PCbA/8XdIGzr4YdL2LgNo3w0J
 Ms1EVdIAc8IDUanwxL3Fc8jvL8zBbifuaPj+43dfoYSDjJ6AhmoLrJulOHoz9TSKaUTX
 7ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765866392; x=1766471192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3Fm+mgS/RGcJGNsaFKUENZMYAk0DZlnA3/Zg6UmWWE=;
 b=d8fORLiScF5R1OLG4Fkl3ObcL7k5IhLBWh5Y3YljgTHGrRGrZEzRi8Ppc+dTO5vSOw
 v151rCUx8V7JziDWpcPXR1j57ThaqGNpjAnD0NE13Yj5KVIRL2vKpN+0UQk6NhL9wMX+
 uCX1x15Wwyr744rNNB60wbG05nnnPpr4SjDM2q0bT7ozmFWiUDzPPrOvLDX3CwAogdo7
 CkVPDsH1XvaKaJAHjI1NAnvEMBxaussy4FcWLUHDGAWzGPVr+dSF/dZnWedSxuZ1ggz4
 hbfUMpFbjDnr1vbZlT9i3XMCfkXD+qqXJ2M0x7OUqo/y4j95fEjKXAjXL68JaP1Ajts1
 exXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+ZurMFDjGOOQWqsQo93ax42Zh/0AH4mxjyT2uHjd3Be7oBiJrGpprr90USQVRLJ1jMhN8Y/SROU3f@nongnu.org
X-Gm-Message-State: AOJu0Yxh8Epr8JV3BCfan+vKpWQoV/ETCBqL/58KwMeLR/Otc0VFrk5q
 dm5Eemo+bWvbE+WXIUolwTNOQKRwpHhUa+yQMkymuMtDTjsYvCyEe49fod+ub81fVEU0a9Z4KDk
 b7w4XFOtU/rXpZECycraMHn8V8vaF6nVjFdJdwbBuiVCJS7J1wvvB2D00KMsiFjKI0tms5Ph+GT
 83m52TeCTuqmDelr3cImqmZw6bjiTXYRQ=
X-Gm-Gg: AY/fxX48VdQprO48bY4pJOCQuzdRwnGpBkjvB4O6QSwFyDIbViC+zd76TYQOBZDvcpi
 XwTAWJ9kRRmT7JbtkCuimaar0IU2cQl3XCY/0BqJ/p6gkKiNEe5M5s06Js0vBPFXLfgpuEDhyeX
 PfUKe3inA2t6LUvoaOe0/LHAPyTSlT+zsKeUYeJvSSCKQ9KUAZpj1wY61R5knEnxZLS0iqQ/3X
X-Received: by 2002:a17:903:1a03:b0:2a0:afeb:fbb6 with SMTP id
 d9443c01a7336-2a0afec014amr79906025ad.8.1765866391881; 
 Mon, 15 Dec 2025 22:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWQhh/HflffXxJyxHJYLPxy37gU1IMqhVl6U2FFeLtWGTDYha803gPZVbaDs6bYPinBDs9IOZmZTRlydxbYhA=
X-Received: by 2002:a17:903:1a03:b0:2a0:afeb:fbb6 with SMTP id
 d9443c01a7336-2a0afec014amr79905975ad.8.1765866391484; Mon, 15 Dec 2025
 22:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20251215164512.322786-1-phind.uet@gmail.com>
 <20251215164512.322786-2-phind.uet@gmail.com>
In-Reply-To: <20251215164512.322786-2-phind.uet@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Dec 2025 10:26:20 +0400
X-Gm-Features: AQt7F2rpUe0d8uaXQpRnZWTiejFIHpj5wwFsEF2MhTdRsf7x2ZJjwE66IHJQ8y8
Message-ID: <CAMxuvaw=ZigHsgHf5matsmLrH57y-HE4gwgQy4Oyht4+u58N+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga/vss-win32: Fix ConvertStringToBSTR redefinition
 with newer MinGW
To: phind.uet@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fc4fec06460bce9d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fc4fec06460bce9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Dec 15, 2025 at 8:57=E2=80=AFPM <phind.uet@gmail.com> wrote:

> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
> Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
> _com_util namespace via <comutil.h>. This causes a redefinition
> error when building qemu-ga on Windows with these toolchains.
>
> Add a meson check to detect whether ConvertStringToBSTR is already
> available, and conditionally compile our fallback implementation
> only when the system does not provide one.
>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  meson.build               | 12 ++++++++++++
>  qga/vss-win32/install.cpp |  2 ++
>  2 files changed, 14 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index c5710a6a47..60a980e610 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3299,6 +3299,18 @@ endif
>  # Detect host pointer size for the target configuration loop.
>  host_long_bits =3D cc.sizeof('void *') * 8
>
> +# Detect if ConvertStringToBSTR has been defined in _com_util namespace
> +if host_os =3D=3D 'windows'
> +  has_convert_string_to_bstr =3D cxx.compiles('''
> +    #include <comutil.h>
> +    int main() {
> +        BSTR b =3D _com_util::ConvertStringToBSTR("test");
> +        return b ? 0 : 1;
> +    }
> +  ''')
> +  config_host_data.set('CONFIG_CONVERT_STRING_TO_BSTR',
> has_convert_string_to_bstr)
> +endif
> +
>  ########################
>  # Target configuration #
>  ########################
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 7b25d9098b..5b7a8e9bc5 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)
>
>
>  /* Support function to convert ASCII string into BSTR (used in _bstr_t) =
*/
> +#ifndef CONFIG_CONVERT_STRING_TO_BSTR
>

I wonder if it could check __MINGW64_VERSION_MAJOR >=3D 14 instead of addin=
g
a configure-time check.

lgtm anyway
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

 namespace _com_util
>  {
>      BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
> @@ -566,6 +567,7 @@ namespace _com_util
>          return bstr;
>      }
>  }
> +#endif
>
>  /* Stop QGA VSS provider service using Winsvc API  */
>  STDAPI StopService(void)
> --
> 2.43.0
>
>

--000000000000fc4fec06460bce9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 15, 2=
025 at 8:57=E2=80=AFPM &lt;<a href=3D"mailto:phind.uet@gmail.com">phind.uet=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Nguyen Dinh Phi &lt;<a href=3D"mailto:phind.uet@gmail.com"=
 target=3D"_blank">phind.uet@gmail.com</a>&gt;<br>
<br>
Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the<br>
_com_util namespace via &lt;comutil.h&gt;. This causes a redefinition<br>
error when building qemu-ga on Windows with these toolchains.<br>
<br>
Add a meson check to detect whether ConvertStringToBSTR is already<br>
available, and conditionally compile our fallback implementation<br>
only when the system does not provide one.<br>
<br>
Signed-off-by: Nguyen Dinh Phi &lt;<a href=3D"mailto:phind.uet@gmail.com" t=
arget=3D"_blank">phind.uet@gmail.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
2 ++++++++++++<br>
=C2=A0qga/vss-win32/install.cpp |=C2=A0 2 ++<br>
=C2=A02 files changed, 14 insertions(+)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index c5710a6a47..60a980e610 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -3299,6 +3299,18 @@ endif<br>
=C2=A0# Detect host pointer size for the target configuration loop.<br>
=C2=A0host_long_bits =3D cc.sizeof(&#39;void *&#39;) * 8<br>
<br>
+# Detect if ConvertStringToBSTR has been defined in _com_util namespace<br=
>
+if host_os =3D=3D &#39;windows&#39;<br>
+=C2=A0 has_convert_string_to_bstr =3D cxx.compiles(&#39;&#39;&#39;<br>
+=C2=A0 =C2=A0 #include &lt;comutil.h&gt;<br>
+=C2=A0 =C2=A0 int main() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 BSTR b =3D _com_util::ConvertStringToBSTR(&quo=
t;test&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return b ? 0 : 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 &#39;&#39;&#39;)<br>
+=C2=A0 config_host_data.set(&#39;CONFIG_CONVERT_STRING_TO_BSTR&#39;, has_c=
onvert_string_to_bstr)<br>
+endif<br>
+<br>
=C2=A0########################<br>
=C2=A0# Target configuration #<br>
=C2=A0########################<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index 7b25d9098b..5b7a8e9bc5 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)<br>
<br>
<br>
=C2=A0/* Support function to convert ASCII string into BSTR (used in _bstr_=
t) */<br>
+#ifndef CONFIG_CONVERT_STRING_TO_BSTR<br></blockquote><div><br></div><div>=
I wonder if it could check __MINGW64_VERSION_MAJOR &gt;=3D 14 instead of ad=
ding a configure-time check.</div><div><br></div><div>lgtm anyway</div><div=
>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau=
@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
=C2=A0namespace _com_util<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0BSTR WINAPI ConvertStringToBSTR(const char *ascii) {<br=
>
@@ -566,6 +567,7 @@ namespace _com_util<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bstr;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
+#endif<br>
<br>
=C2=A0/* Stop QGA VSS provider service using Winsvc API=C2=A0 */<br>
=C2=A0STDAPI StopService(void)<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000fc4fec06460bce9d--


