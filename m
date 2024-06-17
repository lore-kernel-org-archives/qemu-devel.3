Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF153C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAb4-0004Ok-KR; Mon, 17 Jun 2024 07:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJAb3-0004Nv-BY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJAb1-0004YO-NA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718623942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMrv47O6eUwXlI8pbPzwLgmtgQt8f4SScH7RowQ8aFk=;
 b=fYZdlRkK68z2JuIsLIm+weFoGxLN1cVks6YSb2DJWSmz32lVngupEouyIQ4QUjbWig1hU0
 bUTj98LlOrKA1ZSBsIlAZ0yFs5Flop//vUQOJWacc2NINBhKTd2B+oGVbqCtpCYPgwuehR
 NUIL5ssh75jG+prdkivZrH8w1aR4vd8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-gnxeKARGO-KpbuRQI1_jDQ-1; Mon, 17 Jun 2024 07:32:21 -0400
X-MC-Unique: gnxeKARGO-KpbuRQI1_jDQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-421f3b7b27eso37202645e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718623940; x=1719228740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMrv47O6eUwXlI8pbPzwLgmtgQt8f4SScH7RowQ8aFk=;
 b=gzl1T2po/gMk5lzStICONxmhXfRz992wZT6Vbo63pm83vm4+qe4f5I1wU08K2eIdNT
 JhV9tA8wnkSpfEiMcArQf9ukIQ85vfescO0GTnKEGm1GlGgeXcZzHI/T+BFTdANMPRxH
 Uhm1gKH4bgkOYa53RW76BOpzBaJUpltDxOVG2iEQZf5lY8/u2GWElmjXcVN5Z98RgNH6
 FfKnVvhRbntfBgn0/wcjvlsH9VcaAHIiSDxy7dO7Gnj6yFlyYg5Ln4C5D1pMQAl39NAc
 y0OpTzG+6it4im793kA9THPIR7TfBIuCoGMHQa/IkDnhSjCYomzEZ9oa5kJ0BKknor8w
 YWdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUWaUBInqbyWcotRL/ZjLqGiN/F7LYYQKd8ToZ+7B+TgCDTgdffPHx0JZX12NTOIhFlFTmXoux+dQBTlvtXngnV/Lzah4=
X-Gm-Message-State: AOJu0YwT8Ehhz5pmpaplP/l2LoTwKMrrh5suchythTU0LCzyyj8JEe0z
 9W3pn1j5byJnuN/4mdLUs+NyRFmsAKfkH1OIl56RCV4cGARLjztpeBgGA7OQJCvAgdVKuLV0kQz
 QY5FEI1q08zObWFp9hQw2ue83D2JPQziDCVCKK7D7xL3zOz8WsUkI
X-Received: by 2002:adf:fe12:0:b0:35f:2f14:b98 with SMTP id
 ffacd0b85a97d-3607a783420mr9205218f8f.48.1718623940065; 
 Mon, 17 Jun 2024 04:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9IEEh6uinHRrSitao1MYEPHbrQboUPPSPyVCPvW8aT/joLdHcqa2pivCJkbRwSqgQlUBFTw==
X-Received: by 2002:adf:fe12:0:b0:35f:2f14:b98 with SMTP id
 ffacd0b85a97d-3607a783420mr9205196f8f.48.1718623939690; 
 Mon, 17 Jun 2024 04:32:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36079d78ce2sm10403350f8f.19.2024.06.17.04.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 04:32:19 -0700 (PDT)
Message-ID: <7bbad3cb-318d-41b2-8dbf-1ba69f35c64a@redhat.com>
Date: Mon, 17 Jun 2024 13:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] vfio: Remove unused declarations from
 vfio-common.h
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-3-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/17/24 08:33, Cédric Le Goater wrote:
> These were forgotten in the recent cleanups.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


> ---
>  include/hw/vfio/vfio-common.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 776de8064f740784f95cab0311c5f15f50d60ffe..c19572f90b277193491020af28e8b5587f15bfd1 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -207,10 +207,6 @@ typedef struct VFIODisplay {
>  VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>  void vfio_put_address_space(VFIOAddressSpace *space);
>  
> -/* SPAPR specific */
> -int vfio_spapr_container_init(VFIOContainer *container, Error **errp);
> -void vfio_spapr_container_deinit(VFIOContainer *container);
> -
>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);


