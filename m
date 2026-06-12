Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B84CD8C9D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 03:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXst3-0000ri-8N; Thu, 11 Jun 2026 23:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXst0-0000rN-Op
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 23:48:50 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXssy-0007U2-2R
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 23:48:49 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68bfcf11050so930828a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 20:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781236126; cv=none;
 d=google.com; s=arc-20240605;
 b=Zz33CQw2KioVUeyIwD92DrIhRQPAQSMKxG/D3suLuc0757oKncUJV8bg0bih0VhEU0
 D/V6NSS5aQmukA7LqJTOXsEtGxa/MPjTlDec+g+ddLdDOQgldJIqhR/kgiFS8HEGe3d0
 j9ZtR6zlTnjSOy/4+pMqUYGdUEM+uYHH+scSwttzdpOtn9yE5DtbKWkivsE2Cd/bTD2K
 wmzkS8bUbRGSe4wMSerQa9MtwRtHMMBtraINmGzdUc1JZ4ZWGbplXEN/rBQ/0xJN7IbM
 EpPMcbrui+LOmq4AZCJ5KhZIk48FGQ5wONSI9djOGDipp+FW7iUNAJ9sC2G16S8WIiqW
 irKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=asLThhv5rJ9q+kTKdzC8tDXN+Ex3qgtD7namDBKaYUA=;
 fh=261oot2FMbPVGnpcrb7kLMaV0fTVsfTOM7iBWmcFpKQ=;
 b=UxNkhmFbCvj+3HXkCGqDxBj9zhjX/TgsBtgeDA/nOfP72eAlwKy3xzbAbUxohAqoZ8
 J7DcsGzByNSFTiIwMBDWGbY/DTjNrbx5mHvlpF4AKBHCKirl0Ybgkl/8kgLFukbFWDFE
 R+cb090nZd3t5J9asFvv2AONVybmS2KW0iTLiOTpxpEhFUgV5YXgjGu2zIifZcKdXPua
 +x2ll9fp6G6/5rnVmWTw943To/NbzhPFg3Dro5VX3e4n/DAWi/aF3sjXOEq243mnfpmM
 TDlW73JffOuXieCGxONqPt2Gus5W07WY5JMDJ65IHWt6KZpTPajoVYalv4FE1Ga1ig5x
 neXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781236126; x=1781840926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asLThhv5rJ9q+kTKdzC8tDXN+Ex3qgtD7namDBKaYUA=;
 b=d5EF14/prLStaDn9A/YSYjAGtpvNHBKGPFOtdZ7HILwN+VTLhEm4l3ANt/4rUhPFoU
 UgkKz3gWcBqVgBDW9RBvNozr0yNSu4N/5BOh2CSe4P/WCu0LyBYhn5iasDQxEO803sna
 tKNaqukNVB31z4N/TkTFs79iSn+3q8g1epdGRvalmqwXpYRTXcLmk2CuVCmz7cnaiMnV
 usfyNEArFNq7tk4oiz0vpDErisoQJiVmmsIXQ209+ottxmqrt+xJuFbIzgNGWP418mf1
 fzxNxRf1RMUdioFV5zI8Tdm/rKAusQEzN+peKyUYSdiwqL9BLy+sujvpdP5yPPI3NXaN
 3m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781236126; x=1781840926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=asLThhv5rJ9q+kTKdzC8tDXN+Ex3qgtD7namDBKaYUA=;
 b=rClRw88doz3KH3HVAWxQYoP7zw/3/cp9MJG0i1qa0bviiq7NnATwA1DH+l041SvbdH
 hh23gLx702sEkzh5OqTe+WOGY5fNHlqJX6IaudDWuixeCVv6J1HSdRYhyhYw3VVDWbsh
 la1cGD2uuQyK9MmEJOv+DQebD0yM6TCocu0GCTLfG+i3p8eOClm0NzuvmoVnevaHFYS3
 fa/BDzPyVilD2HOhKEm0EH6TcJcLoyzd+jG1U9zHcnfQOa2p038xM9nhNfW+GkrZXiGA
 sex569HjjrAjDdjK0to8KODDi8I1jzzF/YnIoSG4qTlXCA2HI+B/MwLXmUQZc05210b5
 twag==
