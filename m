Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30228C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 01:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skvux-0000BP-Lu; Sun, 01 Sep 2024 21:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skvuv-0000AS-NF
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:31:41 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1skvuu-0003GE-53
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 21:31:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7bcf8077742so2673699a12.0
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 18:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725240698; x=1725845498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fW61XfU2gh3b9mbhHv4UeKbJI3uysAe1zB+XJEsGzjI=;
 b=mKlK6JET5F2ehdtZTQFCqzCwozIjhM3Y+dhAs5Wb+b34HYPTFNUKbhZXuhmDmEsh7i
 9jwkCzz8EnTmbHUNGb/tSjvAcJum60q+fSPLBuGl8GCvB+Iu7msCmZ7vULip4/1LF/TP
 ky7THu3/ZzHe+05XqhaBiYNLN6kxmQgDf6w1Tw6finJLYqxHahqYGnSdm5cbFi+dib3H
 Ho7lz4MmUAyCQnFtg6sKQTZSeiigxjFxVjcxa10JLouL0Jf6ujpoytqEDXd89/DuYmvR
 tIHUborms08fDz7hJl3s9HPrlQl5PNJzduy8zSgIZHkDL2OO5oGsEnAq6Y11fnbdb0oK
 Aa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725240698; x=1725845498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fW61XfU2gh3b9mbhHv4UeKbJI3uysAe1zB+XJEsGzjI=;
 b=xCZxZgiXZkZ3vgty7capZgkjUsMsxXhl5huQprdSemaqy67QjQSawq9xumrpn10rCu
 36ciLGNfLNznko2mwoiFYY8fLDKuSjQh+PIE1t8Deq0XpS6+cWpQJ7y6JPSGlhfl2UN/
 lFhzn6dF/f8Vrw6w4mspEquPSDGolWD41NfKAa/ajPp+8HYyfyyuKraneS0FVhSE+ioF
 QYm4sU/wVeYLbtjZdOP+wMQK5oHNM0vaD8M2nrY7YYT5JttzT8r96EqmEHOvFRWi5RQh
 rHg2puTiJKuWa22OwTzV1HbcIMxyIFb/4EZ7YAieE6pIsXeqQaxlJI0+eX9vbbqz62cj
 6CiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEXWG62liKqNBlJw8//cuohR41w6wyzlg8QRp1oRk4oBXcvdobKyewKBNMSlywGVBbD16DCw6GF4sH@nongnu.org
X-Gm-Message-State: AOJu0YzUXCn2o2cDzQjgIw8fcDXgZ2+yVRvZiz8FVXJUMzJjRZTV/D+d
 ak+Ssc2VpyKORLIuohTR+d1ZHI1DM36wc8JIL7wkEETWsjDlOE5Z9qV3N9JETVE=
X-Google-Smtp-Source: AGHT+IEXYNOccEOKNRdlFUCHrd2OUINqyGkz+Wg+lVWmZoEU5Zuis1QDkdwmC/qDSxqxL++YVLvaFQ==
X-Received: by 2002:a17:90b:390c:b0:2ca:5ec8:576c with SMTP id
 98e67ed59e1d1-2d85616ebeamr12924888a91.5.1725240697917; 
 Sun, 01 Sep 2024 18:31:37 -0700 (PDT)
Received: from ?IPV6:2001:8004:5170:1fd8:ef9d:e346:b99e:7072?
 ([2001:8004:5170:1fd8:ef9d:e346:b99e:7072])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445d5a9fsm10429780a91.3.2024.09.01.18.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2024 18:31:37 -0700 (PDT)
Message-ID: <b5032add-5955-4cf2-baaf-1b5afc000cb3@linaro.org>
Date: Mon, 2 Sep 2024 11:31:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] tcg/riscv: Implement vector load/store
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-6-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 8/30/24 16:15, LIU Zhiwei wrote:
> @@ -799,6 +834,17 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
>       case OPC_SD:
>           tcg_out_opc_store(s, opc, addr, data, imm12);
>           break;
> +    case OPC_VSE8_V:
> +    case OPC_VSE16_V:
> +    case OPC_VSE32_V:
> +    case OPC_VSE64_V:
> +    case OPC_VS1R_V:
> +    case OPC_VS2R_V:
> +    case OPC_VS4R_V:
> +    case OPC_VS8R_V:
> +        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, imm12);
> +        tcg_out_opc_ldst_vec(s, opc, data, TCG_REG_TMP0, true);
> +        break;
>       case OPC_LB:
>       case OPC_LBU:
>       case OPC_LH:

I think you shouldn't try to handle vector load/store in this same function.
You'll want something like

     if (offset != 0) {
         if (offset == sextreg(offset, 12)) {
             tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, addr, offset);
         } else {
             tcg_out_movi(s, TCG_REG_TMP0, offset);
             tcg_out_opc_reg(s, TCG_REG_TMP0, TCG_REG_TMP0, addr);
         }
         addr = TCG_REG_TMP0;
     }

at the top, instead of the imm12 split currently at the top of tcg_out_ldst.


r~

