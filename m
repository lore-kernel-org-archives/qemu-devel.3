Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88AAC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5M1o-0002W5-W6; Thu, 17 Apr 2025 05:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M1m-0002VT-LP
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:59:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5M1k-0002JI-O6
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:59:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso419427f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744883963; x=1745488763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nOHCFZ/q8018UWwWrmnf5XIZ8fx1Nubz0vTuMFEj+p8=;
 b=vUZVMznVvs4oTyKqCpx3nIrxSMN3qIGH9gzcLyPpX3mHk0o0TXEyc/PLr87WrjFEOd
 sVfE1GXQSZYbGfyKWv2pLc+PmbE4JvjCOWX7C5Y+msP9RtQdNZ0mIqOBG8NaRDpjbNIA
 MxpctKrOfPdJC//JZDGhQDcgFyiIds7zPQ0PdoEuiajfb1NtlBbW+HUPeW9tX6Loe5/+
 s4Uxz5i22wam2c5oajftF5o8zPkc4U87Le3c0dYMrHN0cA/AyEIMmdGI+gBor1iYEApm
 HcQ394klvaX7RPUm3gCG9o7b9QJK1a4sJ+s2JuHmu0YA4THhNtcod1iJzNf+hTTHToP4
 FnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883963; x=1745488763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOHCFZ/q8018UWwWrmnf5XIZ8fx1Nubz0vTuMFEj+p8=;
 b=HKdDYESOyLDrVeVSkRwkd8jYC1SFpvNa8yQ8G4RfK8atJ548iCcxSAvV40+MerbLw3
 ANZsOHbeKxZgR3ZfdW34oDa89a58vZD1DiuAEFVp1h704vQtLoAyUm065Rbu3rCTEqQw
 pTUfIbCL7oma3o9N2Rd3vOKt2wj1A2akEOPbUlnll65Wat7bQNPToBxQhSoENeQWoADN
 IzXLL+AYlmnLEPJ+HMGukhgavfXvYl92Y6/iRDoiHsCAOiJ6sl1ziFC5e2e5jksZ3JMW
 SkntccNY3BcDnF18E70JNPS8R9Wo4J4zvTrje8nXL9XPzjS/vdThwsuuovg//ZaiLYkm
 pseA==
X-Gm-Message-State: AOJu0YzK34Xox6fxSghj2oh038lTO9EjnmAX2sHsIo3cee/J1ruxndHc
 2e3jo34l4/TpbeXya/0k75CPNgnD7hNhfgyFxwzGFo1IqQmdpdFURPiwA3/lKAw=
X-Gm-Gg: ASbGncvTpd2kvmT0Y6xEOaUQCsiKmDZDCi+eNy+lR0LzaMsqBf2Xiabjxsk2Fjarh/I
 t3o6/5Xl60S/6f8q/jQXINEA09LkD9tCfHOExmWDIewHhRAqbQOxSoSWmZAM+6dK7N5EM23fiBY
 rBKA05EthX4W2/91KloPClKw3KwUiwrSSHLmVVMWzMnnWCb3H6rJon64Mi+Br8ebO39kO/TXeYn
 RwOCqXA0j6P+YthNhvmo1Ny4+sHVo/CEudStKG0hL7KEQuzkj/UmFOrhYBtpp79PujirAJTeucH
 nJXGxuuGKzlI1wuQctjliDevmhGnSqQnFc6N+IOB7aKbrdqAJOJ+L4shIaOOCdVVsKAQuZvWse4
 8FeEks2w7
X-Google-Smtp-Source: AGHT+IFGFHy+jUq6o32BZfKF/Q1cLMrPtl0aS0mHJROjJxQf1F3tnlnJ6ohk+wXICf8f+kUB/p/pKg==
X-Received: by 2002:a5d:64ae:0:b0:39e:e588:6725 with SMTP id
 ffacd0b85a97d-39ee5b1312emr5018214f8f.2.1744883962834; 
 Thu, 17 Apr 2025 02:59:22 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9777a0sm19579713f8f.43.2025.04.17.02.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:59:22 -0700 (PDT)
Message-ID: <53db2d29-fe14-4c39-b13e-a0557dec4ae6@linaro.org>
Date: Thu, 17 Apr 2025 11:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] target/loongarch: Set function
 loongarch_map_address() with common code
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250417035143.268248-1-maobibo@loongson.cn>
 <20250417035143.268248-6-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250417035143.268248-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 17/4/25 05:51, Bibo Mao wrote:
> Function loongarch_map_address is to get physical address from virtual
> address, it is used by qmp commands to dump memory from virtual
> address.
> 
> It is used by kvm mode also, here move function loongarch_map_address()
> out of macro CONFIG_TCG. And it is common code, the similar with
> function loongarch_page_table_walker().
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c | 10 ----------
>   1 file changed, 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


