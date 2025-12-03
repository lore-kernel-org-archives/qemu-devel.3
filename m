Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4389D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjEN-0007J8-Co; Wed, 03 Dec 2025 04:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQjEM-0007Ir-Aq
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQjEJ-00069U-EL
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764754376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IU6O/j9pijizxYYonNQSq8wKlMZZUkUo8gXMMn/6+q0=;
 b=LUZwBDnDYZD1jPdFr7u1PjNlXXfDWEUiTxciEWsoMkJMj2xEZYqh5jLz8efFGULyaQPP79
 HM4PVa7Zjo5WSDIS3j30hyeti20HfGX/u/QR0VscX+vc6pmqEK4Kr5kSsUe5SSEtq2Om1h
 B5oKv1whDof3GM8ytwxhblnWwl0XxAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-K2Jc9rlVN_ubpL27jCU0vg-1; Wed, 03 Dec 2025 04:32:54 -0500
X-MC-Unique: K2Jc9rlVN_ubpL27jCU0vg-1
X-Mimecast-MFC-AGG-ID: K2Jc9rlVN_ubpL27jCU0vg_1764754373
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47777158a85so57038685e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764754373; x=1765359173; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IU6O/j9pijizxYYonNQSq8wKlMZZUkUo8gXMMn/6+q0=;
 b=MrMeOclwf+RUcV/2bJuLHlId4hnfkg9Zqdg25F+//YGEexIWQ+gsHlPuakZiT1k1Xf
 qW7W9BGCyZ5Dt5F5CNP9znZtZTqq3Cg6VMdhVtahjw7t8B/mJKOH2Xx5u3EJ1SK9Pv0T
 vXP4ip4y4XE/PSiugX7wR1A59ReOytnDwwR20fFQbmyYrILYnYiemWygJvLPfCdePdE2
 zjmB/IaBr3YPq6cr3MUyJ/tVv+JOXkyWuXdqUBdq1fAXtCk6AXZ2Y6lqjHNhkEJKa3B3
 mIpQQ9W0x0L2klT+j4Sqm3UTsURXHY2GXyVSUyD4eJ0fSkUQtHimuRE6m7hDpSen9H46
 tlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764754373; x=1765359173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IU6O/j9pijizxYYonNQSq8wKlMZZUkUo8gXMMn/6+q0=;
 b=hKRql1PhGYgLg63BKlabeIGEGwaIJE4MzI0AymOhHWiMT+Kv4AakVgS/BU0s9lGu6z
 XTWFjX3kh2pe95Ur/XR2F9Gl8sZYG6/+CkCowGg39+WPSueY3TcQxF6mZUh2vFOq3Zrn
 I2BXdsX5ywrP7zGEFWXo66WySN1z3C2Pvf6fOYedzubj6nSg0Dtqf1xWLENkFeRnukhK
 W00b6Lm/+BL/JfYzapwyAAm98tJkUtanBZMXlgjrL3lo5oyxCS2RtEDAL6pY9Vu1xSY9
 4T9EjnaLXq5ZC32dbmHERtZLCY3qdyAowEKZ+e4db3mKa3c+p56KAnZV4QRzIsfAPoLz
 tFdw==
X-Gm-Message-State: AOJu0YzMorOE8gA90GOvi/OtP2FDJvJuH5R9g8soi1GDJPp3+4t8Fn8s
 vljMGPngv/3xU4nSdXQ44zmvKCYvlyTjzGSIUTC9yz3Vy5I15z6iebvyaOq4DAAYLE4ihIyPejm
 wXEgDHbUULkpM66HkfLOTUvWIMWkrUi+UIkm0AcVdDAkPTOR72hlEObLHrFJNfvHf6PwMHH3geS
 eFeyXhCyCDIrA19mcWi9bLcxgVWuoWY42AF/ywTsM=
X-Gm-Gg: ASbGncsJLCFNUCazVH1Kj4WvIEC92Ba++f+Men2/+eeLUrfAQjPqsKbkEC0PyU22e9N
 V0Q2oYtWJhDa1BLvLpZlTuTGVv20Cf1XtahkR1o7sNcDTD4iErGn3hIjTpa2Ukl0YQnLbFg0z2C
 hjM7CGqdoXUdo3E218/cLqKIk0hn9KrqoRFDp6SQgNlgdrrNjES3oiPMJu8GZCKPdrzxpsxxJTY
 ku0JRcW/MXrdIA/1cYjRPYCguOwz1k9FBiHiXiUNew78x5qdwFOL4nc2xABQ+ddBorRqn8=
