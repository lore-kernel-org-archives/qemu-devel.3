Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA2C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkbw9-0001ix-Lc; Fri, 17 Jul 2026 02:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wkbw7-0001if-7K
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:20:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wkbw5-0002kp-KQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 02:20:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so2879084f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 23:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784269234; cv=none;
 d=google.com; s=arc-20260327;
 b=Z6Ml8gy9YiYTYArI8PIW7EqM773k/o706/eZQcAyC0nSpHnN0Z8G0aA7sNZeuFh1gR
 2OZr0TXLtcbhHHbIJRwGqY5xDuWejTN15y2PrKgGd8fS7ep+iCRSr0WxZ6o2nBfkD84K
 UEbtxxyV8w2pz7LDHDVTCQDZNDw9UV3ADQkzXs4XfBBoOguXzD14rdYVOaGnyNx/wT9c
 biJ/KVcWpEOdjYCZcwM1W4zEzaLwTEB3lhQJ75Ud0tuOiUEC2lOCbQofu0mS8SLVvThG
 jifotmpL2eC74rSCKLubXoTz+dPJc3haYQw0ZASrUPMqFd8/90ARND8nDNx9n6LQAuCN
 xs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nd+saHVmECEBd4cRFaI+dlvhn4fxqhJBiXv0JkvqJgc=;
 fh=eHBFDOgL+Yp+16F2tyfqAU/z0ciqecePHdX3QxEm5MY=;
 b=fvpHI5mP1eOVJl+hGZ0mSU3ikeocLn20TkHpfZd8acBGGjK6TLjWSiz3I1RgZVWKwg
 zR4pRC+H4FGrCVClm37VeqLWxGVEGfOJoRJy4thcWlqY+8pSP30J+7OaeZ0NtrLlNFp3
 u9Kr7K+XDu0DyHfkBuhZtgPhJkZGZFzcZotq20XUod006DYcKajErMmuQjHGUmZ1A3wr
 WbNjg5te2f2TH0LTI9QOrGx4CB0SoqOUKKPtbJIpVU0m2bgVDdFhHXGFqnMat94HbAfm
 4dtPQMAEzgzZdiHQ9dvA0Id71EK0BggSNzAEtJQeP+yC/EW2uQlliZpn729WwjQJ3qlS
 mWmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784269234; x=1784874034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nd+saHVmECEBd4cRFaI+dlvhn4fxqhJBiXv0JkvqJgc=;
 b=sX7y3gz72ddjIdGF6cafiZ5MVUDkJIS8kErfF0vLY0ou1Nu1bbQm+dmOwEttDJu2Mi
 sBkyDCAY7PHkPW/d0RMyEYcRsKt8wEkWOZSZji6VO0LE/l3hIkOqJZIvxps2ugwFff8M
 2iDL5DjB/b9nwLOhOwYKGGHztYRLvaDcVx30Urn+AjWwpwK/LsXGj4TE3AZb36VzOyEc
 D+PZaCU8IU31gWh4zbqf8WBshzExezpkFSqAGy4SFWxJE/in5kazZ5ssmGBfkriaDZg5
 kEFtnPjwPuYMuS0TG+gImRYR78kQe0BOc9XZQMrr0naa5PLtou5dlYmLmlwOG+afwTGJ
 mw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784269234; x=1784874034;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nd+saHVmECEBd4cRFaI+dlvhn4fxqhJBiXv0JkvqJgc=;
 b=oc7Gxpmo/q0j+54jKmpeRp2FOQ4x81FmhcFwScj+ERRH0UG+fOo2Mq2WO0YS0Qe1Bn
 cMvZpSC0cTwjOXf5LHklHcW47wFYtbf1oNIGNaYP/rLfK1bKrVG+z0Chu/oZ5xWYipzX
 IW1rHciws1Vxr/J9r03v2FD9OY/M9Qz9dJos3j1fk4p8YOEJV7qaxrRwwLF3FCnmF8Sf
 eli5im6IXKvhyVwfvnjt6UU15/GLnwK74Mkz6/2ilVvrlPrdYudI8cW2aiUrcPgz81SJ
 UHUYsjIX4SOAYyiLuKYq0aP5whMHdxsYjkMvkLd8+ziuqd7h7PschG3XoW8JPKj7sBO6
 JaSA==
