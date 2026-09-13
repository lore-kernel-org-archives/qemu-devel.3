Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C1FC88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBV-0005Me-3i; Sat, 12 Sep 2026 22:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBP-0004ek-KV
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:07 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBN-00021X-OK
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:07 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b350c6920so634070a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267384; x=1789872184; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L0/J4rpG81dFsTAdAA7Mb59J1+MdiBpL1WMMuIA1E08=;
 b=UTSM74CUa4dfUfvPTD1/UkaHcPJe+A7Jc9TscdYQp+hw5hdu9XiwsL+ck2JQLiArnt
 mpQAxl38J44OBoPAPJUutF27n26+srge8mc1KZULzUVp2rfamdfGsY+fypTFJuiKiS6V
 Pi0en/AAZXxpo7c1XnxuZ4tnCQ1delYJqZPAIi+HXxO4SQFG+jyRjxmbGRNPvxzi0TDK
 fGqFxMa5JR4JerA3FBGs0ZGW+/9iJGgVKkVZbkV+ygPW8f8v0Nb5NlHdS3xEThI7f3Qb
 VmaqbPdrdneeTbj+YrAMFFOAANAx97rF0Wl7IElomtTr373JNzLVDpqyC68a3FNgOTBS
 jYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267384; x=1789872184;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L0/J4rpG81dFsTAdAA7Mb59J1+MdiBpL1WMMuIA1E08=;
 b=Kj0pBGTkFTQNiGFnJmFDj5b/22e8XIKQQCK+caRHoekn6osmw2FSUVavlMw2yrgU6V
 ACC79TsTB0AxwHlJqqXlb2wiwGeBlmk+UkKPtb35NmGhxYPbl63j2FRmOUWs7w3rw49+
 RPcAGqN695FTOZCfZ5F6WZbCvA9cyY+7yX2LoPp12883d7f33TCkZIosbiAIYSolGspd
 HqsMHQdWIpFYGQUYWNDdyufwn2nzDl5PM0fyxHEWBR1ss6SY8FWsdTywfOdxNHS/Nh1L
 vsmmzq+NjRGPCEZKMG5BBaaErWNvQRT7Z97e0SvWymVFHfHftobiNkR5XxkaOhx/Jx9V
 aOoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDrn3uYNfUo28C8tVbd63Cf2A25XIXyFIMlyaEBUoY+0AgNyV//wmYUkFshHrB3vZYj8Y2Rfl6NnEp@nongnu.org
X-Gm-Message-State: AFuF++lN58MzJRTd56Y2Na8m4/SYvyO3Dm//sioX3ZigFGu/6Ot9yJIN
 Don8tBRVcbiYcrBGVOb+qwuGZYhbitCPaDSESxhKaoqMbOe/I+VoHaP41cNQlm1hdvg=
X-Gm-Gg: AYBFou2zmQi6JgcUW4KBhbEyb0oP9Yuyyk7fN7N1bY9QfA4fy1Yf5aGaVqDBMJMCybN
 lDrmZXB+BZYAbu96GZpa2JulEaYT0xoggLq1ef+HI3OJh4BGSYMsLZ1FBCJG+MZTcTt3mFxAk9Z
 SnpfbbFMiSn0RvrHwjNUbnEdii1r2MUgk2HHg0jnHQeJdslDP5MEWh+rQyXAmhtyP6J0Vb/OdjX
 kdtwA9PsI3I4/5Y+oNX/iajmf1ti9v1Uvdjh3xMtXCrMndC40QpZjRqTx7iM/r5Zmhp4gdtZRa+
 tApRrE4IdMouD6jLivrEAZjAoz3ZxPhc2l1q1vyQFXWH/d2ILcEn9r/ccLfsDTYk5zRKF87DTWi
 kNg/3xbav4Q2wH24HD2o3sScBm+ct6lcTjy6xFmcxDiZbeL6TMY0zFg6xsYhwUr2Ro6UcBfXHf7
 WJUQ8aJMqBsnBnGCBHOlLk6L+ea2htX6PNkiY3SPYZPSDTUQ0MCNKQxmaj/xtDJN/4Uu/FYxlgQ
 cNMjwChx2j1OL41kGlVPv2RmWsUhzHNCpvHeBxqEdToiG1PPuxfjk3DrbNAaQ==
X-Received: by 2002:a17:90b:2242:b0:398:9beb:5c19 with SMTP id
 98e67ed59e1d1-39dbc6e3f15mr9150282a91.20.1789267384256; 
 Sat, 12 Sep 2026 19:43:04 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:bf2d:a6f5:e308:cd27?
 ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b78d59sm15332612c88.8.2026.09.12.19.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 19:43:03 -0700 (PDT)
Message-ID: <8ae886e5-5841-42e1-a4b8-dc0c103ca860@linaro.org>
Date: Sat, 12 Sep 2026 16:43:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] target/s390x: Restrict interrupt handlers to
 system mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260902152044.31291-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/2/26 05:20, Philippe Mathieu-Daudé wrote:
> Move s390_cpu_do_interrupt() and s390_cpu_exec_interrupt()
> declarations from system/user shared header to system-mode-only
> section, removing the unused user-mode stub.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/s390x/s390x-internal.h  | 5 ++---
>   target/s390x/tcg/excp_helper.c | 5 -----
>   2 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

