Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D649DEE0AF1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 21:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voqJz-0006iP-Hs; Sat, 07 Feb 2026 16:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqJr-0006i3-CN
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:58:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1voqJp-0005iR-Hv
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:58:23 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a9042df9a2so9858355ad.2
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 13:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770501500; cv=none;
 d=google.com; s=arc-20240605;
 b=SnmhSLJi3AZYbhSv8KOtcXMk1qkqeWHqIhDtqEw1e1bnnVUNLDBFArGcI4qXX2K5Py
 RN8nfXzSwouJVlGWUmWaqQN/LXIlqL/s5xwIF7KvAt80J9MiFhuJyoeehOilMao1dLUn
 lhQpQnVUoni2SMwL0e7tjezLWPn9GHJbDIYrBUUdsco0QS4jcFdpQoiocjHEP9oTTgIE
 19zMLZxeZfcGYQcFcqAS45CRHYMUTyiNJPTAoj+W+IJpCPRSHNaLHOjx7HiOUVk/dbz9
 Y0gpzCKhxVvqxQjmvPdfLN7vpry8xTQEgNzNN1zEyV37Tqy7XJ3kspxwyL6Bkt2stE6h
 j7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qw7w9+WdaMXeH6uwe83It4wrVF/857gReZ1FfSJYaj8=;
 fh=3m1aKdVwiiAQeDysI/JPLFyw7hm3fA2/ymZW6NmRwXE=;
 b=XIF6+khTKj7Kyr7qL0wAmzPHwPokVpm3YNR8gH6qc6FAB2TVmurbnVrMLfdYx8IRCE
 UQSCcuuIJTZfqxt84J4x4jUY9d6csZH+UrjkStlDd2e2JTfOUMVNDNKeHIWaIncJfr4R
 Y6ehCuMQ/m7A8wkeRIuHX4/ukueJlt4DvzKETQ9ZaCQtbmumbpCZQw1/sSeLurOw2CRE
 6fdxc3sgrcw3Q3psyjIw9QDvft3xiKKwCigahfOmtegUpzHlT7JwP03382N8lV2F1gJm
 aSezPD/vWf1Ef3PJNihERqLQLfroiILveiA3xF3Vu6RmFDH6kmaDszHa2EJsqMrn4W1L
 8aFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770501500; x=1771106300; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qw7w9+WdaMXeH6uwe83It4wrVF/857gReZ1FfSJYaj8=;
 b=Rj+D69G7f0zAngHoLsz72M9imYnNkJVYCk6ZonzTuZ8nAv5Rvnl3nHmc4bDeZ02xuo
 fMBVOirwyfe83EuK3JB+LGgd4ERfnpzXPMiu2/VRBIyv02r7bn8WsfOmd28ppulrIadB
 vgFalRMRBXJvPq+YNg1rrGxF0gaqa01/FKgJODNZZP8MVxQhDujbus+XXJZJK9mrlrwm
 K+BH1DpEIDanpAGUCAQbsIch1RqpaW7LxEW8qjSgaNAejREbjfO5VuW9lw40PGaSo7n+
 vdgnZcG6XmbycmHb4WbxMDzFLAzjDxNtjD5SwuRnxqydVnpKB6Jv6zRNdGP1dad6xxJ9
 boOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770501500; x=1771106300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qw7w9+WdaMXeH6uwe83It4wrVF/857gReZ1FfSJYaj8=;
 b=T0NhRt57nQhdoRWXkeOthtK7OI+d0FoIsatoTjNmVXB3+8gL/Rzwqf0crZ34ua+Poz
 RdRmfHd3Zv4dnzPINu6mIyjpHePx6Io61QTqYHksDDJBleWoBXoSBwqhLz/N/tAy0zbq
 QuSmIx1J2dHeUXN1b148SFYByzPZBiWlDmpAgnw7Vw6avuZLPa1UeNFgVtlveMHZpto+
 dI2WAmk0kGpu3Wd1s88yP3AKD6QvgZTJyTxueesxWcPKP8dgPAAv7kQgqrp16gy7AqPU
 1RXnxSTNRu0TNumsFy0yaPMtph3E8Bjce4QtWcBFpQREUk2CdNY/8dRbxqc2SHz1/W21
 wxBg==
X-Gm-Message-State: AOJu0YyJx/ixuV3ySc5qhciZZN24sYb/FUI8dE0cvKA78+4T2uZ88ZmS
 v2Pr9mTxL/gxpA88s6ypUl/lwtZ/JPbGe0SDif1j2kh4sU/GxbEylw6MgbIPhCjiEyFYq6qKxr4
 m3c2Z1pANCnzq5X6bIGygHJp2vbNHvvU=
X-Gm-Gg: AZuq6aIf5ep+omwP0ZVcCZmdFRcx7aAM4VUURSvx7dES6tvweH3z6ATS5pf9WitI/lS
 CxKLf23vxiuOWghLn1pcaanQmZ2Z4Hh6UI0tNJCBS5eSce87njsEDBzmwD0qAQr0IZ7ruDUZPac
 Vi+mjw+LTxxn6u+Y8KXld1cMhqPEwaiaqBOsLtb3RyTFhNe7NUzvc1WpowNKjZP5wY2m9TSQ1bR
 BZBua+7qvg78BM12HMPfxjSEJipRV7doWvgy0o4ImndF3oka6nXDxmW+0mGhHARPconyl2oFudK
 BQi/02HfshN+NfLcILy6rnL8cVs=
