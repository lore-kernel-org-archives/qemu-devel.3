Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43636CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GVa-00049q-74; Mon, 29 Sep 2025 12:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GVW-000498-SO
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GVN-0005Ge-34
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759162410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V5FQfi5+60+FYu1bBdU/dOdi8w4fRkHBNI51zjoQbQU=;
 b=AH/84x6g+HHVyu/LIKhV1Afnm74In7P55YlFBzPaSmtyWPJptd0CFj8N9wL0+vtEg34SK9
 jPqZw3NWelOuRsLyvNmi1pzbdGch9kzX91ld2dSlCtwkYjovkAiLNPyRK9WDZ34MlGcXHv
 6T98E5B/NMX7emkqMirIRbMm73svnvs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-19yP3OhWNh6gDSEwmL3BFQ-1; Mon, 29 Sep 2025 12:13:27 -0400
X-MC-Unique: 19yP3OhWNh6gDSEwmL3BFQ-1
X-Mimecast-MFC-AGG-ID: 19yP3OhWNh6gDSEwmL3BFQ_1759162407
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f3787688b0so2637841f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162406; x=1759767206;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V5FQfi5+60+FYu1bBdU/dOdi8w4fRkHBNI51zjoQbQU=;
 b=NAhubFi3p6rXeeN6Ll/3BdOOZb4cSPwDXGTp3K/rfq9CM0xBuZ9p3Ea6kZ3skmAPzt
 4rgsLKGWbzZJc5y38YjACCg4uDozcaudamhRST6+q0yhfXQ3gifXjFQiu63BjG7aaAgV
 4hSn+bH6Ar4IygUs6L9Zh/hh7Kj26gBXVQVG1z6ayzN8R0pxCqKgyEUnPpbWeOL+DtJC
 zgW9Oa4s0yzZL4iiXsJ3L3jmy+t5Nwn7gW3U2pgzaZjKyxbFqergVVXu01QB4cI9sZi6
 Com24gNZtsgyfIbS4hg+MTeD+F28impQSq4qxi04LhmU6ZtX/sKcreXn8ondibstyZ7j
 nPog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgxI29657BCuDnzLd1ZO/oJKAGpRu+XCXREgAQ52V61TjUSY5Qu5X0BBexWaZJ0PIPMaFXaqReQ25O@nongnu.org
X-Gm-Message-State: AOJu0YyvNrpmBtVq1ABhgjsp6tl2x8rqTgACcYm3M3WY9ZGEODETarwD
 T1dXd0np57ckLehK38J4zgPwaEEp+P/NNeIQrYZbbenRFJpgK5bNeKqyQvHaxR7qgnkiQlM1WS2
 6cGY39a/JLoagI9SvPVzObXvJQEZvLEqRDRzqu7MDPF32dnogFHebdNdM
X-Gm-Gg: ASbGncsfzgZrLbn6++FnMORDZvodEdrmtcySNiWtyprAUzc3dRPBXdNNs8i5uv7I/tv
 yma8me+I4E9uruqtRVIQiA+rBL2QKy+orKpIo/kjcifXCC8fHvWscBP/2XsJZmNyv1Y9m09VAX/
 dNzcqKfK5YmwojxHrUJQObvUgyFrft3UwA4TrVlWf0DuyLFUQ4aOEVLyPtvUBUGCh7ZpX01arwz
 HUwSfNVC3nL/nDFQXNzQ+xIcSm53BTYVZNvwAK7XpWXg2/pJtHEsFAwFbmJ3j5HzC9pcPg53ERs
 dcuoDKyDbAjH4clO0m2vVctp1l01gbmecwCiQ8WK0Gs4YBIrdin3QT9BxS4GPtCd4MjPAeNqSr5
 Weqo=
X-Received: by 2002:a05:6000:2c06:b0:3ee:1125:fb6d with SMTP id
 ffacd0b85a97d-40e468e7375mr11782383f8f.9.1759162406532; 
 Mon, 29 Sep 2025 09:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKpSH9fRflMsb1ojiq5LUNQpXmbTnkW3vSiA+dsRwDaRi0QYqZM24S/w/DhOGTZ1BCCMV2aw==
X-Received: by 2002:a05:6000:2c06:b0:3ee:1125:fb6d with SMTP id
 ffacd0b85a97d-40e468e7375mr11782363f8f.9.1759162406151; 
 Mon, 29 Sep 2025 09:13:26 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d?
 ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41f0c467ecasm6026435f8f.38.2025.09.29.09.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 09:13:25 -0700 (PDT)
Message-ID: <d6a3321c-1492-4c64-9341-8071659220fe@redhat.com>
Date: Mon, 29 Sep 2025 18:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] system/ramblock: Remove obsolete comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
References: <20250929154529.72504-1-philmd@linaro.org>
 <20250929154529.72504-2-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250929154529.72504-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29.09.25 17:45, Philippe Mathieu-Daudé wrote:
> This comment was added almost 5 years ago in commit 41aa4e9fd84
> ("ram_addr: Split RAMBlock definition"). Clearly it got ignored:
> 
>    $ git grep -l system/ramblock.h
>    hw/display/virtio-gpu-udmabuf.c
>    hw/hyperv/hv-balloon.c
>    hw/virtio/vhost-user.c
>    migration/dirtyrate.c
>    migration/file.c
>    migration/multifd-nocomp.c
>    migration/multifd-qatzip.c
>    migration/multifd-qpl.c
>    migration/multifd-uadk.c
>    migration/multifd-zero-page.c
>    migration/multifd-zlib.c
>    migration/multifd-zstd.c
>    migration/multifd.c
>    migration/postcopy-ram.c
>    system/ram-block-attributes.c
>    target/i386/kvm/tdx.c
>    tests/qtest/fuzz/generic_fuzz.c
> 
> At this point it seems saner to just remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


