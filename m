Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF79EB2703
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 19:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vptMR-0000gy-Dr; Tue, 10 Feb 2026 14:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vptMN-0000gb-Tm
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 14:25:19 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vptMJ-0003W0-P5
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 14:25:17 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82496e32924so351525b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 11:25:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770751512; cv=none;
 d=google.com; s=arc-20240605;
 b=F+F+kapujx30WdFiMG3U+SQrI78qWUha/7uxoBVi55EBUfLwk6O4zny29adebzy1eM
 XDbT231t+SiQ4p3oPmN1fg+bKTeeq5UjEh2uxt0Ka8IZivIVlREGo6H9NGSuNkgsbJ2j
 OAvdKmb7PWhDlFqfAm7p9UzBTFSP+m2VeEYQupmsSao/Vh13ftjeYZ9WGf5ITHrnCaqQ
 1GhZIqQ6qlK2Bt3J0bTkpoJjs6mKstxxfsov2V7r0h7Q6K0Kvjyv6EL8xLX7KCY4m+M0
 0mEnliGmtMCGY1U/+17boYpH4NHKUtzb3ZOsRdR+V6AYFAWDVdvlvadIjCWsFL3WdblL
 V58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6rPhbJanEorH5+GZrRK9dGzmF893O2jWCKqwibbRu7o=;
 fh=R5JcZg9QYrZnuDJoUPbN5BM2IWW90yOVG6/dz4apTxA=;
 b=kAcDTXeHCl/2uaIZFJom1cUtg0B81LWfjC1KQEob9/IeHXkTTwTe2RuTo9h/+i/MMY
 khVsNliO9EjUUMHfzVl/SOlwqP1zFn5kNoe0+7KQKVw6x2J0bkSl4nifc7xr7L2GKpP9
 0dicnk1r7VNZos87FJGdXyG4Ba/AQKWE6NgMCh9umlO8GSSv6I+kSmNUp2egrDECy9+2
 8HMB/PMXDSJTcat0uH2nQ6vgtYH9H/mfVU6YDvX8dA4T577R7N4+Xuz/sWHxF+ZBw4lX
 Zws8FgO1kpIjPUcWhy+pCLkIxr55z+isK7NZL31Kdgop//z+s+HvnUOj3AN+RsTKA9uc
 m/vQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770751512; x=1771356312; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6rPhbJanEorH5+GZrRK9dGzmF893O2jWCKqwibbRu7o=;
 b=bOPtPrhRLPsGZ6bpxC6HPkyGXJtnlF20nKhzRGiskI4cFV/fl+nZgpAzFdN/8vCTq/
 IwpMot0oCvZgPonSBv2bSLj8asB3wly5oHc4SP37WMs0x/wxy0BIDMinP3RG7RGii9lK
 I29Mm5dGhRvhMIpQWPZhiBxkCLVfbFBvRBHVF+bHFd0HsylfgrPCTV+SzC0efNvCcw6D
 KqntehEIqN8VnL6Dcpd/vSlU30rqAl8yPh6t9uMmQ4iS/BLrGiRMF/cb6Rcesc5M8Pc3
 KWzU+bBGY1w4VS4Uhv99dXlp6XvecV6Ed6L8dz4dp71XCAJ2qvxpivtTH3mhaUwfYGdp
 KBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770751512; x=1771356312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rPhbJanEorH5+GZrRK9dGzmF893O2jWCKqwibbRu7o=;
 b=RQkoEPYx2Ldr3nxebONT2vdMJPHZtNz08hDhEIfyOfAWi8Fza8R6lGkeD9IWK5icVt
 dH8QycHzII8opxPpecnKs5sHjwXQFUSNYhGqKPxeVAO0WLQsZ9eSPBe1sKkDkBEdbc3O
 eOYvHiDogziupnox718iTNWPolwhrxMMTvUKcmR/x9ELHdWAIREBl1KvSb/HzIiNyz5M
 WcsWbna0GmwEWeUc4kF7+OLQLMmrcC0oveGA/Er0WL/IbZQy6VGIKLez/A/i6yubb2JL
 5LQ+JyLVo9uav+DI8e6CCmtHnDVvximl7c2PBx39qrZkJAI4k8deKF7nH41R3EIDkHro
 OuXg==
