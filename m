Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADADE88D72
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8nz8-00064f-IA; Fri, 03 Apr 2026 19:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nz1-00062B-Rv
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:31:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nz0-0001TH-Ca
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:31:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b258d93ffeso13307905ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 16:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775259080; x=1775863880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XnhnP97gNK5KIpx3GrbpwH4iMFaGjQJ+XzZrlSps20c=;
 b=lx/Eaxtnl6/hm2epiGiKEVGuROJaE6IIOHwFvqdzZ6kIbKP0jz7QTXvXrthKXuc+MU
 EMmn+ZCGKlXqGMwn3obuEokXyIx/hc9UnPI71yOTR+yPKh1GfUk8cQXH4oa5qxCU82eL
 SpVlEmRUnP8VUAVdpMuRuUUqZRt3+quiVuBd67SOCVgmwj/2/JeP/EZmDqIVphvmkhPh
 mx3Q5MGFc+y6X4KV0yf60vy3nzkYN/zkIiwszECvhyRXmBiS6i7xhBC/cbw8XDFiZSpe
 npjTOowHE9HWoHDo5sFaabssWwj5QxoDvUsRTLteMlG31sjwCL17K04hSzVQWDQRlFps
 taOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775259080; x=1775863880;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XnhnP97gNK5KIpx3GrbpwH4iMFaGjQJ+XzZrlSps20c=;
 b=YY9LHSiRlo26KU5S+y65QXbg7rH8mCw6Kla4yeETd4YBajxdR0VV3dvsqPRrmG4CUt
 p77JcZB+RY3yF/zQ/POxzE7mg3Xp211XQ8ehRc9BbF63vDtCYzZO7HcHNIAixA1i349p
 fMvGnJ2VcbrG5eLxgcu1jd2ymIrA+sLksQFVhgDjV1TVgMPevlsQJwaYMpNUAR8Pk7O8
 MTi9bATytom9f90gH/egUl69qqD9KLcEHyBB8CmF4a6Kl/YKBxCsqzutSivmOf4qRpIn
 3vbotex7+ylveFbS7rNQ80uR/gtHOF5YK5LhrWtoubzqFIlysDI4A0/ZIH+BCYeR35F1
 j4Zw==
X-Gm-Message-State: AOJu0YyR79qXmw8+cE11aIBlFz7BucmQGhYO63MqtDDdZFcWvvYw3iYJ
 9u/giGW2eu3/f/jfflRRk+SDT+jhy4AXJ+HCKgMQOFqkqp6tKtbRch6AQPx05PbGUSuVKjlKTAW
 qWtylJ+A=
X-Gm-Gg: AeBDieskt6ycLPtImChIcYt7f1RLL/a1/WxQutA1xL4ETx7SbtDv7jRaTgKR7pp7lLi
 H/mUwjXif34PpxL8VrSWG1lOcopAExuAw/aBiNf/8tUAwOcufCuQI0hgzllrlGTU4z2OtgpwQ7K
 l8r7XRfjdfyLqN4wiHv3RVngK+fFUkvCrrnWzAfAybT6t8J0lzlQEquplMqUmwHWmhk9sx+gIFT
 4/8h4VGgXvLYPbR+NZDI/5cJiHjzZpAy0YmgGGCnRZCr/sTSbyI3IPfRZDSlG2Q5w9ni8VXQ+Gj
 6CbqSZeeiL8MFsagQKb1HJIY7mErP1205eJMOBpKPM2lrrZpjiRIfgNbCYkyjEgbNY3s5oNFCNX
 fJ+ZTGPjzU5s9CLgVbOcNTwUsvhY9MhN0EOKdoInPbvD3OJo1ndUJDrFVnqf3+KeOELSWbGyNLI
 6teQHjoXI/DbttFIxVXHXZQgetXzee+078r/YKNVaSg82tuWt/WObo93UpX6ly22K1uxo=
X-Received: by 2002:a17:903:1aae:b0:2b0:4a57:e480 with SMTP id
 d9443c01a7336-2b2817da2c3mr48557375ad.45.1775259080270; 
 Fri, 03 Apr 2026 16:31:20 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979530sm66640365ad.46.2026.04.03.16.31.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 16:31:19 -0700 (PDT)
Message-ID: <c83d8f95-885a-4f26-ac4e-4ebf281eb263@linaro.org>
Date: Sat, 4 Apr 2026 09:31:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 4/6] qom: Declare compat properties API in
 'qom/compat-properties.h'
To: qemu-devel@nongnu.org
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-5-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260403104327.1163942-5-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/3/26 20:43, Michael Tokarev wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> While most of QEMU files use the QOM concept, few of them
> use the compatibility properties API (mostly use in system
> emulation). Move its prototype to a new "qom/compat-properties.h"
> header, keeping "qom/object.h" for generic QOM.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Michael Tokarev<mjt@tls.msk.ru>
> ---
>   accel/accel-system.c            | 1 +
>   backends/hostmem.c              | 1 +
>   hw/core/machine.c               | 1 +
>   hw/core/qdev-properties.c       | 1 +
>   hw/core/qdev.c                  | 1 +
>   hw/i386/pc_q35.c                | 1 +
>   include/qom/compat-properties.h | 8 ++++++++
>   include/qom/object.h            | 8 --------
>   system/rtc.c                    | 1 +
>   system/vl.c                     | 1 +
>   target/i386/sev.c               | 1 +
>   ui/vdagent.c                    | 1 +
>   12 files changed, 18 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

