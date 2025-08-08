Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F72C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUWS-0001gO-KC; Fri, 08 Aug 2025 17:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUWR-0001fx-9q
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:21:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUWP-0008Gh-NF
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:21:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so15707985e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754688064; x=1755292864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a7hWASVeuLPuBjF8NDJUu0dnW3MNKBfRrk3TUZDnk6A=;
 b=gC974QjBsE5KR+VFYCZfjCmq+0ZeJmbPqU++2iQKt4LpBFFeFNbqEQTEEF9tn8OxC9
 jubYmyb9zgAGDok5k5NzCYDBzd3DO19II169C9LFW8sMO7PQWqkjvWo2wSl9XYeUYnUH
 IBZBiCQPcuv7ZkMaBy1Tegwjn0+4hVbectdZbFx+aFgbrdTm9FvJh0fErGDSijSKaicz
 hYp7dJnP4g2bOY2SXWiWzkZJ8Tz3FlCJs5AIf59p7c0NdqMpIEcw+BSI/NybezahQz4q
 Qb2y4NVijLwE+28Vwr/mBeHqIdBRWxv+OQZaDzlUhlQJmyztG04+VVOmpZ6+fYUh1K32
 +8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754688064; x=1755292864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a7hWASVeuLPuBjF8NDJUu0dnW3MNKBfRrk3TUZDnk6A=;
 b=W4mb+lK/zqfk0VzmyaucuDdw7xPevx4eaTsRT6nhjDF1eXJQKKWPsB2GmrClF2p1Af
 iOBmgxfGtriw1JtIOa9n1Ab66H5Oa3IHUEcdEL7FyarB8xPD/UQKH/kMGPCH/TynojSm
 qjuYEem7aMXSkIaxNGWaHbptkolcbNdePbKZwaoKcpnM9bP+5SK4CFZHpq5vRbTmOvpp
 357Xjykng6gZEy+ykieYxcBwI3NttWuPSK70lAGbamCd5E07BNFnfhT7uejaI26K4r/b
 zYMGiHQ7Jbs9A2AgiNzr3/DxbiwrlfE83Ko23SJLy24saPJDInVD7HkyGn6+8Nj5KsD+
 b27Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAR+an7dUo8+dBNS4bpi5ahUIj8jtFSxwhxWH2MrmTjX2lrasWWCxRlNe3K6oPkQjoZPGWzbQCbTyo@nongnu.org
X-Gm-Message-State: AOJu0Yw53oN0ZOF2FyJ68lQXBTtnurS7dqBiQobwNmQJT7szYu7nbfrb
 DCeIGlQfmOUr/tU6YXmDvG8JpzkeDPo6OIHa+WsRgCtiLiT3Hby6K+gJHgiWqWqf/nmOR/sb5VO
 qRpNO
X-Gm-Gg: ASbGncvdnB+eINmUyh1av1S/dNVu6pV6GPaOXi0NwwRGv/SuuP5aIfuoVzdWD0uSHPR
 cYc3+p/LPeKlTyazqYRsM3Ewehu/BffPLPY+5WuXKVnaLOFxnD7n1v/0DTiXBI+sFK1SWyP9ScM
 cVIaQ0++DzNHGLlfjedRNEh5iLha0LENjao4z1M/T+xiOkU3p9ZdLQ21+2pg9wnQCBYO3uo/3vH
 q33KjjtGbLqDDPqtc0PlOJ0Uu7D90S6DUAaU4wlbYtx9KxpD9l/Z3bMJgfESEir2rVwyGEx7KXx
 PjTczieKnnMCpwrQUl7tmYiCjxKDUz4QMj8Sh0QYafUhypeVxeq7ewAaVJ16Xt8RNwwDuX5+ijM
 /HG/Z6fbWwSLpsx8828A3GHb9ZySPfEcYwgZChe3KGDqaw0SF5kEYJ7Ngi3vfPtbutA==
X-Google-Smtp-Source: AGHT+IEt4YVUWwFgyIzhdn5IbgXOq6MpXuk1ycqNDSbqohoyP2LWKqeQhzVLhX2Un94Kouh9YIsSHg==
X-Received: by 2002:a05:600c:1912:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-459f4eb1a07mr40401175e9.12.1754688064043; 
 Fri, 08 Aug 2025 14:21:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459db3048bdsm242603625e9.29.2025.08.08.14.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:21:03 -0700 (PDT)
Message-ID: <42480805-2aa0-456b-8b19-bf9b4265da06@linaro.org>
Date: Fri, 8 Aug 2025 23:21:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] tcg/user: do not set exit_request gratuitously
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, richard.henderson@linaro.org, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-8-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808185905.62776-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 8/8/25 20:59, Paolo Bonzini wrote:
> User-mode emulation correctly uses cpu_exit() whenever it needs to go
> all the way out of the cpu exec loop.  It never uses qemu_cpu_kick();
> therefore, there is no need for tcg_kick_vcpu_thread() to set
> cpu->exit_request again.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/tcg/cpu-exec.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 1a973596d87..b9da2e3770e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -750,6 +750,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>   
>   void tcg_kick_vcpu_thread(CPUState *cpu)
>   {
> +#ifdef CONFIG_SYSTEM
>       /*
>        * Ensure cpu_exec will see the reason why the exit request was set.
>        * FIXME: this is not always needed.  Other accelerators instead
> @@ -757,6 +758,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
>        * CPU thread; see kvm_arch_pre_run() for example.
>        */
>       qatomic_store_release(&cpu->exit_request, 1);
> +#endif
>   
>       /* Ensure cpu_exec will see the exit request after TCG has exited.  */
>       qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);

What about cpu_handle_interrupt()?

