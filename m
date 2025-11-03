Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5889BCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG2xU-0006C7-Mn; Mon, 03 Nov 2025 17:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG2xR-0006BR-ES
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 17:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG2xC-0005Eu-9G
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 17:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762208581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFZ34JahUwWSW7e70+91HrNGA1SzD2iJ9NvUoaNVuTY=;
 b=HAI1jo8hJBN38cX/g6EkGYEORv4DzK4xfbufEyJheFiyLtXn7sZIV4goPWx/s3Gx0grOvr
 Gr7rGRQhus4CnvR8OuMaCcYfBEOvr8ZIbFb7alRtUhfYtqlgvDssFKyAEwJCrmLXela87o
 jD7eLoKC6oLGMox5QHiAHkAmVTE2YxY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-cuHzJZhdNY2FvDAWVjcvJQ-1; Mon, 03 Nov 2025 17:23:00 -0500
X-MC-Unique: cuHzJZhdNY2FvDAWVjcvJQ-1
X-Mimecast-MFC-AGG-ID: cuHzJZhdNY2FvDAWVjcvJQ_1762208579
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429be5aeea2so2020378f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 14:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762208579; x=1762813379; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DFZ34JahUwWSW7e70+91HrNGA1SzD2iJ9NvUoaNVuTY=;
 b=pCOX6/4fuGQAQ0mZRZdVxvqmxFHeUTC6HfsZ7TMYNDUWu4NK9yx6udyrKWxWdwit2l
 HquyKNses47/Xs64U4eM3+PxUSCDubzDI3SambN+pS3ciBury9E9aiIaxR7fsKsYKZv8
 sMfXkTJFiuVp1X0O/t6xdyGrKyRrY5EU5LFZ+ofKl+rFEqaA6hg5+0J8/ntE20ulV3O0
 MXdx1zaQVYxBkiyFc6XDHXKqbAUM58Px2GjoBFLxJyBUtaSEGuF9oBGgaQ+sBARjskNS
 oLYsvjY5AwdJGJf7zpucCirUn+TD4K05oFAOoS1XAVW+Y08VcW2iOrU8tLDdml+C2woO
 TLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208579; x=1762813379;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFZ34JahUwWSW7e70+91HrNGA1SzD2iJ9NvUoaNVuTY=;
 b=P1b9N44OCN0tv9bFGq1m0zOYPiZIZBCedyPo4y4uFvDrReOq1Sc+k6yyQe0eKD1l8g
 GvT1WlSnRU3udG2cqYoBM3bGv7orulM5CslHx4wgnIkDmO4YU7/1YOVKUewpGSIxbDRR
 mY+0sRcST9jT/kMp30Zv1pt67eaPz5nnQ0afR2iF0dOqlytnT9tCEtdRht/8a44Qutxa
 bOELKRpyjEJxjDyEtEAiWDbFHytZSvKwVdZK8m9jAYEllq/6XDHSSoDb0FIZYG/eNCSW
 3L4f+G8QeCVuRq7PmIPy3PCNndDjdVUbuRf4e3NkilBfRoGKJzYf2wCw26OVnc4fUs0l
 qs0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCWY8P20krZVaFNwxvQH6S8uduz4D6Nnm9gHD1hq7oxHgQcYfz53B6zrk3EO14JJ6fKafNJ+ESrI8G@nongnu.org
X-Gm-Message-State: AOJu0Yy2M9tgRHSAzeTGjHGukQZeTiL/oMs9wS2WU3rN+iI8dkwvazum
 bH8uiuHm/ofZef81BhxHnkLtC3oEde2G3A/pTRvwLt08kgLtJb6ZmZNArFxH3mqj+AsdHS8FKbo
 EWXmHVCVk5zzic+bNdDIX3WR1nU8Tx49D/18A/IwJQKSIagkO2ujl+Crc
