Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63419F99C6D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDt7d-0007Tw-MB; Fri, 17 Apr 2026 20:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDt7b-0007Tk-7Z
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:01:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDt7Z-00059a-JA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:01:14 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso849889a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776470471; x=1777075271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=le/YmQzmlY9MiCvkr9nid44C8Rmu09QXeLU/kryfTvo=;
 b=E4h+smdFdUqJR48EwZW1SWi/pFAuwJfrvJeNDn5JlprATsKzfTL9dGTPvLf0Ve3qcW
 TXUstaLr9RSWBFaV+PCDQk0ka5ENjy4MtNu3LC0xgNxCW5rxl3c+Ue9w+RFev5YTzNd4
 /Oa/A99Ty3mXeQxM0EXKhjWW0RN5OQFYz76K3/A/3AOcXwHHsKs3kdRU2eOOY9vLqcRd
 LG87nFYDYoLCOD6Xjczt30Fszb7DV2HUrif62tq2z8U7NUtjFppexLplpSDCre0NY5Qk
 YRF2v/Rjf5XaJrLcpXtUBbsJUfFVPJChQc846NjM2aeCNBKMjTsHmGox1bO/A1Uxb7lB
 dq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776470471; x=1777075271;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=le/YmQzmlY9MiCvkr9nid44C8Rmu09QXeLU/kryfTvo=;
 b=BQvxqd+hAxIipG6mSiYcEduRnKICEGmqT2Is54oYuWaL0vJ8WRHO9jBLm/P8jSKV0M
 8ZleiH70bIfgBUcamxBYgCi9QDHMxVXTQqS2pArWVKwaOF5IoVBEAv8LgQ4oh/16HT8y
 5ofUNUxT9BTo4XVGNIrXPumSGkcCgR1/hOSgWk/BMC/gu7ttBYu83UJP+PwR8PZPBNsY
 9EhQMC3aA6/gsSOffqtC1AYwLAeMZ66xwYaz2nt+PH2C439zrCWFoMC9wwe3wk5cL1Vr
 jtl6MHwigw52+cYGPnyoeyijdk/U2VYjI4Y3nMnYD55WQtCY4VdM4ULAOiz74bMPIRKO
 hb6A==
X-Gm-Message-State: AOJu0YxtVtppybP6KqRAV+CSpeJqYoZ32m0qiAtUCbUKHYdES1TxnjQo
 GwIRAvxk9GW0FVdO6EG/LJu1iM3W4WyM3t0qWGPgCjqd4BHL9VqrgzXgYQruKzdnFuAGOmWfN9/
 ujW/LJ80=
X-Gm-Gg: AeBDieuS54FfI/CiDTx+9evVvYkngXWqa+Zi8h/yenHnGSEQZmu3XJrV+PU+2q2Zx1v
 BIZbfnuNo81ojScPUtNYCCFy2d+cGsiOzF4xD36YzJHzn5pRRrliLE2TkSwrYnhJgn9m46yu9El
 S+ppETZp6X6Fc2e+JrTTgO2gBhUog4eAtfl+MyrPncrLexE0DQ9sHQ0d8TwbeRmVhMgyGq3hWrH
 zBJSenHuSXjyU3bpOEdEUbfXdeRj4kH9j7MwEUFuAByZSamntIB2RTITt2RGhxuulcljPca/dbw
 f1/hrB1UQfuulcyTU9FGnq9AX7SNGiMJ01Xl2pdYhR020+pVU1fzzBk/CBbMeIF9TIwrfsjO9Ip
 u7BbB0c1A7e9DLIA/+QdRcExe/dg1xru0HINGmczwM3LfSNql9/XIy5O1Cf5CeKhG0NWV4vdePh
 98IW2cJ6lBFg9CM3ovmCMoWbLyuR9qWNK9gSP1wkO+jeRMgYgmIM6nXz/RqsmsJq9VnX0KP1d7G
 xd/q4ls52+LNoQJK87QNqKs
X-Received: by 2002:a05:6a20:2451:b0:39f:461f:be7e with SMTP id
 adf61e73a8af0-3a08d8fe55bmr5099374637.44.1776470470328; 
 Fri, 17 Apr 2026 17:01:10 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:742f:8dfc:5be0:dc23?
 ([2401:d002:dc0f:2100:742f:8dfc:5be0:dc23])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f9cacasm2427470a12.8.2026.04.17.17.01.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 17:01:09 -0700 (PDT)
Message-ID: <59793b74-2ecb-442b-ba67-41d90492b4f5@linaro.org>
Date: Sat, 18 Apr 2026 10:01:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/riscv: rvp: add arithmetic instructions,
 including saturating and non-saturating operations
To: qemu-devel@nongnu.org
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <20260417104652.17857-3-xiaoou@iscas.ac.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417104652.17857-3-xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 4/17/26 20:46, Molly Chen wrote:
> +/**
> + * PADD.B - Packed 8-bit addition
> + * For each byte: rd[i] = rs1[i] + rs2[i] (modular)
> + */
> +target_ulong HELPER(padd_b)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t e2 = EXTRACT8(rs2, i);
> +        uint8_t res = e1 + e2;
> +        rd = INSERT8(rd, res, i);
> +    }
> +    return rd;
> +}

tcg_gen_vec_add8_{i32,i64}.

There are a fair few other vector operations that can be expanded from wide integer 
operands at the end of include/tcg/tcg-op-gvec-common.h.


r~

