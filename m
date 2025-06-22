Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E99C7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBSZ-0007Zv-CN; Sat, 21 Jun 2025 23:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBSY-0007Zi-Dp
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:33:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBSW-0000Ca-58
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:33:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-235ea292956so32254815ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750563210; x=1751168010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vwNHcQd2k+U3TzgUh4s36VuQGLGCz6YFa3Xxapo8SPM=;
 b=qo9Am0f4ntTrkOLiaovzgicgRhDRgjTe0VWbYky2kYVoMFEdpFz36zxTJq2URSXoVc
 Mxgd3ZnFI5GG9CuZQ2maEGCd2FtZ1oNB/h85u7oI8nehTbACeZUF7Cope20Gw/SyFjUL
 nJXk+lb1gc6x9OG4XL/otV7k+RkI/uimcZJV2v0p3jrreldzgxdISXQ2RbixiysHdz6C
 ggXDVnyGaOdTrWGwHW2ASyZN73qNzE7lzfRo6m/i35gX1Y5Cu8xKWS2oPBtwbAbtDu+P
 dFK6YIhDdi+6JDbhOJGkZOUa7uRhUJYeORLng3aDEWrEcxDmRVR7Hwr/VaavctAjYewv
 1A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750563210; x=1751168010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwNHcQd2k+U3TzgUh4s36VuQGLGCz6YFa3Xxapo8SPM=;
 b=rHsQLfgETo+KYUxfsPCLuI2jpOCkUFapyD0WwRvrloY7ox1l7DYzSHmT6t0H0i64qD
 Nl4gw+JPkpw8YibO5h/oDC6sZiMjcjawMPr3xx1wCnUmkr7gUdScJqiDioWBoQc7Od9P
 ME8xTddee0XToO3X737V0Zs0jvloUdL9KS9s3gIA52UOTz3OaDcOZQQ+XYTA2RqQdO7z
 wNE4w6YDRlWWJDJ8N6fmupNTYuraXMJPw4YrBp/HC5IPuT+rc+B8qBAjghdP9XcYKzYm
 tqcOzuUSW1iPgyRHNt9xRZX12gs69KpT4pRn8ORoz6/aTfESzDSPR1ecNhoLFym/oBB8
 EqUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFmiRGtvhR8aS5FUi+lYWg/B3WZgEk7M0h6Ok7E6NCoK4XO5lDgWAkmlPwuYLCc3xyb1KVyDU/swf@nongnu.org
X-Gm-Message-State: AOJu0YyHI/B6yJlGRapY0ejRlGkml3HWoDI+rjdWeuA6NGbCL5Kftj+i
 gQTYiynZgfUEXPxJL5XyKsPSRvmMq/m3xhek8YTB5b8/gC5JJoZlIv3Jd7OC+PHvbvM=
X-Gm-Gg: ASbGncv16TeLNXtfDgUMuu4Un0tXA4KRc70L/RAhL++H3uu/ZyVFgSqKGMUk2ym8t7N
 hAYyAJN53RT3BBOeiNrqii7z4gxSbxsgoL+CBQl24EMU0aFr5XRWafT75MwuAC8XyH9XfElSQse
 vTzu3CX012cb2cABw/kQGDVSet1Feefj3DfOz0RDqOB9lprtqQBnkaEYV5lTSS9YEaoXUTOOoZS
 uIQDCy4lb3wS4VyFaDsW1R6b4qOkWJASrU4cL9iaPybr7rFdRDm8iH1mv0d9SU3oP/L8G2O+kvh
 sX4e2U1ey0KpDeX6K845mZyDBEaqmclq1NIQCVpVJiCFWR5rcYHNn9gnE9LtC+rDGjlhJXXOqBG
 W8UrWF5GQDkpQwTRYjlzxjRhuuxwS
X-Google-Smtp-Source: AGHT+IGcOYyQ3WqxAOpH3uXuOCCcILdyDGQTfTXzeAIay9HeId4pKB8Ovfo1mZ9KEQVg8tjpaYPagg==
X-Received: by 2002:a17:903:1111:b0:235:880:cf70 with SMTP id
 d9443c01a7336-237d97f8c47mr103241395ad.14.1750563210561; 
 Sat, 21 Jun 2025 20:33:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d875c1f7sm51812565ad.257.2025.06.21.20.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:33:30 -0700 (PDT)
Message-ID: <730b4fca-e0fa-4e99-a092-f63aadfa57d9@linaro.org>
Date: Sat, 21 Jun 2025 20:33:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 38/42] accel/tcg: Introduce
 TCGCPUOps::rebuild_tb_hflags handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-39-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-39-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> index 29ebcf45928..20999033c89 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -71,6 +71,14 @@ struct AccelOpsClass {
>       void (*synchronize_pre_loadvm)(CPUState *cpu);
>       void (*synchronize_pre_resume)(bool step_pending);
>   
> +    /**
> +     * rebuild_tcg_tb_flags:
> +     *
> +     * Used to rebuild TCG TB flags when a hardware accelerator transitions
> +     * to TCG, prior to calling TCG %exec_vcpu_thread() handler.
> +     */
> +    void (*rebuild_tcg_tb_flags)(CPUState *cpu);

I think this isn't right.  This should be part of synchronize between hw/sw.


r~

