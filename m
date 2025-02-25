Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B3FC18E7C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn18O-0004es-FY; Tue, 25 Feb 2025 15:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn185-0004cJ-O8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:02:12 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn182-0003Y4-Rr
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:02:08 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220e989edb6so166951165ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740513725; x=1741118525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w4jGV3D75YfX9XnMKOC/GiEryZiXIjZhXgsY+cWKjfc=;
 b=bpTEGIElPp+EyqUo/C6MSbM4hQB5I9hLjFFLsnEH4w2/Ln6Vow9D0nMzWxa+BH7ec/
 vdROyqLn3usM9YzcG/Wlc0tUMdrQS8LIt1sRqAS73sg48btlyQOxFQKcr97O3b7icxKE
 81oIt9ufxGFBG9QPcJ9SmfFcwRUozQMgkUXoYwBv73QROXCSW+rN91l/aWOebmkVPLTu
 /H45EEbtLC/XjMupvmG54hWRnypKB3zbSMLWJHK6vhXe6vKiORVGQIbZhho3pBZxfqhr
 ihxsb4wtlptVSQjBTjojIJcTH0Isr99dmdys0nF1LA8ZjvoTClD25aOhD0FWs99NacMC
 bYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740513725; x=1741118525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w4jGV3D75YfX9XnMKOC/GiEryZiXIjZhXgsY+cWKjfc=;
 b=CePJzxRoSKF2tUTS7h1BQLOY8qe+edQEBs0dKetwhEAVTQAnHU5VRCDaqbW+luC/hV
 468vw/3p+shnacd3GQaGtCrJrU+ujuuAMybiEWl28fcGjKTX+SNprB/9jj3ZmXOuDead
 tZt4mi+XSY7hmJ13qIfAtnXvYwG1a96KxeFNLksrLMPBEdh6FlfgU6DstJRyjyCi5asD
 3yrrcsGxm4RUw9iAu8FQ15ttH/8AECGrk/7Ja9j9DwUZ+k4ZwVo5ttVpcahKDS1lS1+k
 29iXTwNio5Ffjb2klnGtk/LpOb8gr4ABLNvJ+7nOOhSiiJ0taKhejqbnAPe4ipLdoqGJ
 81+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIkuvBQNi7poi4k4DW/MQ5DW8MqU/HDF6odt/uEHcESgqZfcu/0VKDpfjM/AKNPd1go5UntiqOFgEE@nongnu.org
X-Gm-Message-State: AOJu0YzobK+kUjGBQBCNGG4fs2MoXPWx+FFDZJonLFteyJOgfFTgV7RX
 D371DsEW4BQYW9HNit5GabyrZ28fOv30nrnmi2mPNjqBKjR3FSNyIJ/lRTR4pBs=
X-Gm-Gg: ASbGncvYXAzXKaL7vJme53fHULoaflnoQ4/rsz0rbTGfSwAE70mtlXjI5XSco4nYAxP
 jvPf686zyk2Wqh9+bK1SzfdyS8XrFLgpyidRIRHD5HiuIazLgVa4bZ2ZQcxByWhwMxbqT493E8M
 Tz4Py4XzWZULD0N2tqj7HveM221qzcz5MXq7SmL/fAgcPejexuPCD+u0gLxfHXH1SJKlpUWht28
 kYHYj0BhTgBAxvcDg8QylFJZKeFiZDKk5PfchCGL2Frv6J/A/Dh2DS7IW/IS+629ltQ1WBHQMEy
 IcPyH2U0Nb5OvUAYQjDxkm64BKDku9SpHo04gQgxTR69Rm3PmsBMyL+fLk6fvpMKBSAeIZXpvpf
 89F3BL1Y=
X-Google-Smtp-Source: AGHT+IFLd+Rw+Z6BXvNUh/y9/vlXCFq6mSfOACpG5hC1wd+S88OsW6PPTM/BKOj7PVNJsTtFyav9YA==
X-Received: by 2002:a17:903:94b:b0:221:331:1d4e with SMTP id
 d9443c01a7336-22307b32c67mr69441175ad.7.1740513724946; 
 Tue, 25 Feb 2025 12:02:04 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a00ac23sm18364645ad.81.2025.02.25.12.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:02:04 -0800 (PST)
Message-ID: <c7c2d873-3ea7-41a5-8842-1ebf33b5a560@linaro.org>
Date: Tue, 25 Feb 2025 12:02:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tcg:tlb: use tcg_debug_assert() in
 assert_cpu_is_self()
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225184628.3590671-5-alex.bennee@linaro.org>
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

On 2/25/25 10:46, Alex Bennée wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> that will enable assert_cpu_is_self when QEMU is configured with
>     --enable-debug
> without need for manual patching DEBUG_TLB_GATE define.
> 
> Need to manually path DEBUG_TLB_GATE define to enable assert,
> let regression caused by [1] creep in unnoticed.
> 
> 1) 30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flushing")
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20250207162048.1890669-5-imammedo@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/cputlb.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index fc16a576f0..65b04b1055 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -73,11 +73,8 @@
>       } \
>   } while (0)
>   
> -#define assert_cpu_is_self(cpu) do {                              \
> -        if (DEBUG_TLB_GATE) {                                     \
> -            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
> -        }                                                         \
> -    } while (0)
> +#define assert_cpu_is_self(cpu)                             \
> +    tcg_debug_assert(!(cpu)->created || qemu_cpu_is_self(cpu))

I think this check is just wrong or incomplete.

The intent here is to check that we're not attempting to modify the softmmu tlb 
asynchronously while a cpu is running.

(0) A synchronous flush to the current cpu is (obviously?) ok.
(1) A flush to a cpu that is not yet created is (or should be) a no-op.

Not checked here are any of the other reasons a flush might be ok:

(2) The system as a whole is stopped, on the way in from migration/vmload.
(3) The cpu is offline, on the way in from poweroff/reset.

If we decide that {1, 2, 3} are too complicated to check, then perhaps the solution to 
queue flushes to the cpu's workqueue is the appropriate solution.  But so far all I see is 
that we have an incomplete check, and no ready explanation for why that check can't be 
improved.


r~

