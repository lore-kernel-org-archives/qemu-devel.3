Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B80C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wEj-0001mh-1H; Fri, 11 Sep 2026 04:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x4wEh-0001mT-77
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x4wEf-0004Zy-6v
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789113826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSNvb4ZdDtnDJnYUwYPYiiCMZVvs6/HYFlDUJCLNGwY=;
 b=gSCqxJcHqii1lp6XhyU5vAPTj++FjCu9CpAwiM3fG67GO01vOJb/ursT/q6ir9iR6H7sKT
 Lm1pkX1MPbqk6H/YCzgYLj9qLjGwNYGO3VXQcD/HvPWIbCuIy+NWpHTSAoiAxVagttETLA
 TkSue3M+Ew4rAeZBV/g9oPDgQTdqkxA=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-Sfou3TJgMvWJVjIPGhk5hA-1; Fri, 11 Sep 2026 04:03:44 -0400
X-MC-Unique: Sfou3TJgMvWJVjIPGhk5hA-1
X-Mimecast-MFC-AGG-ID: Sfou3TJgMvWJVjIPGhk5hA_1789113824
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66e44d96aa0so623369d50.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 01:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789113824; cv=none;
 d=google.com; s=arc-20260327;
 b=CGhGmZ3CXv2DOApwCLYWXDYVceBy1ZQyPqaK6dzjoPqyEFx+P1KDFSYCx+kk8vmilg
 E6vF90yF4VxifMjNAjsa8K4c7EYSQcW8gUfk4ib8qBSLKj0UDCnI9ialR+044M2HXVLE
 XrQ7R6is5tHo33xdiFuyvr0I+x0jc0cBLAa45jCl0xEZWVQvdF8a2Cb+b2HbBIgRt4x6
 s3R8ONnoCiou1kaIsoWManQN9Hce/8pem33N5OB0TurXixTJF1imhi92yaeuYRvuZQrx
 72FKQEn6OYDfXndtWGm2IrTmeef0UNquLx5Benfa9De+xEDWBKfDAOmpQ4BelG6iDP0G
 ZLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pSNvb4ZdDtnDJnYUwYPYiiCMZVvs6/HYFlDUJCLNGwY=;
 fh=ZGs7c3/fnytETzMCe2/3jZT7VT51Z/u+cS7qu8qO0m4=;
 b=QTlshu/uKreJFOMkDsHfGZbjFJ+T6D1RfqFljBDcvfh6hhh7J5+nXKFgD/fUF1aJi4
 XTYmOFNPzOz+mC0AA27tCURE2xOcv9grr6vuGKBIAiClJOZ7XACVOzCXxeCxio4xP0pc
 RsTDQVazzSKsYAScZCunVvmXCOR6g/P7LUR5G+M9X6Iktt/MFf8P//qb7cM1DF1Pv9Fn
 o/7jRb7GuzDNC4meS6jWci0jUL2YfdMHfURqvp6WUIadvDIehiXBEZmt7WUbdfp7o8gk
 Rp8XyqHkGHXK0SZKEI9E0h+kVzS8I8t77b4ZJHyRWyEkUEOXkt+Q6AETxvquv93QSnoz
 OECw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789113824; x=1789718624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pSNvb4ZdDtnDJnYUwYPYiiCMZVvs6/HYFlDUJCLNGwY=;
 b=ekmEJbpMk3Sh6fJNOlm1wRAxY5fKWX5ojFUlUPgrYilw/J95xFOybr9QpufwWaJmd2
 p41XUcbEEdBmasTuqcIwPjFnxWtIMicUS/FjpXADKTf6UWjkwE/67IyRXDROsRtW5WXD
 uaOqmS9eFnOvjdHXIPnvuK6AZOM2hvIGq1OJxjMnaWn3hyMKHIn8lqQDGBFWd+rsbkt/
 dFThnsvkX4dJYSU101cciozF4TEMf0IDGgOt1hHwSL3DSpDzteoI+mFFBM2mgLEzlw3V
 qWkFOl+ZbKcZiAEtrQKKLZeceVmtv1bkOSaaa/48JcmCeuDUy6oBLjf56xa0frIhECQY
 kZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789113824; x=1789718624;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pSNvb4ZdDtnDJnYUwYPYiiCMZVvs6/HYFlDUJCLNGwY=;
 b=Tw7f7nfRysUgBpvmbYSlErDrczcFDSRHmEJqYYwjO5lRSkjS+nr1YGprXzPpNHQcF2
 7EkUO8/pza8xCw3YQWh5kJUKWCFeLVRnpo2DRv9B9+uxUBne2rZXmglQaYplGlc9mlLM
 DfHpbisXnY9rYgoC2eADMTDtX1AEKyvzQyb8GssmaKYeJ1SYurAPzt/lHVFgds+OnFNQ
 rB+j8PimLX3xGICqvehhx/xoHYWhaVIuo5CWfTIJDTB9INnqU7CQ/YCdiHSJh+xpagnN
 DqdSXR5Usc03EooGR8UdCT7TjgU64EgJ+63AXVLZG0zkG5rjz6JNN6es+fkkCwpU/Qzo
 APig==
