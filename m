Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59C11125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NlI-0004W2-0Z; Wed, 11 Mar 2026 13:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Nl5-0004VI-FT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:54:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0Nl3-0006Fr-G8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:54:11 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439a89b6fd0so144714f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773251646; x=1773856446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLjJwZFhOKyALEg8hi6m2YzhNLS3Our6fPQAStPiJRo=;
 b=vwY5YxJI8IHjerI+23s0TlzLt0ymU0d/y+vdXbzo2ftQhkJT8a7PzuKYktP9vDnVaU
 lv1HeBXsVmmBZJrxo4Vdt6uCGT6J3aShdFR6d0wWL5018yJmVA/SRbv6Hojx6YvBp+Tn
 FRhIlbMTgE6eagTNRjxbO7wwHnFeNxJTktpWPd8TyocGv+FpqxNQ9dEb6yevt16wT3EE
 Plj0Pn7Rer18BgM2DpVzu5Uys2QduMARxizeVQdKlkCN/nMiTS5e2R+ZQ61t5rp5bSQO
 KOenfcDLoul3urs/o3p5vm5zjx21QLaoE9Cd5a5OjlF/7XTkd0yiZlFkJ/GmaoSpRUqd
 ClLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773251646; x=1773856446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HLjJwZFhOKyALEg8hi6m2YzhNLS3Our6fPQAStPiJRo=;
 b=p7FFmjfpIYBKtrRHeTPTIGH0iztO1wB8L9WiH8nwzJOuVfT5k04eYhoFgu9zIvgVkI
 bx+gT12nzZ9u2VkxKcvBsHImjFNTSkU7r5lN1faL1pUVIPNL6JGG9RbisuW2BvcjbH4E
 cN0nj7AAhiMP8m1xv3CKfPnhqYHxrBitI7UUmC6wvHUICsvoIXh6v6QIk99+2QuPnMkn
 sCUCjPERBn9mteqadryTddx5eQtLo7+eM2Jp7YbSN/uU6RvWTYZ5v7ZsBuQnmfTb5UNN
 J3ZT0lYOAVrT4oj1csZiYcr5q+MqxA8XCmSe4OzYMwu+hjhGFKpxKHL9s/oXG7lQ6O/f
 ITsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAah00OfhPLgHLRpBdKVjtpMUIogKzTvnJEzuAZT83yZMumbFpjcq4Yt6FoDG3ibjoSGhjTmeWiFLp@nongnu.org
X-Gm-Message-State: AOJu0YxcOcvlajF0J+tnCTRCeTk4BoZmLTgcIOPwL14L5uG82CANejdA
 XE18zuSqsXKYtxQG1pm/3ou0EtdLyeUs590FHm+lD0Dzgdi9Qk82fqJgkbuZqcRcNvI=
X-Gm-Gg: ATEYQzzmgV5RYJKAxskK+2eoxQn9afxuPWYJeUzdoFIOd4aHOgtSK5st/UlBMbXGu+W
 S16y1qoGhuQTqVb8caHzBYBVWgimgN9g8HQJUZrEY3UP/v8vmkxyZ0u66Cnv3ZfXyHtZo+tAbSC
 Ek4TS3/ZXLw2BCXCFKUE2kIgn2BHK94JK0TyppTimh543uYxHblw6wpYT/n8c2hJ3Y9H7w8q2rj
 Lg8KFez+n1K8b2Zi7W/of/2UrwNhUhFMfr7D4F8MUzHAMYd+Ldok1QxoxMzPC6P7zSdOvX7DG+0
 ffQEhm9GU8C8QkfVK2HX0Mm8W52owD6iMwqPmak2tkh1O36vX4pE7sb7wf3qrp6Y1w0iCFgAfna
 u8FK/xiQM06RtJnW+VUGhqkIFPd5VEAI1nILyHCvrw8w0KhED8E4QRifmTL6i200HmxtjH7//aJ
 pI2YXiB3obIrAvRA7cCnSx0uIwh5wg9leeW5uX05cSxIUeu2Q1j93Yz+9gOpko7AUtvQ==
