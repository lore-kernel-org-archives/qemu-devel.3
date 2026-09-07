Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6897CC79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 02:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3OeT-00045d-A4; Sun, 06 Sep 2026 22:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3OeQ-00044z-DD
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:00:02 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3OeN-0004mV-Mx
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 22:00:02 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66c9995ca60so3849245d50.1
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 18:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788746398; cv=none;
 d=google.com; s=arc-20260327;
 b=WdB5TtayDxm6tPb5lvLi0tr3c2Apt2IxLzfp+71ZYQvbDfzjbngljoimux7U+6CfEZ
 PEsn9IT87t9haxJGfAFFM9PTG4bDmz0K71ysZbtR/mL8Uk/PtsOWe9P8fbh1t/3bWlvz
 Hwr949/I7g3GbhanCtGBLJsykUWyXeOObBPb7IIokvnBrQDt6b1Rs7cUBVfh+8LDTaHC
 OPjFEbBSPQpFs7ufXdadE1U1U4AJ7OO/W0QxfC2kWoOEguzIRT3NpOHMmSuwwGp8Md/2
 V64oCyMqvTKCq0+FhlfJdI941rCJ88EeSMqGkp2U5j0NY7NZ77kA4eCo41NY3Dfouk/d
 UwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3a35i00JcPO+1PlUnpIvpEu7xlvw5Pcruz3A3w+M5h4=;
 fh=COcs8C7L0RYFShDl7KanJ31LqHp+gtadM2Ndg7NsP18=;
 b=bb7qgdOaNWNhC0z4OxVYVFrCGsw5jQcWjfFYC9waIhn/9IBwqxGak5EmDITm4kfz16
 pFVWr/zqzDBPkI0dCmZc6D+r+ybJJjF2rcVZKztZdv0PPHuH92aESHAP/R9CZPAw215U
 c5Sh64cRw19ICS50r3SypqVy0jWYuTolRFF9yhdvS9gWERbupyLog9OdVOE7uVG4EA2b
 qTNukzGjgYdBQ8Uo8odMeNl5n8O/EZvNVdaJ9aVzyiiR21Rguc13jxj5Ra+9qQ7WSl2t
 lJ7pyFAL6SqWKFlyw771hM1VH3P8nVAs+3Wef/639L6TOWD7v6U7DG6GkpitiARffvX1
 Ip8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788746398; x=1789351198; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3a35i00JcPO+1PlUnpIvpEu7xlvw5Pcruz3A3w+M5h4=;
 b=CIUcJ/4kELXbMD25Y6cUe2SsYWQccm/UI43v4uq+9NdZdjEuUsbWXj9YIgd+iVCVpy
 hXwS+uJ1+vhHaPUmsR5Dq6At84Cjz7ggxzSL4gLRyz0jSwjtEpmWioOIWT7AZ0pcb5Pu
 HyBqTvPr6g5hEwj1uZ/HwajEvtbdEucsk0U5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788746398; x=1789351198;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3a35i00JcPO+1PlUnpIvpEu7xlvw5Pcruz3A3w+M5h4=;
 b=QsenrJdsDJJowVVeZ6FUir+gWneFBZkW/2GPkyeBkrpyGXjjGwx4DuF9IW7NoGhDf0
 ckYgvO33KNulPmzE6Av4oh6b+D5XEocDoza/fmpQG7/uY0YqxgnoJPlreza/mY/PbW9w
 r8+bZ37dsNBjc0vjx9jXqWG2yJZbAI+V6a+2DV8FFxxpkE1tP/D9eGmUDa12JnDVxPjC
 59a5GWVhB4bAaH6ehhpESe5TsGj6Dg2dkaqrSUckLZGsZf2C38n8S3a84BJmsaS5wYaA
 CdxUlcMN3oCzD5xwxOE2w0VPbpoa9hDt5qVdeNyGmPEDxkJwqdJrawX0tpCw9X+QuEJr
 lv/g==
