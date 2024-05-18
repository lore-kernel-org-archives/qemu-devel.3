Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1FAC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 10:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Hn5-000819-F8; Sat, 18 May 2024 06:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Hn3-0007zn-Ky
 for qemu-devel@nongnu.org; Sat, 18 May 2024 06:59:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Hn1-0004Os-80
 for qemu-devel@nongnu.org; Sat, 18 May 2024 06:59:48 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5dcb5a0db4so45089566b.2
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716029985; x=1716634785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wUt83CYN1vWHStsg+gai1at12zafYS8+A1OdzttsHVQ=;
 b=GHJC3OCPLCGIaPGs4ndf0ggAeQL5Lqdgtr6/j9D6StIsGuz1i6jDSktwv+mQ7F3E2b
 Luf4Wm1+GzFbAVyt1qpezQheTj1C9RLCkgLuqaX7GUHxluzu1KA33W1CM8noAOmnHe/T
 2JDkeEhCotysg2aHLknIWVwdBmG6gI6D3JV+SnRM1BQrGvf7lgb8yFdVQc92ERB887rX
 LkFM+baY+qVpO6yORKZgOEUgN9/7X8uaEP29IiT07+XjgFa5WsVMXS6jpN4X7CyF245t
 gGgsdtJaxzymMsq2/sjuxu6FmHERm8aT/W7GKCUqQ7l7DSTWSAMftKhDlm/fBmLKblwI
 Lb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716029985; x=1716634785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wUt83CYN1vWHStsg+gai1at12zafYS8+A1OdzttsHVQ=;
 b=iaGRvtb4oN2bWQjGsHuB91hVoVNB0WNQ4DFphYu6kzbBob2oyc2rsgIAvsiN24245x
 peSqGGmfcnsvwUcYUEq6qdwA6aBfoGjynqUb5ZRfyDnTHiyfJ++EECVZ/PKzDQiGNRaY
 +f4auK1x1Ih06k4T4kwqILNNaUxB5mUgKmH6+CvJItSZiPEetoYlBeoDP2bFxOuzrpbO
 MGLKyLfuIZCFMQgRemeYD1jJ0aKsKvRhid+zSdqhe5GOBTiGeL0986WywoRePHfEfROo
 7kbyWlPOiKAyNPQ04LuQ2ZRX0kyVDP96alcVtdQxiHvdPBfzdoYRMzlO8AFhXfssOUOa
 A64Q==
X-Gm-Message-State: AOJu0YyYCRWU3m97B5JIKw9G9kIn8cJxUpH2X7Ey+xTKBqesI8jMQW3z
 H3UZmDS8dWBf9d6v7eAxx+o08qFIfeqlf77iGbCc2k25XhMX83tqiu1WqYZ64I8=
X-Google-Smtp-Source: AGHT+IHL9TcRAifn1RewjZJltg5cO/WKslIV0db2s2L0twuEhzn2UtELedoApJqXanTJUVgxkMTnAQ==
X-Received: by 2002:a17:906:3184:b0:a5a:1579:9033 with SMTP id
 a640c23a62f3a-a5a2d53abacmr1433043366b.1.1716029980355; 
 Sat, 18 May 2024 03:59:40 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5cdeacb2casm360568166b.67.2024.05.18.03.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 03:59:40 -0700 (PDT)
Message-ID: <d85ce685-e3ec-4ab7-8bf9-80272528b521@linaro.org>
Date: Sat, 18 May 2024 12:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/ppc: Remove redundant MEMOP_GET_SIZE macro
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-3-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240518093157.407144-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/18/24 11:31, Nicholas Piggin wrote:
> There is a memop_size() function for this.
> 
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   target/ppc/translate.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

