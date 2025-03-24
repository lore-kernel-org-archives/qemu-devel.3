Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC1FC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 09:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twe8V-000590-Bi; Mon, 24 Mar 2025 05:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twe8O-00058N-2X
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twe8M-0000cb-Co
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742808612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0JXU5pRRY9gsgeef4yq0ZYoQdOJr9GVQpFHfd70Mgww=;
 b=WSLU8oQETKxTklATa95SmcXSQbnZy/I78SrYEfLeoQBw5FQpzFi5zlIUXvkpLQnmIbioq8
 d/lxIY1LPI0sSfHcsCqwuaV/UYzIHRGw8TVaobKXcnvnMmfQ2DI1GfXJLctKWNkuioVaif
 9GL9ADaZIElKhln+d3y6UTc7/IXpDAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-qAOx7pMCMRCPwMQcAEIViQ-1; Mon, 24 Mar 2025 05:30:11 -0400
X-MC-Unique: qAOx7pMCMRCPwMQcAEIViQ-1
X-Mimecast-MFC-AGG-ID: qAOx7pMCMRCPwMQcAEIViQ_1742808609
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce245c5acso49319395e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 02:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742808609; x=1743413409;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JXU5pRRY9gsgeef4yq0ZYoQdOJr9GVQpFHfd70Mgww=;
 b=m8HZ8irdXN2TH2q0stT6NWXFWqGKwVDqrPanVIVCZrL3cWorp949p1G36ZclgegOaO
 UzUvteJoX8NU/GJn5ObLKau2IDo3l8/zw+rt1SumCFQ6BfZFF8P/c3NEC5pwXBi+0RUn
 j4DBp7ujHFB7TkAhJI50TZ3TfUQyKAJdkhJBqISRPzXB9Mo7LVMW6mYfI+T4INDHlQQ/
 gX5W/olxelYRX7ALRbJkTBSd2DZlsj5t6uH4ktJX0kW+kskQ07M4VoqkFQNh1wcQjjZU
 p2y34ZR9vHt61fxPN9VFN/7y6RDK9ELp5NZe/9bNtKqd/VSVzQFhiIGmihk753JqskzL
 +NXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM/yf+kHbr38cyKy0QDb7CBQDje5P6MoHc/48G45dh9B3a13fRJZRey9VTIK9J/kgXLbf5NhxShtTI@nongnu.org
X-Gm-Message-State: AOJu0YyAp32DLtM8Q/NjR6zXYVe79oFF2uGAOH7VpwxwwyfWzivFXzAa
 VU9RugzP6RbIPxi0JcPfNGgl7dQfKpK+6yhHnDU3GTcaJJ/vn7JtDKmKYoWW/kGC4Hldf+CAfpK
 DBovA893u6pr7JwJNk6wVSw4xfgal4nQwCTSpHdGQd180CRc0tRUyAaXq/U5n1nU=
X-Gm-Gg: ASbGncveNKwTpxVc5C7/2o9WqzEw2bPDOWmt3RhAbhsyYngvR32P/hiffQWzymU565e
 AS8EBIe5ACUvanRiN0K7zcvY1VQ62CuF2Z4w9CSybqShUpj1IeAVOxo5b4R0G7W3cS2Q4eBil8W
 oqu3Lfs3y/0xvSmkgvig7uZe101gsyNah3+PtEcO0wfX8leEoFksH4y2iJjmfNk5f3oA0hm4oLO
 0/GTcgn8x+8lJ4IsTWBexlxSOOCQJXCXdqTce+oF9IzKKt9tbS/RB1bUMJIryHH5inuwGoN33Q6
 RKsxR6XblPb+lV3KO+zOVk0ax4oq1IyUlf3lzHcR
X-Received: by 2002:a5d:47a5:0:b0:390:f699:8c27 with SMTP id
 ffacd0b85a97d-3997f902e3dmr9964694f8f.12.1742808609038; 
 Mon, 24 Mar 2025 02:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8EjFFlmetYJ2148IJ+GTBCpB/JwWCtg3HA/wWmoJ8XZAgFsncnABuA3gBtwzehm97oB0gjg==
X-Received: by 2002:a5d:47a5:0:b0:390:f699:8c27 with SMTP id
 ffacd0b85a97d-3997f902e3dmr9964655f8f.12.1742808608589; 
 Mon, 24 Mar 2025 02:30:08 -0700 (PDT)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eef37sm10206764f8f.85.2025.03.24.02.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 02:30:08 -0700 (PDT)
Message-ID: <8115b7be-03b8-4d08-8f7e-9d316f11e082@redhat.com>
Date: Mon, 24 Mar 2025 10:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 5/6] target/sparc: Register CPUClass:list_cpus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250323224035.34698-1-philmd@linaro.org>
 <20250323224035.34698-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250323224035.34698-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/03/2025 23.40, Philippe Mathieu-Daudé wrote:
> Register sparc_cpu_list() as CPUClass:list_cpus callback
> and remove the cpu_list definition.

Copy-n-paste error in both, subject and patch description: This should be 
about s390x, not sparc.

> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 5b7992deda6..1aac967a0ce 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -902,7 +902,6 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>   
>   /* cpu_models.c */
>   void s390_cpu_list(void);

Don't you want to remove the prototype here, too? (and make the function 
static in the .c file)

  Thomas


> -#define cpu_list s390_cpu_list
>   void s390_set_qemu_cpu_model(uint16_t type, uint8_t gen, uint8_t ec_ga,
>                                const S390FeatInit feat_init);
>   
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 1f75629ddc2..ac05e82f0ac 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -378,6 +378,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>                                          &scc->parent_phases);
>   
>       cc->class_by_name = s390_cpu_class_by_name;
> +    cc->list_cpus = s390_cpu_list;
>       cc->mmu_index = s390x_cpu_mmu_index;
>       cc->dump_state = s390_cpu_dump_state;
>       cc->query_cpu_fast = s390_query_cpu_fast;