X-Gm-Message-State: AOJu0YzXaNXKp2WFujrCnblPgzOhP5uC1Cf1RHYQEyDHHoWLQ9zlZEs3
 RuW26AFL09RS4miRVY6pTgw9bRqZaF5qRmLipdCki6626fHyvAH8HtWU60iChrKLrQ6zktiRUNi
 AMnHVm/QlLPcaGig1m/Af3cYuWrEeBE0=
X-Gm-Gg: AZuq6aKZxo4oBX8NZc1VKljl3E9CjJZKsNb9Y6tdy4QdcKbOKoY9Sa1OwQpTtUIix11
 okcyN0jE/42ukHjtsg6Qq/OL/Mm9hsANAWqJuZgpaeQZo6HXDODV7wqmpdKgEhVmZdoGSyMxtUq
 3bf2UrauF9h4uqU3/51/PYpm8sUBioZPwo3ikcuepHf1sfWXRmx+Og+oVHeCJiKSodnTCXOBJZy
 7qVjpJZoJrkLSSB9Hmd31fOCYCKIBTG/kS6x42jwe5oo5XOeG5wMQCSbxRRJolGdxs2lK0mvlMl
 fs8hbPX6lADM4W674l5N1+xGRG0JKQC0H2jN+zw=
X-Received: by 2002:a05:6a20:6f89:b0:364:1361:a8a7 with SMTP id
 adf61e73a8af0-3942e36f184mr218882637.10.1770751512392; Tue, 10 Feb 2026
 11:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20260210133355.16093-1-brian.cain@oss.qualcomm.com>
 <20260210133355.16093-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260210133355.16093-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 10 Feb 2026 12:25:01 -0700
X-Gm-Features: AZwV_QhotOkXei1XcXwpBUaozvKyvuk4fAkiWTnkVJAAEPHzKfktl12cMVV_Ajw
Message-ID: <CAATN3NoZTQdNWX0rJmsqeCrJGPQF-8c4=2swHDY=5X2REGAn5g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] target/hexagon: Detect register write conflicts
 with bitmap algorithm
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, alex@alexrp.com, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e1b823064a7d3628"
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x435.google.com
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

