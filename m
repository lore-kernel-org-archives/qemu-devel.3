Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3138D2ECF5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 23:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhz1A-0007QP-EH; Mon, 19 Jan 2026 18:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz10-0007KY-S6
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:50:35 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz0z-0005Zg-6i
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:50:34 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40439fb8584so2954423fac.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 15:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768866630; cv=none;
 d=google.com; s=arc-20240605;
 b=Cqe96gJjzGCwghJ/A2h6cu4BVOFeG/iGzPMyPCx0yQGsgx/XHN1NWf0hKKTsAr/b6e
 tHzUV+EkSUB3p+6mos/lhGyEx1jGvpJbYJlFb6gOcf+dvRNY88wbv9+h+Y6gJwqKbxRi
 02W+NvDkBCcKfWBjRO9qMFu/T3Fo+OoVHtvVA17qtYHC2bG+XUjtjKIHvjYIlCca57v6
 dKLVz9/ZePK7WS021SWxTouPRjKs8R5i9Mu3Dzkex+wEQYnU5uVOAOqKLoY2aJW7+W6B
 luXUbQLs3XgVofRluARBRCoifjawMCld6syVEYAQhhD+zpBibsMcPJI0/bu71X+roMZA
 R0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LWrqtsiUmtsxZyPsWxKTewnXiLEB2PsRUenvhwPCiXQ=;
 fh=QhL3pPqZ5XZnOelPBCjRMs6DE5g4vHRvGOhNtz80nsM=;
 b=PPQPYurICwODrVTxwaZuvG7EaLgD+RhHXMgarX6XUszmp4bCzHReVUVRC5ql1jqukc
 +kbN08ycjNWt8ueZr2U9gYlOrUfYYadhOwc7ekfZjgnXLOHRIslaVKH2KQVzkxGZfWK2
 3iKW2LnE0KcDb8369WZJxKgq0iepRPAPPoI1K5AXLu7dQOVYqibvygiLcr4QkTsv9muZ
 qw/mRiNCw0kEp7vIo/5TnQx0BwWvAHVxmyefNybiJiLsJNS+3so4pmnhwYSmOH2k9Gdn
 l2NaJt6Pymx/ZEK9nP0qTGEqxADnwymOeHdZPXJcIDGRvq8mSwC0pEGeZd2Oiy+mAcLY
 T8rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768866630; x=1769471430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWrqtsiUmtsxZyPsWxKTewnXiLEB2PsRUenvhwPCiXQ=;
 b=GYQUEJb0sdzllkrd1VB0KVuYdy7tuNArhsioL4dhM42/N/G6nGEYTnJvJPMUOMRJv/
 2XU+/Xw7a55cSHbaLcpV9bSHtRA6Q2c3BZQr+FK/ub+YjGdxQt6K9ThxqIpiNrgyzVEW
 B77ip05kVvojG7F+diJ29ThtRfPgWOkzasnZPlKgfDM2239SMLIls0f9o1DKQia0dZ4v
 WSExegSEo8s39A6hafnle0ixyz1Fl4P4viWC6JqsducfUZBTKLdBAEOJgHnErF2p6OzG
 ADZlh4AodyCN4B9Am7qpkLZ4l2yGRIzTbkosCHp2beS77A/1CMPWWe8/NOpvyoRTL/e3
 SBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768866630; x=1769471430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWrqtsiUmtsxZyPsWxKTewnXiLEB2PsRUenvhwPCiXQ=;
 b=K05GpprUxdOvVyqQl0GlgeGc1sPMiCkSfyup/GMh+T6weD1R2FG35fiZdlh8g/U0X6
 adN6r26cQ91j75eUw1KjGvhxD+QnG2Ql+ki/yVKRiONvhHfF2eEIXdR4NECByhxYtFt1
 I8H5qeEVl7jhUg3G4cg+lMDC0YRQReaaffzOPA/DlKH93IFMcFK+4ifiFf/I5KQC+avn
 KYoDIQyUno8iH0lK9ED2V65HN9Kbq9t0qCJg4B+rgMnshQuext6+btz0KQuF33HGT/hX
 CdPspW4Wfbysy0biIBeNdsW5z4Ue3ovr2OzQh19VujSCvVaXY1LYxtv98fxjAyWfOJ3t
 5RKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM+ldV5EWQ67dQFWQlHJIKY48zH5KcW/MzgHh8OdkwUIzOzYhIGnyFEwEmCywLcTYzy6NPRZXdJR7Y@nongnu.org
X-Gm-Message-State: AOJu0YykBC+gfR5qfTFdL8C1jLoPlYL3Ndef5BowkrYn/eWBeame5vWk
 7u6s9zDV0YFqHW8/gU+S3bkrVptMMhf8VjXFNQXF62hyNdyvZqKwJYowrfLJuZModDmE0Rve3JW
 z16NI+BrwF0y5bMq+hAh9vPw+5+UMDf8=
X-Gm-Gg: AY/fxX5QGlcwcRY8IMOK4rGzg9AsiOk5jXvZlbx/NfAoCLn9Ed7CvCs5ibYpSLDYqg9
 1OexgDRYLYRqBq7yUd+6A2Rg5LkxuhlMrdv4zvzit9IoTJk9gEy8LTbBWBz2pjVQ/bdhrc2D7ET
 1VbIZ54GorXZf2gMyS98OaIHXyvZ/XeY/O3YwX8rY09bRA8e1++PTqEhOdx+7c8pFmOi5INHJgf
 y07cTXwqwMsLKz6ilvAWKlFOVfNQtmPIDAStyKsg5XB30+bSvxxRhqsaeeFAQEKHYpIJfafkYOx
 Di0UL4sO3Eucz8rDUJcE8WknBSE=
