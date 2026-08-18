Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E2BC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNDs-0002Iz-Pz; Tue, 18 Aug 2026 13:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wwNDr-00028A-Em
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:03:35 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1wwNDp-00057K-Fv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:03:35 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5aebf96bc89so24895e87.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787072611; cv=none;
 d=google.com; s=arc-20260327;
 b=mQ5EWzg546jBjC2sfyQcPlGbkc5itf6IuEvVUYT2AdbgkL38t9YkC98kGhUxbzBiqH
 a6oX/rHmc6L7zAQA1DbO8A5EQXJuWhQ3s+kxypzfZebbBEiQfqNunIr/LmwnPLhkII5b
 npQAf4WnPKH81kELliOhB/aI43XhTysVXEBBdtfiVqMaCxYWx8lEaDhboCIyxi08Fboz
 3lMYuTOvv+yF8KHgohEA1T7IxOmL6m6sutN8q3HXvFaPPl3hm4r2ZT4HMENKC9sX1/QQ
 94AWwBUbfegtv3F1qWR4P4ZtKC05FMrZhcbf4xtnafJyUw/NwI9paMMHYRpqkuNnpp9c
 +4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7yw3BNnnrSYYWoyJhU/0SkFOfpDmnxK1DieFrFLh8gM=;
 fh=sKJfdWmlXdbO0ULypAS3MiGzy7Q3ZwsXwppXqdFH4Zs=;
 b=g3m652cRxJK+UZUh8DRN06NmSR1kjb/rjBzruUhTJxm/o5dRVBn0pLZErZnfK93n/U
 XPQIdfmvjOK1WEMwiVlK0Vv9lcktUdoqTvoouIUEa5YGwiWwK4Jpoo3wF1zaBnCCOD0g
 1xyxvTt4kXDmAm6sIuaEpCoNalSVo0FLwKEt/LQTE9o20iWxB54TlXp59SY7OmhlC/Hk
 K9q2pXHH1Y0JTuGwI1gltbnAR3NT/L2ZoT7pmBG0/pO+Wfz2PoSYpr5dHvALM2kgBnoH
 uXlE9W15/Poe0C/dnvLr+2C5TczW0Ay5f+vBihnL/a5GAUwlufPViwYJ4AFSdd/MLQz1
 4UpA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787072611; x=1787677411; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7yw3BNnnrSYYWoyJhU/0SkFOfpDmnxK1DieFrFLh8gM=;
 b=I5h3GMcpccy6xXnHIaGza1qwx30Okbj5cxzZ+UaSZu1Qo6O1LNQlSEIsSjTsL35VUb
 7YntXmisczRedqB9HPn35SFpxjDaLp0ZyBq4bWfARYlWmSc0t2DT20HQxiaTFsBRrJfe
 OhqeOVrH2pESHepkF1PSrp9MqQmpNPNfnEqQGBFWhq3ehuaLIfGplAxF25dYLGQBHeYm
 R+6qBQ2cay4S6qvrgyPd7ab2Mv8HOVkB+Z6MRBTrikTPbtUdnND35/7k2TEaVYgcsFPh
 j6Tp+U0F5HebUAE/qdReU2x+ux6+HEVDClyVKiePvr4kJPchRRYy41j+QgI3N7Nb+XLO
 C5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072611; x=1787677411;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7yw3BNnnrSYYWoyJhU/0SkFOfpDmnxK1DieFrFLh8gM=;
 b=UNt3lC/uun+oaqDmQxiqM6WB9nLhjMkrehXFnZWwl/MWJ57Lq6L9kPYYnWfBYrsukQ
 63dJ2TPvCZboz1K5LnzpdvrLbcxor2Ni11OOAcwBzfphZ7qLgS8RtR8hkZC1Fzv+yv9s
 VbLK8v3ZCx5r0M6EcCWsBie93BwqV3SzJaDG+knU2iLdxlUYbRDS4Mqpu+u4EjNuydW3
 UyBV4WMFjmbUNdDRBWIvCyupzmm+R+JzmsjHeiQ7IiLqzInzflbJhwRFCQtEkWiYt6GK
 7fMJyUh4kzamTtKgUYsndSBjO4WKffxLhqPdfcm4EPg2SPIHG7i+1tQRG3a/PANVB5ZH
 cd8w==
X-Gm-Message-State: AOJu0YykhwE6aR36UZ72bl0WatUZUxWJYvUGUwP16QQ951hbfWEgmsss
 BiGJJRchZKi0bEam0bzZ46ty+MZAfVzq7C+pGQxMrsPk3Eip/qt1GMIzlDtFiqkd13mlTx6RTG6
 ZGaiyJOSvn5zqix/CKoN8iqkejnHRJoI=
