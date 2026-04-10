Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D23AF36B9F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0x5-0001y3-Bl; Thu, 09 Apr 2026 21:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0x3-0001vs-Ip
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:46:29 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0x2-0003x5-4S
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:46:29 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9c755b2cdeso234260566b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775785586; cv=none;
 d=google.com; s=arc-20240605;
 b=D7JyPEMWOBXYzsuxLAP7vPSEb/SUKELucNE5qHJO2JrfrOuNfYuOwcBJK/j6Mbpcxn
 j4S0SP+VfUlK2Z8GIkJAcoch6HOHLr1uwk4DRbUHRu62lyuTGbKGjUbZ9Jj38am0VdVf
 z6TO1TcQZvrFCV+AB84T0kNwVNfKGlFLtkBe+i9fYpbeh8UVPPXWY5yNUu8AFkMEXzha
 70QaImkA6ZkqKRWiGr10tYp1WX+0AwM9eVLyIBwL2V075R7hSYN6EkS1bz9YPQIDYqg8
 TGLdZIuXa05WwKd6S0PuMpxDJI7zml1I4I8oD3wls5usUmWavgWbQd9OZYmYsLzwBDfQ
 eZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ri3m/g8snjI/Q2wmkCyZ8IT5nlZxUwhGT6RNmF125OM=;
 fh=4g02711MLHiJfxPa0hKSnHKnrxOMYD3DPVIPNBCbfUM=;
 b=dP71IhoVyjs0WEUqF/Yani1UCII7lOa3IVFhLrM7SlddlLCtQ4is9ljzLrb4cNerqQ
 esERQskKOvrUVFN8RbgpBWDwnd6cz/mwvBaUEZzv2o7xFqYRw8b3oSJWOc5B8WDXrYiP
 WCz4Uvu8zUmSssVMdaNt2pUqYcb2oUekAvqWFPLz+gZBtiQe6Z5ytk7bHwEyyDgavalp
 x5kaZIKtXiW/6uHk7LtsvG+SFs0Ypdky73pyvL6rtLko+z92eC7/HOY8h/7EETQFSlYR
 sQcyRBKr19u1rPQYlJKEgKdcJjkcv2Pvpo6n1AtnEeFzcAkPglIjhOwgdnwAr2PqiRZY
 vNGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775785586; x=1776390386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri3m/g8snjI/Q2wmkCyZ8IT5nlZxUwhGT6RNmF125OM=;
 b=MK3kBc/0DSsiQOOPImfqa3hUI56y3lUFyjanvBv7RSx3rUMOVYUfQTYrTRVGENFNjW
 JFeS8J/HXbrG+e8G47WmTuyKkfQPtdIbqgkIYlvQxiyiaTYvIDxNSCuXEum52GRvcICs
 6IgZVtsuCTjEjXU9wuMuvMSQYgCET9L3YUF5iY5pkSq41n+Pgur1ZDsAg59yOZbM035q
 pkEOJYLhpBJbSiEioPjwNqemXlWo6ICyW6X5NOJXMRbOE/cCaU8ks5fZx2YqSM5jFznn
 FDwxygs22L4XrgZrCyVsc2fauuJd6v9uEo9RCBuEZkOyZD+9tXwh7ogUL5eCH8hReC+/
 90Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785586; x=1776390386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ri3m/g8snjI/Q2wmkCyZ8IT5nlZxUwhGT6RNmF125OM=;
 b=TVm0b1lQPFQgm0mIt1u+eVEpaX+5SlbGVAuu4UInfUUxfuYpazU1B/kTIrMXzvYRhX
 HlKsMRF25aYFh21mjZ3S3oHKuqR+qq7/ZdM9tXPXKKytywhQFGoBTnbPxUSNQgDBMAO2
 zfnbxqtW6U73KQ0b9aGM7aJRP0jlR7ID7lZrO+HOCdsaD+woaiY//JKltrDBxPAMWhRD
 YsdpV2Qhm4n5adovhndBFC6plqY3gO6KDd+tBL5iYpH3YKId5cnQZEWeYM41Vg4a66wO
 DXj3+XbrKpslmWZ0longUaggrFZ0T+b1uLqjisHlMq/MiUvm8CI9IHz27CQmdcwfG1KA
 wnvQ==
X-Gm-Message-State: AOJu0YwbXonKdwiy8mzVjLLD39rBqepU2ebF11TtwIZ32PnORXMcFbOi
 crkuRXmyfxFZv8FIAgc1rN644v4IMcYlhgJuamkMDKZtMWrWpBclZTBuXjHN0e7IqaPho5xw3vS
 B4YGRluH0NlA4ULdT28bvUCLhMLXHfrs=
X-Gm-Gg: AeBDieuJgcxjo+as0JNFap5hR3Od+BjkdMYOqXG4q7Kv0j9GR1zJWVIAP/OBVmoARAF
 GOMJPQVtIR4t+ZXGqImcxS2uusRcIp8lFR/jWv5qcMj9pL2Gx7lntN4xuStglDChz/H2kQcxpdc
 QqThI0PeC2wbKMP6+H1cSEFUT5lJsvEScUApcgetJplDT5mPqoFQiG4Pb5nsvRz4KTUc/bySYB9
 491VwAGVQQIzmRu0WllWi9XSI+h02gO2SJ0sGPQho/mla/yqv87tdHdwtvvDY9yynr/U87PJ02N
 BzVKGzNxmfnPfYQczGhBzK1X4GPj4sudJ16ucw==
X-Received: by 2002:a17:907:894f:b0:b9b:207c:f7af with SMTP id
 a640c23a62f3a-b9d7267bf50mr70988066b.42.1775785586260; Thu, 09 Apr 2026
 18:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-6-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-6-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:45:59 +1000
X-Gm-Features: AQROBzA3kS8HPglmvMbm15Jyw7WlCEL9IFl0iLYCgxc8DVUJLItFILz_1EL85pY
Message-ID: <CAKmqyKNt86vKPYzP-+5C92FQz99hCjUStWs5ACG2kcLbqjKx8A@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] target/riscv: Fix smrnmi isa alphabetical order
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Thu, Apr 9, 2026 at 12:09=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8ac935ac06..cb4ccd001d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -224,9 +224,9 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>      ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
> -    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>      ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
> --
> 2.43.0
>

