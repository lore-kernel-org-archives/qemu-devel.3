Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C83CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuZB-0000mO-6d; Fri, 15 Aug 2025 09:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umuZ9-0000jE-6r
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:33:55 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umuZ6-0000za-Cx
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:33:54 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4717553041so1584668a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755264830; x=1755869630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S9kBEZJwRHdS1z6l2jhnNM5qi6DDBuoPnjz3YSuWe0U=;
 b=Povq678g1ORGI+GESUyrXedv0gOaURC7qkZSzyF+0JB+p3K122gSi0eCodqu3/8Cut
 3dJgzoxhSfL6eOSVQEYsmTQ88Rnnl9fTjQiNJoJ42xTWFHv5UOzTiI8QiXqFJI9klH9o
 sioIR1qiWz1DG1krayrH1wgKCRuqYB+puQMKM+NPx/Lsu7QssFTVYskCwyY6Mre+0rMh
 tNB55gxMnrUfttCtdZBn4CUjOSOqKGPfSjFO6y2LukuBEMB8sEbbhMg29agS1Zbdn7ao
 HUp6q7YSc3hCtgg+vTd3eYrYf/7FhZsLCP7CaXQFFiD4Sh2rbdZnhNmA7cPAhcCRyfrX
 ZsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755264830; x=1755869630;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S9kBEZJwRHdS1z6l2jhnNM5qi6DDBuoPnjz3YSuWe0U=;
 b=jPJOor6gZlbz//rJGIvY24gOmqK1m0/rx0H27oEPjLONhhUWfw2AEN7ttoOiRaki70
 /8l/X8pkRQVhYLH7CwDIRVzejIT84x2oJg5sgp+5xT0aW7UTCmuglZG2Ph6HVArbDdzd
 l9ikJqYoCAqzQqhseHZrLkvPIU0SBHtDL6QK2PPYqkX/T5zErjCHNRFc+qsYayJKir6e
 oRdoVdoBP83JoIKuDWTKeEZ805gSg9iydI+8olhohk1QGJ53t6hRUd+0cl5kQ7PADzLt
 78P3vMNifMqKIhYp06T0IgiPmENx0QNmprmVuqLfjCXlUjLSV02/tWNLDudASLh2i+hy
 eMag==
X-Gm-Message-State: AOJu0Yz3yw3+FEbzx8jzTitx812viI0HZARJN4OPMfHNicTxa5vhxwQ5
 jRBWAeAlP0mcU6IsTEclfWEr608v6CUCLx8R7HuPT4jV4tbdjI0BqaX8f1rR/UVzlxQ=
X-Gm-Gg: ASbGncuDaloB4xl7knti29ogSUMNLqEeBEnck+2LNyHj5jSTvnE6TuhOxC90ZxqFDjQ
 Eq5rnZ0+yO5rLedQgDilHHmOA10YYh7X93DQzb/EtttpRh+14cVcdTh7OejVc8mK3nro0m8K64i
 KdGh+hFeFyDU4q93D0SBEdKLMFwaA1sHkvithapFG/gzrMzuP6aKGe7kAWNxY1Yj+Z0LHn1ZPtx
 whlr0R2umBCChFg0ahRQtQgI1sYyMUxYaUyfGbPOXcAIcC0m09gKnNd0xK9tF8ZYKT4G1LG9L+T
 ZORbm0DuMV1pvc0d1dHdNdSXO+1FMjlIIc4HiA8Toqq26FBeGIwbnoEme/hBJji7ZniBXYmDlzk
 LYZxswlcbOEKNtvNWSRCnwJ8c33DCmPO24m1I7qA=
X-Google-Smtp-Source: AGHT+IG0L7LCUw5MQGb0s8R5i3Y65m1vQ48A9MjiYuJN2C/JtyyvtUtPqIjH3VHjhHZx7hFjzGd8cw==
X-Received: by 2002:a17:902:f68c:b0:242:126:476e with SMTP id
 d9443c01a7336-2446d866ae5mr36519825ad.32.1755264830091; 
 Fri, 15 Aug 2025 06:33:50 -0700 (PDT)
Received: from [192.168.4.112] ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446ca9d016sm14475025ad.35.2025.08.15.06.33.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Aug 2025 06:33:49 -0700 (PDT)
Message-ID: <2099c9ed-9d2a-4820-aab7-bc942ca44206@linaro.org>
Date: Fri, 15 Aug 2025 23:33:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] target/arm: Implement MIN/MAX (immediate)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-3-richard.henderson@linaro.org>
 <CAFEAcA8YsRWk-dFMpnMc7ZgJNhOH5WuqHkhJ-0g2WATE6mAqdg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8YsRWk-dFMpnMc7ZgJNhOH5WuqHkhJ-0g2WATE6mAqdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 8/15/25 23:18, Peter Maydell wrote:
> We end up doing the zero-extension twice for the 32-bit case,
> once in gen_wrap3_i32(), and once in gen_rri().  Does the
> extra one get optimized away ?

Yes.  That's what the z_mask stuff in tcg/optimize.c is for.


r~

