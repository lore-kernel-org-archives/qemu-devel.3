Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3A1C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRMI-0006DC-17; Thu, 15 May 2025 01:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFRMF-000693-Ty
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFRME-0008AO-10
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747287731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RH+dcKKzj+jm/NX/Xjll1QgiD2/5+19yEs2McATebiU=;
 b=SjbI7rMYGenMcHjgRbACnGoqGCZCWF4nj25R4/jM0y2Ge/luUQZnSwfyrvz2iYGwLN8R/D
 0faFLKCct6fDb9f8nD3VcaC3b7pgQbfPy3avPGCCy7FQ7CVM9zqHD8JJa4GJXrunTQTbXw
 PCiLzd2QOs06jYpa3yun6UShKtLWeB4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-3wqAsqdhO_2_2H6ECHvHoA-1; Thu, 15 May 2025 01:42:09 -0400
X-MC-Unique: 3wqAsqdhO_2_2H6ECHvHoA-1
X-Mimecast-MFC-AGG-ID: 3wqAsqdhO_2_2H6ECHvHoA_1747287728
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso1996345e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287728; x=1747892528;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RH+dcKKzj+jm/NX/Xjll1QgiD2/5+19yEs2McATebiU=;
 b=E4HlP7/4IzpTQHubXb9U/05wvr+scXoboD5hi/HPEO51vLbmI32EA4L1JrB5aaroxR
 2rtOYdRZPwVDHjGov1kWRuSGY83n93wf3DIIS+1LrUQWCOrjC8Kg6rf2bHrvA3LtPZxM
 bA3R782vcNjbvDDIcvw0/FKUOFwsLsMlfLNUZX+lXPVnEx+LK66iQhK2BmGRbbH6mql6
 DVLwe8VAsl+uhVXoyiQUiiq0AHm/33P8qMqnuznGy2YRy12/kVd8v4qTF9KbTd7QAb5C
 LAru/ojo2PW8GnVbkUEJAa26+XPdPjldiuJ+2k9tjxWiYBDrzmTqdOZAzAxR2IwYXEB6
 OTDA==
X-Gm-Message-State: AOJu0YwJJquaccrClGEQkCfjnAi6xF6A6Va06neLwm7oRAOzloz0l2Kb
 8lzVYZxqLKDK8ridivkcCeFWJ9pE/K48N/Iw/MoF1gbKEogGo+InRd65Z5+uq2lhI6hK13eCYbr
 PV/qCM8aZWzw5fpRINZMM03aifCn6l03A9rfXg7pEJl71iIM/y51h
X-Gm-Gg: ASbGncsGCOLIO4nALpEcp8dzq12aYxZDxFk9FOXvPEz+92sU8sddsScOxqC++TEIzdy
 hBp8RRjZobZfDU3yIn/169A0e8NlorrS+i6uj7fxMM4tfFyppXrsZl87ZUwEOZkzEWDSsUvCUiV
 mOzOivEQZKwQFo/rdGoTCFJAqegp4i6BsW6ENeAP7Qy4RyO+eNLT5ZTBWRLGz14DGBmESHtBKuI
 GpS2BcSuIj5fOwQCt6Nd8UWwbG072biX7d1Ee8fylXgDBjUk+Thd//3Aqf91/uSv4R4rXEmQjC6
 Zg/QeQ==
X-Received: by 2002:a05:600c:1e2a:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-442f21696fdmr46549185e9.22.1747287728352; 
 Wed, 14 May 2025 22:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnfPLD20aGOyHS7aBG21xMoUBqfRES6UaHYKjkQ9PKlq+lP2fbm00jldzB6TDoznerSdPWFg==
X-Received: by 2002:a05:600c:1e2a:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-442f21696fdmr46549085e9.22.1747287727955; 
 Wed, 14 May 2025 22:42:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442eb85bb20sm56827705e9.0.2025.05.14.22.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 22:42:07 -0700 (PDT)
Date: Thu, 15 May 2025 01:42:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com,
 si-wei.liu@oracle.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 7/7] vdpa: move memory listener register to
 vhost_vdpa_init
