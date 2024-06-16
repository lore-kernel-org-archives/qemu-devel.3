Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DD6C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 18:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIujq-0004Rq-KF; Sun, 16 Jun 2024 14:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIujp-0004RE-1k
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:36:25 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIujn-0004Iy-Dg
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:36:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70601bcfddcso275920b3a.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718562982; x=1719167782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=waI3WE09vh9QpQ8foEBWjcGa4i8IQHbzyXLqb7YYH4E=;
 b=Plf9lmllBkyHNpieRRefVpm3mzI2BRnK8ClWwjlIZAy/EJsy6HByZhp4iKthRXhERe
 xRZwXLYNr40S9j4xvEf7X0r5n3dBiJTEtyeEYpE5CYo30aQ5m0cG0SVAflK37WgFSin5
 EIFw0JIuQHUcz2GLCzxqnIpG7a4PSKX+bSkVumvHpeiB2yTEDSNYWDQkxK00o+WMgDll
 V4uNGkCE4jyEa5/QZZMHnHWciusxoAVcn/pDbxdOSyBBHfHx42bgbhLAaMsSPOLhJDP9
 Mi7Eh73ypNZfur4K+Gg/NS/STKBG/BbA1+IG2tXQuf4WA3koYYmw53ysvgnf1pvCgYrK
 JG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718562982; x=1719167782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=waI3WE09vh9QpQ8foEBWjcGa4i8IQHbzyXLqb7YYH4E=;
 b=CVuLGJl5C/H5YUE35OFlpNsqrGlShZZryxm7c5WF+/iX+Rmf4xApCsZBniWO3t1WCm
 yMjHWrhGOYJ4mhaHsKBUHZcGdRnXjOo4E37kykzYQoJ/RY3nUQUb9IMJOYiyEX4dOIVk
 v4gYEcWEebmMQRSeLsXWLSCCzCRvAF79Lj5dHosvUbdu7g4BhAv4LyDNV9LpZMweCRJZ
 Fs0e9iwpCRe2lYDhS3cksLF81ywBUwmMetQmM8R0kwDRlpR79v+nga4h1FP1g3raZyWJ
 BxhH9MpGtfxIuKfqgsGBYBM6q1OZLchRToDnBoyW3LkSgMP7Q5usuGC6SmY1lQ2FXbpj
 vhjg==
X-Gm-Message-State: AOJu0Yz9HYTNCbjkYc+Kt7e6/59Er8p4mE4ZEqYQ2w+joRvf2i4ysfOF
 wG7pXwc6exVBKPuX88yp8Onm5tkYC+76oVJzCix+/o/ZwZqR1JSfO622BWTWwf8=
X-Google-Smtp-Source: AGHT+IGd6nkBFQY9g51IvVEUunHjpUkwh6fNrfNArBos7lPuwmsaZGxlqdmIYYRTIUEOgkQhbRj66Q==
X-Received: by 2002:a62:b50c:0:b0:704:24fb:11c6 with SMTP id
 d2e1a72fcca58-705d715b493mr7982362b3a.12.1718562981701; 
 Sun, 16 Jun 2024 11:36:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc927a33sm6215142b3a.40.2024.06.16.11.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 11:36:21 -0700 (PDT)
Message-ID: <8cf1327d-c841-4bde-869b-12ec5dc6beb5@linaro.org>
Date: Sun, 16 Jun 2024 11:36:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Make TARGET_NR_setgroups affect only the
 current thread
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240614154710.1078766-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240614154710.1078766-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/14/24 08:46, Ilya Leoshkevich wrote:
> Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
> calling thread, and not the entire process. Therefore, implement it
> using a syscall, and not a libc call.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> 
> v1:https://patchew.org/QEMU/20240131001851.15932-1-iii@linux.ibm.com/
> v1 -> v2: Rebase, add Philippe's R-b.
> 
>   linux-user/syscall.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued.


r~

