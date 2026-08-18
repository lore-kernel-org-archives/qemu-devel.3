Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1245C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwICp-0007GD-Mu; Tue, 18 Aug 2026 07:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wwICn-0007EI-TT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wwICl-0002sY-OG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787053326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKA1TImwMipAEIBYivfQ/VWA170YFpYmPpHcdZBwpPY=;
 b=budeqjk2jWnt/rqp4BR9VUB5110L4UP9OAOb1ZclmlmF2JgmVNH0AjYEBM7dr4TXkCbXFg
 kXqROKmIPod9zWYq8IQnrmZs3+ZzNHJBxtYIlbCDaVA9F03mTVDnevdRDUYipWSHbcyi45
 e7W4o+NLkyRErQtvc8FVCKaGPfQUZQ0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Z3BGCIY8OUmPQ_MCnmNCoA-1; Tue, 18 Aug 2026 07:41:59 -0400
X-MC-Unique: Z3BGCIY8OUmPQ_MCnmNCoA-1
X-Mimecast-MFC-AGG-ID: Z3BGCIY8OUmPQ_MCnmNCoA_1787053319
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso66671395ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787053319; cv=none;
 d=google.com; s=arc-20260327;
 b=k/TCOZMrXlDTAb8GrRGNAgHuY3rdBd/p1SyM8LbZa6VCT1EbdVpnHkXQSzdtO21rnf
 LZlmth/9yDSarUSesFFq90ug2bHQMB9m2zPJCs0z+75/kLkCIp9AUAe/WYV0tKFIKDFi
 zH6T2rPFlNhId2Y3XpvHiDE/pkOnRq7CdEx1isl7YO3lZu0ls8UNO0PAxv1EZn4kn62Y
 j5IpqnbT7RVeW9792IqgTPOPlt7NI2zhkYG0+20CAg/4FBHVEL6gQL9HTNT5AHx6ffdy
 SnCkHT2a9f5CNi7V0kWYc6shBGzocOraUqUnMeixUm0N61DeR8SyIjfQ2SVyypRhRJCl
 NVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fKA1TImwMipAEIBYivfQ/VWA170YFpYmPpHcdZBwpPY=;
 fh=VWpDDznhhkns+RBYcpzRS+HdjURLRuFdq8+B6bSxo40=;
 b=HP1zilMXQtQ593pB9awu3yYVSW+h/xZYhppQ86Tr7ZUHGAiDNs2bAQx/NiJSUZBWBf
 Dn/oO0wsBCa5N+2k5EkADUA7EKpNufQxU2DVZzOAGu4pdo5GVGjCOCYk2Y5vdwaiVAqA
 hFUm5lOXfUr0OT3GrMHHT6t+80y4d1QjLtetg3QExLqFKb/T89GKe7bXdFOVoFvJBpK1
 zC+eeXkh5ENOCRfnPn5Eo7hQ57XVopjU+ARvde1wRZxD31tMfjrdJWuX7Qt+cU6kCEge
 ms20AWn0qTO/vvnvdcI7DJCytrPFm2V2aJieFvpO17cL2Looy39pccQEBAtpsAqK6TPo
 80AA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787053319; x=1787658119; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fKA1TImwMipAEIBYivfQ/VWA170YFpYmPpHcdZBwpPY=;
 b=mRpWs2gezNByw71AUXV+yySQfqC8vOhldVdMcnjnuJplyffrMBmMJrC5rbVlN8hgDm
 CwtZo3m07EDjMW/raH08MSCSqBSzHiHYoU+a2kxI0wpE9v6W5a2Gyk/l6N0uDbAOnJGr
 qLN3v42kbSCnaQOA0niWA95IMiSvKSMcTtOqrqY/3AUf7iHwYxG+x1GwQz2p6ncftm9U
 G5NpMnWzg4uh9Kv0LHsNLPDzl6f3WmQ2OWA/GCVYdXLJxRPwOCz00cx62j4JhXw8weuq
 vwdzh5RfHVQFgMtZ9pXgUTOv3uEd3nbXdEWOVXKah/cMc7Js/LgIxMQ7ULNXLWbYtm0b
 giSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787053319; x=1787658119;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fKA1TImwMipAEIBYivfQ/VWA170YFpYmPpHcdZBwpPY=;
 b=Z6IsXXH//jxiDGmjq+tW9z7/4nVIcVYAnZ/yg+30W9TTc++C/w5F3mvEk73uG5J3Yv
 aF+X5HvE9cSQNM+10ZRieajXpaNbeKuyCcIuBS09pbOGY/wlFCUShlQsw8wkWvD+0tEw
 Aqo0lt8VfvE1eq7HTghK7Fp5P25iowYENmGNQTiH9UVTjfWlnCr6i2dM1Wf02UASq2cz
 Sv//mrTHoV7drLE/2rW7kq2o6xfAS1AWOISoIpOOz0/ysA69ipXLGmGWJfcUptQDRyXP
 HuSjvjLGJYs7sfZxEu0hTTyEsX3IpLpldjFmapmZQWpyghDa9AxwBlLTcXj0JAezmdKO
 H8yQ==