Message-ID: <20250515014103-mutt-send-email-mst@kernel.org>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-8-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507184647.15580-8-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 07, 2025 at 02:46:47PM -0400, Jonah Palmer wrote:
> From: Eugenio Pérez <eperezma@redhat.com>
> 
> Current memory operations like pinning may take a lot of time at the
> destination.  Currently they are done after the source of the migration is
> stopped, and before the workload is resumed at the destination.  This is a
> period where neigher traffic can flow, nor the VM workload can continue
> (downtime).
> 
> We can do better as we know the memory layout of the guest RAM at the
> destination from the moment that all devices are initializaed.  So
> moving that operation allows QEMU to communicate the kernel the maps
> while the workload is still running in the source, so Linux can start
> mapping them.
> 
> As a small drawback, there is a time in the initialization where QEMU
> cannot respond to QMP etc.  By some testing, this time is about
> 0.2seconds.  This may be further reduced (or increased) depending on the
> vdpa driver and the platform hardware, and it is dominated by the cost
> of memory pinning.
> 
> This matches the time that we move out of the called downtime window.
> The downtime is measured as checking the trace timestamp from the moment
> the source suspend the device to the moment the destination starts the
> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> secs to 2.0949.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> 
> v3:
> ---

just know that everything beyond this line is not going into
git commit log.


> Move memory listener unregistration from vhost_vdpa_reset_status to
> vhost_vdpa_reset_device. By unregistering the listener here, we can
> guarantee that every reset leaves the device in an expected state.
> Also remove the duplicate call in vhost_vdpa_reset_status.
> 
> Reported-by: Lei Yang <leiyang@redhat.com>
> Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> 
> --
> v2:
> Move the memory listener registration to vhost_vdpa_set_owner function.
> In case of hotplug the vdpa device, the memory is already set up, and
> leaving memory listener register call in the init function made maps
> occur before set owner call.
> 
> To be 100% safe, let's put it right after set_owner call.
> 
> Reported-by: Lei Yang <leiyang@redhat.com>
> ---
>  hw/virtio/vhost-vdpa.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index de834f2ebd..e20da95f30 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -894,8 +894,14 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
>  
>      ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
>      trace_vhost_vdpa_reset_device(dev);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    memory_listener_unregister(&v->shared->listener);
> +    v->shared->listener_registered = false;
>      v->suspended = false;
> -    return ret;
> +    return 0;
>  }
>  
>  static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
> @@ -1379,6 +1385,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>                           "IOMMU and try again");
>              return -1;
>          }
> +        if (v->shared->listener_registered &&
> +            dev->vdev->dma_as != v->shared->listener.address_space) {
> +            memory_listener_unregister(&v->shared->listener);
> +            v->shared->listener_registered = false;
> +        }
>          if (!v->shared->listener_registered) {
>              memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
>              v->shared->listener_registered = true;
> @@ -1392,8 +1403,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>  
>  static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>  {
> -    struct vhost_vdpa *v = dev->opaque;
> -
>      if (!vhost_vdpa_last_dev(dev)) {
>          return;
>      }
> @@ -1401,9 +1410,6 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
>      vhost_vdpa_reset_device(dev);
>      vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                                 VIRTIO_CONFIG_S_DRIVER);
> -    memory_listener_unregister(&v->shared->listener);
> -    v->shared->listener_registered = false;
> -
>  }
>  
>  static int vhost_vdpa_set_log_base(struct vhost_dev *dev, uint64_t base,
> @@ -1537,12 +1543,27 @@ static int vhost_vdpa_get_features(struct vhost_dev *dev,
>  
>  static int vhost_vdpa_set_owner(struct vhost_dev *dev)
>  {
> +    int r;
> +    struct vhost_vdpa *v;
> +
>      if (!vhost_vdpa_first_dev(dev)) {
>          return 0;
>      }
>  
>      trace_vhost_vdpa_set_owner(dev);
> -    return vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
> +    r = vhost_vdpa_call(dev, VHOST_SET_OWNER, NULL);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
> +    /*
> +     * Being optimistic and listening address space memory. If the device
> +     * uses vIOMMU, it is changed at vhost_vdpa_dev_start.
> +     */
> +    v = dev->opaque;
> +    memory_listener_register(&v->shared->listener, &address_space_memory);
> +    v->shared->listener_registered = true;
> +    return 0;
>  }
>  
>  static int vhost_vdpa_vq_get_addr(struct vhost_dev *dev,
> -- 
> 2.43.5


