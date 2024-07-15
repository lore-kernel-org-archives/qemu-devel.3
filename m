Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B36C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 06:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFIx-0000v3-8L; Mon, 15 Jul 2024 02:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFIq-0000qf-Hs
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:35:17 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFIo-0000qV-Na
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:35:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3680667d831so1329393f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 23:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721025313; x=1721630113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ZM+8MEwDB7RXfXkCuzXW/XmZtNyrPCPggfs/ca6Pg8=;
 b=LBV8WTBXtUGmRnwffyTfhWy1TIizLoJYXQ4x/AVdIxJ2NFlrJ86A9F3xJ/rOv1Fy4H
 V52RHfV+idRC6+3Fq21hzTNp5/tr+W1sxF1Zqu5SGL9WxposASz57QZUrsmU30JrwnxD
 ZGaDCzu2BnqH3tMPC2wia1xXuGBCn5wZzsSSiCl1vE6PkPVu7Cdi+Ai3u5cV5JjbvYPP
 t3vhzgQ1bIc5MUeDnnfBisYMZIy42r09kMaVpzgMCR3EdjYO0/oq6u3omDTZ+k6zLkXB
 EifjQ0wyeK2gzVsv43ZXXFz3PdkmBkNUhrXBZU9Uqw8lkICfbs0yigB5ANqLQg34GzZ2
 t5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721025313; x=1721630113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZM+8MEwDB7RXfXkCuzXW/XmZtNyrPCPggfs/ca6Pg8=;
 b=s8UtOJecqwlVOMx1o28TACPQQpzqi59qTHuSpb2MHmmoclYsvMW82IH4ixaD+mx4Of
 pXODvP9g9alI1gIErdMSCS1vYVzR7drw6YfqJ/Bir7FnxkxB2S35J1Tx8YA+Nmq+FMdI
 Ct+oTfCiKjLDd9zLANYbEPWPgvSmb6p0Zl9NmsVSEKh5fa8CtvU5xprdwSEiC70AiEnT
 DKB3d5q1P3OT+rwZB9ZBhQpYL9uEss42vWPRHrzlDQ8OtOACqDAF9bS6J2ivoBPAv6TO
 BsUlzBNgcF37eHdL6v+XLSAmxZcPGSGsyHYMRwin3u0+icuq1w9Ltx5noUB3WkjIf/TX
 8tyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU52oIQUH2K0Vie1g9D2UWaOSxgAwNzPeOTGONOBb89k0X8VjVgooKoAEAyVerebhEiIba/dT7+BQFCD2y6lHU74xqY2ik=
X-Gm-Message-State: AOJu0YzGJ9u+h5XYjPzkFcP2zd5AUU2LwPujvhZM0WlwckQuDDejKea5
 h1ZEAMyYmgm+HukEDPkzG5Cl/A52JPWMAMDgowd4SMe3YieinAuPaHT978vicdg=
X-Google-Smtp-Source: AGHT+IHC6wRf7/bYcJHxFp6Vlvct5v9uMTBEZFH8gEK2Pdi9udAlTnjsCpDQZ/oNsKeyqunrh6y5WA==
X-Received: by 2002:a5d:4523:0:b0:368:75:26fe with SMTP id
 ffacd0b85a97d-368007527d8mr4950123f8f.32.1721025312721; 
 Sun, 14 Jul 2024 23:35:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb07sm5376464f8f.86.2024.07.14.23.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:35:12 -0700 (PDT)
Message-ID: <e70f5115-20a7-47e5-92cf-ab1ff5e7de46@linaro.org>
Date: Mon, 15 Jul 2024 08:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Use float_status copy in sme_fmopa_s
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: danikhan632@git.sr.ht, qemu-arm@nongnu.org,
 Daniyal Khan <danikhan632@gmail.com>, qemu-stable@nongnu.org
References: <20240715055820.319035-1-richard.henderson@linaro.org>
 <20240715055820.319035-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715055820.319035-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 15/7/24 07:58, Richard Henderson wrote:
> From: Daniyal Khan <danikhan632@gmail.com>
> 
> We made a copy above because the fp exception flags
> are not propagated back to the FPST register, but
> then failed to use the copy.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 558e956c719 ("target/arm: Implement FMOPA, FMOPS (non-widening)")
> Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
> [rth: Split from a larger patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/sme_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


