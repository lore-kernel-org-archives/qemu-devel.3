Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151C3C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCdd-0002lf-0a; Fri, 24 Jul 2026 05:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCdb-0002lH-6D
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCdY-0006Fh-Hf
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784886969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oRn4RqvNJ/sf4Akhf565cpp2IaOA/zWXYW4oXT+cWNs=;
 b=idpjCUm+lkWasUk69tpF4JavklFUVJ4A3mUqhRvTvN4eoqqlM/+bQ2WCkhXovdxPsz+zRg
 xb02NTu66cVXArJBQUYA/GCgxBs071SpULP+Vd3oFWZdd5zkPCcehsgdepvhzf5do/60Dn
 JW4CVibMW705k3sF4iYGGsYvPYRSGsI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-dqSPlOa1NvCHtdmCLhWZBg-1; Fri, 24 Jul 2026 05:56:08 -0400
X-MC-Unique: dqSPlOa1NvCHtdmCLhWZBg-1
X-Mimecast-MFC-AGG-ID: dqSPlOa1NvCHtdmCLhWZBg_1784886967
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4740be00302so245445f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784886967; x=1785491767; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oRn4RqvNJ/sf4Akhf565cpp2IaOA/zWXYW4oXT+cWNs=;
 b=GP2L+Oi56hvkRULyAnsaWd5qsNnDrsdvlnraxyLjrSwatOOVAtInLQlQfAUHGUZi98
 w+GOnmhS1hr0l0ZENyXHCkTTvMi6t3wAbHps/zcTL/MBwPNsw+oF4Icx4s6d16Cr/cbk
 RZOIXEPdn6FDJQFKvMHdhqH1zGEOdCbVmoUrE2gsx2U+kqyWxs56Xit6Q1YLX7grZyo3
 8cQUsKi3+mDMuV4A20cMsqYzwXoRJTyKBqGByK/Lng71ByhyyGvCEMfecs3MseSbRsjB
 K6Vhzzml6dFeE6Dso6elHNN7/H03goQF/3I0jclulujuJHJvQ78Hbw0Few3JCjWb1DTG
 ZPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886967; x=1785491767;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oRn4RqvNJ/sf4Akhf565cpp2IaOA/zWXYW4oXT+cWNs=;
 b=Kl6hGWrbTxhPL8vPTishdBxUvsE87UXesV4rYCiGM5BHnUdxeWxJaKeBW7ZqSzOGZy
 Jw9HKdstrisjftHdXlrpASnUZwuwTd+BIrXDRIZ82l0agrEkU2Bf8Fs5b0yTJWU8+Ike
 qA/wMajNOeNepMNOaMXhZB963Ok4lHUjzwy4of1Xw1/zNLvZB9QOC2m9v4WdmJdXKS6C
 Or2dTQOtoh/7JBL12Q807U8H7h82HHjKd+Hu5eNBzmGsuVR/6EcwuIakdTk5DLzVi44Q
 Xj+trqJVdZbpX49NQ3dSd1vZIyZBvvUaPx4qW34pWN1mcEdva+J59z9cwz8BdfggPW6F
 5sDw==
X-Gm-Message-State: AOJu0YyaZhk7xcy2uDIyjRu6dfmd4kof7lRSXzb2sHohvRfThWmxnT5L
 xevHbTRhUc1J8CdVmoMjrx8i4SBhnaMhKfjxjH6+fyLuCeTgiJA7vQKTisdUPcQOOl6zjb4DA0i
 poMUNTboraeyqH8oKi0ACRp62D3aAFlX2dL8KH4CJ+ueQ0chD+lEsq20w
X-Gm-Gg: AR+sD10KuqxYxDqgEVbhjcPHoTK2kD5MabA6jSW7MymSOhh60vZBPY/op+98qQ+7qcR
 eGk3txo8Goh1CKSJjqoqHDeZ2oHJIzvmHlDpHr/+0XhbrVj+mNtA5UVy5NMhWvKBHtwO8nNyV3T
 DFETEd6quZx0g8jXMSO1A4ceEqFWrfBOfkqux9pFw26AzyFiADNhURHTOAjXJvus7//FbAbK23Q
 4zTtJKqcivm61U6fQJlBhB/BvTmF4Yp3Ckp+GfxXS6LNiehZWWVr5aCbW+xJT3DifHlhgjXQcXf
 dagIDEAIwevCBnzuymklxp9KBbq23n4rrh7On+KeVX+9AAkn5HoYSnfkNVLNS83TPYRMLWxtCuq
 7xsgfCE0WgUg2avDWBgiZUw==
X-Received: by 2002:a5d:64c3:0:b0:47f:838c:4256 with SMTP id
 ffacd0b85a97d-47f8d71c7f5mr9083816f8f.16.1784886966623; 
 Fri, 24 Jul 2026 02:56:06 -0700 (PDT)
X-Received: by 2002:a5d:64c3:0:b0:47f:838c:4256 with SMTP id
 ffacd0b85a97d-47f8d71c7f5mr9083766f8f.16.1784886966040; 
 Fri, 24 Jul 2026 02:56:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63678sm21269614f8f.29.2026.07.24.02.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:56:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:56:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH 1/3] hw/virtio: Optimize vhost_log_sync_range to avoid
 N^2 complexity
Message-ID: <20260724055156-mutt-send-email-mst@kernel.org>
References: <20260724093750.810018-1-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093750.810018-1-xiongwm2026@163.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2026 at 05:37:50PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The vhost_log_sync_range() function iterates through all memory sections
> for each call, resulting in O(N^2) complexity when syncing dirty
> bitmaps. This is inefficient for guests with many memory sections.
> 
> Optimize this by:
> 1. Checking if a section overlaps with [first, last] range before
>    calling vhost_sync_dirty_bitmap()
> 2. Early exit when section starts beyond the requested range

As any optimization, I expect actual perf measurements
showing an improvement to be included please.

> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  hw/virtio/vhost.c | 18 +++++++++++++++--
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -280,11 +280,21 @@ static void vhost_log_sync(MemoryListener *listener,
>  static void vhost_log_sync_range(struct vhost_dev *dev,
>                                   hwaddr first, hwaddr last)
>  {
> -    int i;
> -    /* FIXME: this is N^2 in number of sections */
> -    for (i = 0; i < dev->n_mem_sections; ++i) {
> -        MemoryRegionSection *section = &dev->mem_sections[i];
> -        vhost_sync_dirty_bitmap(dev, section, first, last);
> +    int i, j;
> +    bool section_dirty = false;
> +
> +    for (i = 0; i < dev->n_mem_sections; ++i) {
> +        MemoryRegionSection *section = &dev->mem_sections[i];
> +        hwaddr section_start, section_end;
> +
> +        /* Skip sections that don't overlap with [first, last] */
> +        section_start = section->offset_within_address_space;
> +        section_end = section_start + int128_get64(section->size) - 1;
> +
> +        if (section_end < first || section_start > last) {
> +            continue;
> +        }
> +
> +        vhost_sync_dirty_bitmap(dev, section, first, last);


So it is still O(N^2) right? It just skips calling it for
some sections.

>      }
>  }
>  


