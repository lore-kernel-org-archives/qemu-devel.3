Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D5BC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 21:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPpSJ-0005Td-1y; Thu, 12 Jun 2025 17:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPpSH-0005Sr-CV; Thu, 12 Jun 2025 17:27:25 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPpSF-0005FB-Nv; Thu, 12 Jun 2025 17:27:25 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad8826c05f2so270253766b.3; 
 Thu, 12 Jun 2025 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749763641; x=1750368441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGZv2VAG09mDiRoHHEgf2+bwUAgRb+R+CKa75tyGlTk=;
 b=ladChdKVgCUQmMK8OwrZ0xSw6eNEVduFh2a4d4xIJIHVmi4MjHKJU1bZMo2OFzuSEw
 v5agt1tS4EBTNVgnSZLshLYYv1xbpsm1JOwaI5p6FiXwMJ4/V9MHuVWn/Ehk7kdbOW8a
 h2rG22Ji/zfmOkZltbS9sW9i6qthoZCa9kleaIgzgBe8OkIEJa84GkLDhyngLHVA05Hh
 yiDxlG4uc0QsIBqvPNuSn6XgBFgQR8VDlX+eXCHnoQ176rl8Tf3uE2AiLrs+HE7rr1VT
 RsjOUxxPG81xpLCyy9NWdT1AD2VnX8MXPjMKnlGW5TQJX3vTK9ocPkRtPjUusSh2mWCh
 sjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749763641; x=1750368441;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGZv2VAG09mDiRoHHEgf2+bwUAgRb+R+CKa75tyGlTk=;
 b=RMA6UXtCPItBvyhumb0rToHu3K32JmOnQaVN/6gNxg08BERIZJVaYOjynpuZKgYtKt
 OaKbNJ6DXUzb1AMXU1I/Xt3N4M81DIdIWDjIMETTucpdOQOnk3fdBaHunEtKAQKuFo6e
 2OzXd0vL9XpCnx5R+o0f9wyrH5VMuhBW+pFk216gkFojHCUOmSgEcvR+hLGssIOjJDR4
 s6Mi4dk3Zv8yNN2yZ6IG6+ryfp3SV2gQ0fV6ZxbShSboS5X+zakfLvnXyGQxrnoDaJ+2
 rxVTwPjKe0BrrvwoiVBUarc37Re0NLpdVoTEPQMS/OE48iYDhUwcHHUbDbstlaVrO8ye
 PUqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Edy1RuW5qmNHm12nLqUZ4BpCqCAd+Rp03gT1ixcobsgXoBMrN+iSxne4b8vaZtp2ZLSD6syVz6o=@nongnu.org,
 AJvYcCXMGenmL4Xa9pckjwaTiACwvzkKWxqd9+oB6aJpvV14VbQHtPVglFFNgHah/CyQzqTm/+JsKekO6Q==@nongnu.org
X-Gm-Message-State: AOJu0YzEgAsJ5bf9Kc6hsTASgKGLxfS6R8cZGzBYnU3oRn9w0sdmhURW
 /msfehu8pkpgQp5VB9n3YlpjPXYmHroMpph4teBjTfU+x/XmK/2efokb
X-Gm-Gg: ASbGncvYS1txDVArFd/+AmkERgjhuNZH0KId03X50EH0NTayAVnvdZ4ao/92aYuFZtX
 cSbmJV7lWjtVaatN7hK4jqiQyJCiMmYXIF9mAe1lOWUdJCJFedtwKLPNVtOaOHNs0n7RI4p2ope
 62jBUciMGioWhGHa3RIJyVknsiP4C3z554s7koxeufwQ1k3gd4VLLdGflXXgpLO7Jn8FpG78QhA
 KJymif9SlA2I5O/cJXXociz5lbwz6fvLreCb7pIXx/ks7pUtpCFA4OFmY7QYsewsY3lzHKoVOks
 ys/qcyUfaZS2yLVF5yx/iY4Lc1xf4PxFRLgOkq5KF2kOUAkUTQY19NAVGltcmKeLknmXhzUX24q
 eeBoZ69S0HnuqSYG9MAGvTH9waZfkZcwmeF7BtSyjCcREs9dU7r56C72jEVfSmNuvyANBmA==
X-Google-Smtp-Source: AGHT+IEEl8HJ9Jo/cyEnCAnv3iTy5DoW4nXLFYgamacqqBaaKOjznmliZuy1exI8HSXL5kPakclDcQ==
X-Received: by 2002:a17:907:3f9e:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-adec5cb1aa7mr68440666b.31.1749763641233; 
 Thu, 12 Jun 2025 14:27:21 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2ff0-9b00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:2ff0:9b00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec81bfd69sm23672266b.51.2025.06.12.14.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 14:27:20 -0700 (PDT)
Date: Thu, 12 Jun 2025 21:27:18 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 4/5] configure: Add dtc option
In-Reply-To: <d2860e38-241e-4778-ad9c-7042c73edfd9@redhat.com>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-5-shentey@gmail.com>
 <cdfc561e-23a9-607a-d9a8-70e07e73e0fd@eik.bme.hu>
 <aElCJnmjrB-X9M-n@redhat.com>
 <6eb6aa79-33f8-57ea-5714-af264557f8c8@eik.bme.hu>
 <c29386d1-1a4b-4f3b-a669-4206c366ad9e@redhat.com>
 <d2860e38-241e-4778-ad9c-7042c73edfd9@redhat.com>
