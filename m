Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67220CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 05:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4C6B-0006Ux-LL; Thu, 02 Oct 2025 01:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4C66-0006Ul-EV
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:43:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4C5o-0000W3-Md
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:43:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso2718225e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 22:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759383770; x=1759988570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sxrCWg4VQ/Mu11YI0GAfPlSLAgIluMDTDF8XGFntmGA=;
 b=dOMO0W8srX4iASAAg+Mhcvkk3R/PpQzPRjKgsGdNmxv6BVOmYFHMrwQ7zzokwWFJvR
 R8/FJo+TIAEFiAgQDYdwNcuHMoGyWdphVpxqyefJRFF+fr90gwJd03VHD2wNePEZFWWv
 /iS+Va8mzrFtw9hs9MCJ5gXjM9cWfHctlNiyUPnN7esCZ2/xhdPKzcBbxRsfb50K/b1M
 WxKmc0L3Dy/BFpCapCoahI9K/ww4iaAYdPX94RZUI/AmN6ZhIzi7kQTzYk7b1vqjTZlY
 siP4inTccSiMy3rqSM+3FvNpCzswXc9qBBYYhIPJgj/iVIZV+ERsj/wWxhQAdqdSnBQm
 zO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759383770; x=1759988570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sxrCWg4VQ/Mu11YI0GAfPlSLAgIluMDTDF8XGFntmGA=;
 b=pxEqSfLmqoMHOaHQZ2izqH3+c029OeWm88tQHPQ4QVzyJ4gZzDxGhzhGXhjouS3A/m
 TRvjWqI8IpXAzapvBUCgYtAKBGYlRv5aQ9YKf8rE58vzpWFFJs5ZBBjL3DfUbQeNEsyq
 70P1pGJixjh/blEx/X389Xz87PEdJMHQe8OLrOB+ddvgcWlTrv0d+Ovh54FMKGK3Uh1D
 uCxE8MwroXrRN5ykH6kuhKjnwXR997KT+LuePQ5trcN73PHGDMIcjlw8PbVoXB5O7BRU
 fsFZS/+QZhPhgDcZYRp8Ab/+VLP6YJhcNlmW7VVMIJUGp/K7C5kLKAtLZyf4cozUXB2O
 JoDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxK8/xytMRoF+ICe2BP/bTiScBEXG2tn2w7QQH8jBp+WPVH3bwuzejrwrpJuukZJvCImFO37oFw5fR@nongnu.org
X-Gm-Message-State: AOJu0Yz6mLhoZpRZEhtp7pb9+0+GanRXGSOeEsGqXF4T/tnsCjymgsHD
 ZQW36bYJ1wiQKoEc+tJqtt2Z3P6LkqQGnHP8h0c9S0HiuSarSY4vgbRPd4VXpv+3QNc=
X-Gm-Gg: ASbGncvuy+IW2R2AXCpVXJXt1aglwRVSg154SvyN7aH99q2PFs83W9yKVA3o+qU+bLH
 SBhZxs2YwjX41gQyDMynwF4vy/fQKXZOXQyKNIUuXAaHQLJdHSCGZ3dR67rIb0BJJhDDrRZgA9t
 BAVnU4gV2F29DvoYGfwAhdUKku18GJNt/4w5IxaitI6i089roIgfdiRUcduGmSaDdZZlthlv1Y/
 x3Oa1Z6vQ6Cu4hrkqGgOI5duuD4lU5J2NWxJXC1Qw8ShsOJDyg4ak149YMZ1bHwupbwdf7OxPgV
 6qFrKggvJlIJyQNjwV01XImSWwVRuuKdPCt+B6m+5YqZi+X9mO2/IJRR2QVuHZv38GmjcsvKqte
 UTWUXRedGqPDj9VCrxydgXP+f//C0B/DKnt2cuwTGtlxRB63I35J4tzyM/mZrjwF1zl7naAT5XB
 Vz4Dp3OW17wSWL8Du2sA==
X-Google-Smtp-Source: AGHT+IGcZ0lWD0kkCrPNVt4ltcnoZfJ5LP60iCWoqBAIcyf/rdGYKnd0JP+EbRTt+JcA4oOGArwjXw==
X-Received: by 2002:a05:600c:630f:b0:46e:4f25:aace with SMTP id
 5b1f17b1804b1-46e61201e95mr53927345e9.6.1759383770177; 
 Wed, 01 Oct 2025 22:42:50 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c45be65sm49783285e9.5.2025.10.01.22.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 22:42:49 -0700 (PDT)
Message-ID: <124c48b0-eea0-413f-a1dc-1ede32a7092c@linaro.org>
Date: Thu, 2 Oct 2025 07:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hw/hexagon: Add global register tracing
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ale@rev.ng, anjo@rev.ng, marco.liebel@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
 <20250902034951.1948194-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250902034951.1948194-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/9/25 05:49, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   meson.build                    |  1 +
>   hw/hexagon/hexagon_globalreg.c | 73 ++++++++++++++++++++++++++++++++++
>   hw/hexagon/trace-events        |  3 ++
>   3 files changed, 77 insertions(+)
>   create mode 100644 hw/hexagon/trace-events


> @@ -99,6 +171,7 @@ void hexagon_globalreg_write(HexagonCPU *cpu, uint32_t reg,
>       g_assert(reg < NUM_SREGS);
>       g_assert(reg >= HEX_SREG_GLB_START);
>       s->regs[reg] = value;
> +    trace_hexagon_globalreg_write(get_sreg_name(reg), value);
>   }
>   
>   uint32_t hexagon_globalreg_masked_value(HexagonCPU *cpu, uint32_t reg,
> diff --git a/hw/hexagon/trace-events b/hw/hexagon/trace-events
> new file mode 100644
> index 0000000000..6ef88d9e05
> --- /dev/null
> +++ b/hw/hexagon/trace-events
> @@ -0,0 +1,3 @@
> +# Hexagon global register access
> +hexagon_globalreg_read(const char *reg_name, uint32_t value) "reg=%s value=0x%x"
> +hexagon_globalreg_write(const char *reg_name, uint32_t value) "reg=%s value=0x%x"

Maybe worth also tracing the cpuid, regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