X-Gm-Message-State: AOJu0Yx0xW/z9bcsfLuttnqWjuvbIHOLumNofZKlE3BW2NrdU+ySVVKe
 lPOtsIc6yAHTqs+x7lV4rDAI7ChdWfuQMh/bLq3TIsoENb/Jyx6VPkAntp6MUiGqpN66z99KdUW
 x1tk0D4d5wnaEkYCk9jUR1bpdqNtWEU8=
X-Gm-Gg: Acq92OEVVuHGPkcF2RH7lBmiaxYH9EgBQJY0nhjiusDiD+XemWQDmG+QYZSY0zmfDSk
 2LA4uxZzwsB/81VXn6CO2wQDxLcTgwPtvCbQz7Vt79IQlS3SO7jB+MM9q/zB0TV0/gB4BFjOXNd
 PMFnEnaiV38/EvjimC/EhGOeHIU4vqNETp5KJb0LoKgUjiC4EV4jj6MQlSG59EtiFzU+M2Y/V1W
 JOfNDte+LQjUUEtpkiz4aSnZ98UAKpOSME6F/z459Klrm4l/KkKRzLazvQ8uw10sBQR1YbqHScJ
 cAIpZAt9SN2/fg4jlL5LkMiQCyJAsu7CmAFZ8UBCy3wBQSg2
X-Received: by 2002:a05:6402:e0e:b0:693:ee1:9018 with SMTP id
 4fb4d7f45d1cf-693781919d3mr352681a12.28.1781236125468; Thu, 11 Jun 2026
 20:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260606145520.34152-1-imaginos32@gmail.com>
In-Reply-To: <20260606145520.34152-1-imaginos32@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jun 2026 13:48:17 +1000
X-Gm-Features: AVVi8CenocUhIQTh6e52GkloSrLBnOJyI5wJ-e8xWZFRwPQG_3Yf9HftiKRWLL8
Message-ID: <CAKmqyKPYAYP-npmDr1E3-+sqKU7aBSm+a=YuwUG=_Vr=9Z7Yvg@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: enable `mnret` disassembly
To: imaginos <imaginos32@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Jun 7, 2026 at 1:32=E2=80=AFAM imaginos <imaginos32@gmail.com> wrot=
e:
>
> The translator has supported mnret since commit 3157a553ec6b9a
> ("target/riscv: Add Smrnmi mnret instruction"), but the
> disassembler still renders it as illegal. Add it unguarded,
> since the encoding does not overlap any other extension.
>
> Signed-off-by: imaginos <imaginos32@gmail.com>

Do you mind rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next and
sending a v2

Alistair

> ---
>  disas/riscv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d416a4d6b3..065985992b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -985,6 +985,7 @@ typedef enum {
>      rv_op_ssamoswap_d =3D 953,
>      rv_op_c_sspush =3D 954,
>      rv_op_c_sspopchk =3D 955,
> +    rv_op_mnret =3D 956,
>  } rv_op;
>
>  /* register names */
> @@ -2255,6 +2256,7 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>        rv_op_sspush, 0 },
>      { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
>        rv_op_sspopchk, 0 },
> +    { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -4050,6 +4052,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>                      case 64: op =3D rv_op_mret; break;
>                      }
>                      break;
> +                case 1792:
> +                    switch ((inst >> 15) & 0b1111111111) {
> +                    case 64: op =3D rv_op_mnret; break;
> +                    }
> +                    break;
>                  case 1952:
>                      switch ((inst >> 15) & 0b1111111111) {
>                      case 576: op =3D rv_op_dret; break;
> --
> 2.43.0
>
>

