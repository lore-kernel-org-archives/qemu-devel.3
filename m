Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D0C4828D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 01:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRQf-0001wE-07; Sat, 03 Feb 2024 20:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRQd-0001vF-CW
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:36:15 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRQb-0005x6-QA
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 20:36:15 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7c2ca431146so33158539f.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 17:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707010572; x=1707615372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiXzMRwDEX8pUcRwUs91ZJ52FULClsguhpNQ9UK7Kao=;
 b=VMk6xNv0OeeBlbypJf43uEIqb6+26RfgIsW2Q+1iiI7MYRDEbpYtmuZ7NTAvEAGtAV
 w7o8/pwhhIKOOn3xOfunW886Evq7dDQC+ofpkkM64i/3W+u/nPQaVuiQyvXYmk9qMF9i
 +EnJQsq0IPxJG49lp7j4j7nPkmSmBdt1ZblUXux7PqLD5tY/j7r4rBE0nVDL7FYBSIsV
 t9qeswN6EfE3C0Kh9sdHG86VkWG2mGfk+p+hbL8vb3Lm3uJDL6X/kMOlX1Plmjel/7mS
 uYWCYiEXzmTsQFzeE0SDd8MCiiH+xjHIeAHEgWQAIeZhbwRN5RMaCN8T0/y3Td8kqXGH
 UWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707010572; x=1707615372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiXzMRwDEX8pUcRwUs91ZJ52FULClsguhpNQ9UK7Kao=;
 b=LnIMtbLEUnpwLi7OK9FN7d4jBOS9xrAWiYlOd8Abz33T3dFXb1/KMs/lD+8RdQMT9K
 dXt+EP3IBUXUyPPQadg2o2sq5DRC999XBlIgsH7gmSS7kA0K4R8+p1OWBk0w5As2AiYq
 ENq3TxDJC4HXy702JuoaPcsCNXPuBzgkcc2KlGdfFBJJI6lMlwcB1wX2hu3NIrKTPfQg
 SzExI8d9Ak3+holyRR5m5050YkixqUrF7Xd746oNbGeWnKJ+hx9WXThKdmnandU5VaiJ
 9NBZBxpDAQ1t27xoJm0VK2iM57OzPNWwQCs7SJAlYoTSaHLRxNlpD4ikv0vy5tvHfMvY
 WDvw==
X-Gm-Message-State: AOJu0Yz+g6hXKjKlzN86OSm3Veb7YmzJfU6iHkrc77Y+MX+c8LEG2WHZ
 9u1k9yFxhyye6QR3eU6QflVb+JP762j6S5ZuAe5iHuq3M9QCuUtZR+PLlCP0xAcmtiJyPSnDxP/
 Cab8V54Piamjkx+KXrk09Rrpwt9E=
X-Google-Smtp-Source: AGHT+IFtZY0CK72n32sOLv3bDifJdXCe0dGFqIjC12EZ1OwYMEeEEerLP+XNGFY2q7G/DkMGPrlM0e7mpSw2k+CYA9o=
X-Received: by 2002:a5e:8343:0:b0:7bf:d9a4:6d0d with SMTP id
 y3-20020a5e8343000000b007bfd9a46d0dmr13797070iom.10.1707010572491; Sat, 03
 Feb 2024 17:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-3-david@redhat.com>
In-Reply-To: <20240202215332.118728-3-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 20:36:01 -0500
Message-ID: <CAFubqFtKZ-rm79Gp9UXfA9yXALk4047iYDsyz8iR=xgC9zkXUw@mail.gmail.com>
Subject: Re: [PATCH v1 02/15] libvhost-user: Dynamically allocate memory for
 memory slots
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 2, 2024 at 4:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's prepare for increasing VHOST_USER_MAX_RAM_SLOTS by dynamically
> allocating dev->regions. We don't have any ABI guarantees (not
> dynamically linked), so we can simply change the layout of VuDev.
>
> Let's zero out the memory, just as we used to do.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 7e515ed15d..8a5a7a2295 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -2171,6 +2171,8 @@ vu_deinit(VuDev *dev)
>
>      free(dev->vq);
>      dev->vq =3D NULL;
> +    free(dev->regions);
> +    dev->regions =3D NULL;
>  }
>
>  bool
> @@ -2205,9 +2207,18 @@ vu_init(VuDev *dev,
>      dev->backend_fd =3D -1;
>      dev->max_queues =3D max_queues;
>
> +    dev->regions =3D malloc(VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regio=
ns[0]));
> +    if (!dev->regions) {
> +        DPRINT("%s: failed to malloc mem regions\n", __func__);
> +        return false;
> +    }
> +    memset(dev->regions, 0, VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regio=
ns[0]));
> +
>      dev->vq =3D malloc(max_queues * sizeof(dev->vq[0]));
>      if (!dev->vq) {
>          DPRINT("%s: failed to malloc virtqueues\n", __func__);
> +        free(dev->regions);
> +        dev->regions =3D NULL;
>          return false;
>      }
>
> diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libv=
host-user/libvhost-user.h
> index c2352904f0..c882b4e3a2 100644
> --- a/subprojects/libvhost-user/libvhost-user.h
> +++ b/subprojects/libvhost-user/libvhost-user.h
> @@ -398,7 +398,7 @@ typedef struct VuDevInflightInfo {
>  struct VuDev {
>      int sock;
>      uint32_t nregions;
> -    VuDevRegion regions[VHOST_USER_MAX_RAM_SLOTS];
> +    VuDevRegion *regions;
>      VuVirtq *vq;
>      VuDevInflightInfo inflight_info;
>      int log_call_fd;
> --
> 2.43.0
>
>

