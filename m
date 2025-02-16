Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6231C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 18:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjjdY-0004C5-1k; Sun, 16 Feb 2025 13:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjjdW-0004Bc-Eg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 13:45:02 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjjdU-0008QW-N6
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 13:45:02 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4395f81db4dso21426575e9.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739731498; x=1740336298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qcnIFrOxZaP/eIZdkFb3O6hln+uhL7G3fm3F7+b+k5s=;
 b=c3iYSo/R1SKRXSyZwd7G3SfQw0X1sdhdf7H7N199ekM1QGz1ZIje8oqtijuuYP6ShR
 1p2RYydTpTqzty6oL2crfidP7MZU7ThusndRuWFffbH25EVZxY8lJJgc/TXjpK7Ke1i+
 /fXbdoyFP3Htv0GJBphi+vTfI0HfYvkmO8cn0vrYmC0GAOCmPuUsXeoHykPSvLDWDJrg
 epmK35tqLmc4UeiuNjxQrcyk9L1GTJkRGmZvi5pnw0C1oyjFK+l5Q9pIhcEu8G7yhmmq
 5THAby0CEsYioJzoP+uAV8n5eHb6VdphoRAkQd3ebclWkPeyCdYOLXL4NYxN4x03NFuk
 ZkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739731498; x=1740336298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcnIFrOxZaP/eIZdkFb3O6hln+uhL7G3fm3F7+b+k5s=;
 b=j0cX3pl4ed84pWoEUkyC1s3bjeAlmDnkTIB9eCnr8P5lZh4vDi0NlDoVN0xMlBwBV0
 Do737G66mQS+pheFaZRImOKBnf+v1TggkGlCeDEpPUY1ZvepImUB/euffrc/hCuOkx4y
 ytxgNhwt1XvFqtIIn6l2HhJcRiZ9r3RKDVfpcQEQ1uE0K/pYVqHk3ak4LE7gDNQwgPfD
 P83ICkjq3VYnmdfI6cKTvo9es4Y2OCn705Xyz9udBHPyLCxJgl+zz+dZxejOnoGDeG2t
 a03bZEAwOVV9mM+oNKIvV/xNDBBdq3n2OA0clz4hfyhD87aZBQ1xpJ72KOugz4aWo4Fl
 JD8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+xGBs+AfeLLOSiSEZq/VsOaFmhQc/nfOpx2B+iOf59hKuJenwQQZ8myXTxUyqIv6EIZGVaiex8jV6@nongnu.org
X-Gm-Message-State: AOJu0Yy7AZpYBRagQVTSjjvE/fz6rBOZWHxWs/ZWVs8MavrL2Nr4YpaX
 34mSfd2U2pGOqtOMr4/HWXz1Ab5sRGtfUjl7ep2IQxhMG+LavqTrIRCzvNOJdkU=
X-Gm-Gg: ASbGncsYVrU+SQMLmvQrimeNkdOyXYiEDMrYlooehHhPrknQf6rl3eROfdVlzSCkkNF
 88u4/m8fBYKW2KQQfIbYHr2jgXDDqVnlyHQofuFpIM2uduGsTm1Zz0uvhThN+nvzwHRUi4/E4fR
 zPp52F18rif0PHDN6T+Tx1RmqC7C/vT7g7w4gMk6VI+o0gd45okefVt/EVVv2r2jjnmWG29yXvZ
 Zf/KnXEXrUWNt/7KOuMRIF7SomHb7LLrmFnvGKbm8dQE8JLXrzIDm5U1l0C+yz9US9Dns0Aq7TC
 u1wP49uaKTzAV7CMoz5N8S59jhfBCO74ynu9fzPv+52jPszMI7v5yLAH8hE=
X-Google-Smtp-Source: AGHT+IFgWMFN9imhMTn6E0ahoqgQFDeVGmt591o9c98vHRHW9sS9uw0ykyZ+g5bHwfmRzHP7NA+5yw==
X-Received: by 2002:a05:600c:314c:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-4396ec29183mr56169215e9.6.1739731498191; 
 Sun, 16 Feb 2025 10:44:58 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a06d20bsm132410865e9.20.2025.02.16.10.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 10:44:56 -0800 (PST)
Message-ID: <81cb5917-802f-4d76-967e-d357f87f08a0@linaro.org>
Date: Sun, 16 Feb 2025 19:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/i386: Use tcg_{high, unsigned}_cond in
 tcg_out_brcond2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216024709.2624325-1-richard.henderson@linaro.org>
 <20250216024709.2624325-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216024709.2624325-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 16/2/25 03:47, Richard Henderson wrote:
> Eliminate code repetition by using the appropriate helpers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 65 +++++----------------------------------
>   1 file changed, 8 insertions(+), 57 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