--000000000000e1b823064a7d3628
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 6:34=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> A conflict exists when any GPR is written by multiple instructions and
> at least one write is unconditional.  This catches (1) two unconditional
> writes to the same GPR and (2) an unconditional write combined with a
> predicated write.
>
> Add HEX_CAUSE_REG_WRITE_CONFLICT and map it to SIGILL.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2696
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h           |   1 +
>  target/hexagon/insn.h               |   6 +
>  linux-user/hexagon/cpu_loop.c       |   1 +
>  target/hexagon/decode.c             |  43 +++++++
>  target/hexagon/translate.c          |  21 +++-
>  tests/tcg/hexagon/multiple-writes.c | 169 ++++++++++++++++++++++++++++
>  target/hexagon/gen_trans_funcs.py   |  10 ++
>  tests/tcg/hexagon/Makefile.target   |   1 +
>  8 files changed, 250 insertions(+), 2 deletions(-)
>  create mode 100644 tests/tcg/hexagon/multiple-writes.c
>
>
> diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
> index 5d59430da9..db4dbb728a 100644
> --- a/target/hexagon/insn.h
> +++ b/target/hexagon/insn.h
> @@ -72,6 +74,10 @@ struct Packet {
>      bool pkt_has_hvx;
>      Insn *vhist_insn;
>
> +    /* Bitmaps for detecting duplicate GPR destination writes */
> +    DECLARE_BITMAP(wreg_mult_gprs, 32);   /* GPRs written by >1 insn */
> +    DECLARE_BITMAP(uncond_wreg_gprs, 32); /* GPRs written unconditionall=
y
> */
> +
>

Consider making these bitmaps local to decode_mark_dest_regs.  Instead,
only add a bool here that indicates a pkt_has_write_conflict..  Then move
the pkt_has_write_conflict function from translate.c to decode.c.


>      Insn insn[INSTRUCTIONS_MAX];
>  };
>
> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.=
c
> index c0e1098e3f..5711055aff 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -65,6 +65,7 @@ void cpu_loop(CPUHexagonState *env)
>                              env->gpr[HEX_REG_R31]);
>              break;
>          case HEX_CAUSE_INVALID_PACKET:
> +        case HEX_CAUSE_REG_WRITE_CONFLICT:
>              force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
>                              env->gpr[HEX_REG_PC]);
>              break;
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index 33ad60c5b4..08b0fa2c8d 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -655,6 +655,44 @@ decode_set_slot_number(Packet *pkt)
>      return has_valid_slot_assignment(pkt);
>  }
>
> +/*
> + * Build bitmaps of destination GPR writes across the packet.
> + */
> +static void decode_mark_dest_regs(Packet *pkt)
> +{
> +    DECLARE_BITMAP(all_dest_gprs, 32) =3D { 0 };
> +
> +    for (int i =3D 0; i < pkt->num_insns; i++) {
> +        Insn *insn =3D &pkt->insn[i];
> +        int dest =3D insn->dest_idx;
> +
> +        if (dest < 0 || !insn->dest_is_gpr) {
> +            continue;
> +        }
> +
> +        int rnum =3D insn->regno[dest];
> +        bool is_uncond =3D !GET_ATTRIB(insn->opcode, A_CONDEXEC);
> +
> +        if (test_bit(rnum, all_dest_gprs)) {
> +            set_bit(rnum, pkt->wreg_mult_gprs);
> +        }
> +        set_bit(rnum, all_dest_gprs);
> +        if (is_uncond) {
> +            set_bit(rnum, pkt->uncond_wreg_gprs);
> +        }
> +
> +        if (insn->dest_is_pair) {
> +            if (test_bit(rnum + 1, all_dest_gprs)) {
> +                set_bit(rnum + 1, pkt->wreg_mult_gprs);
> +            }
> +            set_bit(rnum + 1, all_dest_gprs);
> +            if (is_uncond) {
> +                set_bit(rnum + 1, pkt->uncond_wreg_gprs);
> +            }
> +        }
> +    }
>

Move the body of pkt_has_write_conflict here and set a bool in the Packet
struct.
That way, all the logic will be in a single place.


> +}
> +
>  /*
>   * decode_packet
>   * Decodes packet with given words
> @@ -674,6 +712,10 @@ int decode_packet(DisasContext *ctx, int max_words,
> const uint32_t *words,
>
>      /* Initialize */
>      memset(pkt, 0, sizeof(*pkt));
> +    for (i =3D 0; i < INSTRUCTIONS_MAX; i++) {
> +        pkt->insn[i].dest_idx =3D -1;
> +        pkt->insn[i].new_read_idx =3D -1;
> +    }
>      /* Try to build packet */
>      while (!end_of_packet && (words_read < max_words)) {
>          Insn *insn =3D &pkt->insn[num_insns];
> @@ -737,6 +779,7 @@ int decode_packet(DisasContext *ctx, int max_words,
> const uint32_t *words,
>              /* Invalid packet */
>              return 0;
>          }
> +        decode_mark_dest_regs(pkt);
>      }
>      decode_fill_newvalue_regno(pkt);
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 7fe8b35351..6e399bc2f2 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -940,10 +940,21 @@ static void gen_commit_packet(DisasContext *ctx)
>      }
>  }
>
> +/*
> + * Check for register write conflicts in the packet.
> + */
> +static bool pkt_has_write_conflict(Packet *pkt)
> +{
> +    DECLARE_BITMAP(conflict, 32);
> +
> +    bitmap_and(conflict, pkt->wreg_mult_gprs, pkt->uncond_wreg_gprs, 32)=
;
> +    return !bitmap_empty(conflict, 32);
> +}
> +


 This doesn't address instructions that write more than one register.  Try
this test case
    .word 0x9b004021    /* {    r1 =3D memb(r0++#1)      */
    .word 0x9b00c022    /*      r2 =3D memb(r0++#1) }    */

Also, this doesn't check for multiple writes to other types of registers
(predicate, control, HVX).

Thanks,
Taylor

--000000000000e1b823064a7d3628
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 10,=
 2026 at 6:34=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">A conflict exists when any GPR is wr=
itten by multiple instructions and<br>
at least one write is unconditional.=C2=A0 This catches (1) two uncondition=
al<br>
writes to the same GPR and (2) an unconditional write combined with a<br>
predicated write.<br>
<br>
Add HEX_CAUSE_REG_WRITE_CONFLICT and map it to SIGILL.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2696" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2696</a><br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0target/hexagon/insn.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A06 +<br>
=C2=A0linux-user/hexagon/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 43 +++++++<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
21 +++-<br>
=C2=A0tests/tcg/hexagon/multiple-writes.c | 169 +++++++++++++++++++++++++++=
+<br>
=C2=A0target/hexagon/gen_trans_funcs.py=C2=A0 =C2=A0|=C2=A0 10 ++<br>
=C2=A0tests/tcg/hexagon/Makefile.target=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A08 files changed, 250 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/multiple-writes.c<br>
<br><br>
diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h<br>
index 5d59430da9..db4dbb728a 100644<br>
--- a/target/hexagon/insn.h<br>
+++ b/target/hexagon/insn.h<br>@@ -72,6 +74,10 @@ struct Packet {<br>
=C2=A0 =C2=A0 =C2=A0bool pkt_has_hvx;<br>
=C2=A0 =C2=A0 =C2=A0Insn *vhist_insn;<br>
<br>
+=C2=A0 =C2=A0 /* Bitmaps for detecting duplicate GPR destination writes */=
<br>
+=C2=A0 =C2=A0 DECLARE_BITMAP(wreg_mult_gprs, 32);=C2=A0 =C2=A0/* GPRs writ=
ten by &gt;1 insn */<br>
+=C2=A0 =C2=A0 DECLARE_BITMAP(uncond_wreg_gprs, 32); /* GPRs written uncond=
itionally */<br>
+<br></blockquote><div><br></div><div>Consider making these bitmaps local t=
o decode_mark_dest_regs.=C2=A0 Instead, only add a bool here that indicates=
 a pkt_has_write_conflict..=C2=A0 Then move the pkt_has_write_conflict func=
tion from translate.c to decode.c.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0Insn insn[INSTRUCTIONS_MAX];<br>
=C2=A0};<br>
<br>
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c<=
br>
index c0e1098e3f..5711055aff 100644<br>
--- a/linux-user/hexagon/cpu_loop.c<br>
+++ b/linux-user/hexagon/cpu_loop.c<br>
@@ -65,6 +65,7 @@ void cpu_loop(CPUHexagonState *env)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;gpr[HEX_REG_R31]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case HEX_CAUSE_INVALID_PACKET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case HEX_CAUSE_REG_WRITE_CONFLICT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0force_sig_fault(TARGET_SIGI=
LL, TARGET_ILL_ILLOPC,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;gpr[HEX_REG_PC]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
index 33ad60c5b4..08b0fa2c8d 100644<br>
--- a/target/hexagon/decode.c<br>
+++ b/target/hexagon/decode.c<br>
@@ -655,6 +655,44 @@ decode_set_slot_number(Packet *pkt)<br>
=C2=A0 =C2=A0 =C2=A0return has_valid_slot_assignment(pkt);<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Build bitmaps of destination GPR writes across the packet.<br>
+ */<br>
+static void decode_mark_dest_regs(Packet *pkt)<br>
+{<br>
+=C2=A0 =C2=A0 DECLARE_BITMAP(all_dest_gprs, 32) =3D { 0 };<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; pkt-&gt;num_insns; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Insn *insn =3D &amp;pkt-&gt;insn[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int dest =3D insn-&gt;dest_idx;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dest &lt; 0 || !insn-&gt;dest_is_gpr) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rnum =3D insn-&gt;regno[dest];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_uncond =3D !GET_ATTRIB(insn-&gt;opcode=
, A_CONDEXEC);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_bit(rnum, all_dest_gprs)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(rnum, pkt-&gt;wreg_mult_=
gprs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(rnum, all_dest_gprs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_uncond) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(rnum, pkt-&gt;uncond_wre=
g_gprs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (insn-&gt;dest_is_pair) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_bit(rnum + 1, all_dest_=
gprs)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(rnum + 1, =
pkt-&gt;wreg_mult_gprs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(rnum + 1, all_dest_gprs)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_uncond) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(rnum + 1, =
pkt-&gt;uncond_wreg_gprs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Move the body of pkt_h=
as_write_conflict here and set a bool in the Packet struct.</div><div>That =
way, all the logic will be in a single place.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * decode_packet<br>
=C2=A0 * Decodes packet with given words<br>
@@ -674,6 +712,10 @@ int decode_packet(DisasContext *ctx, int max_words, co=
nst uint32_t *words,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Initialize */<br>
=C2=A0 =C2=A0 =C2=A0memset(pkt, 0, sizeof(*pkt));<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; INSTRUCTIONS_MAX; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;insn[i].dest_idx =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;insn[i].new_read_idx =3D -1;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0/* Try to build packet */<br>
=C2=A0 =C2=A0 =C2=A0while (!end_of_packet &amp;&amp; (words_read &lt; max_w=
ords)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Insn *insn =3D &amp;pkt-&gt;insn[num_insn=
s];<br>
@@ -737,6 +779,7 @@ int decode_packet(DisasContext *ctx, int max_words, con=
st uint32_t *words,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Invalid packet */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 decode_mark_dest_regs(pkt);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0decode_fill_newvalue_regno(pkt);<br>
<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index 7fe8b35351..6e399bc2f2 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -940,10 +940,21 @@ static void gen_commit_packet(DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Check for register write conflicts in the packet.<br>
+ */<br>
+static bool pkt_has_write_conflict(Packet *pkt)<br>
+{<br>
+=C2=A0 =C2=A0 DECLARE_BITMAP(conflict, 32);<br>
+<br>
+=C2=A0 =C2=A0 bitmap_and(conflict, pkt-&gt;wreg_mult_gprs, pkt-&gt;uncond_=
wreg_gprs, 32);<br>
+=C2=A0 =C2=A0 return !bitmap_empty(conflict, 32);<br>
+}<br>
+</blockquote><div><br></div><div>=C2=A0This doesn&#39;t address instructio=
ns that write more than one register.=C2=A0 Try this test case</div><div>=
=C2=A0 =C2=A0 .word 0x9b004021 =C2=A0 =C2=A0/* { =C2=A0 =C2=A0r1 =3D memb(r=
0++#1) =C2=A0 =C2=A0 =C2=A0*/</div>=C2=A0 =C2=A0 .word 0x9b00c022 =C2=A0 =
=C2=A0/* =C2=A0 =C2=A0 =C2=A0r2 =3D memb(r0++#1) } =C2=A0 =C2=A0*/</div><di=
v class=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail=
_quote gmail_quote_container">Also, this doesn&#39;t check for multiple wri=
tes to other types of registers (predicate, control, HVX).</div><div class=
=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail_quote =
gmail_quote_container">Thanks,</div><div class=3D"gmail_quote gmail_quote_c=
ontainer">Taylor</div><div class=3D"gmail_quote gmail_quote_container"><br>=
</div></div>

--000000000000e1b823064a7d3628--

