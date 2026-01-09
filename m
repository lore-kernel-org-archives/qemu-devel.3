Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7650D232EF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve8DK-0003V3-DB; Fri, 09 Jan 2026 03:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ve8DH-0003Uh-1a
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ve8DE-0005R7-77
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767948673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rz3Q17uvPzafEZeM3HadWjGFu58mQq4S3oUrIGR7D1M=;
 b=bZFT6Vy3gbG2DJOytGWu4AkLeNcaBpy9NlsxYyyhxT1rZpMndpvTOp+Fn2YZpnI0Q/7Wm0
 g5vW7tQIaABX2VH2TygTmSLjowTlqILev2XPvPxtm9HZEh4/Wc6eAgjZnc5uer1u3T7fc/
 43cP0uPWEgnCx5JICtIHmlI6BdXP79M=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-dhdIy0jwNWePBP_npU1cTQ-1; Fri, 09 Jan 2026 03:51:11 -0500
X-MC-Unique: dhdIy0jwNWePBP_npU1cTQ-1
X-Mimecast-MFC-AGG-ID: dhdIy0jwNWePBP_npU1cTQ_1767948670
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a0bb1192cbso44431085ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767948670; x=1768553470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rz3Q17uvPzafEZeM3HadWjGFu58mQq4S3oUrIGR7D1M=;
 b=d47sflSGGsmb24NdknoTWetJnxMSkGimTjHlpoc+e+AIK58XKE/QIEAxntrsbIkPHe
 qQSyPyOa7awQXzN7yTRWb8xGVJ2lAHhMnNx1xOB2GrwBm7sM7u9W0CAo3U5DFrX9L04w
 K83qgMvxp1spNmTTHYi7JOS+L3joA7MArRR8tRyoTIGFNP3Pqbj3WL5ESoFWuFYbILGW
 iE4HX2HhVtyOcBfUZur25kxOeWGPFisoGC2e36FTFeIqrnP2HZwyCPEAfKFxpP/tAN00
 JMHEdNff1ZgrIILvrh8GOHwExCypp01EjY0OMR2dNHbCMx9FifKFJIs2qqFREBRwe5KH
 eC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767948670; x=1768553470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rz3Q17uvPzafEZeM3HadWjGFu58mQq4S3oUrIGR7D1M=;
 b=Dq53e7MApd1Jy5LmI9wLKfPlUUbspCRiIzMvhn5ARm1VpeR4DN10RIT6WFtA+Ucbpw
 OhqwAmRQXJEgvgkdTP+Dn3l0lbrnVvCRkEQcI//19qUM3kQe1E6bBFcEy7TOekGvTiM+
 GuxN4bteNAukpN1iyRpgt5F/BRO8/IX/7yQbw7kzc9nUpDYC4OEuPUpiowmU0Ja7KSVD
 rR1mKkDLmWzUzGrx42g5XA0BfMi/vdDcAHwfPiePEAYBLMumQTRBNHj61TYWuOlxM6Eb
 Mq88wwPsa+fp2qKXnhp8YCrHXt1LKnV7F16bGIGlIs+LgFgMj7g+mm0c5z4ukApmWGT0
 MhgQ==
X-Gm-Message-State: AOJu0YyQRKc7w3EgrQbqunkEfHnA756Qe8DOD+DB8Uv8q1pWc3qNgK0R
 u/AJwvvyDddgye4xs4SxIYs1lUY9Y72/cddaDht0W4X/9qDEVQTeomZY3567W2UrThXo3XIabNO
 7Wc2ItspoR5D9WEBqKdtsu8lEnjq6y9PEBiuRHoEfZq834hpIEXZ2H6FBF/fU3tcWf6JOpccegt
 je2udZtTW/6E5ZyAiC+hgBMiwtUTCRWjI=
X-Gm-Gg: AY/fxX5WWxKBfIoeTsk0TxufJTDi8KOSrmnTW3OjWfPkNcJcyqRgXP7VsrJfLl5fD/Z
 k1aZCP0EyBC3DkzVS+wluW3b+yWbaWHsmYLLOJX+SnvHvChtf9TdeGf4PRPboD6um97OrCq1+gM
 KNCkzkBHSDS4J/ZH3BmSeSHuZbk+wF7EOqS0kL5ARwxGZymXMVu3MFWCC1caVCuIcm+Pur94GE1
 HyOY65n7p5pQ8vfucTISRa/bw==
X-Received: by 2002:a17:902:e84b:b0:2a0:bb0a:a5dd with SMTP id
 d9443c01a7336-2a3ee4f3880mr97377355ad.57.1767948670367; 
 Fri, 09 Jan 2026 00:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ7A6gjS1McjzWW/pB5gb4V7ex/K8Wr4kZDmmLRQYqRdWMdCcwRHksdSxj8MUTrZbhlFgRUmboeDvU02w8uRU=
X-Received: by 2002:a17:902:e84b:b0:2a0:bb0a:a5dd with SMTP id
 d9443c01a7336-2a3ee4f3880mr97377035ad.57.1767948669900; Fri, 09 Jan 2026
 00:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20260108161220.15146-1-philmd@linaro.org>
 <20260108161220.15146-5-philmd@linaro.org>
