Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BABCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Dmi-0004Be-HP; Mon, 13 Oct 2025 04:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8Dmf-0004BW-6B
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8DmY-00056z-3y
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760343586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMoV9s+GFjFyE0AItCwlqYk/y32/kodLPSUeWJowpxA=;
 b=ROKs+uv5SdkCqxvt2B3b8K50bBtAVFzdsunh2NJLcA/R3nJEp1NWSxx6g6HzE2BYn7OwuI
 NcnK/Kw0zF9XJkl4KvUaPzuSzckC8O2TyYznXVJFh6GD2er+8LM1xteGV+3jL96Qw5Upv9
 I0EE58V5/rVjbeiqEf2zCTGT1pfFFPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-CKYFMsQHMreiZvSS3Jrq9A-1; Mon, 13 Oct 2025 04:19:45 -0400
X-MC-Unique: CKYFMsQHMreiZvSS3Jrq9A-1
X-Mimecast-MFC-AGG-ID: CKYFMsQHMreiZvSS3Jrq9A_1760343584
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e41c32209so21216895e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 01:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760343584; x=1760948384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMoV9s+GFjFyE0AItCwlqYk/y32/kodLPSUeWJowpxA=;
 b=R7Mi/RVUFQ35NMOG33ekm0sv2tENgepYYayEYxGl+skOXALNrhcLKiQk1rHms844Ri
 k7HHj3aQ4EEw8qaW00JDRQslANrQWAh6u/lMeQxrxAavcqXlGolojJcCYWKo8WrCLWXS
 RBLObqO4ohPggfqIaoNkn1+9XX7Ks5I2DkqWDmYW6e35+dvRjUDmODFUpa3hsZZP7B/6
 Nd9DNAI8abEPWJsFkvp4Tix3HwTYC6OwZipAg1um5bdKKUVsU5Sq0AnrujmzgJTcgoB9
 VcYLi/qFxFcxV3Or0tvvDuOblu5Pn/GEOT0hkHvg4hIo+CVIhIt38vZboRavT9e+xfDc
 4X/A==
X-Gm-Message-State: AOJu0YyP5taYxZXKpO1TqpjB8B7s1d/Nv6W6nwkB5qovJ1JJF7UYfKiY
 YFPLjXwQR3Q4sl/8e8nPm5W+YObeigjL5/B/LsEi4KcVm64ON4FCmohO3itZ2f6bWOiAeR7tnto
 yinUpNFkxOZhgV0hWY5dAsI11vmD6PKBEOSy3lKW6kj7G/hkJqXvE5pDa
X-Gm-Gg: ASbGncuge7oNIOGPSs4Rqgeqx2D6DBOVnM2x8grNhKDGp/Z318Un7tKR0qkYCACI3UZ
 p8H5XZXOM1bbLQU00+wTpu3AtEeJME+Zvr8W9bJw3bP69byOIpRhkEh4vzxtrS23nE5TpQ78deY
 FTHPDLW6Q6VntAlsbsty8czIyHDkvmlWl81+Xr6u1Q1S2ZlFhTmFE4AB91Td0cBhZUUc6z6XH41
 Jh5NSI3dQ1HB/DQ6VehiK6eANh9ahI4WS/gHk8Kr+WloC3FGysOR+qagl0FsO+E5rQfCnJch0Kk
 akkwK0FnjRKJFqHl9z0VkpmpdLH1uw==
X-Received: by 2002:a05:600c:1986:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-46fa9aa1cb9mr123737715e9.13.1760343583577; 
 Mon, 13 Oct 2025 01:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqKeP68s82rBAY9nb+cUDrXCjlOagWgwpn3x7+Ss98kZKu9s6SQt3o2CAjbVXwdvQvZcwBZg==
X-Received: by 2002:a05:600c:1986:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-46fa9aa1cb9mr123737475e9.13.1760343583019; 
 Mon, 13 Oct 2025 01:19:43 -0700 (PDT)
Received: from redhat.com ([31.187.78.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b9easm177471055e9.1.2025.10.13.01.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 01:19:42 -0700 (PDT)
Date: Mon, 13 Oct 2025 04:19:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, alejandro.j.jimenez@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, aik@amd.com
Subject: Re: [PATCH v2 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
Message-ID: <20251013041617-mutt-send-email-mst@kernel.org>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-3-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013050046.393-3-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 13, 2025 at 10:30:46AM +0530, Sairaj Kodilkar wrote:
> Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
> to read or write from a given DMA address, IOMMU translates the address
> using page table assigned to that device. Since IOMMU uses per device page
> tables, the emulated IOMMU should use the cache tag of 68 bits
> (64 bit address - 12 bit page alignment + 16 bit device ID).
> 
> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
> to 60 bits. This causes failure while setting up the device when guest is
> booted with "iommu.forcedac=1".
> 
> To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
> entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
> the device ID to construct the 64 bit hash key in order avoid the
> truncation as much as possible (reducing hash collisions).
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>


I am wondering whether we need to limit how much host memory
can the shadow take. Because with so many bits, the sky is the limit ...
OTOH it's not directly caused by this patch, but it's something
we should think about maybe.

Something more to improve:


> ---
>  hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
>  hw/i386/amd_iommu.h |  4 ++--
>  2 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index b194e3294dd7..a218d147e53d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
>      uint8_t devfn;
>  } amdvi_as_key;
>  
> +typedef struct amdvi_iotlb_key {
> +    uint64_t gfn;
> +    uint16_t devid;
> +} amdvi_iotlb_key;
> +


Pls change struct and typedef names to match qemu coding style.