X-Gm-Gg: ASbGncvQHJWqvOS9CGbiAS9pkRy6lnp6gxjJoyfDTwBl/OTCqdAg1zR6Y3e8sFVycpY
 eZt8Oyo3aX2s2vt/mvN3X1TO5UTVHWx/R6CiGE7UMW3JjMJ8at0EBck9hqsC7MKmcSUPpsRehBH
 bVd7+bIdKv0seGF2vTxIyFsY+RtuG1Btf9F8Be4PlSkexhQDhYa1CRZkCyz+EZ7KX0SJTcGvKgF
 OUKADvfWUgspfyx79VDDien7cViAIiiLZ26N2dQtAKMSmwu97hWWfBCKT02t25WZsaiz2TgYdHm
 CbZ+nZ9agaZvwzluFHTnDHLgkK1VcfKSIMcUYXaiUakZnkfJASwuNpf27XMPKoo=
X-Received: by 2002:a05:6000:24c3:b0:429:c7b5:ed9f with SMTP id
 ffacd0b85a97d-429c7b5edf1mr7650219f8f.63.1762208579178; 
 Mon, 03 Nov 2025 14:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZbtA8iU4MSW3iWd5/yD03wgmkuKe+i0ax4OImH9FQR5ck1Ma5Tnb7wBnmsESUPn2aafS+yg==
X-Received: by 2002:a05:6000:24c3:b0:429:c7b5:ed9f with SMTP id
 ffacd0b85a97d-429c7b5edf1mr7650204f8f.63.1762208578658; 
 Mon, 03 Nov 2025 14:22:58 -0800 (PST)
