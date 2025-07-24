Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA0DC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevpV-0007gP-WE; Thu, 24 Jul 2025 09:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevpQ-0007dc-Pr
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:17:45 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevpP-00066n-3D
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:17:44 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ae3a604b43bso153804766b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753363060; x=1753967860; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKa9Xfs+jC54utoZbp9wWbdGbgaNPTNBJbxU8B9LYEk=;
 b=edbLXvN5os8yrMXxA8N0ZgmWwXbZJjN+iv5THa1HtoQkeyVVvv0qU25HVHgnWfBezQ
 0d4YOtd/7iF8VACQaAp8tq2ax/T923keEvk5NIQyS0tDlZG9pPbqnn2xz3t6OM6Ehc+o
 Qn3z3JsE9JtRqTd+IvhV4CIXLmg88EmrMOXln/dA8eJoMr6fSeEexcSaVpX8wmdt8rJh
 5DNTITO+BC+Ka+tK0BRrutMWzSQeZI4bwQdhuUsVrDKW6HvYwlI4ufe4oHAGU0+FQVZB
 mugK/0C+Kvk8LvIdF25It8A7/jPU7KzvT+mpLU0I3I6FGZoTkcOpvpR7AoNWa0U1mf2t
 W58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753363060; x=1753967860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKa9Xfs+jC54utoZbp9wWbdGbgaNPTNBJbxU8B9LYEk=;
 b=jfWWJeQkWWCc7DQ4nYB6W5zsgA33b/fyzjA/fnW5fcDpUWkSf2J9hrownCiUBmaAMU
 DyKS8wTfOsi+LTkhTirwxw0u1R4h5nHlWtnxLu4aVg5+i46tARG8FIrbOHlafrjjoT/6
 3UlEs/fdbyfb3tC0N02HtEgE70IIx6QM2Xt4Bp9neDGVgCGV7uxdw0hMzxwhbwlSmM17
 SnDzShvnRFU2Xe/uioaw6UACy4VrmQ/F7aDy7/QgFCXE+truK7JuYSOIJPneYN1ozzlg
 vh24kpPCyeCM4c4/KFiGjSSd/wpSsUoq9NkLxIB0fthB2I/0E9ugtMXbLTuPQG3RNiP1
 b9dA==
X-Gm-Message-State: AOJu0Yw0jnihPCbWw4Zx9lh5Nj0Lq72bvO2dr73GWz/RPojp7lKFjyQd
 5q5p5pl8ovIq1JP3vGqmvmqb+tb46bAnWu1wwPe7+6P7EWOaA6YlmsSgzju41WOHss75UiW+rvG
 ng5YJVCuUjl8Gmr2/h5n+6f7nAsv/4HUWXW4QbnvRvA==
X-Gm-Gg: ASbGnctmB8625P/8NIDofkTiv9jiFCmPSIVWvcqa6rHwLeIhuapz7lLJWmATbfUiwBi
 O+9nEleQKTGhxfnorXoQu1azZIjQwPTQRXD1hLynGpRhnByi8XtVK5EGd+Fy4c3+2JjPnjvQMpK
 6c6Vu+ec9fLPMUMJWWV2Bch2okrK0YwRczWzwMQbQhEcuEoP4/aCTWgdpWMA6jbxRAOzwqAqMmO
 2cDiA==
X-Google-Smtp-Source: AGHT+IEaM5fGR+ucdMcIE/Zyo2rH+mc8wvrQk14WM0wfEtU/y6romPuYcWCKjx1vH4uoghWVZWhk/2RYA1FVaEpzWPk=
X-Received: by 2002:a17:906:c14e:b0:ae0:635c:a400 with SMTP id
 a640c23a62f3a-af2f8d4e87bmr650990266b.51.1753363059961; Thu, 24 Jul 2025
 06:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250724125928.61045-1-hreitz@redhat.com>
 <20250724125928.61045-3-hreitz@redhat.com>
In-Reply-To: <20250724125928.61045-3-hreitz@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 16:17:14 +0300
X-Gm-Features: Ac12FXwOj1GLQpZBQWGaH2C4gLbt0_D2cd48O4OYBDmTbhwoltKtpmDf-gTfRh4
Message-ID: <CAAjaMXb7SuHrCh_oCAoVKmfo8eNXoaR=8ay5sDAMrS4Qdtxk6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost: Do not abort on log-stop error
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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
> Failing to stop logging in a vhost device is not exactly fatal.  We can
> log such an error, but there is no need to abort the whole qemu process
> because of it.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 05ad5de629..6557c58d12 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1122,7 +1122,8 @@ static void vhost_log_global_stop(MemoryListener *l=
istener)
>
>      r =3D vhost_migration_log(listener, false);
>      if (r < 0) {
> -        abort();
> +        /* Not fatal, so report it, but take no further action */
> +        warn_report("vhost: Failed to stop logging");
>      }
>  }
>
> --
> 2.50.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