X-Gm-Message-State: AFuF++mcqE/zT3izZTAS7hWnFcZMX3Y7Yqueq/kJc0lh5ccdCe8QqBLK
 oVOhlh/lFlC8GJGW65fgE7XL3EaRqS9k2H581k9QTi5Xzp3GFX8IzfGPhcCFupDujxAf2cHubk0
 7NAxicdaPRoDb0Z3dwKsVQQOEW2iPJxk=
X-Gm-Gg: AYBFou2RtyCuFpZCdueQYbik8fIn926Qu0VCLaQYZTuFMSOFQRORQYI8jzH7t/K8ygz
 0WiNfoQAA2ita4VGEcGdIU9tvWiyGjIhY4xcVrhKxy3vemkIylONkJPvfz1+w4O4IdCf4KIU0g2
 t907OqUq2c6Pt7PnpFPDTVHPNwl9qp/JCk9TXivWWAoyky2em+57UVSH5KJZmbNTnHYmo9Bxr4P
 R8kIXbsSrQPjlM/b7JbBZ/roFmAG071vQOOJOcAZaY6yL5f69z1fLH9TvDuJDqNXFVvCNzS+HC0
 0p02jT9JG7AFUON+6AVsbTkH7l4+yCr4jPkjrasvxweEHj1ZwuEOkx+Z/73i9CvpRv0G51NGIF7
 TN3NdYJJnLJuCK7kI4BOEp663TfoPPP9PRbFqzK4ULl0aq060zGxrXaI4DK+pKfU8QjXlSFhA14
 LC0M2WqeAWhebo+0ym
X-Received: by 2002:a05:690e:191e:b0:66f:b0f7:5958 with SMTP id
 956f58d0204a3-66fb6cb6334mr3775842d50.6.1788746397762; Sun, 06 Sep 2026
 18:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260831133000.982059-1-liumingliang.dev@bytedance.com>
 <20260831133000.982059-2-liumingliang.dev@bytedance.com>
In-Reply-To: <20260831133000.982059-2-liumingliang.dev@bytedance.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 7 Sep 2026 11:29:45 +0930
X-Gm-Features: AcwNN1V23c1kPMAFUaWEPk66EgbdprmVFqcJroVl-T7pE2Vshb1acPwRpIo_5PQ
Message-ID: <CACPK8XfqEi8-hbdVLo0gtrsBrGYJhSFqkQmaF5QLb6at9uk7pA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/riscv: Add experimental Zvabd extension
 support
To: Mingliang Liu <liumingliang.dev@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com, 
 Zhibo Hong <hongzhibo@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 31 Aug 2026 at 22:59, Mingliang Liu
<liumingliang.dev@bytedance.com> wrote:
>
> From: Zhibo Hong <hongzhibo@bytedance.com>
>
> The draft Zvabd extension provides vector integer absolute-difference
> operations for image, video, and other data-processing workloads. It
> introduces eight new instructions:
>
>   - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
>     8 through ELEN, with SEW 64 requiring Zve64x.
>   - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
>     and 16 and accumulate into a double-width destination.
>
> This patch implement this instruction extension, including instruction
> decoder, TCG translation, and helpers, etc.
>
> The specification is under review at:
> https://github.com/riscv/riscv-isa-manual/pull/3279

Mention this implements 0.9 of the spec. It's notable that the opcodes
(and other things) have changed since 0.7.

> Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>

Assuming we follow the same convention as the kernel, include a
Signed-off-by line from the author, followed by yours as the
submitter.

> --- a/disas/riscv.c
> +++ b/disas/riscv.c

> @@ -2417,6 +2423,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                  case 13: return &op_vclmulh_vx;
>                  case 14: return &op_vslide1up_vx;
>                  case 15: return &op_vslide1down_vx;
> +                case 21: return &op_vabd_vx;
> +                case 22: return &op_vabdu_vx;

Should these be in numerical order?

Otherwise, looks good.

Reviewed-by: Joel Stanley <joel@jms.id.au>


>                  case 16:
>                      switch ((inst >> 20) & 0b11111) {
>                      case 0:

