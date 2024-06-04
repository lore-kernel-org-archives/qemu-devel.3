Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991F3C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJno-00045v-OL; Mon, 03 Jun 2024 22:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJnm-00045d-TM; Mon, 03 Jun 2024 22:21:30 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJnl-0000XK-4u; Mon, 03 Jun 2024 22:21:30 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4eb12b7702cso769067e0c.3; 
 Mon, 03 Jun 2024 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717467687; x=1718072487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8K+yVMVB24tc1lMIu2xf7mahJxQWZmItAt1xkXshoA8=;
 b=jfDLbKKbBIwn0fCKoAGISWEHTETygcDuZPA6hi7ZSqKM5EH4w4kClGo6+LGhLYJ13r
 FLonyAP6keBl+Zbvv5QzZcgMZsqBeCg0pS4LBUNUZchLVe5A2Am06bmNTJjH0ICENGPz
 FYLTqkXdcvWkO8390L9vwizGjirPO7UobpLK1kiA0EvgTKMsVg/DQX6b7HgdEefmCog7
 4XK8ba6cx/K517yo3uYgUv+w3CWGAlRfnbaLYM5exvXp0T5bZ5Q4eRbGVQWOhvz3yXru
 EHEAcvtiOaMLpFMia2l+3tYWFMhbb+om577rGuCL7FXSSx/HKn4psA6TU9hSikzIS+bw
 BYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717467687; x=1718072487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8K+yVMVB24tc1lMIu2xf7mahJxQWZmItAt1xkXshoA8=;
 b=cisbQF8ZI3ZUHY4Xo04/boEXicFnA78Dmq1M/ykvYjY1/9Ktc2N4m0ls2kipVONae8
 HDgQ6sW4Lb+3vnn1ENbsZyRJ6vqLAQCgTp0pq3nQ8o9DzgeRlrQjmTSHos+kln81n2im
 sSo8cfQzzZwqUZbiBC/XXaT3MRkhNVdCe+HSgMmpwrfDL+6tmht7DB2gy+So+VSDZdV8
 5RF//iFmMPqkkOTOms4ZY0tIg9W4sZ1KIiDe6rtiL+TAVe4M/z3BGAqSVhFAHACPS8/z
 FKBG+CghmQ3UtmXEGANu3AVGVBkaMAVSA31geJr3MhsikEuSKkJz0lW113lHZoCVvxim
 OMuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrwKGZWID+FkSHQgj3Mil1tdsDHW48nOvQDOkqjVikWvO2zJQLkDo1NRhr60qsCTTs48AKqTwdDfB/BNCwKYpYArcPBs0=
X-Gm-Message-State: AOJu0YxvTSUFhwGiJUT5AbUBfSdvMqHJiVXnHxtqg4pG5bnzArXTR1PB
 gvRCJFseFxsYrDeL40gjuGCh/5hH5o2bZ6OkqmTcByFlXq6Ju8QVs1QYukZFB2bxL4pa2bw8v6t
 HM1NKyFft8eV/ByJlcoCOEncAEAY=
X-Google-Smtp-Source: AGHT+IG282pFSBwzJtVlUbsLqWTn7KNZvjovf8mYNh6d96xHHwpOZN4WmPYME0OMSA5TFnu6Eo5FHW5Ettz52owyYs8=
X-Received: by 2002:a05:6122:3113:b0:4eb:12b1:2ea6 with SMTP id
 71dfb90a1353d-4eb12b12f86mr7188252e0c.13.1717467687454; Mon, 03 Jun 2024
 19:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240522062905.1799-1-zhiwei_liu@linux.alibaba.com>
 <20240522062905.1799-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240522062905.1799-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 12:21:01 +1000
