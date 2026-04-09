Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5188CEA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAnui-0005d2-DT; Thu, 09 Apr 2026 07:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAnug-0005ci-Ge
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wAnue-0006gG-8u
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775735465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MbXxmVu9Xmy1MKFwhFhmGRERwbWRz32beMl+jXO5NSo=;
 b=F7vEivH9Yy++QGqVHrmtcT5GJedYRUB626KVZcsdE7DImdVmJNkqCfqMKOLgkFcSL1N1bU
 wGiFY3vslxBRo3BKQcZmHsISsxU9kf9N8Wqn8mkHQ6xhtca2X+6uoA/Xvkzko4BVsmcTEm
 G+RZd7wTdrqJ/uentZ0L5lxW6U2eMiw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-300SpazOOemHpAd0_EYLOA-1; Thu, 09 Apr 2026 07:51:01 -0400
X-MC-Unique: 300SpazOOemHpAd0_EYLOA-1
X-Mimecast-MFC-AGG-ID: 300SpazOOemHpAd0_EYLOA_1775735460
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d167a0c1fso556240f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775735460; x=1776340260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MbXxmVu9Xmy1MKFwhFhmGRERwbWRz32beMl+jXO5NSo=;
 b=jemyK8gJrVig4EFEf7UjJPf1sY6TEGkFatL/lzg5clAKlsMYXQgOfXeJdz/QvroiQc
 H2SnV8EfxX5exe0zlb3J/ykX0p1ArZ+qNAzFAPhuzodT29tK9Xiqm+qPMmy6EIUJI0qN
 QIFUqBMPLzjviFGCXbusZa4SruSPrGplkU5opj4Xuo+nT47I0vngR0t/fGfQneN+2tJc
 uBFhzw5R32bvSr6/eZGX91O1VJUzfGc0Oe+YFTQWPkk/byJPKIboRFcgJCFxBQZhtuT0
 Kc9yCv4jgEZ/LIoCj6NunGDAIGYDxM+x3hgYs/DG4GPDG3mDqRoftvAaU+GJ3rmWQyzX
 gQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775735460; x=1776340260;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbXxmVu9Xmy1MKFwhFhmGRERwbWRz32beMl+jXO5NSo=;
 b=E3uWlyF7YRX0rmkgehP+2TUtVmc239VCzil+NvSAKzSKRML0Q/PbrLLvufqt7GHVgk
 gcvwyf/KB2YQrsnwX/o8r35aYIbGidW6MIq8mnK3bvelQCXEnb/S8o1yemIrwTm7AdFI
 V++mqgdH1OPjq3QAgZNS2EHjzdzQbumgyCLLFHqBEyz6kgyg6LlC1EZqjK3eIPC6SGVk
 dWBAeJugK19iLg0JMWLk2ZhdDlCzHwgUhh8G8YGNXlpMSRbJr/fLtAgGunWXYPBkZuRw
 FJ6nEZF/LQfjBDQRzR1iT7d15lNIi73oRbYH/ewRxo97UdLGlLnHrOSkJWPkthJa1L55
 DCkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB3u5lYJmcrD2l+RjBTORqUlPuOjLqBc1GLZd1RHcVdhFn2L403xcLurrA+ssVrev8DwGxynZ31Js5@nongnu.org
X-Gm-Message-State: AOJu0YxKltle7ttXje9zYatbDNqetW+NhshikDWzC2d0SJ5Zt1llJ4W/
 yNt8PdQ1ink7nqDijCDxw8qq8KL61POsO4Bv/UHSQqZJG/0OazeR/DugR5mYpsd3XTrdH4hcTRd
 ojvrpx430VVjSFDqlUe7DRQEnWdUvqr6lD6lzATVu8u2ssg89Zy5GYtrr
X-Gm-Gg: AeBDieuF4sbHrONc5OsDtQGzTzp7Hvv86jojfeZeJEd2HeHsLdj145yDaQHOAZMAARg
 4TDKMJWk0r5uCKknH2UjzyRQSEknFVJdj+DqBsvwNIvaXm/ptwUMDjrHn4qpEhoPJ54v4POVAOW
 IGtFvQIFjptbY9un84ayMX52vl1DxjfNvxIysq82ighVj6fdBOPfOUHmov+TAarqFQEa/M+rtEe
 4dVMQMigWPOwNCk/PPU73P9E7m0KXXwCt1j7lxDUWuNnl7x7t5R9Q8lgNoowQ3GTGDRJYli6n/+
 nAfdloeQTAluh9VVq6raa92PJA7RWbYDVCXWbo/JWSmifyHyPf2stMNH6flqJoM5+qC12G7bmK/
 Dc0k2wRp9JJ7lsAcn7d6Yfe6exrZF8xSRsdPz/mj0AJqTmsRIEbUvVBenaQ==
X-Received: by 2002:a05:6000:1789:b0:43d:1bf6:30f7 with SMTP id
 ffacd0b85a97d-43d2927716bmr35454842f8f.18.1775735460323; 
 Thu, 09 Apr 2026 04:51:00 -0700 (PDT)
X-Received: by 2002:a05:6000:1789:b0:43d:1bf6:30f7 with SMTP id
 ffacd0b85a97d-43d2927716bmr35454795f8f.18.1775735459763; 
 Thu, 09 Apr 2026 04:50:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f52easm67473264f8f.36.2026.04.09.04.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 04:50:59 -0700 (PDT)
