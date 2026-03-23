Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C445F483E7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4l1O-0004my-AP; Mon, 23 Mar 2026 15:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4l1N-0004mm-Bo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:33:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4l1L-00047k-L3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:33:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b0586d5bb8so32903595ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 12:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294382; cv=none;
 d=google.com; s=arc-20240605;
 b=LX5XKpP67kdqfaDsHme4/sMjLw/L7I44pQDhHUrv712DUtOMGSye/wzygNsmnaFTdl
 0y1FgVq6RUgjv3WPEYRDAF1+ivZII1WqUFfQCKeWzaNNwbs/MVwhQGIUbj+ZG5h74Hz+
 SptPZGXGObwvHsgsekN9LN9JHDERlYWf09QXJO5yC8t+qwGqeGMk86PVccoJCA7/YwMX
 GXKfFRzj4wP3LYVZi7581cfLpRtbB9Apc8uZO+XPIzoW7/avjFVfiVOhxF7EZ6sAOtYZ
 k7vTHGJK2vcxywZvijTlCc4hPkaqNF5gAlS58MlrHyWRDpwGPjqp/h6MASWwNmST94Uy
 pvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hjYunPTDH9867uMWOIxIZTkwp5jJV1/lPlJp8FLWKSw=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=J1306SLyKc8q1wcLiVCYIS5hJDs8whqJ3Hb4NzYk8Uu2f6wC3HZo8HWskHmKstswij
 K1WMrrbZmkDWUwsOM9hRXW3lrWp+hgvYPBRLK8rn/Z2m9+M9+kQxCvPjRYDUZVO1ipvO
 2Kl/2umge7B7LbPLCIbLK/pmMAmYqSnHatxsg3fudpmazWjORVzCiOKiQhpuMhNmLnOa
 03WeIoBiCjFapCU90mmAfpr+avAOmgjOrofhcFZ0h3NtFnwrvCPgaxSrpvWn0XwEQxwb
 vcmEoppOjesK3Gn7hthiOg3U70nE4RXkodXdUH4KjjoCitMMEIVlRVeOtXV/uQ33EH+q
 TXmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774294382; x=1774899182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hjYunPTDH9867uMWOIxIZTkwp5jJV1/lPlJp8FLWKSw=;
 b=oikEAvBTYsVppJDR/So+/Xg8HBXrl2zOOADy8Y4zZVLR12D+qmKWivq0BWcacbJxQx
 F7NgdltWod0psRMfao+2lBWNf1CX3+0EMOcXiSN9TTsWtbn7MDNxVtJ6ZhbMpLSaAjbz
 AHD3PNVVItfrvm1KacdkAuUlnNe9xIHDuVIj3vsEHomyyMjpgoV8sxCg32kQOUg8zUBv
 ZmpvdgyBiYJDrY77Qy3WIjxptfruytJAI93Nq/T8jTa8MMapDTjnKWXHPq63tCvGjf3a
 FydHcL6rV2DV0+9eIURz3NmvcxdZMaSUaiPRtKeJX6zRL5wlIC7n93WyuserZ576qwhZ
 U/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774294382; x=1774899182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjYunPTDH9867uMWOIxIZTkwp5jJV1/lPlJp8FLWKSw=;
 b=b0bYSQ6pynAIErcIvS3q3oJSzPaE2ooTc0gbAYL2ZPFArhTE0YcCuvYczbLgBK/8nN
 uQAyT8aaf3bj5rlAjmiJysVmzA0Q473rrKkI122DxtuJShF/XkUiA7czOWD/5ywzU3F1
 Xnhg5m26gXajYQzgk0nUbkuV0i0DPb1vXtCA2CegMY2mm8IF5oscRt+xfNfdhrvwgQRj
 vMEX94pnNsvj5nYLLmfR38vFSXGiAFVag7rERixybTsEPLt9NvM1uqickVJBzmmeMQIY
 j4zrJgEIRrmtzVesR8AgB4pS4o/yULR9KXX70AQyxHJqGjIsJiSfmIC5UFYtoPk1STx3
 hHHA==
X-Gm-Message-State: AOJu0YycN6WYFiJONybglCKkSBC5wV2ML5m+fje9YeSMmCx/24Udu44K
 zOU/N9sKzNucI4aTuVx0oOzCufpX6mLAmvnI6OAU3HDa3mjzCQv5+/d0k38BLUwwhvUmYBkRyw+
 iC1xYUyJivhm9S/gjD98Ec/cHto9+6qM=
X-Gm-Gg: ATEYQzwO9hGATpowekUClfEWwhiWrORsb4OFJTzx1Q5QEXYswERy2qDmpj41mg9r2wX
 furpuYGjT6oQ7Xus59ehGSC/ZIbuKG+nNp2JXx8NvYvtsw2T1BR1+jcI3u9j4svTBw7MTfjvuor
 PkqipuxMrxrcDDDNDge7XczxSqmLSVDnU278Njhze7jT2E18EDK3TVaVdumBErA4sbM2G1gTRGx
 L+WQsOa8aV5HM2q6ME9A//4tZfev0HnPz0bJu+1xyNeMnkCnJ/PPDeLRZdJjYpYkFVsBPn9tCQY
 H7BX4nUqFS20+RaBN+h6U+HWEmVgw7Lzfw+qc8s=
