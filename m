Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED466C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0lM-0007bU-Ra; Mon, 02 Jun 2025 04:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uM0lL-0007bE-Uj
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:43:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uM0lK-0003F7-5A
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:43:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so26639805e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748853796; x=1749458596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3kFnz/9k+Y5MAUSoT/JUxXU5CSOd/6L2UqPd55OfWfQ=;
 b=Xksfpme8nijLlLjNrauSbQiuANw99Fp5jXoSwQLs0ftbTbPeogCxJ89mKgy5yR0YeR
 QJNboJq53OnROdbw3+iI+DJogTF+S3WGZhj+GwOElIF3KiR4Jx69US2CIJEDHTkSzmeM
 vy+GfvsfTjCmqUuhUy+sDKud97GEdYSFkwEolthVsbSWjHAe957msr3fjSwG53+6QH4V
 p6YxlzHxMddbgMz7/3ulmibkikajyR2TcbC/ZLNEI1k0DdaLTBB2h4z5uA/K28A+7Dg7
 4EsumX9/92g+vrI+X2qcBCtNIkC8M2ag90g9jYKsnoqyCPh5kGvhXTw8787Wz17UV4Td
 lsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748853796; x=1749458596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3kFnz/9k+Y5MAUSoT/JUxXU5CSOd/6L2UqPd55OfWfQ=;
 b=SoXtyj0pY7th2fGH7+qVmSJme/lT+KX321LQSbhpTjl2nHCtnjk4iPM4rIoiCBCBK8
 K2ckxsEy4cJiL27UWZz/824lFRt4HTnmfn83hQowiyX+h6fNu+ZozuIBTZu/KpBv4klE
 vF4fnnL/A9VLnsvv5uB/yDeXiIt7uXQW+PVfW3iv1wRx8yJzs0JAd93O5jKKbMkK4Ccm
 sAMiSj0mFte9CtRG7oleuNdGoYIop3lycqsipLT73UsedumOYvJlvel7rBlGL0dZXyVT
 A5rVN72MG5EFcWXHaMCDWR8Qdm3hKEEsDMxblBJlZ+9vci57cdT1PMNkRUHDf1H09S6n
 78yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWViOnFsOCNrKO8MGko+nTRstltRKk4sBY3ZuF5Di3Rg3NkaVHUUX5L37RlJylWPA1Cm0ekyLXHMis@nongnu.org
X-Gm-Message-State: AOJu0YwNRB5yxlBK20vQkACNz8j9LI36UyTXhiLxt//gI70SkM9pKd8R
 s+DwjeBlC3blV8QVVScnCO5WZ1ahpAizpblKOn1om5DJDDkuBkh/3w8s9QgcOjI57dQ=
X-Gm-Gg: ASbGncutDrGqrPC9zEcSmLzb11ZKGyXN41X/BVHEMlarj3YgQU/THjs8H1NW+JnkmL0
 hOiPkBsi6LKvifAFAbPiBQe5K1uiXmBijjutbvJejmL2R5N2sHK9JD2EIuD+hlVF5r370GVevOR
 O4O27NcowusWLpu8LLdFVTQGqXlKafmx1U4Ass3ebxgRzih6vfqxOBzpKN8zHqavfa+K8/w5XK0
 GxlhAjxNBv12oKWnSnKcTqGmZpB6BHW/draMCMTGOd2fgJA2bgmzLPxrQwwx6UE1u3fZvdDB2Km
 Qm70+E7H7xnkzwQ1rsrNPgH/PGHOUqyJx9Jwa1TVCEW7CaIRSxXPEWiehbG8AM0TXk11mY19RjQ
 x5t7AA4n6jyTWF7CtgA8V
X-Google-Smtp-Source: AGHT+IGFWFM1csx1rFJXOB1jIodfGwedHxWVUjOSq+r7+gKfj9XeZYKhGYiBG1xKS0hPY8iypzZnhg==
X-Received: by 2002:a05:600c:871b:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-450d655c68bmr115813555e9.30.1748853795906; 
 Mon, 02 Jun 2025 01:43:15 -0700 (PDT)
Received: from [192.168.1.127] (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c4f2sm13889209f8f.22.2025.06.02.01.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:43:15 -0700 (PDT)
Message-ID: <d3e19880-08b8-4ec0-b897-36118ad9f160@linaro.org>
Date: Mon, 2 Jun 2025 09:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/loongarch: fix vldi/xvldi raise wrong error
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org, lorenz.hetterich@cispa.de,
 qemu-stable@nongnu.org
References: <20250522065532.3809286-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250522065532.3809286-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/22/25 07:55, Song Gao wrote:
> on qemu we got an aborted error
> **
> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Aborted (core dumped)
> bu on 3A600/3A5000 we got a "Illegal instruction" error.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..b33622ff79 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>   {
>       int mode;
> -    uint64_t data, t;
> +    uint64_t data=0, t;
>   
>       /*
>        * imm bit [11:8] is mode, mode value is 0-12.
> @@ -3571,7 +3571,6 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>           break;
>       default:
>           generate_exception(ctx, EXCCODE_INE);
> -        g_assert_not_reached();
>       }
>       return data;
>   }

This is correct, in that it eliminates the incorrect assertion.

However, is the priority between EXCCODE_INE and EXCCODE_{A}SXD correct?  For Arm, at 
least, decode errors take precedence over disabled functional units.

I suspect that vldi_get_value needs to be merged into gen_vldi, so that the exception case 
can return early, and this needs to happen before the check_vec().


r~

