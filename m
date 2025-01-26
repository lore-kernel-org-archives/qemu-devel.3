Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF6C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1nr-0001Eh-IU; Sun, 26 Jan 2025 07:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1np-0001Du-QD
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:31:50 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1no-0005c8-Ba
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:31:49 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21631789fcdso60644665ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737894707; x=1738499507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3kypwyn23Csr2lNhyAaxQo54NBRF3nBjPWJc7KIwjE=;
 b=XrZ8o059blB8OBBYxG6rt3JFjP4gsa6vawHrgQlWbDU6bcfY1BQAuKm5EIeiEjZPZa
 eUp7uO3IfC11L1bzczPthj5safXqbmbrV2KKMIr42KA+XMEQZ4nV/dmC8dCE+9MSIYco
 Rk0xHJG9LsUcH4KWBuTA+jZgEevV0BgQBBpTEPmI9aW/FbUJpSouDl9j9bIADfnGJUl0
 c3pmUhd20rx0xpal8LrQf/y6rhZ2Bu+UNi+VWQJjTt4Hxu/0XY9QzjK0nsFPYOm1VacV
 lUGGLKmzvbuIJlx5AtvKWPw5Vpec2sYlU7q0gCFCSuwmXlP5W6zsMy1CM0hXP4YjdIaC
 0f3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737894707; x=1738499507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3kypwyn23Csr2lNhyAaxQo54NBRF3nBjPWJc7KIwjE=;
 b=tdeKsW730tfqO87OQ+nTFEErkaIU1F2bas3EdSnTe31IRWNYxxtwMLvr98jJGUlZtk
 0NqzseN3KRIUWc6/0Hxtmj1WHRF4dQwycqWkze6eqM9qSDKxqUREn0Un7r8o71pATNxc
 63qy3kxHjQeKnex89z+b2FgDFskc/k3srJbmkT5/zIQyHlxG7A4OnHw7faH+Url3Mwop
 2W82RCGYSoZ8ZAlD9dPePdHZrHhuLCzc3R81m9GcPbG+qeZKK+Eh5KbIUeP5O8cKAH9p
 RiHr03TM5mw4fncvQZsX0O5A5ME7ICsY4YaFSYp813euGWvEy/ddG8Uk+Gs249VhRLLI
 q++A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+mh4zCQCjh7EWASy3FUtKBJAnh5tIJdbrxRU+f7Mu5hYsw1rNLG+6XgcrzUQafd+DEkO1wLH5CQuX@nongnu.org
X-Gm-Message-State: AOJu0Yzsey+jMv0MnANWdtFLi9vxe86vCsCENd5idOqVMhWqKG3Um82G
 3HKamT3ptbK4+EPMIenjeZ37chSdVEbJx+s436JPBM+oYsgP6OZsti2qcEHEX0I=
X-Gm-Gg: ASbGncvTDm1hhn2spQygfM8F+sinzxATL180U/LB073bQEM0C7GLhVu0BNTRfcwFdJG
 3CBVjrVhS64A24qqg5UTUqW4p3p3VvM9tdvXjq6klavOiSNR9/qjuEh+ofcamXMYRprU/7W5NxI
 xZsjYBgRO+Ianq6P4F6BU5rGubX1DL/H0QMdZTLCdEUqnla6pNOqsG0WqcsvXxg5EqEwbBtP4/4
 VRHgS6mShCop9LxutxkNN7KyIrMXZFOuapqRY8QorWh9jo/4EQ1HQC09Z+xYMOosw7UFymRA3kd
 pL9hsGwy6KMgjJ0Q+GTouHA=
X-Google-Smtp-Source: AGHT+IHzcOBVtSnMLGdPgG/6wk7JbF+kzcX4c8RtzEcFAoM3UnXqzveuRurRFCJD/UVU+FEpPE0uJA==
X-Received: by 2002:a05:6a20:9f9a:b0:1e1:a789:1b4d with SMTP id
 adf61e73a8af0-1eb6978a73dmr19920082637.15.1737894706896; 
 Sun, 26 Jan 2025 04:31:46 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a77c9b1sm5154641b3a.125.2025.01.26.04.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:31:46 -0800 (PST)
Message-ID: <cbd78ef0-c06e-4a6a-8c17-1072fc58c777@linaro.org>
Date: Sun, 26 Jan 2025 04:31:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/24] cpus: Remove CPUClass::has_work() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250125170125.32855-1-philmd@linaro.org>
 <20250125170125.32855-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125170125.32855-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/25/25 09:01, Philippe Mathieu-Daudé wrote:
> diff --git a/cpu-target.c b/cpu-target.c
> index 98e9e7cc4a1..778f622b07a 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -230,6 +230,14 @@ void cpu_class_init_props(DeviceClass *dc)
>       device_class_set_props(dc, cpu_common_props);
>   }
>   
> +void cpu_exec_class_post_init(CPUClass *cc, void *data)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* Check mandatory SysemuCPUOps handlers */
> +    g_assert(cc->sysemu_ops->has_work);
> +#endif
> +}
> +

Does this really need to be split from...

> @@ -319,6 +313,11 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
>       dc->user_creatable = false;
>   }
>   
> +static void cpu_common_post_class_init(ObjectClass *klass, void *data)
> +{
> +    cpu_exec_class_post_init(CPU_CLASS(klass), data);
> +}

... here?


r~

