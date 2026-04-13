Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4228E9380B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 02:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC7Fm-0004gO-1B; Sun, 12 Apr 2026 22:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7Fk-0004fQ-L5
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 22:42:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC7Fi-0003ny-SM
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 22:42:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso17846705ad.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 19:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776048137; x=1776652937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VtC7wLtD2z/N/B3RGXLA8q4qYbR4arCwIYuTZlXfiw8=;
 b=MWCGWWWu5AxlqekOf62ZXkcN5FsErEy+uwre8piRcVW69lo38JHsZJ5VKnH5i9QaU1
 PF57pXlwoYKsux9UFOItA771RRYX8RfjnhMK7NNyN3RzPZmHeONDI1dVLVXdX9LecawL
 UO2iQWDHZQ9RZnDad1w7rEOe72RWLSOlozZLgkYuYFKA4Tw/Zc+KLUKfZn0Py8dinJUe
 cB1QINTaMpriXgvXi+dMxjg+0Jmuua8Z8m59YmYmvDJYG6QCE2qcYre2n7i8tWrSGjYS
 7hw4wIvJgDTMEXYL7fUmWBBKkGW5qsEH2p+XIY+gHeOnyY66ZHLu/c91w3ETonWCgxA5
 bvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776048137; x=1776652937;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VtC7wLtD2z/N/B3RGXLA8q4qYbR4arCwIYuTZlXfiw8=;
 b=nDwA33y2pvjTXyPhpgg8AcoEFl6Hz+astzd+4Ad/19ymog6r8s4ZmIXUKtavAktCM+
 XVV6G2yfGHJDmQi6O5QlBgEJwl99pP02ias7uT/XSaWyZSdjAKzGQ8On7c6QSAj8KsrD
 wUknZ+5yGpBWFqj9+DFqWrYnzyu6Yl1iyqcH8FRkPnveqsSHoxqDGA4+RCVjWGDdaNgV
 2qoGBjJyMYYfrAm4GK8hzw3laiC/gZ7yim0Ljt1JFiZL9PB1yAx4VV+f3HALdgw8g4Bp
 FPQOf6F7PLxRejf0Lko8MdSFU2lJL+qD1tp7BzSbpfpu4WUMllrpFYy0eRVDapW4ek1x
 bZqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/F+tdDUdHR/IUl5bJ+N7i2mxolBRf6XMszI6HsCcN1tVU2vh09cH6yPzSs930cg35/kSQhQshkCqIk@nongnu.org
X-Gm-Message-State: AOJu0YxHv5asBpcIJGrOKahFXjgakjujm46YAqcRE7slqllXpC+19b1z
 PVj5Mi5Bk9AtObARhIx0U2nQK2VbQDJRFspxQScUso/9IiI9HVuCUAzTuygmK71F4oE=
X-Gm-Gg: AeBDiesex8IAEx2KUgAou7zd2Ran/pzLvqR9r3C46/mqOUNGZ0KMAC9SGpcm00MD5U/
 Z4yP3+dttN+O4l1ea6H6ivfFZQ3nIXTTof4W195bT5RyNU9ABQPM5/2mLf6a/jjaOSok/pQgKfH
 o8IRVTF+hY76QoGwljcHKAmvxfDr59JzVcQZJLoEi19W2IP7t2FmKFbWNXlSWxpXl4r2PvhBUCM
 qr23RCt2hmhKMjNVnmMiBZ6vMopmtFu2VIof54Xzhi3ji+mtbWNmLABgA6XNPAXFi51ZFV73kka
 ZfsMmfsmII1UM7j6FXYTIpbV9R1EXqVH0w6XxjxfnbZ8GuTtxEW0Yh5OyMZM+MbmUEV5f57dAHa
 GxTz0CKMpa3VId7JosslbH9ufCh9gJcOkrU5VomG2UmQ0x1OL8whFM3rVDZlv/Xnrym0KDYQjhf
 Qlf56vFkClUUxlp32HEE9bDtuQ3zKrqYpvNjsFUk/RV4cckOLKe9ytqcu3U7pG2y/YOUaOEtgVv
 v+nfyqD7QN+dw==
X-Received: by 2002:a17:903:2c07:b0:2b2:4fc1:f657 with SMTP id
 d9443c01a7336-2b2d5941193mr110907025ad.6.1776048136836; 
 Sun, 12 Apr 2026 19:42:16 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b45f192203sm13209245ad.23.2026.04.12.19.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 19:42:16 -0700 (PDT)
Message-ID: <9d6a644b-5aaf-4ecc-b529-85f8884ad548@linaro.org>
Date: Mon, 13 Apr 2026 12:42:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/27] monitor: Have MonitorDef::get_value() always
 return int64_t type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> Simplify MonitorDef::get_value() handler by having it always
> return a int64_t type. Truncate to 32-bit in the single caller.
> 
> Note, this handler is only implemented once for the x86 targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/monitor/hmp-target.h | 6 +-----
>   monitor/hmp-target.c         | 4 +++-
>   target/i386/monitor.c        | 4 ++--
>   3 files changed, 6 insertions(+), 8 deletions(-)

Given there's only one use, we could just define that the hook itself extends.

> +static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> +                              int offset)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       return env->eip + env->segs[R_CS].base;

     ret = env->eip + env->segs[R_CS].base;
     if (!(env->hflags & HF_CS64_MASK)) {
         ret = (int32_t)ret;
     }

The test will always be true for i386, but will also apply when the cpu is in 32-bit or 
16-bit mode.


r~

