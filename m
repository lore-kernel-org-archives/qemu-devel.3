Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B152C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5Rp-00014D-VA; Mon, 17 Feb 2025 13:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk5Re-00013b-Fy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tk5Rb-0004kc-Ed
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739815329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xCmfO2pjNeKfmfjK9f57fRoNTmn4VruD4gvt6jp6M2U=;
 b=BEas3ajeBmBA8r7tgt+QE1vv7uO5dPyJUWgUtw1j2fUW/qhLr0nzJiPB5beBhLm4AF47dt
 pYT9zQL0UrkV7/u/Obw4pnRc0egNuGjWIwq8fUke1ePg7VJY8ps/B1KsQhbS0wVEF/WG06
 83oAgDPqaXSh3/aXa6abWO5bUNk+5w8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Do9mvi9bNOGv24R9gsPBGQ-1; Mon, 17 Feb 2025 13:02:03 -0500
X-MC-Unique: Do9mvi9bNOGv24R9gsPBGQ-1
X-Mimecast-MFC-AGG-ID: Do9mvi9bNOGv24R9gsPBGQ_1739815322
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393535043bso26941225e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739815322; x=1740420122;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCmfO2pjNeKfmfjK9f57fRoNTmn4VruD4gvt6jp6M2U=;
 b=sAU0tJoyUCIc7j3sJfLy8EjqplN81r+5C6i4daOzhXUIecdaQuP2Jfab8kgiE5rU7j
 WHgd12uYn7zcPWXH7KjvRJX7JiNJs+mk5BMjrHPsYszBuhzEQhgoqO02BXox1myrP1+b
 Za7cGJui8rdWf1fZJj2xzfvQAfAS1GvH9DqNTDh3/g9KQEm/m4VqoPX8MCE4DB5VPZ2a
 kpWPv/SZqsaiJK5LX47LxfdInYTuK+8bTuPLieil7WJziQqW3TjzSbUgNbtPgaPKMidZ
 OCiM8hKRnvPK+uk/DYk3QhJdJcQIcl7Qs6j12ZI9cNwyJjwDCsGkfFMXgXziMF5gMtug
 6fYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Cmsz0BTyBL68wMtPZ8ol4Gt8aBZEfAkAdq1RYH1BmDYuAjVHHkb5Ko51R7iFQzqRNhW2avXtYqLL@nongnu.org
X-Gm-Message-State: AOJu0YxIoq56y3MsOP7mzxf+Zju79u7JbkqzZcUH1fJktsV5LhP6XfNS
 v8RCXxo3MSWCDwZqOwtsvdPgB90+Om3L1m1ST3UDQF+Qj0jTDPU9vrYIQRoYZEtXJ9TuvT1gvry
 I3z+X4Dggbjcop8KPNm3fDNpkK9QW7FrKYcZhmMfnlJuCe6caOXaQ
X-Gm-Gg: ASbGncuRIiU9aiUDZM9+BMlpn8HLVKdrOdii3k++BVHYy3oZYsbUv4m4ZHBTIn7lqXg
 zKZf/XGl3NBpnmMue7Qz9lE/OfgnGYWBBB+BwGbcQevPI/vPMlEatu3zXFPYo826llN/73swGJP
 JgqQHy3b+LZTiH1vPG91si7MygHmfzGnwdDl6CBThtNPwIYB5FICIA57z6oYY+K2Bnjum2sRShL
 uSNtvo0NJKEGgbR6aKUBds1LIhON4CvyP3phb/7OkplROs0DHiMh1PCPrcJDuMhaJLpUKcKyblW
 Fq1+FNgIk8TwXH9XI/wnhGdCOVI25y6gAHPp/dv3
X-Received: by 2002:a05:600c:3012:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-4398490d2b2mr38533345e9.4.1739815322216; 
 Mon, 17 Feb 2025 10:02:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgdBPPeziS3/PQw51y6FcuJjI6U3TwGc/FpS8bEdqBWd3mdGu2fkaxOmcesMBhre8E96pdpA==
