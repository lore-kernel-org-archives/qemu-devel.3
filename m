Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF0BFEC100
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57Zi-0001mg-2l; Tue, 24 Mar 2026 15:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57Zf-0001mL-Tm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:37:59 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w57Ze-00078D-5z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:37:59 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c7412b07f22so100292a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774381076; cv=none;
 d=google.com; s=arc-20240605;
 b=gblUYUgsrCqtXGl8ZD9X32OLIa4OTZMm69dNXFCTbHl/Bwr+/ZuHhP4+Xp7XP+fG9i
 Uk2kVYLPepre5IB+zHziMQBW3EZlus277+RRf5JCpbBB0/XIcFlhOxNjhNLNHbl60RQm
 dqQuVEdga2x+zsbfhSCEFhpyR3th/4Q0HEFM23IRVDeTkB/ywgRB7f1cWfH95Kw8Mei2
 x+gPLBSm85p3nqUXcOTelerbnj0P7apS+2+QUcr4U1bJkmLO+ENkNB+x64OxMniIGVLl
 hIV3zr2J7XXeqJmS2GWZpTvdA9bcDj4aRAzDNkRFj9Rs+HqKuUYovqHZLzRWizsIC8q5
 qijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E4jg651gMRtWJp/UaSbfM+bz2mMjaNZQ1mOz69vomQM=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=OIGqJhGVYVaZqLADFZgwHQhpp2dsvqmgXjoQeavT4s2mAtAAxqCV984Y5Lahm05bQr
 QdiXavPxKoG4zSpEB0yXB/gsleCgkwK5DU9uaI6ZZDAL9yTzkx4d7FjRG0reIkn2Pv4j
 jNTvdwy0IhsVEpbYo3thlCrpVA90AOQL7Gi1AMPR5B1imcqCPTMdP1tW8i5ALC5vz4aI
 MnhOwC5wKKLkOWCyhOKi98tCineTiZanvFh5sr9MNJQE+i2A75nm5SzOnoMeV/vg+QfV
 bv6qDe3I30BHUXlzrfj639KwuVDc+cqvKXfF8pSdxvUwoJYn6Yc7wRnINcT1kwRGFV6+
 /+tQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774381076; x=1774985876; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E4jg651gMRtWJp/UaSbfM+bz2mMjaNZQ1mOz69vomQM=;
 b=UwIxxAP7Ta99Zu7HVyU7Ue9A1FH6Y+Ww9sUwxJYX5EEafDllgGchS+bKLAVbAS+Vvb
 PbWT072efP9Pd5+SEgCFKkjMPb1CYuwFGBqzK4bPrXlfcWK8M11ZUJkNJKGA6KaFx19Y
 4+sBYQnLpwDNV8q5/9dDxyjk0g1NX2Le8giXRYJx+QSzbuZHzTCywuIrcu6gCRYNBtLw
 WGKfG6zuhHGLqqPq6g3+At7ayyFX5McEuPpc+2JvdJu9uLxA2taKIeYI06ZXTxgxsMS/
 14Efr8f6heGJ4A43rojFxO3/f7drFresupJij3tjRpQy55tR6/4H91jgwSOnTGASjVcl
 OHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381076; x=1774985876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4jg651gMRtWJp/UaSbfM+bz2mMjaNZQ1mOz69vomQM=;
 b=dttsX4XT2ULS5Ia4ivDASUbIpn2Yhv05y/aNBZqCTwaaSX6/rR5AUUM+5+d+ubN3b7
 cyWuFY/ZmHxQNs3lwGxZC8ZjALm5IfUd3CWRyNiFu9UBsQL+WkvaHlbCwGT/tBbOLqc0
 16iCHIK8fe/MAP5RyG+YuboVFXTUILOwS5yxvPvSLea79c4OGKL4Ac1LJjrOtklsRVd/
 TvHIQ22BLO3X9cb/bcX/DBv2jJROXqlNdFGwMNctktmNDPKwycATPpAZcBs0Ij5nUIfn
 DokXulcZE9NittfKUraltnuGU0CxGHGTzX5x53wHMa3bgG3O8GfxGZsDqtpRKsljjuk6
 3FTA==
X-Gm-Message-State: AOJu0YzNQTCfc5/FLwEahaZhj0GDqgGTL4aEbxp/NyCtw1MJ0L2sDaFA
 kN51BgZ9LEOc1bk4Bfbog9pZB91jTRZAgFY1emG72aSihAQY0G1YD9JVltTnWwtlAAJq7FOzGZZ
 aKjLEV1t5fiNvl+DizwLI/qHE+EKcs9c=
