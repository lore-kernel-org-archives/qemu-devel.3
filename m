Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EDAD5CCA1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 09:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVRkQ-0002Gi-Hj; Tue, 16 Dec 2025 04:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vVRkN-0002GW-8r
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vVRkK-0004lR-7D
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 04:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765878810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L1s0eqRGahHf7N8O4aYEfoltAWxkcolVTZ0Epkcl9Is=;
 b=bsxRVCHgvikwtcissBBVls/DkPVbFKxskaXjvTLxbYEHETIHLUQ1T8bS3HW5IEZUHIZMlr
 hacMZDP6YybJjdQGdR9/bRM0gL+7QWXWvobZ7X0nsso1mMdi076Y2hnsW9Flf7va2zcm+F
 RxhpDdONBNTdqWo6umepO8KdiEoEB1s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-hUvGbaXzMUWw6YqOM7Iwag-1; Tue, 16 Dec 2025 04:53:26 -0500
X-MC-Unique: hUvGbaXzMUWw6YqOM7Iwag-1
X-Mimecast-MFC-AGG-ID: hUvGbaXzMUWw6YqOM7Iwag_1765878806
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8823f4666abso100490096d6.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 01:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765878806; x=1766483606; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L1s0eqRGahHf7N8O4aYEfoltAWxkcolVTZ0Epkcl9Is=;
 b=KgPdL2A59lb/yM/1/+CDjgNuYQ9DjBWRijcjZ1r7qWx3tEci70yAU+psn/rjw3nzgm
 +oecCXo2uyy4wNiVxkEk3I9EScyHeRHWjDeN4KN+mKxVq10YWgKapHah1z2JfWUZf0LC
 z3caBNj1UNDeEzLrD/2HnDYJSVltg+nYAYvG6NhEYVwg32sAVUx4gs+TcRBtlfwZvg58
 HaylXyW097SPGPrWCZtIaGhlV+a5FjpO0nfHqcZrczwFAc4/xOqaWzFnXingF/AJUQwu
 VD/EEwmMqUPnHDGah70WTAww2ofGvGP0eefPWRr23Y1wsia8B9Xg5nRVAzIBhdvYnfT0
 3Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765878806; x=1766483606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1s0eqRGahHf7N8O4aYEfoltAWxkcolVTZ0Epkcl9Is=;
 b=xIkQ7J7762AhBL4vm2zDamIhVCZ57CcY5sz36ElpN09DK6G+Mwmgz3sXW/EWnHc6V6
 sxmq0P24Ybzl4dt4kVvakjmrp+gQ6GcSIVXRvSZ1kESjqGvEpQuTC8CTMVAd94crm0Ws
 KOYQpgHUKDSU95J1ZKwMzsZJj3iZzjRz4rrLtcSR1921iDp5sWHtMzIrP5etCf2eAnJE
 zHnZZ1v7JblBRPlYwTKf53K+msJ+ZiVQDETy0bxnH+hY9jnVsZj7Dr3KD0glgiSLA+tS
 X+FSaeIN9zFLPwJ5pACITyHalDVtBZr/5AcNZwuoqptg/bt75JQpPj/smMXJ3eD46kKa
 5sRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDecqmWsURk8L/YeTIgE5ejx8HmMNoGV0tHRVqljjiDGMtyKbhO8tCLsyjU1MRmRGdBV8EuRR9q5Kt@nongnu.org
X-Gm-Message-State: AOJu0Yx5+8sSzAgNbfsqYedeMuUou/rcG1IfoorwoA0RTgzsDyeUBaiC
 4GSMtjdRP4dsgxX3j4jp9Jnh4QJiXx0EmROLj4m+ToRC4FD5DAjulcmJlpHeij0ag5vFsO18tF4
 7lrWVilh3JYDJkDVtR4caOGliZmBd4V3Et8WbNIiHD3ogtZ64gV7n9At4vSCxPAwguOM9US7ChT
 rvsaJZXpupKWTuzqBon/qlZZp+eWJAv/s=
X-Gm-Gg: AY/fxX65e0V6hNrjA/wGfCNyHJdmAottOnzLqMv1DKAUtN3fs+5pN9h5tvt6LM9tU0F
 wx5+nelI7x86fx8k7eml9fnH8GcWgjmv4CGMic5/ZcMFtjKTaLga771/6w+1v2hMUlBWDhZm1nW
 FWiHvz5L5CfHCd/sSEXjy7onpeSFj4YP1aMC1j2Sp/U/wnvvzOx0cN6XCfiigBP41X3HKC
X-Received: by 2002:a05:6214:2305:b0:87c:1889:6a7f with SMTP id
 6a1803df08f44-8887e16bd17mr225070166d6.5.1765878806319; 
 Tue, 16 Dec 2025 01:53:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBqBCTN4PynvolU7w8ZBf0KPSeYeBPIRXDaBdeIqZBeyEn9YrCPJVwbzhlxCEqbisbuYcDsm+heAj4rhxN2Yg=
