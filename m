Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D06CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWpo-00082q-2S; Fri, 02 Oct 2026 02:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCWpm-00082T-52
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:33:30 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCWpk-00059E-6a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:33:29 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so1732627f8f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790922806; x=1791527606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r5dHPYrPwBE79JqkZWJ8w4Ckh8geBH8x23nWjycDfyc=;
 b=h4y6ooaOboj0MQVvjMsuPmXmTtcpNy1mYYpvIhSXmB4l541Z3hnUdOfGATyZH+kMnj
 FMgqHrTBWNTA8aU0XnhMYdDuI8h+0bINBlA5+8ojXo2A9+5icpIUu4mmgidwIeIJ757i
 5/PaDSf5tWnAOEghHRiSUI01DaLn49tOz4DWNnoXWC+j7PJ0Pw/aqkBGPZxBttBcIUr4
 iuodixt14JZGmk2wLUsPD3+p/Nu4gDQLy5ykNrTTFZKUp5rzY54AQFxBhsBbEjetbWYl
 xrWxZ0HC0Z/XtvIt6xWPgp1TCrIiUFDu7Ju64/mUS+T+Y8vBrhje866O3YFE7vY1XK+1
 /foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790922806; x=1791527606;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r5dHPYrPwBE79JqkZWJ8w4Ckh8geBH8x23nWjycDfyc=;
 b=WilPEOoF4Yu25ToSL36VrS1BJGPeD6C+P6J/ruOlZ4fF3k3ywL7o/nWM2t/Bq42dAs
 1xuUXoSVhoDFnUREBmclUBTeXvK0lZZcZLVhw+lFpkwcQ47YVBPrSG6qX2LRDpdze6CK
 ng5IQK/KXyjl9bL4k7KfZJ4JYpfdPJIA4qbkKnsGwABScW6WNLxGuzcmx7dhD1ZY+GwM
 qOUNTe1vcoZCAYd6ADwjuSMqsK2iLiGugGbeknGLZUBvcCXNSllAdXQc3Hfm8o6928bu
 WKX79B67ZfyCTUHiDr48+npsuDnWDg2xklzv2BpMIF3qESVaru6XR/NQPIiVbD3AyAzo
 CrCg==
X-Gm-Message-State: AFuF++lz94vRekspIdRMEFmRE0Tc/NvUgIjqIblkEIcMgN6K2/Pt62c7
 hTdl6jA18xh8JCgscAcFUjgHeavM13pRTY3eycubmTYnOkg19XZrbsMUN2disgLIRXc=
X-Gm-Gg: AYBFou2ZK+eBwmi4H/GR6iRZcbzGgmXzp9yvis0NDCN2c6fEuvIdqIIb71imx2tEWWi
 87k9dhC+x7WBorinTeURXZZtZy0FJhuXBhYN5ohhjKE8zMaWnS5AI20Zf3+LSy2zJB4JjjdD/b7
 IqV1C7Px0dkEFxL206iw3gmiMRG1s9wnjepu8RWClanUoiHiVvQzGi9OwfIeF627mk9N1zuCbAW
 xq9bXgfLBgcLTu6LmRRoxveBzdqM2/0iFfea139SXfbcRGT4fULTNYB+VLqDVyXWBUH/xcadtdQ
 L8Itn2vqVD6bm1sJK/AIRuELLFJ4J/RNDk0jJgh07xnqbeLlxDza3VGV4+t1gM7XdKFQ3ff4uSD
 h8fJz3/29rlFpwr78sdXzg3UeSb96st2oGfeJV/pRH8gSJY+933cJphLb4g2r8kGGfISE0iaxYK
 YASEXMHzS5XHygQvqHWQxHJMRcN0dDVUm7p2LWuRMiLOEdkCQbwnmTll9gXQBiwbRg2fFFZHRMm
 JQwVrykNh2xxmQ+ti7V2PfiYD8B+vVcC43P6N9Xyw==
X-Received: by 2002:a05:600c:1546:b0:4a0:1c43:3c04 with SMTP id
 5b1f17b1804b1-4a02756e5edmr30553305e9.13.1790922806519; 
 Thu, 01 Oct 2026 23:33:26 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm3541775f8f.40.2026.10.01.23.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 23:33:26 -0700 (PDT)
Message-ID: <b631b417-e032-487e-99a8-607d7b7fcc56@linaro.org>
Date: Fri, 2 Oct 2026 08:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 015/101] tcg: Generic expansion of tcg_gen_subi_*
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-16-richard.henderson@linaro.org>
 <CAEdQ38HDzHj=RZUqj8TDYSf2FJZFACGT75p2PTZB1iCyw4q0_Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38HDzHj=RZUqj8TDYSf2FJZFACGT75p2PTZB1iCyw4q0_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr2-x0e.google.com
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

On 9/29/26 23:53, Matt Turner wrote:
>> +void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
>> +{
>> +    tcg_gen_addi(type, dst, src1, -src2);
> 
> Double check me on this, but since src2's type changed from int32_t to
> int64_t, I think this will produce a value that isn't sign-extended
> for I32.
> 
> E.g. for I32 with src2 == INT32_MIN this now produces 0x80000000
> rather than the 0xffffffff80000000 the old code produced.
> tcg_constant_internal() doesn't canonicalize, so we end up with an I32
> constant that isn't sign-extended, which optimize.c assumes can't
> happen.
Hmm.  I was just about to say that it'll be re-extended when creating 
the TEMP_CONST in tcg_constant_internal, but that turns out not to be 
the case.

I'll fix it there.  Thanks for noticing.


r~