Message-ID: <6c5a98ca-2ac4-4239-b3aa-30e5572f2c72@redhat.com>
Date: Thu, 9 Apr 2026 13:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio-user: support VFIO_USER_DEVICE_FEATURE
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260409104756.465294-1-john.levon@nutanix.com>
 <20260409104756.465294-2-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260409104756.465294-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/9/26 12:47, John Levon wrote:
> Plumb through vfio_device_get_feature to the vfio-user server. Note that
> we translate EINVAL into ENOTTY, as the existing generic vfio code is
> expecting the latter to mean "unsupported".
> 
> As part of adding a trace point, clean up the trace file.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/protocol.h   | 12 +++++++++++
>   hw/vfio-user/device.c     | 42 +++++++++++++++++++++++++++++++++++++++
>   hw/vfio-user/trace-events | 23 +++++++++++----------
>   3 files changed, 67 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
> index 3249a4a6b6..2a0c31e7c5 100644
> --- a/hw/vfio-user/protocol.h
> +++ b/hw/vfio-user/protocol.h
> @@ -40,6 +40,7 @@ enum vfio_user_command {
>       VFIO_USER_DEVICE_RESET              = 13,
>       VFIO_USER_DIRTY_PAGES               = 14,
>       VFIO_USER_REGION_WRITE_MULTI        = 15,
> +    VFIO_USER_DEVICE_FEATURE            = 16,
>       VFIO_USER_MAX,
>   };
>   
> @@ -239,4 +240,15 @@ typedef struct {
>       VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
>   } VFIOUserWRMulti;
>   
> +/*
> + * VFIO_USER_DEVICE_FEATURE
> + * imported from struct vfio_device_feature
> + */
> +typedef struct {
> +    VFIOUserHdr hdr;
> +    uint32_t argsz;
> +    uint32_t flags;
> +    char data[];
> +} VFIOUserDeviceFeature;
> +
>   #endif /* VFIO_USER_PROTOCOL_H */
> diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
> index 64ef35b320..b8d2b7c1a8 100644
> --- a/hw/vfio-user/device.c
> +++ b/hw/vfio-user/device.c
> @@ -74,6 +74,47 @@ void vfio_user_device_reset(VFIOUserProxy *proxy)
>       }
>   }
>   
> +static int
> +vfio_user_device_io_device_feature(VFIODevice *vbasedev,
> +                                   struct vfio_device_feature *feature)
> +{
> +    g_autofree VFIOUserDeviceFeature *msgp = NULL;
> +    int size = sizeof(VFIOUserHdr) + feature->argsz;
> +    VFIOUserProxy *proxy = vbasedev->proxy;
> +    Error *local_err = NULL;
> +
> +    msgp = g_malloc0(size);
> +
> +    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_FEATURE, size, 0);
> +
> +    memcpy(&msgp->argsz, &feature->argsz, feature->argsz);
> +
> +    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, size, &local_err)) {
> +        error_prepend(&local_err, "%s: ", __func__);
> +        error_report_err(local_err);
> +        return -EFAULT;
> +    }
> +
> +    if (msgp->hdr.flags & VFIO_USER_ERROR) {
> +        /*
> +         * Client expects ENOTTY for "not supported", but the protocol may
> +         * return EINVAL (which should only occur in the case the feature isn't
> +         * actually supported on the server).
> +         */
> +        if (msgp->hdr.error_reply == EINVAL) {
> +            return -ENOTTY;
> +        }

May be this is not necessary anymore with :

   https://lore.kernel.org/qemu-devel/20260409114312.1704062-1-clg@redhat.com/

> +
> +        return -msgp->hdr.error_reply;
> +    }
> +
> +    memcpy(feature, &msgp->argsz, feature->argsz);
> +
> +    trace_vfio_user_device_io_device_feature(msgp->argsz, msgp->flags);
> +
> +    return 0;
> +}
> +
>   static int vfio_user_get_region_info(VFIOUserProxy *proxy,
>                                        struct vfio_region_info *info,
>                                        VFIOUserFDs *fds)
> @@ -432,6 +473,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
>    * Socket-based io_ops
>    */
>   VFIODeviceIOOps vfio_user_device_io_ops_sock = {
> +    .device_feature = vfio_user_device_io_device_feature,
>       .get_region_info = vfio_user_device_io_get_region_info,
>       .get_irq_info = vfio_user_device_io_get_irq_info,
>       .set_irqs = vfio_user_device_io_set_irqs,
> diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
> index abb67f4c11..84714781cf 100644
> --- a/hw/vfio-user/trace-events
> +++ b/hw/vfio-user/trace-events
> @@ -2,19 +2,22 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -# common.c
> +# container.c
> +vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
> +vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
> +
> +# device.c
> +vfio_user_device_io_device_feature(uint32_t argsz, uint32_t flags);

missing format here ^


Thanks,

C.


> +vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
> +vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
> +vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
> +vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
> +vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
> +
> +# proxy.c
>   vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
>   vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
>   vfio_user_recv_request(uint16_t cmd) " command 0x%x"
>   vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
>   vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
> -vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
> -vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
> -vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
> -vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
> -vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
>   vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
> -
> -# container.c
> -vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
> -vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"


