Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2267CCA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viFgK-0003fV-Na; Tue, 20 Jan 2026 12:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1viFg6-0003Sw-QG
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:38:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1viFg4-0004t0-3L
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768930682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+4QxSpkNjF2EkzZAKQPlQPI6YXNQ66sF9tBW1H0t1mA=;
 b=FMNMu5SWO4KowYpp8dKGRJndp6OYvjSXhIiemaxuyxybCdtfhOIFyAcO9SmdaLSnPVbvyd
 pqj2Yx8sv6eVMO1YZHTiCVDM/wrkV582/7s+kOonWXQz3SYaP1rOMZjYz8mqqJBLbqLGX+
 K78N5OdwyhDkxOTAlYaWY/YmRcj9lWk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-6kw2m4YoPpqaVHUPGtkrMA-1; Tue, 20 Jan 2026 12:38:01 -0500
X-MC-Unique: 6kw2m4YoPpqaVHUPGtkrMA-1
X-Mimecast-MFC-AGG-ID: 6kw2m4YoPpqaVHUPGtkrMA_1768930680
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso39878325e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768930680; x=1769535480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+4QxSpkNjF2EkzZAKQPlQPI6YXNQ66sF9tBW1H0t1mA=;
 b=CcvHZxH6pV03cpL2aHN9I2XOI561zUkZ+b07gz9CEbmRbbOwLMphbKGJomVGkrshZk
 ZzoxsTWNXpiEyYFiezCyzagGvNp0zFhfIBStisC1XH7TVauyMn1OkG3AqJ/kOx+MN4To
 sL6hHbb0SxeBJx7wv/9erhMUt6EUl92jaIwi5Xxv47Yw4w0ts/yFG3S1lnXc5vt2+sg8
 3QMLDPeZZlxLUh8xUesk7iq8ojuV5GBMbXQBWznJ8YoX2N2UlUTfgqXKH2jxXXHqe68T
 WWwo7ABu31XMcIzczUd+oQnQpVL6yVo0IWw7PNDs8K3ceSw/VHMmcYuen/BjNgyw2Oe4
 tGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768930680; x=1769535480;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4QxSpkNjF2EkzZAKQPlQPI6YXNQ66sF9tBW1H0t1mA=;
 b=XH8o1Cn2s8tgZuoP4MhOUrTgVLF0zU9urlhkOXq3ZDTY9XCAbsC1MuGsETtGONL/a+
 EjHFUd8uauZF8a6xhA0HjrDWq7UrAI2T43O18s3Ko5HJdRejmGLzfkJNMj5CSUfsIAJZ
 cApKXdW5X4WCs74FBbMFtCHZK+3OQRIMMgiBb81Q63FFuUobKtPQeJyAnHFNjN9IFc5G
 AS5GgNI7jfEos7N0EhuVBUtTlt3AJau9gqxN++ej5clnfMQ27kYCjkUqN9ze3LZSc6Lm
 Z7PWZe1+gbBD3j9IGmC1RsW1NTzyGkoq3HCxXmVONm/10YsLhGT8oEPrpDYpeA/8auqj
 XBig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5SmLrhA1dZ4lwF27GclBiw+uCZO61ZuGkhIvKHs1xrt25q8t2sU2CWXR/QZ5z1VLc669qQIs4bJWc@nongnu.org
X-Gm-Message-State: AOJu0YyS2xXqkCHrqk4Mbhh3UXyo9HWg8aDTzCzjJguT2sOKPv1602FK
 bIsSw8lo1ALpd5a47zrkBWSYtWdglPmWQx/6oDU6Z1VqUkbcW2si7gTAx3p3NkteUkvzg4GSWq3
 qbccF7sxw9g7KlmHqnyG+QgxVzSvU5xQ3TEyWY0ezxmYrisqHRW9fO5sC
