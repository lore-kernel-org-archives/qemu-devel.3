Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DFFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITKF-0001mR-R3; Mon, 10 Nov 2025 09:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITK6-0001fQ-CY
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:56:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITK4-0000sV-1z
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762786606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cM2DwQPWnMIZwjLyerZc3itnOUiJcah2Bj1sbM5eok=;
 b=XePMlidH0McfYbJhTpfOuP0wvrdADSgtiuWtVD4I+woZz4+5FKur7WbxFOGwNUZ0sVIWbF
 BhDbsmjV4Ar1mt/K2ulOxHOveCXdecDWQ2mBNLVzGanHkq/H+K3uu1nFE3hjTRO21gmKOW
 5l5zoWH3dcUAzVXI1WbVoDSU7K4q9p0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-9Ddndue9OKmvI_LrftoMHQ-1; Mon, 10 Nov 2025 09:56:45 -0500
X-MC-Unique: 9Ddndue9OKmvI_LrftoMHQ-1
X-Mimecast-MFC-AGG-ID: 9Ddndue9OKmvI_LrftoMHQ_1762786604
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429cbd8299cso1094709f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762786604; x=1763391404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cM2DwQPWnMIZwjLyerZc3itnOUiJcah2Bj1sbM5eok=;
 b=SlyZ14yM3dIuIrhJL/06UVk1jcyNaOXEoC8p444Q6rRibbbTDjixcwvClsKEP5vsAV
 mgatnRvDC0z4BIMuv1mhdvvxi7/DSnpAtYS7SbtCgPOGrWCJoU0zhNBds1CI0BmYr0V+
 TvlOZwKjnpDxNofWksejIGbvPosf68Z0hK//CtSeVERgsQnYLGRrZbpYTkyAu4akEBbA
 yU8I36ipVnnA1Q6CM8AnnbDQRkBQ19cNmhL8rMdaT0fqvIAf+bXx4tRJ6EHtDFoLNwcy
 X2al+0Qx7UfP/FWyKo0OLI8w0c7FiPJXr/zOERL3bBncP1my0/JXsURDjue2j2PcKvbC
 ftgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786604; x=1763391404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6cM2DwQPWnMIZwjLyerZc3itnOUiJcah2Bj1sbM5eok=;
 b=JyIj22lqumbdxvY+I86XxF+sy+JXck+eSQQA4AdaDNSy0twy+AiQhHLZvs1I/v62BQ
 ZDAT6u0uxAhaF/zPfyC25iCrD43/ahaIvACTIOa48RMHIl00B2Q2uZXHbUNtZgDv9Z5i
 yWiRNZMFZSnQctBvOZ208ZzD6gD8LW+PeElR/k9lkMv+ZeWomkWPSaIF/5Whf55L0ClH
 FJ1XiHTcAl4GAHx+Rt9GJG7MeP5TYskt06YI1RNZI00NnSuskQKh6gIfvUjNW3xTflTi
 BM6/x/Qw0NwhMpaaSqh6IN8SPWDv1qoQJJjMrlJYULVwLZL4XT17KBDbDtxKfVSOrrf7
 RGPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSGcweBTSg1fehZfVjp3NKTgOHPes9hQr2RpnS5ViwIsqquFrw5nCjeMTZ4DZornAt3BlH1AblkeCx@nongnu.org
X-Gm-Message-State: AOJu0YxmYULw0lI7+1q3X7XReqxLhYCGnsCNCueBjpXn1+Hd4YXfFfZs
 q9coEd379VoQuImFVIPXcK3G/SLb4XM5XL1x0rEMLkPgGFQg2cN7F+6bBQh/p8RvXWwXYBgCUy1
 4YhhtWosCbXQ9CZZAnopGtdv8cp9cLP96scCcjvPfAZILLGOIM3Pe+Vhx
X-Gm-Gg: ASbGnctJHuuJEMbpHx4dIpA5n7FANwAqZYu8odH3XZ49cQEe0SZGjfsIx8VZvXHpT3C
 EZVtME56iX3KOu6gk21DKWLqSSPBn//fzS6+O0gTN9Kwv1AL/heV07czER2WCKd7IX6ifboyG5u
 H8J/X8ed0NGP6b7deILe04mfisrG2tk0c/JYHBOTsU1uLSYYZjLY7agRwiIRNjDf4d9kLOQm4iZ
 FBky2J3dZIfJEEmqqWfov9Jo0P+UHEudfhwM+yevlZm/T8IckIX9D4yUdizE8AvsnJefqorRQdW
 Azvhf4LpyByAjXjnfi+lL68VY/4Eo4chHQWKMgeV0CLk4MjrDaZGIFg9hzKm50B7xA==
X-Received: by 2002:a5d:5f50:0:b0:42b:411b:e476 with SMTP id
 ffacd0b85a97d-42b412b29aemr1280696f8f.9.1762786603796; 
 Mon, 10 Nov 2025 06:56:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqffXlXaUV8iTzadTTIkODoWrRx97bPnVr7wBabo7NHbFIY353VbqDAkqEDogoOxonmr2NCw==
X-Received: by 2002:a5d:5f50:0:b0:42b:411b:e476 with SMTP id
 ffacd0b85a97d-42b412b29aemr1280674f8f.9.1762786603426; 
 Mon, 10 Nov 2025 06:56:43 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2dd927d5sm15875533f8f.24.2025.11.10.06.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 06:56:43 -0800 (PST)
Date: Mon, 10 Nov 2025 15:56:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v3 7/8] kvm/arm/kvm: Introduce helper
 push_ghes_memory_errors()
Message-ID: <20251110155642.2bf8eca0@fedora>
In-Reply-To: <20251105114453.2164073-8-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-8-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  5 Nov 2025 21:44:52 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
> errors and injects SEA exception. With this, we can add more logics to
> the function to support multiple ACPI GHES memory errors in the next
> path.
> 
> No functional changes intended.

I'd squash it into the next patch

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  target/arm/kvm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index a889315606..5b151eda3c 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2429,12 +2429,23 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>      return ret;
>  }
>  
> +static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
> +                                    uint64_t paddr, Error **errp)
> +{
> +    uint64_t addresses[16];
> +
> +    addresses[0] = paddr;
> +
> +    kvm_cpu_synchronize_state(c);
> +    acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses, 1, errp);
> +    kvm_inject_arm_sea(c);
> +}
> +
>  void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  {
>      ram_addr_t ram_addr;
>      hwaddr paddr;
>      AcpiGhesState *ags;
> -    uint64_t addresses[16];
>  
>      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>  
> @@ -2455,12 +2466,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               * later from the main thread, so doing the injection of
>               * the error would be more complicated.
>               */
> -            addresses[0] = paddr;
>              if (code == BUS_MCEERR_AR) {
> -                kvm_cpu_synchronize_state(c);
> -                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> -                                        addresses, 1, &error_abort);
> -                kvm_inject_arm_sea(c);
> +                push_ghes_memory_errors(c, ags, paddr, &error_abort);
>              }
>              return;
>          }


