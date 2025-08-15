Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA46ECA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 06:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umnrJ-0007qT-JW; Fri, 15 Aug 2025 02:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umnrH-0007q9-Vq
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 02:24:12 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umnrG-00048v-7a
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 02:24:11 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b472da8ff0eso91404a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755239048; x=1755843848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FskWgedQMwIjQLSn2I4gWdMD5wPPB5Uw2SpTiRgRz/Y=;
 b=oeTbbL+a+wjmJiFMCEIDUsAf4zUm7moZFASNpIs99G6c9clmprGf6E5Ru05fnDH5kn
 uASiW7NW3Acntfoie+aNlMnMCcpCn6TDipYL1XupTOcoMQcC71oE4yHtedd5BVDYK3gL
 G/xQOyKLkp+xTtXzHxJ4iL/XHef1NuO5osomQBTggHXPAIcBrQLAkx1bH9FUVRr4F3E+
 hRmyNIcJ5gIrCfhuZd+fDrrPwX9f5dtITUMAUIdZ3F05ULzo+9BpQ/ir6zNlTpx/RTbD
 qGf2hlexra7ul7yiTq0p6WkoGG4I2yR2kvMIZzv/huFABP7vTjT/0NiITH5xhZfelWIs
 ZKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755239048; x=1755843848;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FskWgedQMwIjQLSn2I4gWdMD5wPPB5Uw2SpTiRgRz/Y=;
 b=GfaWyOY/ubtYiOkRhTmIji7VLetquM8raldd837WeuOrBN1Iy3wEeU0DKHlD4lq7JO
 LDMfKWqaOgdrRCgnqVvvxHxIrXc6V4hU1qWku8CagRTEGRrEhx7UKc0xYVvQI3+7rcfh
 T8xbjVRRoaKdDeiNVpiWSCpNoNf5Tg2gyrKaN+lAGwZ2sz/Dbpe6rEJfuRDs/+pwYFRy
 9Tkyle13r64ldmGbd27PjxooRuamMpOzBfCW5GMlHRn4sPbc0A0lrgq+hdzopx+1HQxi
 Pz3tPgQERzGdzIOTT4CmlzbXHiL3PA5GpCEQAWSUfbJtJiYG0roY2sAIwcs52uUu4OmW
 4u7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZZOS1KWhIKSrJiZSjPZWdZGUDhDgp6L1VO6HiiTo03HqMHTsWmciu7/XisnNmxSOECR0ZeV/2ham5@nongnu.org
X-Gm-Message-State: AOJu0YxNbh9pN0Vgrv5BcHuAogMNZjlLtJvqLwNeHYIsO9onnwDc82zp
 au4va8EjwOpJSyJ74RRlbA4bPIodV7FzJcpciTA66BIC5gZoqiPYnu0g5Eg7d1i1NWs=
X-Gm-Gg: ASbGncui8c9Te+InrRtPdL6QmLK2u77mP4nhnSkzVj+s19XIAAUCrS1lHFW845maXqF
 VOGIG2gl6Z6kbZDxSMfMs2dsQodWC5ItNDmezh5USn38VTh1+y3LwdWpRXnMKysCb6e1WIqsAeT
 NipBZGF4cpHfT7IGmEy3tKhr0E6ungJ1svIsVuRerhLVhtJkV0j5/F+A7+ekG34jPosv+3pRjij
 lBDRVrnf0OV+FYWbN3hqvSoxsIMMLAk+K3mwhWDZRZA2gZ3WU7xoE/VQ7FIhk6tqpr06ozOIBai
 mMG1rHl8PLSx714nDBdXwsR/xR7dzl4Ehn4VmGzJzoFLMX/E1r1fw9PTVnXjPXrBLqw7ryJmz1Z
 9MXUMHHIMcdMw8DbxGpzBXc32bSjzzeFILd2XwNA=
X-Google-Smtp-Source: AGHT+IHVFl4Kj2QNdtIdOlLMy7ekNRtlzsuwoey+jMec9PqBBBCK98thjJibLHmmJPKg7NxVmELe6A==
X-Received: by 2002:a17:902:c94a:b0:240:9a45:26e6 with SMTP id
 d9443c01a7336-2446d6e8a61mr14127065ad.10.1755239048290; 
 Thu, 14 Aug 2025 23:24:08 -0700 (PDT)
Received: from [192.168.4.112] ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446ca9e000sm6904455ad.27.2025.08.14.23.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 23:24:07 -0700 (PDT)
Message-ID: <ee8abdcb-de14-4ff5-b454-b60a454c4740@linaro.org>
Date: Fri, 15 Aug 2025 16:24:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm/kvm-all: declare kvm_park_vcpu static and make it
 local to kvm-all.c
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20250815053021.31427-1-anisinha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250815053021.31427-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 8/15/25 15:30, Ani Sinha wrote:
> kvm_park_vcpu() is only used in kvm-all.c. Declare it static, remove it from
> common header file and make it local to kvm-all.c
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   accel/kvm/kvm-all.c  | 3 ++-
>   include/system/kvm.h | 8 --------
>   2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 890d5ea9f8..41cf606ca8 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -141,6 +141,7 @@ static QemuMutex kml_slots_lock;
>   #define kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
>   
>   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +static void kvm_park_vcpu(CPUState *cpu);
>   

No need for this, since the definition precedes all uses.
You can also unexport kvm_unpark_vcpu.


r~