X-Gm-Gg: ATEYQzzPgb6s16eVKE/MmY0QyyqAhC+fpZUQW4OusjpxYeCdTRIDuE69tuADfXS2Oy9
 Xvm2dYWxgei6sTnc2gRHlebCznlgXh5SzMLa+y+5oKhco75NjFib0Y7rVARgbGjihRym0bDAk6Z
 zGNzsdt1eYhZeVLmV9RLzfpRG2ZQvnbPCIf5BS0qKfw8bUWTtFwtzYEsdiOmk4n4rUnxTDzXGnA
 uf4cKTfrC9FHB1jgv5JEyNE160PKZwCN+ciRTpDx7fV75Kcdr/0gjoZMmR8LHpQyzlrbMyvJPhd
 /LSCH68Mtla4etiTbK4eWbxPz7dyUSCqNdqGTnw=
X-Received: by 2002:a17:903:388c:b0:2ae:5346:d4e6 with SMTP id
 d9443c01a7336-2b0a4e5ef51mr44588955ad.28.1774381075992; Tue, 24 Mar 2026
 12:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <76a65d4bf9062558256d29756e9e847d18692be9.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <76a65d4bf9062558256d29756e9e847d18692be9.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 13:37:44 -0600
X-Gm-Features: AaiRm52AasZXXiThThEEDgbVFmIXRy_rgBXc1i_srszpPpOfepAIHreEk1dR0gY
Message-ID: <CAATN3NqtZ67=PuqAY7UdKNqSNXOhWJkFX9e8e=vLKL1MHwfFDQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] tests/hexagon: add tests for v68 HVX IEEE float
 comparisons
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000bb16fa064dca49a4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52b.google.com
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

--000000000000bb16fa064dca49a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hex_test.h      |  1 +
>  tests/tcg/hexagon/fp_hvx_cmp.c    | 58 +++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target |  3 ++
>  3 files changed, 62 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
>
> diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c
> b/tests/tcg/hexagon/fp_hvx_cmp.c
> new file mode 100644
> index 0000000000..e925c973f3
> --- /dev/null
> +++ b/tests/tcg/hexagon/fp_hvx_cmp.c
> @@ -0,0 +1,58 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <hexagon_types.h>
> +#include <hvx_hexagon_protos.h>
> +
> +#if __HEXAGON_ARCH__ > 75
> +#error "After v75, compiler will replace some FP HVX instructions."
> +#endif
> +
> +int err;
> +#include "hvx_misc.h"
> +#include "hex_test.h"
> +
> +#define TEST_CMP(VAL1, VAL2, EXP) do { \
> +    ((MMVector *)&buffers[0])->sf[index] =3D VAL1; \
> +    ((MMVector *)&buffers[1])->sf[index] =3D VAL2; \
> +    expect[0].w[index] =3D EXP ? 0xffffffff : 0; \
> +    index++; \
> +} while (0)
> +
> +int main(void)
> +{
> +    HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0];
> +    HVX_Vector buffers[2], true_vec, false_vec;
> +    HVX_VectorPred pred;
> +    int index =3D 0;
> +
> +    memset(&buffers, 0, sizeof(buffers));
> +    memset(expect, 0, sizeof(expect));
> +    memset(&true_vec, 0xff, sizeof(true_vec));
> +    memset(&false_vec, 0, sizeof(false_vec));
> +
> +    TEST_CMP(raw_sf(2.2),  raw_sf(2.1),  true);
> +    TEST_CMP(raw_sf(2.2),  raw_sf(2.2),  false);
> +    TEST_CMP(raw_sf(0),    raw_sf(-2.2), true);
> +    TEST_CMP(SF_SNaN,      SF_SNaN,      false);
> +    TEST_CMP(SF_INF,       SF_INF_neg,   true);
> +    TEST_CMP(SF_INF_neg,   SF_INF,       false);
> +    TEST_CMP(SF_SNaN,      SF_QNaN,      false);
> +    TEST_CMP(SF_QNaN,      SF_SNaN,      true);
> +    TEST_CMP(SF_QNaN,      SF_QNaN_neg,  true);
> +
> +    pred =3D Q6_Q_vcmp_gt_VsfVsf(buffers[0], buffers[1]);
> +    *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);
> +
> +    check_output_sf(__LINE__, 1);
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
>

We should add some half-float tests as well as and/or/xor versions.
Also, check the FP flags.
Finally, we should add another test for bfloat.

Thanks,
Taylor

