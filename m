Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A42CD58CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4n39-0004pO-8g; Mon, 23 Mar 2026 17:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4n37-0004p1-72
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:43:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4n35-0002yt-JD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:43:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a9296b3926so5339755ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 14:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774302178; cv=none;
 d=google.com; s=arc-20240605;
 b=Q4e7XiKZYBnHIp3ORWG5vZToUBLBC+lkUAGyMnziDlMe7d3ewAiTqm4u0hyUVkAeHo
 TF9QueOz/8rW1x9Civw2QVnc2KQ6M4yGl7Tjy8gCProqcS0JNUY9FOFSMdahPRKIkxWL
 djtIMa2dGVCLaVafiwRQ4M6Eq+Wy5VZsMmrnL8dtvcepSI0728uWjaALNvtTDGpAHYdz
 Phh/5opffZdKq1JErFKuj6embWNf5eW3r5RvklPuc54urMC8AkDniToFR/BfGLsyES86
 yTeEc5B/sK8EWp7zqrg3pyuWQ1pMh4JeOCm9nhaD54AvOQHQL6SRPNwrc47QL+QSTQtq
 +g4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bzTtdEwzP739kZ534d8JBx6Y6R5sdXXXIPJp/pSCvNw=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=LadCJ46/emG2pRYnL90Ubg816AmuJ53wrg/TLzy6XIpyfuHm2zEqUeN45pUlj7VP4e
 2u5tC5t29VVAnVkxOPXdqCC5bD0ESLP9/gJ2FXJobsYTTDT948rFxCwi/eoxQgAoLXOZ
 wb13BuZZLqa3R8OKygAZdRaSQAOYo+BV3lRoi9Y90WVVdRYamd7mf+FY5P0g2uVyT4bD
 iBB1RUcSmmwaciwHzZPrePQ9Yr7QVMxfVhMMbBrc+NMKlhCnsoQSG4uId4T0WkGiFrPj
 hP8lsnsa64i9TnVYbXK/nFDz5HFyoFl391Lyy+uTqSwuI33APALkfZMGTUkNdnn4lXCa
 z53w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774302178; x=1774906978; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bzTtdEwzP739kZ534d8JBx6Y6R5sdXXXIPJp/pSCvNw=;
 b=pWx/NaEKtUuamS3XxrayzGiDIK0lpk8VRu3PvpZtSs213EdIiETCKCccHx83edLM2S
 FjkWmVaTybshw5GoNcpQ9w5TABo+T5EoKt4yzj/ghYVIc6CrtZ1Yp/KGNrB0Zmst3QlL
 Dabs717b0BzK40cCE0etsfELd3hIB4EdYderE7M6l0zKPEtSByOFPJB5lcqwSEWPDuAz
 vRpNbsZNj8l4weqRUIApjz1aER//KVUFRIcFhW3YG7sXTpGnKHPAbEMQyoMKosbDPzOH
 WqiwKLc1fz0Xv+J0BBtsaqtiOVQ7EaMK+gfBDolH4Deqg6IGaLFtHbEIUXev12ICjbQD
 TFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774302178; x=1774906978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzTtdEwzP739kZ534d8JBx6Y6R5sdXXXIPJp/pSCvNw=;
 b=RR6mRa8kUZvkPHvEkQKqMEiYaO2pZN2ROG1MFUd/YXA7sLSGT6o/qnpWok/dPu8X/Q
 Hm5OKQ11TD0CSFqUfDnhrh+JDkAoFlFUQc55szldXM2B7sTj8x883x8nGi6v/UzB8xfq
 X5aXxXiwu8HkHB9KEqEiryu3nn9NuhJv0H42LHf/DumETZPy0HIvoSmyWYZwBtxcKci5
 kFRq7EY337I27WIn8HlFnBdSlW3SJuemWOjUwjRyARUi5L9fDRhAbHFnaK0t2AGKnztI
 IPlqoXy4DLUkMWcAHICS8iEjcu3GLDp4/Akqs7sziBYcSn0wsowig0lqYIYZlSPss1kD
 pvqQ==
X-Gm-Message-State: AOJu0Ywkv1f3Vlf8RdyNGRU2KDzcg8KURTpjUdBcI7rUzOQLPYCN+0bS
 36194vGtsvtP7DKv7W8xTP0wsn2jxO4VwHbBQ5Ia2lJmcxLmVBfAyPmF4Oa3jft0UYefx9yUfJJ
 5seCjKcMJP6WItLZ7Afgdfl5mqjZKt+U=