In-Reply-To: <20260108161220.15146-5-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 9 Jan 2026 12:50:57 +0400
X-Gm-Features: AQt7F2p5QZ8bR9r8oUwoalOJqrK7deaxfntxVg2vXaqKOGFpRfhBI_ObMXOp1dM
Message-ID: <CAMxuvazRztSC-buX=MEm=UbG55qGyqgAdyzbVvow9eM4h13x1A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dump: Build stubs once for non-x86 targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000736a5a0647f0a0eb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

--000000000000736a5a0647f0a0eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jan 8, 2026 at 8:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Rather than compiling the same content for all targets (unused
> most of the time, i.e. qemu-system-avr ...), extract the non
> x86 specific parts to a stub file and build it once for all
> non-x86 targets.
> Add a Kconfig symbol to only select the target-specific file
> with the x86 target (rename this file with '-x86' suffix).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  dump/win_dump-stubs.c               | 21 +++++++++++++++++++++
>  dump/{win_dump.c =3D> win_dump-x86.c} | 20 +-------------------
>  Kconfig                             |  1 +
>  dump/Kconfig                        |  4 ++++
>  dump/meson.build                    |  3 ++-
>  5 files changed, 29 insertions(+), 20 deletions(-)
>  create mode 100644 dump/win_dump-stubs.c
>  rename dump/{win_dump.c =3D> win_dump-x86.c} (97%)
>  create mode 100644 dump/Kconfig
>
> diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c
> new file mode 100644
> index 00000000000..07d1a0c5ea9
> --- /dev/null
> +++ b/dump/win_dump-stubs.c
> @@ -0,0 +1,21 @@
> +/*
> + * Windows crashdump stubs
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "win_dump.h"
> +
> +bool win_dump_available(DumpState *s, Error **errp)
> +{
> +    error_setg(errp, "x86-64 Windows guest dump not built-in");
> +
> +    return false;
> +}
> +
> +void create_win_dump(DumpState *s, Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/dump/win_dump.c b/dump/win_dump-x86.c
> similarity index 97%
> rename from dump/win_dump.c
> rename to dump/win_dump-x86.c
> index e5fdc12ad34..4f8bcc356fc 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump-x86.c
> @@ -1,5 +1,5 @@
>  /*
> - * Windows crashdump (target specific implementations)
> + * Windows crashdump (x86 specific implementations)
>   *
>   * Copyright (c) 2018 Virtuozzo International GmbH
>   *
> @@ -18,8 +18,6 @@
>  #include "win_dump.h"
>  #include "cpu.h"
>
> -#if defined(TARGET_X86_64)
> -
>  static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);
>
>  bool win_dump_available(DumpState *s, Error **errp)
> @@ -494,19 +492,3 @@ out_free:
>  out_cr3:
>      first_x86_cpu->env.cr[3] =3D saved_cr3;
>  }
> -
> -#else /* !TARGET_X86_64 */
> -
> -bool win_dump_available(DumpState *s, Error **errp)
> -{
> -    error_setg(errp, "Windows dump is only available for x86-64");
> -
> -    return false;
> -}
> -
> -void create_win_dump(DumpState *s, Error **errp)
> -{
> -    g_assert_not_reached();
> -}
> -
> -#endif
> diff --git a/Kconfig b/Kconfig
> index 63ca7f46df7..26388c12838 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -1,6 +1,7 @@
>  source Kconfig.host
>  source backends/Kconfig
>  source accel/Kconfig
> +source dump/Kconfig
>  source target/Kconfig
>  source hw/Kconfig
>  source semihosting/Kconfig
> diff --git a/dump/Kconfig b/dump/Kconfig
> new file mode 100644
> index 00000000000..99f99ff4a4f
> --- /dev/null
> +++ b/dump/Kconfig
> @@ -0,0 +1,4 @@
> +config WINDUMP
> +    bool
> +    default y if I386
> +    depends on I386
> diff --git a/dump/meson.build b/dump/meson.build
> index 4277ce9328a..26e1561ed48 100644
> --- a/dump/meson.build
> +++ b/dump/meson.build
> @@ -1,2 +1,3 @@
>  system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
> -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c')=
)
> +specific_ss.add(when: 'CONFIG_WINDUMP', if_true: files('win_dump-x86.c')=
)
>

I thought this could end up in qemu-user, but apparently I was wrong..

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> +system_ss.add(when: 'CONFIG_WINDUMP', if_false: files('win_dump-stubs.c'=
))
> --
> 2.52.0
>
>