--000000000000bb16fa064dca49a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hex_test.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0tests/tcg/hexagon/fp_hvx_cmp.c=C2=A0 =C2=A0 | 58 ++++++++++++++++++++=
+++++++++++<br>
=C2=A0tests/tcg/hexagon/Makefile.target |=C2=A0 3 ++<br>
=C2=A03 files changed, 62 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c<br>
<br>diff --git a/tests/tcg/hexagon/fp_hvx_cmp.c b/tests/tcg/hexagon/fp_hvx_=
cmp.c<br>
new file mode 100644<br>
index 0000000000..e925c973f3<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/fp_hvx_cmp.c<br>
@@ -0,0 +1,58 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;hexagon_types.h&gt;<br>
+#include &lt;hvx_hexagon_protos.h&gt;<br>
+<br>
+#if __HEXAGON_ARCH__ &gt; 75<br>
+#error &quot;After v75, compiler will replace some FP HVX instructions.&qu=
ot;<br>
+#endif<br>
+<br>
+int err;<br>
+#include &quot;hvx_misc.h&quot;<br>
+#include &quot;hex_test.h&quot;<br>
+<br>
+#define TEST_CMP(VAL1, VAL2, EXP) do { \<br>
+=C2=A0 =C2=A0 ((MMVector *)&amp;buffers[0])-&gt;sf[index] =3D VAL1; \<br>
+=C2=A0 =C2=A0 ((MMVector *)&amp;buffers[1])-&gt;sf[index] =3D VAL2; \<br>
+=C2=A0 =C2=A0 expect[0].w[index] =3D EXP ? 0xffffffff : 0; \<br>
+=C2=A0 =C2=A0 index++; \<br>
+} while (0)<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 HVX_Vector *hvx_output =3D (HVX_Vector *)&amp;output[0];<br>
+=C2=A0 =C2=A0 HVX_Vector buffers[2], true_vec, false_vec;<br>
+=C2=A0 =C2=A0 HVX_VectorPred pred;<br>
+=C2=A0 =C2=A0 int index =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 memset(&amp;buffers, 0, sizeof(buffers));<br>
+=C2=A0 =C2=A0 memset(expect, 0, sizeof(expect));<br>
+=C2=A0 =C2=A0 memset(&amp;true_vec, 0xff, sizeof(true_vec));<br>
+=C2=A0 =C2=A0 memset(&amp;false_vec, 0, sizeof(false_vec));<br>
+<br>
+=C2=A0 =C2=A0 TEST_CMP(raw_sf(2.2),=C2=A0 raw_sf(2.1),=C2=A0 true);<br>
+=C2=A0 =C2=A0 TEST_CMP(raw_sf(2.2),=C2=A0 raw_sf(2.2),=C2=A0 false);<br>
+=C2=A0 =C2=A0 TEST_CMP(raw_sf(0),=C2=A0 =C2=A0 raw_sf(-2.2), true);<br>
+=C2=A0 =C2=A0 TEST_CMP(SF_SNaN,=C2=A0 =C2=A0 =C2=A0 SF_SNaN,=C2=A0 =C2=A0 =
=C2=A0 false);<br>
+=C2=A0 =C2=A0 TEST_CMP(SF_INF,=C2=A0 =C2=A0 =C2=A0 =C2=A0SF_INF_neg,=C2=A0=
 =C2=A0true);<br>
+=C2=A0 =C2=A0 TEST_CMP(SF_INF_neg,=C2=A0 =C2=A0SF_INF,=C2=A0 =C2=A0 =C2=A0=
 =C2=A0false);<br>
+=C2=A0 =C2=A0 TEST_CMP(SF_SNaN,=C2=A0 =C2=A0 =C2=A0 SF_QNaN,=C2=A0 =C2=A0 =
=C2=A0 false);<br>
+=C2=A0 =C2=A0 TEST_CMP(SF_QNaN,=C2=A0 =C2=A0 =C2=A0 SF_SNaN,=C2=A0 =C2=A0 =
=C2=A0 true);<br>
+=C2=A0 =C2=A0 TEST_CMP(SF_QNaN,=C2=A0 =C2=A0 =C2=A0 SF_QNaN_neg,=C2=A0 tru=
e);<br>
+<br>
+=C2=A0 =C2=A0 pred =3D Q6_Q_vcmp_gt_VsfVsf(buffers[0], buffers[1]);<br>
+=C2=A0 =C2=A0 *hvx_output =3D Q6_V_vmux_QVV(pred, true_vec, false_vec);<br=
>
+<br>
+=C2=A0 =C2=A0 check_output_sf(__LINE__, 1);<br>
+<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br></blockquote><div><br></div><div>We should add some half-float tests =
as well as and/or/xor versions.</div><div>Also, check the FP flags.</div><d=
iv>Finally, we should add another test for bfloat.</div><div><br></div><div=
>Thanks,</div><div>Taylor</div><div><br></div></div></div>

--000000000000bb16fa064dca49a4--

