Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8706BECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4Rj-0006xv-FX; Tue, 10 Sep 2024 13:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4Rb-0006xL-58
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4RZ-0001wy-Q0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725988460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BO8bAneU5o0NzmPnduubEV0daZoXvM4E2x3r4OcT/gg=;
 b=WoKcE91bFvdSWNEb/qXRYIu1TzBjNUqBgOLnHm36r+/SCqdNOODOWN+7XskTfoYfJlZ+lA
 5B4prpQs9f4kM4e2I1lYKPLj1byb7uosWYqAFD8SN7AgbbbqZ5yzMQj4m3aMJJq2wj0RHu
 ewEieKA4BYH+2aknVwi4JygMy/gmOSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-6zqlIXj6NJ6yFmBmjuqxrA-1; Tue, 10 Sep 2024 13:14:19 -0400
X-MC-Unique: 6zqlIXj6NJ6yFmBmjuqxrA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cbadcbb6eso8618425e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988458; x=1726593258;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BO8bAneU5o0NzmPnduubEV0daZoXvM4E2x3r4OcT/gg=;
 b=OFHxNBNocWqh46NhkDvjKGteo2oWlrclK/xKSyTPQjZzr5pvF5kgKoPr37FKvIhv7Q
 8TzKu6kq4HpzfZ3ChRSo1rnPEnSXqhKlN4qYht2e1JBhSBIVmioPaQXOqFFi7GkyK+B4
 uK5QG/0HKRt8Lo6h1KbOJcYpTSU6Yq3c5gYgkkKVdUQZTIXKw3pHiKAKy5EbjGSmP2rn
 +WGcDl33ytO8Iq6Fz9fn/uN8o3iI1rt+06kMBJP2ZaR5qFtrgFWJlq8qBnDzPHkzgcPM
 xJcYKKZiSJE7lNS2+YafkCHoIP33y5qO3hlcx8h8GVeUPqxn9+jJ0D6n2g9oo8iJ2wsS
 CxjA==
X-Gm-Message-State: AOJu0YwW+QBr+rcquCIFY63Ah7Tc2NqsZOVq+0W9GywR5dUOls9QNe9B
 btR4bWlRgDGub03LOwOpO5ejBjDSBPWEW37yiUnVq9oCeNucaTw2shI22AkNJ9oxUf5NpLuEG3h
 pa25y/wcqqWkK8en987e8UgtHNygxcKD2TXTZAlbobKVot41VWuhQER8X5o8e
X-Received: by 2002:a05:600c:4706:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-42ccd324fcbmr3081375e9.10.1725988457602; 
 Tue, 10 Sep 2024 10:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHELmlN/b8lpI8GLHGjAW6LA/fKN0l4KUZoFWRzKbXrGezU0h3Pb5H2XShFTVIK7a4awgDtxg==
X-Received: by 2002:a05:600c:4706:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-42ccd324fcbmr3081155e9.10.1725988456853; 
 Tue, 10 Sep 2024 10:14:16 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cae4ed007sm118574005e9.11.2024.09.10.10.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:14:16 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:14:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer of VT-d
Message-ID: <20240910131304-mutt-send-email-mst@kernel.org>
References: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820095112.61510-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 20, 2024 at 09:51:47AM +0000, CLEMENT MATHIEU--DRIF wrote:
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Using index info to reconstruct a base tree...
error: patch failed: MAINTAINERS:3672
error: MAINTAINERS: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3584d6a6c6..b12973f595 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3672,6 +3672,7 @@ VT-d Emulation
>  M: Michael S. Tsirkin <mst@redhat.com>
>  R: Jason Wang <jasowang@redhat.com>
>  R: Yi Liu <yi.l.liu@intel.com>
> +R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>  S: Supported
>  F: hw/i386/intel_iommu.c
>  F: hw/i386/intel_iommu_internal.h


I did it manually, for once.

> -- 
> 2.45.2


