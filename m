Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55BCC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcxAt-0005uz-0S; Tue, 28 Jan 2025 20:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxAX-0005o7-W6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:47:06 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcxAQ-0004zT-TB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:47:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216426b0865so105500615ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738115217; x=1738720017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kb9jDIWqu1CNPTBiBL/yvvy30NyatF17RDKTybtHRdo=;
 b=ZT3PKe6U8+MIr7CBtqPpweUHygVrQFuUR9PTv8schvfwujgCw4RHLG4zmZJ1pMKKSu
 MGSrOpUVd6ecGcq5u6/xN5c3F5CXm91POaVjW/QN6BfFBhc90kXV5aDWM7q9I+JnYPAg
 R6LSoVW4iG6WnYuh+OtSvNe9pS4QBe5oPmctM13krzgHv8JSBk0tF0Ufb+ZOvTNYzlar
 0ScxmhtYJWK5fL+Z1zKdsiJza+e15VvYCVtRv80oGVIwpstn3c9jTpMqar4ImyHjDDzC
 9jO9VlOMUj5NWfjiYWacNS/949exlOsLzCi5b1zSZZQ/g3AKGxhnz55RDRwG+nuuL7Fz
 cMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738115217; x=1738720017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kb9jDIWqu1CNPTBiBL/yvvy30NyatF17RDKTybtHRdo=;
 b=b58sf35ZTjMJbmo3zIVnfHo64qeteBPDBjkYltIQMzt3lMdMcmycaAAG5GfrhbKZI1
 WodkyUp4rkJufkgog9KMP09ZEFAhDbqyHDqTYw3hxdLHtLgBUTZnv4byKrOzqF2ZCGpB
 gZFxxvddr0yslZ8/HTV4Ek5sVj2MC3880b4OLObakEylI+yoJx/OwOBuH4P6SOcQq8RL
 qjswZhht8djwe2BMU7ucT2t8hk30zVc2aSzo99lpP/0Omgskb2zbqOKIZjRFdnTz2c3a
 BhH67DchOvcK1FFPU8y3t0dnElK0UjZbY+QXjuMOp7b7NPOxEBTII+AYI1YGmuz4rwu4
 KdFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6+k+ruS7B0bjuMxvVEvBJdBt6bOvkUS+s1rXkYEsVRnC+X+0y3yPWtpPm2gSv13KSACTk6fdwCPyQ@nongnu.org
X-Gm-Message-State: AOJu0Yzs9AqxbWeFIQDbWUIOjbXnnay3gplMGSF90fyrTt2lMQ73ssPd
 zCKv5TItexpRKcFog55uiZ1uj0nNYNx3KE0LvAFGLngJIQdtBA217CXKxkhpda6qJL8gkS90VhB
 B
X-Gm-Gg: ASbGncuEZGi3y1jZ2QfdP1ofkFX7m5qclegusw8BvuFlUu+ViX+yyVxgRmqb1DgNDL0
 rdWFlbKv+iewyWWPd/AX3Fum65P7nQE6LB/WwvD4l6wgeLM6FcrAFQGO5AB15mOCT3+0eykyxei
 mqemvOMoinkvxSunSN0+9szcT2dQj2vMspLQV2sxODjwz2Kbkz48gk3F5kTOn1Moe+I2ekd93P2
 9zC7I3m8NfO89mCDQvGJnU6qW42yl0KhTUMS6Y/zVYWfzzjAxlONfx8vvsnqD93+RfmPUl3UELH
 xmLQrvvunx8qTZDR6/ECqmch6TW3de5Hv6gWfppUZeYc9RcVRw4N8/oQOw==
X-Google-Smtp-Source: AGHT+IHJGdWHo8yVmSwMX9FsGiQ1iWZEg4P4yf87uqj6oKJDLL8wLnOiasV/UykKmuanI+5PX2TEBw==
X-Received: by 2002:a17:902:d2c7:b0:21a:874e:8adf with SMTP id
 d9443c01a7336-21dd7e00b3bmr19681915ad.45.1738115217433; 
 Tue, 28 Jan 2025 17:46:57 -0800 (PST)
Received: from [192.168.0.4] (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da555a428sm86845025ad.84.2025.01.28.17.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 17:46:57 -0800 (PST)
Message-ID: <3b950540-7040-4970-9d57-75df4cae0b02@linaro.org>
Date: Tue, 28 Jan 2025 17:46:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/hppa: 64-bit CPUs start with space register
 hashing enabled
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-4-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128224817.24715-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 14:45, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Turn on space register hashing for 64-bit CPUs when reset.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   target/hppa/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

