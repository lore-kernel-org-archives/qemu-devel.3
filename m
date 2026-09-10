Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450A7C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ku8-0003rX-3T; Thu, 10 Sep 2026 15:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kiI-0000Sh-D3
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:45:50 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4khv-0008LI-GP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:45:24 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so212281a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789069482; x=1789674282; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8zETsqRvX4XGj+oOnGQ4sYZWQHFp84w9PP72l0AJz8U=;
 b=eYgdz2cYC/Wmm3ooFKr3I+SfTDBpBCoVehyyDSt0AzHldens2a3yoR+uUIdPefRr8+
 R3jb9CLuySzk1lf86ltUW7jYmn/BoS+tu3rUSIipAT+r9HS7NVvxpUrpM2fTSkFKFUNL
 vErE7w4Bj/TUiNHLBFeq8HBSsK9kZ5lTGGtZ0drdGmOYJwoh319v+9kpRx5i9Qpvhmxb
 HW2uHa45/nFz79SBfqzW1NZK3zl8pscVJoFMQ1qA6fxzcScCRzUBLQI2Eib3f5zObLDT
 jnzdkAI718G7Ns0MPw+2702Vi3Y3VFhKazEnrtRxl7h1iIg8N+ZNN6C1E7bIDgqMftLp
 7dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069482; x=1789674282;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8zETsqRvX4XGj+oOnGQ4sYZWQHFp84w9PP72l0AJz8U=;
 b=dYEqIF143V/8tpSwtTJP2yFi5Gcru8mdrAsDgLGil+77Jky9m8+9e1Nwkv2MitBeFY
 pZn1MRUjoU+KEaidqmQDYxnt55nnEn230OsIDiqai8bEilMFiuUWGXn4HyzAexkgcXE5
 wwWPjX5ZbbmMZdLklaT0oTBz+68ZrCAlrVrBo2pOkUUay8ODiUhXjjJSUS76oPSITtFN
 feYVj6rS8lMo8kzoiIKi9qNn8Cm8LmUlrSSTqq1VFjCl+e9iXXtipWFmjvj7fo7eJXxP
 cGG1XMR41tfkmD650vHx/1sGSLj/RxAJ1xVGBw3YQXdqHXNQAtx+clcxk45Jd8z6KTWZ
 PfwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNHBKA0v0IsTLcK947ckQqPT5ArRzo9hIEBOjA6G7icLBGma5eNsvI7/daJnWsrD/e1fm1PxW6qwJX@nongnu.org
X-Gm-Message-State: AFuF++kSstdlT4mKKPQTGI2pmkhpqgappdmjrz5d2AF7zTPYtTaGWZ/B
 xO9GH/wR23mZEe4yja36dGNhrDI36yDEhW/nGkxxHTuoUjsl6qiGSGJZZvp6wNRg7h8=
X-Gm-Gg: AYBFou3xsU3CfQkgRk55vcfegR/7i/3M+GvcgbvrE5ejFUmriBokFQz8E+i8sjvYPeD
 4QRH9zDqRxgmU7qvNKkMnN6stl82TtT9i2cdbWPu9AankV3jXBd9xeMAU3xiCjTF5Szkl0uT7wM
 cadxtS9zncxyhq53sotBHWkkDnkN2kaxdnKvo2mHdKRg/14IEj9BaVmxcnV7NlQ+wS7JhkgvyrR
 xXmTy0N/EAIJ6JvT+8yr+Nd4VHmFU+l5wO0z768avBS1yjIi/Tk4OgOaEutF9a928MEOlekFAGJ
 RS31de86wBdMUDj2IO7mWQ7J7ehU3dzE/4CnBM/N76IQild7/myRJ+lpKCDobBPcHuwcAC3Kgub
 2zW1vWaLX96+8AppvnD9u9IgCzd0QIFtia8U7IqA3OKrk+xOSB5Uc31rBvY+UY15RDyjA8Zx6Im
 ZKDatag0MM9mHGwPjnN6Aaph75Mi2R6UolwvrBiuWU/ruwAb+dAmc5TFeaqyauX275dfoWsEd1f
 bwob0kXM69jqRE=
X-Received: by 2002:a05:6a21:6f88:b0:3da:755f:a031 with SMTP id
 adf61e73a8af0-3daed20b238mr923398637.12.1789069481818; 
 Thu, 10 Sep 2026 12:44:41 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a8a9sm287837eec.13.2026.09.10.12.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 12:44:41 -0700 (PDT)
Message-ID: <714d9088-2a70-414c-9b41-a86966a1e8d9@linaro.org>
Date: Thu, 10 Sep 2026 09:44:36 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/21] target/avr: Constify CPUAVRState for some
 cpu_*() getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-8-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901095229.72018-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 8/31/26 23:52, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to CPUAVRState when the
> argument is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   target/avr/cpu.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