X-Received: by 2002:a05:6820:1f8e:b0:661:8bd:6aa1 with SMTP id
 006d021491bc7-6610e65396fmr5140311eaf.35.1768866630230; Mon, 19 Jan 2026
 15:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-22-vsementsov@yandex-team.ru>
In-Reply-To: <20260119185228.203296-22-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 19 Jan 2026 18:50:19 -0500
X-Gm-Features: AZwV_QiExtgDTNVUY9peL5_I3DF_swhhZFdgpWaAfUGVvgvwdbZ4EOmP9AOJ89o
Message-ID: <CAFubqFtyzU3j9oAg98=4Mfp9VHa--okbatob9vRZ_YfB+VnMqQ@mail.gmail.com>
Subject: Re: [PATCH v4 21/23] vhost-user: make trace events more readable
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Mon, Jan 19, 2026 at 1:55=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/trace-events |  4 +--
>  hw/virtio/vhost-user.c | 63 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 658cc365e7..aa1ffa5e94 100644
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
> index aedd5a80ff..824943f1eb 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -119,6 +119,63 @@ typedef enum VhostUserBackendRequest {
>      VHOST_USER_BACKEND_MAX
>  }  VhostUserBackendRequest;
>
> +#define VHOST_USER_CASE(name) \
> +    case VHOST_USER_##name: \
> +        return #name;
> +
> +static const char *vhost_req_name(VhostUserRequest req)
> +{
> +    switch (req) {
> +    VHOST_USER_CASE(NONE)
> +    VHOST_USER_CASE(GET_FEATURES)
> +    VHOST_USER_CASE(SET_FEATURES)
> +    VHOST_USER_CASE(SET_OWNER)
> +    VHOST_USER_CASE(RESET_OWNER)
> +    VHOST_USER_CASE(SET_MEM_TABLE)
> +    VHOST_USER_CASE(SET_LOG_BASE)
> +    VHOST_USER_CASE(SET_LOG_FD)
> +    VHOST_USER_CASE(SET_VRING_NUM)
> +    VHOST_USER_CASE(SET_VRING_ADDR)
> +    VHOST_USER_CASE(SET_VRING_BASE)
> +    VHOST_USER_CASE(GET_VRING_BASE)
> +    VHOST_USER_CASE(SET_VRING_KICK)
> +    VHOST_USER_CASE(SET_VRING_CALL)
> +    VHOST_USER_CASE(SET_VRING_ERR)
> +    VHOST_USER_CASE(GET_PROTOCOL_FEATURES)
> +    VHOST_USER_CASE(SET_PROTOCOL_FEATURES)
> +    VHOST_USER_CASE(GET_QUEUE_NUM)
> +    VHOST_USER_CASE(SET_VRING_ENABLE)
> +    VHOST_USER_CASE(SEND_RARP)
> +    VHOST_USER_CASE(NET_SET_MTU)
> +    VHOST_USER_CASE(SET_BACKEND_REQ_FD)
> +    VHOST_USER_CASE(IOTLB_MSG)
> +    VHOST_USER_CASE(SET_VRING_ENDIAN)
> +    VHOST_USER_CASE(GET_CONFIG)
> +    VHOST_USER_CASE(SET_CONFIG)
> +    VHOST_USER_CASE(CREATE_CRYPTO_SESSION)
> +    VHOST_USER_CASE(CLOSE_CRYPTO_SESSION)
> +    VHOST_USER_CASE(POSTCOPY_ADVISE)
> +    VHOST_USER_CASE(POSTCOPY_LISTEN)
> +    VHOST_USER_CASE(POSTCOPY_END)
> +    VHOST_USER_CASE(GET_INFLIGHT_FD)
> +    VHOST_USER_CASE(SET_INFLIGHT_FD)
> +    VHOST_USER_CASE(GPU_SET_SOCKET)
> +    VHOST_USER_CASE(RESET_DEVICE)
> +    VHOST_USER_CASE(GET_MAX_MEM_SLOTS)
> +    VHOST_USER_CASE(ADD_MEM_REG)
> +    VHOST_USER_CASE(REM_MEM_REG)
> +    VHOST_USER_CASE(SET_STATUS)
> +    VHOST_USER_CASE(GET_STATUS)
> +    VHOST_USER_CASE(GET_SHARED_OBJECT)
> +    VHOST_USER_CASE(SET_DEVICE_STATE_FD)
> +    VHOST_USER_CASE(CHECK_DEVICE_STATE)
> +    default:
> +        return "<unknown>";
> +    }
> +}
> +
> +#undef VHOST_USER_CASE
> +
>  typedef struct VhostUserMemoryRegion {
>      uint64_t guest_phys_addr;
>      uint64_t memory_size;
> @@ -311,7 +368,8 @@ static int vhost_user_read_header(struct vhost_dev *d=
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
> @@ -431,7 +489,8 @@ static int vhost_user_write(struct vhost_dev *dev, Vh=
ostUserMsg *msg,
>          return ret < 0 ? -saved_errno : -EIO;
>      }
>
> -    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
> +    trace_vhost_user_write(msg->hdr.request, vhost_req_name(msg->hdr.req=
uest),
> +                           msg->hdr.flags);
>
>      return 0;
>  }
> --
> 2.52.0
>
>

