Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439EEC98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAB1o-00042p-2R; Fri, 25 Sep 2026 14:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAB1k-00042X-Hl
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 14:52:08 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAB1j-0005rC-3I
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 14:52:08 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bec20a6fso389795a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790362326; x=1790967126; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a63BQxOTv38gXPQxH43AV5/ZEUdcU2uyUGXC6HBrzBo=;
 b=SN5WX2XsTG4IPUgIdZtJHmSXlG8nMUAqCWYsCQPqagvAJOHqijsHCCXFQ5nXzPTJph
 5mUaCUXeH7YTHYiY0kdu1GiFCbINr8o2tZMo6wAQHtpO1GAuwfXyBYLtegsTXEls+daf
 rFV00fSxiYoLSkIVzmWsp0DX8ETHVDnsxeOCkFQr5CJjjzuLO5VOWT7lOse3V1MfrAE5
 V5cC/5BrPH/QLquBwW2Wx1MMMp7ODF572/15B8GMHRyKiZvoWemzOeKXySE6Ro72MMsa
 OYsQmUlb3t4neGy6WW9Ms+HLdGGaw6p5VS/qwJpoG/5Xh6s7Io9uF0ShfC9BoPVQOsgW
 4iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790362326; x=1790967126;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a63BQxOTv38gXPQxH43AV5/ZEUdcU2uyUGXC6HBrzBo=;
 b=HdyGL29o80rucozLAOAfDC6GzPOPcvw6k91QjERLfv5QGM3dohhZpfgSV5yWa3aL6Q
 1C+oYOAdei7WmH3FyGS6/2+2MX6svLfec28SV6Ah2GyHxLWmC8+BUEtqflS5wqdnBuMt
 kTJ6drAShjzbOXR/Vb8aiXRyiycrDnvbj5u6dccYEy250LUfphfwHC9ocoLjjcu01sPF
 Zy9isHUOC7w4qkpCgZCJsYGS+lebRX/IHIyISsGRQMe17TsGtDY5gY+0k5xv/1PXQiYD
 we9LwjZSpMs5kDJwt6PX02/SkF+deV+4EtWEw7EIOJt5N+kpC1/sk5tcTolKylgqpASM
 W/Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP5tauxEDAJrehA5yrwL3mGy7Ba9/7tLu3j9L688MtB1II5viJzT0F6CQxUXX657iS2GvxBLER8ZzL@nongnu.org
X-Gm-Message-State: AFuF++nxfJYQWgt6+hNpD0CJWwCVGU3cJ8lPFR83Lxq3KeVnl+YrTXTP
 j4qvNgvzgg0CjLqnF+rv8abieGBRoB6WmiWo2iOk/kK5ZC4TMboluiRhnHf80yCKeT0=
X-Gm-Gg: AYBFou21ipCKG5CRFOKl8XVW00XzD3F3WdkPmtE54VxEGtUkWHybU6DT9Xm4m2oLsb8
 Z1g/ZVxywXRgV1ao2Sx0bYIJ8UU/7N2ww+O5Bqj9UqhENfYHO56xc00eiBao6/3PJLjNnPqQPZK
 FFwNID4WU8Jyj+/fpm+YtfuX+tmSw5anbTRB0kiWoiMPc4tSWXeKUS+4faRyxohDogXlWwWTV2B
 E3YAWwIvIfAsCVo6l7XLvpQf/YXg+KvEalBqCANgT0juhYsXrKFaLbo4SQI8x41HGtPnEwyvwRT
 omrSDYR6FblVbqD2iBWNXbDU1yAO32FYP3BUsE3LgcFuy9wnYBRA0w3fAY3vmM10fQHMI8QiNSr
 onSFSSxPnaNxmqdSi19QCApTimtIClc3LgRsHz71ldo+hbPSYDNCt1ewYnzH/V00B30l6WK7pz0
 7AhyTI4vC1huL/uVLbeohYiZpUGtKB0jIUHgatwWBwNeoqe5rniOU6J8devFna+vhR3mODWPCaB
 zXYuvAIBv8pGqvX7WNQtV7qtitun/uc0oyy2yg6
X-Received: by 2002:a17:90b:3c87:b0:39e:4c7e:bc6 with SMTP id
 98e67ed59e1d1-3a098ac641emr3329546a91.20.1790362325486; 
 Fri, 25 Sep 2026 11:52:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0bda430b3sm5064902a91.0.2026.09.25.11.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 11:52:05 -0700 (PDT)
Message-ID: <1aaf0379-ffb0-4742-a638-9b2f869c9034@linaro.org>
Date: Fri, 25 Sep 2026 11:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Linux user next patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260925093844.5685-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260925093844.5685-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/25/26 02:38, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit a97f90fcf8029af253a2ba274b9bda9acabc5b23:
> 
>    Merge tag 'pull-tcg-20260924' ofhttps://gitlab.com/rth7680/qemu into staging (2026-09-24 08:24:59 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
> 
> for you to fetch changes up to 926d6cf4036102e3e0bc9e7f92291ee2277c3215:
> 
>    target/sh4: Drop use_exit_tb (2026-09-25 11:23:44 +0200)
> 
> ----------------------------------------------------------------
> linux user patches
> 
> A series of patches, which
> - fix a race in atomic variables on sh4 guest
> - fix unwinding through vdso signal trampolines on sh4 guests
> - improve the parameter checks for setsockopt()/getsockopt() syscalls
> - improves the parameter checks for the mincore() syscall

Applied, thanks.

r~

