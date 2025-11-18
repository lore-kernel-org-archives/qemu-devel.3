Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3553ECEE347
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQAT-0007VE-SK; Tue, 18 Nov 2025 13:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLQAQ-0007Qb-UL
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLQAO-00077f-RS
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763489459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w76e+PGHXKcyV9NDmq1hCnJIhcMTNSPhYz09futJxB8=;
 b=RB5Jbi0ozObkac+rk3DQdfkp+ISQidXa34Wrs59gE+pYgnTwQjNgzAJE6Mi6iVIsBvp1CQ
 1sRbf+ScsfJmk7aGTSgUY4/mnsBLq7nGbiC0hTHra3xbfXcn7Fue1mv3J9Hx95yROSpY61
 L0zPVAk82xzET/8RbpJ5d79PmhfXxps=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-QYysv5yaMiuqAI2lUiNgBg-1; Tue, 18 Nov 2025 13:10:57 -0500
X-MC-Unique: QYysv5yaMiuqAI2lUiNgBg-1
X-Mimecast-MFC-AGG-ID: QYysv5yaMiuqAI2lUiNgBg_1763489457
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-787f7261b62so1344677b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763489456; x=1764094256; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w76e+PGHXKcyV9NDmq1hCnJIhcMTNSPhYz09futJxB8=;
 b=rhAMr0KQyEMxL4bdZ33h24/OoD8HdBgYmfqirhr4MrumT2eNZsOWoaXEViRPTdLTyu
 cBOx0Gfs41Ye/aUE9yDA+8XeuuZ4VCNQov3iybK/L+pZ4bmK9wmHyO+B0jkI2sSmHMWw
 uLqAsUT3Sb+djwcm1eO6WFrwsIsQKYueA77WwYimRYeEN3OZHbmPlwKIfwJL1R8tRTQf
 z/veAUCIGz/NvAqRYJStWrME2nH8Q+y1p/RQLcJBKtNZhyDpoSC15DurWbCCwvQC9lC9
 u4cgUVqO4FuZQPnzWZ2sSCWTRGxxU8l6/5TL1ulstsWsxBHiYIUzA/F2yzrLlbVYqQbs
 dpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489456; x=1764094256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w76e+PGHXKcyV9NDmq1hCnJIhcMTNSPhYz09futJxB8=;
 b=u7GTaBLSyWBGl3tPpyXC+TpsK9IxoHi0eI39ivjWulNvn483t7WCFoxEgBK/8NE4Cq
 calW6bTXVDecpPC1nEaSUJawR/9oKwO/XJaCCeSBXFIJd6R50XQ6jUh6Arx2PmmIJsXe
 0ZF1PlGEJMhxE6YposUEvPHiz6ELPUvTKZBHgZexco4kAqz6qlTVgwQ4M6RTxVE/cvGL
 V0NLl56+aNRJuNJxnz/b0wxJXntTJWv2yZ/Qtys8XTgY0wYIaYYOGQ12NIO6jI3683/9
 VW35S0lEU+w3UTYnJyW8CvSaCNbOjjKLSSo+MSkHDslsmD6eIE6F0BsX0f+FgFxOpJ7w
 cnGg==
X-Gm-Message-State: AOJu0YxwCVT1ZnhwIKQgJJWkO4XXeA1KFp3yNp7khixM3eTtGLynsJXk
 dy6VE6JKy5ttM1aLFOuAJ7LNCbPUxl/Li7dqWIGqxPYHSFGl/eIbIDehVjuW59YrocK9lF6DJjI
 g8ADMrQu4uoBU2TrXmb8OOdPcuIZ2cLfWG8dwiUHrBBcsKoJ7TxTFR2XAxP2y0JJrs1XVU0cRXZ
 xq8/FRUoNyhbEBGiYRvrUky/HP/uVk2zsSlWigMV0=
X-Gm-Gg: ASbGnct/6QvSS/5mo174woCI892lWOcsoHDcpO9cnaT5ZbxNLmBEHXj+gf4/H/lBLTT
 K6XitLO2MF7ZEY16YD5dg8MSrAuXzqKUbSA5ZkPMGURFPM8W1FzPGdtQFOJ8U4n4XoSmvmqDnFg
 gRFFeQBLAt4dbZ8Zqryh++9L9xsxGkzgYxdsb+H4jzOrtKG0LL+77vvUxzLmEIrbK4vlK+vIzYo
 F61BmLDoIPOYE812GXvaqW/sA==