Received: from redhat.com ([31.187.78.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc193e27sm1104866f8f.18.2025.11.03.14.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:22:58 -0800 (PST)
Date: Mon, 3 Nov 2025 17:22:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v3 21/23] vhost-user: make trace events more readable
Message-ID: <20251103172122-mutt-send-email-mst@kernel.org>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-22-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015145808.1112843-22-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 05:58:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  hw/virtio/trace-events |  4 +-
>  hw/virtio/vhost-user.c | 94 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 94 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 658cc365e7..aa1ffa5e94 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -25,8 +25,8 @@ vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_siz
>  vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
>  vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
>  vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
> -vhost_user_read(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
> -vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
> +vhost_user_read(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
> +vhost_user_write(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
>  vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
>  
>  # vhost-vdpa.c
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 23e7c12b16..e45b74eddd 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -119,6 +119,94 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
>  
> +static const char *vhost_req_name(VhostUserRequest req)
> +{
> +    switch (req) {
> +    case VHOST_USER_NONE:
> +        return "NONE";
> +    case VHOST_USER_GET_FEATURES:
> +        return "GET_FEATURES";
> +    case VHOST_USER_SET_FEATURES:
> +        return "SET_FEATURES";
> +    case VHOST_USER_SET_OWNER:
> +        return "SET_OWNER";
> +    case VHOST_USER_RESET_OWNER:
> +        return "RESET_OWNER";
> +    case VHOST_USER_SET_MEM_TABLE:
> +        return "SET_MEM_TABLE";
> +    case VHOST_USER_SET_LOG_BASE:
> +        return "SET_LOG_BASE";
> +    case VHOST_USER_SET_LOG_FD:
> +        return "SET_LOG_FD";
> +    case VHOST_USER_SET_VRING_NUM:
> +        return "SET_VRING_NUM";
> +    case VHOST_USER_SET_VRING_ADDR:
> +        return "SET_VRING_ADDR";
> +    case VHOST_USER_SET_VRING_BASE:
> +        return "SET_VRING_BASE";
> +    case VHOST_USER_GET_VRING_BASE:
> +        return "GET_VRING_BASE";
> +    case VHOST_USER_SET_VRING_KICK:
> +        return "SET_VRING_KICK";
> +    case VHOST_USER_SET_VRING_CALL:
> +        return "SET_VRING_CALL";
> +    case VHOST_USER_SET_VRING_ERR:
> +        return "SET_VRING_ERR";
> +    case VHOST_USER_GET_PROTOCOL_FEATURES:
> +        return "GET_PROTOCOL_FEATURES";
> +    case VHOST_USER_SET_PROTOCOL_FEATURES:
> +        return "SET_PROTOCOL_FEATURES";
> +    case VHOST_USER_GET_QUEUE_NUM:
> +        return "GET_QUEUE_NUM";
> +    case VHOST_USER_SET_VRING_ENABLE:
> +        return "SET_VRING_ENABLE";
> +    case VHOST_USER_SEND_RARP:
> +        return "SEND_RARP";
> +    case VHOST_USER_NET_SET_MTU:
> +        return "NET_SET_MTU";
> +    case VHOST_USER_SET_BACKEND_REQ_FD:
> +        return "SET_BACKEND_REQ_FD";
> +    case VHOST_USER_IOTLB_MSG:
> +        return "IOTLB_MSG";
> +    case VHOST_USER_SET_VRING_ENDIAN:
> +        return "SET_VRING_ENDIAN";
> +    case VHOST_USER_GET_CONFIG:
> +        return "GET_CONFIG";
> +    case VHOST_USER_SET_CONFIG:
> +        return "SET_CONFIG";
> +    case VHOST_USER_CREATE_CRYPTO_SESSION:
> +        return "CREATE_CRYPTO_SESSION";
> +    case VHOST_USER_CLOSE_CRYPTO_SESSION:
> +        return "CLOSE_CRYPTO_SESSION";
> +    case VHOST_USER_POSTCOPY_ADVISE:
> +        return "POSTCOPY_ADVISE";
> +    case VHOST_USER_POSTCOPY_LISTEN:
> +        return "POSTCOPY_LISTEN";
> +    case VHOST_USER_POSTCOPY_END:
> +        return "POSTCOPY_END";
> +    case VHOST_USER_GET_INFLIGHT_FD:
> +        return "GET_INFLIGHT_FD";
> +    case VHOST_USER_SET_INFLIGHT_FD:
> +        return "SET_INFLIGHT_FD";
> +    case VHOST_USER_GPU_SET_SOCKET:
> +        return "GPU_SET_SOCKET";
> +    case VHOST_USER_RESET_DEVICE:
> +        return "RESET_DEVICE";
> +    case VHOST_USER_GET_MAX_MEM_SLOTS:
> +        return "GET_MAX_MEM_SLOTS";
> +    case VHOST_USER_ADD_MEM_REG:
> +        return "ADD_MEM_REG";
> +    case VHOST_USER_REM_MEM_REG:
> +        return "REM_MEM_REG";
> +    case VHOST_USER_SET_STATUS:
> +        return "SET_STATUS";
> +    case VHOST_USER_GET_STATUS:
> +        return "GET_STATUS";
> +    default:
> +        return "<unknown>";
> +    }
> +}
> +

Please use a macro so we don't have this duplication.


E.g.

  #define VHOST_USER_CASE(name) \
      case VHOST_USER_##name: \
          return #name;



>  typedef struct VhostUserMemoryRegion {
>      uint64_t guest_phys_addr;
>      uint64_t memory_size;
> @@ -311,7 +399,8 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
>          return -EPROTO;
>      }
>  
> -    trace_vhost_user_read(msg->hdr.request, msg->hdr.flags);
> +    trace_vhost_user_read(msg->hdr.request,
> +                          vhost_req_name(msg->hdr.request), msg->hdr.flags);
>  
>      return 0;
>  }
> @@ -431,7 +520,8 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>          return ret < 0 ? -saved_errno : -EIO;
>      }
>  
> -    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
> +    trace_vhost_user_write(msg->hdr.request, vhost_req_name(msg->hdr.request),
> +                           msg->hdr.flags);
>  
>      return 0;
>  }
> -- 
> 2.48.1


