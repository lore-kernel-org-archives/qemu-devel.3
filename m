Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A44C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6d9-00005F-1O; Wed, 17 Jul 2024 11:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6cr-0008OQ-RB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6cq-0003wu-07
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721230287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4ZHdx1No2slFPya5wMVWYTJpX1xJhqZkiTzk46H+D0=;
 b=OQk95jC8etRGC5Ruwxlag/6FVF5OP8lviFkIx45UivoX53Xcxv9ryB8IKqT4/XVq1zFUOt
 yPhG+D8UKsdywMGUCoa0hXOkD6Fv78Ev57U9tWUkFwqbW0oFFx4vlAYzbk2pjX7KlbUfxc
 xFKhdAbNcpg9LWCYTxSDH6hcjWBqkKo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-59QxLsKdPheUx4NpqOHeBQ-1; Wed, 17 Jul 2024 11:31:25 -0400
X-MC-Unique: 59QxLsKdPheUx4NpqOHeBQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-79f06a617a4so183221685a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721230285; x=1721835085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c4ZHdx1No2slFPya5wMVWYTJpX1xJhqZkiTzk46H+D0=;
 b=oeXaCL0eW+ab3Idizs+0pfPZp99KWCT6Kf3Jd7yA6qnqrmciT8N/9Eo/y5yGVsKuJc
 trttUAjPIhmKQuxZciqF2BX/zUOs+l3wW5dlsyU0vzKp17BHli6/UknYeJzmb6oLenDQ
 1FUGa+8ZzV+o+S3C9a4nIe95aWyOyYMeznLZqnPG++k3VDsaYFniBzcCB18udCBnYisr
 n7s3yGEyRmfCEe5YElKnwgxCNC4spc8dIrdZmTUoXWqljhmvf6x7M3VxY9P48o++tgFP
 UhqtaXVMQ9IMIM+gNyjjN/soj1VGFaWUn4qRy1vaXyBEiKe7gwSqipNztP+KrUMbf6ZO
 oIGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVteyl+W31iXLDq6K9tSIz4Ym+/23C7Q71vMXJ6Jnv2HfF7WkqWK2vn8uzx9EV681ie9X0bMHjdI7SjNOTjKOiMbWbQgxA=
X-Gm-Message-State: AOJu0YyxSD0zkNqVOcSR0oEqwgZw5yi/nU4OvZt19b1RYl3uYCmvWL21
 xcArK+DL7k3EypzSm7mN4kvrgign1JQGwlXEged9P5RIGJa5mBl9HALwZwxnN7+cU4jbT0r46WT
 IfYbIdrT6GioDzLwTuvRsBeJ+wsFjfDKgnfsapo4p4sXL1L9QG1wn
X-Received: by 2002:a05:620a:f03:b0:79d:7893:1cc with SMTP id
 af79cd13be357-7a18da82ce5mr2742985a.12.1721230285106; 
 Wed, 17 Jul 2024 08:31:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPcvxy56CwJX9lYyvgVDqLc9DXu3mi0bFReMVtpQxIYc+NVdb8anStfNIn711SxCDHRH0lHQ==
X-Received: by 2002:a05:620a:f03:b0:79d:7893:1cc with SMTP id
 af79cd13be357-7a18da82ce5mr2735185a.12.1721230284481; 
 Wed, 17 Jul 2024 08:31:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160b92ba7sm414925685a.27.2024.07.17.08.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 08:31:24 -0700 (PDT)
Message-ID: <81699528-a000-4c0f-bd72-006bdb460f9b@redhat.com>
Date: Wed, 17 Jul 2024 17:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/18] hw/arm/smmuv3: Handle translation faults
 according to SMMUPTWEventInfo
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-17-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240715084519.1189624-17-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/15/24 10:45, Mostafa Saleh wrote:
> Previously, to check if faults are enabled, it was sufficient to check
> the current stage of translation and check the corresponding
> record_faults flag.
>
> However, with nesting, it is possible for stage-1 (nested) translation
> to trigger a stage-2 fault, so we check SMMUPTWEventInfo as it would
> have the correct stage set from the page table walk.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 84cd314b33..d052a2ba24 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -34,9 +34,10 @@
>  #include "smmuv3-internal.h"
>  #include "smmu-internal.h"
>  
> -#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
> -                                 (cfg)->record_faults : \
> -                                 (cfg)->s2cfg.record_faults)
> +#define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
> +                                        (cfg)->record_faults) || \
> +                                        ((ptw_info).stage == SMMU_STAGE_2 && \
> +                                        (cfg)->s2cfg.record_faults))
>  
>  /**
>   * smmuv3_trigger_irq - pulse @irq if enabled and update
> @@ -933,7 +934,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              event->u.f_walk_eabt.addr2 = ptw_info.addr;
>              break;
>          case SMMU_PTW_ERR_TRANSLATION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_TRANSLATION;
>                  event->u.f_translation.addr2 = ptw_info.addr;
>                  event->u.f_translation.class = class;
> @@ -941,7 +942,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_ADDR_SIZE:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_ADDR_SIZE;
>                  event->u.f_addr_size.addr2 = ptw_info.addr;
>                  event->u.f_addr_size.class = class;
> @@ -949,7 +950,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_ACCESS:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_ACCESS;
>                  event->u.f_access.addr2 = ptw_info.addr;
>                  event->u.f_access.class = class;
> @@ -957,7 +958,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_PERMISSION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_PERMISSION;
>                  event->u.f_permission.addr2 = ptw_info.addr;
>                  event->u.f_permission.class = class;


