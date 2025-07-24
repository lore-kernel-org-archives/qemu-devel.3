Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A615C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevlG-00022d-2V; Thu, 24 Jul 2025 09:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevlC-00020v-5u
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:13:22 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevlA-00040h-2m
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:13:21 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6077dea37easo1845580a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753362797; x=1753967597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIhXE+3LskBlDP9Giy4jHTvR9om9iXJsO+fQ/F6U8zE=;
 b=Df5fLBUQuxdbGX6rJhcxFSpmF5Fgnl5Fpj21ix5bAiFnMkRX5XUcUjCTOAfldkbYKv
 XK47HwQkQqczdtShmL2JmY0/EYH7913s8iiIsnQnmdn1rWNXi40TuRKoUEy0jgTNpJ+X
 WmsEFQW/j+N082MuCJiCvB5Z/3ngeB/XB7vommjwv7lj4njNAzu/xjq8INbkMrgBgT6I
 ZnFjxPuM0P9QjlQVLrBcK4j9RrF+x31HjBTPgXssKmbS7DXVlcMqV2M3zbN/fNYsBiPT
 1mQVBETXn1JUcHY0J7ZAD68elOLawwehTElPdPBGvbStp3rCA2JTxwGQIYd5E0gBWxhJ
 a9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753362797; x=1753967597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIhXE+3LskBlDP9Giy4jHTvR9om9iXJsO+fQ/F6U8zE=;
 b=lC4hkIn1vsZZl6rs6thykEpeVx2wdZCR/9tPT7WXNFQo++Lc9JO89NwjKnoFvOxdpQ
 YzNd6fkTw9/8q9RKe9FG1lbz/GEGPYb6DEaHMG/Tt3OIR4v2G8b0y1t8niTu8tKrEA2s
 HZpsoYUm0S4Z6e0xkIRMrPiJfBlDhTylS2wSC/Qp//IpaRGwfE4aXYyKGohaY4TjsMjK
 2jnsFpkPzlb3HhetRH7zcEheLyuqam8rZPQ20MXYBRE2PdRtG7PPti6pbENCNX1HeqFv
 escGHy3tUL0wTyaBLN1rMyCJXfowCJ+jJ3iPnI53IRGJlAmdJAqlByoon9Kz16vvuFhK
 AzWg==
X-Gm-Message-State: AOJu0YzdCTPzF6liR/Rf5DFi0nTSAGTdswbgRfByU4r+AxBOCsS0TaJh
 OvTJjT1ThsbMhL6KJ9FEorrl4JSU5bI+REjllvKfBo48iPYY+ebbRZyJxg9ecE89Vy7iSABmN+2
 Ry30M6tvdPO89cb1D4jJwIY0+yC38OefWzCZi8gkuQA==
X-Gm-Gg: ASbGncuQSvq9qRRfF63mDS9B2tROaInDiGtT48Zx7uyTIXnwaSBt2qK4NUJJ92T57sx
 votZUfegRgGlQ35SvwKFIKaRZqvUEuMwxnaKFkQ6sF9D3G97lJUOu+hYfQ7s0PlKo9n6Kxy4vMy
 Egvd494GE3YRDAptEzxaAJ0ziAfKjPyBIs8y/KLp7Tk7BEI5W5r6RVa+XbEahzm/ByzFnS2GTyQ
 +ZDtg==
X-Google-Smtp-Source: AGHT+IGLlU+shQNwIbIGbcrAq9IE3B4zWJCLbnQBa2GjM52Azc2qFHwHM0FTkPRn1Jsfwj/bC6AOrKEoQPyHhSXaalM=
X-Received: by 2002:a05:6402:3591:b0:607:e3ec:f8ea with SMTP id
 4fb4d7f45d1cf-6149b45d5e9mr5561450a12.6.1753362796884; Thu, 24 Jul 2025
 06:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250724125928.61045-1-hreitz@redhat.com>
 <20250724125928.61045-2-hreitz@redhat.com>
In-Reply-To: <20250724125928.61045-2-hreitz@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 16:12:50 +0300
X-Gm-Features: Ac12FXy2upb67-rzohndXkHzOvNU_EDJQfq5vAa6EzjFhAVe3cOvlhhyZl19REk
Message-ID: <CAAjaMXbBFE5zhwf+JLUG2TZ3GZ2v79rvUoD5KUw9hSrZfHkkfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost: Do not abort on log-start error
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> Commit 3688fec8923 ("memory: Add Error** argument to .log_global_start()
> handler") enabled vhost_log_global_start() to return a proper error, but
> did not change it to do so; instead, it still aborts the whole process
> on error.
>
> This crash can be reproduced by e.g. killing a virtiofsd daemon before
> initiating migration.  In such a case, qemu should not crash, but just
> make the attempted migration fail.
>
> Buglink: https://issues.redhat.com/browse/RHEL-94534
> Reported-by: Tingting Mao <timao@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index c30ea1156e..05ad5de629 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1110,7 +1110,8 @@ static bool vhost_log_global_start(MemoryListener *=
listener, Error **errp)
>
>      r =3D vhost_migration_log(listener, true);
>      if (r < 0) {
> -        abort();
> +        error_setg_errno(errp, -r, "vhost: Failed to start logging");
> +        return false;
>      }
>      return true;
>  }
> --
> 2.50.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

