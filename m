Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 12:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGcmR-0001U1-QZ; Wed, 05 Nov 2025 07:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vGcmI-0001Sq-Su
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:38:19 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vGcmG-000333-8S
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:38:18 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-640860f97b5so6222343a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762346294; x=1762951094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SX0304ma7LlkmakLl1AF+T1mgjYKJJuFt7RPNu8g83M=;
 b=bnbGwkGU12hxVUzZ4t06YM2L8AzfDiVyGxhG9VC0fqCyR8L8zKDS+bP2Viw8W1jHgy
 VARePn5HC03P5+kNX8ZrEiXf/2Q99tQFalsR9pVf5rqlTPxNbQjAAO8BGnUG7TpCMWmr
 GbuMudwZH/heoKDZelo3lm1KTzRyrvAHFfgKs8osqVx1CF5+DekjYKKAeXRVGAgu1bNi
 cjeNUF45jTrbzKzKzs8WOKdqzQsCakXO3tsECI6Yj/ov/79q4DTL2F/epWajWP3A3+JS
 /tJdoEeQAQCcXrZgAb3jebzr/y8COnKP7h0PTHoH+eAO77KjspAMvekbMBg69igSFYIT
 g9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762346294; x=1762951094;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SX0304ma7LlkmakLl1AF+T1mgjYKJJuFt7RPNu8g83M=;
 b=PT79lBcY2Ddfz9AtSCWYVAXsm9d4IbXV0bjwALKxxunaAkz6UMmpUN4gtKvfI3GJMY
 1wN+vFFWEGdQVjsch8Ubq0uPf9lxh4rAJcSCGopyziuUgpwXFCNggeVC3mYXDWhqswvE
 Trb3f0yThOsTozhJlvcfctrA1Cyyc3jl8dAR0QeD7H1cWoajS3ViOAX6kovr+w6e0jyK
 76T7qNk+g3ok7cb0K0J14XlEZMQciLAOVz+Rvdsj/ngAbmrhHs178weTDQVq8tqu87zl
 F3sN3O386MlNL4HXOabto0xGbD/c6lzYGiXoPpUMaldNr0tiQfLHivsafNZ861Ybx7Fw
 JFvw==
X-Gm-Message-State: AOJu0YwruqQep3FWElmfKNaakYRL07j0TS8osGHdyyoZ14LNhviZeOWH
 X5W+C0lgXmkHceb186mLosaV/r2SeCI+5UIuMYImNWAxuB4+6AGU8ecKowYOZjXGXy8=
X-Gm-Gg: ASbGncvEwi3xvdgu8N6FdHzNTP2KkIChK0sPIbsu3Y9qptXBpiW+CR7vDIpYKBkBpsv
 KKF8jzgihyt+U+OK53v94DG9tPJD6cyglGyANWPL3R4G7TfRzNBIUP/ZmkO4aYQNNjt9gAYx8UN
 eRW3MLfDjN5iCZVFUKOEs93ehWYYNFQl7WtYtqy8olQ6cCFnwAE8EHj4rI2hCjBbCrQCOO93E/8
 AN1XPza0IC9WD/1EtCogpGUtO9RVf5j2Vji/rEN9gzKe0mYrVCXZ0XZwBez3Q9A+CL5JCOTzBNR
 6yxmXBoLLUUpYO0gaDpJ267AeRVu9xoYNf0++NO+CknlWxADjGOUuvKtjeHTzfw0iWtedM6qkve
 rXhpufd33GEX/4741laxBB/7l7OL29DtGzK0M96icYFZxE9bofZk/Z6TqVYbP4FVPE8dlI+AWNs
 DWHxFQhVrrzEw=
X-Google-Smtp-Source: AGHT+IFK42NacTjbmFdPFQ4Vk616DBQ4meQeHFXl29CGKFcivkj9zNW8QWpFM5eSt+FNvPGe6ZWx1w==
X-Received: by 2002:a17:907:7e9d:b0:b70:ac00:2d3a with SMTP id
 a640c23a62f3a-b726517074bmr263093566b.8.1762346293726; 
 Wed, 05 Nov 2025 04:38:13 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7276298b54sm83418366b.14.2025.11.05.04.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 04:38:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E88A45F88E;
 Wed, 05 Nov 2025 12:38:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,
 bill.mills@linaro.org,  edgar.iglesias@amd.com
Subject: Re: [PATCH v1 1/5] virtio: Introduce notify_queue
In-Reply-To: <20251028152351.1247812-2-edgar.iglesias@gmail.com> (Edgar E.
 Iglesias's message of "Tue, 28 Oct 2025 16:23:46 +0100")
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
 <20251028152351.1247812-2-edgar.iglesias@gmail.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Wed, 05 Nov 2025 12:38:11 +0000
Message-ID: <87bjlgvemk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

"Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:

> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/virtio/virtio.c             | 7 +++++++
>  include/hw/virtio/virtio-bus.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 153ee0a0cf..8a53fb5f93 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2700,12 +2700,19 @@ static void virtio_irq(VirtQueue *vq)
>=20=20
>  void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
>  {
> +    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> +
>      WITH_RCU_READ_LOCK_GUARD() {
>          if (!virtio_should_notify(vdev, vq)) {
>              return;
>          }
>      }
>=20=20
> +    if (k->notify_queue) {
> +        k->notify_queue(qbus->parent, virtio_get_queue_index(vq));
> +    }
> +
>      trace_virtio_notify(vdev, vq);
>      virtio_irq(vq);
>  }
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bu=
s.h
> index 7ab8c9dab0..043dbeb4cf 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -39,6 +39,7 @@ DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
>  struct VirtioBusClass {
>      /* This is what a VirtioBus must implement */
>      BusClass parent;
> +    void (*notify_queue)(DeviceState *d, uint16_t index);
>      void (*notify)(DeviceState *d, uint16_t vector);
>      void (*save_config)(DeviceState *d, QEMUFile *f);
>      void (*save_queue)(DeviceState *d, int n, QEMUFile *f);

The code looks fine but we could do with a little outline of why we need
this is the commit messages. Why do we have notify and notify_queue? Are
they mutually exclusive?=20

Not specific to this patch but we should strive to document the
individual methods in each class to give a clearer idea of what they do.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

