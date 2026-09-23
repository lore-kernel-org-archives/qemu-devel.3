Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F271C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SEb-0004FR-Us; Wed, 23 Sep 2026 15:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SER-0004Dz-C8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:02:18 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SEO-00042c-IL
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:02:15 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso7559615ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790190130; x=1790794930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a2YDElJcR12vsEtPmbjpiDU+yc4lParm4JCS943iTuI=;
 b=BOKM3sZDvssQ04QCfQpS2Sg2+Rx/DMmG08Zy26JgdZl/ewUWvwbKb8YBDiQIgXls+g
 Llw4uZ5dP2tvNdolnI345v9mbfGbXEoMLGAPcc/yUk4KL6/cb5Qf9SarfI3B9cDzefmO
 s3sa4E6VvGv27zxp/22tn/4ffYGgMQ9Tx0GYiH+g7Eo6XfFIpMqSMO0s0c+IMzbXoIm6
 uWnufMGGAZiNE2BUzn4Fjj7OyorAAonV9LiTY3wDC8AyQkcjqK2u2Mh1G4iDH5Du614i
 1XrLBJjR0G41XJPYRExJYEJtjEqTCwuADGvMB1UtFfo3h11xvfAgx8WDPa6QrpW572pQ
 xuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790190130; x=1790794930;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a2YDElJcR12vsEtPmbjpiDU+yc4lParm4JCS943iTuI=;
 b=w8gyGIycqfOo5XKOo2VopYouq/zZxfGPstjesgSAa0eWHm4X89/oN5ulELW2tW4HuC
 dq9nZxLN/alar5MFcNcOHcwLiIVV8Ij8KYR+bOfoqgYx43xBJo7Rqn5tC0j/VLNEUvmm
 gpbRM1ayCjfmiz6n99IZYu+uRqUeqxaH/INv0ZLYaK1dKIcKzJpeJZDT7sb0CVclnqkz
 OTaO94+JhSsQl13dfsxLKQT+R/2pz0yeJJrZmtASuvqRACc5I4WXN9/1Fgu4CbNYlyNq
 v/wrflbbkqkEjBZiyXG9rA0xYxdYtN1n+Mz9r5ecbjE9kyR+pUSfvGUr6Q6sz61h3nhs
 KAQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMTmWSZGtZ0Co4mWj8l0uFE+ksOveGSZyPA4RAW85Qk+UTlAE9VJ7QFFQ14A6TrFckLDwIPJq/CMhz@nongnu.org
X-Gm-Message-State: AFuF++ntH2LAzYmSrlRL0fBqJm2s0DYIKHeiSmd7EXZm1vAyENN6klYv
 I/18BX6YteRzYw2vmzin8a25DVj6kpdl68X0oW/X8w4YS0QQAapmgGR/Og2tRM7E5BQ=
X-Gm-Gg: AYBFou3uYLenPZ76tZ2Ly7dhm8llcuXxkImL4CeqdVhoctQ0nZL+mMsMolUw/l/On1o
 R6sXYvbRsf60XGh5O9NjNQLjBrCZgMtLuxezMhNCD6fV0L/Nkai3/QejMpO/JTISqGg1BcOXk4L
 hDpgQP1eUKqQRP9lywr3x3q2weGEvK1TGUlQax5npr+MvuRE4XZUES6Ku5tfcxEjJT1MU1fq2UJ
 RvH/Gl0klz8J6BspMpiOqQcJHpH1y2JjljOSjA7nni7y889Jat0qzS1J6rrstj75PCCaiBASLoR
 /N/M7NJnGmo9mwF3/HEowMDAjZT8O9SG+YkPgfmRudgqbsJ0QtvOSRAz0jlpR5j1O3AMF2P/PbF
 SwUHwVVQ1Bl8OljzxoSbgsVq/4H6+oS7Wz41o94wcOqIsb2Ai519JLUsGCdjo4w0RWsYwhJ5UYz
 kIZy+3792LXS1x6qp08on1bFk98tE++p/VP69yFYz0LFkYzan0fhdNvgiU3UMIzUop07WzMThrJ
 7pKOi0qOSvJCc0utRwFnF1ssZB6Yl7v2j5JlQUUoWWx5vCJI6Y=
X-Received: by 2002:a17:903:37c3:b0:2d7:107c:917b with SMTP id
 d9443c01a7336-2df7d735ccamr1242585ad.0.1790190129690; 
 Wed, 23 Sep 2026 12:02:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a603828sm15795525ad.77.2026.09.23.12.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:02:09 -0700 (PDT)
Message-ID: <28357eab-ce8d-47be-ad9c-21efb7c03822@linaro.org>
Date: Wed, 23 Sep 2026 12:02:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/21] target/riscv: Skip empty MIP updates
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
 <20260923171116.31276-11-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923171116.31276-11-philmd@oss.qualcomm.com>
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

On 9/23/26 10:11, Philippe Mathieu-Daudé wrote:
> Return early when the effective mask is zero. This avoids taking
> the BQL and processing interrupts when riscv_cpu_update_mip()
> cannot change env->mip.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


This breaks the usage in riscv_cpu_set_mode.  One could argue that 
should be calling riscv_cpu_interrupt directly, but you'd want to 
examine locking as well.

>       /* No need to update mip for VSTIP */
>       mask = ((mask == MIP_VSTIP) && env->vstime_irq) ? 0 : mask;
> +    if (!mask) {
> +        return old;
> +    }

If this is kept in some way, this should be written as

     if (!mask || (mask == MIP_VSTIP && env->vstime_irq)) {
         return env->mip;
     }

Note that there is an existing bug in which the returned 'old' is 
fetched before the bql lock is taken.  Note as well that the existing 
mip update statement doesn't use 'old', but could if it were fetched at 
the right time.


r~

