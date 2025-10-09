Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E4ACCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vzH-0008PJ-ES; Thu, 09 Oct 2025 15:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vzG-0008NT-Jx
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:07:38 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vzB-0007FJ-4o
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:07:38 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-42d7ef9a402so9098735ab.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036851; x=1760641651; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKcEEHwFi9HmNoUBFRpCl1XRH/t4LsuWaRSjMtReov8=;
 b=BbE0FGLCtvt/X3yKqNQwz4/5KMfIRIr2JnhNe7RTbRAsMt4JQrLxDkegzCM3p4ABYJ
 liGj8hoBC1NlTso3LCyJk3zU4OO8xNlIuUYkY1ClRvlLWPUnJ/UyhqYADi1TttB4DrLh
 IXFc2p+bgUhN9xi+Hp7Khqk7NdOhJWEnxJ0nu/RbuEgwkVbdWKMmm040276Ck1qZSrg+
 WY3XUU00vyKW9XFl9IPRuQxr+AIhbmtm6NqnoQTFg6YXoUw90gnpyeW127GKsGNu5SbH
 AVnVCbRiBV8C4kmxFGLpg1uM9zuaoVgMaOCbDR+vQeVzPox0msNCnYdbMRQMVvF5IYar
 pyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036851; x=1760641651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKcEEHwFi9HmNoUBFRpCl1XRH/t4LsuWaRSjMtReov8=;
 b=Oqle/mpnyQZAsqN6qVvpjchPZoXE+5JFPOTn4MejkgqQJyp/fetHnlIhammKTuqPWw
 +++Zx2GekSouwSQCzaQNwqUm+hFNdLzVpSAigoYwM1se49JrTbKPm/01whumjgLLwncH
 KMQtZlJceryKHuMD2DCNf2KqMaKvaA9YYjaq3sk39Q0MU0ehtyR78VF3FjiBiYaH+RoF
 OCri71Avo4B84YRv8shOzCnXPUqq4qMsDeB2AliweH8XbwM6+bUKQxfIdHTF+W4F2+d0
 uccAPld2KDvRlu3dq3D5frnwhcToVBwfXmT214s+Oc/r/TpOhEg+X1IIb7QQLH3AIBem
 s0zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5IbLYrGTpSPXeeMxYo/yCRvxnfBp6P2YMsTi4HMK8kKGp5uPRZFwXCzeuzLle4i2cN2dAqt0v8INP@nongnu.org
X-Gm-Message-State: AOJu0YxLjyrNuyi7Ulirt4aw31ZUuOs6/51E+cWbbCQF6TqKuxICKmEN
 thu5AcaWmcvimpBxsjmgrYOGKHjwTzcrKPADBS8PRfqY62Fmvk9jfKqVHGB0kaH5Q1yuOHk+8I0
 oY2YEf+29ZVZZrf8A8nYLmVV6Avrw2S0=
X-Gm-Gg: ASbGnctUHQpx58dmRvJL28kQYv1ID3Qq0l2iel52hOqnLmNj/GjA6VUXb970IaARep5
 laXYxEtchyHnoXeTKidabjil32hKFD6T67DxCCm5Ba+lN+zHK7fo1C+LHEFLu4U0fg6Qla/9r0D
 AsUfcVP1opvWoUt9HawLZnegnLnDimNlZDvSj7cCIxvOwrCkSAy7Ax0MOCjQYaNBjfwlD0a7+0t
 S+WqxVCIj9HDrBVIYglOKO+76GyMgsZmVMyRLUoGjCazDgjdJfi
X-Google-Smtp-Source: AGHT+IFbK2pX8lftKs9t+PhqpjosJJz8V7Rq9B8MA/pPtbdP48UyV4YHd52/4xZsId+NgEX8LMff8tILvemYF8G7JaU=
X-Received: by 2002:a05:6e02:3c04:b0:42f:9353:c798 with SMTP id
 e9e14a558f8ab-42f9353c81fmr36167645ab.3.1760036850859; Thu, 09 Oct 2025
 12:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-21-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-21-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:07:18 -0400
X-Gm-Features: AS18NWCB4CeEqC7DKQr58Ne3jDBs4omMFZJ5DutPA-gHOqTecmY4fBOzxT9Wfgk
Message-ID: <CAFubqFvjrc+wn1dusOgeyhBr_W0V36=one-EBu2qCw=Hoy+T5Q@mail.gmail.com>
Subject: Re: [PATCH 20/33] hw/virtio/virtio-bus: refactor
 virtio_bus_set_host_notifier()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x135.google.com
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

On Wed, Aug 13, 2025 at 12:52=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> The logic kept as is. Reaftor to simplify further changes.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/virtio-bus.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 11adfbf3ab..c7e3941b1e 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -293,20 +293,18 @@ int virtio_bus_set_host_notifier(VirtioBusState *bu=
s, int n, bool assign)
>                           __func__, strerror(-r), r);
>              return r;
>          }
> -        r =3D k->ioeventfd_assign(proxy, notifier, n, true);
> -        if (r < 0) {
> -            error_report("%s: unable to assign ioeventfd: %d", __func__,=
 r);
> -            virtio_bus_cleanup_host_notifier(bus, n);
> -        }
> -    } else {
> -        k->ioeventfd_assign(proxy, notifier, n, false);
>      }
>
> -    if (r =3D=3D 0) {
> -        virtio_queue_set_host_notifier_enabled(vq, assign);
> +    r =3D k->ioeventfd_assign(proxy, notifier, n, assign);
> +    if (r < 0 && assign) {
> +        error_report("%s: unable to assign ioeventfd: %d", __func__, r);
> +        virtio_bus_cleanup_host_notifier(bus, n);
> +        return r;
>      }
>
> -    return r;
> +    virtio_queue_set_host_notifier_enabled(vq, assign);
> +
> +    return 0;
>  }
>
>  void virtio_bus_cleanup_host_notifier(VirtioBusState *bus, int n)
> --
> 2.48.1
>
>

