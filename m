Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EA8C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBfX-0002E5-JL; Tue, 21 Jan 2025 05:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taBfU-0002DV-Bh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:39:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taBfS-0002cL-CN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:39:35 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f796586so59447775e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737455972; x=1738060772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3PbUo/DhjJSDV0mHbiEXoyyVE69KmcTLVad0SAwjkkY=;
 b=hqfuawl0ShdSDBMwBgnc8IdnJQ+9DlYciFoXxaUHGQZ1i2N5OJgethI783pRZ0BoF1
 ucUVwJCDEhEc0QReDC6akqbHbQ0zMBjFXj46D/MUZ3OsTyMO7Bwo5WErWkiDHIRpus3V
 ak4c6XtUFVxSFE2kB10jMeVZdW9s0qPf3cCXah+drbtFHXYp818kbjk/CgApkhThHq+2
 Sj0V0kQkuFnDensGKwhApJ0u2vitn19f+N2hm57SN2QpBhx8ZpBC4t2/Y5P0NMp0inUp
 abqjgXf/EeEooGwzxIiEqebhC5/MMfAhI+4nZSyDEhb+k5O5sG8COi7rlNIjcWEoyZRp
 e+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737455972; x=1738060772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3PbUo/DhjJSDV0mHbiEXoyyVE69KmcTLVad0SAwjkkY=;
 b=u2kwze/X2TZ+iloI0HG4BtMrAwlzAa6w80iBvFDTcyIuJ6h6HBZ8ZNyJoDhNSQBXJt
 L8b6VkbBOyvfvBqk1pidq8zrkbfmWvJn00wTqg0RVGowPXn6bH111FCNJbwytwxy2CmE
 5FHZeVNzKzjVEdGNUWxjGyFRoqwlyRD93KeZI7dgdz0wa+8sn9JcrmImsJb+vwCouZTF
 Xrb4zMlm4x3N6DjjIbjeDUloz4/Vi5Asz0ehSBzU3GHkXhpd1jCjXV5cOjMyD307GQwG
 8CipZVSZmgwtbHpWvkIqGnlLjhmm2TiwGlLWMJ67gmomy4djDhApPSYG9BwioD2LbcoG
 QYNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXun7VVQzzQhyCDe6jZ+0xDLHARIzkz6dpfY3+YPDhABZeOTKmml/FU+Q2qFJ4lsOrIfyju6ofsRfM@nongnu.org
X-Gm-Message-State: AOJu0Yw+YP4L20j8tgTVCjHzR/MNP3FjF9OSd8jGVHyte+fxsrOP8+LH
 7P2OuHkpqtahxqcKLKPvlKRNGT2DqnL4SZojONo1rMPU4phShEPTmXxWEQfeLF4=
X-Gm-Gg: ASbGncvAwqPxSrLqUP09796X9RDrk60WPzi5Au+Qj+l4N2LZxAQD9DslSz2ZBh1I76b
 mC5RNyHAsA5pj3VpVBvIjgm8lSS8qn5q4yJ6ciPfBAJYmKqqgJAG6FH9AbKSlGB4gszpgoeFxLK
 Ao1umZzdTsrIHiA7SczDQKv+jGCJspsq2CM67MG4l/C0BRsIEKvqOKYjC9I3PgIxDA5BuEs7klv
 NNWtLE8vgRODU0qX+S3+OWGGFqLZ4V00JwulIxuculsc8peUmvXZh/D4EBYgrAzpG4CoXoKbbFc
 rGGIjddI4NE7Nd56eRvG2SFVP/nNSaqLaHM+FQ==
X-Google-Smtp-Source: AGHT+IHWRmjEuCZuu6azpeDtmPMn6pSrg2wJwGU3qvFDLZt40CzPPR3NRTSznTGBwuYtIvd9ybtfEQ==
X-Received: by 2002:a05:600c:46cb:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-438913c5b82mr159287145e9.2.1737455972074; 
 Tue, 21 Jan 2025 02:39:32 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c4751sm231288045e9.19.2025.01.21.02.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 02:39:31 -0800 (PST)
Message-ID: <4cdd0978-16c7-4cd6-93e8-ac7a2061e407@linaro.org>
Date: Tue, 21 Jan 2025 11:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] linux-user: Emulate /proc/cpuinfo for Alpha
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Michael Cree <mcree@orcon.net.nz>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <20230824010237.1379735-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230824010237.1379735-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Helge,

On 24/8/23 03:02, Richard Henderson wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add emulation for /proc/cpuinfo for the alpha architecture.
> 
> alpha output example:
> 
> (alpha-chroot)root@p100:/# cat /proc/cpuinfo
> cpu                     : Alpha
> cpu model               : ev67
> cpu variation           : 0
> cpu revision            : 0
> cpu serial number       : JA00000000
> system type             : QEMU
> system variation        : QEMU_v8.0.92
> system revision         : 0
> system serial number    : AY00000000
> cycle frequency [Hz]    : 250000000
> timer frequency [Hz]    : 250.00
> page size [bytes]       : 8192
> phys. address bits      : 44
> max. addr. space #      : 255
> BogoMIPS                : 2500.00
> platform string         : AlphaServer QEMU user-mode VM
> cpus detected           : 8
> cpus active             : 4
> cpu active mask         : 0000000000000095
> L1 Icache               : n/a
> L1 Dcache               : n/a
> L2 cache                : n/a
> L3 cache                : n/a
> 
> Cc: Michael Cree <mcree@orcon.net.nz>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230803214450.647040-4-deller@gmx.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/alpha/target_proc.h | 68 +++++++++++++++++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
> index 43fe29ca72..dac37dffc9 100644
> --- a/linux-user/alpha/target_proc.h
> +++ b/linux-user/alpha/target_proc.h
> @@ -1 +1,67 @@
> -/* No target-specific /proc support */
> +/*
> + * Alpha specific proc functions for linux-user
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ALPHA_TARGET_PROC_H
> +#define ALPHA_TARGET_PROC_H
> +
> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> +{
> +    int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +    int num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +    unsigned long cpu_mask;
> +    char model[32];
> +    const char *p, *q;
> +    int t;
> +
> +    p = object_class_get_name(OBJECT_CLASS(CPU_GET_CLASS(env_cpu(cpu_env))));

Isn't it the same of:

        p = object_get_typename(OBJECT(env_cpu(cpu_env)));

?