X-Gm-Gg: ATEYQzyKcc6qLVrycJaTTUM+c7n9muEkvlJjq1eFWxODbe5qS3XBh2mz4OZcIbVZ76O
 XDIH0L8p3InE2Zw1Ya1O7eThsEKqG0U8fA+WpTsXNf7Rjgo+9u+rnuZvo0CftDIrGFK0SNJ+5IC
 CZmjFdJa0s6DaCXuzUWpfVni7Q2kNmLxK2ZZm9zMzXpMMjjAkCnkLA/nuinIqh0n4OKwScOVe/T
 JUtL5opj8g1aqsw3v2GSQKfPTEy3vZ45KmpdVyrVMayOClDNMpGb2dhsHYQrYb30nRY9R+kgNNe
 jUhp1szt+GWUhSnE7rH4RV0BeDSIYYPLCTPxg+SYQRGbXiRzSQ==
X-Received: by 2002:a17:903:1247:b0:2b0:6d2d:f1d7 with SMTP id
 d9443c01a7336-2b0827cab9amr133137135ad.48.1774302178002; Mon, 23 Mar 2026
 14:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <c687d91e8ad5b476593aa1969113e8c51987f156.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <c687d91e8ad5b476593aa1969113e8c51987f156.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 15:42:46 -0600
X-Gm-Features: AaiRm51nv5oo13DBTDFmuCnGC8m_1K6vbTgMUHEAqh2a2uE8K3b305FlOO1WH78
Message-ID: <CAATN3NpAk+oPcPgiBwauV12-kk3H8E=v9ytv3ifSMuS=0r-K8w@mail.gmail.com>
Subject: Re: [PATCH 08/13] target/hexagon: add v68 HVX IEEE float compare insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000000b49aa064db7eb4b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62f.google.com
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

--0000000000000b49aa064db7eb4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point compare instructions:
> - V6_vgthf, V6_vgtsf: greater-than compare
> - V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
> - V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
> - V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/macros.h                | 10 ++++
>  target/hexagon/attribs_def.h.inc             |  2 +
>  target/hexagon/hex_common.py                 |  1 +
>  target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
>  target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
>  5 files changed, 84 insertions(+)
>
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.=
h
> index 2af3d2d747..c342507d1a 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -356,4 +356,14 @@
>                 extract32(VAL, POS * 8, 8); \
>      } while (0);
>
> +#define fCMPGT_SF(A, B) \
> +    (float32_is_any_nan(A) || float32_is_any_nan(B) ? \
> +     (int32_t)(A) > (int32_t)(B) : \
>

Seems odd to do an integer comparison of two NaN's


> +     float32_compare((A), (B), &env->fp_status) =3D=3D float_relation_gr=
eater)
> +
> +#define fCMPGT_HF(A, B) \
> +    (float16_is_any_nan(A) || float16_is_any_nan(B) ? \
> +    (int16_t)(A) > (int16_t)(B) : \
>

Ditto


> +    float16_compare((A), (B), &env->fp_status) =3D=3D float_relation_gre=
ater)
> +
>  #endif
>

Thanks,
Taylor

--0000000000000b49aa064db7eb4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point compare instructions:<br>
- V6_vgthf, V6_vgtsf: greater-than compare<br>
- V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and<br>
- V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or<br>
- V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 10 ++++<br>
=C2=A0target/hexagon/attribs_def.h.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 10 ++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 61=
 ++++++++++++++++++++<br>
=C2=A05 files changed, 84 insertions(+)<br>
<br>
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h<=
br>
index 2af3d2d747..c342507d1a 100644<br>
--- a/target/hexagon/mmvec/macros.h<br>
+++ b/target/hexagon/mmvec/macros.h<br>
@@ -356,4 +356,14 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extract32(VAL, POS =
* 8, 8); \<br>
=C2=A0 =C2=A0 =C2=A0} while (0);<br>
<br>
+#define fCMPGT_SF(A, B) \<br>
+=C2=A0 =C2=A0 (float32_is_any_nan(A) || float32_is_any_nan(B) ? \<br>
+=C2=A0 =C2=A0 =C2=A0(int32_t)(A) &gt; (int32_t)(B) : \<br></blockquote><di=
v><br></div><div>Seems odd to do an integer comparison of two NaN&#39;s</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0float32_compare((A), (B), &amp;env-&gt;fp_status) =3D=
=3D float_relation_greater)<br>
+<br>
+#define fCMPGT_HF(A, B) \<br>
+=C2=A0 =C2=A0 (float16_is_any_nan(A) || float16_is_any_nan(B) ? \<br>
+=C2=A0 =C2=A0 (int16_t)(A) &gt; (int16_t)(B) : \<br></blockquote><div><br>=
</div><div>Ditto</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
+=C2=A0 =C2=A0 float16_compare((A), (B), &amp;env-&gt;fp_status) =3D=3D flo=
at_relation_greater)<br>
+<br>
=C2=A0#endif<br></blockquote><div><br></div><div>Thanks,</div><div>Taylor</=
div><div>=C2=A0</div></div></div>

--0000000000000b49aa064db7eb4b--

