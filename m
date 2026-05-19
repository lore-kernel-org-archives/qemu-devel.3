Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E6DCD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSMF-0007kF-5N; Tue, 19 May 2026 17:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSMD-0007hy-Mo
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:52:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSMB-0004vg-Ke
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:52:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b150559bso31583615e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779227525; x=1779832325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DEinpFWAf/dgwZJ4Wp4fwI+DaPN2mKDPRq7tIIRp6Io=;
 b=HV6ZU4x5tkphRM3XxsiXjlUaa6HSZDJLC8Aq+SgucqQYTl5NARCR5VM/0zVJ8I4+Ys
 9758EgHtoevbCo/CMZdZsdGuI26p37NCIeaPcFz34VcSqb75fwMQ2dbSyJFIcl86CKBC
 qAln4b+55YPSuIzNFQuvkaTMRfPZFL3zjsuBQ8ZcWhAuNH2oq8TfXqwYAGeT2HiYJt8C
 39NhMXSSJS2b3TGDXC5IbPP66wnS+uqxSvfS2OYPM1nfWAJbcQ4PtWD58CAkGwemtffu
 EfOl8lnCYg6b2a7IWIl6WBHgC/xbejulwttYeJ1sBJzDaqwefb+7OZnAF5DVrC+hID0Y
 6zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779227525; x=1779832325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DEinpFWAf/dgwZJ4Wp4fwI+DaPN2mKDPRq7tIIRp6Io=;
 b=p61F7fNLMPXCoLTOMFggIDistHTKyLgGrnMirNiI22bTzDq2/m9xT85IVWIbtJ9tVW
 RPqrWhUXr8ICiVt7Sv0+ZBIudwyPEuwUppc2JmUjjssK3tS7stknWACzuNkPSUFLjhFk
 8oM2N3sV8HdN++Yb/wBrsLKJP/L/C71Jufni9JOp0GvEFfgsxjsdg0fL3mTY1JV/AR0x
 CZPjJQ/GYC8hJpvjTeAYBylxN7o6YZbai/3BpUs8561GFq15//9Ty6TAchioEnRVygT7
 g2csmmohC6ssZnrGoSah71cOa6Owqg+Fll0/H6bpr2XokG3gzyYJAxr28Fa1Kqm1NgRW
 GRaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G0j4h8abU9AFW5pIoleIVOzUYhLF4Bz1811BF2O5+QQbZ6rO5a2B2R3Lbb4xdOEjKJluM1gSaeXcy@nongnu.org
X-Gm-Message-State: AOJu0Yx9CTkiPLL3e1AdIpI1A4lqJH+Na/fEWpNC5Id4yMNufD/hFJUX
 bubu3KPDEfZxuTiFFBwMQiE8gi8zQqaNStUfzEwNDAYBXar19O7cLH3iNBqTw33ss7M=
X-Gm-Gg: Acq92OHnaTX7ZQup3yA+HSyzs03k/NyFKHPy0l5GmJ9T1MmM4hmx6UfwsW8ClEYqn/r
 mx169WNsvz29QwQPLwCE7SDm4RCU9tM79rrrPZdOhVXusNbKhvEdNP94Y1iK+3atjiPzAVujlYX
 ZrWmt+CIFjGvlRdXIxFlSIJiiCTgVaJyBC3TimrGegEdFjw954tUTpszg8S2CxmjKsLFSBMTRII
 YPp2yHsE23jksSlPUSkGcM0lPY3tJlUjHot8zRzXlnspurC6g+ysiJd1FrOtEj75r3w6hpCOubS
 l6F3ijTzZBhnkJBzJxS+jPoG7nlbvIgbwJAJlT2j8SLvq1m4qDFrISMckpF4ZV9V8KDH25W1lmu
 fCW4tIu/O+zfZUDMZZeHfnBC82PytYmTTOjIDQHADBrJicPWU9FC5bd4cIt7clyRRqYTiYcehvd
 KreLKe0d6umZ4QJ+wGf0u67Ti2KmKpMOmI1qtQdZMnPZlqtWlbe99yfB+B+7ncz0pylw==
X-Received: by 2002:a05:600c:8189:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-48fe632249dmr324012515e9.16.1779227525127; 
 Tue, 19 May 2026 14:52:05 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6aff4sm115799695e9.25.2026.05.19.14.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 14:52:03 -0700 (PDT)
Message-ID: <59747973-1075-4db9-b3af-2aad0c7f15a7@linaro.org>
Date: Tue, 19 May 2026 23:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv1 3/7] hw/misc: Add SRC (System Reset Controller) to
 i.MX8MP
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, shentey@gmail.com
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-4-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519175635.3245229-4-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/5/26 19:56, Gaurav Sharma wrote:
> From: Bernhard Beschow <shentey@gmail.com>
> 
> Add emulation of the i.MX8MP System Reset Controller (SRC).
> The SRC manages reset control for various subsystems on the i.MX8MP SoC.
> SRC registers are used to start/stop/poll the M7 core, hence needed for
> AMP boot.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   docs/system/arm/imx8m.rst    |   1 +
>   hw/arm/Kconfig               |   1 +
>   hw/arm/fsl-imx8mp.c          |  10 +
>   hw/misc/Kconfig              |   3 +
>   hw/misc/imx8mp_src.c         | 431 +++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build          |   1 +
>   hw/misc/trace-events         |   5 +
>   include/hw/arm/fsl-imx8mp.h  |   2 +
>   include/hw/misc/imx8mp_src.h |  32 +++
>   9 files changed, 486 insertions(+)
>   create mode 100644 hw/misc/imx8mp_src.c
>   create mode 100644 include/hw/misc/imx8mp_src.h


> +void imx8mp_src_start_cpu(FslImx8mpSrcState *s, int cpuid)
> +{
> +    switch (cpuid) {
> +    case 0:
> +        arm_set_cpu_on(0, s->regs[R_SRC_GPR2] << 2, 0, 3, true);
> +        break;
> +    case 1:
> +        arm_set_cpu_on(1, s->regs[R_SRC_GPR4] << 2, 0, 3, true);
> +        break;
> +    case 2:
> +        arm_set_cpu_on(2, s->regs[R_SRC_GPR6] << 2, 0, 3, true);
> +        break;
> +    case 3:
> +        arm_set_cpu_on(3, s->regs[R_SRC_GPR8] << 2, 0, 3, true);
> +        break;

Confirming my thoughts on patch #6, this SoC really need to start with
no less than '-smp 4' :)

> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +}


> +static void imx8mp_src_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, imx8mp_src_reset);

Please do not use this legacy interface.

> +    dc->realize = imx8mp_src_realize;
> +    dc->vmsd = &imx8mp_src_vmstate;
> +    device_class_set_props(dc, imx8mp_src_properties);
> +    dc->desc = "i.MX 8M Plus System Reset Controller";
> +}


