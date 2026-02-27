Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2706104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6gP-0002rm-FQ; Fri, 27 Feb 2026 17:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6gN-0002r7-CH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:51:39 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6gL-0004K4-Vd
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:51:39 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43989bd056bso2145384f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772232696; x=1772837496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w2+K1gZgXy5XuDvkue0dAnONG0M7zaWD4q/STguEmzY=;
 b=Tre5YuZtXnQOVTwghz29z6au+lNg1gSevbsdQLc0xOuXfLj7RnEbjmb3MrL7yglcEN
 xhT1LOyhB75idyBfyUwivTcwg9WF8M380uSfhW/8YtpLgcCfdXeqAWQBPysplusYAcv3
 EZLEckhx+CJMCpOZBra00nKD+wwmGN7p858a1CLj9C3krFArtXHNYbP4wkPIfqAcscWr
 2/HxNmqGlYWJn6PhAIaWXvBUSZdvbXZn6jodqL2bq/p6T0grij1a88crtsGqCGOexMth
 sD64z1AF0wTRzjArLLVMCWKPqLftBVJcgpAX3uMG7gp47Yztk6IG7tCLZ68wpBJn4/PU
 C1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232696; x=1772837496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w2+K1gZgXy5XuDvkue0dAnONG0M7zaWD4q/STguEmzY=;
 b=FlQF+CiinF9zw0hXibqD5y7jxDRkH43DCMPqGiDfr2l75mbVRJgNBOsAXz4O6iz7uL
 ltsubaplNwaC+nTYuhsHIr/OWJstQKEPL4yhwRY3QA265qwZmYRuX/8w69wbKQYwiRzG
 T6DqlvCJInOCAaK2ncIf/xsnCR3qRP9r6c6rhFkF1JWjq7wmiF+MvptVXnQOeZyHAWhk
 Z1tLrRtzY3xpVQewD0NRR9hBMZ79heRXyGDE2dQxiH9SnNFgxr64gg7eUeWdkNIigPQl
 A8jEJQFcsDixY7LNMi40zd91spTbsVGAJeTPuchuP8FwGQ1mEOXDJ5MLixA4p1QM9zSX
 +myg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1cI52oPaZHFZsgL3EbExXvVL297lLC7iMtVf7yxF8H16M1R9gpcHTmApngIUxVuTpqsedUiK1kSOm@nongnu.org
X-Gm-Message-State: AOJu0YyeHWGbeCuvjLLCuRR5rCX3qVvM0Y3wl2c31w+CFlitouKV9p1m
 alzCWRcVD7Mq/k091YDP+L1wYMBN+kdLUdiXgJ5NL2IvRsCV8FON01llTwTTfXhwEmY=
X-Gm-Gg: ATEYQzx4kLBW70E8C5Zn+/dL7MJ6lshpYwq/U7bvhVsycIzi+GfkN7VwSTz3t3Fxl7f
 0zKtMs9M49KWzNT3FDVROnWMIJd7hCV4vgBP50ttwqTQP8mMzatIezEhS+KN5gPbEzC2q8ITqG6
 4pE2b8Tz4V/0qwlVT/rx1R/+FUQHtcGVXPCNEUowa8N2tK3jCD4aTrPocnZI46iCLhYTfarYbOd
 huOmyenZ84DV0cmds06nXHarxReNpTPYUse8Nw0TE4hzKrPpQOhoCkVgYmJJg+zgeMppHIYwD2r
 umGonjSvuTh8mUbTKzChBi0RFMeW5r4QRM7GeSbPlNzoF6/eHrAGkwWAN9TamE9Tr8upFM2hAKZ
 p1a07OVnPXsCuH+5EI19jrj6VY+JLSI2gh/9Y+zVIMFznmPqFaUulSdIgeVsMx2MryoHPj1oBgs
 n+tvzSJqAjDsKZjiM3ftG1+BB+Ra1nBRy/hD87Ge4gKLClZxW8Vb+GG56jflqPE1nPpw==
X-Received: by 2002:a05:6000:2689:b0:436:8f7e:a486 with SMTP id
 ffacd0b85a97d-4399d97f9damr8510246f8f.11.1772232696501; 
 Fri, 27 Feb 2026 14:51:36 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60f783sm9479420f8f.6.2026.02.27.14.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:51:35 -0800 (PST)
Message-ID: <a7d80b8c-4383-4077-8926-99f227ef3220@linaro.org>
Date: Fri, 27 Feb 2026 23:51:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] arch/riscv: Set UBE bit on BE target
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-10-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225102016.200654-10-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 25/2/26 11:20, Djordje Todorovic wrote:
> When the RISC-V target is built as big-endian, ensure that is signaled
> in mstatus via UBE bit.
> ---
>   target/riscv/cpu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e95eea0249..0e24f2cbcd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>               env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
>           }
>       }
> +#if defined(TARGET_BIG_ENDIAN)
> +    env->mstatus |= MSTATUS_UBE;
> +#endif

You should update mo_endian_env() instead IMO.


