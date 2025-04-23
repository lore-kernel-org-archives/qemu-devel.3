Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2810C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7hYn-0005Np-JW; Wed, 23 Apr 2025 17:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7hYl-0005Na-S6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:23:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7hYk-0008C1-2Q
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:23:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso292283b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745443387; x=1746048187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TVyyXt2NG5tcM7M3366hy2BuMxyedKPjKiPNUJWq0l8=;
 b=kUsleYRlwZFbnWKTDMnhgVkoAU2jK9iJlVgaDhn/Xcs+IjVgB8X1oZy+1KEziPgI3f
 PDgXXwyW9YwDr+//CcAXGCDPPtp+qMUEH00f45g/MAV0HttFeT1JKFPtgE0YOxhXwRKZ
 E3u6+byQckaXay8mZ6wTiakdzLM/peQo3zpQfdH8ro6wH+vP3egG9lXfSiWjTmGa4A8f
 OroFPejJngSbvzX/bwVK30gOJnwWXOGGASIXLde5xsGOnEtzhZUHZtxsRpr4OaOE35/u
 llifdMSWpBF7WfMAB/XfFsEUG5RsZnTOY/rcrAZ2pJ10fafDobp1+c7bdHJrDaR3FGqy
 Bt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745443387; x=1746048187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TVyyXt2NG5tcM7M3366hy2BuMxyedKPjKiPNUJWq0l8=;
 b=jzQ082pRqfT3yQRPXiCCjXr7l2OjFTR/+vSZFdenOic8yLm5bvhkDOaMH5G6GS5tje
 P3+ej/homxIdCyUt6oWL/UNjEGXc4G6hBYbZijdDM9n9aNYrsYAmTk+YujgU1b0JWP+j
 VlI7W32J9Fy/q2yegHbIG/GHx62ejy3ZroCBJCxHRq2pt0terJXuOCbco6PVVbBeUNNy
 Tf96KyhX2fgwbyDyQn26NZbWk+qvOIXhjSjM3G0r1mFKHsyIzggHmYcoAwwwqeh3aMO3
 3zha+CU6Li5A4sRToLKTnrcBZyqhf7D3NVyHJoOk2YuWEiEdkB55AD6A379NLDt213w8
 z4Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8oiBpOdDNJcwjM8oLdgoFAbyDCeSQMTZzLUzRE72wwtOxzeIZvHhVPHXSPziobfK21M6hqLLJ6EJn@nongnu.org
X-Gm-Message-State: AOJu0Yy81zur7GlwjIYjBANhq3+vuZSGPy8FFMOXnZJv6eI7x/xm9J8H
 VilCc9onVfUjvpThCC28wu5pGh/Cn5hi41t7wh//cjlk+tLpUe8+7Tahfj8SfeY=
X-Gm-Gg: ASbGncsMm9KgXJdTblrFcIM2xVM0IXzbk+VreDq8sLD08ejmSnJlEj6vgfaYlOBS3Ui
 JYorbv4+OUsBq08YilS98P7MugTucRQtewbNFE6lz/of9a1yAzVCeeUINk1QQWYoZ5KoGJ7leYu
 C9Nl/cVKxp2HBb2drC33VPSkco2jdSgPfENH96oqtLLMrnU/chg10zuX013YexQF3VPiscff6wr
 Lvx9OiaFqdRdDet6lvUI2WsHKkZCgFpphAChyCPTO1ejyBs5ZXAF1CBuEcaeiLBOXgL2OTSLP5x
 R8B1kg46DFB684BzMnppq2j3iShyVzCNnrJzKEFV3HnKnLxYpxwufzNCGzEsjVGMi2UlyDWLcFB
 zzyiCmyLkuj13knlxLQ==
X-Google-Smtp-Source: AGHT+IG+TOEb6dKuhS1JsYgX4IueBJABbyEvZE1zU8ZY2WhelDk9nr8G+4CytjbPzV2AG8lPKQDgAQ==
X-Received: by 2002:a05:6a00:1483:b0:736:35d4:f03f with SMTP id
 d2e1a72fcca58-73e246188b5mr355299b3a.6.1745443386944; 
 Wed, 23 Apr 2025 14:23:06 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25941fd9sm41624b3a.53.2025.04.23.14.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 14:23:06 -0700 (PDT)
Message-ID: <21d44c3a-a27e-4f56-b9e6-7152b02de600@linaro.org>
Date: Wed, 23 Apr 2025 14:23:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 118/147] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-119-richard.henderson@linaro.org>
 <4a8da7b6-7773-453d-b704-0991caa3cd97@linaro.org>
 <41f54ebf-6831-41d6-aa67-f083d6b7b0e8@linaro.org>
 <f5c71904-342b-47b4-af8e-4155067b5e7f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f5c71904-342b-47b4-af8e-4155067b5e7f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/23/25 09:38, Philippe Mathieu-Daudé wrote:
>> So I think we should not squash it here.
> 
> OK, then this patch can be queued on top:
> https://lore.kernel.org/qemu-devel/20250403235821.9909-37-philmd@linaro.org/

Ok, I queued that immediately afterward.
Incidentally "unconditionally" not "indistinctly"; fixed locally.


r~

