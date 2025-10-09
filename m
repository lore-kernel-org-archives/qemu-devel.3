Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F4BCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vzi-0000gx-Dp; Thu, 09 Oct 2025 15:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vzX-0000X9-Ap
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:07:58 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vzV-0007Gl-14
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:07:55 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-9032edd72c1so147535739f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036870; x=1760641670; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoqXzwBxGf9QQWk3WWhuB8rewsTlsm/0PyoJupoB3GA=;
 b=OD0BW2ssb0HEtuZweFThUqSV9hMspkwZAy+BYKSK7HLmPhgRXBn9Sk+X8/q4jQhqCa
 IQQf+QY4RJu7wnCUyi8lIJy/dIa4jyAtxOjoFFaPNl9Kjmlvp2ALm+Oo7Aouz7z1r34x
 Rlck5I//IY/hgN1RT55HybzLnuZvkyxGH0wLhJvsFP+ie7Lmw9HR13kcRVeYAX9xO2w4
 s8jRrAUcXuAG7MNq4fcOeiI0TpzM42NgXiJVoPxyPofDKbod2Zk9Kt/cbDSKJDYSrWI3
 hjrfXNoY+IVmQb+IRVi3kI35aMkz7/zRtNRplAs6/l8+nEmT6pfJk5nTP97UxtD5xtrQ
 ukNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036870; x=1760641670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoqXzwBxGf9QQWk3WWhuB8rewsTlsm/0PyoJupoB3GA=;
 b=JaQCzDd0I5nuM6IlrPGcBqfClNlIKFyPfZbUu8u5TBdG2Am/ZJkWzKxFsEaQIE22MP
 62x7Lvw11NYlsY3loEJLSlGEED6TIJDFISOOZSvf9rQlo606y3ihGSzABSW0OFmmqzbR
 V474D5ZbUyF4UBUkWTE6W/77gL4Y5/2sCR822k469f/h3qxKUsFaBnrEpZdoQXUyU+y0
 /mTIMfFTEov4KkPFDNwdCL0dQiQXTA1c1W+fh+DEza3PjwE4WZFGytszJuIZ4Qrge0mV
 BGhP1BfirEnmglYBBqOmjiZv2sZ7Fy+EoW67JWQfLOA5XsgUAXaYA/Hb8+dwtYWDtIGH
 0Riw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoNAI1WNuILgeXMDMsGdzh17QyqogVKBOlKcFYjovKAv9x2ZTzEP9nJ+WbulYTA40eZkwDZhjx9kRk@nongnu.org
X-Gm-Message-State: AOJu0YzuoakcvNiGPqZPs2Yg+lLQiWQBHQUqnZd3XWRQvze0wZyMt3C/
 roTpw6UqJFvsOR2HDAIy02ZxwHNHXueesT6OKGlw48ryLb67XxR++AX8gQ7QuWfnIMwQJ/I4sZX
 qiiitt0+l2NcnIjynstBRFv22/ensRXk=
X-Gm-Gg: ASbGncvP5/K4fc4fVQKUMVXcxrU5BOIiPVUma+hCNTNt4nysarGDuoqUdotwvJBH2aV
 c/dOLTNZnfC0MzDM/GFZPxq5UYgCagGBdfm5hbWHQ3qoOCtneF20JpEYiAcqtjUPIst/gscc6qg
 mOzD/jr1x9OxqyYd6HbtznCyuthMOGUeb5rdkeuMVCghjI4H4VOSwzL+2Vk/lEb36rdeTWrp30a
 6CRjt6L3objhmd0des5w28vCnbedC0T8NtlQuxHX+KCTDnkLrse
X-Google-Smtp-Source: AGHT+IES1j7ozbgcTz9TD9ZLUJb968efEzWnLMtCGKKiOqyVzUuuig7ZFHEClJDu09qcx0HZwSX8lT3KQ/vwtuDwtkw=
X-Received: by 2002:a05:6e02:2206:b0:42f:8ae9:27f1 with SMTP id
 e9e14a558f8ab-42f8ae92abdmr74849155ab.28.1760036870193; Thu, 09 Oct 2025
 12:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-22-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-22-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:07:38 -0400
X-Gm-Features: AS18NWCGxNXsxrninkjHNZdve0J9UJSheuyBdoxrGvvkNusJfypKfG4iRClu6eY
Message-ID: <CAFubqFsVsPnKvm8VR==zUmn1j6cq4TnKHaVKWpiG6pr6gbGW4A@mail.gmail.com>
Subject: Re: [PATCH 21/33] vhost-user: make trace events more readable
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 12:57=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/trace-events |  4 +-
>  hw/virtio/vhost-user.c | 94 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 94 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 76f0d458b2..e5142c27f9 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -25,8 +25,8 @@ vhost_user_set_mem_table_withfd(int index, const char *=
name, uint64_t memory_siz
>  vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"=
PRIx64
>  vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
>  vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%=
s + 0x%"PRIx64
> -vhost_user_read(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
> -vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32"=
"
> +vhost_user_read(uint32_t req, const char *req_name, uint32_t flags) "req=
:%d (%s) flags:0x%"PRIx32""
> +vhost_user_write(uint32_t req, const char *req_name, uint32_t flags) "re=
q:%d (%s) flags:0x%"PRIx32""
>  vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
>
>  # vhost-vdpa.c
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index fe9d91348d..3979582975 100644
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
>  typedef struct VhostUserMemoryRegion {
>      uint64_t guest_phys_addr;
>      uint64_t memory_size;
> @@ -310,7 +398,8 @@ static int vhost_user_read_header(struct vhost_dev *d=
ev, VhostUserMsg *msg)
>          return -EPROTO;
>      }
>
> -    trace_vhost_user_read(msg->hdr.request, msg->hdr.flags);
> +    trace_vhost_user_read(msg->hdr.request,
> +                          vhost_req_name(msg->hdr.request), msg->hdr.fla=
gs);
>
>      return 0;
>  }
> @@ -430,7 +519,8 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
>          return ret < 0 ? -saved_errno : -EIO;
>      }
>
> -    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
> +    trace_vhost_user_write(msg->hdr.request,
> +                          vhost_req_name(msg->hdr.request), msg->hdr.fla=
gs);
>
>      return 0;
>  }
> --
> 2.48.1
>
>

