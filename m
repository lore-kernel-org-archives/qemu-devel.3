Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCEECF45D2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 21:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfPjA-0005Lr-OZ; Mon, 12 Jan 2026 16:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPj7-0005E3-Rm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:45:30 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfPj4-0001Sp-Rt
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 16:45:28 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81ef4b87291so1228767b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 13:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768254325; x=1768859125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYBrkuKZYmCKQU4pm6dft1YQ4sHik3YX3Q9EAqEJ560=;
 b=O6uubM6BT4z9m2u2aON0GYSSXC4ltSSxe04fC3gNnJxlBIzNKC+ubD/9Hj0lpo3t6K
 bRRx6zxmM5lYc0uZMEa59Pbzxx3xBZCukcQ+icTwxUfgaFoeXMitQXFLI416yhh5NOEu
 IGz+zOKbkaA1TcpLtWz0MJ7x1S+8bp3ilEOMWNyhBbrmtJVQV2H215g++3Tpn04mdPoY
 xwJWW98Vw+EdrrJy91UhR1DGbWlaIT/zrja8C52faWRYqx6o46yVqI+5t/a6ZbAS2gMR
 ngyVzfCTBEL3DT3ffNsRfdaEyO2boKIgn1VmSsEDhPYk23kzeqKEtNPT/2c+4p2B9f37
 c/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768254325; x=1768859125;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYBrkuKZYmCKQU4pm6dft1YQ4sHik3YX3Q9EAqEJ560=;
 b=VbxzJxCeWkkoJ9+skkG1YW13Wl3rfy+prRgBSCtocGrX44s6XuZc8IEIXeieNGH3ct
 aF40AiafTAn99fY8HtnIvxFnD5++dOFHTVNn25GEBXBW7mvVh63KCvwaIdYx2X+csYvS
 VBEDAG6KQo2ZUV48t5F/cwUPti6oB139e3224og1UxctJWsqDA5e3PIeWdwAxku+aRGM
 543M336COrnb1okl1XCRNJI8UIZv0DfhYJQMeXdd9bKf3+5qHhBS/DxGu5lBkNaZfB0E
 ViKCmnjAtIsMauIDGZwGNY/d4/DSKXaFXBgJkc5IiDF30b0swP8jMVq14bthwfoybGOc
 im4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvztYAp1R6ZhJtDyISONriq1C2iyT4pMsNCLp1XHD6gwb69AkmhPoS6h7pPTJbZU9P5m68TyhSMgmA@nongnu.org
X-Gm-Message-State: AOJu0YzctWtVJ7le87ZNh6hfP1FfaISVTzFhdVnbwUK9iAm1p9x3mWeB
 blSF8wgrcluWhkfFYYM15lXxEhpNW+yj/8V4crAKVc9/kd2ElCN+cUuURJqoj3Tb3gob3BP3qTi
 6RnlrQNw=
X-Gm-Gg: AY/fxX5pzuTxH5TXFBXoA9ExYZd6IsFVJFSi0PBDAo0QN+ybHD7ugpDlhfMp2FaNYia
 rN1nAWLMZjdfD5NIQs/Ssu63e0HkpzC2XF4kz8bYrX7VxlAAk2t4/t5KB/YKSsie/QqxS8CdL9G
 6fzOhI/9QgOGL1DIhjuHEFk4CE6NTtmWz9DowU9pwSxD7aXPs6rl6Bz+fjfKiHeEHHafEObiiLr
 DwUFytVI6ZDgSJJqTm8ch3N700nyaPJmphro5nEhVoxC9hqo09cV551jDX7uBbRSP7jDj4/Oxud
 n47BAdZUryUL3EpGgr3EjO6PYuVSGS2QS0/rfOJYB0zYsopAS0tl1/VOHzvoTbRh8lQOHKUw6kd
 2WrceBvKn5XilmE1Gic9vCeYqpnDSLMtIFw3sy8iJ+NZxgqwNQPvzesE/NuueFaechs7GRRXe3M
 r5SP1dGdNXx/Jh7xiXzTzlcmPSXlkmUtO4WkhDcg==
X-Google-Smtp-Source: AGHT+IG3kdBZIZUf+aP8bhdO+vH9uaQnpHKGpJLKI+1vxTwL19kT2tHx1HNRWS/IRl8wNqj4qNQboA==
X-Received: by 2002:a05:6a21:6d93:b0:34f:4459:a68 with SMTP id
 adf61e73a8af0-3898f9166bbmr16898259637.27.1768254325008; 
 Mon, 12 Jan 2026 13:45:25 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c50347bc321sm15891795a12.18.2026.01.12.13.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 13:45:24 -0800 (PST)
Message-ID: <55ef7d7a-ddef-4171-a5bb-b73d1a1632ff@linaro.org>
Date: Tue, 13 Jan 2026 08:45:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] target/loongarch: Add host CPU model in kvm mode
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260112080721.3319572-1-maobibo@loongson.cn>
 <20260112080721.3319572-4-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112080721.3319572-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/12/26 19:07, Bibo Mao wrote:
> +#if defined(CONFIG_KVM)
> +static int read_cpuinfo(const char *field, char *value, int len)
> +{
> +    FILE *f;
> +    int ret = -1;
> +    int field_len = strlen(field);
> +    char line[512];
> +
> +    f = fopen("/proc/cpuinfo", "r");
> +    if (!f) {
> +        return -1;
> +    }
> +
> +    do {
> +        if (!fgets(line, sizeof(line), f)) {
> +            break;
> +        }
> +        if (!strncmp(line, field, field_len)) {
> +            strncpy(value, line, len);
> +            ret = 0;
> +            break;
> +        }
> +    } while (*line);
> +
> +    fclose(f);
> +
> +    return ret;
> +}
> +
> +static uint64_t get_host_cpu_model(void)
> +{
> +    char line[512];
> +    char *ns;
> +    static uint64_t cpuid;
> +
> +    if (cpuid) {
> +        return cpuid;
> +    }
> +
> +    if (read_cpuinfo("Model Name", line, sizeof(line))) {
> +        return 0;
> +    }
> +
> +    ns = strchr(line, ':');
> +    if (!ns) {
> +        return 0;
> +    }
> +
> +    ns = strstr(ns, "Loongson-");
> +    if (!ns) {
> +        return 0;
> +    }
> +
> +    ns += strlen("Loongson-");
> +    memccpy((void *)&cpuid, ns, 0, 8);
> +    return cpuid;
> +}
> +
> +static uint32_t get_host_cpucfg(int number)
> +{
> +    unsigned int data = 0;
> +
> +#ifdef __loongarch__
> +    asm volatile("cpucfg %[val], %[reg]"
> +                 : [val] "=r" (data)
> +                 : [reg] "r" (number)
> +                 : "memory");
> +#endif
> +
> +    return data;
> +}
Are you sure you should be bypassing KVM for this?  Other targets start a scratch vcpu and 
then read the values via KVM_GET_ONE_REG.

I'm not sure how much trap-and-emulate support LoongArch has for such ID registers.


r~

