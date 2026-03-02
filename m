Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE0AFD0076
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 00:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwr6p-0002xx-Fk; Sun, 01 Mar 2026 19:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vwr6n-0002xO-Qg
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 19:26:01 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vwr6m-0001kU-39
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 19:26:01 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8274a3db5e3so1547916b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 16:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772411158; cv=none;
 d=google.com; s=arc-20240605;
 b=FmQki5spETiY99MA73YRhd04dTdSNVxNLdOW5NQz07FofkNJDsYnzsRMI1DFP6+3n+
 qf1K95s5qCVV8NsmmLozJupd0TlIA9VP++SFq0mpE5PWTJmZ2bWzKp5+cN4tJsD4fEfV
 RqinfdeQjl1LOEKRgIs1421UndEV9MkYBo8t50eN7WQI7MshLuVsIghrK+DVOtwnLal7
 LnCAzsdgWZsnUpMyEu8qrUFgjwN00POeIav+Lj7tErsZ0zrk2c18LM0UmwGKN2G9+bRZ
 DCs3S3ZyKUSHjqU2sscVYftFybxlzk6CE2LcCzZ9lvKPRLg4ZoPK819Ho0PIg6IVGjW2
 QQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XMNU+8A7AVgPbSOlHWBdSzcHSiYVaaFZ3C/VIpYBtJE=;
 fh=S3wkVjJ0k2ehCsPBOFKgM2AZkjL8wQJr/WvLyLTvNNE=;
 b=ev9ctbOpa0zzLu0cjbKIhSE58Vp+qzDFCI7Q5t5MYnKcfr0N0Zk1WEvKEbHT1DKO9R
 Tdmel84R8x+HVwY21HgZzRLN736BFpZ+4xs/njeDnHCtDvsqK5Y+ebfmWWrtNTrT7HBd
 OBChO7onFfFAQPMVlh9Uw8ayMj/LGqsNfnzu4piRaWgkUKHBPcSZOFL3vaHYzzseYrYV
 pipB5/1dS1n2e6YJwIkeEou1Oxw9EF1H/32vLloan8KJ5hNJBTc2EoDBqM4f17i2/2t3
 ILTuYBeYUUxaZ30dElVZz2FyrOydrNb0wVa7ygT/R1rKRqkiLeLLj9LBPE+ogmJzpSlq
 VncQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772411158; x=1773015958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XMNU+8A7AVgPbSOlHWBdSzcHSiYVaaFZ3C/VIpYBtJE=;
 b=glaGpJKeSIzv8Xn8fMcTmyHY+onhTWYu8sqegQlWEXLQdc+j8dpXSlPigUAGXg9nt6
 AZ83O2H+2D4w9vCRxbkRljezkPFAEHPcOS2+L0i0Kh/Ok4Qa9oRzBy2PE1P+VDwcfleE
 5sh8/N9WMWq8MJXmTed+EGuD0HW9v0KMrqLhOOlH2bx7zsNhGNa6++90jRHwYAcO4f1x
 31PpXwAdqmDtwu3BeXBOhBqv5+xtxk94nLtpcZoeRCwJ5D5Ip1/qdOfEul3T6HG3AXh8
 zVAWyIfSFqcp+20rN81pVI0ep4BnkUqoYPSowU6rQ8G4RfVfkzIwxpiSyQ0uOEbyT5N2
 qD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772411158; x=1773015958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMNU+8A7AVgPbSOlHWBdSzcHSiYVaaFZ3C/VIpYBtJE=;
 b=a/KarrnXqKZhOm4SMhdenXLC1jo2sQRlFzJLeUnDwlWwc43Dv5RzJ6/Bz8Fpls8tZc
 swX2C8/SOzU/DMU1e8WqHNiHz8dyo/Sey+r0D/RPJzp3YoksqxFWuZUPTWElk62rSLe7
 C8rDkQMU+DFto804p+neuoAvxC85vwHuV2GvTtTVLU0pbr+sKfzotWqcLrpsKjEslUvZ
 vTnv/jiPLV5YWq56xW23VeNm/BaQDo3PJCwiGIEaFbOCp9yHNjkSUwRutHJPmynWjcUi
 vfAAHhFCVzkiA3rqOLl40wXF/Nh0ZZGfqGxdN2ZRF8K4q2WoVXjbnnypRWlwtbeQbuBn
 3pow==
X-Gm-Message-State: AOJu0Yxs5RtT0VXVIkXSUK7cFEA5RtCFkflu5o8tdOIF5yrIhSaIHv/p
 a/wHYlpRWflzmdw2NuhPYAJl21/bxRXFoyLJ25+vKm5fXIrDvw7L8VFB4a/26R6jRIWrLP/XIfW
 VthtUcsmCdNiLWtkj283lOD0DYmzj96GngQ==
X-Gm-Gg: ATEYQzzjySkfj4NiXb3zAZZQs9M90nr4k3xj7Klc+shLolIAxDRr8kMvSv0FViv7FUs
 iBs1HALRkDKDeJab050KT0P+V4TBuX/u/iUoa78/vkG6P6AXV74cTl7BK1Ok1D6/tCwiBJGksjV
 XGfl70CT1nrhKohOW0fRrGcjTNNO1lMAuTMkH4TSoXpDoYh5LQGlneQJyRXP7XqjDrHaTCTwHa3
 IctTWcVhV5NALNtRCMl9+RrZSIZh7H7JQ33wSpyjDrbVN2HxlIIiYwQSVT5a22tIQH2Ttd3TgxU
 lhGXZhaxStKRBUuX+4/BzZQJwB3h3LVxg4Zqg+vOLWMrC1sheA==
