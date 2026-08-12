Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33529C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAxU-0005o4-Dd; Wed, 12 Aug 2026 11:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuAxR-0005kt-Nh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:33:33 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuAwj-0004Kq-7t
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:33:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so140494b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786548767; x=1787153567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J+oEVeFA6TSg3Gh2SM1RNT5hqgGZ4fgL/Ch22eQuV4E=;
 b=N6rAQn9ykk2Ck7NT9eLJRH9wPu0TcoYqNwEGbCNaoBSMbdpoy7T4C4dR+SUk/w8wDP
 rElPDbiSqoGspyZ2ZuWvnULF6dDj5hUmmPGZI2g4Bnz4+HpQceyVepVB7m+qop6Q8yxK
 yhOukDf8/0vbPBL963KrIWvxnAL2BomuQrjAPkNrfqrWqV9qhdGCdGmBzoIFQraqhQIA
 dNN5Vx67fXx1OcwcmIahnebr1zoijllFf5vXMKPjNus7a6xTIIhHJ92aAjXydZwUX9dP
 xV0cDYsQrh65ZzbtsVidqIXHMNTj9FL+qTlSG3BlkYz8J5drxEY/lsMqPbkRuO+Ybpj0
 EuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786548767; x=1787153567;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J+oEVeFA6TSg3Gh2SM1RNT5hqgGZ4fgL/Ch22eQuV4E=;
 b=GEiVpvDw+0TTXlneKQ+spIf1fi2qOLLaH8weEYgPnNlQkv4ioxO7OJEuid8nTcRtb3
 EqWZduk/RkMARxS9WdRy/45YQG5XqKr1/FvV/V42wLTf9iM46RM5qbd5KRrSVbyOJibc
 DvihUPN03lN7RNWlp5rRvS8Z2BA4lHhMbm0ukkSNxtHioM2WoWZVfyRdhG4MKkTJtFQT
 TUdorUqGlRNALJmlKjI6lHcyEclEA0uhfAbFw9jP1EKY/uW14l3vNsmfYoqI3RXWlFV1
 MKgXj+m94Lo4OMqROW64C/VZSG/ySIOLMQCeIUpzhMcgYJesc9IC7GfFL8DkLJsVAMfw
 FPjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqifXdi7NV42Wr/5DxHty481q7gb+yBvM63hwHRKzoKnLJaKgo+lHsXUlW4y3PO58q9FfsVDfOpZ2bb@nongnu.org
X-Gm-Message-State: AOJu0YzMA41FQu+gfxGMSv/UpOBNv22S7vRnfSSXTfHaf04MyTJJcYdV
 SbjjCUK+bTko+LdydAeqsQ/A4rJkzpxryQEx2t2jmnd6euQ62VyX0yrIjXhREwaxJ5s=
X-Gm-Gg: AR+sD12Xa//emPcgkdd8TAW717TAkx4LTT+eYt7b8UOnVDshM36R8JdYdoJh3sU+Q73
 HNvKHB1JN/AvAdT4SSmzfzuLWNLsJknxRCwhwjcG+CcmOpCwkeSZdvvzMN3aMgZdQziD+jo8AKq
 oaz3fXJWXIS1CtlJB36wZ6ZHdc0J/Su4ryJ2WCbTHse4y3gDwK9LBzjEeiXEMEva0kYj0CeHy1M
 jFuS6gMTYTWDiRuh4Vn6OO4W0WuR48rcFsn+TJUSZmTWJg+hbqHgsaJnEXNE4loAbGovlg5n9n7
 LFRfVHbnWFhLo8Yfek/O/2DOai74AC5bOoYO0Xao7A1djPqIWUwvO86GpRqEH7AyA/OlqOEtu6+
 grXZY9ESIrGnOjW9b8sxVug9RU74Gy75s6XKS73qB3nP3vaCI9AVwXqR2eVKcggwLbmGBb6hQt3
 hHwMKgA3r4iOvRFiMJlj9E5yWL2U4Qpd/HJ5kQVI9q5ulkd1XHzoQCSKLqv7xWNYSdsow58gIBI
 2p4Ln5CXdftBxJnGfv4txCXBvdN
X-Received: by 2002:a05:6a00:178c:b0:82f:38df:681c with SMTP id
 d2e1a72fcca58-84fb53d6a1dmr6687087b3a.6.1786548766915; 
 Wed, 12 Aug 2026 08:32:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f6ef0fsm1229209b3a.54.2026.08.12.08.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 08:32:46 -0700 (PDT)
Message-ID: <2c195c3e-5b63-40d4-a9e0-348a555f9e19@linaro.org>
Date: Wed, 12 Aug 2026 08:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Set aliased x87 exponent bits to all 1s for
 MMX register writes
To: Simon Scherer <scherer.simon89@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20260812122114.510447-1-scherer.simon89@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812122114.510447-1-scherer.simon89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/12/26 05:21, Simon Scherer wrote:
> Per the Intel SDM (Vol 3, 15.2), writing an MMX register also sets bits
> 64-79 of the aliased x87 register to all 1s. gen_writeback() never
> does this for X86_OP_MMX destinations, so those bits keep whatever
> the x87 side left there (e.g. 0 after finit/fldz). A later x87
> instruction such as fucomi/fucomip can then read a stale finite
> value where real hardware guarantees a NaN encoding, changing
> comparison results and flags.
> 
> Set the high 16 bits to 0xffff when writing back to a MMX register (not
> memory).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4105
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
>   target/i386/tcg/emit.c.inc | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 473f415766..e2f0b4b1f7 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -352,6 +352,10 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
>           }
>           break;
>       case X86_OP_MMX:
> +        if (!op->has_ea) {
> +            tcg_gen_st16_i32(tcg_constant_i32(0xffff), tcg_env,
> +                             MMX_OFFSET(op->n) + offsetof(floatx80, high));
> +        }
Not ideal to reuse MMX_OFFSET here, even though it happens to work.
Better would be

     offsetof(CPUX86State, fpregs[op->n].d.high);

explicitly referencing the floatx80 type involved.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

