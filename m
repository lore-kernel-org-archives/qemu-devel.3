Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F22C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 14:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKO4-00014n-TB; Mon, 14 Jul 2025 10:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubIqd-0008Ue-8f
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:03:59 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubIqY-0004qU-D6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:03:59 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-41b1ca1f28cso127782b6e.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498233; x=1753103033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EiqAn49S8CY/KaPMB72o/KuCRfolChglBttyObH9PGQ=;
 b=gJxbR0rk9vTBOq8O7K9+GA8lpe3q16QoHuHgtK0eFl5eBkQM2eTIj2lwo/Pkpek5ZX
 2NF7evgIAuYGbsClwFPj4usvoER4NdHk0xh8vM6dFg2quzlIClWvuEgWar/KKS5/CgSg
 figMfkEqYHRPXmz407O/pdJ2RZAs/Ahy2ZPEwUYOp3GuZY4LgTGnsLp/HTHbiFvTAJpx
 DhPuDmowkvumkp8YOYyb0ZH06eJfhl1iJUZ4u/CVlnQNBhrlYGrL4uq5diuAJJRxosCM
 stWKmkL4/Rrry4H7nX4+ZQc5O7gBzhoGfpg5aIekOjfzyN3RAbmEMvqBUaoaYa6lYXp3
 7yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498233; x=1753103033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EiqAn49S8CY/KaPMB72o/KuCRfolChglBttyObH9PGQ=;
 b=jFNwDYiZjPiQlk5coJvOXIGk43hTW5zIyjEv3L5K+8aFlSRiZNFslPM9yK1hZD+9xf
 JKO4cpuiXE7A58rb7vyLLWH3NO+jNshe3qOWm79eWD/5a+QLDZGiDUaOOsm+Dv3BGhJF
 uwIFM7l5erYzjnI3CNVQRoffEG/VCDeVJ1+VnASjJ5N+fiD9LQYN6tDPiy+jQv8FzUmV
 Fu2191wdUP0e7Lit0XKwDsPX3zArmcvw2S5KRlBv9qko7kmR4deop5nTGqC31jZvmbSm
 MP7n9kKr8ni11RgXuWtTu7uHNyU+NK6N4uvGOcYfJJTxMGQTuimSbTZR0kARJQlueg30
 hkMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZgg8eU6Xn5YtIEIsl6NOvTNHrzHJkM9QQfml86aJBsUvc33evSPeKzvZAzzwB5R/+Jy3T0BhHKa+j@nongnu.org
X-Gm-Message-State: AOJu0Yza5lJ1gSug60hVOuXgNRhJUTBNK7/8KDtVa022kDg4YUGP2DTz
 w9JYsg9COhRdMrBMoWD3YT9i/u0qvQS2ebWV4xeBvVe5nE2nyXSBEe9hyRpi8fHgqx8=
X-Gm-Gg: ASbGncsAENxOwI/mqgb5Kv/Fc0PFuMgZJCaozdwHNifqyol/rYIU/cNrijOIWaJ/22p
 xAcf2Rc2vtBiBqYqIiDO8iuT1GDGljaW09axh7CLbVuPBtcAYhuHIXBy9JC5KJQMwCdeY1Q3xxm
 ktZ0q8S57f8WwUE9tw4avCVmKx6+XcWPylFxWh646NOhHHJSda1WEX1mXg3oeZnjIyark+wzzMv
 gyUweF36QDbzkF9NZvBFa+tjJ3jYp/NN00Z6JnEzJtZSFW+DXZRZgI03N0RRnrEfsBJAij2rHCW
 TNknAoa7NxK84Nn1ALzU5H0N+Ps96+/nj1kABRf4FirTkeH+Wi2gdQtyUuvwMuHQjISXAGd5D9L
 NDutCMYwHJIf7Rvxw2SGN8Jp8PPBLyJIubWb0JAS6mLHnXMl+18xitXl1CHPg2sKjC6+CALnkWa
 cU
X-Google-Smtp-Source: AGHT+IHYAmPOK16UUreRJp4bqWWVOjer7+yvaIi1YAYAsn8Ew7u04Fnm6nNi8gsW8jr3u1YM1Ux8hw==
X-Received: by 2002:a05:6808:2016:b0:40a:52f5:f2ad with SMTP id
 5614622812f47-4153737a03cmr9313531b6e.8.1752498232656; 
 Mon, 14 Jul 2025 06:03:52 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41419baa665sm1525064b6e.21.2025.07.14.06.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 06:03:52 -0700 (PDT)
Message-ID: <19cf4296-7abd-4405-a49d-06eb868e3886@linaro.org>
Date: Mon, 14 Jul 2025 07:03:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Assign the GDB register XML files of Sparc64 to
 Sparc32plus.
To: unisono@quyllur.org, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, atar4qemu@gmail.com, laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk, philmd@linaro.org
References: <20250711155141.62916-1-unisono@quyllur.org>
 <20250711155141.62916-4-unisono@quyllur.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250711155141.62916-4-unisono@quyllur.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 7/11/25 09:51, unisono@quyllur.org wrote:
> From: Rot127 <unisono@quyllur.org>
> 
> Commit 3/3
> 
> Signed-off-by: Rot127 <unisono@quyllur.org>
> ---
>   configs/targets/sparc32plus-linux-user.mak | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
> index 7a16934fd1..0d9cf44652 100644
> --- a/configs/targets/sparc32plus-linux-user.mak
> +++ b/configs/targets/sparc32plus-linux-user.mak
> @@ -5,4 +5,5 @@ TARGET_ABI_DIR=sparc
>   TARGET_SYSTBL_ABI=common,32
>   TARGET_SYSTBL=syscall.tbl
>   TARGET_BIG_ENDIAN=y
> +TARGET_XML_FILES=gdb-xml/sparc64-core.xml
>   TARGET_LONG_BITS=64

This isn't used, because the ifdefs in sparc_cpu_class_init are wrong.

r~

