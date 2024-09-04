Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2C6CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 19:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slvJx-0007nC-1v; Wed, 04 Sep 2024 15:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slvJs-0007k3-7B
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:05:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slvJq-00048R-Fk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:05:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20570b42f24so38313395ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725476728; x=1726081528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rKH+Uj6vFcYNPjExDu3jbUWGdLw3KjpPW/eoFDkoW20=;
 b=Oi/ZMuyNcz9ItRE/Ivt3gPfl0kDNMLIumd9jEOnnL24aB6zagxwNRA0g5eNR/0M/c4
 AeRYYoJGEoIQ8ia1wBkZMNTs01XCATrIvDB7ICTl/0wBDUBo0yR9hkTzajhHz7SB6703
 Togd/gLOnLSaJOwt3/vnN8VpHzMAfgFF997r4/AVpSoQlpLK9mlmI2RvFNpxV9JY3K9H
 uxFAWaMbiICJU2Uk0rExPtffgbcDw4TebOuxF9s9NkOCLJF1okbGRkUIQdrq1rFqBDoS
 pZc130Ba5N7Xd3VzV8c+QAu97SXrUKSNOuJtH5qKA//+GM5SKsunfUakHAeOM4PCuW/S
 B0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725476728; x=1726081528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKH+Uj6vFcYNPjExDu3jbUWGdLw3KjpPW/eoFDkoW20=;
 b=Z1zYOxYGcShsQfRLHZ+TLPJxX0VFRZAbTAnFnaT2bByIeNKtvme5N3oq7Ta30GeRdU
 oaY/NzR0hhqtD5MuRiInw1GRANv+yu/p/EsjiGK6da5d0SYQkdGLbUzqf9u7k4bqvkJZ
 piGi7mdU+e/Ztv9M5Q9I5sQb6vlwfsrqHOQte/MrKrNuRtb3YN8YMPcKH/9b7rWs9ROH
 qEsgQzarGRGl+8n5uCgHrNXtPU77bCcY+PguEPAvbB4ZoA5s7OZsmm7GvNroXGzgKppf
 meyZTch085n3Q8b5VkGiEru0UQU1sfW1eHjrduJU2tB9xWMcNsBUIzHF3frtdkAEfF+G
 Y/Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmxhvL1zVPLcjHy9GqQHmzzlLgUaZ5Ts/B0ORabZ7T6ydtlFdm07ZFqudCzy4X+q6NHQk9p4/tVjst@nongnu.org
X-Gm-Message-State: AOJu0YwsfGJgtXFybTi6PTVSeEkdFm3urAxsoxKTQnSKfQ5PXuB+3XjO
 cZl3qzeR+T+HtwOytw0xqb6ZUHcZK3mnjJ+3UXqhp5j0GRVlo9E7gSmW3wBZrrQ=
X-Google-Smtp-Source: AGHT+IGnszYHRe8rX7wCStSyFFNz+oG2uI8caz4mieCZornCM2jfy/kznL03jXKddTsVLcOwuxj7OA==
X-Received: by 2002:a17:902:f682:b0:206:9640:e747 with SMTP id
 d9443c01a7336-20699b21af3mr74559345ad.43.1725476727531; 
 Wed, 04 Sep 2024 12:05:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206ae9138b5sm16777795ad.50.2024.09.04.12.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 12:05:26 -0700 (PDT)
Message-ID: <ea3474ab-947c-492e-b264-0fff3fcd30f7@linaro.org>
Date: Wed, 4 Sep 2024 12:05:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] tcg/riscv: Implement vector roti/v/x shi ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-14-zhiwei_liu@linux.alibaba.com>
 <97873524-9e47-44c4-b34a-a27e9833b0e1@linaro.org>
 <141dbbff-55f6-4628-9701-554b0d32440d@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <141dbbff-55f6-4628-9701-554b0d32440d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/4/24 08:25, LIU Zhiwei wrote:
>> I'm trying to work out how much benefit there is here of expanding these early, as 
>> opposed to simply using TCG_REG_TMP0 when the immediate doesn't fit,
> 
> We find for rotli,  it just copied code from the implementation of INDEX_op_shli_vec and 
> INDEX_op_shri_vec if we don't expand it.
> 
>    case INDEX_op_rotli_vec:
>          if (a2 > 31) {
>              tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, a2);
>              tcg_out_opc_vx(s, OPC_VSLL_VX, TCG_REG_V0, a1, TCG_REG_TMP0, true);
>          } else {
>              tcg_out_opc_vi(s, OPC_VSLL_VI, TCG_REG_V0, a1, a2, true);
>          }
> 
>          if ((8 << vece) - a2) > 31) {
>              tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, 8 << vece) - a2);
>              tcg_out_opc_vx(s, OPC_VSRL_VX, a0, a1, TCG_REG_TMP0, true);
>          } else {
>              tcg_out_opc_vi(s, OPC_VSRL_VI, a0, a1, 8 << vece) - a2, true);
>          }
>          tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0, true);
>          break;
> 
> Thus, I prefer to expand it early, at least for rotli_vec.

static void tcg_out_vshifti(TCGContext *s, RISCVInsn op_vi, RISCVInsn op_vx,
                             TCGReg dst, TCGReg src, unsigned imm)
{
     if (imm < 32) {
         tcg_out_opc_vi(s, op_vi, dst, src, imm);
     } else {
         tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP0, imm);
         tcg_out_opc_vx(s, op_vx, dst, src, TCG_REG_TMP0);
     }
}


     case INDEX_op_shli_vec:
         set_vconfig_vl_sew(s, type, vece);
         tcg_out_vshifti(s, OPC_VSLL_VI, OPC_VSLL_VX, a0, a1, a2);
         break;

     case INDEX_op_rotli_vec:
         set_vconfig_vl_sew(s, type, vece);
         tcg_out_vshifti(s, OPC_VSLL_VI, OPC_VSLL_VX, TCG_REG_V0, a1, a2);
         a2 = -a2 & ((8 << vece) - 1);
         tcg_out_vshifti(s, OPC_VSRL_VI, OPC_VSRL_VX, a0, a1, a2);
         tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0);
         break;

r~