X-Gm-Message-State: AOJu0Yx4tPnH//HKRRAcSihBllbbrRtdK0p39fx8NSYQzqR+KRsF5lJ8
 Uv7dYuQ/SpKpAEKyxvMHJNPjmM5VMGu4XJ9xsl52SehBP7Qj05PyuDzQOQT7jKcUmWnsZb7vI2T
 n7xleAJYGThHRarU7AmZvtzlA5GSmHJUtaacFqqJ2TqDFSAaCf4LcNXngA4L7hoQbj1qobdOu/g
 KOGgFdicIGhKejqqyihCOJ09fwPJvqY3o=
X-Gm-Gg: AR+sD11Nf0NNZ3Oko8nd29WBmiPlUUqTKP4kgFrbfLyBKcxu8AtX9ik+sr0G/cOrcK6
 /99cEc4x3vwy0AXmpZfMH8ZLwkX5d2H3rJy0VwTaM9900D4upA0gajtIYqZ8xu8z2Hez8pjbxNx
 1gwrh1IbKRVkRrA9Iybqj3zFj7EfxTlTPcbE0Rm33NcrbCiZIzmutmw1XA
X-Received: by 2002:a17:902:ef11:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2d3b07e5c69mr431719415ad.0.1787053318568; 
 Tue, 18 Aug 2026 04:41:58 -0700 (PDT)
X-Received: by 2002:a17:902:ef11:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2d3b07e5c69mr431718065ad.0.1787053318037; Tue, 18 Aug 2026
 04:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-6-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-6-24b8bbbe3d86@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 18 Aug 2026 14:41:45 +0300
X-Gm-Features: AcwNN1XURjo4zUgIAsUxCWGx2gE0ljEq3qom8Yu9Gn9vwbcBK6jOO2X6QV2f6vc
Message-ID: <CAPMcbCrD6_GS5mACUEF5X2ouBXmOCcL9kaw=fNcLg7zA_4BDPQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/74] meson: add qapi-type-infos-*.c/h to build
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="00000000000037c3ae065950c6aa"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

