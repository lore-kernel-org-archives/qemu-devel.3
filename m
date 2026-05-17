Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B59CD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOf0J-00054p-As; Sun, 17 May 2026 13:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf0G-00052j-TP
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:10:12 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf0F-00069i-3G
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:10:12 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso538563a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779037809; x=1779642609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ZLCAVIAz3BK3Vp4vXRYR5e/tkZiuFJEYIfOWFAvM3s=;
 b=Gmy0Rz1HMLcTVt2eGKNNvGHOUgAuJOhazC8MmkCsTAb99+VmriEco2vV8RL4aeZA+f
 8kzKIQNDtrUACW1vCHeOZLn83dkR+eKsaN3DC94kUGXJmWrUh59NaICM1XJ6QJOcAE39
 VZDdAIw5dX+IjrsAxozW1Zoef+VrcALMy0CeQlwdewALg2SAonKzuPdfP7joCtEztO5g
 hXWdNWasqgk7O+8T/YnU/jJtE/fV3AqkyT3hjssdb0NIe0QpN1/w8BRI0qXHeKS1JOW9
 7AUZECxhlU6MbF7ryJE+oWFuN0Atedc72RAbWZPwk8YteLT2EiuopCi7HFI6kfFyogh7
 t4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037809; x=1779642609;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ZLCAVIAz3BK3Vp4vXRYR5e/tkZiuFJEYIfOWFAvM3s=;
 b=jyByNb+CBHOGdGihVnqNDQBUzsunmXNI74jzV3Z+R1hQbAwJOF4sj8w5wX36EUUBij
 xw8DqzzQQvfVUgCYjC/8+oHy3LtzgJ50gWK/zTH4G0CJAvNN8Nja1A53ydbgwKIWbNFD
 +QNes6SqgDJGNitNfYU3yuBrdM06NEafpXfzIiGBENqkCu9OUkJKi+r6qUmiSUoMHQin
 7E2ReWD+0xaUqtPqHYuIYNRC0jVUjEZxZaWViCQdCOfkWfiNjlGX62giT4/Ci5EcHG9a
 bEXxKQ2aJMHcOv8IV5BDFc+Y9zQDaPx9Rs4uw0mVCmm3zrjf09dNlZLWlmIlsZ8tXnOB
 vCnw==
X-Gm-Message-State: AOJu0YzA131QJ9LeRFvaXFESw9XMnjYXldqcvjccs3ny6/x3COhy1NIr
 al8SSaRLRfoXTY0wf0Ticu0KtQwpP1BZU56eqGf8jPxYYwTagWbW9sNSdDesQWceNtsF5R2wi3U
 KsCj0
X-Gm-Gg: Acq92OF09MWRcYXK/y2gM6CNX3DmvDHbS9ApsqoIni+ozKLGEM/9L+JiVxYF+Z4OHUS
 l8r4jjgl2xYPysBEWdewSuun3J7HxtFb7IPnc/oKcboAAZ2G64xvjhZwOPe9seWaZn2EAycAbit
 U7l6gSlD0MqA7C/T1CJP3JANjq7QAvu6qPJpmZS8dN/k1sRcongV/WIoHPa2QWY0NWm0oOLqHM+
 zJHpte1+pKy2GSYZ1tRHAqQS+izY4FwKRtj4JYQ+lN4W8Aka45ixP1S5OdDx7gRKG5kZ9sDL9FA
 RJRK3vy79Bg1ZNvpnJFMPWygj3YXhsOtkLg+5g+nL1LpxDBidrYCe0GEtLMJQjRjkp6/HzrYPwZ
 mbW2HVhOKTjzqFapcp8+lDDbpTbYIXz140hWy3dfr3Cmd6TzHSCXsL3+u/6nj0WYG4J7/EYHpVh
 hQR0BLKKIn2//EuVRimnOs36M5SUrndIK2UaNaA2St8+D22WJcl+S08YYTng==
X-Received: by 2002:a05:6a00:807:b0:835:36e6:72b5 with SMTP id
 d2e1a72fcca58-83f33ba7238mr12138680b3a.6.1779037809423; 
 Sun, 17 May 2026 10:10:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19664a59sm12091905b3a.1.2026.05.17.10.10.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:10:08 -0700 (PDT)
Message-ID: <83cd8a28-e9eb-4c0c-a29e-73f3ac1e3843@linaro.org>
Date: Sun, 17 May 2026 10:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/arm/omap: Remove unused wakeup irq
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> The OMAP code creates a qemu_irq whose set function is
> omap_mpu_wakeup(), and passes that irq into omap_mpuio_init(), which
> saves it in its omap_mpuio_s::wakeup field.  However nothing ever
> touches that qemu_irq again, so omap_mpu_wakeup() is never called.
> 
> Remove all this as dead code.  This lets us remove a direct call to
> cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB) from within board/SoC code,
> which is pretty ugly and might not even do the right thing these
> days.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        | 18 ++----------------
>   include/hw/arm/omap.h |  2 --
>   2 files changed, 2 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

