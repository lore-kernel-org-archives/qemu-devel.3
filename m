Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D869CC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdxi-00058p-OB; Tue, 01 Jul 2025 12:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWdxg-00056I-RA
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:36:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWdxe-0000GY-UL
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:36:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so3602365f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751387754; x=1751992554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O/6EiRS+dKF8gdeapMmBXhGH7wQxCu8g5WqEtX2r8X4=;
 b=g4fq4WA9HaLkyEhejk50N//SN4195OgX5Mvd90NrEgFuW3bvIzZ0w11jorf3uww4Wc
 lc6zn7wEHJOPSKDqM8KspTo/wI7fpx/ghH4SQIkIFJzJtm9WS8w+UxAauVu6HhUqSTXv
 eIsHUK/8PR5aLsWrCYFGsCyRSgkZPT9gM04Gl0xitr+9Qk+1GftyI/jEcFat/YPFN5FH
 fca0u1Zz6oTcBC7T2fdCZF1INmrCwD1uzDlqhINp8IhLxpmq2FMn9/QnqarZv0XPafdY
 fgayIsgszD+3cJ6nAi52F+wHBIYrp5lFBRw9afnzJivao0LB6e3MZkkAIzMw8H3aSG4j
 Qi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751387754; x=1751992554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O/6EiRS+dKF8gdeapMmBXhGH7wQxCu8g5WqEtX2r8X4=;
 b=S+LKR6QGyJTUr2n54jmnZUVroZr2+xIje1vduR0iR+HsLlFsWwoOHcpTwMyPUH3GQC
 AsncQHRM9Ruptwe8zXylUULx21kLH8BYPtI4+g6vhkIObhUvuz6J7k/yYZ6XjW7uiQEc
 UKBGxT80UD54p9EWBQnio4O8ttsBUvWIVNGmc6UGIr1FeUS7yLMzV0CKMK4UNe2x2i9v
 KhJQuyoe5my6aL4SD0pxsQl6C4CZ5lNmwg6kOw8xU38t52wOrzFZkn91jVyvtQI8YUSO
 9chFSq0tceYI4blB9InK2tRhSBUGI8Pd4SBOoKRf+PXP8I+Y8uB4DGLoLpoK5aLmeZ+W
 yd+Q==
X-Gm-Message-State: AOJu0YwsUjdMPvgNcAsj76eCpOZv5HpIeOZ3eHBs0CalavaNENIZv5DN
 grslLXzIf4TQ6KWzhA+89VJG03ah4Ibnj6YtV3p5BylICTSGVS9/ymBlAKf9/y5Qiz6te+blcTG
 a2g66
X-Gm-Gg: ASbGncs4pt6rvE/rpOKT69YaxSyrL3RcrrFENtmoDxxxv8tG1nsyWy34aHb3AQ4o+26
 XzofxOeI24/qQvnKIkARVUQp/pSZf/XBSxN76UQ8rUQoaYLxmuY2ZHeEsBvn+3vtGaxRBNWFYSU
 AVqsurBIuwtA5vgcZ2b+z4+FH1BmRT3DBlBxI8bRqlv5iWYdw5nz6TBRok9WONXhSe/ZR+oHObb
 +znbLY7wMQh0MoSoLFYYk8F67NbRXCdAtwJ4Ze1iqrHp6M0HPXgTyE4ZeZmKgXjL4ChXBjp9Ht9
 dEyKH9GgVknIYL2euh//Zlia0zuK6bifWjLPPWF9QWevH1F00xpnFZQ6POBCOrJJXCIFI8L/3Al
 AGq2meIKzjQ6GYEdCpZcGEBtpAUE4aw==
X-Google-Smtp-Source: AGHT+IGSGrRQ1JutHZUB8+W+IN4OH7awrZLyDyP0F7Vz8Cx9NBcL0Mo1gD/6Cnck9VVefvMdHWPm9w==
X-Received: by 2002:a5d:4886:0:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3af100ae54bmr3299204f8f.18.1751387754132; 
 Tue, 01 Jul 2025 09:35:54 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3b3213sm168819815e9.18.2025.07.01.09.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 09:35:53 -0700 (PDT)
Message-ID: <c9a161db-1220-452e-88bb-7887bafb6986@linaro.org>
Date: Tue, 1 Jul 2025 18:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: Report TPR accesses to HVF
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@linux.microsoft.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250616090632.55214-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250616090632.55214-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Ping?

On 16/6/25 11:06, Philippe Mathieu-Daudé wrote:
> HVF should be able to handle task priority register accesses.
> 
> Cc: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Untested as I don't have access to such setup, noticed
> during code review.
> ---
>   target/i386/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index e0aaed3c4c4..a0555e74cc6 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -549,7 +549,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
>       X86CPU *cpu = env_archcpu(env);
>       CPUState *cs = env_cpu(env);
>   
> -    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
> +    if (kvm_enabled() || whpx_enabled() || nvmm_enabled() || hvf_enabled()) {
>           env->tpr_access_type = access;
>   
>           cpu_interrupt(cs, CPU_INTERRUPT_TPR);