X-Received: by 2002:a05:6214:2305:b0:87c:1889:6a7f with SMTP id
 6a1803df08f44-8887e16bd17mr225069996d6.5.1765878805891; Tue, 16 Dec 2025
 01:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20251215164512.322786-1-phind.uet@gmail.com>
 <20251215164512.322786-2-phind.uet@gmail.com>
 <CAMxuvaw=ZigHsgHf5matsmLrH57y-HE4gwgQy4Oyht4+u58N+g@mail.gmail.com>
In-Reply-To: <CAMxuvaw=ZigHsgHf5matsmLrH57y-HE4gwgQy4Oyht4+u58N+g@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 16 Dec 2025 11:53:14 +0200
X-Gm-Features: AQt7F2pFKeaXf-s1mkeH2Q8kl3JJwNmpDg4wcv8FQEvd6Tx2CZncROtpm7NfnSE
Message-ID: <CAPMcbCqSGCk0kmHF+uJjOjES+sKHQHQ-v59iU_q4QqY3TOTGVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga/vss-win32: Fix ConvertStringToBSTR redefinition
 with newer MinGW
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: phind.uet@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f11f0e06460eb24e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--000000000000f11f0e06460eb24e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Dec 16, 2025 at 8:26=E2=80=AFAM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Mon, Dec 15, 2025 at 8:57=E2=80=AFPM <phind.uet@gmail.com> wrote:
>
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
>> _com_util namespace via <comutil.h>. This causes a redefinition
>> error when building qemu-ga on Windows with these toolchains.
>>
>> Add a meson check to detect whether ConvertStringToBSTR is already
>> available, and conditionally compile our fallback implementation
>> only when the system does not provide one.
>>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> ---
>>  meson.build               | 12 ++++++++++++
>>  qga/vss-win32/install.cpp |  2 ++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index c5710a6a47..60a980e610 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3299,6 +3299,18 @@ endif
>>  # Detect host pointer size for the target configuration loop.
>>  host_long_bits =3D cc.sizeof('void *') * 8
>>
>> +# Detect if ConvertStringToBSTR has been defined in _com_util namespace
>> +if host_os =3D=3D 'windows'
>> +  has_convert_string_to_bstr =3D cxx.compiles('''
>> +    #include <comutil.h>
>> +    int main() {
>> +        BSTR b =3D _com_util::ConvertStringToBSTR("test");
>> +        return b ? 0 : 1;
>> +    }
>> +  ''')
>> +  config_host_data.set('CONFIG_CONVERT_STRING_TO_BSTR',
>> has_convert_string_to_bstr)
>> +endif
>> +
>>  ########################
>>  # Target configuration #
>>  ########################
>> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
>> index 7b25d9098b..5b7a8e9bc5 100644
>> --- a/qga/vss-win32/install.cpp
>> +++ b/qga/vss-win32/install.cpp
>> @@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)
>>
>>
>>  /* Support function to convert ASCII string into BSTR (used in _bstr_t)
>> */
>> +#ifndef CONFIG_CONVERT_STRING_TO_BSTR
>>
>
> I wonder if it could check __MINGW64_VERSION_MAJOR >=3D 14 instead of add=
ing
> a configure-time check.
>

@Peter Maydell <peter.maydell@linaro.org> preferred to avoid specific
version-number checks.
See: https://gitlab.com/qemu-project/qemu/-/issues/3217#note_2935451782

I also preferred the idea of checking the real function present instead of
the version of the component.

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>


>
> lgtm anyway
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>  namespace _com_util
>>  {
>>      BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
>> @@ -566,6 +567,7 @@ namespace _com_util
>>          return bstr;
>>      }
>>  }
>> +#endif
>>
>>  /* Stop QGA VSS provider service using Winsvc API  */
>>  STDAPI StopService(void)
>> --
>> 2.43.0
>>
>>

--000000000000f11f0e06460eb24e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 16, 2025 at 8:26=
=E2=80=AFAM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@r=
edhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi<=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Dec 15, 2025 at 8:57=E2=80=AFPM &lt;<a href=3D"mailto:phind.uet@gmai=
l.com" target=3D"_blank">phind.uet@gmail.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">From: Nguyen Dinh Phi &lt;<a hr=
ef=3D"mailto:phind.uet@gmail.com" target=3D"_blank">phind.uet@gmail.com</a>=
&gt;<br>
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
ding a configure-time check.</div></div></div></blockquote><div><br></div><=
div><a class=3D"gmail_plusreply" id=3D"plusReplyChip-1" href=3D"mailto:pete=
r.maydell@linaro.org" tabindex=3D"-1">@Peter Maydell</a>=C2=A0preferred to=
=C2=A0avoid specific version-number checks.=C2=A0</div><div>See: <a href=3D=
"https://gitlab.com/qemu-project/qemu/-/issues/3217#note_2935451782">https:=
//gitlab.com/qemu-project/qemu/-/issues/3217#note_2935451782</a></div><div>=
<br></div><div>I also preferred the idea of checking the real function pres=
ent instead of the version of the component.</div><div><br></div><div>Revie=
wed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkost=
iuk@redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></=
div><div>lgtm anyway</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lure=
au@redhat.com</a>&gt;</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
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
</blockquote></div></div>

--000000000000f11f0e06460eb24e--