X-Gm-Gg: AR+sD13/n3Im1bQaLk5MAem5AyNFyka6lGomXgey0xPkwN56+YqrSKApA04sS3Ywoha
 to21WE4a9GjbPZPuSRJq2DmKG69AwT4y44IWHJLya6VVXJGeuWca1HCTZM3zhlXXYYbx3wW6aMJ
 XtU4F3ZJAz0WeSAbRDQ4s3B6jNcFuJYCgYgA/trYuS5sXraMMnQ/hEpEDE7+zP0FW0ZEoFpqlLM
 AbID8rajOzybgW4jBvxLRweDX9uEfBNsKurVoM/Q2BDug3H7tyoNMzVWqpM0P4k7oVyiizuU/uf
 jlxgAVBQCzaRyVJMAOcBviyvohtMKZcle9IOVukdxa+o6eSfDmSwu3StIexCochma5CxgcEalT7
 19B1/kaTI0uQ=
X-Received: by 2002:a05:6512:a92:b0:5ae:b6cf:2864 with SMTP id
 2adb3069b0e04-5b4590ce3c6mr5200277e87.0.1787072610690; Tue, 18 Aug 2026
 10:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260813005031.518387-1-richard.henderson@linaro.org>
 <20260813005031.518387-3-richard.henderson@linaro.org>
In-Reply-To: <20260813005031.518387-3-richard.henderson@linaro.org>
From: Yogesh Vyas <yvyas1991@gmail.com>
Date: Tue, 18 Aug 2026 22:33:17 +0530
X-Gm-Features: AcwNN1UXm-0NIOvBgxNyfJo_j1V5P1IHyTkvb2SfN-KcUeAxFoPHm5EpdQlgWGM
Message-ID: <CAJOT6qNRduLyxkb1MbnUBWjaE2JdU6_ep3GzOwEVfrFubUPaxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tcg: Return success from tcg_region_alloc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rathc@linux.ibm.com, 
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
Content-Type: multipart/alternative; boundary="00000000000025e9020659554489"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=yvyas1991@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000025e9020659554489
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Regards,
Yogesh Vyas


On Thu, Aug 13, 2026 at 6:20=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Invert the sense of the boolean result from 'error' to 'success'.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/region.c | 2 +-
>  tcg/tcg.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/region.c b/tcg/region.c
> index 2161d961d9..8ee8c39c43 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -383,7 +383,7 @@ bool tcg_region_alloc(TCGContext *s)
>

The API comment above this function still says "return true on error" which
needs to be corrected with this patch.

         region.agg_size_full +=3D size_full - TCG_HIGHWATER;
>      }
>      qemu_mutex_unlock(&region.lock);
> -    return !ok;
> +    return ok;
>  }
>
>  /*
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 1e77f2365a..af15c3d63e 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1835,7 +1835,7 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
>      next =3D (void *)ROUND_UP((uintptr_t)(tb + 1), align);
>
>      if (unlikely(next > s->code_gen_highwater)) {
> -        if (tcg_region_alloc(s)) {
> +        if (!tcg_region_alloc(s)) {
>              return NULL;
>          }
>          goto retry;
> --
> 2.43.0
>
>

--00000000000025e9020659554489
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"><=
/div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Regar=
ds,<div>Yogesh Vyas</div></div></div></div><br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2026 at 6:20=
=E2=80=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linar=
o.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Invert the sense of th=
e boolean result from &#39;error&#39; to &#39;success&#39;.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0tcg/region.c | 2 +-<br>
=C2=A0tcg/tcg.c=C2=A0 =C2=A0 | 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tcg/region.c b/tcg/region.c<br>
index 2161d961d9..8ee8c39c43 100644<br>
--- a/tcg/region.c<br>
+++ b/tcg/region.c<br>
@@ -383,7 +383,7 @@ bool tcg_region_alloc(TCGContext *s)<br></blockquote><d=
iv>=C2=A0</div><div>The API comment above this function still=C2=A0says &qu=
ot;return true on error&quot; which needs to be corrected with this patch.<=
/div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region.agg_size_full +=3D size_full - TCG=
_HIGHWATER;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;region.lock);<br>
-=C2=A0 =C2=A0 return !ok;<br>
+=C2=A0 =C2=A0 return ok;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/tcg/tcg.c b/tcg/tcg.c<br>
index 1e77f2365a..af15c3d63e 100644<br>
--- a/tcg/tcg.c<br>
+++ b/tcg/tcg.c<br>
@@ -1835,7 +1835,7 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)<br>
=C2=A0 =C2=A0 =C2=A0next =3D (void *)ROUND_UP((uintptr_t)(tb + 1), align);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0if (unlikely(next &gt; s-&gt;code_gen_highwater)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tcg_region_alloc(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tcg_region_alloc(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto retry;<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>
</div>

--00000000000025e9020659554489--