X-Gm-Message-State: AOJu0Yz1+qMZMyh0bIdLmL/+8Y7zeEpPpP5/euBXl2y25ChbYoyAVw+s
 TASc0F2GIgBFn+0ewZmE+4hzhr1046S7qd9xiLj/lWAHdXajSyAjofWcW/8D24z0S7lv0UfUoFX
 L+of/uD6y/5cu7p+ap20N+JyARMgceFmRP/ZvOVPd0w==
X-Gm-Gg: AfdE7ckZi9s/xerVCCiNgTMuIp2HGdIa0B9UL01xy929khRrmnzJAkH+j91RXWmj1yC
 RKQ2IN4Ly9XZRcfcTE8UO13dBLKtgXmoNGjnkby0+a7x5ZQFCkqHcN03SHuVMFPCyKVfqxANLnS
 1UXz3vP3Dl5e8OJjUzv2LhvhlE3Ymm+bVwgS+guYUSRk6H4KCcBmHTksZUbGamDmKDgUl2BSw20
 TA5r0AvLtzcQ1fomZYf0IvKpCiqUuTwqboFfAje1/sYpDnMGQ/pD/JhKNA6VrFgPyP5O3udVMOn
 oMelqRElp79FoJk8BmePLC/oJfSacgKE9kUm9IcMZCQieOwfYMyDckxgr2LykYAv6YWaaaDn2Zr
 JfOma28kr9Z0Sini756UTxZB60L4eP+h0oZJdtxG4EQ==
X-Received: by 2002:a05:6000:2011:b0:477:6da:1b83 with SMTP id
 ffacd0b85a97d-47f622fe22cmr1525463f8f.24.1784269233702; Thu, 16 Jul 2026
 23:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132359.96785-1-dbassey@redhat.com>
 <20260716132359.96785-2-dbassey@redhat.com>
In-Reply-To: <20260716132359.96785-2-dbassey@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 17 Jul 2026 09:20:07 +0300
X-Gm-Features: AUfX_myB1xfpMa44iLxPzs-i8twzAPOuYfWAzuWXvC4uNNrMLLkvSWn96ouGO6M
Message-ID: <CAAjaMXbcFtfKqHGUkiKWCsf5aOJ3N18KsyTXQmQLahZS4zR=Bw@mail.gmail.com>
Subject: Re: [PATCH 1/3] vhost-user-gpu: Forward RESOURCE_BLOB and
 CONTEXT_INIT flags
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
 pbonzini@redhat.com, aesteve@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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

On Thu, Jul 16, 2026 at 4:25=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com>=
 wrote:
>
> From: Matej Hrica <mhrica@redhat.com>
>
> Forward VIRTIO_GPU_F_RESOURCE_BLOB and VIRTIO_GPU_F_CONTEXT_INIT
> received from a vhost backend to expose it to the guest.
>
> Use vhost_dev_has_feature() to query the backend features, matching
> the existing pattern for RESOURCE_UUID.
>
> This allows the guest to negotiate blob resource support and context
> initialization when the backend (e.g., vhost-device-gpu with Venus)
> advertises these capabilities.
>
> Signed-off-by: Matej Hrica <mhrica@redhat.com>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


Nit: this patch maybe should logically come after the patch adding
blob support (simple reordering).


>  hw/display/vhost-user-gpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 57360898ca0..06549c98e07 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -643,6 +643,12 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Err=
or **errp)
>      if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID=
)) {
>          g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID=
_ENABLED;
>      }
> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_BLOB=
)) {
> +        g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_BLOB_ENABLED;
> +    }
> +    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_CONTEXT_INIT)=
) {
> +        g->parent_obj.conf.flags |=3D 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_=
ENABLED;
> +    }
>
>      if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
>          return;
> --
> 2.52.0
>

