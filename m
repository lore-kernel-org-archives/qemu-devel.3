Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA29C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wke6T-0007OL-6d; Fri, 17 Jul 2026 04:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wke6R-0007O9-87
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wke6O-0002tB-TD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784277558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+J8ouTUOutmqXF+mKLUSaJg8UqrVHLs91VXo4vxdPwU=;
 b=dd1CQfO3mnkMA4rUIyVdikw4cBGtpI9D91bD9upgWwcRwXL/ylmKu6vu3wG9mce8nFC3RE
 5M8SIQb6JTceJQUJinovYI0erZI9S47taIEW5I9LNVkbXd9kybs+RSfbPZiSz4R3Gse4AG
 18IiTy2GfFzRLrj/8j7oUx3CAmvnKoQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-oDPSwp0wNaCwckRFzm64Pg-1; Fri, 17 Jul 2026 04:39:16 -0400
X-MC-Unique: oDPSwp0wNaCwckRFzm64Pg-1
X-Mimecast-MFC-AGG-ID: oDPSwp0wNaCwckRFzm64Pg_1784277556
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-81e6fce9ed7so134016187b3.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784277556; cv=none;
 d=google.com; s=arc-20260327;
 b=FXg11xpdY1hdnsDow3zexXHYc6TAV+c8NtnpkHFJX5taxlwvINrk665mA0u1YypEd+
 R7d/5CVaJtoFd4fEi2eBbDXrlgrI2XlGc6CoGEXGaIPBI0Mw+jfkhRX1ml40cVb6ZTZc
 Fb+v0P9Vv86knaitlKOujVzYLxMAkVAm/HT2ayq/X49FG/8mL4sfAHsrL2+F++ZBUDC8
 8ZxKXL+GnucLCApuLjswR68W/IdQ/tOA+MrXo4bMJlVnA0WdpuwvES0khFmf2zD6B1hd
 xZhQcDtu1/nCvz+NwPijsneJAUYH94IAzAy7lnDqhs2+8rJX4aB3G+HJdW7b4q+F0hEO
 Ip5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+J8ouTUOutmqXF+mKLUSaJg8UqrVHLs91VXo4vxdPwU=;
 fh=scobbx4Z3/DtfOtk4QFSadtpeR2080Ksudnd1sTI/uM=;
 b=QVsCc/r075FMcOzsZTyNBM1ocXjZlj4I+4QmA3rR3tWTBNyoy64xUwZQG6z/BB79Lq
 Mq79Sls9QtMP5Uh0NbC4XXc/ZcxB/gq1V9eILoqKzVd8iuPIms61F040UsVV8slZxsxs
 VybOpDNxe1qNT0vDOBjXm0Lngxh5o1nfYqQMX8YeVIGMOZY82MSadA9nnCsh1Au8pwdl
 B9YV1/mlEZ2PAMluqGTR9W6df++6XHySqWeQ5xhvuT08w3D1OspB8myViWhH4amwPlNC
 cHsPOVc+ZIGVnSsjpIRoEtJ3oCH14dfRAzChXxClp3IK7ofSyyv2J/+2Dmqqs6XPJt5p
 rmNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784277556; x=1784882356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+J8ouTUOutmqXF+mKLUSaJg8UqrVHLs91VXo4vxdPwU=;
 b=BQnYYv7rZ3wJWUbCbuvglpusvPOiO0AdRLAFCAS2RTgWYhyioSWP7bUuLfjBpxUbov
 a49FIVsZcO1zl5QjDOJaEEunbtqG2cHYXK2Cgb+OT5oF97AYgh7DktgLKcfqaRmqhpOu
 gaGsR6mWjeLgQXOrkmOv7qnQdbGK469paCDWJQC/XwSI7DiWWrqaE9+jqqV8AOLvVam2
 cZeT1mCZdFK+LJyZGYbaiKzuUT78XOG2sY4mivrxo/LH98PVefTD+HwqVG2XOiqxlpWE
 BljJiKsAUlIaXXU9fTJ3t/QsQXnziUpQ51N6aG/ur6aVe4EHQzPH29dpVdtKuRSoZ2Sx
 OCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784277556; x=1784882356;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+J8ouTUOutmqXF+mKLUSaJg8UqrVHLs91VXo4vxdPwU=;
 b=EhTDZeASAisVgxFFxznTNaYN4yj58VOn9soS5fK9Rt7X+Ti/JnqDNpD6xCMZlhL+tc
 gkv5l2w0Tuc6ZCE8hbTQxR+RYOod2marzkEiPfs2eCLedpP+GLc6PQJ8T4Q1O7CYzZzy
 u9/jDqUun4+6k1LPQ/w3/8bEio8wEmwYz0cvtYIOTG5cRcOeWFZYkev46W59HJfXS7M/
 Lu8Mw6nbbkvPVc8w08RYMRZynEEoe6lhh5gKSv7Iriqs4n+5YAGDtJ5PK6sOeAM3KtLz
 7Lub7QkA2gBrn7CFu3qQNFHcluXSu55JBWtjFMqZ/a1K8oVGMctJYj4fjgvwmSvIii+l
 POBw==