--00000000000037c3ae065950c6aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Tue, Aug 18, 2026 at 2:13=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Add the per-module type-infos output files so they are compiled into
> the build.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/meson.build              | 4 ++++
>  qga/meson.build               | 2 ++
>  tests/include/meson.build     | 2 ++
>  tests/meson.build             | 6 ++++++
>  tests/qapi-schema/meson.build | 1 +
>  5 files changed, 15 insertions(+)
>
> diff --git a/qapi/meson.build b/qapi/meson.build
> index a46269b5a0c9..7477953492ad 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -79,6 +79,7 @@ endif
>
>  qapi_nonmodule_outputs =3D [
>    'qapi-introspect.c', 'qapi-introspect.h',
> +  'qapi-type-infos.c', 'qapi-type-infos.h',
>    'qapi-types.c', 'qapi-types.h',
>    'qapi-visit.h', 'qapi-visit.c',
>    'qapi-commands.h', 'qapi-commands.c',
> @@ -88,6 +89,7 @@ qapi_nonmodule_outputs =3D [
>  ]
>
>  qapi_outputs =3D qapi_nonmodule_outputs + [
> +  'qapi-builtin-type-infos.c', 'qapi-builtin-type-infos.h',
>    'qapi-builtin-types.c', 'qapi-builtin-visit.c',
>    'qapi-builtin-types.h', 'qapi-builtin-visit.h',
>  ]
> @@ -96,6 +98,8 @@ qapi_inputs =3D []
>  foreach module : qapi_all_modules
>    qapi_inputs +=3D [ files(module + '.json') ]
>    qapi_module_outputs =3D [
> +    'qapi-type-infos-@0@.c'.format(module),
> +    'qapi-type-infos-@0@.h'.format(module),
>      'qapi-types-@0@.c'.format(module),
>      'qapi-types-@0@.h'.format(module),
>      'qapi-visit-@0@.c'.format(module),
> diff --git a/qga/meson.build b/qga/meson.build
> index cfa2157efb23..79163b7d8e93 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -39,6 +39,8 @@ qga_qapi_outputs =3D [
>    'qga-qapi-init-commands.h',
>    'qga-qapi-introspect.c',
>    'qga-qapi-introspect.h',
> +  'qga-qapi-type-infos.c',
> +  'qga-qapi-type-infos.h',
>    'qga-qapi-types.c',
>    'qga-qapi-types.h',
>    'qga-qapi-visit.c',
> diff --git a/tests/include/meson.build b/tests/include/meson.build
> index 8e8d1ec4e692..026480d96851 100644
> --- a/tests/include/meson.build
> +++ b/tests/include/meson.build
> @@ -4,6 +4,8 @@ test_qapi_outputs_extra =3D [
>    'test-qapi-commands-sub-module.h',
>    'test-qapi-events-sub-module.c',
>    'test-qapi-events-sub-module.h',
> +  'test-qapi-type-infos-sub-module.c',
> +  'test-qapi-type-infos-sub-module.h',
>    'test-qapi-types-sub-module.c',
>    'test-qapi-types-sub-module.h',
>    'test-qapi-visit-sub-module.c',
> diff --git a/tests/meson.build b/tests/meson.build
> index 9ba04bbedd30..71dc4ac8bf99 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -2,6 +2,8 @@ subdir('bench')
>  subdir('qemu-iotests')
>
>  test_qapi_outputs =3D [
> +  'qapi-builtin-type-infos.c',
> +  'qapi-builtin-type-infos.h',
>    'qapi-builtin-types.c',
>    'qapi-builtin-types.h',
>    'qapi-builtin-visit.c',
> @@ -22,6 +24,10 @@ test_qapi_outputs =3D [
>    'test-qapi-init-commands.h',
>    'test-qapi-introspect.c',
>    'test-qapi-introspect.h',
> +  'test-qapi-type-infos-sub-sub-module.c',
> +  'test-qapi-type-infos-sub-sub-module.h',
> +  'test-qapi-type-infos.c',
> +  'test-qapi-type-infos.h',
>    'test-qapi-types-sub-sub-module.c',
>    'test-qapi-types-sub-sub-module.h',
>    'test-qapi-types.c',
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.buil=
d
> index debff633ac17..392b59d8dccd 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -231,6 +231,7 @@ custom_target('QAPI doc',
>                         'doc-good-qapi-events.c', 'doc-good-qapi-events.h=
',
>                         'doc-good-qapi-init-commands.c',
> 'doc-good-qapi-init-commands.h',
>                         'doc-good-qapi-introspect.c',
> 'doc-good-qapi-introspect.h',
> +                       'doc-good-qapi-type-infos.c',
> 'doc-good-qapi-type-infos.h',
>                         'doc-good-qapi-types.c', 'doc-good-qapi-types.h',
>                         'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h' =
],
>                input: files('doc-good.json'),
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>

--00000000000037c3ae065950c6aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Aug 18, 2026 at 2:13=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt=
;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Add the per-module type-infos output files so they are compiled into<br>
the build.<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qapi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 =
++++<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 2 ++<br>
=C2=A0tests/include/meson.build=C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0tests/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 =
++++++<br>
=C2=A0tests/qapi-schema/meson.build | 1 +<br>
=C2=A05 files changed, 15 insertions(+)<br>
<br>
diff --git a/qapi/meson.build b/qapi/meson.build<br>
index a46269b5a0c9..7477953492ad 100644<br>
--- a/qapi/meson.build<br>
+++ b/qapi/meson.build<br>
@@ -79,6 +79,7 @@ endif<br>
<br>
=C2=A0qapi_nonmodule_outputs =3D [<br>
=C2=A0 =C2=A0&#39;qapi-introspect.c&#39;, &#39;qapi-introspect.h&#39;,<br>
+=C2=A0 &#39;qapi-type-infos.c&#39;, &#39;qapi-type-infos.h&#39;,<br>
=C2=A0 =C2=A0&#39;qapi-types.c&#39;, &#39;qapi-types.h&#39;,<br>
=C2=A0 =C2=A0&#39;qapi-visit.h&#39;, &#39;qapi-visit.c&#39;,<br>
=C2=A0 =C2=A0&#39;qapi-commands.h&#39;, &#39;qapi-commands.c&#39;,<br>
@@ -88,6 +89,7 @@ qapi_nonmodule_outputs =3D [<br>
=C2=A0]<br>
<br>
=C2=A0qapi_outputs =3D qapi_nonmodule_outputs + [<br>
+=C2=A0 &#39;qapi-builtin-type-infos.c&#39;, &#39;qapi-builtin-type-infos.h=
&#39;,<br>
=C2=A0 =C2=A0&#39;qapi-builtin-types.c&#39;, &#39;qapi-builtin-visit.c&#39;=
,<br>
=C2=A0 =C2=A0&#39;qapi-builtin-types.h&#39;, &#39;qapi-builtin-visit.h&#39;=
,<br>
=C2=A0]<br>
@@ -96,6 +98,8 @@ qapi_inputs =3D []<br>
=C2=A0foreach module : qapi_all_modules<br>
=C2=A0 =C2=A0qapi_inputs +=3D [ files(module + &#39;.json&#39;) ]<br>
=C2=A0 =C2=A0qapi_module_outputs =3D [<br>
+=C2=A0 =C2=A0 &#39;qapi-type-infos-@0@.c&#39;.format(module),<br>
+=C2=A0 =C2=A0 &#39;qapi-type-infos-@0@.h&#39;.format(module),<br>
=C2=A0 =C2=A0 =C2=A0&#39;qapi-types-@0@.c&#39;.format(module),<br>
=C2=A0 =C2=A0 =C2=A0&#39;qapi-types-@0@.h&#39;.format(module),<br>
=C2=A0 =C2=A0 =C2=A0&#39;qapi-visit-@0@.c&#39;.format(module),<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index cfa2157efb23..79163b7d8e93 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -39,6 +39,8 @@ qga_qapi_outputs =3D [<br>
=C2=A0 =C2=A0&#39;qga-qapi-init-commands.h&#39;,<br>
=C2=A0 =C2=A0&#39;qga-qapi-introspect.c&#39;,<br>
=C2=A0 =C2=A0&#39;qga-qapi-introspect.h&#39;,<br>
+=C2=A0 &#39;qga-qapi-type-infos.c&#39;,<br>
+=C2=A0 &#39;qga-qapi-type-infos.h&#39;,<br>
=C2=A0 =C2=A0&#39;qga-qapi-types.c&#39;,<br>
=C2=A0 =C2=A0&#39;qga-qapi-types.h&#39;,<br>
=C2=A0 =C2=A0&#39;qga-qapi-visit.c&#39;,<br>
diff --git a/tests/include/meson.build b/tests/include/meson.build<br>
index 8e8d1ec4e692..026480d96851 100644<br>
--- a/tests/include/meson.build<br>
+++ b/tests/include/meson.build<br>
@@ -4,6 +4,8 @@ test_qapi_outputs_extra =3D [<br>
=C2=A0 =C2=A0&#39;test-qapi-commands-sub-module.h&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-events-sub-module.c&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-events-sub-module.h&#39;,<br>
+=C2=A0 &#39;test-qapi-type-infos-sub-module.c&#39;,<br>
+=C2=A0 &#39;test-qapi-type-infos-sub-module.h&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-types-sub-module.c&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-types-sub-module.h&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-visit-sub-module.c&#39;,<br>
diff --git a/tests/meson.build b/tests/meson.build<br>
index 9ba04bbedd30..71dc4ac8bf99 100644<br>
--- a/tests/meson.build<br>
+++ b/tests/meson.build<br>
@@ -2,6 +2,8 @@ subdir(&#39;bench&#39;)<br>
=C2=A0subdir(&#39;qemu-iotests&#39;)<br>
<br>
=C2=A0test_qapi_outputs =3D [<br>
+=C2=A0 &#39;qapi-builtin-type-infos.c&#39;,<br>
+=C2=A0 &#39;qapi-builtin-type-infos.h&#39;,<br>
=C2=A0 =C2=A0&#39;qapi-builtin-types.c&#39;,<br>
=C2=A0 =C2=A0&#39;qapi-builtin-types.h&#39;,<br>
=C2=A0 =C2=A0&#39;qapi-builtin-visit.c&#39;,<br>
@@ -22,6 +24,10 @@ test_qapi_outputs =3D [<br>
=C2=A0 =C2=A0&#39;test-qapi-init-commands.h&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-introspect.c&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-introspect.h&#39;,<br>
+=C2=A0 &#39;test-qapi-type-infos-sub-sub-module.c&#39;,<br>
+=C2=A0 &#39;test-qapi-type-infos-sub-sub-module.h&#39;,<br>
+=C2=A0 &#39;test-qapi-type-infos.c&#39;,<br>
+=C2=A0 &#39;test-qapi-type-infos.h&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-types-sub-sub-module.c&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-types-sub-sub-module.h&#39;,<br>
=C2=A0 =C2=A0&#39;test-qapi-types.c&#39;,<br>
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build<=
br>
index debff633ac17..392b59d8dccd 100644<br>
--- a/tests/qapi-schema/meson.build<br>
+++ b/tests/qapi-schema/meson.build<br>
@@ -231,6 +231,7 @@ custom_target(&#39;QAPI doc&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;doc-good-qapi-events.c&#39;, &#39;doc-good-qapi-events.h&#3=
9;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;doc-good-qapi-init-commands.c&#39;, &#39;doc-good-qapi-init=
-commands.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;doc-good-qapi-introspect.c&#39;, &#39;doc-good-qapi-introsp=
ect.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;doc-good-qapi-type-infos.c&#39;, &#39;doc-good-qapi-type-inf=
os.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;doc-good-qapi-types.c&#39;, &#39;doc-good-qapi-types.h&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;doc-good-qapi-visit.c&#39;, &#39;doc-good-qapi-visit.h&#39;=
 ],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: files(&#39;do=
c-good.json&#39;),<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
</blockquote></div>

--00000000000037c3ae065950c6aa--


