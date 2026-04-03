Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AA4E88D6A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 22:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8mZY-0001dZ-Jz; Fri, 03 Apr 2026 18:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mZH-0001be-Ed
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 18:00:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mZF-0007t4-3G
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 18:00:42 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso1449054a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775253639; x=1775858439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E5Tk5h0DBxV7WnAoGiV9hDcqtMbqZOUY9apv3ctT524=;
 b=HfpED/ckhWHBjHC5qaQuo8/H7+O51CPQFSraXLs6zysi5xNZxTBwpct6oG7q7KZyxk
 lg3sjaG3EPkfb06DRpTC9AA1djpbvTKw0HOAMlvmPzLT5FkDp/NdT83XTEC4ceZD8o9h
 OJhOQnUJHchQ8ZVeD/umVBgsn1CEjQHBcoCk10HpruTgT5HjpsVymtap1JfGLb0AHptl
 3ojs26AEdJ3E5GWhhQUMp0zIVMzstIFNBi9uF2MJW/DN/CYzy4fF35ouYFxnlsaG6d5A
 4xSCid4Wc9rr67BheBAPkUHb/QImqz4Mb9YWcli1eSwSYSrky9lMbhrd4TRrG8jbYUGI
 YBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775253639; x=1775858439;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5Tk5h0DBxV7WnAoGiV9hDcqtMbqZOUY9apv3ctT524=;
 b=Ove21/J/ijXix+SawSVpYSbLjfYIy3qT/nrr2kFf1p9hByryRI7nWbnm6kUZz5oaqW
 +q057vpUh92QvPPtFLrl2yZvOXpb/8RmCJ0KW01syBTlVD1hRye6O2n7B/M/9TWSPB8S
 UNSsUnFO5iIr5JppV6vVhwinZ0qsynrFcSmQiOYJ43zCfgOAhDWXu5q7s2v6gO+mhmbz
 VuHo9ZrEBXYPr6XlXpHLXmlW/14oZ+HTLwFupRpZR4u3F9nhfiobjiDyLQucdayZPOQA
 rQMn4Osw1omyhB5qOh0MZ+mmsYOw0KhkpUKpoATAGqhTlkoM0VWTobD1BrOkEXUag+SF
 BUdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsOsX0n0bTa+LxIKO+12bR9gTLwU6U5bAFg6JCoHSEyauvyJN7Pzwp3v6WSIRSgj0mgLQ9OlqhIQ1w@nongnu.org
X-Gm-Message-State: AOJu0YxpTqgqlKBVCG8FJpT+cRKgjuNvDVLs+rVmBYihbJCRoNhFN8os
 WNKOFSD9LjZiU+zYZtCzGt02OM1ewLDs4jpjvCARkbe12r47SB0KLDGq0zf/KMx9EeDapbnZVfH
 UfWMT33M=
X-Gm-Gg: ATEYQzzLsernHbcfGRix3KaMKhtyVvPxBCqbv1v09ekgS7M3HWaURmRVhQL1kseUfJd
 Hkh1WU0KAfq/oLKuI0h3ntC9x8Ml0hxlmKexyavWRYJCunJbe58vkw40d5xbjQHjMr4lwzDEmy6
 ImAbLuCLlJSqbjJpIeNs8RDYfbd+V2OEpM+zQiQeNwSlNo/7BI5+8gNrYGs3G/NhnKFcI9vxsIp
 7oUsRguWU/n4vNHwfSo1ZsnFeK1y+QXiU1XYQxWkL6C8mPtIig1Qs63tJ5pPjdPAIJLlUjAlCLb
 jk1cMIrrQBIxFH/o2VWgXdgJ4IVm5GwYVNmAQZyFM01BNEywejtYnoX7jKnwIWBpDwpisZDmnXY
 jqWOs1d8aLldak2OFpPwdnE502tB6FGEllPdYfTUozxhT7YN8x78UAwblloUQvaNAuEI6B5kDi1
 JnVktYYNkqtwrC5fBfGJmnLn0Exts2kla13g4aOJL54Hi0oOw16MWWRg4Ohj9yshJc9/8=
X-Received: by 2002:a05:6a21:338e:b0:398:6e6b:da1f with SMTP id
 adf61e73a8af0-39f2ef20a2bmr4206898637.25.1775253639071; 
 Fri, 03 Apr 2026 15:00:39 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm5896428a12.3.2026.04.03.15.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 15:00:38 -0700 (PDT)
Message-ID: <c52cda8d-4f38-4f2f-9b6e-8c8aa319c5bd@linaro.org>
Date: Sat, 4 Apr 2026 08:00:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Replace aarch64 TCG instruction formats with more
 meaningful names
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260402-aarch64-tcg-instruction-format-rename2-v1-0-0998a08a515c@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260402-aarch64-tcg-instruction-format-rename2-v1-0-0998a08a515c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/3/26 00:20, Jim MacArthur wrote:
> tcg/aarch64/tcg-target.c.inc contains a lot of numbered instruction formats
> called "I3XXX" in the enum AArch64Insn, named for the original section in the
> Arm documentation which described those formats.
> 
> This patch aims to give them more meaningful names, for example, I3314 becomes
> Ildstpair. Where possible, these names match those used in
> target/arm/tcg/a64.decode.
> 
> Changes since the RFC version:
> * bitfield_32, logic_imm_32, movw_32 have had the _32 suffix removed since they
>    also apply to 64 bit versions here.
> * The I3310 mask is now ldst_imm_to_reg; the previous 'to_sign_extend' name was
>    wrong.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I'll queue this to tcg-next for 11.1.

r~

