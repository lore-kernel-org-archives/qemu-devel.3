Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21D2C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OgJ-0008Sd-TD; Sat, 29 Aug 2026 15:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0OgH-0008NE-Ip
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:25:33 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0OgF-00016S-SR
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:25:33 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-39266382df6so1878193a91.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788031530; x=1788636330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Qya0zUGibGq3pom3Au3RqB7dWfMGCLLi/+sfTrlQx4=;
 b=X6pJtUCIzWiv5Ei0q30SZrGe4d0OQ6gSLzyQuwywQziB1UoWW8GwTWoyfIPVUyJ4RV
 mEEkl10FhE6nE2rXo+gx+tvmjLDk2X7pB1cqssDrxU0UTTlIdhg0mJfPFbKMJwim6Rr6
 fs8Ts67vss1nj/7+jF9j3NKYhWkuR4p519OvcssNcVM/baYvDXWZv8edDFVB7Yck8D+K
 7zqjVX8l10RSxIE0t42pZC7b573coyqfu2rTmBxUGRs4KCZCjme+rmepRrhXzu/m6oDt
 d/Lw0wzS/M/CkrsUD8zpQoS2+lkoX7HSuYOzSoQsKEdEWyzTq/Czqq974cqXJ1FPx92g
 GD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031530; x=1788636330;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Qya0zUGibGq3pom3Au3RqB7dWfMGCLLi/+sfTrlQx4=;
 b=AmCbwUyGyQzvx3tSAr3gzs1NpTOBvaCfuROOLGLv60d94ZisBXeerTWbuY21JzzsbT
 3iSDXlNPjoW2izycseExV64vQ5UkZx6XNGEAbRdlvGCuOAHvvAZjnTLX8qbJnyYUb8UZ
 LrRz9QvAPvualrVkNPjL0jQs24Eg33dvWHHOseQQd7x7TjHhKKzU8JcJXjdp4j4SbQNk
 UGcM9dGuUvQIZx9kjEvgjtpr+dO4AS0wB4MOLIm47rz3BpX4tdQnLUuYfBcaOyH1lYRB
 /C7wnsmnn12aauMtyxnXsI/n9VhVQrVzBLJ1JofUdiH3vgNSZ+C2gqmLMKdVmf90XjY1
 i9SA==
X-Gm-Message-State: AFuF++l3ZZHPq9kBVd1jGd0TlVJBRkBgTEmk+biqzfOTqPtqNlxCyrFu
 zAXP3sYcTa0WKDE9JlKt3b0uTbNrtOTW7U/SRCvhC/yBZAAiKtlwZUkTtUo/q++CPHs=
X-Gm-Gg: AYBFou1mXtPD/0UkcAMJINbQj+VqJAi1QKnRoO8jr3XNv2JXJas3+sxDxx2/aSmq27k
 EhHW6WkTG3vJC/EGw+jS23VMqEQTQTUSKIkqQhe/bLLySmPwRM0Lku/IWB3kWruCFelk9o0IdoB
 okPorkjyreOUwGGOyPvqAQAniKDkSfhyEIfQGNVas8f2KN89td+vzF8yh6jyXbpPyujgyucmadF
 BoRy3kAkTYQ/Mj/yygMAwk1R2KQUNMOjOUsELk+H8IpPmHD5Ts1DnHU5DIanHHkB+5RssLvuU6v
 DmJLPC6Re4SK4MKrFFvihQy8amAS1tXPWqWbQZHfEPkGMaAD1iV5OIKqVAaBjATXX/RDkmSuxYj
 bxgX6qzW+Pp8kVBWdabHJxwU2RyAKovH9BQYfMCGk8uGO6iq5leP1ipvM32jk8xAMbz9MTpFSLD
 r9JC6GjzvdAGgzjlnInL34/OOCOxDY96VO1GXhxxWapKoMsBeqW2epta3+sg5F6x5w93fNLHozw
 DEuXwRyAeooL4JUHI3chPxcGuRBpx0=
X-Received: by 2002:a17:90a:4ca6:b0:398:c16e:69d3 with SMTP id
 98e67ed59e1d1-398c16e6a51mr2264512a91.1.1788031530141; 
 Sat, 29 Aug 2026 12:25:30 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396ddc08266sm8046708a91.11.2026.08.29.12.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2026 12:25:29 -0700 (PDT)
Message-ID: <9ab65a48-75f2-4abc-b4c1-f07230780945@linaro.org>
Date: Sat, 29 Aug 2026 12:25:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] tcg/riscv64: Implement INDEX_op_lea
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-16-richard.henderson@linaro.org>
 <CAEdQ38F2QrafQtxrxLCKav8PiDBtkvEotR8r7R3BMC+fJNRczA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38F2QrafQtxrxLCKav8PiDBtkvEotR8r7R3BMC+fJNRczA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 8/29/26 12:05, Matt Turner wrote:
>> +static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
>> +                     TCGReg a2, unsigned sh, tcg_target_long imm)
>> +{
>> +    tcg_out32(s, encode_r(OPC_SHxADD, a0, a2, a1) | (sh << 13));
>> +}
>> +
>> +static TCGConstraintSetIndex cset_zba_rrr(TCGType type, unsigned flags)
>> +{
> 
> Assert type == TCG_TYPE_REG to mirror the macro?

We already have

> +            tcg_debug_assert(TCG_TARGET_lea_sh_valid(type, sh));

in the caller.


r~

