Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60E7F364AB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAtLi-00052n-OD; Thu, 09 Apr 2026 13:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAtLf-00052c-Cf
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:39:23 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAtLd-00009z-PT
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 13:39:23 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82d03827316so567367b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 10:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775756360; cv=none;
 d=google.com; s=arc-20240605;
 b=RHY4VE4nL0VijrgU9OXFETEE+97V2/yPAso4NQZkWAvgXcMkWMTN8hb9///Kg0Eofj
 tI6XFIg86Jgo55RRbFpFKv+qyGD0Ib3UqIGUZLH6uOMCluCcw7bnO7wV5toPQevuZnZL
 3canv7K+T3CIyhQi1W5tHofP2+qfOQqYC1K6Qt3QK+/Tcl2lYPS8q5mIqoYVzP7jtbol
 j49IElmRAEYJ4o6/zkYUq60Y/T83FlM6QcGUDh3U95WLGVW//52Gx4e7b9SbTBaszHcM
 87LVeA2CWQ/oa6ZFH8IhEWo1Uw7JpbtbC66BTF+GxP5hvm6JYOl8/3vQdG0JqQcT7v11
 chKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=95UHS3IRRE/5T0I2i8qAJrDVmZDHXLiuSD8p/GWf1sM=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=D9bOHS8M7T1WPGQRgQVLVXRv+e0F+52p9XVxcwFZlbZcLhMCereVQDzPtAIjY5wINd
 /TotHTxQRZPajOi8wBTeaHl6fvEFBwCDFGC6pt+iG/0kF3Ur9CXW6jRPsqpBI/9nne7l
 9gsjFl+jI60IU2ksymbMchBDQ8q6anRB0BxL25ApBOJWfB4uc+0tt2CFSS8tKBZdenba
 /GuMi0xkpUNGvxth7EiL9AkRG/3XBNClM2e3pWbNFnUvhC+itv67V9QQ7g5YV5jfzI2H
 46r0Z+nYcFdoRs1EYlZWs2cDSpUvTSf34Ew9x7IaeUuX8Wzx0Ms0KuHIGUELK/XiA1Tx
 o/Ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775756360; x=1776361160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=95UHS3IRRE/5T0I2i8qAJrDVmZDHXLiuSD8p/GWf1sM=;
 b=H3g5DHDQHxHtHiMrmMm9qdzjRrqiGEeFg3b+qp7Ti0Kr7TCyDabr2V3eBxjj/jluE4
 nvBUUT4jsv2tmKYtY5jEUXwHFnTi4yD3R0KjamO210R+hs5XQfMLt8S4gVQC036df8c+
 6GZacjWdk5QApXQG0qu7qXPyza31oE9BEeOlcB0rlloLs7kDrVh8AwRBmCznoZEDczjK
 3QEE3s3ZGp++B0G3boGNt3HVzph0CFEtvui6k1FmIDeYwkEWyJCO80y1kK+b/uWCjZUg
 LKA7SaQy1V/Et3KiY82f2XpnjZSloakOzvAcy8vZzP9GNaPKcsK6L5T7xTcBq/L9oEkO
 rDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775756360; x=1776361160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95UHS3IRRE/5T0I2i8qAJrDVmZDHXLiuSD8p/GWf1sM=;
 b=JsOSOHLDs1xC8tYrB08KVwxIuO49uS3DUMO+nMguX+S2XlKnc9FTKTJ0cxDFZR3H/I
 tUWjUSNqEz/q9aG0HRobZBlkMrhJVyoCW6xQTkNMDkp6ubIS3mKtJSGZPfL6gCR4J8Ep
 buhfAxD/Cv40r7f41bskEtu6BZfbYN1dCPA//uZ1fckqevj8Y79n4+nXMHiJQEFvDMer
 Wflc+t6oLXx9WVQfpX345F8a32Yk6OX2fs1eYxRVZwFlV633MLglectgcqtp5nnN4pi/
 1iME8jfExLqibR5OblFSVq7DeaBY2CqFSBqXyeyNzi8UldyzcFnWng3zvD6XFrCEMkdw
 RhMA==
X-Gm-Message-State: AOJu0YxTPIxzhvFyS2bfkiQtn/+Qungpbaou8j5CEXgYgHFhz5pGY8py
 xJwPGkG2MqqxjtgqGVjyGG4en6Jn05CGIk/OdnAAazjPkpqPZVyCxazXoch59xDLgX2TM/ZB7io
 zKBQ75XpkzYOd8wSFo8O0HtMP2qiLhE4=
