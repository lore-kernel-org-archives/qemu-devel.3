Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76942C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nos-0001VQ-3C; Tue, 29 Apr 2025 12:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1u9noo-0001SP-Hg
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1u9nol-0003cB-Ci
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745944101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l50atMCuK0a/t6+OSsjycsY+3SVS0yqhWVsTT+GbMRY=;
 b=RS7dLxtzMrvPyM/UhKCxc6n11nXhg5GqB5fpfIWsS5UJ5JEeXlO5nr1IKH6zh0ISaGgIOI
 FJ1QpYaptzHyGOkbv2Os8K8Z+cM3hdqTwSk7w0c6G2JcGI4z3PoIRHs4sQqucNj7lMGq8w
 jHJOxmBdNRW+XtkOPtOSt328jkafojE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-dIZbPOfSO5WaUwa-3eUGlQ-1; Tue, 29 Apr 2025 12:27:12 -0400
X-MC-Unique: dIZbPOfSO5WaUwa-3eUGlQ-1
X-Mimecast-MFC-AGG-ID: dIZbPOfSO5WaUwa-3eUGlQ_1745944031
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so35363565e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 09:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745944031; x=1746548831;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l50atMCuK0a/t6+OSsjycsY+3SVS0yqhWVsTT+GbMRY=;
 b=UJsyQMEmZftp1oTL4eaN1X9klApKZIT8ixQWaj1JUTXu9/5p/A/jxngUgnnX/xw89q
 k/diaGC7bRS7MhFRVpGups3bOnnSATbP7LrmnR23OGisiQ0ceA4QjvP0Qu7/PMgDPZgZ
 JMHQpDLwnF9uAOg7lgnLd+1tQ+DjNUEUqmXd2699DseNnL1z7aga61d2jJohYetX5Hit
 vcCMR/M3tEpdH3QAuFxfe24/NzUNVjsjS9vDrcVjOjb8tz8AJEYBgLM7oQUjNDz88/gN
 6OIZm5IdCgQD+gRL58K5T3XBES6SoW9bfEzvvP2m6ar8ar1SQ/nyXzea5DOZTmnng8+/
 qEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiMvfJCJ94HKZ+oqoAkx2yFSTBR6D4sC2+tYNef0vyNVfqlHW/aAfjWQbPbruP0C4WjAQqLK1+TqeV@nongnu.org
X-Gm-Message-State: AOJu0YxlVXuG6+tyeHwORnTjQ+0eGvacIk+5ByVh5sCB80Na6UvOMgwx
 XN11fHjq7M6LaJYotW2D5Z71+1Al+L3QPddC+Yqx8oHaw+9zuQ7O4rG5dkBYZztdZ+GrrVbzQrD
 jgom8aBRZKRkFPnxqAmxz5NQ60ZmQAYaJbQw3GIDnYQ8HlyHY1g6K
X-Gm-Gg: ASbGncssoBLB9O1sDeO6PwkQI4PD6AXnisXPg8JyQiMXZvA0hnT36WBrPqUko4iTPjJ
 79YT5GBr5XozdAuhO2lxRQ7HS3XEbX4gtk+4ONCFoUgnLyDpm2OD9sN5FVFFsLnjMfea6XvzmJw
 qENC7PBtzjLzm/djIVqx+rBKfempzsEAOcF+1RZB0LcoGuUN+9IWbDMAW8HPTnjIhc25PbF8WKL
 1uiPokyoxRk0ofE+fAMtQDu1ehgpRHt1eYsUFCipDn9ke8Nb7B0b0oVHEJtrRIzmE+ErF01A0tC
 fUGlspeoVcoFbDR2BqN6Jw19t7+MOWA4i+dKAU88nG9bbR3+uAnMW0G4C47/
X-Received: by 2002:a05:600c:4f8f:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-440ab7aececmr117307555e9.8.1745944031419; 
 Tue, 29 Apr 2025 09:27:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuUSzhkKqv0CBZmumvxFVHUHd6z0kkIg62q2bNYagDKXU1xaQJccG/XSf0llsSSRxcQQTkcg==
X-Received: by 2002:a05:600c:4f8f:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-440ab7aececmr117307275e9.8.1745944031090; 
 Tue, 29 Apr 2025 09:27:11 -0700 (PDT)
Received: from rh (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de.
 [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53044b3sm160787565e9.15.2025.04.29.09.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:27:10 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:27:09 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, agraf@csgraf.de, shahuang@redhat.com, 
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 05/10] arm/cpu: accessors for writable id registers
In-Reply-To: <20250414163849.321857-6-cohuck@redhat.com>
Message-ID: <bebefcad-d9db-a2b7-ab69-8eed34b9e63d@redhat.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-6-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 14 Apr 2025, Cornelia Huck wrote:
> Also add conversion between the different indices.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> target/arm/cpu.h | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index bbee7ff2414a..775a8aebc5d3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -876,6 +876,13 @@ typedef struct IdRegMap {
>     uint64_t regs[NR_ID_REGS];
> } IdRegMap;
>
> +#define ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2)               \
> +        ({                                                              \
> +                __u64 __op1 = (op1) & 3;                                \
> +                __op1 -= (__op1 == 3);                                  \
> +                (__op1 << 6 | ((crm) & 7) << 3 | (op2));                \
> +        })
> +
> /* REG is ID_XXX */
> #define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
>     ({                                                                  \
> @@ -923,6 +930,17 @@ typedef struct IdRegMap {
>         i_->idregs[REG ## _EL1_IDX];                                    \
>     })
>
> +#define GET_IDREG_WRITABLE(MAP, REG)                                  \
> +    ({                                                                \
> +    const IdRegMap *m_ = (MAP);                                       \
> +    int index = ARM_FEATURE_ID_RANGE_IDX((sysreg >> 14) & 0x0000c000, \
> +                                         (sysreg >> 11) & 0x00003800, \
> +                                         (sysreg >> 7) & 0x00000780,  \
> +                                         (sysreg >> 3) & 0x00000078,  \
> +                                         sysreg & 0x00000007);        \
> +    m_->regs[index];                                                  \
> +    })
> +

s/sysreg/REG/

Also GET_IDREG_WRITABLE doesn't seem to be used in this series.

Sebastian


