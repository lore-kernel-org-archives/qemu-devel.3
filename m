Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9411C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x13pJ-0001va-V9; Mon, 31 Aug 2026 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x13pI-0001vS-Ra
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 11:21:36 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x13pF-0004T7-D1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 11:21:36 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so449677866b.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 08:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788189691; cv=none;
 d=google.com; s=arc-20260327;
 b=Vww/78W5TucxHYWHRd5460fhjPOHe5VPP0QutiKHTT+U5M6Hh1oRlISj15xp+0X+24
 1/RobtVqwhLdCTvYcjt36iT7QS2ZgwQFEF4gKq9fnjhEvnB+Wur74tiMxCI7Br/Xg67T
 pAeXzLHiTV9jqXsEZPNShOM2J7wwIoYhhV5A/H9r+1iPT7rVL0vQH3pVpgrXifMqprhR
 bSRAGxyEHM1f9HsOGGcW5K/mbSeHVkUGkvYMDzvE6IMPcJ6TZsvEqV5PVq20qvvFbGy1
 QmpgP6WwpszthOE0qJFa/zAJxbfbsLtWRmXX1godKWsTmGl25yE9yAV7Wv/vJChA1okC
 yrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RiWDeMWZjDTB9sF3reKgzO1rXFPnwfrqjlBIhK/sM2w=;
 fh=dLrxXhNFLYOe0h//qW0yf246b4AxzSerEDHU468ijm8=;
 b=PL97oveDqUViVw6tHkYVyalFKJ1plW/BoJpi2Bisx2ZMdV5coOhELdrX3lRje/BxQE
 cf4WhDn2DloK0DIqW2kISzi6wD8MKQETkbEZgby/G1YjPNLBpVS/tRfRe+8E0D8kKJR5
 IBun8rkX5V3cgtfim4uUGxoJ+7W8gbAnN+D1F6QMKyIMWr1XkkHH6WwnOAjtm1TULaFO
 S9LJrHx3y5DGGpHgpAeUBuvcAzw1ipM4hRkXshgyvmwEltv4A+mHAGUGRxJOauOvvqfV
 cKbefGEQ0xI23GD/0rQHYqnhNoByS2N/vh5umsl6S7Aeqwjp+amE4oaxmwWKRRg++2B7
 qXww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788189691; x=1788794491; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RiWDeMWZjDTB9sF3reKgzO1rXFPnwfrqjlBIhK/sM2w=;
 b=RBx//PUg/WtL/OvYix4z1RKPQo+h8lZUfuq35vzWw5cDalBbsjKqfDiYf2bXCFD4fM
 jci/8Yn08n34ZH9wPxnhqsHHi/G46TgIrJVopzbICPYGYNjfp0rKGeZXzXj4FH6/yGd5
 P2Y4EVHqUk3euD0VAsYginQ3TkD3JeY/dAkKeSl0MJHAwncjnSL/b+2LWr0xmDyNsjIF
 YG18GEWggobSOCoFSOnTFbODFN5NhJVBPPHOE5mwjPcBYrSKsaw2ao4Y5HW+T80Ds/F5
 JUAp61KOu90VacJm6DjNBbWilJE0wDZ0oxsA7W0JlFujX6y5ydx1TRGGQobevMH4osDa
 xoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788189691; x=1788794491;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RiWDeMWZjDTB9sF3reKgzO1rXFPnwfrqjlBIhK/sM2w=;
 b=klobWXd++/lPBQDMBFTBdsWNDOyhlJPsHXCnb8lwho0O8fzDIQY/Ts0pPbj/TGJdub
 OD3RO1oKH8JcWguGXmD+gUOnyhi7wv7VYzk1vXnRAIo20vBi82Mya6p3ELziMK7HjR6c
 XyCF8QAXG+iLkj7iyLItWoxC3CDKK3qbLvNW4JvN4aHoETOgpUp8E8F77ho6+Z5RSTpq
 d8hSfkCGtjVyuXYzOrnnGHsHM0mvR2d+rdMc/+GtC5XskPr2pkUGtOm4DUysxBmM2vrY
 O3oWLKqd1Zg+ZsUmxG6+RDIA6lbFdMRQXJmY0IcZ69z+uJ90/Rk8RMyTiWmvDdoGtILy
 TMLw==
X-Gm-Message-State: AFuF++kJhw9fOHW/yjmdZm7Zw2WJzlLQkJ31SgkXqs6FCIO0E3uqOLH4
 3T7UpN5Tn2kNGoMVdjvA1m85QsjMdpHiyzupf5MJmG693elbgAvCLkMNpng1eyqShvcpcZvrxpG
 oJDY7/3yz+69K/Y/c9LsqgcJb+UX9XN8=