Message-ID: <CAKmqyKOMEKPd2BPP9AQy7dRqAuM1DsDs9DaOToF94Ujvj4d92w@mail.gmail.com>
Subject: Re: [PATCH 2/4] disas/riscv: Support zimop disassemble
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, dbarboza@ventanamicro.com, bmeng.cn@gmail.com, 
 iwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 22, 2024 at 4:32=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e236c8b5b7..4cd769f165 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -906,6 +906,46 @@ typedef enum {
>      rv_op_amocas_w =3D 875,
>      rv_op_amocas_d =3D 876,
>      rv_op_amocas_q =3D 877,
> +    rv_mop_r_0     =3D 878,
> +    rv_mop_r_1     =3D 879,
> +    rv_mop_r_2     =3D 880,
> +    rv_mop_r_3     =3D 881,
> +    rv_mop_r_4     =3D 882,
> +    rv_mop_r_5     =3D 883,
> +    rv_mop_r_6     =3D 884,
> +    rv_mop_r_7     =3D 885,
> +    rv_mop_r_8     =3D 886,
> +    rv_mop_r_9     =3D 887,
> +    rv_mop_r_10    =3D 888,
> +    rv_mop_r_11    =3D 889,
> +    rv_mop_r_12    =3D 890,
> +    rv_mop_r_13    =3D 891,
> +    rv_mop_r_14    =3D 892,
> +    rv_mop_r_15    =3D 893,
> +    rv_mop_r_16    =3D 894,
> +    rv_mop_r_17    =3D 895,
> +    rv_mop_r_18    =3D 896,
> +    rv_mop_r_19    =3D 897,
> +    rv_mop_r_20    =3D 898,
> +    rv_mop_r_21    =3D 899,
> +    rv_mop_r_22    =3D 900,
> +    rv_mop_r_23    =3D 901,
> +    rv_mop_r_24    =3D 902,
> +    rv_mop_r_25    =3D 903,
> +    rv_mop_r_26    =3D 904,
> +    rv_mop_r_27    =3D 905,
> +    rv_mop_r_28    =3D 906,
> +    rv_mop_r_29    =3D 907,
> +    rv_mop_r_30    =3D 908,
> +    rv_mop_r_31    =3D 909,
> +    rv_mop_rr_0    =3D 910,
> +    rv_mop_rr_1    =3D 911,
> +    rv_mop_rr_2    =3D 912,
> +    rv_mop_rr_3    =3D 913,
> +    rv_mop_rr_4    =3D 914,
> +    rv_mop_rr_5    =3D 915,
> +    rv_mop_rr_6    =3D 916,
> +    rv_mop_rr_7    =3D 917,
>  } rv_op;
>
>  /* register names */
> @@ -2096,6 +2136,46 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>      { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
>      { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1, NULL, 0, 0, 0 },
> +    { "mop.r.0", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.1", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.2", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.3", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.4", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.5", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.6", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.7", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.8", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.9", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.10", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.11", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.12", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.13", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.14", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.15", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.16", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.17", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.18", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.19", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.20", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.21", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.22", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.23", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.24", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.25", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.26", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.27", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.28", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.29", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.30", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.r.31", rv_codec_r, rv_fmt_rd_rs1, NULL, 0, 0 },
> +    { "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -2945,6 +3025,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>              break;
>          case 13: op =3D rv_op_lui; break;
>          case 14:
> +            if (dec->cfg->ext_zimop) {
> +                int imm_mop5, imm_mop3;
> +                if (extract32(inst, 12, 3) =3D=3D 0b100) {
> +                    if ((extract32(inst, 22, 10) & 0b1011001111)
> +                        =3D=3D 0b1000000111) {
> +                        imm_mop5 =3D deposit32(deposit32(extract32(inst,=
 20, 2),
> +                                                       2, 2,
> +                                                       extract32(inst, 2=
6, 2)),
> +                                             4, 1, extract32(inst, 30, 1=
));
> +                        op =3D rv_mop_r_0 + imm_mop5;
> +                        break;
> +                    } else if ((extract32(inst, 25, 7) & 0b1011001)
> +                               =3D=3D 0b1000001) {
> +                        imm_mop3 =3D deposit32(extract32(inst, 26, 2),
> +                                             2, 1, extract32(inst, 30, 1=
));
> +                        op =3D rv_mop_rr_0 + imm_mop3;
> +                        break;
> +                    }
> +                }
> +            }
>              switch (((inst >> 22) & 0b1111111000) |
>                      ((inst >> 12) & 0b0000000111)) {
>              case 0: op =3D rv_op_addw; break;
> --
> 2.25.1
>
>