X-Received: by 2002:a17:902:ce12:b0:2a0:97d2:a264 with SMTP id
 d9443c01a7336-2a95180ea22mr62438945ad.37.1770501499874; Sat, 07 Feb 2026
 13:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
 <20260207180632.1042754-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260207180632.1042754-3-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 7 Feb 2026 14:58:08 -0700
X-Gm-Features: AZwV_QiAUnwu_qUEw2crbHBQ4AfejRVuB84PAFdIrvTEAM9kCCaFXCudYsydAnI
Message-ID: <CAATN3Noay=pVLA5-d8MMYMLq=QDSwX2zQZwdt1mzA-cjdCV0Eg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] target/hexagon: Reject duplex encodings with
 duplicate dest registers
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f96fb7064a4300e1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x634.google.com
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

--000000000000f96fb7064a4300e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 11:06=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> A duplex encoding like 0x00000000 decodes as two loads that both write r0=
.
>
> Add a check in decode_insns() after both sub-instructions decode
> successfully to verify they don't write the same destination register.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2696
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  target/hexagon/decode.c              | 12 ++++++++++++
>  tests/tcg/hexagon/invalid-encoding.c | 29 ++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index 69ba1ec96c..90499fc320 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -501,12 +501,24 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_=
t
> encoding)
>
>          /* The slot1 subinsn needs to be in the packet first */
>          if (decode_slot1_subinsn(ctx, slot1_subinsn)) {
> +            Insn *slot1_insn =3D insn;
>              insn->generate =3D opcode_genptr[insn->opcode];
>              insn->iclass =3D iclass_bits(encoding);
>              ctx->insn =3D ++insn;
>              if (decode_slot0_subinsn(ctx, slot0_subinsn)) {
>                  insn->generate =3D opcode_genptr[insn->opcode];
>                  insn->iclass =3D iclass_bits(encoding);
> +                /*
> +                 * Check that the two sub-instructions don't write the
> same
> +                 * destination register (e.g., encoding 0x0 decodes as t=
wo
> +                 * loads both writing R0, which is an invalid packet).
> +                 */
> +                if (insn->dest_idx >=3D 0 && slot1_insn->dest_idx >=3D 0=
 &&
> +                    insn->regno[insn->dest_idx] =3D=3D
> +                        slot1_insn->regno[slot1_insn->dest_idx]) {
> +                    ctx->insn =3D --insn;
> +                    return 0;
> +                }
>
> Isn't this a more general problem than what is checked here?  What if two
non-duplex instructions write the same register?  What if an instruction
writes more than one register (e.g., post-increment load)?

Let the decoding go ahead and finish, then add a check for duplicate writes
for the whole packet.  Look at ctx_log_reg_write - called during
analyze_packet.

Thanks,
Taylor

--000000000000f96fb7064a4300e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Feb 7, =
2026 at 11:06=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">A duplex encoding like 0x00000000 de=
codes as two loads that both write r0.<br>
<br>
Add a check in decode_insns() after both sub-instructions decode<br>
successfully to verify they don&#39;t write the same destination register.<=
br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2696" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2696</a><br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro=
.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 12 ++++++++++++<br>
=C2=A0tests/tcg/hexagon/invalid-encoding.c | 29 +++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 41 insertions(+)<br>
<br>
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
index 69ba1ec96c..90499fc320 100644<br>
--- a/target/hexagon/decode.c<br>
+++ b/target/hexagon/decode.c<br>
@@ -501,12 +501,24 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t =
encoding)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The slot1 subinsn needs to be in the p=
acket first */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (decode_slot1_subinsn(ctx, slot1_subin=
sn)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *slot1_insn =3D insn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0insn-&gt;generate =3D opcod=
e_genptr[insn-&gt;opcode];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0insn-&gt;iclass =3D iclass_=
bits(encoding);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;insn =3D ++insn;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (decode_slot0_subinsn(ct=
x, slot0_subinsn)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0insn-&gt;gene=
rate =3D opcode_genptr[insn-&gt;opcode];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0insn-&gt;icla=
ss =3D iclass_bits(encoding);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Check that=
 the two sub-instructions don&#39;t write the same<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* destinatio=
n register (e.g., encoding 0x0 decodes as two<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* loads both=
 writing R0, which is an invalid packet).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;dest_=
idx &gt;=3D 0 &amp;&amp; slot1_insn-&gt;dest_idx &gt;=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insn=
-&gt;regno[insn-&gt;dest_idx] =3D=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 slot1_insn-&gt;regno[slot1_insn-&gt;dest_idx]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-=
&gt;insn =3D --insn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><br></blockqu=
ote><div>Isn&#39;t this a more general problem than what is checked here?=
=C2=A0 What if two non-duplex instructions write the same register?=C2=A0 W=
hat if an instruction writes more than one register (e.g., post-increment l=
oad)?</div><div><br></div><div>Let the decoding go ahead and finish, then a=
dd a check for duplicate writes for the whole packet.=C2=A0 Look at ctx_log=
_reg_write - called during analyze_packet.</div><div><br></div><div>Thanks,=
</div><div>Taylor</div><div><br></div></div></div>

--000000000000f96fb7064a4300e1--

