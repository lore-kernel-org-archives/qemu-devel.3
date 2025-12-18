Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601CBD6ACF5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 12:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWDEu-0004nJ-PO; Thu, 18 Dec 2025 07:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vWDEp-0004n1-8I
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vWDEf-0002RE-Np
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 07:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766061358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LJEI7hBcJPsKIGs0FW8nMdtFnVkJuNdMnip0SyuyT8=;
 b=Ewuq6hXPGFTMwGbwUhg+c4S80L007BJ4YIRHIhcy9Dp3BjVRxZ6KfzxevEUyGNXVdzyMeJ
 Q0UsCxxZYgohYLADGJSlxpGpCI8TiwXCdoXnfuwdpBZXJU0z9sF9f8QL+uT084R+XNycfq
 PhqxkCacE57FPuoPeTvBw+4JGGod2QM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-CDuVA9xANRK5nUBjoKX4NA-1; Thu, 18 Dec 2025 07:35:56 -0500
X-MC-Unique: CDuVA9xANRK5nUBjoKX4NA-1
X-Mimecast-MFC-AGG-ID: CDuVA9xANRK5nUBjoKX4NA_1766061356
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b259f0da04so131717385a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 04:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766061356; x=1766666156; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8LJEI7hBcJPsKIGs0FW8nMdtFnVkJuNdMnip0SyuyT8=;
 b=jhaUdWh88pRRObguP3kA2dv31r5Q2GWvii1ejTQgelZbvAR3CVMS/CQBgT+3lmcz4E
 OR1QTVXF3KWOn+dLGCodpKXHeGPS6bSp1PXXWT9gZAjB/j5ZfJUIDSpKEg4jdho7dUzS
 FtaIbMgtEQ930TGve+Q/pgYSLhlN9VUjFjgs0M0E+vvia5v27TI1M/R1EDLi1M4/A5Mp
 xVbxxpeDw/8aIq0/XuUBXSwW9XYJtAtAGrgyLzhFjMfXd1LTphuewfozKVaFAlpSvvsG
 w3MXPtFHaR/rCQn37aUP0zPCXDcddNIafIDH/lPeXP3Cf409VzjlIxedC0ncyetmiKuX
 woMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766061356; x=1766666156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LJEI7hBcJPsKIGs0FW8nMdtFnVkJuNdMnip0SyuyT8=;
 b=NvfRiFfv4yXdPozCGPQ7jpDtzi0JdZjWITS/7KAdAmQTNs53voSjxUUsO8qJOR6C/N
 tvVcIGmwhOqZCog1x/eoDVq1fWq897qmibvvR+KEVQvtmZIYOWRegeThnt+u+ExJ8e+x
 FsLZqVsKy1Qxemrg9Ns/S6D2X5mcrSISP3Q5gHYbR040Pw4baElcvzwjSFx1k2aTBMYk
 feaTq4oNSALG9qZy3WqTg0C9PNMebbA4xvGVTBlf2APpUatC/MrKiUbVN3qEZdzVmdSL
 Rnswa0omiiIqqHjjfbk99qErlRDveRA2czPet5og+BrHvoAWecPBMWqE0RKdbxrxFrsG
 cBdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ0OHEADpZlLbueCQf76k1YtfFe1GqbCLnSdmRz8qAecmLIS+Yxt0NKVUKn8UNK2GfKL6FZI4EU9Jk@nongnu.org
X-Gm-Message-State: AOJu0Yz0rehsSYpg6EfbcuZ/G6yhHMeZXvAErZyykJzUjdiPJEbkG9XF
 PTaXTnfidfL1FDCzxj1CNEDfs2lgntKIzRAA0xhf/GJ/dt+MxiktA4MEoC9C4gBCZot8pw/VILy
 E+vgJCbckoYdy6vKYrFdR1+5TXX9iny02FQl0RumU7HYRE6g6v90MOi8XORdU6P/e1IxjN4QrnU
 9LfaQx4sK7Xp91M7toDzaqJxpUxddu0HM=