X-Gm-Gg: AeBDietxkN/vs2JM91mtRAR/v+5nk9SEQitKy/IVEl7b4VyNaxVeOfLDe65ijVwIaqh
 bwgYLtVyt2YvVz5Ywi2kfatpVCN0vKNo8oQ6LirqOq2oULB+DVFrfWSVP9TYo+pIRld9G7ikgNp
 CNUIFeQZfTpAYSFNDMZokfX8xvWgUg9BY+hWHitrTag6idWqIaK1GU1cQJRt2zHtcWAx0YCRGF/
 9ASAgEC6cm5gMqenf55oruNOKvNFndyaqe9lO2YVVHzCNK39qJVAc6lDeSH9prPmzUbasu7VRJJ
 xJTrAgAEpBrTQbyzOBaC5A9JIUkDKR51DMQvFuvVuycURZ3MiA==
X-Received: by 2002:a05:6a00:bc8b:b0:81f:4e1c:1d3b with SMTP id
 d2e1a72fcca58-82dd8b2105amr4019292b3a.23.1775756359991; Thu, 09 Apr 2026
 10:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <12d1c25d334b2b97d61b7d1d5b972a89ba235587.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <12d1c25d334b2b97d61b7d1d5b972a89ba235587.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Apr 2026 11:39:08 -0600
X-Gm-Features: AQROBzBSSd9rjI9CfMSFIJV6intxIfaqwKC_VjUmjs4RW-fJWRmgstpu2dVso_U
Message-ID: <CAATN3NojPFisuy8tjr7bP3ZpYsjS6LmDMJbwWtQRQUKpu815OA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] tests/hexagon: add tests for HVX bfloat
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000000b859e064f0a7f7f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x434.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000000b859e064f0a7f7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hex_test.h   | 13 +++++++++
>  tests/tcg/hexagon/hvx_misc.h   | 30 ++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx.c     | 41 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx_cmp.c | 52 ++++++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx_cvt.c | 31 ++++++++++++++++++++
>  5 files changed, 167 insertions(+)
>
>
> diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c
> b/tests/tcg/hexagon/fp_hvx_cmp.c
> index c4e1c81ce5..4417e736f9 100644
> --- a/tests/tcg/hexagon/fp_hvx_cmp.c
> +++ b/tests/tcg/hexagon/fp_hvx_cmp.c
> @@ -22,9 +22,11 @@ int err;
>
>  #define MAX_TESTS_hf (MAX_VEC_SIZE_BYTES / 2)
>  #define MAX_TESTS_sf (MAX_VEC_SIZE_BYTES / 4)
> +#define MAX_TESTS_bf (MAX_VEC_SIZE_BYTES / 4)
>

Divide by 2, not 4.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000000b859e064f0a7f7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hex_test.h=C2=A0 =C2=A0| 13 +++++++++<br>
=C2=A0tests/tcg/hexagon/hvx_misc.h=C2=A0 =C2=A0| 30 ++++++++++++++++++++<br=
>
=C2=A0tests/tcg/hexagon/fp_hvx.c=C2=A0 =C2=A0 =C2=A0| 41 ++++++++++++++++++=
+++++++++<br>
=C2=A0tests/tcg/hexagon/fp_hvx_cmp.c | 52 +++++++++++++++++++++++++++++++++=
+<br>
=C2=A0tests/tcg/hexagon/fp_hvx_cvt.c | 31 ++++++++++++++++++++<br>
=C2=A05 files changed, 167 insertions(+)<br>
<br><br>diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c b/tests/tcg/hexagon/fp_=
hvx_cmp.c<br>
index c4e1c81ce5..4417e736f9 100644<br>
--- a/tests/tcg/hexagon/fp_hvx_cmp.c<br>
+++ b/tests/tcg/hexagon/fp_hvx_cmp.c<br>
@@ -22,9 +22,11 @@ int err;<br>
<br>
=C2=A0#define MAX_TESTS_hf (MAX_VEC_SIZE_BYTES / 2)<br>
=C2=A0#define MAX_TESTS_sf (MAX_VEC_SIZE_BYTES / 4)<br>
+#define MAX_TESTS_bf (MAX_VEC_SIZE_BYTES / 4)<br></blockquote><div><br></d=
iv><div>Divide by 2, not 4.</div><div>=C2=A0</div><div>Otherwise</div><div>=
Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com"=
>ltaylorsimpson@gmail.com</a>&gt;</div><div><br></div></div></div>

--0000000000000b859e064f0a7f7f--