Message-ID: <B55C341F-5BDE-45B5-B3F5-2F730EF4586D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 12=2E Juni 2025 05:46:03 UTC schrieb Paolo Bonzini <pbonzini@redhat=2Ec=
om>:
>On 6/12/25 07:12, Paolo Bonzini wrote:
>> I'll send a patch to the upstream dtc project and you can add it to QEM=
U via diff_files (see commit 64644bc4eab2f for an example)=2E
>This is the patch, backported to QEMU's version of the dtc subproject:
>
>diff --git a/libfdt/meson=2Ebuild b/libfdt/meson=2Ebuild
>index 0307ffb=2E=2E6581965 100644
>--- a/libfdt/meson=2Ebuild
>+++ b/libfdt/meson=2Ebuild
>@@ -30,6 +30,7 @@ libfdt_dep =3D declare_dependency(
>   include_directories: libfdt_inc,
>   link_with: libfdt,
> )
>+meson=2Eoverride_dependency('libfdt', libfdt_dep)
>  install_headers(
>   files(
>diff --git a/meson=2Ebuild b/meson=2Ebuild
>index b23ea1b=2E=2E7def0a6 100644
>--- a/meson=2Ebuild
>+++ b/meson=2Ebuild
>@@ -54,6 +54,7 @@ version_gen_h =3D vcs_tag(
>  subdir('libfdt')
> +dtc_tools =3D []
> if get_option('tools')
>   flex =3D find_program('flex', required: true)
>   bison =3D find_program('bison', required: true)
>@@ -77,7 +78,7 @@ if get_option('tools')
>   )
>    if cc=2Echeck_header('fnmatch=2Eh')
>-    executable(
>+    dtc_tools +=3D executable(
>       'convert-dtsv0',
>       [
>         lgen=2Eprocess('convert-dtsv0-lexer=2El'),
>@@ -88,7 +89,7 @@ if get_option('tools')
>     )
>   endif
> -  executable(
>+  dtc_tools +=3D executable(
>     'dtc',
>     [
>       lgen=2Eprocess('dtc-lexer=2El'),
>@@ -108,7 +109,7 @@ if get_option('tools')
>   )
>    foreach e: ['fdtdump', 'fdtget', 'fdtput', 'fdtoverlay']
>-    executable(e, files(e + '=2Ec'), dependencies: util_dep, install: tr=
ue)
>+    dtc_tools +=3D executable(e, files(e + '=2Ec'), dependencies: util_d=
ep, install: true)
>   endforeach
>    install_data(
>@@ -118,6 +119,10 @@ if get_option('tools')
>   )
> endif
> +foreach e: dtc_tools
>+  meson=2Eoverride_find_program(e=2Ename(), e)
>+endforeach
>+
> if not meson=2Eis_cross_build()
>   if py=2Efound() and swig=2Efound()
>     subdir('pylibfdt')
>
>
>and this is how you can then find dtc in QEMU's meson=2Ebuild:
>
>diff --git a/meson=2Ebuild b/meson=2Ebuild
>index 61595015802=2E=2E831678b4580 100644
>--- a/meson=2Ebuild
>+++ b/meson=2Ebuild
>@@ -2121,13 +2121,15 @@ if numa=2Efound() and not cc=2Elinks('''
> endif
>  fdt =3D not_found
>+dtc =3D not_found
> fdt_opt =3D get_option('fdt')
> if fdt_opt =3D=3D 'enabled' and get_option('wrap_mode') =3D=3D 'nodownlo=
ad'
>   fdt_opt =3D 'system'
> endif
> if fdt_opt in ['enabled', 'system'] or (fdt_opt =3D=3D 'auto' and have_s=
ystem)
>   fdt =3D cc=2Efind_library('fdt', required: fdt_opt =3D=3D 'system')
>-  if fdt=2Efound() and cc=2Elinks('''
>+  dtc =3D find_program('dtc', required: fdt_opt =3D=3D 'system')
>+  if dtc=2Efound() and fdt=2Efound() and cc=2Elinks('''
>      #include <libfdt=2Eh>
>      #include <libfdt_env=2Eh>
>      int main(void) { fdt_find_max_phandle(NULL, NULL); return 0; }''',
>@@ -2136,8 +2138,12 @@ if fdt_opt in ['enabled', 'system'] or (fdt_opt =
=3D=3D 'auto' and have_system)
>   elif fdt_opt !=3D 'system'
>     fdt_opt =3D get_option('wrap_mode') =3D=3D 'nodownload' ? 'disabled'=
 : 'internal'
>     fdt =3D not_found
>+    dtc =3D not_found
>   else
>-    error('system libfdt is too old (1=2E5=2E1 or newer required)')
>+    if dtc=2Efound()
>+      error('system libfdt is too old (1=2E5=2E1 or newer required)')
>+    else
>+      error('device tree compiler not found')
>   endif
> endif
> if fdt_opt =3D=3D 'internal'
>@@ -2145,7 +2148,8 @@ if fdt_opt =3D=3D 'internal'
>   libfdt_proj =3D subproject('dtc', required: true,
>                            default_options: ['tools=3Dfalse',  'yaml=3Dd=
isabled',
>                                              'python=3Ddisabled', 'defau=
lt_library=3Dstatic'])
>-  fdt =3D libfdt_proj=2Eget_variable('libfdt_dep')
>+  fdt =3D dependency('libfdt', required: true)
>+  dtc =3D find_program('dtc', required: true)
> endif
>  rdma =3D not_found
>

Thanks Paolo, I'll send a v2=2E

Best regards,
Bernhard

