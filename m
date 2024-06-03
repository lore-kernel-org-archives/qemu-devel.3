Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EF0C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6kW-0001rj-Qf; Mon, 03 Jun 2024 08:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6kV-0001rV-6K
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:25:15 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6kQ-0004Eh-5p
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:25:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35dce6102f4so2891580f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717417505; x=1718022305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E74LP4Y/GXZl6YQQGnWKRM0gzJNlwqsKQGudOIQJrBw=;
 b=xT0Nbojib57HvVj7PpSlRSaDSqKgmZnbsit0lP2P42VWIRzFX7HHXItb/b1yHrUG0r
 H1+rrD8uNYxr/gtSOcqG4lX1zfo4gfygDxfRiZFxYRAeQEEX60Nbw5sOc+p2ipX2yZcf
 tBfjhnWFkqm4M8sR7ZMURCTyLoAk5DC6izKaI1+nbG13x/d2QgNa3Tag0wda4Nksi9SS
 2O8i0b2cNf24dZ4MJ1R6n++TfdqO6s2Ocy+fNkJ6U+lnM8FK3THD/8/sg9Dh1/CcrhDi
 eEsTVKf2lXSk18tCodM+vgYwrroDyu0xtN39TuKp9y6J+G1RuvWtDDfUL1s9pfaGuLV5
 FE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717417505; x=1718022305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E74LP4Y/GXZl6YQQGnWKRM0gzJNlwqsKQGudOIQJrBw=;
 b=lzPCEOF6QwgfXbf5UAEEFaNgN/tTsoaD93YThQpNCQ+t5CIwUHtixmsYBK2wPz0BkG
 kiKoeHZR/PSxPWtWoRlbGGvCcss0lo5LoL23sdqWp8cLf9qkikcC0c7g63WPwFNeM1sj
 6RQHggiiOgt1Qj0i6kNfKR2t4J5iIM5XVBFZatBIs2kgDovmaK60VYnQj3AfOcdGyq9f
 xWrQwM0EkZ8DCCjI1wY5TvP86Un4cXcVsgluxgFXjpLI05mY5QO7roEl8fXvpvxH2aC8
 auljT2soLPgdLby7WqQ8QnHR4r/lYkuQy9qd8B8vWt56uMfcCNPWosHrMvNkheAwMwnr
 vYug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4gdptJBxeOFbnJlkD53XAuZaZXapUokhq4Du1B/hFSkOTCRzRQVZ2nPQSDAjsRUx/CDhNgMakM0WiMT27jQiBS6kb4Wk=
X-Gm-Message-State: AOJu0YyvVhDx/KaV58cvxOFq9qeBi/NNKF0VfurOVNUIE0ohnyAA4Xnv
 DcV4/92vBWack/PUIQ7DcTfW0tSJMkWOoIGh9fp8BipHDCV6SxXecbhqCu9NDbw=
X-Google-Smtp-Source: AGHT+IEIGyaka/Z7/dWW+hPBaLNfz3p6/+fmhlouvsDhK0aSNobVl197v+YyzAI3tJrNipcMkqaYjw==
X-Received: by 2002:a5d:460f:0:b0:354:c934:efa0 with SMTP id
 ffacd0b85a97d-35e0f30c7b2mr6968849f8f.48.1717417505113; 
 Mon, 03 Jun 2024 05:25:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0e8fsm8689410f8f.2.2024.06.03.05.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:25:04 -0700 (PDT)
Message-ID: <38b8ba4a-437b-4ab3-abab-25c7af203dfa@linaro.org>
Date: Mon, 3 Jun 2024 14:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/32] hw/sd: Add emmc_cmd_SEND_OP_CMD() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-16-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-16-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/7/23 15:24, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 409fbbcbd8d7..f846440b737a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2171,10 +2171,17 @@ static const SDProto sd_proto_sd = {
>       },
>   };
>   
> +static sd_rsp_type_t emmc_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)

"emmc_cmd_SEND_OP_COND" I suppose?

> +{
> +    sd->state = sd_ready_state;
> +    return sd_r3;
> +}
> +
>   static const SDProto sd_proto_emmc = {
>       .name = "eMMC",
>       .cmd = {
>           [0]         = sd_cmd_GO_IDLE_STATE,
> +        [1]         = emmc_cmd_SEND_OP_CMD,
>           [5]         = sd_cmd_illegal,
>           [19]        = sd_cmd_SEND_TUNING_BLOCK,
>           [23]        = sd_cmd_SET_BLOCK_COUNT,


