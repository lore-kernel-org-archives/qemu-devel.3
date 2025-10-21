Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F353CCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIX9-0005Yy-3j; Tue, 21 Oct 2025 16:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIX7-0005Yk-Bw
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:00:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIX4-0000Ou-Gg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:00:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4710ff3ae81so22376895e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076832; x=1761681632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iDJCpBi5LhPRhogX48q7arQaOvoVP3BKJdF6FUPLKyo=;
 b=PWH2Uzqg6epyQs89dnBGkzCo3kqjXk3rnq3iItyNi9dwOM44ZSpVhD6b4aamXm2OQc
 PouhQpSCsL5yuUNgP+p0/h9ZxhL1qwOFf/Dmtm2x9qOuhyYZEnD69iEg+MnsIP9BWdmS
 4AwZa/YjIPfkoKysU22GtIfdEvyrdBBTbfRZS0KIKGyMcDkMRQXXBjfpsEmfzyyoq253
 Nrw259W2gZIo5uIMZAc83622sgyG7mv9QIk7zwvJ45qkzuUMlydZ5kfcDVIGp6VUqirz
 4oyMvyLB0Iz4k9yFMg6n8t5Gc2I0xBQ1TnuMB9gKmjjicD+XJEoTYs/UNa9RjPjlpLCC
 a/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076832; x=1761681632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iDJCpBi5LhPRhogX48q7arQaOvoVP3BKJdF6FUPLKyo=;
 b=ZS+dGmHlvrSon3RM3DUfZgJHUu3ZSJmwjwbLNYM2uolrGFuBTXHwXPQw1+4Fhlfunp
 RK84G3zmhbUVYb0Z0fyo5WkzFbjUozfylsnvQMYUw0GZN4Dy/xEU0HJRsb5KCNJrLWI5
 yHYbxIaGrHfbvr3baIRis5Xboxm08LKUzw5T8Q4ogvk4MfHM60jDfduAJ8XJKSVFyIpk
 iwbWrg0Z3dGPq4qRFGNDbwZspjZU1uX8dsjRPOjCichMfe9zK3CcA9wzC1BLFWUzij62
 gI4h3yP+J7O1qJLv9WFq4BFoqW5kp/1uVD/Oht8o0f1iTjCqwFu/9BGHnR8O2iA6PdF3
 N6Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHAfvOpECBOckrJSMrzs6gaQn9SdF8Fgvsf9sxhVhcJHbz79Lx8Lq6jC8eO5vt91fSoTz6MzpCxATi@nongnu.org
X-Gm-Message-State: AOJu0Yyc0F4I8Og7KciWGzAT0COwN1rtUzbX7EKIdfdn4d5nby73JN0B
 2FQGoyPe2cJcfwBToAO2EpuMZt56z1edzDJstWKakkNZpBQfeyht8tIu6azxijgPrc8=
X-Gm-Gg: ASbGncvM11cmol3S6ZZ5+G1Iji+BZeUOruD8lmV17+sXwfSfglletBSdopIXMpABKlF
 FHnxyo9hBlQFEeEpjed1vdViK58nSKcTVXgQQaT9Wo6SfiCOYT2unDYPZ1K0pFPGA8Jkb7gyg9w
 yAjmyapl+ewpws/OX22oN5UehctP9t+gJ5xeiay0M4k8TC3sDZDiBJqSaz5fxz+0cmATpwHuA7I
 75/MHpxJoYlBf3JK0K6h0xYFYVAKGud7btMRRd9mtKCTUEb1vWcPkJMJ735/8g+THPbavYvyZks
 0jl9DD2w5qznB4cVji1K/gUiAncliKmaMc2D4abixGC31wnnMblBbCqQ5PrP7G7moZwwFhLFV/K
 afLdl7C7mZJpOBSALA62Cd+igfyH7CU8AM1W6WK+nyY45IFsWkdBK0ZCX4dIfezraOFAooaEmVi
 UXwZbr8lWCyMsqubwN2YntpFw7BpTWVu+tVTeV4AuUA899jDlrQqHdmA==
X-Google-Smtp-Source: AGHT+IHhZQQCfzXiGcpczApJaRHqlfsMTvEmaARVZAsDeeeiIAbP1kJQ+g89m/b/KgjaMrrUgFYx5A==
X-Received: by 2002:a05:600c:34d0:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-471179122aamr140933555e9.25.1761076832400; 
 Tue, 21 Oct 2025 13:00:32 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b4867sm8101305e9.14.2025.10.21.13.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:00:31 -0700 (PDT)
Message-ID: <a7949fa7-e02c-46d8-98b1-776bdfb879bc@linaro.org>
Date: Tue, 21 Oct 2025 22:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/25] target/rx: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <cover.1760884672.git.neither@nut.email>
 <b3333ba5003a4cbe023278e8692168daa5f544c2.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b3333ba5003a4cbe023278e8692168daa5f544c2.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/10/25 17:15, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Renesas Xtreme targets.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/rx/helper.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


