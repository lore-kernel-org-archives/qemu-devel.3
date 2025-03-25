Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1A1C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx5Tc-0000Hx-Ra; Tue, 25 Mar 2025 10:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx5Ta-0000HT-2I
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:41:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx5TX-0003aN-Gw
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:41:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso56706675e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742913713; x=1743518513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WcCyOT7br7y+X4G4ReQAs8pa8HTxerPJQsiJvzhIgR0=;
 b=lkI3/ejmE+r7dOcso9gKYQJh/kg3RNJHreqj2c+88VmVKKnAzdCTvs/fQ14PtfJMfi
 K4IbQe00J8jy1tnPn2ViqrgdJ+vuswjAAw9sc5TeAMjxLKvCo2THdhQiVpksiwZXKhPj
 MRJMjqSneuSW96nhLUg1NELPp6vGimkhXglYs/uzMA22Kaj6M+7XKL04ejqQLgrKenrM
 1u3lCIrLn3EiHEuzFSUTjlHYRRpcdhYssStReHR0pkHa9YePES1KzzH1fe5is6rthLAr
 YRBmBE5QmgGHaG347zu2UIQ2elq9K8UB0sWvpOJxOof4fidf/oDfh/QHIVesJJpTo07s
 v0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742913713; x=1743518513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WcCyOT7br7y+X4G4ReQAs8pa8HTxerPJQsiJvzhIgR0=;
 b=JNtLwsxxu4Rtb3jCI5CsyTkyXqdpAIQiUzPNAbrbB1WDUadnbzWbregPSAZxp+zag/
 4OORFylj81FMtyfQJZmoVJlWGYsr+oRLKlT8+Qwu1vzXwCBvsl36kDtIbpzSYjw5ycZg
 EH33VB9l00Zv89KfZZTuJXmnajUXtChYgOjsYWRW4Sg69NQpM3vo5uNOX9655LCnBEr6
 xZ5lCdWEb4tPWH5MOILTNDGhfvbDOIeOYTG3Kn+/CW9PJcnnPVepWSXs7WURmRXplkHN
 daE2WuAbn0KiY/L0sFyBDZv9R52A5nQJO+yga/in1yClbKSjrQBI+KGc73LG1P/CEWGQ
 7bQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyojjHAqRCPkEaq1L55N1/InPdlgrQzbJ5fDApDT3uzJGTUu/ODLfL2OrmPgNGe6BWk4VtBpORGbw3@nongnu.org
X-Gm-Message-State: AOJu0YxtAnNyRENffeFoqafHtV/Z/siak7B9kZnuXz0VwWk75nEYlGfm
 9CEs2Uot0rg6njeme5ftvl7C5iAfXKDoSKV76WAE88StMUHbv8ayoLhWQV0uZyQ=
X-Gm-Gg: ASbGncvxQO+7WJLNmvsUDRv+bVbFWb/C9ruF5iVx4cK4gKIxLlWVL+NXvtzquvahW2F
 X9IkH1FSguKzVyFdKZc7VJPMcbzvPOeyZoqIJKrsZY/Rsv0hqi1KFYhlOQWGv22Yg1D9JGeUAJ9
 KBFlRJmKaE1UZgygDNkn03wXIZa9NKFDXAwtEfG5UNQQJujoKlcui51ypd4Z0xlwcWnInkHX3ua
 43RLUUnU/W3e9Q0Q+PLnL6zJMXwtVw/N0xOWVhnl00QzTes06tmsuc9WZ5cyXUrRT876qj12Rv6
 CRhbYVqaNeDk4494UTtgmfSdqwNzqt4I5hObsYHrZCFQGXRjo4HDu8tYRQYs3cqFPYqUr0sWrSD
 CYNsoZdmflFiA
X-Google-Smtp-Source: AGHT+IHAuIbOb84KAgE+aFZAWmyRB60FCSGywpsqTxptGE+ZQeX+3maIQctfizzIcfWryXcWqThLnQ==
X-Received: by 2002:a05:600c:1d9f:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43d50a201a9mr167082735e9.20.1742913713396; 
 Tue, 25 Mar 2025 07:41:53 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd185c5sm152463005e9.15.2025.03.25.07.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:41:52 -0700 (PDT)
Message-ID: <417bccf1-01b8-462f-96e5-94b0dbb64807@linaro.org>
Date: Tue, 25 Mar 2025 15:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/4] target/sparc: Restrict SPARC64 specific
 features
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250325123927.74939-1-philmd@linaro.org>
 <20250325123927.74939-3-philmd@linaro.org>
 <3776d8fe-f94c-41f2-baba-81c76655703e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3776d8fe-f94c-41f2-baba-81c76655703e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/3/25 15:07, Richard Henderson wrote:
> On 3/25/25 05:39, Philippe Mathieu-Daudé wrote:
>> @@ -2750,12 +2752,16 @@ static bool trans_SETHI(DisasContext *dc, 
>> arg_SETHI *a)
>>   static bool do_tcc(DisasContext *dc, int cond, int cc,
>>                      int rs1, bool imm, int rs2_or_imm)
>>   {
>> -    int mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
>> -                ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
>> +    int mask = 0;
>>       DisasCompare cmp;
>>       TCGLabel *lab;
>>       TCGv_i32 trap;
>> +#ifdef TARGET_SPARC64
>> +    mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc))
>> +           ? UA2005_HTRAP_MASK : V8_TRAP_MASK;
>> +#endif
> 
> This is wrong.  The conversion could have been
> 
>    int mask = V8_TRAP_MASK;
> #ifdef
>    if (HYPV && super) {
>      mask = UA2005_HTRAP_MASK;
>    }
> #endif

Oh indeed. I guess I got confused by the parenthesis.

> but that's an excellent reason not to have the ifdef at all.
> 
> If you want to hide the features from sparc32, so they don't show up on 
> the command-line, fine.  But I think you want to introduce
> 
> #define CPU_FEATURE_HYPV 0
> 
> etc for sparc32 to automatically fail such tests as these without 
> further modification.

Hmm maybe not a big win after all since you said sparc32 and sparc64
will likely be considered as distinct architectures (in terms of QEMU
target implementations).