X-Gm-Gg: AY/fxX7TtmqAZamZtG9l+0mEElQh2fX6JTRWQSh8vJwD1a0dhzIOZKXjv5e8J6y8rfm
 hA0DQ3/L3etyC+KJS1ozauOfGImXl8BcDsHJKK0RpAvSYz0BGbJVr7YhLvTSVYkND8nCd3JRMFC
 wqlv1Yiijxv6JNPenwVJJbOVR1sYpR8+vrUAhmQSBlW3jR5IZkXnmi0pQOAfC1Rt+atOE=
X-Received: by 2002:a05:620a:6919:b0:8b2:5cdd:6a16 with SMTP id
 af79cd13be357-8bb3b3708d5mr2929783085a.82.1766061355895; 
 Thu, 18 Dec 2025 04:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpxFhGoLTghMC+VClOhPC8jMRIpVdUHIyRBMkyOji8G/nfSeqCFXAa/rBK/Oq82OvKZ0wz0sCNUfcmYNstw2Y=
X-Received: by 2002:a05:620a:6919:b0:8b2:5cdd:6a16 with SMTP id
 af79cd13be357-8bb3b3708d5mr2929779985a.82.1766061355467; Thu, 18 Dec 2025
 04:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20251218085446.462827-1-phind.uet@gmail.com>
 <20251218085446.462827-2-phind.uet@gmail.com>
In-Reply-To: <20251218085446.462827-2-phind.uet@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 18 Dec 2025 14:35:44 +0200
X-Gm-Features: AQt7F2q4o5B25uhX_oWQBW9fat5qEtkM0Nr8aYVEcXQ9mIhtZ6QKAhGqX5MMIc4
Message-ID: <CAPMcbCqCkqSyhpGvSYAQLR-cT0+_imh=3o5mXfCiR1j+74264A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] qga/vss-win32: Fix ConvertStringToBSTR
 redefinition with newer MinGW
To: phind.uet@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000be9b8206463933da"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000be9b8206463933da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Thu, Dec 18, 2025 at 10:55=E2=80=AFAM <phind.uet@gmail.com> wrote:

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
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build               | 12 ++++++++++++
>  qga/vss-win32/install.cpp |  2 ++
>  2 files changed, 14 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index c5710a6a47..5a0f407d6f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3299,6 +3299,18 @@ endif
>  # Detect host pointer size for the target configuration loop.
>  host_long_bits =3D cc.sizeof('void *') * 8
>
> +# Detect if ConvertStringToBSTR has been defined in _com_util namespace
> +if host_os =3D=3D 'windows'
> +  has_convert_string_to_bstr =3D cxx.links('''
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
>  namespace _com_util
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

--000000000000be9b8206463933da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Thu, Dec 18, 2025 at 10:55=E2=80=AFAM &lt;<a href=3D"mailto:phi=
nd.uet@gmail.com">phind.uet@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">From: Nguyen Dinh Phi &lt;<a href=3D"m=
ailto:phind.uet@gmail.com" target=3D"_blank">phind.uet@gmail.com</a>&gt;<br=
>
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
Suggested-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linar=
o.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
2 ++++++++++++<br>
=C2=A0qga/vss-win32/install.cpp |=C2=A0 2 ++<br>
=C2=A02 files changed, 14 insertions(+)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index c5710a6a47..5a0f407d6f 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -3299,6 +3299,18 @@ endif<br>
=C2=A0# Detect host pointer size for the target configuration loop.<br>
=C2=A0host_long_bits =3D cc.sizeof(&#39;void *&#39;) * 8<br>
<br>
+# Detect if ConvertStringToBSTR has been defined in _com_util namespace<br=
>
+if host_os =3D=3D &#39;windows&#39;<br>
+=C2=A0 has_convert_string_to_bstr =3D cxx.links(&#39;&#39;&#39;<br>
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
+#ifndef CONFIG_CONVERT_STRING_TO_BSTR<br>
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
</blockquote></div>

--000000000000be9b8206463933da--


