Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A3CC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsve-0004P6-20; Sat, 24 May 2025 13:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsvY-0004Or-Ko
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:44:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsvW-0001iY-Vx
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:44:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-44a57d08bbfso5969675e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748108693; x=1748713493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/QYNqjvVSe24+ACWRyWt89eB4Co84GsFkHqD14aCepw=;
 b=AK1B7QWWO0J5bBkCKUZCo6wT0yhZGgCIphc3DtHobUUxAo0dTi8HtuYVuhFHTIyKBB
 U7kD6YgLLjjBG9pwRQILYaI/TYtE4aI5QWQmP1gguk2Kb8mW5xCR+vcqZDUDLYPqtC1k
 ppc+P6X/fbriF3jBK0OXvQx4Kc7jNfnDThmDrQ6zW+vj/+O7kGUzgrvvPWy8r3UrPwpm
 xzgsYmyCvbiVbRYc4oElBGMcY+b7rZWDRk8zW9dQ+K5gB/jaGCb1bMgufatRhLr8H28o
 gP8AXvZSiJQBSY4jgI016YVM7S7p6rpv06FRtcRQGe+sgKdsCQmH9CjcUkZRC7PPjkK6
 Ccfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748108693; x=1748713493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/QYNqjvVSe24+ACWRyWt89eB4Co84GsFkHqD14aCepw=;
 b=W+DuFGYYlxpzoBSfxAwkVV+M9+39vozV15c73GxbJvEGLRHosmkXTtlmZmqlXnJXF1
 cqY0OMZPsJU0T+VL+mJiagCojZMqCjX0rJmiC4mehRFN4rWJGmwbtyWgj2v+Ys39ngR9
 TwJp0OVnEGQ0dN+Q6U26nm7UrvPnP88rVR8icwlPscBTXf5KllVkJ63vo2V+VWAWkXX6
 SaB5j3YKm6hLylIag2o+F0asr5TLtuzcDht7awo6u8U1zSAfrCyUvgo8p1W/gGYDl7cW
 dphTGgVYX7V+mpwojFk5oNwsvfjg19o8ODXhPb6XvQkQQu8VPbsfke/D5vqRTeppafnX
 nveA==
X-Gm-Message-State: AOJu0YzF6v+GTTUn5U4wU8E8b5uaIFC30fPCLIBTD1O29krHssPp/zNm
 690xp6yks1pMKv0yG65qH/oKNU3INSBpQPWOp2iA/p4S1cPJ2c8cbuJycbR5PwOgCjfiJsh70+U
 N7UD2OeSTKQ==
X-Gm-Gg: ASbGncvx3lYY41yy+903Qd2sIjwYg0oe5899Y/J0CSZ39SptrBTHYDBQs54Ti6KhXJc
 YFQBEZ1rQiv/uVTrt5MobkoN+FpuO14XLCnAEZP9RbNGH7YswVsnP7hk1ga8T2yllJPIp/YtHuJ
 /edH2uR4eutNTCNe9FV53tcAnFx9wIdo4pR1aspdzGyZAHMP7nL/N7g9k8B+O0A+z3ob2JYqIpn
 PjF2jm91Du1QU44vKVRL8qEt8IkTpBunFp7wAhrOK8A5KvYZBCbyGifw8Q5ubPiblBrwv8nD8ob
 UaBHtkSAUy24xS6UoUkMmoI4Rha/2Q9eUEitb4ingIf2n10RuEdgidfRKojRdcs6LA==
X-Google-Smtp-Source: AGHT+IFplq/s2YSpgeHzhgyefecGv2T2g5LEBORDxQi6sf1R5lY0uiHamM9DdIVcJeR1j67+ssADxg==
X-Received: by 2002:a05:6000:4284:b0:3a3:5c8b:5581 with SMTP id
 ffacd0b85a97d-3a4cb43da9bmr1979848f8f.4.1748108693113; 
 Sat, 24 May 2025 10:44:53 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f182538fsm190801345e9.7.2025.05.24.10.44.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:44:52 -0700 (PDT)
Message-ID: <4d4e420e-3365-4f43-b2a8-f45318752118@linaro.org>
Date: Sat, 24 May 2025 18:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/25] target/tricore: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <8bd3931ba67e8beb420cb198e2eb16b7b1270084.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8bd3931ba67e8beb420cb198e2eb16b7b1270084.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/19/25 16:20, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places an exception hook for TriCore targets. Interrupts are
> not implemented for this target and it has no host calls.
> 
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/tricore/op_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

