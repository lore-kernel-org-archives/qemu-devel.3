Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07A0C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LrN-0006IX-Gn; Thu, 17 Apr 2025 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Lqt-0006C7-Fb
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:48:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Lqp-0000SE-Kl
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:48:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso392396f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744883285; x=1745488085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c9z188USbMHEAsmOS9aZWv+1+Xr9xFEVLP0AvPR6hxw=;
 b=NV2T4Rbf8SKZW1XEDUUjSnjFyg7b1bow+qsil394tA+l7uJ5yPo0t9Fid1EfFy2Z31
 fiSKfDtyGJpDh5Fq3s8ap4jmBxsoYn/TpYJcuyVmozzDJMai5Q3a6QY/nvHtCbXngi2O
 bc5tB901Z9ny6FXdThKGOSLvf1bbkqrijHfhV7jx9cjAcfr4ogmY8KUWCcm2M4xshair
 /x2v8tFESu33jaM9owgDbzIGAnjGwRuJi9gwAeMLydR886zxxRdezcwr0T5cSJbfb/Ke
 bCSfd4wZCQ5hXR5pD0O3/33alJmDutcCYS62rLUG1B9infSUZFwnQuAyRBmpr9raDqgt
 D1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883285; x=1745488085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9z188USbMHEAsmOS9aZWv+1+Xr9xFEVLP0AvPR6hxw=;
 b=Es+qkBEnolSy7lrz6kWb8KQOjEzyN9oxnbGIq3kDkIU+skzcJlsXmuo15MoQUyfOx2
 jGeGrjwKkXsWw8aJOOaQs+/iTP6O+wA9tpmnPn/1Ph6+yLAiJfhlWFMg40EvrVauv3L1
 nlwjt8FgxXWR5uakPJ4yxmUSxitypnZftu/S1p8HdH2+A/N2GWdqbp8apz/C7gBdr+QF
 s8yKRs+Me71oZDzu79kye198HmgQPHIQEDbDJbL2OIPrV3zTi8jkSb0XG/C+xnAlHOZ/
 la/wMFQQBqDeTWNxoKVgzOBF8V6a/mS5Qi9qZ0TNXmq9LkvxYsV/21kqIdiX3JH74SEM
 liRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHLPyrXy6Z7Yq/0eOemaI+oD33rThZvSIwGwB9AWslCDsQxfgXd4jop1xb/HFprZ6mTP4MI9d2FOCN@nongnu.org
X-Gm-Message-State: AOJu0YwS07gt8U1kWmT9L6SIHBmhiYKqj3Ouqb4YYIopRtLcPuHYsAP5
 rh6MN4TSb5o+jpEmvrTMgPlOBdfNYWjkFHv3pSCyAmjahPVhmtlfDa+WJYeYk2ExOtTHvQM6y9Q
 y
X-Gm-Gg: ASbGncua72O5v0PtUHufOHcaSJM+83LBvr7tnU3F6PMVapapy/lGGl2/o2nAbsBLOkE
 EUD4gVtcSZO6M86HOUVAPdXJOSBH9Jz8Ym2b0BX3kLsOjJOxXpWOF/VDyl9VyZyyTgoJupH4Xuf
 YzZiYoklaGePXIB/ZbcWJ+lIB0NhfTEUcw4v9rdxJ/QsyuGJwOU6HKi4YRGYUamIRCy4/IXUmO0
 uI+lbpv0tvWozvp95nx/2ZyRgDDoIEe2Q5bUxZ3EfAWoI5HCk9k3HpcvD2HVLVgfoiRM4DBZado
 rI4F17bSRKvp764yLGQZGUv5wV5CkjrU9UuXC6E8sstjTuB+Lshhy7AAeA2XCcH0Sju+xKEm7Oq
 XR+MNoUVN
X-Google-Smtp-Source: AGHT+IHt9vr/9AnjE0csomAITnsz6FVhtEU8mP40NKpFr5Qug0e2c8ij9xvP9hEcIpUf7+PROvGrXQ==
X-Received: by 2002:a05:6000:18a7:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-39ee5bac4c1mr4112460f8f.44.1744883284881; 
 Thu, 17 Apr 2025 02:48:04 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c102sm19802614f8f.35.2025.04.17.02.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:48:04 -0700 (PDT)
Message-ID: <0e2832b7-e5c8-4e85-a816-f313a8290e34@linaro.org>
Date: Thu, 17 Apr 2025 11:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ui/vnc: Do not copy z_stream
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@daynix.com
References: <20250417-zlib-v1-0-34fad73b843b@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250417-zlib-v1-0-34fad73b843b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 17/4/25 11:41, Akihiko Odaki wrote:
> vnc_worker_thread_loop() copies z_stream stored in its local VncState to
> the persistent VncState, and the copied one is freed with deflateEnd()
> later. However, deflateEnd() refuses to operate with a copied z_stream
> and returns Z_STREAM_ERROR, leaking the allocated memory.
> 
> Avoid copying the zlib state to fix the memory leak.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (2):
>        ui/vnc: Introduce the VncWorker type
>        ui/vnc: Do not copy z_stream

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