X-Gm-Gg: AR+sD11Br5djBUIOe7EyKxA7+whcYy9qMKHg4EwDR7WkE+wT3d4jZptsBEktsfRWxpD
 LLF3il9CTyqOyqM6f+GEeEXAWv/nk6CaajVKWAd1e2VEhZ65aOql79KuRANaj4e1WP/KHbhIhV5
 WR4ySEY5AIWO1bHlJVTUyRukjJVMYVw8K+j3HD3vSfPxBRze6a3sPDUgHdXhr6x1XLUsbTB4QfJ
 bNCV/EN3qYsm0JHqj2UQDkHxugr+gW+tgASHwH/uAbAV2GCBVzUVVQD9bnLkP0pr0Ica0Lq5aUq
 PZzz8iP1TOXcdt4RVQFiLSRmAoFuQ64ReNrmc6goSzaW
X-Received: by 2002:a17:906:f58d:b0:c20:f913:9337 with SMTP id
 a640c23a62f3a-c25571cc627mr1759825866b.20.1788189690359; Mon, 31 Aug 2026
 08:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-36-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-36-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 31 Aug 2026 23:21:17 +0800
X-Gm-Features: AcwNN1WrYaQEqQotVwRVy7F8rAzx7RD6xkkNOrLM2q4ZJ6es5lEy4bngGvN_aFM
Message-ID: <CAE2XoE9JF6eY08oRJ4qxQTn=u4bQ61vtWN-1Eyi5DpbsChdczw@mail.gmail.com>
Subject: Re: [PATCH 35/47] meson: build single binary for arm+aarch64 targets
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, anjo@rev.ng, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000492afc065a595b91"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000492afc065a595b91
Content-Type: multipart/alternative; boundary="000000000000492afa065a595b8f"

