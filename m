Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC27C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWemW-00023O-Hs; Tue, 01 Jul 2025 13:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWemT-00022x-RR
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWemS-00068R-3V
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751390906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h4uf9bj/+dQ4A6SdlyrI7ie/VNOmPIOPLMFHAtadjJs=;
 b=BaLH4vEBENvIqK3yruSUg8NW7lt7tm5DqtUSbYVKqYt+wzseiR4sfAWITSB0Q7Omi/y7t0
 M9WWPw6rnlt3Rd3Q4xFEpMUWT53Pxk8T/D0glyygfe2JonPVGoQqwGD+Ys4MZOnXCKOmVq
 kGr9vt5fLztbBEaeJ/fw7IMxbT5dsDw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-SKBPmr2rPyWPpV5JIh3ivg-1; Tue, 01 Jul 2025 13:28:25 -0400
X-MC-Unique: SKBPmr2rPyWPpV5JIh3ivg-1
X-Mimecast-MFC-AGG-ID: SKBPmr2rPyWPpV5JIh3ivg_1751390904
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a579058758so1352353f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751390904; x=1751995704;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h4uf9bj/+dQ4A6SdlyrI7ie/VNOmPIOPLMFHAtadjJs=;
 b=C+LA7gzV+ljE2mneslUFUlRgnnu6P7K8gNvpX/zR+NGlLb0LK5Cjxq/8LPP1dn7s/j
 Aeuliik+WltO43sYchkxwEoe/WucFd+2eG7fpp8cm1TAa92xF6qnvACgCMsV4TvjXVki
 0tF93Sgg8KGnSqlxfCmeWu6GNdr16b0El2mLiqKTVsbJQUt5sQbD/By790LKO0zFGgle
 PInK5Q8GP4Dau/qHszZwlfEg7VNRXdnNXIzbZ98kNmBcixsoQbin6LqQv+piLWArAGAT
 xr/+tGZrZsKTOtrPot9ji7dnSg+lVbbjLdCkKOfgfwoY9EbzPGpNGTI6hzPAYxTWiyOp
 3cbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGkouDY3LKgiiVhngYych7ht5seA/J2WSuhJ7Ky/miNND0nRYF4Q4r0uF2IsQABvjL9jUT2ekYAI7T@nongnu.org
X-Gm-Message-State: AOJu0YzZ+yZU5UDfrz563w1rUqlLiUFIc3b3dJRolhdVLsjvgsFEsX7X
 XbyMJ89gFrPBBs4Z6IuPpurYfK4qvw0CHFERip8uyvfDX2TJ/FbUyZJuZmzL2Quk1KacbBrII7k
 DoQQ2WuR9p6p1tdtTEaU1+Nkaxy8G7L4JaI2p1bcHN+TY8NqBJI3pG3l8
X-Gm-Gg: ASbGncu2veli3t3olwYD5LCRK8ojcz8ojQm7ZHrYQ4Et5aPHfMDza61AeHfiWDh6fsH
 mpN4amRoUJALFOJC0TyFU8t//4FyPW9q7xBhzUrasXaEwHKfa6XSXj2UuSKisq9t0WuBJvk9VMs
 6WkTD7RPrryyvmr7Jt3aAVzSh3wfXXoK9KZLFvn1vYYMXLQIEoCuN1rX7FbL8xB5c+x2Ql5RKcR
 YyBVfzwzfVu93K0B5iVYEUvIA96/eCzrd2//mNn7x+y5QsJYsRFIkNFHZGbP6tKJpgSdXhE0R+Q
 ma55RLmjzDZZQNogaHWDKIkdLYYm6sWkxCTqtHeYUd0QlM1A49Suj4FCITxcOQ==
X-Received: by 2002:adf:9cc4:0:b0:3a5:6008:e782 with SMTP id
 ffacd0b85a97d-3a8fed6dd92mr13648928f8f.43.1751390904122; 
 Tue, 01 Jul 2025 10:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLdyZZ/Qs4gtDZ3Ps/JcXBfHRBhWVLKBXiWJ3/ACe6537B4pJhSk+PV2MNXJyN/DsYT4e5UQ==
X-Received: by 2002:adf:9cc4:0:b0:3a5:6008:e782 with SMTP id
 ffacd0b85a97d-3a8fed6dd92mr13648913f8f.43.1751390903660; 
 Tue, 01 Jul 2025 10:28:23 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-041.pools.arcor-ip.net.
 [47.64.114.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fadf3sm14070681f8f.34.2025.07.01.10.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 10:28:23 -0700 (PDT)
Message-ID: <d96479ff-a239-421f-a697-b19dc4a8fa1e@redhat.com>
Date: Tue, 1 Jul 2025 19:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] treewide: update docs file extensions (.txt -> .rst)
 in comments
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
References: <20250616.qemu.relocated@sean.taipei>
 <20250616.qemu.relocated.05@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250616.qemu.relocated.05@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/06/2025 17.50, Sean Wei wrote:
> Several source comments still refer to docs with the old .txt
> extension that were previously converted to reStructuredText.
> 
> Update these references to use the correct .rst extensions to
> maintain accurate in-tree documentation pointers.
> 
> No functional changes.
> 
> Related commits:
>    50f8174c5c1 (Jul 2021): docs/specs/acpi_nvdimm: Convert to rST
>    f054eb1c920 (Jul 2021): docs/specs/acpi_pci_hotplug: Convert to rST
>    912fb3678b8 (Sep 2023): docs/specs/vmgenid: Convert to rST
>    bb1cff6ee04 (Sep 2023): docs/specs/ivshmem-spec: Convert to rST
>    55ff468f781 (Jan 2022): docs: Rename ppc-spapr-hotplug.txt to .rst
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   hw/acpi/nvdimm.c               | 2 +-
>   hw/acpi/pcihp.c                | 2 +-
>   hw/acpi/vmgenid.c              | 6 +++---
>   hw/misc/ivshmem-flat.c         | 2 +-
>   hw/ppc/spapr.c                 | 2 +-
>   include/hw/acpi/pcihp.h        | 2 +-
>   include/hw/misc/ivshmem-flat.h | 2 +-
>   tests/qtest/vmgenid-test.c     | 2 +-
>   8 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