X-Received: by 2002:a05:690e:1c09:b0:640:dcd7:3559 with SMTP id
 956f58d0204a3-642ebaeea7emr386458d50.12.1763489456515; 
 Tue, 18 Nov 2025 10:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWJsC3M3qQ113Oy0OQYtSv0QBbtc+w1dKO3Nwkm7EOZZHLNdkBhd+97Txr7o3Uv+8GTtYkltisQJd1kkuU3a0=
X-Received: by 2002:a05:690e:1c09:b0:640:dcd7:3559 with SMTP id
 956f58d0204a3-642ebaeea7emr386445d50.12.1763489456201; Tue, 18 Nov 2025
 10:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-10-jsnow@redhat.com>
In-Reply-To: <20251117185131.953681-10-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Nov 2025 13:10:44 -0500
X-Gm-Features: AWmQ_bm0P7DNBhf1PCUq2KxOrTaHOysQsgTp9Nvl8prwtPctpcRxaABfBgrIBkw
Message-ID: <CAFn=p-YOr4pB8yWMF7uNsTud6RzqnS8gWAdmO2ShJOa9jdbKCg@mail.gmail.com>
Subject: Re: [PATCH 09/22] tests/iotests: Use configured python to run GitLab
 iotests
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009a8bc80643e2627a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000009a8bc80643e2627a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025, 1:52=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> use the


^configured

python (and the pyvenv) to run iotests instead of the system
> default python3 interpreter.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 44df116139b..c3a9e8428c2 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -351,10 +351,10 @@ build-tcg-disabled:
>      - make check-unit
>      - make check-qapi-schema
>      - cd tests/qemu-iotests/
> -    - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032
> 033 048
> +    - ../../pyvenv/bin/python3 ./check -raw 001 002 003 004 005 008 009
> 010 011 012 021 025 032 033 048
>              052 063 077 086 101 104 106 113 148 150 151 152 157 159 160
> 163
>              170 171 184 192 194 208 221 226 227 236 253 277 image-fleeci=
ng
> -    - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102
> 122
> +    - ../../pyvenv/bin/python3 ./check -qcow2 028 051 056 057 058 065 06=
8
> 082 085 091 095 096 102 122
>              124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>              208 209 216 218 227 234 246 247 248 250 254 255 257 258
>              260 261 262 263 264 270 272 273 277 279 image-fleecing
> --
> 2.51.1
>
>

--0000000000009a8bc80643e2627a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 17, 2025, 1:52=E2=80=
=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">use the </blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">^configured</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmai=
l_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">python (and the pyvenv) t=
o run iotests instead of the system<br>
default python3 interpreter.<br>
<br>
Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
---<br>
=C2=A0.gitlab-ci.d/buildtest.yml | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml<br>
index 44df116139b..c3a9e8428c2 100644<br>
--- a/.gitlab-ci.d/buildtest.yml<br>
+++ b/.gitlab-ci.d/buildtest.yml<br>
@@ -351,10 +351,10 @@ build-tcg-disabled:<br>
=C2=A0 =C2=A0 =C2=A0- make check-unit<br>
=C2=A0 =C2=A0 =C2=A0- make check-qapi-schema<br>
=C2=A0 =C2=A0 =C2=A0- cd tests/qemu-iotests/<br>
-=C2=A0 =C2=A0 - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 0=
25 032 033 048<br>
+=C2=A0 =C2=A0 - ../../pyvenv/bin/python3 ./check -raw 001 002 003 004 005 =
008 009 010 011 012 021 025 032 033 048<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0052 063 077 086 101 104 106=
 113 148 150 151 152 157 159 160 163<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0170 171 184 192 194 208 221=
 226 227 236 253 277 image-fleecing<br>
-=C2=A0 =C2=A0 - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095=
 096 102 122<br>
+=C2=A0 =C2=A0 - ../../pyvenv/bin/python3 ./check -qcow2 028 051 056 057 05=
8 065 068 082 085 091 095 096 102 122<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0124 132 139 142 144 145 151=
 152 155 157 165 194 196 200 202<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0208 209 216 218 227 234 246=
 247 248 250 254 255 257 258<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0260 261 262 263 264 270 272=
 273 277 279 image-fleecing<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div></div>

--0000000000009a8bc80643e2627a--


