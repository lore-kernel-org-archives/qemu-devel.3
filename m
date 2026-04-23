Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D86FAD3EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjII-00046Y-H7; Wed, 22 Apr 2026 21:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjIG-00045v-SR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:55:52 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjIF-0006vB-C6
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:55:52 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8acb550db18so65262246d6.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776909350; x=1777514150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HCtz7K1W/kT5KEr6GYbvd/GBKUuFwf0Z3nD2u//Qx8g=;
 b=mO55csKOQ+B6MlensBU1StL8yemo/YP7cl/SoNix9051cehT9hNSupykQIZ5TOz7OH
 xk0tUXgPOprBDlkdGlZJSXhpTCykzA/bWhNoQxEYH92h9Wo0Ikwdw6EgHKNjwpwTQvZq
 RmX6KzELYYwpu23wggDh432Q2WiShl4fuE/MpFdQmMrzh1ycYyrLjzNCgOmsCi+zBX+p
 knxMPsDeanhVVkHjUxbwg4T4WdMGW+M81xTr7TGVEYoVE6iWVGKNJqyTaBb51ukgqtP1
 5ZovW5wnTw7TGBF6BjhKQp8/Gz20bHdWXf93CBH24rQCT6X95WWXSFM10ZK1D+ORPyZ4
 sk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776909350; x=1777514150;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HCtz7K1W/kT5KEr6GYbvd/GBKUuFwf0Z3nD2u//Qx8g=;
 b=LRw0sOKn9iHdipXjiGp5oovCNWv3msoi8wTB7CwJcHHkoDuxluhmizvyEVoIE5cHbk
 cv18TFtPRdQvVIzKSanmg2u1XYT3GpQ9gJL/YJDvlVB+2KzCpOaTshTi9mjJed7IEDFg
 g6S9IuISMI3ooJ++F7vqlF/yHdTD5lb2HH0bZ9mcLdz/xAXGdCnHUr5+xEBDH41dWRUt
 bQai1nZV+PYZycfwRw8ah0MB1Z9eLPDV/uGg15Q66hguI0xkI5KtysL4+4jH98WlqQjQ
 imbzW6cGiH/DdsfXUL8fEbAtn97EsJNYkrQZESGQbj/2Fvr0NONTD3iE9bGjeRvdzLMd
 42ag==
X-Gm-Message-State: AOJu0YzU1KsUcz8YRwoRIs37JAmLlO28sVcb0Z6OpCeGYxkvTLI6rE3J
 /EM44SIh8tia5fbXqCFgs3TB1sKgi2nbT8hQPoN2RlqPzT+IHoAFZHhK9kjokzqJhNp1EpSDFbU
 WMWEY3/s=
X-Gm-Gg: AeBDiesH91HC7TF731kZ4XoyfgfHyOXwL1uFkd0AbdGY3A5Uf9NZReRtMUWSbo1QTqt
 W1vn7xdLf4HjsrAr5mO9SCpYylkED8pnMsehZ45D2IABKnbxiFTCj6P2lOs5RED1H2mSBBNBdtV
 h0ampDq/kkenZd5PGc4vkbi2clfb3pXdcGlA+YgkULwwo3C3zndMqwCba25CdO0l/jsgtcBl7/K
 PR7MnL3L/N7qPmxpXvRBbjzeFbXXVMvuiNYPrLliQTs3tXETrYVqMNMSy+y6So3YfBFkYYfoxtS
 cj+fm/0rRYrNOAwwlx4rZC5a/hc76vfcffB4+TQpzhMHa6ZtG2T4jZuVr3VkIrWvZhDyozyqM0n
 POyjEn8BQtS2fd9nJ2XCFDkiuoppsBzytWnaTdfowT2a/hUpSyfwG5DW9BAFn9bY+JajGJ1onUx
 jAnKZ5BMO/BWYuo69dZfiX5aPXFsmnHYCCCpPOkwK7iygGGgLHOy8mqAsGk+E7CZyQKOfiaGVD/
 WF9XMpsBLB/38QLkGTcsrVA0G5o
X-Received: by 2002:ad4:4eef:0:b0:8ac:a689:34ce with SMTP id
 6a1803df08f44-8b02818e4bcmr426648776d6.45.1776909350172; 
 Wed, 22 Apr 2026 18:55:50 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae61332sm139201976d6.24.2026.04.22.18.55.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 18:55:49 -0700 (PDT)
Message-ID: <66ebbc64-7509-47bc-b7cf-27c0b5fd0eee@linaro.org>
Date: Thu, 23 Apr 2026 11:55:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] accel/mshv: implement cpu_thread_is_idle() hook
To: qemu-devel@nongnu.org
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-9-469f544778ba@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-9-469f544778ba@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
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

On 4/21/26 15:21, Aastha Rawat wrote:
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
> In MSHV the hypervisor APIC is always used, so we to implement this hook
> to make sure the AP's vcpu thread is not blocked waiting for an INIT SIPI
> by the BSP. Without this change soft reboots with -smp cpus>=2 will
> hang.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/mshv/mshv-all.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 5ce76e86db..6c0ddbf3ca 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -704,11 +704,23 @@ static const TypeInfo mshv_accel_type = {
>       .instance_size = sizeof(MshvState),
>   };
>   
> +/*
> + * MSHV manages the LAPIC in the hypervisor. SIPI for APs are handled
> + * internally. Halted vCPUs must still enter mshv_cpu_exec() so that
> + * MSHV_RUN_VP is called and the hypervisor will deliver SIPI to wake APs.
> + */
> +
> +static bool mshv_vcpu_thread_is_idle(CPUState *cpu)
> +{
> +    return false;
> +}

The comment, at least, is x86 specific.


r~

> +
>   static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>   
>       ops->create_vcpu_thread = mshv_start_vcpu_thread;
> +    ops->cpu_thread_is_idle = mshv_vcpu_thread_is_idle;
>       ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
>       ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
>       ops->synchronize_state = mshv_cpu_synchronize;
> 


