Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBB1C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2kg-00072n-Dp; Sun, 26 Jan 2025 08:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2kZ-00070n-C4
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:32:33 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2kX-0004aU-UW
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:32:31 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so4752375a91.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737898348; x=1738503148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUWt2eNQRdRiGergJ+CJi+bbHTkIz2AqkOY1oiKjqjM=;
 b=ganQdMxERvLNYXAL70k9oZoGvV/pN9EyM9sygLsUWBnN5RJR8ObZiVJfxrAsy3Kv7n
 +FdnYg18xGkqCgXrQrt0CypvPWw/cn2LtIVEMeZ4MrixKF8HwLdrPza1RN7TenzmLHvs
 Vf7SE7CFNraaJH6L/v2N6vPxHZaL1cFVZKS8AwXBBTri5zREN9a+xbiQGKBSUC/FAIuh
 fBC2gOkv5TpXYI95MUWC5FBHsyit9VtuH+hzQpAF0f2jNyzDi9O9vp0nePJi8WxNgg+n
 KbrZpPn3EPcvWzbHIVnBgZHYHhcpY7L5GPGHqZWpszSspsg2GCIq4nyC/aOcT4E156D9
 KqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737898348; x=1738503148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUWt2eNQRdRiGergJ+CJi+bbHTkIz2AqkOY1oiKjqjM=;
 b=IDC/6LEvslLHcfcF2l7gQE5vkVpHs/0OYWCcJmHoQAjJ4uHPaXuQo2vznh7hT4EH3z
 WuVCPSBhGYjjLigrNsKL63yD18Y/HWYZtVMV38QQbrAencxP74ldMXS+37gLMu546v1N
 g3wFADqQzyf4TXuqk4ge1kavY1dNOEQCyao4NG9qZsWe1sgCCBclZsv4XTUAuKKXjLi/
 ItMISZM5ECaRZgbyfPETu+y5TuiqXlUjZAVtZspByHlsfD2b3JaujkrCPHaeqUZyy+fr
 ttearkpiZuIfS4k5Kifkvkfl1ZZ/08HVujZmb5Gqq35S28PcQtCtXYNbLAMaHGMILfsv
 FkCQ==
X-Gm-Message-State: AOJu0YxJuuxa2wtYy1rJz5oVEfVgI9rNJSr8vdT+LxzkWnRnclZNfk1h
 U57nDjHoTY//sixuIs0lg7F3ty6L8ANmZLffud9gXmuLmHpbgSj/l75huwVSgpVhfxYbsykijc2
 t
X-Gm-Gg: ASbGncvcOPd/1I1L/vdX1eCaUqkpY5hAcsnAqPtv14wOiU5BzkphgxJNstPt5lquPqj
 c196LMLaozFHcJ3v7tJoCX7gDnrImlsZS1C1DrtlGlENdctUMsEtjv/eVdrEsPpSXguD0cqMzag
 LvNypKsFubvBqIKnnCKUtE+vm2MIIOxyxFEQ+KGjUztjOF4j4NEKxh4wGt6/bjpLf4rjsP681zI
 XfK3PJ4k1KkSfvXn00rHt1xOuxYqk+ScSO1whH0fb6i/7YrJHSCR7JABunTUVvWwbHpNNC3AAFa
 aH8JuGbY+npL5YuJVji916M=
X-Google-Smtp-Source: AGHT+IEy/+5FKnYtwgohwBBrWUH1/Fysfx+ZBNNy/jxgHAfgT0g11ez6AHfLq5ovriNUf6KtDvf1lA==
X-Received: by 2002:a17:90b:4ece:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2f782c50befmr47621045a91.5.1737898348376; 
 Sun, 26 Jan 2025 05:32:28 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffaf80dfsm5145366a91.33.2025.01.26.05.32.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:32:28 -0800 (PST)
Message-ID: <5ebe9700-a454-4e32-98c7-3a4885f6e9b2@linaro.org>
Date: Sun, 26 Jan 2025 05:32:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 76/76] tests/tcg/x86_64/fma: add test for exact-denormal
 output
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-77-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-77-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Add some fma test cases that check for correct handling of FTZ and
> for the flag that indicates that the input denormal was consumed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/tcg/x86_64/fma.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
> index 46f863005ed..34219614c0a 100644
> --- a/tests/tcg/x86_64/fma.c
> +++ b/tests/tcg/x86_64/fma.c
> @@ -82,6 +82,18 @@ static testdata tests[] = {
>        */
>       { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
>         0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
> +    /*
> +     * normal * 0 + a denormal. With FTZ disabled this gives an exact
> +     * result (equal to the input denormal) that has consumed the denormal.
> +     */
> +    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, false,
> +      0x8008000000000000, 0x2 }, /* Denormal */
> +    /*
> +     * With FTZ enabled, this consumes the denormal, returns zero (because
> +     * flushed) and indicates also Underflow and Precision.
> +     */
> +    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, true,
> +      0x8000000000000000, 0x32 }, /* Precision, Underflow, Denormal */
>   };
>   
>   int main(void)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

