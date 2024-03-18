Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04490C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDPx-0003SX-0t; Mon, 18 Mar 2024 09:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDPt-0003Od-TF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmDPr-0002yO-Ei
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710769958;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKIDMgt+X4yr6Wx8ftv3fFaZmKTBScinp5s+yF/ElXM=;
 b=BOTQpTJL4aBeJGQmmY+04/c/hUiEFpbX0sJvl14+JwEMHvWoFapbIxGV+SNHP39dthSuez
 TXVwWZyClSYyjom2OYPw/Do51N64N1uaXXQTRc3oQ19qfMJrIpMWVu9whIc9x2dZTcmd7M
 Ch0xPuBgU8LfhvMnaBb6VHdQZJMkpEI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-DMIo7vjdMmSKKvIjTd8njQ-1; Mon, 18 Mar 2024 09:52:37 -0400
X-MC-Unique: DMIo7vjdMmSKKvIjTd8njQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc64f63d768so6905909276.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 06:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710769957; x=1711374757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKIDMgt+X4yr6Wx8ftv3fFaZmKTBScinp5s+yF/ElXM=;
 b=ZKcabygYSQuFnFhR5jojO4RlQcy3aA0AQagqa7Y8PUowDONQeKY8UKY8JiMtLhymKS
 jnbAw+wyBhYQs+IzH6Qzq/GnUMFN7GJIZJe3IfeE7X33zxyG9JHyS75NR5iQKsCIcZcx
 TWfXxEKhcapqCVYfybF1DunaHxBM3/9iJQr7p3+Bm94Ape94ZeACM0Z0uMPbiNCwgAG1
 pk3Ci/Hno/9TEdfh/mkFCx0Jy8KDGumM/EK0ARdgXmZ1Y6Q4dM9KCvBi9hxKxiKOeUVJ
 Cpts/wt01uQ0U6VeOCENeQ3H1NraeX6g+xFTagChNrlZ6xErcA82yR6Dk9DnhydyJ5bv
 BSLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4f7CwHcmDuYRXIDcxiUIJtCtnYrNAWzP31JM0ni3EvqdzpIIHdO6BRCAJaHDQwvKC8R7i+sdTfMwyb8UIpavABHYcVj8=
X-Gm-Message-State: AOJu0Yzcrh84FIuszr80QA/Cf+2+YdAHdnTVK5b5ZvaXNsXt9aGvnkpB
 l2p2wmeXDQUGOoGuP4psIx2He8qKXei2yqqzYGzGrRo60dYM45cO6H1KrqhHiQLpMj0AmnNQma/
 u55jNKi3K7mwt04JpoPln9D2ldR45qQOVVorKLkL94gctrdy4vn5K
X-Received: by 2002:a25:acc5:0:b0:dcf:313d:d4ab with SMTP id
 x5-20020a25acc5000000b00dcf313dd4abmr9505689ybd.54.1710769956913; 
 Mon, 18 Mar 2024 06:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE04HbkPi9lK5Rike1yhJXpd0UgET83qjWeJqz9J2UjMDikC4HuM2dxV6s5IZVfelnamlQfOg==
X-Received: by 2002:a25:acc5:0:b0:dcf:313d:d4ab with SMTP id
 x5-20020a25acc5000000b00dcf313dd4abmr9505661ybd.54.1710769956624; 
 Mon, 18 Mar 2024 06:52:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 t5-20020ac87385000000b00430ac228781sm4188862qtp.67.2024.03.18.06.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 06:52:35 -0700 (PDT)
Message-ID: <d386b8e4-b597-492c-b0ab-4b4246906f94@redhat.com>
Date: Mon, 18 Mar 2024 14:52:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create callback
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

Hi ZHenzhong,

On 2/28/24 04:58, Zhenzhong Duan wrote:
> Introduce host_iommu_device_create callback and a wrapper for it.
>
> This callback is used to allocate a host iommu device instance and
> initialize it based on type.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h         | 1 +
>  include/hw/vfio/vfio-container-base.h | 1 +
>  hw/vfio/common.c                      | 8 ++++++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b6676c9f79..9fefea4b89 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -208,6 +208,7 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>                         AddressSpace *as, Error **errp);
>  void vfio_detach_device(VFIODevice *vbasedev);
> +void host_iommu_device_create(VFIODevice *vbasedev);
>  
>  int vfio_kvm_device_add_fd(int fd, Error **errp);
>  int vfio_kvm_device_del_fd(int fd, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index b2813b0c11..dc003f6eb2 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -120,6 +120,7 @@ struct VFIOIOMMUClass {
>      int (*attach_device)(const char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>      void (*detach_device)(VFIODevice *vbasedev);
> +    void (*host_iommu_device_create)(VFIODevice *vbasedev);
>      /* migration feature */
>      int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
>                                     bool start);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 059bfdc07a..41e9031c59 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1521,3 +1521,11 @@ void vfio_detach_device(VFIODevice *vbasedev)
>      }
>      vbasedev->bcontainer->ops->detach_device(vbasedev);
>  }
> +
> +void host_iommu_device_create(VFIODevice *vbasedev)
> +{
> +    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
> +
> +    assert(ops->host_iommu_device_create);
at this stage ops actual implementation do not exist yet so this will
break the bisection

Eric
> +    ops->host_iommu_device_create(vbasedev);
> +}


