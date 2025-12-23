Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFC1E6FE24
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 16:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4w7-0003wM-V9; Tue, 23 Dec 2025 11:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vY4vx-0003vW-Rk
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:08:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vY4vv-00045j-33
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766506101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cTxQBLJgu80O/UJEI91bM6W3PHcErvS250esmBZja9g=;
 b=H16/+oo06Sd2svjBC7tryFXg9G44S0KPcd7lcb0scESruQ1FeU9xiH9ia4qHgCNroaFvy4
 Nb0dckpbW+mrWR6eTnhm96WWWBpfCHsML63UGT7nI7w/3AgpoKIvQ91OzURrHEniSQ6kZF
 LYHK+WUzO+gELSknYrHLjcIMH/j61lk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-xvUXOLxJNxColQ8ZsA8Kaw-1; Tue, 23 Dec 2025 11:07:22 -0500
X-MC-Unique: xvUXOLxJNxColQ8ZsA8Kaw-1
X-Mimecast-MFC-AGG-ID: xvUXOLxJNxColQ8ZsA8Kaw_1766506040
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso2761195e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 08:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766506039; x=1767110839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cTxQBLJgu80O/UJEI91bM6W3PHcErvS250esmBZja9g=;
 b=ihmT/Erl9W8j4NXof6mPphLZPDyz5knRO6/vNFkwrJbVKVGtghtNkH+0S8qwttuZyY
 LCDKyf9JYwMSN7xMl/wh/GT5t1KTOuz25I42/NffDEqPoq9vF2qOwSo0TTxLVkxhv/iy
 DIDKeJGkhwswxZNqcoLVh6hCuti9KaEPW6QGCBnAo2mxAXuer1ElDYFBHoZM+NK9DEhi
 ZhStmNlmxWzVNWLAHnh/6I6BHwHLrxcoKODD8HuHYww4HsNSokQVt34zajuTGKCMHy4K
 YY2J7jYZMev1dQIxEcw85hcDpm++ddYQYARtHUW5dJA3nlruiHryRvhct8p0Vpug7zWg
 ZhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766506039; x=1767110839;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTxQBLJgu80O/UJEI91bM6W3PHcErvS250esmBZja9g=;
 b=rc7NoHWDrHtEIzFZ/RFdxmwnTnUR7HEsIn39VLRfb0WCty4q5Je1PyREVsd1f3yxAb
 x1gKQv3dTlR2O/BDtedVrR6sBQfxj63iApM0irYsFa3avAqhcNx8mYRJ7hXqWMfquNwy
 0KCuvbsmgl25G9wzaos2hvcBTYNoM6jH22zQvP4e5JtgxA/vDijv5QlxIDMyQq9Uvc7F
 gs9sF/psdz/g19r5NUzm77pLixMoTHhDH7kNVBhJO0x5uTwKk/gQmFE7+JOGD7YjOLPC
 3BOisLFFKOi5hkbpYYsC5s+5GS5qcMjY4ERWF0c2UKONhrInxeaj33fQHh8XB3D6Gl80
 qzHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX94ai4MviouSoV9aJgOjE7UO7tnTjDWB5KHr/7V5Zb1RSndjO72jrn1+EVEQOSVdQNM0i3h7A2QzUr@nongnu.org
X-Gm-Message-State: AOJu0Yyd5eAYNIW2FyRlZPB9vg9cYXAGD2vyMsjei0LBr89LZdH6+vQR
 BRGBgtIcIUXBAaU81qpoyNWRyN+cqZpJFu92CqGOApsZdJUjiMT5shzmiX9Yx/lVd7Zlx2hT/cM
 BMp9shI23dPEQDEDmJh93UqHmF0zg4OLs1wtNBp4aFmwp01DTthHlEDVM
X-Gm-Gg: AY/fxX5lzzBUKodJKb+bc/b6PnVyAEJo0vbE2aJ0HHn9DTDOLn8PFdP0RIy2hQBFIJb
 qW/vS5xBR/ussp5p3vcxA4iyn1PM2vVcAFiwdnEFgNAvF3uOELNv1QsOz2sgV8yk1IMmUdVXY4R
 toor9qtMh3QMdg1MTw9sv4wxSmseJ9LCaynZX7UxidXdLomGYVWjoN3VcjAgl2CtTjOD7zLKrMM
 D/I8quqSel5IVQAmFXkGc/AwaTegj99EH8GDYtAsI/NZDZKp8iMGb8QMm7oQKQWw9zBCKFkOtmG
 +2X+Yos7Qsqp350oNkciNjaQtkV4O8xehk/IOc1VblKNM1KnKXIsGIC3TTjCFhvy+oODePl7HF0
 IQDzLPbHkaVuZrYXdWMN+WYUPMikgUtbMUGoQOzwEwx+Ovw==
X-Received: by 2002:a05:600c:4746:b0:479:33be:b23e with SMTP id
 5b1f17b1804b1-47d34de4cacmr35923105e9.17.1766506036792; 
 Tue, 23 Dec 2025 08:07:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGorltnEPvlQ8mx8n6Hi9xtqfDK6P5WWqr6O3kkGRkSNxcpaZKpR6KkCIBHziDUGwfftG5O6w==
X-Received: by 2002:a05:600c:4746:b0:479:33be:b23e with SMTP id
 5b1f17b1804b1-47d34de4cacmr35922805e9.17.1766506036394; 
 Tue, 23 Dec 2025 08:07:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:2c1a:3780:4e49:dfcf?
 ([2a01:e0a:165:d60:2c1a:3780:4e49:dfcf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm28704669f8f.35.2025.12.23.08.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Dec 2025 08:07:15 -0800 (PST)
Message-ID: <563fdc20-3e10-4876-ba1a-564e8a7d4eb9@redhat.com>
Date: Tue, 23 Dec 2025 17:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vfio: Add DMABUF support for PCI BAR regions
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, kjaju@nvidia.com
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251222135357.143339-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Shameer,

On 12/22/25 14:53, Shameer Kolothum wrote:
> Hi,
> 
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. This adds support for vfio devices to create a dmabuf for
> each mapped BAR region.
> 
> Requires linux-headers update to 6.19-rc1(patch #1). That update
> introduces a virtio-net build issue, which is addressed by patch #2.
> 
> The dmabuf support was sanity tested on an NVIDIA grace paltform.
> 
> Please take a look and let me know.

I gave it a try with a pair of GPUs on x86_64. LGTM.

It should be ready to merge after the linux-headers update
is fixed.

Thanks,

C.


> 
> Thanks,
> Shameer
> 
> Nicolin Chen (1):
>    hw/vfio/region: Create dmabuf for PCI BAR per region
> 
> Shameer Kolothum (2):
>    linux-headers: Update to Linux v6.19-rc1
>    hw/net/virtio-net: Adapt hash handling to updated UAPI
> 
>   hw/net/virtio-net.c                           |  11 +-
>   hw/vfio/region.c                              |  57 ++-
>   hw/vfio/trace-events                          |   1 +
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
>   36 files changed, 427 insertions(+), 503 deletions(-)
>   delete mode 100644 linux-headers/asm-s390/unistd_32.h
> 


