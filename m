Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC2DC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 08:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8yNf-00008I-0c; Mon, 20 May 2024 04:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s8yNP-0008Vj-ES
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s8yND-0000aJ-8A
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716193678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krc6tNgzPH2+iJleITGbXi8D+vtGRcZ3UX7tAfMsAno=;
 b=icps6nv4Zj3jJ5TLHrh2ivNxOGqR4q+uZs77dOLIoUl1c39Y2i7cNZIootpPaYv9Z4ut2U
 c1t6eOxWuvmFX8+hd8AtH1vTFXvJJBDi2iQLFlaR52q3kYivYiWqNCFQVqwMuAo9JtDFOx
 Eq5jdtWqNzMzVfiD/OmkL3iOz5F+lgo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-rw6wbl2kPlactOu_RkZ9JA-1; Mon, 20 May 2024 04:27:56 -0400
X-MC-Unique: rw6wbl2kPlactOu_RkZ9JA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-792d2abbc65so1121540085a.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 01:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716193676; x=1716798476;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krc6tNgzPH2+iJleITGbXi8D+vtGRcZ3UX7tAfMsAno=;
 b=cOe57/6KZK3IKcU38XSqLr0lVbpbZKneKTp+sXRjDQ3ID6sYo9GiHyK1QD3/E5wZaN
 OEw/lXLilwDeGt6EJ2nIhxM9n3hFhZ8tJfLvGLh4IKHMw7mW4LuuTpDWhfgj9mW2t0Z2
 2GKvqI0WhLoI6HXvMVpBQG8EaqMvvAVVOTEH84GnkGk5OXojQdh/V8o/Oqdvni30Lg3q
 ga67pFzA3+yOkZvbNIcKz20ioM8D2KORMi/CzayojI4G0ESwk2hulIuZLR4zMK+w8Nt7
 8tX3gEo4zoyjDny5DQu/7m+d5KNXrP1S52baRiDhu8Oki6D2ARutUPjoQiC0Qt1MaGA/
 zPWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8bqUW/QdzA9fOC3hElssa1jFHv3wHS5FnG/PlEa4jNqcDd2Bf0S8j9ypnXlVDcxnV5glxYbJpMXocy3exG4xviGzcqDs=
X-Gm-Message-State: AOJu0YyFRf21id1nJ5FyJI0YY986R+HADZ4jNYNxdW+PZVx4tbd6d47g
 3MbiMh229nSi0s/3L/Hr6X7Njr/j+ZDL66r2cKUBr0L1Gr/n3+B/7GtRY+TmHh2qulbIDo+lmWz
 sTmjX8RhYcBMFk4xvuHlUxV8+aiEb6IvSnY5/U5SpCbXW3qS12Dqs
X-Received: by 2002:a05:620a:5201:b0:793:1b3e:dd19 with SMTP id
 af79cd13be357-7931b3edde5mr726642985a.76.1716193675875; 
 Mon, 20 May 2024 01:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHuechjtwGmOciGLmndmKTtPIS/icFioMDFHMVrm8EAY/sjK0Edg/an5DnAFtGosN8fVdkA==
X-Received: by 2002:a05:620a:5201:b0:793:1b3e:dd19 with SMTP id
 af79cd13be357-7931b3edde5mr726641185a.76.1716193675483; 
 Mon, 20 May 2024 01:27:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf310c2csm1165240285a.112.2024.05.20.01.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 01:27:54 -0700 (PDT)
Message-ID: <c22b04a2-c15c-4d9e-bfff-8d9922a83122@redhat.com>
Date: Mon, 20 May 2024 10:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/18] hw/arm/smmu-common: Rework TLB lookup for
 nesting
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-10-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-10-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Mostafa,

On 4/29/24 05:23, Mostafa Saleh wrote:
> In the previous patch, comine_tlb() was added which combines 2 TLB
> entries into one, which chooses the granule and level from the
> smallest entry.
>
> This means that a nested translation, an entry can be cached with the
> granule of stage-2 and not stage-1.
>
> However, the lookup for an IOVA in nested configuration is done with
> stage-1 granule, this patch reworks lookup in that case, so it falls
> back to stage-2 granule if no entry is found using stage-1 granule.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 0d6945fa54..c67af3bc6d 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>      return key;
>  }
>  
> -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                SMMUTransTableInfo *tt, hwaddr iova)
> +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> +                                                  SMMUTransCfg *cfg,
> +                                                  SMMUTransTableInfo *tt,
> +                                                  hwaddr iova)
>  {
>      uint8_t tg = (tt->granule_sz - 10) / 2;
>      uint8_t inputsize = 64 - tt->tsz;
> @@ -88,6 +90,24 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>          }
>          level++;
>      }
> +    return entry;
> +}
> +
> +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> +                                SMMUTransTableInfo *tt, hwaddr iova)
> +{
> +    SMMUTLBEntry *entry = NULL;
> +
> +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    /*
> +     * For nested translation also try the s2 granule, as the TLB will insert
> +     * it if the size of s2 tlb entry was smaller.
> +     */
> +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> +        tt->granule_sz = cfg->s2cfg.granule_sz;
is it safe to alter the tt->granule_sz without restoring it? In the
positive I think this would deserve a comment.

Eric
> +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    }
>  
>      if (entry) {
>          cfg->iotlb_hits++;


