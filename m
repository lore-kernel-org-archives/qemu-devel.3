Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B15D5CCA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 12:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t67hd-0007ii-EJ; Wed, 30 Oct 2024 08:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t67hb-0007iY-PD
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:21:31 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t67hZ-00039M-Q8
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:21:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e49ef3b2bso4890258b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730290888; x=1730895688;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2a614ZxJIKfeVotfc/D8jNHFfZKIJhUS5p7FdpXdhKA=;
 b=z/Phe2nCSIh2hn88KBvUN5VOiurxOq1XMYJGsWn8gkjJP5rdTtwhYSaN8+wmct8GgS
 O9SK8ZcfklyYSQtzmbeL9v9fJtTyomAh2L0OTRWAlp4WFjFCXK2mpGU+UGE8LmKbiiRN
 Nx8XYQNyhREUKHqSVRDPGxAqeVX3IMQ5KxhfWs0VwlnvQCuk2iPPGKeknhAUk7vrmgLK
 WWh/HhYU+TNjQ8vgfb2LbyEqud5T3kLjWcvtz4ubLVdggBYpvjWcszYTQtDUi7VpRgdI
 qlGN8TP54ggLZKeOXEFQx53dDdujKXTcJP1qeDyqCtkzS5bv55TwNOWM+qVwxZ9CCqeO
 LG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730290888; x=1730895688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2a614ZxJIKfeVotfc/D8jNHFfZKIJhUS5p7FdpXdhKA=;
 b=HLJQtV6WdjpJO2KHizFzO2/QTOgGoloGvbMUO1hfmH7Sw54VQqzvNAhGGVSznP/MaZ
 2C+gb+zuu33O1q76p7QjpH0A+URVfcqDXL6uJzuD+Zxrj8F5qsoMzvdh7pNHWYtVlVYY
 0dlnJm4u7RJh9B7uzi2N6Or80eT94Rsz+FKCMcD/QagMKhHPMix4qXVI2xK4BAaXBe3q
 aceMJsPp3s8cEFJT8elMNgx09bKZR/e6uu0wydsRjyGnVzTm2aYwBsD5U65//1WGHe7S
 5LhP9CmwSpgVWi7zuNAUW2vyDL//L0Nhysb9L/+uvTq1wF0biM4mTpcWfpki14qnxfU4
 wwlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN+Rls5612WCM9FQLpSJh0ySDj+GX9Bh+ksI2ZpICVubSqR4RGPp1JXyQ8UR5msKo0x7GSL3FbB3zC@nongnu.org
X-Gm-Message-State: AOJu0YxGf3V9+QQKNRbJ9vBwQXwnCrfnsPK74NnEJcujAF3nSVlnY3tn
 MIbnsfe605A1A6LfkBz/oo1gu/8mjpkZ6IJFQ2YXbQTBYtEgW3cAGaUeLOv73PQ=
X-Google-Smtp-Source: AGHT+IEqBf+ZcGb7NbHvoLsWLZ3M6tbhfc12PZa00vyXy1VH73YP0KBI/HMRuLmfLnkvqZE8E7PacQ==
X-Received: by 2002:a05:6a00:182a:b0:720:36c5:b531 with SMTP id
 d2e1a72fcca58-720ab3f1fd3mr3776143b3a.14.1730290887584; 
 Wed, 30 Oct 2024 05:21:27 -0700 (PDT)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7205793272bsm9090033b3a.69.2024.10.30.05.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 05:21:27 -0700 (PDT)
Message-ID: <3e8be3c0-e528-4c41-865d-67960012e30b@daynix.com>
Date: Wed, 30 Oct 2024 21:21:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: Fix missing hash type and hash value
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Cc: yan@daynix.com, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
References: <20241030121334.134794-1-yuri.benditovich@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241030121334.134794-1-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/30 21:13, Yuri Benditovich wrote:
> virtio_net_receive_rcu does not populate hash value and
> hash type in case it needs to change queue number from the
> initially defined by tap/tun to one calculated according
> to the packet hash. Earlier commit a4c960e places the hash
> value/type into local extra_hdr structure but the extra_hdr
> is not filled in recursive call to virtio_net_receive_rcu.
> Current commit discards the recursive call and just continues
> execution with changed net client state and uses correct
> virtio-net queue for the packet.
> 
> Fixes: a4c960e ("virtio-net: Do not write hashes to peer buffer")
> 
> Jira link: https://issues.redhat.com/browse/RHEL-59572
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

Hi,

I have submitted a similar patch:
https://patchew.org/QEMU/20240915-queue-v1-0-b49bd49b926d@daynix.com/20240915-queue-v1-4-b49bd49b926d@daynix.com/

Jason, please pick the buglink, which was missing in my patch.

Regards,
Akihiko Odaki

> ---
>   hw/net/virtio-net.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index f2104ed364..ed4e33b48c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1898,7 +1898,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>                                         size_t size, bool no_rss)
>   {
>       VirtIONet *n = qemu_get_nic_opaque(nc);
> -    VirtIONetQueue *q = virtio_net_get_subqueue(nc);
> +    VirtIONetQueue *q;
>       VirtIODevice *vdev = VIRTIO_DEVICE(n);
>       VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
>       size_t lens[VIRTQUEUE_MAX_SIZE];
> @@ -1915,12 +1915,13 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>       if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
>           int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
>           if (index >= 0) {
> -            NetClientState *nc2 =
> -                qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
> -            return virtio_net_receive_rcu(nc2, buf, size, true);
> +            /* change nc to proper one */
> +            nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
>           }
>       }
>   
> +    q = virtio_net_get_subqueue(nc);
> +
>       /* hdr_len refers to the header we supply to the guest */
>       if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
>           return 0;