X-Gm-Message-State: AFuF++mO8x54oMnXid7JQlp+ZPWwFCDVb9akomxUMuLPs/BIeZYftwRG
 r8jJKt8eiM8tFprGCRJ7RHlv5XRKSc/ggN8z6t6HnIqbtGL6Tp/0AovLQaBPWM6+GXQVL3jh1ki
 6DGppXpBfmgrhq8V+9oAcS0GscniXkLqcvZwJ5jrsoxLqUAaMFVu+2/l6E26qgqtGuGFeUuDIz4
 y9p/jRNDXWNcNHCvj34QoK9iBD5gj4nIU=
X-Gm-Gg: AYBFou2yEIdnCWzTmNQ+OJX6AY743kXTObD6u0z4NOCgICnnWhBOs1Dh7WTtorSs3nt
 iIGG5z4SRkmM5lkmdQkR6QwKXGFA42bWEFsfxrGSnDZgbB24QzdTgA18K71V9O2ETJAnXsu37bT
 ORex5ZdcU5LQ/M2RZMQ+burAekiy6mk8sHfDTetGi1qF5JYZRHp8X0EYs=
X-Received: by 2002:a05:690e:254c:b0:66f:c1d9:c028 with SMTP id
 956f58d0204a3-671247660a3mr1070499d50.52.1789113824060; 
 Fri, 11 Sep 2026 01:03:44 -0700 (PDT)
X-Received: by 2002:a05:690e:254c:b0:66f:c1d9:c028 with SMTP id
 956f58d0204a3-671247660a3mr1070494d50.52.1789113823617; Fri, 11 Sep 2026
 01:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260910053012.1395885-1-oss.patchbox@gmail.com>
In-Reply-To: <20260910053012.1395885-1-oss.patchbox@gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 11 Sep 2026 10:03:32 +0200
X-Gm-Features: AcwNN1URFKnxOmjTSPBz7fvkQWXHUoW9InsDQT3nGh0_nJ5mrJ9fHvN5qZyP4B4
Message-ID: <CADSE00JusYv9n=JEDefznchJ4e0p0OtivHtH5HFo6E5j0F6xtw@mail.gmail.com>
Subject: Re: [PATCH v1] vhost-user: remove shared object entries during cleanup
To: Yuho Choi <dbgh9129@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Yuho Choi <oss.patchbox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 10, 2026 at 7:30=E2=80=AFAM Yuho Choi <dbgh9129@gmail.com> wrot=
e:
>
> SHARED_OBJECT_ADD publishes a borrowed vhost_dev pointer in the global
> UUID table. If an exporter goes away without sending SHARED_OBJECT_REMOVE=
,
> vhost_user_backend_cleanup() frees dev->opaque but leaves these entries
> behind. A later lookup from another backend can dereference the NULL
> opaque pointer, or access a freed vhost_dev if its containing allocation
> has also been released.
>
> Remove all entries exported by the device after closing its backend
> request channel and before freeing its state. Match both the resource
> type and owner pointer so other exporters and dma-buf entries are kept.
>
> Add unit coverage for multiple UUIDs per owner, unrelated resources,
> repeated cleanup, UUID reuse, and an uninitialized or empty table.
>
> Fixes: 160947666276 ("vhost-user: add shared_object msg")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
>  hw/display/virtio-dmabuf.c        | 18 +++++++++++++
>  hw/virtio/vhost-user.c            |  1 +
>  include/hw/virtio/virtio-dmabuf.h |  8 ++++++
>  tests/unit/test-virtio-dmabuf.c   | 43 +++++++++++++++++++++++++++++++
>  4 files changed, 70 insertions(+)
>
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 5e0395be77c..636372543a5 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -96,6 +96,24 @@ bool virtio_remove_resource(const QemuUUID *uuid)
>      return result;
>  }
>
> +static gboolean virtio_vhost_device_match(gpointer key, gpointer value,
> +                                         gpointer dev)
> +{
> +    VirtioSharedObject *vso =3D value;
> +
> +    return vso->type =3D=3D TYPE_VHOST_DEV && vso->value =3D=3D dev;
> +}
> +
> +void virtio_remove_vhost_device(struct vhost_dev *dev)
> +{
> +    g_mutex_lock(&lock);
> +    if (resource_uuids !=3D NULL) {
> +        g_hash_table_foreach_remove(resource_uuids, virtio_vhost_device_=
match,
> +                                    dev);
> +    }
> +    g_mutex_unlock(&lock);
> +}
> +
>  static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
>  {
>      gpointer lookup_res =3D NULL;
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 2881cec72d9..4b32a61a0ba 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2679,6 +2679,7 @@ static int vhost_user_backend_cleanup(struct vhost_=
dev *dev)
>      if (u->backend_sioc) {
>          close_backend_channel(u);
>      }
> +    virtio_remove_vhost_device(dev);
>      g_free(u->region_rb);
>      u->region_rb =3D NULL;
>      g_free(u->region_rb_offset);
> diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio=
-dmabuf.h
> index 627c3b6db79..a1ad362c379 100644
> --- a/include/hw/virtio/virtio-dmabuf.h
> +++ b/include/hw/virtio/virtio-dmabuf.h
> @@ -65,6 +65,14 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vh=
ost_dev *dev);
>   */
>  bool virtio_remove_resource(const QemuUUID *uuid);
>
> +/**
> + * virtio_remove_vhost_device() - Remove a vhost device's exported resou=
rces
> + * @dev: the exporter whose entries are to be removed
> + *
> + * The caller must remove the entries before cleaning up the device.
> + */
> +void virtio_remove_vhost_device(struct vhost_dev *dev);

