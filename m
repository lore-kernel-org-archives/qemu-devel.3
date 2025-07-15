Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C2C83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbra-0001Sg-5Z; Tue, 15 Jul 2025 05:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbrT-0001Q2-Q9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubbrP-00023N-JJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752571320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oR1PDVnZhgu3pT7GkP3NYWwwEvK29p9dkZG1H3mvDLI=;
 b=hoacfAGJFVnzw80ipxJxcj8LK31OrR7XKjhNhK7swwJjglDcSWgcUkaVsT4VlScImzsvff
 pMg8w2hMewpfJCQ03S5XqGbMJj0VDsgJzIS64XFA5zlMjZKcAm5uOSiKyPOF8F4FHaeP8q
 a68N9Q9UQsDIsNHam5u2FEEkYkkDpVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-kkWg3oyxMOyF2Zvhz09LVA-1; Tue, 15 Jul 2025 05:21:59 -0400
X-MC-Unique: kkWg3oyxMOyF2Zvhz09LVA-1
X-Mimecast-MFC-AGG-ID: kkWg3oyxMOyF2Zvhz09LVA_1752571318
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso30006995e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752571318; x=1753176118;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR1PDVnZhgu3pT7GkP3NYWwwEvK29p9dkZG1H3mvDLI=;
 b=CqSTUQotEKPNH9s4eQNqObtgi9B6HFuUFMRKIqBHPPBtOK5z7q2l1BmQJciq4NASFC
 tpBR0PpH3dN2gXIaDTzgyO8QNrFXX3jjtF5hdABF1nWtBr9R6VDnPA0Pc6yXodwYHNSX
 YNWyiljtOoqOvCjEFmPOUfDCS+Kl6JEjtHc1YpwKSUdoAcyTmXq774H1jzbQ8fUVPfFs
 li6tJojUkPaKbSWiNArFTUECYqY0lt9G+i8/9rjRrjFwHAngH1CXVQOEY3RlUYV5vNVb
 ffgbjpt8CVr1GPlfWDaofoPyqUXU8RVDSljzdgI0BqrlnH7N8C8q+WvlOQhF7sacpPFD
 dXcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXApt/GN+EGjcENG+FtovdbWLNJHwS6E+JR1cf9bxnFzEyfRUX0kwUIpcsYZOQbvmPFR9gyHQJHP7BI@nongnu.org
X-Gm-Message-State: AOJu0YxhJet0i2y/AShouwcFPDGDZnIaBqnHaUdb/8biXYQlK7DFu+kA
 3JETETkNjFAQVY4hAJ+kwovBDjq+kGwPtGGGY53EGXf0MYfKZ6LelKkW0oYWb5UCqHjzp32K1AR
 0qdqWSeazNSGw7G2DBjPLwzyoe52O3Qh5VnIkrybWtAZ89HpNugAMqP7F
X-Gm-Gg: ASbGncsCYoV7pPwwIJ2Ao27n/7Yj9JpyXhyuO8QAMmkEiO2n9/DUWGcSuvKl8AflVCd
 4xD72lOz5RRe4Ccm6TBrCfwrS3230knPG8zVu/DGcEfYiwKL9lCMgOeXGpmKvI0oL8sr3w6uo4u
 gua9FiDesL11WTgw6fMFPvqKyMluXT5H6F+dRQw4/ZD8xAusVI3q2sczZn+U5r083f7XRX9y2bE
 jUXxpBk3k/VQgZYRCTFHyHSDXeVK2VeF5LZz4BhWN5EXntqFYZX3bf3jvoeGbTR5b27/fSXo2d2
 SLNmu/SYUWjNBAzAQVXz8LyxrEtDJlhEwRIYpW1qVMyZaulZDrQ6MqQh+7xrRXtbuafKbA6J2DM
 =
X-Received: by 2002:a05:600c:8b07:b0:456:1752:2b43 with SMTP id
 5b1f17b1804b1-4561752359dmr71027935e9.21.1752571318114; 
 Tue, 15 Jul 2025 02:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF++nvvw00UtxNe1Qn9qPGKQaBlwp6+hvm180RdU8mDHCTmUsoy+mk2rHtY8+qXsI3VrOmEbg==
X-Received: by 2002:a05:600c:8b07:b0:456:1752:2b43 with SMTP id
 5b1f17b1804b1-4561752359dmr71027625e9.21.1752571317700; 
 Tue, 15 Jul 2025 02:21:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560394e061sm98911175e9.31.2025.07.15.02.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:21:57 -0700 (PDT)
Message-ID: <964728df-afff-4e7a-b1f1-f920e6a7913f@redhat.com>
Date: Tue, 15 Jul 2025 11:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Avihai Horon <avihaih@nvidia.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <22e94f25448f9ff42b84c84df3960c4ecc94cbdc.1750787338.git.maciej.szmigiero@oracle.com>
 <9bfa5e01-37a9-4e2a-bff5-264909e0dab9@redhat.com>
 <8a541c48-15d9-4609-bad7-a1606eeff22e@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8a541c48-15d9-4609-bad7-a1606eeff22e@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

>> Using 'strcmp(target_name(), "aarch64")' is quite unique in the QEMU code
>> base, and to be honest, I’m not too keen on adding it unless there’s really
>> no other option.
>
> The previous versions simply tested the TARGET_ARM macro but commit
> 5731baee6c3c ("hw/vfio: Compile some common objects once") made the
> migration-multifd.c file target-independent so it cannot use target-specific
> macros now.
> 
> Another option would be to move vfio_load_config_after_iter() to helpers.c
> since that file is target-dependent and can simply test TARGET_ARM
> macro (#if defined(TARGET_ARM)) instead of doing strcmp(target_name(), "aarch64")
> which I agree looks weird.

This would look better than testing target_name(). Let's do that.

Thanks,

C.



