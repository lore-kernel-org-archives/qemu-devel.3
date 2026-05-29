Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D154FCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 20:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3mp-000457-O2; Fri, 29 May 2026 16:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3mn-00044m-DW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:26:29 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3ml-0005yZ-UR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:26:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36bd175fdbaso503582a91.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780086386; x=1780691186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ML1LIOLIlJ4iZvJ1NqUwx+/NKaZnVmux45V5//Y2gA4=;
 b=Yb2lcxjH2ckwRPJU0odP5iZwd/KSjdc7K0dmCpRWKB5CIXcJ0bvO9agPB144kz7XrO
 NeHRA4qNWmpFzmhMJj/ehJWXjOi1gKDVlg9KW69eSJ6pjqVXjsGhO41YAuqvoo6GQMv1
 UjPO2Py1neaSPygPImJG9+jrTcNaemGKvDCkP4e4jbcAhQdU5ikF2La2WH5z5X8GA7uh
 tQrX1YPx8GN5KIqieNd/l7xofyu8Be+U4YbulYV6p5c3JKFqsm7JZxm7GxPACmU0inKB
 9NHYH/YeJpKYCzG6P1OFqJb9PCSfC0uXdIVVkmHFiqE36dbeyBhwWtJ8Ue+XYloZuOk0
 IbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780086386; x=1780691186;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ML1LIOLIlJ4iZvJ1NqUwx+/NKaZnVmux45V5//Y2gA4=;
 b=iBtapWt2BO1/gF275mX4S/VfJHuFBuuDMaswo/Ysyz8/qpoP5TrCAohO4pHNCl3BUn
 KY54WUsUyzTgK4sxAO5D8zRfBdAe/9IdgR1QhbTZJ6ooLX0acWUFV/fFxAuOi0FV1SuG
 7nsQORRH7q+rJTYQJIW4sMNHhUqyFct2bfa6rDskpQ9acxHiM8MPmZpOhHN0cLPY8qpK
 WCj66bs2IaW61DSvIIWa6r5PmASfZZKyOqGdGYQl6fXmprT3T44u9cIUsTW44PUw3GY7
 M+3OLfmy9vgsNSYXLLJ4bVmTDbtsrCabTXs/pHfn0OXnZIO3AR7TIlAnqNJgG16lorWC
 5GMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SvQuB1YkFjcVQPiAArpMq9p5kZrBijxK4bvakcLdV088WF7pH5sJ0b/sM6iug1NccL7odgmSFqT+u@nongnu.org
X-Gm-Message-State: AOJu0Yxd4rxSKckAPzDfzzmfe8ZGHcIZsozVd88kVrz6xekqpYXTXRQB
 bpLwvPPQeYlnadpfQyfdzbM4ikBIDKULZ5I1MpZO/Shtv3NsLtHsTgudjQZZP7Nx1Bo=
X-Gm-Gg: Acq92OG5SRQbh7BnqDWKkHHR2ZsYIaf5qmu76IKqjS3lEAf6/i2lfdWcr1TEWHItCRX
 grYSGlCcekqpmjVAks1V2+4UgXgWUG/Cq+WeNIAq4Ra2qZSNkxf12lEfws7oqQWQv8OxnX0KtMC
 r+5PXhadTv7wo92sXFl5M0CkURmBwlEFOgW+o6LwkKLG5cvGxjdzo7tAnUngEAkk8NV5mfnj1HV
 ZbPS2JIdsQSlFIxzDfaSxv/a4FrNBAxbkkVnXiQeS1G+XBzD71oPsjPIy8PdQ99Botx7xtyqqpG
 U1YIozenfSjUrSBl/QI9jnrfQXnghXtunhq+4izDOZEDZdAbrku+8eAkgEcvW+Fpy2GqRffdP4h
 jgMJsMQgKghtTrhk1/EKIGjEvvJQeZxxbrISBATplgmq4p3CwxGlt/lDii1NZvHTj7lamTtSsI/
 mRybSY41dBEQ+/zTOnWZQexT9no+ROgQ6xUjmZtQ1jgRI66UQ=
X-Received: by 2002:a17:90a:fc4c:b0:36b:e109:1e63 with SMTP id
 98e67ed59e1d1-36c685a8f89mr714711a91.27.1780086385915; 
 Fri, 29 May 2026 13:26:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bbd667fa4sm2208732a91.0.2026.05.29.13.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 13:26:25 -0700 (PDT)
Message-ID: <487552e9-b75d-46b0-b9d3-50272f5255a3@linaro.org>
Date: Fri, 29 May 2026 13:26:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/nvram/fw_cfg: Document and tighten up register
 layouts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260529174639.451353-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 5/29/26 10:46, Peter Maydell wrote:
> Peter Maydell (5):
>    docs/specs/fw_cfg: Document all architecture register layouts
>    hw/nvram/fw_cfg: Enforce standard layout for fw_cfg_init_mem_dma()
>    hw/nvram/fw_cfg: Enforce standard layout for x86 fw_cfg I/O ports
>    hw/nvram/fw_cfg: Remove support for I/O port fw_cfg without DMA
>    hw/nvram/fw_cfg: Document fw_cfg_init_mem_nodma()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

