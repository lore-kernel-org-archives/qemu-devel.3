Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429CCD3B9AB
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 00:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTUsr-0003Qc-Fu; Wed, 10 Dec 2025 19:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1vTUsp-0003QN-8C
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 19:50:15 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1vTUsn-0002sd-L0
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 19:50:15 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3436d6bdce8so480868a91.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765414212; x=1766019012; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Irbe/DQi/c6MSeXWBLxOf9NA3As39yeQLXlJ65EgBjo=;
 b=FIV2GTdmP0iKEKNRcQRw8+7bDO8w1nIBBeMtLLKk3YzJfiZvJlppA97sHFjLD1SSli
 rmRxNhUiVjCDTO4Q64U/iY4AVL6ElBYiJ/DbyraVJph+sdjhibMr5E3SffaFdJNJSbYV
 uXVK/51WJTWXxAZM18waDTnzH+tNSVvD0iAwHKyls3DH+qqDDS0+sCWg7zwVgPeLAeBO
 CTHAYvxkKOITVaZd8S/6WWSX2iI4jSNv4JkLZdhAI1zq+Q7JL3dWw1kLKqaaq6kBgYHZ
 HMVy/QYBMGQP5+FmgthDn2mHGnXCQOfJ0TeJHOTNRZ9vIkFN3HZTerRaulRnDOq+GXTq
 fnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765414212; x=1766019012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Irbe/DQi/c6MSeXWBLxOf9NA3As39yeQLXlJ65EgBjo=;
 b=VBZc26ijSQAVuqQgq7uJXe4BkJ5hQiLUx30ibSwoH/frMoRxtbvruK5XlJhGsCn6W4
 S+q9FJn0uBTNnnMzpO6McESFMd4kIA7rxsgLg9b7BfE6Rmw5q350USAa0u/t/dpIDkm+
 SnqnMz45zRHCQMaVvv4PgruFhm4OlhgB007Db8UmNtVnaXwPfCAIH54Z0Lwf2jmfXEuT
 wIWY4lnmZxg0m2rUvy7IQGyBupOUrUS7TP5ZruAqA0mvogbn/p50kxQx/yxYuKDqFm8E
 8i41M5EvSAVVUQCd6lMZXUJREw1l+taAB/75Rv4xE6/B7ouGBSxY9eZDVITmt7p/NnKa
 US0A==
X-Gm-Message-State: AOJu0YxshbUWEzWtRUETqSEkfJ7R7N/2ELEOQ9TKgh8dAqQg945izJLS
 B5yr4RRM8xoMrbBudDr8tZWxS3vZTLeY4w1ey032IWzyIc+QKupEzzJvwiQgUi3ih1Ai4GFr8wV
 pjMYNAGiW3A+u/WLdrybVL7e1RmjZEw==
X-Gm-Gg: AY/fxX5TOKMt01SF2kJdMSiwFL8yV07E6QKkiwuOr3wURaUG7O7fVnVytLqQViUpsal
 63UgUZ3eYWNxy1iJiPoPCvl/Dt+4Gicu4q2IvpFaKGrG1dTJFLmelAHmOMsugtRbvvkWXFRrsJ7
 +bNVDfU8xbqwdXzNaAVcyeQy68Lo+r4J466SPt/0PBnXVhvHi4rOevxq8RX1Z5fFMwrd5J3HMrL
 sR3twVY5gIHqiaNmpzBEcpFD0n5RHsLsxEOtv5T9faeyiHqR8RWpW8XQHkOUl2LZEgHd/CjR8EO
 Pqy41YZN2Uu43OQK+omVkxO79DeG
X-Google-Smtp-Source: AGHT+IH/x1qpmKuWRxfjBQtZzsmj3IC9ep2kIOCXgy2xzGQK3kMBsZmuh2sPuXEQNT7YdTgCBgyNYW9mynjm4X5BAdI=
X-Received: by 2002:a17:90b:584b:b0:33e:1acc:1799 with SMTP id
 98e67ed59e1d1-34a728a1b73mr3777313a91.14.1765414211671; Wed, 10 Dec 2025
 16:50:11 -0800 (PST)