X-Received: by 2002:a05:600c:1d0e:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-4792af321b8mr15415195e9.20.1764754373140; 
 Wed, 03 Dec 2025 01:32:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVhCwMiTUlGdMc2/WP4XQSOIv0Ud8/RtzZ6Qt6auRMQD9z9QXc9F+2TQha59ja9dpEEENggdorDEKo3kemkbI=
X-Received: by 2002:a05:600c:1d0e:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-4792af321b8mr15414785e9.20.1764754372525; Wed, 03 Dec 2025
 01:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20251127132036.84384-1-pbonzini@redhat.com>
 <20251127132036.84384-10-pbonzini@redhat.com>
In-Reply-To: <20251127132036.84384-10-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 3 Dec 2025 10:32:41 +0100
X-Gm-Features: AWmQ_bkJQlNhPW6D0ZzkS33aGdrbqV_cwaztpJghnEAIR2_f0fEpAOKHaoRMXgU
Message-ID: <CABgObfaQouR4Jc20XM+LT0m0O7agBGtWU_WVuAcO-bQt-hpezA@mail.gmail.com>
Subject: Re: [PATCH 9/9] rust: only link the Rust part of the code into devices
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007d9258064508e574"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000007d9258064508e574
Content-Type: text/plain; charset="UTF-8"

