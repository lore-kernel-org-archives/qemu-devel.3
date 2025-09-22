Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687D4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0f5n-0002RP-Km; Mon, 22 Sep 2025 07:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0f5f-0002QI-Qa
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:52:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0f5a-0006eG-SO
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:52:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46de78b595dso3402685e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758541930; x=1759146730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xzeOzFV6f9ebg2fJBHj6nu9ySkmpD0tvjZMjaRHj4AA=;
 b=u6o+03ylm1kfE6eM8B0/qMdqmeJmnVV4lO/3X4hxEQJsrA7v8oToFLMHV6V0mnKsMS
 /EaxYlyPnTEnsCxgT3Gb5gHRAwZu1yuka1nUYoJcZx6FaYkuDOcvlpTjVa++w8pr1hMI
 5L7ik6mWQpTzPqFshTHpVDga2tGrwbMuccH4JuwKIDeF+lcSgVqtVHIEAHi/GTTeAOxn
 08vElgTYsKRcMDDjsLluIY90tF1aaH+05hTsgAJ1FT+SFbGqDVPvZqe2akXngkWLadCQ
 cLGGcPSgPXFe7le+/venZltrBvOGofU7WtSoefg/AuhrKUDAEPEaDICjV3UmDRUYh2Y/
 aKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758541930; x=1759146730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzeOzFV6f9ebg2fJBHj6nu9ySkmpD0tvjZMjaRHj4AA=;
 b=jkTUB9KmMZ9m0MJA88+e4Jda0UqZCGOMN+HPS9Tn8gISlL7z9LQm2HCkLF0yaQfAEw
 3lTnbEEelIsmcHxSVEW7w5Q4UBh05lg521Zi8nQBlGsjkyvK1QzHqXuXWN+VPztyZihJ
 aMUqGPiyerEl89NORrXYDKmSmkeaFkKBKgr6uMgLOjz7DBknHo4Sjo4j6YsyMfE4bL13
 ApmsW2+AnHQPdown848WwExsubHPav7OT/QUxijrmTe+ORBqDzZjw8RwSTc7ZBC9WY6q
 A/LzLUxMBklyh5qtCT5v4IFcwmjQ/34u9JNV+k27XGGUYKq30ee0u3YQYZw8xTAVYSqa
 ryDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPb0Dz9IlezqDLyelNFf/OOEr2lbiC3x/T+IaNykAUCwK2Ca9/UeLVKmG2Jcdv/M1uhzhY3QpZo7Iz@nongnu.org
X-Gm-Message-State: AOJu0YwgFUMRWWu0RmrAFgEihVZk7aydcOAiGnsnnsER2MTIV1atcETS
 eG36XyJ/2gENv3gJwvblklhAUJK36f+/4+6rK/wgaJN7U3+7BNQEwzW6xcjq0kbVQaI=
X-Gm-Gg: ASbGnctUZXNW31IWLWFhchZT6TeFudNvIKhE5HNl64hRzrXaAVe3L+3Uz4v7jO+rlUh
 DwN/zeCHxOid9NgL+2NGEgStckxzsalaoeBS3TuiEWdMJDESa8/FskY+/ALqh2o8JsudRVm5x6o
 fQwGT9Gel1AwrWauZkTiYcjwotT545Z966NxCcRIBNEh/YeRM+RolrVpPy695hpQ1+j/uc7VAxJ
 ugTpiSFjzuAcfNgwxHVOTSSbGIGIE+T8GLglzn2hf5Z7GsTQvaJyzeGAxNRimP8nbbw1zXJV2RP
 xZe4IiVo4B+ASkJdjMr8AnWjr90sPLSqnbZS37POjb5h4UOFIqTRUZjFVq65khkWaQHVhRqnOfu
 dFKxiQDHQPywutFFB+TzY2BAW88RJ6raYYifC6ZTmWe1sgjehOAGU2h+88hJ7mpDr7w==
X-Google-Smtp-Source: AGHT+IGgw0LqDQ7r1/T6odtz9zB5wIBDnC9BRKdDP32gffJkEcsCuSirEuYsRqGQb7RV+mikDCVgtQ==
X-Received: by 2002:a05:600c:630e:b0:46c:9e81:ad0 with SMTP id
 5b1f17b1804b1-46c9e904ffamr37242405e9.0.1758541929709; 
 Mon, 22 Sep 2025 04:52:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f527d6cdsm226382965e9.12.2025.09.22.04.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:52:09 -0700 (PDT)
Message-ID: <dc5cf3fc-0e1d-41e1-bbfa-a3451eee1741@linaro.org>
Date: Mon, 22 Sep 2025 13:52:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/25] semihosting/arm-compat-semi: eradicate
 sizeof(target_ulong)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
 <20250922093711.2768983-12-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250922093711.2768983-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 22/9/25 11:36, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> No semantic change.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-ID: <20250822150058.18692-9-pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   semihosting/arm-compat-semi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


