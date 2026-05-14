Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4428CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 09:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSi9-0004mG-LR; Thu, 14 May 2026 05:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSi7-0004kd-Jf
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:50:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSi6-00007C-4J
 for qemu-devel@nongnu.org; Thu, 14 May 2026 05:50:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso6509142f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778752227; x=1779357027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+wgIRqye9ZqvIZzmNqRHtvosqLSP8bgpcXTixfIb/I=;
 b=tLQ67QRzBDuP8usgqTVSAPST+qyuujmUrxu6Aly5e3UJOssFTBJaOhd/jML8VFQ0pQ
 hNZAvIZdecXbhZYPBmnY+d8WZXZKuItjDFW3UBxL4F5jOv1ne65RlRonY8U6YI5mBSo6
 MaeU3JyIWpenTY4iNGI8iZGfRE742P3DIT7NIkAzoDziP3WJlS1Z7SY7jmAvl6i8Eikx
 80XFjHtUOvH5hl98dU3Sn7aVU8NWmxU403olZcPYtHbTRMGUrHXwOEYF9QrSc/exnaFd
 fRQ0y4ErL7P6aiP0NwthydR8xp/Du05Jth4eXB1YO4p60zrskwqYzZu5cIy/GTTP3JVp
 Dksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778752227; x=1779357027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+wgIRqye9ZqvIZzmNqRHtvosqLSP8bgpcXTixfIb/I=;
 b=PWd14sLYrj+2JqcPER2GMuLLrIZjpZMNhDxhKd0ZRLIonDA3Q0K15cgCteJfZLSi1v
 rije5Jc+6u3D4jC8R97Z6ZXONvMv8hUb7rQfsLVMOxeNXEpiQh09BipnIwQSWw4yY/1X
 arNJSiRh5hDuokvUISzVmejgjsRm203Js5bfeihXR+OmvQ9Z/XuFcnsn2lFzibdqlTOy
 fb+/ANxCVjdXYrhhQpu60LRM5/bVKWf6A0Get7jwTBvQpckmSkUznk2PFjynFLIYuvJa
 U05ChqkpZZh4c4Ec2aGBAMVknTxVT0lQlwtX3+f5t3+xrknI/o0O7GJGSE5HcqoUnP3u
 KmPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XS7TXfYOzAbIfaRux6fMdELg8TaPQC/UYzbFVXyeuGiKqJr9Au2e2TKvXHjKuevM8X6NEXAc7G7EJ@nongnu.org
X-Gm-Message-State: AOJu0YxKjqlur4gbdO880gUQC5pNMsIkjGu4i3z0iGFFFrLSFofk+nzJ
 VFQPWijH0R6ZHJCWQjF6pqB9tRDjtcLkdFzoLWxJ6Qo2bcXeLJNuCzmAi/3cF213g1M=
X-Gm-Gg: Acq92OHSovjoqrNWEN4jfYF/jpvSXSz1V91fJSMvtpxeX1rZ6erIF7R+goUlq/ka9c7
 nPDJ8nURjEwZsEo8GNSj7/7i95gfbk7WTjiUq4o0AHNG8hvj3GuNdqEKWASWK4I1Ns85dYLlOQX
 PjX286+R6AjoPMTlK8P6oQLObiWHnfbR10fYcf0pYB0KGAdinEpXxY9C9xP9O61TbA6Qy3AmPby
 gnZ55acZfMvCgiwILcLXinL96Icxz0SdxB4XDk+bj6tLoPBd3dUMapqbLtJ5UHAOkiDzezUEtwl
 GfTVa5ORHjAqqI9aJ478xhBPE/g1CmPCbC4R9kWVtbcK4Kwsm3yPbl/kd7kyD13Y8rFq+BHK3ln
 llfHrgatFJWf6Qw11d+vOVZcMiSTDRp7fvNBxOMstmw16AQpIhoIuTXuidWLcqV+VF0w1iWQIOL
 GjIe69G70A9Ql8P89JH+F3X19sLhmC0HTJsmdRfb/L9vovauDxN5U8L65kmaUoIgpzpg==
X-Received: by 2002:a05:6000:2401:b0:441:1df5:480c with SMTP id
 ffacd0b85a97d-45c5b02d421mr11269112f8f.42.1778752227035; 
 Thu, 14 May 2026 02:50:27 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm5552438f8f.22.2026.05.14.02.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 02:50:26 -0700 (PDT)
Message-ID: <7ee8ca5e-70c2-4b85-9461-4ae423cedbfc@linaro.org>
Date: Thu, 14 May 2026 11:50:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/35] target/mips: add Octeon LWUX instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-10-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-10-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 11/5/26 20:22, James Hilliard wrote:
> LWUX performs an indexed unsigned word load from base + index and
> zero-extends the result into rd.
> 
> Add the decode entry and route it through the common indexed-load
> translator with MO_UL.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split LWUX out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

