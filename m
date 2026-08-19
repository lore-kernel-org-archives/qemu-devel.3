Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D55EC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmVd-0004JF-Pw; Wed, 19 Aug 2026 16:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmVb-0004I1-2G
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:03:35 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmVZ-0003s0-LQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:03:34 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38101f85591so201516a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787169812; x=1787774612; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uMci66aDRjcY7AWbQjwN8j244fTIs+AAuBVCJ+MiWGo=;
 b=lPOJoSI9iDLAtNXNx1VvZYCJ5gkBthlk9Ya0AcCzETuXkZSBVvhIDxBzKgZehf/neM
 eBVDuYO2UYs4xYAhOhpXgVfV/gFJw4xBZYA5z+EtMR17bKzz4GBxhlQlZHveLdTYEE5I
 TCEfQlya9C76C1pJJpotpQlaI4NWyMVvBUGKcK5gXP2tYHk6IXIOdJ3G6d/cIFymHnca
 YGBTOvTeAr3NiogBVOQLlAVHYpK/y4iIwDdY/3KfeuPrKIyMhpQ++/PAoH5vtSeZZTZH
 Xt85PvcX+HdM6kRxGzSA9vA9ez+wesTjO3l8l7sjxm/6c76JCKcz8+wxOU6oFRTjG3ZO
 cQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787169812; x=1787774612;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uMci66aDRjcY7AWbQjwN8j244fTIs+AAuBVCJ+MiWGo=;
 b=Up7lVrWPDhN0kA+YTsdqc/gjHE7qt4ALB8pInO4kbYn7oaUrQi29AnRxdwaD8EUvaB
 KxOTLRrtxjVFRS9UZXC7y0HFuYWDaEkF5Yi2K17XCPVzVe+ysCljsHu+iqv9IDiq0Isi
 EjRKMJLZfhVbTYnqPJLccZ4omLuXykbRk0TZEjLnw5sLGovZV1gMtcnzwOzAIT8nI9IA
 OiihGHjb7matjGgasBNjuLGPkSWYwNjtmybyQYEvSXj8FxAxhBcRGaGMhOGpjH8kSZtC
 m0r3FiLeXY9NiWIFvZwPiiafeammMgPr6mqTthIyfSM5uvY/ONDyCj1Vd2Ka3quoyTip
 G+4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Roym4+DndOsLTWmM3yyNRfI0C1imZKPQW1Vkygxl8CQMKHS3RJ7L+CoOcCIDkRvJ+TWlS1dMk1HxChY@nongnu.org
X-Gm-Message-State: AFuF++myT/ehridHNFF8ehnbITdRVGhttPTiH9ZoQ38n+pTsavYA20Ve
 9e6Le96FQdJRiH5OZlAodymoKAreoHSUPmabgjKUUljrsfHjdK3tAx1vnweGcrIsyjo=
X-Gm-Gg: AR+sD11sWd3hfL3tPqfgr6+Ap2T3fte2VlEU/NyR6jFbKnATeoXuDk75WNI8NDcGzDg
 TF4nIzqcUR3s2hl7UX4CPNRlPDdFtwCUGDPUUQq0w4QGta9qCsZugMCPStYrn9BLOm/8xF45Ssd
 iVOAYPKGnqlbmGTSyZmldZrqG+0LFKdBhaVHeGg4drfta5dnDTSUkj1jErIhlf47xX/XZVSGNRB
 xY0aCnwyZij35cUjQIt2OrfG4KYergEYfRcQUbAcA9UO9EVcHztI/8PEvjvekf6NKTU/VN7HbQf
 DJ2V6xd6Szus5euB9CV+PrS0TZkK6RVYtmIKHPaCAWC1sUJkRI9vQ6G0kr8RM3jSohAhLQ0X0z0
 KCnOGuVDbeBBXWCRLrqubyCSWYTaQPvYtK2U35/cBjRXFrc5+0FbioKvwebsqlxUerFW0XV9GfI
 UoszB4EcRx7pn+nrxuHX9V3jt6+IAOtqb1i+2Ua2gB0z0NYB2ss/ONHa8PUhiD53Bz4srPaz5FC
 +DOUaKz
X-Received: by 2002:a17:90b:5846:b0:38e:42f5:d096 with SMTP id
 98e67ed59e1d1-395a00e4cdfmr1645830a91.0.1787169812154; 
 Wed, 19 Aug 2026 13:03:32 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb3069csm4487661a91.15.2026.08.19.13.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 13:03:31 -0700 (PDT)
Message-ID: <a75a5789-6672-4b33-a40b-8481cde372dd@linaro.org>
Date: Wed, 19 Aug 2026 13:03:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] accel/tcg: Refactor halt-to-execution flow in
 cpu_exec()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260819145649.23439-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
> Invert cpu_handle_halt()'s logic to read in cpu_exec() as
> "if halted, try to process async events and find work; if
> no work, return".
> Rename as cpu_has_work_after_processing_async_events().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/tcg/cpu-exec.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

