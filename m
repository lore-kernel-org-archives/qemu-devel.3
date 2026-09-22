Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE5EC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wTy-00072D-J7; Tue, 22 Sep 2026 05:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x8wTu-00071n-Ag
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x8wTs-00031l-T3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790068081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEL6qvgqfV+hdyMgF5OE/JQ8tVFFYqU8gfie9EYSyxQ=;
 b=egaUuzKSU6eyHwWgR4xGnJsEDfEycmp0UBB6W/1+ajX11pZXwOb64AOUIKSTm6kSeXmCaQ
 CVrSvOnYJnRatpf2SxH3P7n4b44K93crYb1Ipp1dz3rH3tk7a5SaPq2cw/w6P67rEc8RGE
 IS5ER6QUUSMWYcznkgLVxaQ0kL5zrHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-hUXXXp59PSm9oTKNqAPReg-1; Tue, 22 Sep 2026 05:07:59 -0400
X-MC-Unique: hUXXXp59PSm9oTKNqAPReg-1
X-Mimecast-MFC-AGG-ID: hUXXXp59PSm9oTKNqAPReg_1790068078
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e745d5dabso42415705e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790068078; x=1790672878; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tEL6qvgqfV+hdyMgF5OE/JQ8tVFFYqU8gfie9EYSyxQ=;
 b=ifmbye1Sf4J2DQUYFc6qVWlNE9PX2AHfm3cjQgbN1oCgYULXG0Oh+Jb2M6iOrOIjHX
 EB6e7/qcF5N1rH9+GDErrLBIpM5TZN039pbnmwG7CcIDa/j8eoe+8/wd4HdXbABnjVY0
 nhj3rXGiftsNEWDn3tCQqCA3CTKuWO6MgwWs59NRIzMzDLEvZlW5aoeGtjqI3ZOW62df
 AoquIJnHJqT5gH2XKdBSHQy0pNnzaJB2ZxozEK9trv0VsBtQnvKRSmwEG8Fr3xkdZYpY
 jo8FA5r/szNYtMoo4sw+WlCQwb6WcMYvVeXLVrX16Ex1HtjZPCx0rUjZjZHOMjL9Y6Jz
 m8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790068078; x=1790672878;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tEL6qvgqfV+hdyMgF5OE/JQ8tVFFYqU8gfie9EYSyxQ=;
 b=Glen/2UFcnt37Ra2kahUI0Z9I016kKGJWv7L+mhLibmzirw2qp8H0WYaP6Z9oiQeyQ
 wMQeVoU3FTRdBzqYgQq9NWGrg3SdnrC2C4jhLoy0zUv8OULqzJ40OxSv0sDH0XiAUtxA
 UArf16WXe0HQAKBFojfl4fztTwCAZQHeCToJwI+dy8fuUmJlLyw19nDfPWjq489DisXz
 8rqa1TJvEJdW5T/wgI0Bv4oNmZBxNbHREAMVHbsUsnSx97qYNFlTCEftfdSJjwHD40nH
 sFCOSvONMSQim2H2nyQvonxXRCWoSTiwii1kSBqeVFAklUAZiLxOSHsPt1tjcCZsCdYe
 6XQg==
X-Gm-Message-State: AFuF++kFIa/FunKewzqjE8R2VQYKIv04rnZ90wjj1WCyEt7sHQKcbzzr
 7b1lDPnGedpzpuipB9ogVDsjEirR4oxjNiwq/IUQrKNYRRHUUxm312sQvGTeu2W/own2L8C4XSi
 fcgi5KHAjR+yeTavNetrLs/1hjXNd8K3xIqrW2fEfvAc3C67ihRYalNEs
X-Gm-Gg: AYBFou37kUWorgAwuLpkFX+UPycD0AXQY0hAWsz9WxxFcxvyVcId0rlBZzrKx4tsqKZ
 t4Fyu0shueWjWHpG9WEn5/Acbsdm6QQwv7X4MUBPrxSHy7J/9vK0tU314Sc+z1YRNcvx31XkuO7
 oTW+t6t9b9saqczvnYUXgrhaBs0BUqeup0y/9P/8xmAu7IvWrDwsjJhMiu/knPR3wBYRJek3Kd5
 4hfvzDz+s3CRYWI0nRnh1fY26n8F+jryXbqWyaKyQqQjAOu5iA7ylh2gN4neGadSJOUcLB0gyfG
 +3LmjufDzFdDAyA6wbHGQgh5wdYI5HQLFzv6yfwaqb/NEIf5TYnzhqThNdLmB12geG1uKiHdYT6
 bvL2nl11BhiloWO3w6IENJznZ0mpYQkNZvtRUQrnLqwtKA6Az8cA=
X-Received: by 2002:a05:600c:4e4c:b0:49f:bd3c:bc28 with SMTP id
 5b1f17b1804b1-49fc574f456mr190736225e9.35.1790068078402; 
 Tue, 22 Sep 2026 02:07:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4c:b0:49f:bd3c:bc28 with SMTP id
 5b1f17b1804b1-49fc574f456mr190735785e9.35.1790068077930; 
 Tue, 22 Sep 2026 02:07:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it.
 [82.53.134.131]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad40b32sm29578015e9.9.2026.09.22.02.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:07:57 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:07:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com, 
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, peterx@redhat.com, den@openvz.org
Subject: Re: [PATCH v7 09/16] vhost-vsock: preserve vhost FD during CPR
Message-ID: <arJFQKUTmVYQ2tLM@sgarzare-redhat>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-9-6ef9ef033c35@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-9-6ef9ef033c35@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 18, 2026 at 04:47:00PM +0300, Andrey Drobyshev wrote:
>During CPR (checkpoint-restore) migration the guest keeps running on the
>same host, so instead of reopening /dev/vhost-vsock on the destination,
>we should reuse the FD from the source.  The FD is saved in the CPR
>namespace (hash table) with cpr_save_fd() and then reclaimed on the
>target via cpr_find_fd().
>
>Use the (suffixed) device path as the key in CPR hash table.  Device
>path is obtained with qdev_get_dev_path() and is essentially the
>device's address on the underlying bus.  As any vhost-vsock device is
>attached to a virtio bus, whose .get_dev_path() forwards to the proxy
>device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
>always be getting a unique non-empty path with qdev_get_dev_path().
>
>vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>Deferring the ownership handoff to pre_save/post_load is done in a
>following patch.  Until then CPR remains blocked, so the restore path
>added here is not reachable yet.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 36 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