X-Received: by 2002:a05:6000:4310:b0:439:c596:fa13 with SMTP id
 ffacd0b85a97d-439f81bc69bmr7004155f8f.4.1773251646417; 
 Wed, 11 Mar 2026 10:54:06 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm898190f8f.4.2026.03.11.10.54.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 10:54:05 -0700 (PDT)
Message-ID: <88a2420d-5927-47bc-8192-4c218f219531@linaro.org>
Date: Wed, 11 Mar 2026 18:54:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] hw/hexagon: Add v68, sa8775-cdsp0 defs
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311042019.1085030-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/3/26 05:20, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc | 64 ++++++++++++++++++++++
>   hw/hexagon/machine_cfg_v68n_1024.h.inc    | 65 +++++++++++++++++++++++
>   2 files changed, 129 insertions(+)
>   create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
>   create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc
> 
> diff --git a/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc b/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
> new file mode 100644
> index 00000000000..3d787c104ff
> --- /dev/null
> +++ b/hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +static 

const

   struct hexagon_machine_config SA8775P_cdsp0 = {
> +    .cfgbase =         0x24000000 + 0x180000,
> +    .l2tcm_size =      0x00000000,
> +    .l2vic_base =      0x26300000 + 0x90000,
> +    .l2vic_size =      0x00001000,
> +    .csr_base =        0x26300000,
> +    .qtmr_region =     0x26300000 + 0xA1000,
> +    .cfgtable = {
> +        .l2tcm_base = 0x00002400,
> +        .reserved0 = 0x00000000,
> +        .subsystem_base = 0x00002638,
> +        .etm_base = 0x00002419,
> +        .l2cfg_base = 0x0000241a,
> +        .reserved1 = 0x0000241b,
> +        .l1s0_base = 0x00002500,
> +        .axi2_lowaddr = 0x00000000,
> +        .streamer_base = 0x00000000,
> +        .reserved2 = 0x00000000,
> +        .fastl2vic_base = 0x0000241e,
> +        .jtlb_size_entries = 0x00000080,
> +        .coproc_present = 0x00000001,
> +        .ext_contexts = 0x00000004,
> +        .vtcm_base = 0x00002500,
> +        .vtcm_size_kb = 0x00002000,
> +        .l2tag_size = 0x00000400,
> +        .l2ecomem_size = 0x00000000,
> +        .thread_enable_mask = 0x0000003f,
> +        .eccreg_base = 0x0000241f,
> +        .l2line_size = 0x00000080,
> +        .tiny_core = 0x00000000,
> +        .l2itcm_size = 0x00000000,
> +        .l2itcm_base = 0x00002400,
> +        .reserved3 = 0x00000000,
> +        .dtm_present = 0x00000000,
> +        .dma_version = 0x00000003,
> +        .hvx_vec_log_length = 0x00000007,
> +        .core_id = 0x00000000,
> +        .core_count = 0x00000000,
> +        .coproc2_reg0 = 0x00000040,
> +        .coproc2_reg1 = 0x00000020,
> +        .v2x_mode = 0x00000001,
> +        .coproc2_reg2 = 0x00000008,
> +        .coproc2_reg3 = 0x00000020,
> +        .coproc2_reg4 = 0x00000000,
> +        .coproc2_reg5 = 0x00000002,
> +        .coproc2_reg6 = 0x00000016,
> +        .coproc2_reg7 = 0x00000006,
> +        .acd_preset = 0x00000001,
> +        .mnd_preset = 0x00000000,
> +        .l1d_size_kb = 0x00000010,
> +        .l1i_size_kb = 0x00000020,
> +        .l1d_write_policy = 0x00000002,
> +        .vtcm_bank_width = 0x00000080,
> +        .reserved4 = 0x00000001,
> +        .reserved5 = 0x00000000,
> +        .reserved6 = 0x00000003,
> +        .coproc2_cvt_mpy_size = 0x0000000a,
> +        .consistency_domain = 0x000000e0,
> +        .capacity_domain = 0x00000080,
> +        .axi3_lowaddr = 0x00000000,
> +    },
> +};
> diff --git a/hw/hexagon/machine_cfg_v68n_1024.h.inc b/hw/hexagon/machine_cfg_v68n_1024.h.inc
> new file mode 100644
> index 00000000000..734a12a2f12
> --- /dev/null
> +++ b/hw/hexagon/machine_cfg_v68n_1024.h.inc
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +static struct hexagon_machine_config v68n_1024 = {

Ditto.

> +    .cfgbase =           0xde000000,
> +    .l2tcm_size =        0x00000000,
> +    .l2vic_base =        0xfc910000,
> +    .l2vic_size =        0x00001000,
> +    .csr_base =          0xfc900000,
> +    .qtmr_region =       0xfc921000,
> +    .cfgtable = {
> +        .l2tcm_base = 0x0000d800,
> +        .reserved0 = 0x00000000,
> +        .subsystem_base = 0x0000fc90,
> +        .etm_base = 0x0000d819,
> +        .l2cfg_base = 0x0000d81a,
> +        .reserved1 = 0x00000000,
> +        .l1s0_base = 0x0000d840,
> +        .axi2_lowaddr = 0x00003000,
> +        .streamer_base = 0x0000d81c,
> +        .reserved2 = 0x0000d81d,
> +        .fastl2vic_base = 0x0000d81e,
> +        .jtlb_size_entries = 0x00000080,
> +        .coproc_present = 0x00000001,
> +        .ext_contexts = 0x00000004,
> +        .vtcm_base = 0x0000d840,
> +        .vtcm_size_kb = 0x00001000,
> +        .l2tag_size = 0x00000400,
> +        .l2ecomem_size = 0x00000400,
> +        .thread_enable_mask = 0x0000003f,
> +        .eccreg_base = 0x0000d81f,
> +        .l2line_size = 0x00000080,
> +        .tiny_core = 0x00000000,
> +        .l2itcm_size = 0x00000000,
> +        .l2itcm_base = 0x0000d820,
> +        .reserved3 = 0x00000000,
> +        .dtm_present = 0x00000000,
> +        .dma_version = 0x00000001,
> +        .hvx_vec_log_length = 0x00000007,
> +        .core_id = 0x00000000,
> +        .core_count = 0x00000000,
> +        .coproc2_reg0 = 0x00000040,
> +        .coproc2_reg1 = 0x00000020,
> +        .v2x_mode = 0x1f1f1f1f,
> +        .coproc2_reg2 = 0x1f1f1f1f,
> +        .coproc2_reg3 = 0x1f1f1f1f,
> +        .coproc2_reg4 = 0x1f1f1f1f,
> +        .coproc2_reg5 = 0x1f1f1f1f,
> +        .coproc2_reg6 = 0x1f1f1f1f,
> +        .coproc2_reg7 = 0x1f1f1f1f,
> +        .acd_preset = 0x1f1f1f1f,
> +        .mnd_preset = 0x1f1f1f1f,
> +        .l1d_size_kb = 0x1f1f1f1f,
> +        .l1i_size_kb = 0x1f1f1f1f,
> +        .l1d_write_policy = 0x1f1f1f1f,
> +        .vtcm_bank_width = 0x1f1f1f1f,
> +        .reserved4 = 0x1f1f1f1f,
> +        .reserved5 = 0x1f1f1f1f,
> +        .reserved6 = 0x1f1f1f1f,
> +        .coproc2_cvt_mpy_size = 0x1f1f1f1f,
> +        .consistency_domain = 0x1f1f1f1f,
> +        .capacity_domain = 0x1f1f1f1f,
> +        .axi3_lowaddr = 0x1f1f1f1f,
> +    },
> +};
> +

Are these configs generated?