MIME-Version: 1.0
References: <CAOYM0N3YdrkhOXrpxE6rzk5DbLOF0GzEVaThAHxnHfQYLk+pzQ@mail.gmail.com>
 <03e5d5b2-2f3f-451e-93af-439348469967@redhat.com>
In-Reply-To: <03e5d5b2-2f3f-451e-93af-439348469967@redhat.com>
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 11 Dec 2025 00:50:01 +0800
X-Gm-Features: AQt7F2owEZOoXLK-pDLpBAr3ZXj0s84wfpEZ1HLzhF3Gi-3mZUOt4jW2_TYCN9Q
Message-ID: <CAOYM0N3Kth=KfZtZLet7+3AYvzQg6V+w4dLWgLYT7OuNTvMsDg@mail.gmail.com>
Subject: Re: make pxerom report error
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f7dc8a0645a286b5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=liu.jaloo@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000f7dc8a0645a286b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply.

$ cd roms/ipxe
$ git checkout master

It works well now.

Maybe it's time to update the default ID of the ipxe submodule

On Thu, Dec 11, 2025 at 2:46=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 09/12/2025 19.48, Liu Jaloo wrote:
> > $ cd qemu
> > $ git submodule update --init roms/ipxe
> > $ cd roms
> > $ make pxerom
> >
> > report error like this:
> >
> >     In file included from tests/bigint_test.c:38:
> >     tests/bigint_test.c: In function =E2=80=98bigint_test_exec=E2=80=99=
:
> >     tests/bigint_test.c:232:14: error: =E2=80=98result_raw=E2=80=99 may=
 be used
> >     uninitialized [-Werror=3Dmaybe-uninitialized]
> >        232 |         ok ( memcmp ( result_raw, expected_raw,
>
> >              \
> >            |
>
>   Hi!
>
> QEMU is just a user of the ipxe code, so if you want to get this fixed, I
> think you have to report it to the ipxe project, see
> https://ipxe.org/contact
>
>   HTH,
>    Thomas
>
>

--000000000000f7dc8a0645a286b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for your reply.=C2=A0</div><div><br></div><div=
>$ cd=C2=A0roms/ipxe</div><div>$ git checkout master</div><div><br></div><d=
iv>It works well now.=C2=A0</div><div><br></div><div>Maybe it&#39;s time to=
 update the default ID of the ipxe submodule</div></div><br><div class=3D"g=
mail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On =
Thu, Dec 11, 2025 at 2:46=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thut=
h@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 09/12/2025 19.48, Liu Jaloo wrote:<br>
&gt; $ cd qemu<br>
&gt; $ git submodule update --init roms/ipxe<br>
&gt; $ cd roms<br>
&gt; $ make pxerom<br>
&gt; <br>
&gt; report error like this:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0In file included from tests/bigint_test.c:38:<br>
&gt;=C2=A0 =C2=A0 =C2=A0tests/bigint_test.c: In function =E2=80=98bigint_te=
st_exec=E2=80=99:<br>
&gt;=C2=A0 =C2=A0 =C2=A0tests/bigint_test.c:232:14: error: =E2=80=98result_=
raw=E2=80=99 may be used<br>
&gt;=C2=A0 =C2=A0 =C2=A0uninitialized [-Werror=3Dmaybe-uninitialized]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 232 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ok ( memc=
mp ( result_raw, expected_raw,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 <br>
<br>
=C2=A0 Hi!<br>
<br>
QEMU is just a user of the ipxe code, so if you want to get this fixed, I <=
br>
think you have to report it to the ipxe project, see <a href=3D"https://ipx=
e.org/contact" rel=3D"noreferrer" target=3D"_blank">https://ipxe.org/contac=
t</a><br>
<br>
=C2=A0 HTH,<br>
=C2=A0 =C2=A0Thomas<br>
<br>
</blockquote></div>

--000000000000f7dc8a0645a286b5--

