Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD92AE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl1h-0003qX-Os; Wed, 04 Dec 2024 03:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIl1T-0003lW-LH
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:46:17 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIl1Q-0007Um-UE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:46:15 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa503cced42so948886966b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733301971; x=1733906771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WpKDDl1qaZvj6mo/KodYZv8nziE2WfA+UfGelVOv52s=;
 b=kVJ2ObyXBVs3fhD5pTvL6ZkCtOeuZcO0pF/+JpHXPZrRbdozVahNlStsnsMIzuiYe6
 WMfKsmhYwlHxAjqFN13QEGOd/T9F0osiGQmS5mJ4UngZ5IJSJnAA3hq84iqPN6ZbIeY+
 pLZVuurQvuw1EO/NsfPHQZio02JuV2qdZ6OHTCqNKpZkAG3UlHCxUQYnl0PLdbKN8JUU
 upj9ovW5Kk7D8cOiSgvQ7f+J/l0ry3n++8aGSkOWP4eyh77mcsG6R5auJ2yBH7JzXdvF
 j6a08B9/+Di9rhKKgyOwrf8FzN4Ybciw8qiHli4D2V0qrRyVtWbRBgbCwO3M/RO5tmbZ
 VKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733301971; x=1733906771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WpKDDl1qaZvj6mo/KodYZv8nziE2WfA+UfGelVOv52s=;
 b=hY45yeaHZp8fxtatvXuI7BknkAOEnMRz9MOsX1i4/POj1f1mPjVouuAIhHCXs3rWvY
 MjsoCfWx2i2+zA4qy4Jue7pHsz2t7VaNazbmzvKUz5VAVO5vC6ylo+3nV0yjs0gtB374
 ATCuSBRaB7I9FURx2HlPLzpy0C/O18IkXOZh2G2eUX8pkoPPLeZUbO4CdzFrQsC+kqjl
 LGpJN2400UzyL9af+IEMHGIhsFjWecRkq/v/rnBlYcx6kxYkFbTWbt94LExj5L4Q4J8H
 7K2Ts7n2C4MEAouTlDZdL7yAJhDKx9zNMOPtTbatd0r5KMMz9jVEj8SvujSvqG2xBykm
 UgXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyToBZxpuLwjSFbFMZwoG/wLuPqhBZTsNpxacLlHzKwBI3/HvGurM4+aGX+u5weQLIC0dqEz1sYsSp@nongnu.org
X-Gm-Message-State: AOJu0Yy6R0sd55QTtn44OXl6jaCc0u6Ge1enAFu1xG0zpIdvZX39oIjf
 0zzVf8sOWhyPjQVWkTpk7uAjjR6NziDv45R1Lt79+s5sWhNsjw4EXMiU26uUaQ0=
X-Gm-Gg: ASbGncvxL93dSrMdXmc3MrsEUpbxiDH36QxE+rfz8OcYoBSEVG01gezV9BZBSvD8FKV
 l2wzYUyS30tsHU5oeoFgEykafsdOrB68MZDFtdWcEMgWypKtccGOteIPJSTOZy7U4MWQK468yyO
 CmX/WVyHd22XFOSw9fMZAHvUlDVQaLcdBHBQhPH5CCayHXxNJ42H3gZY4S8atBdxsbHRDe2Q2T9
 ZmcYUsA/QokvppW4/btLK3Gg2Ism7laPIodswoUDGGxWMONVf8ttL0qP5ev2s1ti00aDgmGWdbN
 prLktZWz7ilCXdYlBGgK9pCudQvfIZ5wk/vi
X-Google-Smtp-Source: AGHT+IHnwoCPgWRjT/bGzID6islUjf0zyYgIQI50BjO5i8gBoNoNKVSTouHPWSTit+8/8EFcYYGqQA==
X-Received: by 2002:a17:906:3110:b0:aa5:49f0:1510 with SMTP id
 a640c23a62f3a-aa5f7d03e3bmr358539666b.8.1733301971013; 
 Wed, 04 Dec 2024 00:46:11 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5999032c1sm703460966b.133.2024.12.04.00.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 00:46:10 -0800 (PST)
Message-ID: <234a2450-620b-4a78-8035-ab658cdae471@linaro.org>
Date: Wed, 4 Dec 2024 09:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Cover the tests/functional/test_sh4eb_r2d.py
 file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-trivial@nongnu.org
References: <20241204071120.663446-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241204071120.663446-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 4/12/24 08:11, Thomas Huth wrote:
> This file should belong to the R2D machine in the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