X-Gm-Message-State: AOJu0Yx+hFmhxihGNc5kxlxRaXLaDlIAjPniRspF1nYo/bgEVadNm+QV
 84NWHJCh/+1upVm1fdbly1AuYLFG344SnU3r1u2xcNqY8WWJzhraiCUYBwcGDEboxGarurH2euP
 BD5Rzof/U/4KRDVfCuMzln/KLzwPOVzsfUjTo/0KpB1WxyCXNkNVeOifkVp6LVG7xRQdo1/yy9g
 oTA5q4rqv0nHjsLvuqAnLK7zDuoTv9CnU=
X-Gm-Gg: AfdE7cmNqCdr9CB1rK8NgNbMml6T1EQU5UvjdQVrv4b3aJ6Rr21fHjRY6t8WoG5R0g9
 u3f27R4q3fMhB10OcZvBxIRsiXMDgl94MlUggjWGvnvohEkCXN7eF+M3ixEjJrKz9pvtzARqNMC
 6Av/CjkTaQdNd1o7DQduNkhPlclOUDXkr9qBoP8ajGkpCrmonIiSxPvbA/
X-Received: by 2002:a53:e03c:0:b0:662:b4ae:f38b with SMTP id
 956f58d0204a3-6683bb7ee2bmr370139d50.40.1784277555841; 
 Fri, 17 Jul 2026 01:39:15 -0700 (PDT)
X-Received: by 2002:a53:e03c:0:b0:662:b4ae:f38b with SMTP id
 956f58d0204a3-6683bb7ee2bmr370126d50.40.1784277555337; Fri, 17 Jul 2026
 01:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132359.96785-1-dbassey@redhat.com>
 <20260716132359.96785-3-dbassey@redhat.com>
In-Reply-To: <20260716132359.96785-3-dbassey@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 10:39:04 +0200
X-Gm-Features: AUfX_mzYcYMq2oz2aVtklBXrGE2vNeJSHgaDkj7vIHd93GLr--Ifor8TI_XL6no
Message-ID: <CADSE00+o6Ut78pTUUBFRXtnF5+UEtj0Ckm20KSszCLTGuRZMyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] vhost-user-gpu: Add shared memory region support
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=aesteve@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 3:25=E2=80=AFPM Dorinda Bassey <dbassey@redhat.com>=
 wrote:
>
> From: Matej Hrica <mhrica@redhat.com>
>
> Add a 'hostmem' property to the vhost-user-gpu which enables the shared
> memory in the parent object.
>
> Register a container MR in the shmem_list for SHMEM_MAP/UNMAP
> operations. A container MR is used so that SHMEM_MAP FD-backed
> subregions each get their own KVM memory slot with the correct
> backing fd.
>
> Signed-off-by: Matej Hrica <mhrica@redhat.com>
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
>  hw/display/vhost-user-gpu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 06549c98e07..7e4580aa895 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -655,6 +655,21 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Err=
or **errp)
>      }
>
>      g->vhost_gpu_fd =3D -1;
> +
> +    /*
> +     * If shared memory is enabled, register the hostmem region for
> +     * SHMEM_MAP/UNMAP operations.
> +     */
> +    if (virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> +        VirtioSharedMemory *shmem =3D g_new0(VirtioSharedMemory, 1);
> +        shmem->shmid =3D VIRTIO_GPU_SHM_ID_HOST_VISIBLE;
> +        memory_region_init(&shmem->mr, OBJECT(vdev),
> +                           "vhost-user-gpu-shmem",
> +                           g->parent_obj.conf.hostmem);
> +        memory_region_add_subregion(&g->parent_obj.hostmem, 0, &shmem->m=
r);
> +        QTAILQ_INIT(&shmem->mmaps);
> +        QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, shmem, entry);
> +    }

Why not just use virtio_new_shmem_region()?

>  }
>
>  static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
> @@ -665,6 +680,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(Vir=
tIODevice *vdev)
>
>  static const Property vhost_user_gpu_properties[] =3D {
>      VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
> +    DEFINE_PROP_SIZE("hostmem", VhostUserGPU, parent_obj.conf.hostmem, 0=
),
>  };
>
>  static void
> --
> 2.52.0
>


