Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6E6C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4aS0-00068W-Cq; Tue, 15 Apr 2025 03:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4aRt-00067v-L2
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u4aRq-0002NI-Vg
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744701068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P4UOVzjG8E8JrY5OZRyncxoDKm/5CZAy0Qh5j4KeZEc=;
 b=XfJlP0Rh2Z5Bn2PlprydiMTv4AsrtC5c6u+4e47rSh8dYf8ePEW+kybKlG2Fx2GrcNuZLA
 p5DxT+bFebLVrhZ3iLcNMtqJhyIMYQCSlheqHtNGHEtWwOsvRTCWuPvKocZSZ0F2Noy7SQ
 +2P+9cGbX3vjZW1Uf2NDwMhlPBBDdo0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-2ZZWH6KoPSiwd-b0wfFdNg-1; Tue, 15 Apr 2025 03:11:05 -0400
X-MC-Unique: 2ZZWH6KoPSiwd-b0wfFdNg-1
X-Mimecast-MFC-AGG-ID: 2ZZWH6KoPSiwd-b0wfFdNg_1744701064
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so2104803f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701064; x=1745305864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4UOVzjG8E8JrY5OZRyncxoDKm/5CZAy0Qh5j4KeZEc=;
 b=Sjscwzk/63BxEH7k+eMpY76yO6MdGEui3UUwqtGIZvRAtrMw9+oZInfelufoJV/HW9
 dDJSStJCStKhIZbCRRYsstPQF7u56DHq3QcwUqkjkRJj7v+5qM9OR+zEDMBsPA2qxGRm
 opr/DWj9W5ui2mKyFJ+YygMkClYLqMOvwwpo+7jHchHqh3Ez6UcHVBmIxOHS38QeM4PR
 8JdcIbEPsTmA99EYLtIXQaaL/VpDjdbDBGrucr1T+7IwrXaROaiitZM9jyklKjn6BEg3
 rxm6jXh2yzzCRgMtr3/nNfgquk69yE6At9lVN9VkwPgZ7QNhWKAzmXQ8DXZo5LJpbtj9
 bZxg==
X-Gm-Message-State: AOJu0Yzr+MHsdhQ91+YR0Q0L8tsZvKxC6yoSBhAdLqxqR9D8ISgflGhe
 o97qPyVyleRM/1PgtFaI7JToMsEp0t3nIu7VPKX5Sf0ATmYvOzJuFrfwMMAtuxjzaU/wM7hMt5E
 BU+0Ea/E85fODKnO8yaF28JhXkuG2loaOhLdwZKh+pdSijTeaLGbm
X-Gm-Gg: ASbGncuWP8ZbQ6YtHSX7oBMzmmJuhh6fI4NZxQ7KMhhEjhn6iKbIFuhPa3b1V3jyQTE
 eSL+uchHnTfjLGLdGrlipa6sePsBLYZb1uj3hBaTeKdqlQFLKr2ei75qPyKO8KWkVxkbK+jjuMw
 ccyTACadXhEw1xBKdZQayTcqwsQerrJRBJyv3d2JQh4/tnesN02Mcd7Oohz3Fq+HO9FEY+TkCz9
 46LqqeAWbP96h5Poa8NOaB6nh5p43bK7Q3lH3/ZBAE7MqF07N74Q2DZ/eDT/PQxb3SHo2hMWwPm
 l2BnfQ==
X-Received: by 2002:a05:6000:4285:b0:39c:1257:feb8 with SMTP id
 ffacd0b85a97d-39eaaed574amr11690212f8f.56.1744701064481; 
 Tue, 15 Apr 2025 00:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnvFzGpXnOSbyF5CICMKXElnWT9wlyQMsE6l917yrkInmVuh4DIOgpc3yJJ/Mry/P5zr+K5A==
X-Received: by 2002:a05:6000:4285:b0:39c:1257:feb8 with SMTP id
 ffacd0b85a97d-39eaaed574amr11690192f8f.56.1744701064158; 
 Tue, 15 Apr 2025 00:11:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963f62sm13037355f8f.5.2025.04.15.00.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 00:11:03 -0700 (PDT)
Date: Tue, 15 Apr 2025 03:11:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, stefanha@redhat.com
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Message-ID: <20250415030653-mutt-send-email-mst@kernel.org>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Apr 15, 2025 at 06:18:08AM +0000, CLEMENT MATHIEU--DRIF wrote:
> Address space creation might end up being called without holding the
> bql as it is exposed through the IOMMU ops.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Stefan, want to pick this one up, too?


> ---
>  hw/i386/intel_iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dffd7ee885..fea2220013 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>      vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
>      if (!vtd_dev_as) {
>          struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
> +        bool take_bql = !bql_locked();
>  
>          new_key->bus = bus;
>          new_key->devfn = devfn;
> @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>          vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>          vtd_dev_as->iova_tree = iova_tree_new();
>  
> +        /* Some functions in this branch require the bql, make sure we own it */
> +        if (take_bql) {
> +            bql_lock();
> +        }
> +
>          memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX);
>          address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root");
>  
> @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>  
>          vtd_switch_address_space(vtd_dev_as);
>  
> +        if (take_bql) {
> +            bql_unlock();
> +        }
> +
>          g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
>      }
>      return vtd_dev_as;
> -- 
> 2.49.0


