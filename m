Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF89EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqhu-0006RH-4j; Tue, 13 May 2025 10:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqhe-0006IM-Op
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqhc-000895-1h
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747146830;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y909bR0YHzufKEcfXdMfMZPq0NlMISVrbvKpfk9Zrzg=;
 b=BrtAd9qkmlGr4f7vMqz9uZySpp+g+enCvZIp4viJEMbo+FSfyRoOtqk5xrto7yITIHlkZS
 JuzQOkcCFuVBeTzGnw/9jv9hRyWkIigd4B+XduoXN6j374DKVf/9RyAgs7jENGSjtK4hEe
 devzQSpAXVHpgJvJrSsjHmZ5BTJtgL0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-Wuzo--ddPA-Bxub_MJPogQ-1; Tue, 13 May 2025 10:33:49 -0400
X-MC-Unique: Wuzo--ddPA-Bxub_MJPogQ-1
X-Mimecast-MFC-AGG-ID: Wuzo--ddPA-Bxub_MJPogQ_1747146828
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso30858825e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747146828; x=1747751628;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y909bR0YHzufKEcfXdMfMZPq0NlMISVrbvKpfk9Zrzg=;
 b=rNKUBX7JEvbSu1OCpJ7ko7RjTAj0CwdgRvLkl9Lkufaj7G9fjiCDF9GPc/nUSo7HB8
 gTrGCRl5IbaM7pi+lv8kZiyodv5+QS5qrd/YECUkvOm1QT9sVo2dtvJ3PDnhkcuH1qk5
 37X60bjNAKcg045Spo9RkXv9+mE/WdylrM9jomBGcatNZk4M+jFsYktuqH+BE/9JN9o3
 Yvag/WqYMPFFjnIsRbBJCDIg9uu4frGSZ3pPXLVGyMURzIHmxWA9RToQDPyJG15rBLRD
 d8Uydzxn/yO4DiY+N0oAZRFEctHj/Wx9GcZstW4nFQyz9RX+WTdfFtl0I7dhL8BV5aaO
 KRWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm3AYjjqGxKpwWllQpIlBojSYOsFUgtqrLKItuSJDj4NSbZB99y2l3zQlkmh4jP1hJ01zWE3GXVtNI@nongnu.org
X-Gm-Message-State: AOJu0Yzq6c2se4HJH5L2oNHdJT/hIRJuEG+WvmfRRkaM2VQzqWTtXkTi
 jKf/UozV4U6AVyCXOZPhxtnqGb+cK+dqprpUwmIWRpNI1WEqWbGjL4FJACEfEPOSY0lPyeIJcUV
 daBQUOqwvrQ85jKhJwbwq5R1P0NzmYtJa1ZBbrMr7E8YSHKeHooES
X-Gm-Gg: ASbGnctV0cPlNlKnSNXys+YShxJp1bRQZWSQO8iS59bHxQUQz1rjyqKRhgDH8wjWAwm
 SN9wIDi1Wf3SvWdRj6Axj3gB8or0yFIVcC31SnwAxcOo1JqZd/dUFGwu74mgW3y1JcrEa6HHUo3
 cBsV/YTYGyPHZeMUsw5ysBKjuODJL6NBddBkBloQ9PQ4IDGDwwLyQqmmTiSTNS0L38kSlf053t3
 wYrPAPK/sdKTpJFIFUVMwE0f6YplNzv7Cg4DUDh8rvz/BYWdxZOnPKe39xVR2x39vzuHCc3iXvl
 hHejIlGmye00uzmqzJZ+bIgDOjeof/Nj6/nh5KtQttiMl6hrNI/4PntRibY=
X-Received: by 2002:a05:600c:4f53:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-442d9a0db9cmr143579165e9.17.1747146828149; 
 Tue, 13 May 2025 07:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqSymGLiEPl5V0duEN/fsyq3JfX8N2e2t3KGImeE08cAaBoCzAymj5g4i9Yxx8mP5niwfg9A==
X-Received: by 2002:a05:600c:4f53:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-442d9a0db9cmr143578685e9.17.1747146827672; 
 Tue, 13 May 2025 07:33:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687ad31sm168969195e9.34.2025.05.13.07.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 07:33:47 -0700 (PDT)
Message-ID: <412f69cc-a54a-496e-bee7-e80dc1246a42@redhat.com>
Date: Tue, 13 May 2025 16:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] arm/kvm: write back modified ID regs to KVM
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-8-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-8-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/14/25 6:38 PM, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> We want to give a chance to override the value of host ID regs.
> In a previous patch we made sure all their values could be fetched
> through kvm_get_one_reg() calls before their modification. After
> their potential modification we need to make sure we write back
nit: write their value back?

Eric
> the values through kvm_set_one_reg() calls.
>
> Make sure the cpreg_list is modified with updated values and
> transfer those values back to kvm.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/kvm.c        | 44 ++++++++++++++++++++++++++++++++++++++++-
>  target/arm/trace-events |  1 +
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b07d5f16db50..9e4cca1705c8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1083,6 +1083,39 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu)
>      }
>  }
>  
> +static void kvm_arm_writable_idregs_to_cpreg_list(ARMCPU *cpu)
> +{
> +    if (!cpu->writable_map) {
> +        return;
> +    }
> +    for (int i = 0; i < NR_ID_REGS; i++) {
> +        uint64_t writable_mask = cpu->writable_map->regs[i];
> +        uint64_t *cpreg;
> +
> +        if (writable_mask) {
> +            uint64_t previous, new;
> +            int idx = kvm_idx_to_idregs_idx(i);
> +            ARM64SysReg *sysregdesc;
> +            uint32_t sysreg;
> +
> +            if (idx == -1) {
> +                /* sysreg writable, but we don't know it */
> +                continue;
> +            }
> +            sysregdesc = &arm64_id_regs[idx];
> +            sysreg = sysregdesc->sysreg;
> +            cpreg = kvm_arm_get_cpreg_ptr(cpu, idregs_sysreg_to_kvm_reg(sysreg));
> +            previous = *cpreg;
> +            new = cpu->isar.idregs[idx];
> +            if (previous != new) {
> +                *cpreg = new;
> +                trace_kvm_arm_writable_idregs_to_cpreg_list(sysregdesc->name,
> +                                                            previous, new);
> +            }
> +        }
> +    }
> +}
> +
>  void kvm_arm_reset_vcpu(ARMCPU *cpu)
>  {
>      int ret;
> @@ -2050,7 +2083,16 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      }
>      cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>  
> -    return kvm_arm_init_cpreg_list(cpu);
> +    ret = kvm_arm_init_cpreg_list(cpu);
> +    if (ret) {
> +        return ret;
> +    }
> +    /* overwrite writable ID regs with their updated property values */
> +    kvm_arm_writable_idregs_to_cpreg_list(cpu);
> +
> +    write_list_to_kvmstate(cpu, 3);
> +
> +    return 0;
>  }
>  
>  int kvm_arch_destroy_vcpu(CPUState *cs)
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 17e52c0705f2..955149ee1ac4 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -14,3 +14,4 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>  # kvm.c
>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>  get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
> +kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64