X-Received: by 2002:a05:600c:3012:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-4398490d2b2mr38532875e9.4.1739815321790; 
 Mon, 17 Feb 2025 10:02:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f23asm158053495e9.7.2025.02.17.10.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:02:00 -0800 (PST)
Message-ID: <3148f69d-58ca-4a82-9cd1-ab5d0f051a5a@redhat.com>
Date: Mon, 17 Feb 2025 19:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/45] vfio/container: reform vfio_connect_container
 cleanup
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-7-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1739542467-226739-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/14/25 15:13, Steve Sistare wrote:
> Replace the proliferation of exit labels in vfio_connect_container with
> conditionals for cleaning each piece of state.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/container.c | 61 +++++++++++++++++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 0f17d53..c668d07 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -587,9 +587,12 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   {
>       VFIOContainer *container;
>       VFIOContainerBase *bcontainer;
> -    int ret, fd;
> +    int ret, fd = -1;
>       VFIOAddressSpace *space;
> -    VFIOIOMMUClass *vioc;
> +    VFIOIOMMUClass *vioc = NULL;
> +    bool new_container = false;
> +    bool group_was_added = false;
> +    bool discard_disabled = false;
>   
>       space = vfio_get_address_space(as);
>   
> @@ -608,35 +611,37 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   
>       fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>       if (fd < 0) {
> -        goto put_space_exit;
> +        goto fail;
>       }
>   
>       ret = ioctl(fd, VFIO_GET_API_VERSION);
>       if (ret != VFIO_API_VERSION) {
>           error_setg(errp, "supported vfio version: %d, "
>                      "reported version: %d", VFIO_API_VERSION, ret);
> -        goto close_fd_exit;
> +        goto fail;
>       }
>   
>       container = vfio_create_container(fd, group, errp);
>       if (!container) {
> -        goto close_fd_exit;
> +        goto fail;
>       }
> +    new_container = true;
>       bcontainer = &container->bcontainer;>   
>       if (!vfio_cpr_register_container(bcontainer, errp)) {
> -        goto free_container_exit;
> +        goto fail;
>       }
>   
>       if (!vfio_attach_discard_disable(container, group, errp)) {
> -        goto unregister_container_exit;
> +        goto fail;
>       }
> +    discard_disabled = true;
>   
>       vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>       assert(vioc->setup);
>   
>       if (!vioc->setup(bcontainer, errp)) {
> -        goto enable_discards_exit;
> +        goto fail;
>       }
>   
>       vfio_kvm_device_add_group(group);
> @@ -645,6 +650,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   
>       group->container = container;
>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +    group_was_added = true;
>   
>       bcontainer->listener = vfio_memory_listener;
>       memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> @@ -652,35 +658,34 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>       if (bcontainer->error) {
>           error_propagate_prepend(errp, bcontainer->error,
>               "memory listener initialization failed: ");
> -        goto listener_release_exit;
> +        goto fail;
>       }
>   
>       bcontainer->initialized = true;
>   
>       return true;
> -listener_release_exit:
> -    QLIST_REMOVE(group, container_next);
> -    vfio_kvm_device_del_group(group);
> +
> +fail:
>       memory_listener_unregister(&bcontainer->listener);
> -    if (vioc->release) {
> +
> +    if (group_was_added) {
> +        QLIST_REMOVE(group, container_next);
> +        vfio_kvm_device_del_group(group);
> +    }
> +    if (vioc && vioc->release) {
>           vioc->release(bcontainer);
>       }
> -
> -enable_discards_exit:
> -    vfio_ram_block_discard_disable(container, false);
> -
> -unregister_container_exit:
> -    vfio_cpr_unregister_container(bcontainer);
> -
> -free_container_exit:
> -    object_unref(container);
> -
> -close_fd_exit:
> -    close(fd);
> -
> -put_space_exit:
> +    if (discard_disabled) {
> +        vfio_ram_block_discard_disable(container, false);
> +    }
> +    if (new_container) {
> +        vfio_cpr_unregister_container(bcontainer);
> +        object_unref(container);
> +    }
> +    if (fd >= 0) {
> +        close(fd);
> +    }
>       vfio_put_address_space(space);
> -
>       return false;
>   }
>   


