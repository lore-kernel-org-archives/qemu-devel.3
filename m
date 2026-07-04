Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D16C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg6KS-0007Jv-VK; Sat, 04 Jul 2026 15:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6KR-0007J9-Cq
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:47:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6KO-0000Ed-A9
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:47:05 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8454160043aso1581783b3a.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783194423; x=1783799223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfW/MWQ5OEHFOFus6Lt2Ftnka/RwbOJ2vEYeKxtAKzg=;
 b=bHLBaXSY8EiCGHE053p+8kWOb+W4zqVC7uk9iGslkpjczESrDxypzdRAwzjDnNhVuR
 kiBy1ZzfQiAcb8cfIlkTyROWynEJmcEMz2138rDByXRVFU3KQMvpYVGjDptvgfEOWwrS
 IJeJw1a33CFGso0U6D/YIFvph28uNiEvIH/lD7qKLQpFzlKXvsn4u1F3kkKw2Ek8w6zA
 wq3rXdo7dqUcoTUPt3tsOmivU15IBlX5HoZt3e8Va4F/WWgL62xk0gzCXuD13SbvmgYF
 f7qUTRu5LwAc5UuiLoP1fpQ1dRQD+kkQY/yj0IltBxdKghCKqWpN7eQ7W80eLku+60xb
 VoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783194423; x=1783799223;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfW/MWQ5OEHFOFus6Lt2Ftnka/RwbOJ2vEYeKxtAKzg=;
 b=XCo01t/LDqR1m6zd98MTKqc9RrGHah1D0hGQjf1jL30ZJOV0Fk3rsUnDe8RIEPwy0a
 EkmYzom56Qr1N6vxHkw8yBHLrC4NJ1kfa525LoJBF3+vx5D66R/LVpAObtEL7yYIkRSa
 2f/kBjXHbp1w1tkGxF/DEJdlVSePM4NTgCrkAqR5msXrbTpn94Z7B1Z3ZfVfVxhruZhQ
 SVR4IZuJUOoC1GjByYeZiodM7QaX2XqGnbnrC5ZyGe9d7W/OkxxYRpwWNBonOQVSxw70
 o49vbYPY/FtvAnOV85J4MY8wprGvGRbgguXJ94ODjwZ/evKvwujxwVnM1AcbvsZ3ESTV
 2x+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/QNRRb0sE0wB6qOSSx/XBx2UW87A8Jp53El+qiSGn/gGetLx9/cy4RUGzz7MSDgrfbuK3FF5hejfW@nongnu.org
X-Gm-Message-State: AOJu0Ywe2xgXTKnYVOK2vOoIWJ7oAV2beYkFBVMJ3tTSIfGOGE8fCrTG
 Pck1iy4HxK7VUDFdLG3Y6HB99a/pX2imJ/ETsWA2FtMDjJfk4PrwKIEp3gYTTEnB3gc=
X-Gm-Gg: AfdE7cnL7OC6vbazIk/Y/+/rp3C4DAXzW5IvU1zWxgyd1c2iu5fq6TuXVxejPgLfDY4
 +hYfu/CdsnLgXTuwgrMHhZd0Eq3ZxDDR2OznyrcQfFidr0w+siRNzkVwsAtnE6lIW3WfZf4wBwx
 udQ1dP1iP6g2yOY2maqCzfwGJQuepE0L28FBU+eBApVGM9vKvgT3XDo5LtP9geG/RWL0VRXMGnN
 CM+N3dtuIA5Np3qDBWlu2UktJ+lIeOUVaWMgept5VcJfL5jD32bdE+OZGPyEp3hucc2IeiCbBbm
 lA32q4hQce2/5C8OLyRUQ8Z6xn1aYc63+NxyBjSIyLA/q/VbWOjiwzch4iyer8/E2JnP42NtGYS
 N6oFqNz1cLq2vuch1pik0acpO6fZ2y0AkGlWBmwjFbEtcGa8mhR4ilJTTcJsTBrc5WO1h1NSgG1
 hJu65VnEEm6uYTXKLGjE7l+WF3UNWaR92uPUS2m2/GUGSabaIl1NdVaMg=
X-Received: by 2002:a05:6a21:62c7:b0:3bf:6c08:fb98 with SMTP id
 adf61e73a8af0-3c03e5ffb8emr4610035637.58.1783194422538; 
 Sat, 04 Jul 2026 12:47:02 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e91b07646sm3834125a12.16.2026.07.04.12.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 12:47:01 -0700 (PDT)
Message-ID: <181be226-2ee1-49e2-b03b-e268735ce83c@linaro.org>
Date: Sat, 4 Jul 2026 12:46:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/33] accel: Have each implementation return their
 AccelGdbConfig
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-15-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703163757.55500-15-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
> Hold the per-accelerator AccelGdbConfig in AccelState, set its
> single @sstep_flags field inAccelClass::init_machine handlers.
> 
> Remove theAccelClass::gdbstub_supported_sstep_flags() getter
> and inline the single accel_supported_gdbstub_sstep_flags() call
> in gdb_init_gdbserver_state().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/accel-ops.h   |  5 ++---
>   include/qemu/accel.h        |  8 --------
>   include/system/whpx-all.h   |  1 -
>   accel/accel-common.c        | 10 ----------
>   accel/hvf/hvf-all.c         |  8 ++------
>   accel/kvm/kvm-all.c         | 17 ++---------------
>   accel/tcg/tcg-all.c         | 27 +++++++++++----------------
>   accel/whpx/whpx-common.c    |  1 -
>   gdbstub/gdbstub.c           |  2 +-
>   target/arm/whpx/whpx-all.c  |  5 -----
>   target/i386/whpx/whpx-all.c |  7 ++-----
>   11 files changed, 20 insertions(+), 71 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