--000000000000736a5a0647f0a0eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 8, 20=
26 at 8:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:phi=
lmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Rather than compiling the same content for=
 all targets (unused<br>
most of the time, i.e. qemu-system-avr ...), extract the non<br>
x86 specific parts to a stub file and build it once for all<br>
non-x86 targets.<br>
Add a Kconfig symbol to only select the target-specific file<br>
with the x86 target (rename this file with &#39;-x86&#39; suffix).<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0dump/win_dump-stubs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 21 +++++++++++++++++++++<br>
=C2=A0dump/{win_dump.c =3D&gt; win_dump-x86.c} | 20 +-------------------<br=
>
=C2=A0Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0dump/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++++<br>
=C2=A0dump/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A05 files changed, 29 insertions(+), 20 deletions(-)<br>
=C2=A0create mode 100644 dump/win_dump-stubs.c<br>
=C2=A0rename dump/{win_dump.c =3D&gt; win_dump-x86.c} (97%)<br>
=C2=A0create mode 100644 dump/Kconfig<br>
<br>
diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c<br>
new file mode 100644<br>
index 00000000000..07d1a0c5ea9<br>
--- /dev/null<br>
+++ b/dump/win_dump-stubs.c<br>
@@ -0,0 +1,21 @@<br>
+/*<br>
+ * Windows crashdump stubs<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;win_dump.h&quot;<br>
+<br>
+bool win_dump_available(DumpState *s, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, &quot;x86-64 Windows guest dump not built-i=
n&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+void create_win_dump(DumpState *s, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert_not_reached();<br>
+}<br>
diff --git a/dump/win_dump.c b/dump/win_dump-x86.c<br>
similarity index 97%<br>
rename from dump/win_dump.c<br>
rename to dump/win_dump-x86.c<br>
index e5fdc12ad34..4f8bcc356fc 100644<br>
--- a/dump/win_dump.c<br>
+++ b/dump/win_dump-x86.c<br>
@@ -1,5 +1,5 @@<br>
=C2=A0/*<br>
- * Windows crashdump (target specific implementations)<br>
+ * Windows crashdump (x86 specific implementations)<br>
=C2=A0 *<br>
=C2=A0 * Copyright (c) 2018 Virtuozzo International GmbH<br>
=C2=A0 *<br>
@@ -18,8 +18,6 @@<br>
=C2=A0#include &quot;win_dump.h&quot;<br>
=C2=A0#include &quot;cpu.h&quot;<br>
<br>
-#if defined(TARGET_X86_64)<br>
-<br>
=C2=A0static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);<=
br>
<br>
=C2=A0bool win_dump_available(DumpState *s, Error **errp)<br>
@@ -494,19 +492,3 @@ out_free:<br>
=C2=A0out_cr3:<br>
=C2=A0 =C2=A0 =C2=A0first_x86_cpu-&gt;<a href=3D"http://env.cr" rel=3D"nore=
ferrer" target=3D"_blank">env.cr</a>[3] =3D saved_cr3;<br>
=C2=A0}<br>
-<br>
-#else /* !TARGET_X86_64 */<br>
-<br>
-bool win_dump_available(DumpState *s, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 error_setg(errp, &quot;Windows dump is only available for x8=
6-64&quot;);<br>
-<br>
-=C2=A0 =C2=A0 return false;<br>
-}<br>
-<br>
-void create_win_dump(DumpState *s, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
-}<br>
-<br>
-#endif<br>
diff --git a/Kconfig b/Kconfig<br>
index 63ca7f46df7..26388c12838 100644<br>
--- a/Kconfig<br>
+++ b/Kconfig<br>
@@ -1,6 +1,7 @@<br>
=C2=A0source Kconfig.host<br>
=C2=A0source backends/Kconfig<br>
=C2=A0source accel/Kconfig<br>
+source dump/Kconfig<br>
=C2=A0source target/Kconfig<br>
=C2=A0source hw/Kconfig<br>
=C2=A0source semihosting/Kconfig<br>
diff --git a/dump/Kconfig b/dump/Kconfig<br>
new file mode 100644<br>
index 00000000000..99f99ff4a4f<br>
--- /dev/null<br>
+++ b/dump/Kconfig<br>
@@ -0,0 +1,4 @@<br>
+config WINDUMP<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 default y if I386<br>
+=C2=A0 =C2=A0 depends on I386<br>
diff --git a/dump/meson.build b/dump/meson.build<br>
index 4277ce9328a..26e1561ed48 100644<br>
--- a/dump/meson.build<br>
+++ b/dump/meson.build<br>
@@ -1,2 +1,3 @@<br>
=C2=A0system_ss.add([files(&#39;dump.c&#39;, &#39;dump-hmp-cmds.c&#39;), sn=
appy, lzo])<br>
-specific_ss.add(when: &#39;CONFIG_SYSTEM_ONLY&#39;, if_true: files(&#39;wi=
n_dump.c&#39;))<br>
+specific_ss.add(when: &#39;CONFIG_WINDUMP&#39;, if_true: files(&#39;win_du=
mp-x86.c&#39;))<br></blockquote><div><br></div><div>I thought this could en=
d up in qemu-user, but apparently I was wrong..</div><div><br></div><div>Re=
viewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+system_ss.add(when: &#39;CONFIG_WINDUMP&#39;, if_false: files(&#39;win_dum=
p-stubs.c&#39;))<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div>

--000000000000736a5a0647f0a0eb--


