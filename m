Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A06C83030
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 20:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsSL-0002N8-Ff; Mon, 07 Jul 2025 16:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYs5i-0004TY-CD
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:05:30 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYs5g-0002AD-N3
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:05:30 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6fae04a3795so41073866d6.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751918727; x=1752523527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V1ULYTnO6DI+Jszyr+Qm0HLYEZk+Z43fqt8vngf2BLg=;
 b=ylKh9ocKjq875I32lUGr5gxB9rFAdJ2dGUOZjXYBnQqTayhsiJA8nMlUaJZCypVIiy
 tdFWSgDiN+mZUQOtT+H8/ZwqqpP4KOGfyrPWG5zK9g+4MwGISL76FymgSFKL3LTcD1uj
 XUWlHuuzR22rFJ890IvhP0YV8dcaY3JOOHT964+HGI9oybai4opEIsI/ZK5bIOQqvr/M
 Ie2/bSVWrd46jokP28SloisJNdkqzB00L2wx924h8vk0hkKdPGCO7FNbbFg/11QK6DYZ
 PCn6aXZRg33X7SWCK86k49Iy4xgoDul5j8wvfJKd8nZMpOIXM3NrJ10Fn/0PcHqgFCH5
 9Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918727; x=1752523527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V1ULYTnO6DI+Jszyr+Qm0HLYEZk+Z43fqt8vngf2BLg=;
 b=WS9Ff45b0EutwFIjHWrUpwJTXx+Ql9QwO4D0iBRYzlP1YjgP3rFlM+yKQqfPqeAnSP
 4wjLMfBjvwHRf//IUcAFu+evoUjG5zMUFmfIQzhy0zunzo19DYfyrmn1onF76qJP7h2B
 QTonpWWVn9fUS52hRXkgGUByFCjg9x46aIjo2p0tjTsi6SXrkZj/V3+i9H7flLgYmlrA
 6Pr2A+ZiWbvXoWshvHXhK79+Kw8m5uwNtGuhdS+NQnoN271bEzhZ9YJqUosCXIQ2wCGQ
 gXZElgIRMvZjMi/ctlr0ycniPxDshkUOdNvL8CCLYELgLk0ePUtb6O3XjHnZxperHrsS
 eagQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuZwodNGqts1+2Y0oszHLqRoPMOe8RvPjDud0TKcMV+8bkvE39vBRXn79eUfOmZyTIDWVpi4OFfwVc@nongnu.org
X-Gm-Message-State: AOJu0YwQX+ccu/yaKlHm7qYX36e2M8g7DRgBcmMexTDTFZrqHA2cZEJB
 AXWxMIy+wFdJp2Q7j5QJehDvaaLC9xOOpLRuKdyVFzdJUm2w18mpMtWmg7P5pyPyuJs=
X-Gm-Gg: ASbGnctakz6L+C59Bkc29/ZY0R7FkSDAlhkqnmbsy6RX20JnkMsHbvkdFRqAcACbKW3
 NBscStjBWT+SRn6kYHM0qA55xoYks8lR/SJCIqxqEpOo7XjjFWRyqycoqjaEm2Ki7nUGan+AqSU
 DKXnjy07ZDMQ14X336tPHIhGMAKtLW58zjSgBny1HKpLLduEnZFLwUXP41yhYF9Y23MgjMxaAVl
 xiL/TeA5y/T2V1/gBvcan15oHVhQJi+biyS76/t9Jj9i6k0UrLh4U/XLYim62e3DWiAJO6kFGFg
 9yvZ/LUQOF8AHkVZft8tWAb5Sk6w/TLPPY3BqKCFkj8wkWExyNDRraQdXeonGzlB1B7sAznmkyl
 NgTc4J0Dxs3LgQ9ufeTNrBxoeSSwkHwjXfr+NDw==
X-Google-Smtp-Source: AGHT+IG5iz8u4zSUWQL9dnJOcIP64xIi+67sKzgql5nFwziZCA4NnGRu8vF4PXG34N41Nrf7juy2GQ==
X-Received: by 2002:a05:6214:3107:b0:702:d915:2bf6 with SMTP id
 6a1803df08f44-7047d912155mr3959236d6.7.1751918727117; 
 Mon, 07 Jul 2025 13:05:27 -0700 (PDT)
Received: from [10.225.72.227] ([172.58.142.143])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d50f7esm64295886d6.59.2025.07.07.13.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 13:05:26 -0700 (PDT)
Message-ID: <e059afdc-0df1-4b51-bfe7-1bfe23e9ac8d@linaro.org>
Date: Mon, 7 Jul 2025 14:05:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v6 01/14] target/qmp: Use target_cpu_type()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250707172009.3884-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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

On 7/7/25 11:19, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/arm-qmp-cmds.c             | 3 ++-
>   target/loongarch/loongarch-qmp-cmds.c | 3 ++-
>   target/mips/system/mips-qmp-cmds.c    | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

