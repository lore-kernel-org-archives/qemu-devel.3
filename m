Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B61D4117F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMjX-0006DM-Gi; Thu, 15 Jan 2026 07:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgMjO-00067H-1T
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vgMjL-0002fh-UM
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768481137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5+yrN+3BXklppUOU72Bp8gOwoD7nshbDGmOuXMJ56tY=;
 b=fHB3SjxZbqae0uE9NJqqKVAlsBB7K0GOPTpWXYXtrCkyYVC5dYFPi0oKsnGIPsmHlwxUBG
 IjCmaG0qJGyTEFbMxkaL2WcjcwI+1ClPOfxnpED8qgZrTweQzyTa0KaP5qD4TqIkz/Fx8+
 cbrJ1GlvyquGo2lDJvbCt4P0olZa3cE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-gPT_nslCNxK2Sw3UcnSvsQ-1; Thu, 15 Jan 2026 07:45:35 -0500
X-MC-Unique: gPT_nslCNxK2Sw3UcnSvsQ-1
X-Mimecast-MFC-AGG-ID: gPT_nslCNxK2Sw3UcnSvsQ_1768481135
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fdaba167so522190f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 04:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768481134; x=1769085934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5+yrN+3BXklppUOU72Bp8gOwoD7nshbDGmOuXMJ56tY=;
 b=bGPoSwx3BS/+8ndhL0pYV2wy5PvCFkExekaaDvoR7D/SOrmyEgSuqRmyN6pnsX9qEX
 M+HDZXsUos2sCT2VyFVRdVlDY4EKYgtqgIAKEZeDFVhXIOprfY+tjhbR7Ttcr5zgbwjW
 /2vxsz3rOLNT0sY78b9ceSu5QVqrNePw1Jd8uiYl8wbky+2K3MmMFFarJ5RyxImemREe
 XV3JXhTZ2+YyQ/qhm4s1T9gQYuaDny96kWvrSNi7DEPR2j7dPu5KNm6WweGtaCcPOshz
 nK6bj6b1on0537CjiRgcdbzD9BukG9aLJY2+iTDcv5zX51y/8DMdlzo6A6BlaIgRwtBd
 a7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768481134; x=1769085934;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+yrN+3BXklppUOU72Bp8gOwoD7nshbDGmOuXMJ56tY=;
 b=XPltNfZrsKU7LFGIRaqaEFnvr1ZZLLOOzniFEPZozeRvJfWyAJz4bpkVk9/tHAkWD7
 23uBJZrbxIP/bGBm406Kt/taLlGarHR2W+JhZZM10VBzbPq460o5I1mKB4vfb8loUjxY
 fqIL9BL3nyapEaOtKd7qgYe1wPd3XoZGPJNVYVzixhs031fGTV7yYS6uG7r3ZsMJauh3
 4Ihk1zK7YBFlE5W49sn3utsHuzsXoOUnuH3D6DtpQUsFUjslALBCt6dTUPMk89MdFple
 aEn6zEryDzJzMC7KcQSVeptsRVLLVeBOSEJ9fRdgOZLGU9VRNCAPVMupkTecTApeGEZE
 Fm3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVJF+C5SekpnaInfCw/kWI2cn+7p3JjV/ECKY0KW90w7YcaxYSCee1ZVUt6mA/OpNDs2A/YvVJq22T@nongnu.org
X-Gm-Message-State: AOJu0YywBWhIErw/SKtQKmukvGOTjOsR0tqZnlri18asRplY/pbECM7c
 ZyNydaKDkBFTtY4RXl7JNyZfjo5e1T1mZLuob/0psyZ6n6eM94OYwqGPIUepu12Sf0iwHl8FFVI
 trw6g4BcgPtiKpzhZWpjo+FBMcsLFvps6h0pUPfJqB+kWbZyVSsw6bLXG5UDkuVKl
X-Gm-Gg: AY/fxX6ombQs0aKKsMG1J4qj4jYqhUCAxCAlMCo2PDZolpXkMvearoV2IY/q7OYcDax
 9K50/AuGh+LKiF3e7xCS/Iao1Eu91S59lPNNdT9fotttcCnxWYEDluaw7t+wweNSb/d2zo4L11v
 Mmbc7bexekxJd+UZFbnAVxgywL48LXF7tIktVQ4bl37r6eGL/IpGh3Ctu0KAgCFWHJJgISL9Y9B
 RMv/ePYCciHXq2soxkfRIBoRLGJBPjXvmttErED9O3q5h9FdbIL1SISGxCPmX7V4SBWdSrk3S1B
 Re/F1CnR62INbIeGv5DMn1O1fc519OG8g1WD9gAlO1OH9oKBwT9EcBLVbw1lBP6VJQOrGZY58H7
 BQA79Pc+nJz5pqfXadix9HhkN8av7fCD5+uMhfdrpZHsXqppM
X-Received: by 2002:a05:6000:184a:b0:431:74:cca with SMTP id
 ffacd0b85a97d-4342c557665mr7720825f8f.44.1768481134072; 
 Thu, 15 Jan 2026 04:45:34 -0800 (PST)
X-Received: by 2002:a05:6000:184a:b0:431:74:cca with SMTP id
 ffacd0b85a97d-4342c557665mr7720791f8f.44.1768481133595; 
 Thu, 15 Jan 2026 04:45:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6fc833sm5632474f8f.38.2026.01.15.04.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 04:45:33 -0800 (PST)
Message-ID: <1a529024-6e2f-464e-b03f-5c4d93a3b6d2@redhat.com>
Date: Thu, 15 Jan 2026 13:45:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] linux-headers: Update to Linux v6.19-rc1
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, kjaju@nvidia.com
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
 <20260113113754.1189-2-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260113113754.1189-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/13/26 12:37, Shameer Kolothum wrote:
> Mainly for adding support for VFIO DMABUF. While at it, update all
> headers.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   include/standard-headers/drm/drm_fourcc.h     |  25 +-
>   include/standard-headers/linux/ethtool.h      |   5 +
>   .../linux/input-event-codes.h                 |  14 +-
>   include/standard-headers/linux/pci_regs.h     |  89 ++++
>   include/standard-headers/linux/virtio_net.h   |   3 +-
>   include/standard-headers/linux/virtio_pci.h   |   2 +-
>   linux-headers/asm-arm64/kvm.h                 |   2 +-
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/unistd.h            |   4 +-
>   linux-headers/asm-loongarch/kvm.h             |   1 +
>   linux-headers/asm-loongarch/unistd.h          |   6 +
>   linux-headers/asm-loongarch/unistd_64.h       |   1 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |   3 +
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/bitsperlong.h          |   4 -
>   linux-headers/asm-s390/unistd.h               |   4 -
>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>   linux-headers/asm-s390/unistd_64.h            |   9 +-
>   linux-headers/asm-x86/kvm.h                   |   1 +
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/iommufd.h                 |  10 +
>   linux-headers/linux/kvm.h                     |  11 +
>   linux-headers/linux/mshv.h                    | 116 ++++-
>   linux-headers/linux/psp-sev.h                 |  66 ++-
>   linux-headers/linux/vfio.h                    |  28 ++
>   33 files changed, 363 insertions(+), 498 deletions(-)
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


