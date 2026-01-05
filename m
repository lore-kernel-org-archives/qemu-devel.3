Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D48EC2A075
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 05:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vccus-0001l1-5J; Mon, 05 Jan 2026 00:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccuC-0001hD-AN
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 00:13:24 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vccuA-0003FB-GN
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 00:13:24 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a1022dda33so108529525ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 21:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767590000; x=1768194800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqH+x/N/XKHxFY1D0EFC8fwrCJp2XIurB+Oxyj5znH4=;
 b=GKSnMPixThKKazOkqooqVhHwu3BFlPu+9uP0Q7HK9oCy0YGOhBU1ZzN6ATq9yocrBg
 hX2IW+Kvf3Ir1qKViJdjjV2mW1hWiqLgOfPsjMImyroCIzvRQ0pOu7FZkTUHh7W7y+Fu
 LM+B6LAxZ2baLU3WJigtKTfsHiwq4V6VxcJuqsEn2QREX7amQv+faokiapMa9dT0CoM8
 Bw3Kq9Z/7uswDZc3eQQIf95/usWdQYJKBbIo3UJq2GhK6+esyyBoWPkr7nBH1P08h/lZ
 g9Twz1k2l4ZQW0tzrIMOMCSRx/l9RRtYF+c/IAX+bz2MERtLa2v6mh4IAyMxYG8n13br
 u2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767590000; x=1768194800;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xqH+x/N/XKHxFY1D0EFC8fwrCJp2XIurB+Oxyj5znH4=;
 b=tFulueCsOT89z8DJTU1mxdF6RQOrvtWkfQfHQS177zOTuv1c9K52itU5le8XMYLQ8t
 +H7bWO5xPMMIM+e8FByOyBcO0pMIK1t4vuqMpVhh9BdPZNas3cveb5EA0qVZHGixlvym
 7r5rBg5ukHqNg75tyWztnNXeIhoqAnhNElJVaW5IER1wLKeotf1oWXH2EaPLlRPVWxoF
 aJtRWynY9A6ust2j69Iv3l00s1/g7gsgneqcZv+SMGFY8nO/2QBk6Y2l8It7bRA3t3zK
 /ifPGhks4tFzkV6C4qZ9ma2/BuAubDqJ5VkufrkmyMQXuIKUECXx0fSv/cypZIEdWORS
 N5gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUkKyMDBFGAu7XEDoskuE3P5N7ginLHUDsIwN1Zr1DKarp/mvlhitCPSTLhkyBfmVZOO4nFY5p7Jdy@nongnu.org
X-Gm-Message-State: AOJu0YzMMzfMmp4rMkieYghnK9QXKaeMtA1E+10EplfuI4C91gbdW5bs
 5IbwTEX3N9yL4UDlTPBJAEe8WG+VGF2zVdeELqV+mP44wi/CpOYUJj0Oy8FDl9VYq1I=
X-Gm-Gg: AY/fxX5P95O3XD01ZM2ySyIsqj7QmTBvfPs2G1tz25/FRbNMB2NiHLFgOX7ioPK2C9d
 TcGeyxgGpgg5dmWcfUdSrvxSxH0Ej19jCUO2O8SmpTKd+qfy0uBZi8/tMmSYtn11NnyG6UaK1lC
 bSm2Gq9utsdkKR2inArmEGkkpUbSM1JBLcK3Ng6tigO9DGvwTgAD2wjl+37upPofUy0GHHx5DxA
 JNgXFIxG0fbH5589s4SHXu1QAolSD9aYr8mB2StZGUefjB0HKpkCZmf6XFInufZAtS3Mb2YCCNk
 eOo2Bhjagx/yR4PezKgvVCrK3YP5IHgrgKrVSb9Igufy9qwB0jkCCFZLVa3Ixb5e2Am/iCYf7b4
 Fi7D/cjqkNaHRWANKckNHyWJeMu3ZwdLw4Wu1iH5Wf1zLrcRCJ+u6ejPDHYgpq1NO1H84JGZwgG
 WyYQ3UUCUZW8I0LeKYZbN6IEf9Ml4XfNlRQxakI48c
X-Google-Smtp-Source: AGHT+IEOAGIC6ULwC3xnFn1ONQ9RvH5zNj7vGu6xvaN1opx7SXWukD3MeAHI1X/+vQll/U8sL5s1jA==
X-Received: by 2002:a17:903:1a2e:b0:297:d764:9874 with SMTP id
 d9443c01a7336-2a2f222bfebmr472306045ad.21.1767590000497; 
 Sun, 04 Jan 2026 21:13:20 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c65d66sm431527115ad.20.2026.01.04.21.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 21:13:20 -0800 (PST)
Message-ID: <53b89e4c-166a-45ea-8a23-6023c0e329ca@linaro.org>
Date: Mon, 5 Jan 2026 16:13:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] plugins: move qemu-plugin.h to include/plugins/
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260102214724.4128196-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/3/26 08:47, Pierrick Bouvier wrote:
> This change has two benefits:
> - ensure plugins can't include anything else from QEMU than plugins API
> - when compiling a C++ module, solves the header conflict with iostream
>    header that includes transitively the wrong ctype.h, which already
>    exists in include/qemu.
> 
> By Hyrum's law, there was already one usage of other headers with mem
> plugin, which has been eliminated in previous commit.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   docs/devel/tcg-plugins.rst              | 4 ++--
>   meson.build                             | 2 +-
>   include/{qemu => plugins}/qemu-plugin.h | 3 ---
>   include/qemu/plugin.h                   | 2 +-
>   plugins/core.c                          | 2 +-
>   plugins/meson.build                     | 6 +++---
>   scripts/clean-includes                  | 2 +-
>   7 files changed, 9 insertions(+), 12 deletions(-)
>   rename include/{qemu => plugins}/qemu-plugin.h (99%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