X-Received: by 2002:a17:903:3884:b0:2ae:5eab:1338 with SMTP id
 d9443c01a7336-2b0826c6914mr122703365ad.8.1774294382119; Mon, 23 Mar 2026
 12:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 13:32:49 -0600
X-Gm-Features: AaiRm50BhrJUPSGcCLNIem94bo2nrq1uim_vbpX3K9_edu-u6uRQL5e2sLpjup0
Message-ID: <CAATN3NrTa3qL1jZew7_3L2mfeK2PT3RFTkTDxQUZ_4NK7wAmAw@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/hexagon/cpu: add HVX IEEE FP extension
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000005f8cd0064db61a46"
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

--0000000000005f8cd0064db61a46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> This flag will be used to control the HVX IEEE float instructions, which
> are only available at some Hexagon cores. When unavailable, the
> instruction is essentially treated as a no-op.
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h             |  1 +
>  target/hexagon/translate.h       |  1 +
>  target/hexagon/attribs_def.h.inc |  3 +++
>  target/hexagon/cpu.c             |  1 +
>  target/hexagon/decode.c          | 22 ++++++++++++++++++++++
>  target/hexagon/translate.c       |  1 +
>  6 files changed, 29 insertions(+)
>
>
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index dbc9c630e8..d832a64a17 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pkt)
>      return !bitmap_empty(conflict, 32);
>  }
>
> +static void convert_to_nop(Insn *insn)
> +{
> +    bool is_endloop =3D insn->is_endloop;
> +    memset(insn, 0, sizeof(*insn));
> +    insn->opcode =3D A2_nop;
> +    insn->new_read_idx =3D -1;
> +    insn->dest_idx =3D -1;
> +    insn->generate =3D opcode_genptr[insn->opcode];
> +    insn->iclass =3D 0b111;
> +    insn->is_endloop =3D is_endloop;
> +}
> +
>  /*
>   * decode_packet
>   * Decodes packet with given words
> @@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int max_words,
> const uint32_t *words,
>          /* Ran out of words! */
>          return 0;
>      }
> +
> +    /* Disable HVX IEEE instruction if extension is disabled. */
> +    if (!ctx->ieee_fp_extension) {
> +        for (i =3D 0; i < num_insns; i++) {
> +            if (GET_ATTRIB(pkt->insn[i].opcode, A_HVX_IEEE_FP)) {
> +                convert_to_nop(&pkt->insn[i]);
> +            }
> +        }
> +    }
> +
>

Better to leave the instruction alone and turn it into a nop by not
generating any TCG.

That way, the disassembly (-d in_asm) will still show what's actually in
the binary.  You could add the check in gen_tcg_funcs.py.

You could also consider adding some sort of marker in the disassembly to
indicate that the flag is needed for the instruction to do anything.

Thanks,
Taylor

--0000000000005f8cd0064db61a46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This=
 flag will be used to control the HVX IEEE float instructions, which<br>
are only available at some Hexagon cores. When unavailable, the<br>
instruction is essentially treated as a no-op.<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/attribs_def.h.inc |=C2=A0 3 +++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 22 ++++++=
++++++++++++++++<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A06 files changed, 29 insertions(+)<br>
<br><br>
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
index dbc9c630e8..d832a64a17 100644<br>
--- a/target/hexagon/decode.c<br>
+++ b/target/hexagon/decode.c<br>
@@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pkt)<br>
=C2=A0 =C2=A0 =C2=A0return !bitmap_empty(conflict, 32);<br>
=C2=A0}<br>
<br>
+static void convert_to_nop(Insn *insn)<br>
+{<br>
+=C2=A0 =C2=A0 bool is_endloop =3D insn-&gt;is_endloop;<br>
+=C2=A0 =C2=A0 memset(insn, 0, sizeof(*insn));<br>
+=C2=A0 =C2=A0 insn-&gt;opcode =3D A2_nop;<br>
+=C2=A0 =C2=A0 insn-&gt;new_read_idx =3D -1;<br>
+=C2=A0 =C2=A0 insn-&gt;dest_idx =3D -1;<br>
+=C2=A0 =C2=A0 insn-&gt;generate =3D opcode_genptr[insn-&gt;opcode];<br>
+=C2=A0 =C2=A0 insn-&gt;iclass =3D 0b111;<br>
+=C2=A0 =C2=A0 insn-&gt;is_endloop =3D is_endloop;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * decode_packet<br>
=C2=A0 * Decodes packet with given words<br>
@@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int max_words, co=
nst uint32_t *words,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ran out of words! */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 /* Disable HVX IEEE instruction if extension is disabled. */=
<br>
+=C2=A0 =C2=A0 if (!ctx-&gt;ieee_fp_extension) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; num_insns; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GET_ATTRIB(pkt-&gt;insn[i].o=
pcode, A_HVX_IEEE_FP)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 convert_to_nop(&am=
p;pkt-&gt;insn[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>Better to leave the instruction alone=
 and turn it into a nop by not generating any TCG.</div><div><br></div><div=
>That way, the disassembly (-d in_asm) will still show what&#39;s actually =
in the binary.=C2=A0 You could add the check in gen_tcg_funcs.py.</div><div=
><br></div><div>You could also consider adding some sort of marker in the d=
isassembly to indicate that the flag is needed for the instruction to do an=
ything.</div><div><br></div><div>Thanks,</div><div>Taylor</div><div><br></d=
iv></div></div>

--0000000000005f8cd0064db61a46--