--000000000000492afa065a595b8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 7:03=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Build with: ninja -C build qemu-system
> This is not built by default.
>
> All available *-softmmu targets are aggregated, ./configure
> --target-list can be used to restrict which targets are included.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 8023da4a147..9cf441382d3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4250,6 +4250,16 @@ if host_os =3D=3D 'darwin'
>  endif
>
>  traceable =3D []
> +single_binary_libs =3D []
> +single_binary_deps =3D []
> +single_binary_crates =3D []
> +single_binary_available =3D false
> +
> +single_binary_supported_targets =3D [
> +  'aarch64-softmmu',
> +  'arm-softmmu',
> +]
> +
>  emulators =3D {}
>  foreach target : target_dirs
>    config_target =3D config_target_mak[target]
> @@ -4402,6 +4412,13 @@ foreach target : target_dirs
>                   build_by_default: false)
>
>    if target.endswith('-softmmu')
> +    if target in single_binary_supported_targets
> +      single_binary_libs +=3D lib
> +      single_binary_deps +=3D arch_deps
> +      single_binary_deps +=3D target_stubs
> +      single_binary_crates +=3D main_rs
> +      single_binary_available =3D true
> +    endif
>      execs =3D [{
>        'name': 'qemu-system-' + target_name,
>        'win_subsystem': 'console',
> @@ -4483,6 +4500,33 @@ foreach target : target_dirs
>    endforeach
>  endforeach
>
> +single_binary_objects =3D []
> +foreach lib: single_binary_libs
> +  single_binary_objects +=3D lib.extract_all_objects(recursive: true)
> +endforeach
> +
> +single_binary_link_args =3D emulator_link_args
> +single_binary_link_args +=3D enable_modules ? ['@block.syms',
'@qemu.syms'] : []
> +
> +if single_binary_available
> +  executable('qemu-system',
> +             sources: [single_binary_crates, files('system/main.c')],
> +             dependencies: single_binary_deps,
> +             objects: single_binary_objects,
> +             link_depends: [block_syms, qemu_syms],
> +             link_args: single_binary_link_args,
> +             build_by_default: false)

A. better assign executable to qemu_system. so it can be tested.
Maybe a simple test is better.
B. single_binary_available should be a meson option, maybe
single_binary_enabled, and disabled by default maybe... don't know which is
better.
as it's still experiential

The patch to squash is attached.



> +else
> +  error_str =3D f'''qemu-system only support targets:
> +@single_binary_supported_targets@
> +
> +use ./configure --target-list=3D to choose at least one of them'''
> +  t =3D custom_target(command: ['sh', '-c', 'echo "' + error_str + '" &&
exit 1'],
> +                    output: 'none',
> +                    build_by_default: false)
> +  alias_target('qemu-system', t)
> +endif
> +
>  # Other build targets
>
>  if get_option('plugins')
> --
> 2.43.0
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000492afa065a595b8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Aug 29, 2026 at 7:03=E2=80=AFAM Pierrick B=
ouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bo=
uvier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; Build with: ninja -C =
build qemu-system<br>&gt; This is not built by default.<br>&gt;<br>&gt; All=
 available *-softmmu targets are aggregated, ./configure<br>&gt; --target-l=
ist can be used to restrict which targets are included.<br>&gt;<br>&gt; Sig=
ned-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qua=
lcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>&gt; ---<br>&gt; =
=C2=A0meson.build | 44 ++++++++++++++++++++++++++++++++++++++++++++<br>&gt;=
 =C2=A01 file changed, 44 insertions(+)<br>&gt;<br>&gt; diff --git a/meson.=
build b/meson.build<br>&gt; index 8023da4a147..9cf441382d3 100644<br>&gt; -=
-- a/meson.build<br>&gt; +++ b/meson.build<br>&gt; @@ -4250,6 +4250,16 @@ i=
f host_os =3D=3D &#39;darwin&#39;<br>&gt; =C2=A0endif<br>&gt;<br>&gt; =C2=
=A0traceable =3D []<br>&gt; +single_binary_libs =3D []<br>&gt; +single_bina=
ry_deps =3D []<br>&gt; +single_binary_crates =3D []<br>&gt; +single_binary_=
available =3D false<br>&gt; +<br>&gt; +single_binary_supported_targets =3D =
[<br>&gt; + =C2=A0&#39;aarch64-softmmu&#39;,<br>&gt; + =C2=A0&#39;arm-softm=
mu&#39;,<br>&gt; +]<br>&gt; +<br>&gt; =C2=A0emulators =3D {}<br>&gt; =C2=A0=
foreach target : target_dirs<br>&gt; =C2=A0 =C2=A0config_target =3D config_=
target_mak[target]<br>&gt; @@ -4402,6 +4412,13 @@ foreach target : target_d=
irs<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
build_by_default: false)<br>&gt;<br>&gt; =C2=A0 =C2=A0if target.endswith(&#=
39;-softmmu&#39;)<br>&gt; + =C2=A0 =C2=A0if target in single_binary_support=
ed_targets<br>&gt; + =C2=A0 =C2=A0 =C2=A0single_binary_libs +=3D lib<br>&gt=
; + =C2=A0 =C2=A0 =C2=A0single_binary_deps +=3D arch_deps<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0single_binary_deps +=3D target_stubs<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0single_binary_crates +=3D main_rs<br>&gt; + =C2=A0 =C2=A0 =C2=A0singl=
e_binary_available =3D true<br>&gt; + =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=
=A0 =C2=A0execs =3D [{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;name&#39;: &=
#39;qemu-system-&#39; + target_name,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0&#3=
9;win_subsystem&#39;: &#39;console&#39;,<br>&gt; @@ -4483,6 +4500,33 @@ for=
each target : target_dirs<br>&gt; =C2=A0 =C2=A0endforeach<br>&gt; =C2=A0end=
foreach<br>&gt;<br>&gt; +single_binary_objects =3D []<br>&gt; +foreach lib:=
 single_binary_libs<br>&gt; + =C2=A0single_binary_objects +=3D lib.extract_=
all_objects(recursive: true)<br>&gt; +endforeach<br>&gt; +<br>&gt; +single_=
binary_link_args =3D emulator_link_args<br>&gt; +single_binary_link_args +=
=3D enable_modules ? [&#39;@block.syms&#39;, &#39;@qemu.syms&#39;] : []<br>=
&gt; +<br>&gt; +if single_binary_available<br>&gt; + =C2=A0executable(&#39;=
qemu-system&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sourc=
es: [single_binary_crates, files(&#39;system/main.c&#39;)],<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: single_binary_deps,<br=
>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 objects: single_binary_ob=
jects,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_depends: [b=
lock_syms, qemu_syms],<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
link_args: single_binary_link_args,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 build_by_default: false)<br><br>A. better assign executable t=
o qemu_system. so it can be tested.<br>Maybe a simple test is better.<br>B.=
 single_binary_available should be a meson option, maybe single_binary_enab=
led, and disabled by default maybe... don&#39;t know which is better.<br>as=
 it&#39;s still experiential<br><br>The patch to squash is attached.<div><b=
r></div><div><br><br>&gt; +else<br>&gt; + =C2=A0error_str =3D f&#39;&#39;&#=
39;qemu-system only support targets:<br>&gt; +@single_binary_supported_targ=
ets@<br>&gt; +<br>&gt; +use ./configure --target-list=3D to choose at least=
 one of them&#39;&#39;&#39;<br>&gt; + =C2=A0t =3D custom_target(command: [&=
#39;sh&#39;, &#39;-c&#39;, &#39;echo &quot;&#39; + error_str + &#39;&quot; =
&amp;&amp; exit 1&#39;],<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: &#39;none&#39;,<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_by_default=
: false)<br>&gt; + =C2=A0alias_target(&#39;qemu-system&#39;, t)<br>&gt; +en=
dif<br>&gt; +<br>&gt; =C2=A0# Other build targets<br>&gt;<br>&gt; =C2=A0if =
get_option(&#39;plugins&#39;)<br>&gt; --<br>&gt; 2.43.0<br>&gt;<br>&gt;<br>=
<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo</div></div>

--000000000000492afa065a595b8f--

--000000000000492afc065a595b91
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-meson-keep-qemu-system-executable-for-tests.patch"
Content-Disposition: attachment; 
	filename="0001-meson-keep-qemu-system-executable-for-tests.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mthdyipd0>
X-Attachment-Id: f_mthdyipd0

RnJvbSBiZWQ0ODM5OTE1NWIyMmVmMTQzZjdmYTBlZjcxMTEzODEwZjU5MmQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb25nZ2FuZyBMdW8gPGx1b3lvbmdnYW5nQGdtYWlsLmNvbT4K
RGF0ZTogTW9uLCAzMSBBdWcgMjAyNiAyMzoxNzowMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIG1l
c29uOiBrZWVwIHFlbXUtc3lzdGVtIGV4ZWN1dGFibGUgZm9yIHRlc3RzCgotIEFzc2lnbiB0aGUg
Y29tYmluZWQgcWVtdS1zeXN0ZW0gdGFyZ2V0IHRvIHFlbXVfc3lzdGVtIHNvIHF0ZXN0cyBjYW4K
ICBkZXBlbmQgb24gaXQuCi0gQWxpZ24gZXhlY3V0YWJsZSgpIGt3YXJncyB3aXRoIHRoZSBhc3Np
Z25tZW50LgotLS0KIG1lc29uLmJ1aWxkIHwgMTQgKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbWVzb24u
YnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCA5YjlmNzI3MTE5Li5kMjk1YzkxZjJjIDEwMDY0NAot
LS0gYS9tZXNvbi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAtNDUxMCwxMyArNDUxMCwxMyBA
QCBzaW5nbGVfYmluYXJ5X2xpbmtfYXJncyA9IGVtdWxhdG9yX2xpbmtfYXJncwogc2luZ2xlX2Jp
bmFyeV9saW5rX2FyZ3MgKz0gZW5hYmxlX21vZHVsZXMgPyBbJ0BibG9jay5zeW1zJywgJ0BxZW11
LnN5bXMnXSA6IFtdCiAKIGlmIHNpbmdsZV9iaW5hcnlfYXZhaWxhYmxlCi0gIGV4ZWN1dGFibGUo
J3FlbXUtc3lzdGVtJywKLSAgICAgICAgICAgICBzb3VyY2VzOiBbc2luZ2xlX2JpbmFyeV9jcmF0
ZXMsIGZpbGVzKCdzeXN0ZW0vbWFpbi5jJyldLAotICAgICAgICAgICAgIGRlcGVuZGVuY2llczog
c2luZ2xlX2JpbmFyeV9kZXBzLAotICAgICAgICAgICAgIG9iamVjdHM6IHNpbmdsZV9iaW5hcnlf
b2JqZWN0cywKLSAgICAgICAgICAgICBsaW5rX2RlcGVuZHM6IFtibG9ja19zeW1zLCBxZW11X3N5
bXNdLAotICAgICAgICAgICAgIGxpbmtfYXJnczogc2luZ2xlX2JpbmFyeV9saW5rX2FyZ3MsCi0g
ICAgICAgICAgICAgYnVpbGRfYnlfZGVmYXVsdDogZmFsc2UpCisgIHFlbXVfc3lzdGVtID0gZXhl
Y3V0YWJsZSgncWVtdS1zeXN0ZW0nLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgc291cmNl
czogW3NpbmdsZV9iaW5hcnlfY3JhdGVzLCBmaWxlcygnc3lzdGVtL21haW4uYycpXSwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRlcGVuZGVuY2llczogc2luZ2xlX2JpbmFyeV9kZXBzLAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb2JqZWN0czogc2luZ2xlX2JpbmFyeV9vYmplY3Rz
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlua19kZXBlbmRzOiBbYmxvY2tfc3ltcywg
cWVtdV9zeW1zXSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbmtfYXJnczogc2luZ2xl
X2JpbmFyeV9saW5rX2FyZ3MsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBidWlsZF9ieV9k
ZWZhdWx0OiBmYWxzZSkKIGVsc2UKICAgZXJyb3Jfc3RyID0gZicnJ3FlbXUtc3lzdGVtIG9ubHkg
c3VwcG9ydCB0YXJnZXRzOgogQHNpbmdsZV9iaW5hcnlfc3VwcG9ydGVkX3RhcmdldHNACi0tIAoy
LjUyLjAud2luZG93cy4xCgo=
--000000000000492afc065a595b91--