Nit: There is already `virtio_add_vhost_device()` which registers
*one* UUID and has a matching virtio_remove_resource(). The function
above sweeps every table entry owned by that vhost_device, so it could
use a more descriptive name. Maybe something like
`virtio_remove_vhost_device_resources()`?

Either way, the patch is good shape as is, therefore:

Reviewed-by: Albert Esteve <aesteve@redhat.com>

Thanks!
Albert

> +
>  /**
>   * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup t=
able
>   * @uuid: resource's UUID
> diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dma=
buf.c
> index a45ec52f421..395ea6f464d 100644
> --- a/tests/unit/test-virtio-dmabuf.c
> +++ b/tests/unit/test-virtio-dmabuf.c
> @@ -22,6 +22,47 @@
>  #include "hw/virtio/virtio-dmabuf.h"
>
>
> +static void test_remove_vhost_device(void)
> +{
> +    struct vhost_dev dev =3D { 0 }, other =3D { 0 };
> +    QemuUUID uuids[2], other_uuid, dmabuf_uuid;
> +    int i;
> +
> +    /* Also allow cleanup before any resources have been registered. */
> +    virtio_remove_vhost_device(&dev);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(uuids); i++) {
> +        qemu_uuid_generate(&uuids[i]);
> +        g_assert_true(virtio_add_vhost_device(&uuids[i], &dev));
> +    }
> +    qemu_uuid_generate(&other_uuid);
> +    g_assert_true(virtio_add_vhost_device(&other_uuid, &other));
> +    qemu_uuid_generate(&dmabuf_uuid);
> +    g_assert_true(virtio_add_dmabuf(&dmabuf_uuid, 3));
> +
> +    virtio_remove_vhost_device(&dev);
> +    for (i =3D 0; i < ARRAY_SIZE(uuids); i++) {
> +        g_assert_null(virtio_lookup_vhost_device(&uuids[i]));
> +        g_assert_cmpint(virtio_object_type(&uuids[i]), =3D=3D, TYPE_INVA=
LID);
> +    }
> +
> +    /* Repeated cleanup must preserve unrelated resources. */
> +    virtio_remove_vhost_device(&dev);
> +    g_assert_true(virtio_lookup_vhost_device(&other_uuid) =3D=3D &other)=
;
> +    g_assert_cmpint(virtio_lookup_dmabuf(&dmabuf_uuid), =3D=3D, 3);
> +
> +    /* Removed UUIDs can be exported by another device. */
> +    g_assert_true(virtio_add_vhost_device(&uuids[0], &other));
> +    virtio_remove_vhost_device(&other);
> +    g_assert_null(virtio_lookup_vhost_device(&uuids[0]));
> +    g_assert_null(virtio_lookup_vhost_device(&other_uuid));
> +    g_assert_true(virtio_remove_resource(&dmabuf_uuid));
> +
> +    virtio_remove_vhost_device(&dev);
> +    virtio_free_resources();
> +    virtio_remove_vhost_device(&dev);
> +}
> +
>  static void test_add_remove_resources(void)
>  {
>      QemuUUID uuid;
> @@ -125,6 +166,8 @@ static void test_free_resources(void)
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/virtio-dmabuf/remove_vhost_device",
> +                    test_remove_vhost_device);
>      g_test_add_func("/virtio-dmabuf/add_rm_res", test_add_remove_resourc=
es);
>      g_test_add_func("/virtio-dmabuf/add_rm_dev", test_add_remove_dev);
>      g_test_add_func("/virtio-dmabuf/rm_invalid_res",
>
> base-commit: 1df256f5968e9f7c3c4533a1383b071c044a36d6
> --
> 2.43.0
>


