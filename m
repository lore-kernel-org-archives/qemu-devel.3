Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C280BC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 19:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpuHW-00073B-2K; Wed, 05 Mar 2025 14:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tpuHU-00072n-Bz
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:19:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tpuHS-00043t-4d
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741202383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raKFbYZgx6EtnhqVRtqYHsYdeIsSSRibe2PrwymB/fk=;
 b=QEq0T48Z99WteZVybnU0QtNOgO+FrujafMbKoXnMDwNk2oAYbXAUqn1wf+U4w2nS1Ho5WK
 csORDq+u6HhfegEb5oN8pGEDC5MB5veOKTBXtpdQozQKSmAJEYj6RH39T/IU53sIaL7ppV
 FIcL4ITkxx/6VhG38NzF6WVv2sF3tsk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-s-n2EW7POguFHwkZDDJLog-1; Wed, 05 Mar 2025 14:19:37 -0500
X-MC-Unique: s-n2EW7POguFHwkZDDJLog-1
X-Mimecast-MFC-AGG-ID: s-n2EW7POguFHwkZDDJLog_1741202376
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso336671f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 11:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741202376; x=1741807176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=raKFbYZgx6EtnhqVRtqYHsYdeIsSSRibe2PrwymB/fk=;
 b=nUG3qZtm6+huhkSO5xWrqgZyt4NSpQEd9A608WiujKaYIXX8C4/ewxHJ6gA6fQNMgC
 hcpdFlWTDHFbMO37n5qxzwF3k1dIwpBeE9Ab2Cgcz4/ZfQHOJ0EY7wuQ2ILmBXoVPPXS
 RhsMt02D93h+a5b2GChH60vvJx710JSZTMTg2j4RhNV7wbngrA4XVMcDfkq8jzJijKLS
 g61v4cO8E3VSMBOF7B98gmnhR2GNshPjj6FRfe2YeUYxyeSpRB/R1eg693lYLFldsDss
 hhNYvwGilVYCAvg2HQ4D2KL6bD2Ca7FuDWUzy4gqMnqfY90qkSBUSczx7BN/I55dYtNw
 RggA==
X-Gm-Message-State: AOJu0Yz4H59plAQ8bBARsjlp+QMcHaW7nXQ6x8Z7em8l1j+tJRm/FFN2
 Dc4xqkl85kZIj0BzHo80ktJBhnZOVTyXHNHihOrd+bzd35m4nhOg54YuMvlNwgM6o1nk/6LNC2u
 YwWt8Isgn65M1RT6G1b/dRVoS42dqCFpC78S1ji/5vC+9JWscHs7fSFpRs4YJvWqoBrqCA1ZV+G
 +jkhNJnVUtCVINjyXwKVn8FKPczN4=
X-Gm-Gg: ASbGncuCAzk3GcduucaBWKzUsNk3T229SjE6CbarAvqvrM/5THuCKs6wLuYtxiVSklz
 vzaIzDYixLRCtDAeQHpG2txbiOjlfhRp0M1JU4UNjCynTelrXhWjdpCj9hAXJ9DgF/H35+era
X-Received: by 2002:a5d:47a2:0:b0:391:490:7acb with SMTP id
 ffacd0b85a97d-3911f72614dmr3493035f8f.2.1741202375962; 
 Wed, 05 Mar 2025 11:19:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBiUtw9LfZrOX9zPeO1cP8SAZaz/c9E9KYVcgRW7Hl+XhaxXWhdx08gkJBJC5Y3WWn7lk8dTEB35UZHiCRwJM=
X-Received: by 2002:a5d:47a2:0:b0:391:490:7acb with SMTP id
 ffacd0b85a97d-3911f72614dmr3493018f8f.2.1741202375682; Wed, 05 Mar 2025
 11:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-5-philmd@linaro.org>
In-Reply-To: <20250305153929.43687-5-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 5 Mar 2025 20:19:21 +0100
X-Gm-Features: AQ5f1JoH8cI10JQuvFGbMD61r1kx-pp7jwtownPfm8UAQIgs9QcfNr2TEo9q4TA
Message-ID: <CABgObfZNDHMiOeif8dbsxNptARQf22ZgYeREjqbcLYLD9xcwNw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/18] qemu: Introduce 'qemu/legacy_binary_info.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000015c2cf062f9d4595"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000015c2cf062f9d4595
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 5 mar 2025, 16:39 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> +    for (size_t i =3D 0; i < ARRAY_SIZE(legacy_binary_infos); i++) {
> +        if (!strcmp(legacy_binary_infos[i].binary_name, binary_name)) {
> +            current_index =3D i;
> +            return;
> +        }
> +    }
> +    fprintf(stderr, "Missing legacy info for '%s' binary.\n",
> binary_name);
>

Wouldn't this crash if a binary is renamed to qemu-kvm or anything else but
its original name? There should be a default target in the binary, and this
function should only be called it there's none; but it should also use the
normal Error** interface instead of aborting.

Also do not call things legacy, as Pierrick also said and explained.

Paolo

+    abort();
> +}
> diff --git a/system/vl.c b/system/vl.c
> index a41ba4a2d5f..74a062c7fff 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -28,6 +28,7 @@
>  #include "qemu/units.h"
>  #include "qemu/module.h"
>  #include "qemu/arch_info.h"
> +#include "qemu/legacy_binary_info.h"
>  #include "exec/cpu-common.h"
>  #include "exec/page-vary.h"
>  #include "hw/qdev-properties.h"
> @@ -2883,6 +2884,7 @@ void qemu_init(int argc, char **argv)
>
>      error_init(argv[0]);
>      qemu_init_exec_dir(argv[0]);
> +    legacy_binary_info_init(argv[0]);
>
>      os_setup_limits();
>
> --
> 2.47.1
>
>

--00000000000015c2cf062f9d4595
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 5 mar 2025, 16:39 Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; ha scritto:</div></div></div><div dir=3D"auto"><div class=3D"g=
mail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; ARRAY_SIZE(legacy_binary_infos);=
 i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strcmp(legacy_binary_infos[i].binary_name=
, binary_name)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 current_index =3D i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 fprintf(stderr, &quot;Missing legacy info for &#39;%s&#39; b=
inary.\n&quot;, binary_name);<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Wouldn&#39;t this crash if a binary is renamed=
 to qemu-kvm or anything else but its original name? There should be a defa=
ult target in the binary, and this function should only be called it there&=
#39;s none; but it should also use the normal Error** interface instead of =
aborting.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Also do not ca=
ll things legacy, as Pierrick also said and explained.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 abort();<br>
+}<br>
diff --git a/system/vl.c b/system/vl.c<br>
index a41ba4a2d5f..74a062c7fff 100644<br>
--- a/system/vl.c<br>
+++ b/system/vl.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/arch_info.h&quot;<br>
+#include &quot;qemu/legacy_binary_info.h&quot;<br>
=C2=A0#include &quot;exec/cpu-common.h&quot;<br>
=C2=A0#include &quot;exec/page-vary.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
@@ -2883,6 +2884,7 @@ void qemu_init(int argc, char **argv)<br>
<br>
=C2=A0 =C2=A0 =C2=A0error_init(argv[0]);<br>
=C2=A0 =C2=A0 =C2=A0qemu_init_exec_dir(argv[0]);<br>
+=C2=A0 =C2=A0 legacy_binary_info_init(argv[0]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0os_setup_limits();<br>
<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div></div>

--00000000000015c2cf062f9d4595--