X-Gm-Gg: AY/fxX7HWqFDWC79n+fFSxcL+O1o50/uTviK1lQdB06bfsoXw73i9JMNtzA/vlslhJi
 QftOBPt6JloCkF0D3/hW6BYBO2Zk9VsOzzkxlcwbVQOFSrLowaVzAXtABCyjrSSqjmFaereRywB
 NMPAlGgcVLKjsT4Vhlv7V+QE6q0zWhIQv7hr7NNlELAfaQft7tWUNYB+YdZ8zswjWMKwKPb3RHW
 Mh9uOzTsfySJVCVe42fb8V20fl3oJxcxbBQ33ImQWpEBMJURe0Ymq/dhF2MrQlsIgtYmgMpiNbR
 4Fb1K+HC2SP8RC/c9C6Wj3Jl3xPl6qQ2X4fHEI5zNfsC6uM6BKCEWMz63VUmlK0b8C9v14X5Ztv
 k1kcxxKAWrD5qqWf8RERSv42ocJKYx5uO6dORuR8fluucU8CL
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4803e803c1amr41563395e9.36.1768930679839; 
 Tue, 20 Jan 2026 09:37:59 -0800 (PST)
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4803e803c1amr41563045e9.36.1768930679409; 
 Tue, 20 Jan 2026 09:37:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe6e703sm109326375e9.18.2026.01.20.09.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 09:37:58 -0800 (PST)
Message-ID: <77ffcbad-cd45-412e-8d46-dca2c6c6e7f6@redhat.com>
Date: Tue, 20 Jan 2026 18:37:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hw/net/virtio-net: Adapt hash handling to updated
 UAPI
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex@shazbot.org, cohuck@redhat.com,
 mst@redhat.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhenzhong.duan@intel.com,
 vivek.kasireddy@intel.com, kjaju@nvidia.com, Jason Wang <jasowang@redhat.com>
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
 <20260116092950.15796-3-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260116092950.15796-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael, Jason,

I am about to send a PR for this series. Are you OK with this change ?

Thanks,

C.

On 1/16/26 10:29, Shameer Kolothum wrote:
> The virtio_net_hdr_v1_hash layout changed in the Linux UAPI, replacing
> the 32-bit hash_value field with two 16-bit fields, hash_value_lo and
> hash_value_hi.
> 
> Update hash handling to populate the new fields correctly and adjust
> offset and size calculations accordingly.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/net/virtio-net.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 317f1ad23b..512a7c02c9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1879,7 +1879,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
>                                                n->rss_data.runtime_hash_types);
>       if (net_hash_type > NetPktRssIpV6UdpEx) {
>           if (n->rss_data.populate_hash) {
> -            hdr->hash_value = VIRTIO_NET_HASH_REPORT_NONE;
> +            hdr->hash_value_lo = VIRTIO_NET_HASH_REPORT_NONE;
> +            hdr->hash_value_hi = VIRTIO_NET_HASH_REPORT_NONE;
>               hdr->hash_report = 0;
>           }
>           return n->rss_data.redirect ? n->rss_data.default_queue : -1;
> @@ -1888,7 +1889,8 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
>       hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
>   
>       if (n->rss_data.populate_hash) {
> -        hdr->hash_value = hash;
> +        hdr->hash_value_lo = cpu_to_le16(hash & 0xffff);
> +        hdr->hash_value_hi = cpu_to_le16((hash >> 16) & 0xffff);
>           hdr->hash_report = reports[net_hash_type];
>       }
>   
> @@ -1990,10 +1992,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>   
>               receive_header(n, sg, elem->in_num, buf, size);
>               if (n->rss_data.populate_hash) {
> -                offset = offsetof(typeof(extra_hdr), hash_value);
> +                offset = offsetof(typeof(extra_hdr), hash_value_lo);
>                   iov_from_buf(sg, elem->in_num, offset,
>                                (char *)&extra_hdr + offset,
> -                             sizeof(extra_hdr.hash_value) +
> +                             sizeof(extra_hdr.hash_value_lo) +
> +                             sizeof(extra_hdr.hash_value_hi) +
>                                sizeof(extra_hdr.hash_report));
>               }
>               offset = n->host_hdr_len;


