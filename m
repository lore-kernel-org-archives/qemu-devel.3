Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614F2C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 18:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZwDS-00065k-Sd; Mon, 20 Jan 2025 13:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZwDM-00064Y-24
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tZwDJ-00041Z-Nu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 13:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737396566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHf31zdeRsN+LrETSE3SYi4HGjOctajALm9Hz8KGoDY=;
 b=HuPB0QJpP8HP21e1CfYpsqfPYOMpUuCC+oNt4oF0SYFBbDPdLWsdYfLX5U/za3eIWPoMM/
 udIutuB2kzlE6OOktyS5JN2WmDigXCZnTbFuSfRZDAa90xFbVkntNqu0B4A3DSallkoD2I
 51zoLgMe9Dj+Do+n01IRCb2ioUhVtV0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-V1n1aMkoPcq3zdfbjzpFWA-1; Mon, 20 Jan 2025 13:09:23 -0500
X-MC-Unique: V1n1aMkoPcq3zdfbjzpFWA-1
X-Mimecast-MFC-AGG-ID: V1n1aMkoPcq3zdfbjzpFWA
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8844560e9so109756346d6.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 10:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737396563; x=1738001363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHf31zdeRsN+LrETSE3SYi4HGjOctajALm9Hz8KGoDY=;
 b=DuM+EowV/iFptjI9B6uYosrjzaML6Rca3570ffbC87oXAb+AcKVT12+JzfIte2Ga6f
 WtKQJD5WChk28e9FNiaq+jx64KZEBCb/LFOOIw4QHV1812drk+pRmcKz9GggpM0WXibm
 2OQYKi4ZZXEuT+YBI6RMcVIyng6hYI2L+2PDQ4eqTIng5okG7g9uyAOWHmszB7wv2tUV
 3oMP9e8siXvFh3dhz0r5BlPWcTDhCt/FFRXaQ+SghALhZsskE2BNyhzYRW5UZ4z8eWbu
 RsRDT4cGa6VvJySKdJBWVSM/xOX/SqtxsMKpPnjguUKyThe0rLIL/UAyjDjJJW5/lUsj
 g3RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzf9Z1b6C7SAwhVChylltIVsWmYwyiBgpoooTD7mxNWOB11nRwFojqN7LtRfNjtDxDPWBYiGTlMdW8@nongnu.org
X-Gm-Message-State: AOJu0YxSSaP+okaPP4cp/SfHgvyg5R1192sy76I0XaqpjjIVbOkaheiQ
 KAM5y0NL9vlsB7H7t/y+sxfduzn62o2dJrU8eMKYRS4E+vWASIYcbDNeaVNjPtf7ZG0AD6T9A49
 falT7CCtsYWEZAGaeFXz8aVB3dBbB8QdNATtNYZbETWkCQ5t1FldI
X-Gm-Gg: ASbGncsHb6Ym0CAUIivaYatEbkVF1UzD4q7c9AuB4xi4k2GZQhI1UV2qnHFrfamllln
 X1hIAoGQCIVHZP3CLNJi6Gmfhg/Ek3fMdM/T9RIGMTE9wmNpANr6PRW1eI5EHMqmOqQ5tJxj1G2
 qDsez+6DK6r45BBinu8jj4QvWJzgIdzv01RWb6STPv6f9JLrPoC7R/AxmDqRBrY0IUlixsfAWUH
 lR4YHtdqQlxl8EYJYNjLDD4Oj9mLy8evk8M8SoPJDiTpe6MhPhYOZPIdwSJeQwcGcxRMM/UNq3R
 Wbyn6rfwg/iD21fe4P7MQUnUL6MsGLE=
X-Received: by 2002:a05:6214:3d87:b0:6d8:b562:efd7 with SMTP id
 6a1803df08f44-6e1b2229dc0mr261335976d6.31.1737396562815; 
 Mon, 20 Jan 2025 10:09:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjzZIqFhBIxeSLxy8x+gO/zeP93RnHT4J++T8bkx1vgiv7xGXlLPbRz5jRLbhzBjJp51vTiQ==
X-Received: by 2002:a05:6214:3d87:b0:6d8:b562:efd7 with SMTP id
 6a1803df08f44-6e1b2229dc0mr261335756d6.31.1737396562607; 
 Mon, 20 Jan 2025 10:09:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc22e4asm43517376d6.56.2025.01.20.10.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 10:09:22 -0800 (PST)
Date: Mon, 20 Jan 2025 13:09:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z46RT__q02nhz3dc@x1n>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213070852.106092-3-chenyi.qiang@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

Two trivial comments I spot:

On Fri, Dec 13, 2024 at 03:08:44PM +0800, Chenyi Qiang wrote:
> +struct GuestMemfdManager {
> +    Object parent;
> +
> +    /* Managed memory region. */
> +    MemoryRegion *mr;
> +
> +    /*
> +     * 1-setting of the bit represents the memory is populated (shared).
> +     */
> +    int32_t bitmap_size;
> +    unsigned long *bitmap;

Might be clearer to name the bitmap directly as what it represents.  E.g.,
shared_bitmap?

> +
> +    /* block size and alignment */
> +    uint64_t block_size;

Can we always fetch it from the MR/ramblock? If this is needed, better add
some comment explaining why.

> +
> +    /* listeners to notify on populate/discard activity. */
> +    QLIST_HEAD(, RamDiscardListener) rdl_list;
> +};

-- 
Peter Xu


