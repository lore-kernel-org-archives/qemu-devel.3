Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EEEC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63Nr-0001WG-M9; Mon, 14 Sep 2026 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x63Np-0001VU-AA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x63Nm-0004yl-L5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789379629;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dELGJhrHKBVrhI5nHM5smk9mInIrLdrlsuHiFocrFJs=;
 b=UTr6AYv+hwCDzSDYkRZFO08C5+AuMBcM57uqJYZxxRO56XiONZiKM+d/D1tJoUH2bbqUzw
 cMyQo0ACVvpe3VNoPjxaOYlrb4eeNyfMLD5DmcebBINjW/7eQ6e9jD5y+kRYUwzDv3JCvG
 l/DDRgwu/mOPsHWArCCRuYlP9lc1R2I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-jXhvXOqfNBKTSaggEGd7XA-1; Mon, 14 Sep 2026 05:53:48 -0400
X-MC-Unique: jXhvXOqfNBKTSaggEGd7XA-1
X-Mimecast-MFC-AGG-ID: jXhvXOqfNBKTSaggEGd7XA_1789379627
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48585fce16fso446209f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789379627; x=1789984427;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dELGJhrHKBVrhI5nHM5smk9mInIrLdrlsuHiFocrFJs=;
 b=ZfH/4DXfkZVSA1LSCZQiupV8qlYe7SP5e6W5/eNI6DhynnBcLlaRmdCbx1N7pTUXZP
 HOd+MNLM/68+lDErVS7271YVg1hKrt0NGU/JUJkq+UZ2oi9+sWi6RoJhkzY1nSuT2noI
 u8VbJNvssqXgMaUcyOouSIw7Lil0XX1P4q1wSOUoNheH4+YRYIkQdprg3ks0e7sXERue
 C7q0pWWlAAWScxoL0bFqDet3RmZqfDumr5LU4hDQLltaOyrzF35Cmfbn/b/sAK2evFy/
 s+tbZPbceMwkKAAlXAa2jH0aTSm/MUxWd6TenTGszJmwD5KDiDLRdleCwu43rnWPzPVe
 TOTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQXyFg4WQGmVKsGq/ehPa0R6h8N37WwyOr/BB72cz0jrM+H4MCGBdIhNKZIfCcxWGTFDKSnMI718lu@nongnu.org
X-Gm-Message-State: AFuF++mO/HDpgg2ecKlj1eVgQRmN6qkOO1UORnQLldt7zbhNxpMLk85I
 Ap3vjZncItJOj7oj9KGDvTeuy4DBY8iowzOea88WobLKJPw7PoyzGmFh+5ZlwnJ80OmEatONWra
 S5FyylosYzHIW73HHt4tpMKoJtbL14albVn+SxZWrAfYIaVIbWq8Ca8RY
X-Gm-Gg: AYBFou3l/ERWjuZHRDttKcyyTHcDMy3T/F+OTVcWFOB7L2X4PB120zSCn46vGWdfZF9
 ptwEnmYFbIY1oECFrl5Wn7dcI4boS82gazEiRr9Cs84s9AiYsIBEGc1Meb3JvmhwmHl5SdDjvnP
 0P9JWz9prTcjXZ5gPjveObqzj9jQBHe9eZc4Iq+Qx6y2mP5hZikY7Imm2LILJZYD3WiMz6CTIga
 b9fSHKzzrc83rOUlnuTBkWCyenlg3t0vQ2MuHVT56RWEOAjy4zh4fk71HKnQfW7sHKn/C3KY3zh
 itpQrE1Gd7dlZ+QWrO6yXwoiTLfXNwerzpUhoaa0D/seRqJ/NpsZxQrXB9mLn8PkCYzuDaM5dOS
 aTlGc5Pk5xF6Q+Yo3eY/0MS1I2EMJKUXPBwFcgAA9MAXJAbh0
X-Received: by 2002:a5d:6f1c:0:b0:486:e738:323b with SMTP id
 ffacd0b85a97d-48702a11c08mr3653865f8f.0.1789379627074; 
 Mon, 14 Sep 2026 02:53:47 -0700 (PDT)
X-Received: by 2002:a5d:6f1c:0:b0:486:e738:323b with SMTP id
 ffacd0b85a97d-48702a11c08mr3653798f8f.0.1789379626510; 
 Mon, 14 Sep 2026 02:53:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf2esm25914166f8f.2.2026.09.14.02.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 02:53:45 -0700 (PDT)
Message-ID: <4fe54219-7496-48b9-8d14-d67241e0ce06@redhat.com>
Date: Mon, 14 Sep 2026 11:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] hw/arm/smmuv3: Support migration with accel=on
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com, jgg@ziepe.ca, ankita@nvidia.com,
 aniketa@nvidia.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <20260904180513.248396-8-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260904180513.248396-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/4/26 8:05 PM, Shameer Kolothum wrote:
> With the restore path in place, allow migration of an accelerated SMMUv3.
>
> Replace the blocker installed unconditionally at realize with one scoped to
> CMDQV, installed where CMDQV is actually selected.
>
> CMDQV migration support is not enabled now.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c | 11 +++++++++++
>  hw/arm/smmuv3.c       |  5 -----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 3f83b505d0..5456fd0ae2 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>  
>  #include "smmuv3-internal.h"
>  #include "smmuv3-accel.h"
> +#include "migration/blocker.h"
>  #include "migration/vmstate.h"
>  #include "system/runstate.h"
>  #include "system/system.h"
> @@ -801,6 +802,16 @@ smmuv3_accel_select_cmdqv(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          return false;
>      }
>      s->s_accel->cmdqv_ops = ops;
> +
> +    /* No support for CMDQV migration for now */
> +    if (ops) {
> +        error_setg(&s->migration_blocker,
> +                   "Migration is not supported with SMMUv3 CMDQV enabled");
> +        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }
>  
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 66d95e1076..8e8ca341c9 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2047,11 +2047,6 @@ static void smmu_realize(DeviceState *d, Error **errp)
>          if (!smmuv3_accel_init(s, errp)) {
>              return;
>          }
> -        error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
> -                   "accelerator mode enabled");
> -        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
> -            return;
> -        }
>      }
>  
>      c->parent_realize(d, &local_err);