Turns out these last two patches only work with unreleased Meson. I will
put everything into a testable series once 1.10 is out (should be soon,
it's already at rc2).

Paolo

Il gio 27 nov 2025, 14:20 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> Do not include libqemuutil in the device crates for the same
> reason as in the previous commit.  Static libraries like qemuutil
> are sensitive to their position on the command line and rustc does not
> always get it right.
>
> If rustc places the library too early on the command line, the stubs
> are included in the final link product, which results in duplicate
> symbols.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/meson.build | 18 ++++++++++--------
>  rust/hw/timer/hpet/meson.build | 16 ++++++++--------
>  2 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/rust/hw/char/pl011/meson.build
> b/rust/hw/char/pl011/meson.build
> index 33b91f21911..9c0e8290e9a 100644
> --- a/rust/hw/char/pl011/meson.build
> +++ b/rust/hw/char/pl011/meson.build
> @@ -28,20 +28,22 @@ _libpl011_rs = static_library(
>    ),
>    override_options: ['rust_std=2021', 'build.rust_std=2021'],
>    rust_abi: 'rust',
> +  link_with: [
> +    _util_rs,
> +    _migration_rs,
> +    _bql_rs,
> +    _qom_rs,
> +    _chardev_rs,
> +    _system_rs,
> +    _hwcore_rs,
> +    _trace_rs
> +  ],
>    dependencies: [
>      bilge_rs,
>      bilge_impl_rs,
>      bits_rs,
>      common_rs,
>      glib_sys_rs,
> -    util_rs,
> -    migration_rs,
> -    bql_rs,
> -    qom_rs,
> -    chardev_rs,
> -    system_rs,
> -    hwcore_rs,
> -    trace_rs
>    ],
>  )
>
> diff --git a/rust/hw/timer/hpet/meson.build
> b/rust/hw/timer/hpet/meson.build
> index bb64b96672e..7eb758ae347 100644
> --- a/rust/hw/timer/hpet/meson.build
> +++ b/rust/hw/timer/hpet/meson.build
> @@ -3,15 +3,15 @@ _libhpet_rs = static_library(
>    files('src/lib.rs'),
>    override_options: ['rust_std=2021', 'build.rust_std=2021'],
>    rust_abi: 'rust',
> -  dependencies: [
> -    common_rs,
> -    util_rs,
> -    migration_rs,
> -    bql_rs,
> -    qom_rs,
> -    system_rs,
> -    hwcore_rs,
> +  link_with: [
> +    _util_rs,
> +    _migration_rs,
> +    _bql_rs,
> +    _qom_rs,
> +    _system_rs,
> +    _hwcore_rs,
>    ],
> +  dependencies: [common_rs],
>  )
>
>  rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true:
> [declare_dependency(
> --
> 2.51.1
>

--0000000000007d9258064508e574
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Turns out these last two patches only work with unrelease=
d Meson. I will put everything into a testable series once 1.10 is out (sho=
uld be soon, it&#39;s already at rc2).<div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 27 nov 2025, 14:20 Paolo =
Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Do not include libqemuutil in the device crates for the same<br>
reason as in the previous commit.=C2=A0 Static libraries like qemuutil<br>
are sensitive to their position on the command line and rustc does not<br>
always get it right.<br>
<br>
If rustc places the library too early on the command line, the stubs<br>
are included in the final link product, which results in duplicate<br>
symbols.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0rust/hw/char/pl011/meson.build | 18 ++++++++++--------<br>
=C2=A0rust/hw/timer/hpet/meson.build | 16 ++++++++--------<br>
=C2=A02 files changed, 18 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.buil=
d<br>
index 33b91f21911..9c0e8290e9a 100644<br>
--- a/rust/hw/char/pl011/meson.build<br>
+++ b/rust/hw/char/pl011/meson.build<br>
@@ -28,20 +28,22 @@ _libpl011_rs =3D static_library(<br>
=C2=A0 =C2=A0),<br>
=C2=A0 =C2=A0override_options: [&#39;rust_std=3D2021&#39;, &#39;build.rust_=
std=3D2021&#39;],<br>
=C2=A0 =C2=A0rust_abi: &#39;rust&#39;,<br>
+=C2=A0 link_with: [<br>
+=C2=A0 =C2=A0 _util_rs,<br>
+=C2=A0 =C2=A0 _migration_rs,<br>
+=C2=A0 =C2=A0 _bql_rs,<br>
+=C2=A0 =C2=A0 _qom_rs,<br>
+=C2=A0 =C2=A0 _chardev_rs,<br>
+=C2=A0 =C2=A0 _system_rs,<br>
+=C2=A0 =C2=A0 _hwcore_rs,<br>
+=C2=A0 =C2=A0 _trace_rs<br>
+=C2=A0 ],<br>
=C2=A0 =C2=A0dependencies: [<br>
=C2=A0 =C2=A0 =C2=A0bilge_rs,<br>
=C2=A0 =C2=A0 =C2=A0bilge_impl_rs,<br>
=C2=A0 =C2=A0 =C2=A0bits_rs,<br>
=C2=A0 =C2=A0 =C2=A0common_rs,<br>
=C2=A0 =C2=A0 =C2=A0glib_sys_rs,<br>
-=C2=A0 =C2=A0 util_rs,<br>
-=C2=A0 =C2=A0 migration_rs,<br>
-=C2=A0 =C2=A0 bql_rs,<br>
-=C2=A0 =C2=A0 qom_rs,<br>
-=C2=A0 =C2=A0 chardev_rs,<br>
-=C2=A0 =C2=A0 system_rs,<br>
-=C2=A0 =C2=A0 hwcore_rs,<br>
-=C2=A0 =C2=A0 trace_rs<br>
=C2=A0 =C2=A0],<br>
=C2=A0)<br>
<br>
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.buil=
d<br>
index bb64b96672e..7eb758ae347 100644<br>
--- a/rust/hw/timer/hpet/meson.build<br>
+++ b/rust/hw/timer/hpet/meson.build<br>
@@ -3,15 +3,15 @@ _libhpet_rs =3D static_library(<br>
=C2=A0 =C2=A0files(&#39;src/<a href=3D"http://lib.rs" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">lib.rs</a>&#39;),<br>
=C2=A0 =C2=A0override_options: [&#39;rust_std=3D2021&#39;, &#39;build.rust_=
std=3D2021&#39;],<br>
=C2=A0 =C2=A0rust_abi: &#39;rust&#39;,<br>
-=C2=A0 dependencies: [<br>
-=C2=A0 =C2=A0 common_rs,<br>
-=C2=A0 =C2=A0 util_rs,<br>
-=C2=A0 =C2=A0 migration_rs,<br>
-=C2=A0 =C2=A0 bql_rs,<br>
-=C2=A0 =C2=A0 qom_rs,<br>
-=C2=A0 =C2=A0 system_rs,<br>
-=C2=A0 =C2=A0 hwcore_rs,<br>
+=C2=A0 link_with: [<br>
+=C2=A0 =C2=A0 _util_rs,<br>
+=C2=A0 =C2=A0 _migration_rs,<br>
+=C2=A0 =C2=A0 _bql_rs,<br>
+=C2=A0 =C2=A0 _qom_rs,<br>
+=C2=A0 =C2=A0 _system_rs,<br>
+=C2=A0 =C2=A0 _hwcore_rs,<br>
=C2=A0 =C2=A0],<br>
+=C2=A0 dependencies: [common_rs],<br>
=C2=A0)<br>
<br>
=C2=A0rust_devices_ss.add(when: &#39;CONFIG_X_HPET_RUST&#39;, if_true: [dec=
lare_dependency(<br>
-- <br>
2.51.1<br>
</blockquote></div>

--0000000000007d9258064508e574--


