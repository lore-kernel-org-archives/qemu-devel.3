Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24906C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrVM-0000WY-Ea; Tue, 28 Jan 2025 14:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrVK-0000WG-P9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:44:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcrVJ-0006g9-7Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:44:10 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21680814d42so99561175ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738093447; x=1738698247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04aeoJjB5IJnzmcHt17DQP+KPYap4dU3QzpuAnykwIc=;
 b=Eqel5ZpfqY2QM62yXd4ovBKGSbKFmSbZ7JFUMlptD7JezZzN29P82TriD8NsQlRrby
 UqYQqujwOwsyOy1MF0kkryOIXs5jmPlIgGWbzmrcWrNbwG9yF3+GSgFauLnRBRT6n3QW
 ln65SQHjCPB8ikrowiJO35exl9dWZWeutQwD5Uw4B6objTZArekjd+sima6y3o5e0Omj
 8H1xwZZ5Avn41iux4dBYYG9nb39PFDD35ks7dn9Z3n6YKGbkDtL4pVAvEWGhA+2tArwh
 RW6+/40nxTjthPq6hm5hc+3kGgVw7Hl7r4YGrE3gNTHxIDybYAb5/azAmgcMmuFCyYyS
 w8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738093447; x=1738698247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04aeoJjB5IJnzmcHt17DQP+KPYap4dU3QzpuAnykwIc=;
 b=roGKDhlYfYfdfwX+YNTNp2GHRGEdwRBVfmDFhnEUEoMUxELGhXjSU34zQ4qbLFdcF5
 SEOgQ2SIK9vkc2MGI/hmslJ707+xEcfDXJPR4HBTdaetS11nfFs7OiyRTkD0ri3azqj7
 e0srDeeXs7ZccCoXbeFyJRwK1IYCMYurXiMhpRdnpFEkzSENkAEb9uJErCAEe2R2IewY
 bZ7pLXt+kwtS05M36VSwa4aFn+wi45avb8qkVn3ghsI7+o3uDaG4IO8HZ6A2Z8Af9LYB
 fXX/A43MbF+vtub2YQYW87ESHx6+EqXJdMfgOEgUj7dhxe02EOtZnjG0s20Vqsokgw+u
 u8dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDwPY2Jz1Kk7n9c/Vk3oJu9tnFDh+MPMCNSLEL3S3cjk06xg7Tm8tC0axptAoXwwVCRzSQ4A2XXN1y@nongnu.org
X-Gm-Message-State: AOJu0YwS3gP3atVUYM7H7MEpmxAKdb4wLOwi8AqW3sdQIdtv7rgMIZ6N
 Bkjmsqo6Wkjvhja31hHlQpMdCPF0S7V2OPkvWcEfDQFXXn+dMxEI0pzgJSdtrec=
X-Gm-Gg: ASbGnctHP9hvwpHSvWw6Zl1DhN07oTkujeLa8M4JLu97/8HjVGB6rO+cakdt75W8nGt
 0W/1HucQQPF6AxPJQnXFG2WYigh/20vsQEER1HkUx9s/lG4dY5Jc6d4N73Qy2I2UoxPCSSngwKE
 AXepI5LSqvwXxyhwTW5YT+4DXeyIzpfmYdtXFokKNYrgKCMcT3cme8hLVFLX59N6hx45AtTmIUU
 dO1cL1EkFJAmh6ksR+CklYqpJfyepWV6MrwN47aDu4Wy6lAO5/5VJ3lqKa9kNhPyNmxu7NlWcAq
 EYivCcRHGNiQ8B/+gZbCs4A6iQxsWe8ulXHz9RkvaHEuIcK5oReTtKpr/g==
X-Google-Smtp-Source: AGHT+IGLzqDcatxwCQOibIRSu3TFdbVWQAuI1VMxBkp+tnwkmB/idPX29h0clhe4fa+EBrptVCtyvw==
X-Received: by 2002:a17:903:2f84:b0:215:bc30:c952 with SMTP id
 d9443c01a7336-21dd7c49ad7mr4386245ad.6.1738093446728; 
 Tue, 28 Jan 2025 11:44:06 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414c483sm85530395ad.159.2025.01.28.11.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:44:06 -0800 (PST)
Message-ID: <aea2b578-78a4-4252-9cfb-c066fa2e3a80@linaro.org>
Date: Tue, 28 Jan 2025 11:44:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/9] accel/tcg: Simplify use of &first_cpu in
 rr_cpu_thread_fn()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> Let vCPUs wait for themselves being ready first, then other ones.
> This allows the first thread to starts without the global vcpu
> queue (thus &first_cpu) being populated.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 028b385af9a..5ad3d617bce 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -197,20 +197,21 @@ static void *rr_cpu_thread_fn(void *arg)
>       qemu_guest_random_seed_thread_part2(cpu->random_seed);
>   
>       /* wait for initial kick-off after machine start */
> -    while (first_cpu->stopped) {
> -        qemu_cond_wait_bql(first_cpu->halt_cond);
> +    while (cpu->stopped) {
> +        CPUState *iter_cpu;
> +
> +        qemu_cond_wait_bql(cpu->halt_cond);
>   
>           /* process any pending work */
> -        CPU_FOREACH(cpu) {
> -            current_cpu = cpu;
> -            qemu_wait_io_event_common(cpu);
> +        CPU_FOREACH(iter_cpu) {
> +            current_cpu = iter_cpu;
> +            qemu_wait_io_event_common(iter_cpu);
>           }
>       }
>   
> +    g_assert(first_cpu);
>       rr_start_kick_timer();
>   
> -    cpu = first_cpu;

This final line seems to be unrelated.

I'm not saying it's wrong, but it's certainly a change in behaviour.  We no longer execute 
from first_cpu first.


r~