X-Received: by 2002:a05:6a20:938b:b0:394:6646:d3eb with SMTP id
 adf61e73a8af0-395c3b3abf9mr10603794637.64.1772411158373; Sun, 01 Mar 2026
 16:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sun, 1 Mar 2026 17:25:47 -0700
X-Gm-Features: AaiRm51Kh1NTYnQkpXsr6c_yQuZTs7zwbbrDPk6qNHahwjJ71p8FRNE9I7e1hg4
Message-ID: <CAATN3NpEZB_pDB3BXMic2Ts4NgtmK1VOSnAvdE5u8rVcMxQcqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/hexagon: fix J2_jumptnew/pt predicate check to
 use LSB
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alexey Karyakin <akaryaki@qti.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000007daad5064bffa127"
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x429.google.com
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

--0000000000007daad5064bffa127
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:34=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> J2_jumptnew and J2_jumptnewpt passed the raw predicate value to
> gen_cond_jump(), checking if the full 8-bit value was non-zero.
> Refer to PRM Section 6.1.2 "predicate-consuming instructions examine
> only the least-significant bit".
>
> This inconsistency caused if (p0.new) jumps and if (p0.new) loads
> within the same packet to disagree when the predicate had values
> other than the ones generated by predicate-generating instructions
> (e.g. 0x80 or 0xAA where bit 0 is clear but the value is
> non-zero): the jump would be taken while the loads were skipped.
>
> Fix by routing both macros through fGEN_TCG_cond_jumpt(fLSBNEW(PuN)),
> matching the pattern used by every other predicated jump.
>
> Discovered-by: Alexey Karyakin <akaryaki@qti.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 7b96dab918..45ccd51888 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -951,9 +951,9 @@
>  #define fGEN_TCG_J2_jumpfpt(SHORTCODE) \
>      fGEN_TCG_cond_jumpf(fLSBOLD(PuV))
>  #define fGEN_TCG_J2_jumptnew(SHORTCODE) \
> -    gen_cond_jump(ctx, TCG_COND_EQ, PuN, riV)
> +    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
>  #define fGEN_TCG_J2_jumptnewpt(SHORTCODE) \
> -    gen_cond_jump(ctx, TCG_COND_EQ, PuN, riV)
> +    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
>  #define fGEN_TCG_J2_jumpfnewpt(SHORTCODE) \
>      fGEN_TCG_cond_jumpf(fLSBNEW(PuN))
>  #define fGEN_TCG_J2_jumpfnew(SHORTCODE) \
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000007daad5064bffa127
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 25,=
 2026 at 9:34=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">J2_jumptnew and J2_jumptnewpt passed=
 the raw predicate value to<br>
gen_cond_jump(), checking if the full 8-bit value was non-zero.<br>
Refer to PRM Section 6.1.2 &quot;predicate-consuming instructions examine<b=
r>
only the least-significant bit&quot;.<br>
<br>
This inconsistency caused if (<a href=3D"http://p0.new" rel=3D"noreferrer" =
target=3D"_blank">p0.new</a>) jumps and if (<a href=3D"http://p0.new" rel=
=3D"noreferrer" target=3D"_blank">p0.new</a>) loads<br>
within the same packet to disagree when the predicate had values<br>
other than the ones generated by predicate-generating instructions<br>
(e.g. 0x80 or 0xAA where bit 0 is clear but the value is<br>
non-zero): the jump would be taken while the loads were skipped.<br>
<br>
Fix by routing both macros through fGEN_TCG_cond_jumpt(fLSBNEW(PuN)),<br>
matching the pattern used by every other predicated jump.<br>
<br>
Discovered-by: Alexey Karyakin &lt;<a href=3D"mailto:akaryaki@qti.qualcomm.=
com" target=3D"_blank">akaryaki@qti.qualcomm.com</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/gen_tcg.h | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h<br>
index 7b96dab918..45ccd51888 100644<br>
--- a/target/hexagon/gen_tcg.h<br>
+++ b/target/hexagon/gen_tcg.h<br>
@@ -951,9 +951,9 @@<br>
=C2=A0#define fGEN_TCG_J2_jumpfpt(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0fGEN_TCG_cond_jumpf(fLSBOLD(PuV))<br>
=C2=A0#define fGEN_TCG_J2_jumptnew(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_EQ, PuN, riV)<br>
+=C2=A0 =C2=A0 fGEN_TCG_cond_jumpt(fLSBNEW(PuN))<br>
=C2=A0#define fGEN_TCG_J2_jumptnewpt(SHORTCODE) \<br>
-=C2=A0 =C2=A0 gen_cond_jump(ctx, TCG_COND_EQ, PuN, riV)<br>
+=C2=A0 =C2=A0 fGEN_TCG_cond_jumpt(fLSBNEW(PuN))<br>
=C2=A0#define fGEN_TCG_J2_jumpfnewpt(SHORTCODE) \<br>
=C2=A0 =C2=A0 =C2=A0fGEN_TCG_cond_jumpf(fLSBNEW(PuN))<br>
=C2=A0#define fGEN_TCG_J2_jumpfnew(SHORTCODE) \<br></blockquote><div><br></=
div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@g=
mail.com">ltaylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--0000000000007daad5064bffa127--

