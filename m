Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFF606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hfDv8H8w;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NDBSFbLB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLcoM-00067V-NA; Tue, 27 Oct 2026 04:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xLcoK-00067M-34
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 04:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xLcoH-0003wX-UI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 04:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793090732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xz/ZglyE+Yb6of/zsc4wTKd7m1oNcOd8DFAUJPraomM=;
 b=hfDv8H8wti2+ALvfuOB9PAc7SEZwauoRwD5TwcrSdk/NH2g0+iqKx9vgcR31t7bwPgeAGz
 YcUhn4nEievYGHwxDX6tH+W78Xm199CEZkx4ovwDmJPlRvhQtps7ByF+Lm1fUx8fLt8ZqR
 gDJzMULCMhPGKM7Jud6dh3Dh317RoYw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-jnZc3b_EPpq3YdZayiB-xg-1; Tue, 27 Oct 2026 04:45:28 -0400
X-MC-Unique: jnZc3b_EPpq3YdZayiB-xg-1
X-Mimecast-MFC-AGG-ID: jnZc3b_EPpq3YdZayiB-xg_1793090728
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8a59717b0c0so1472109b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 01:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793090728; cv=none;
 d=google.com; s=arc-20260327;
 b=i4GLdB68XsqI82WfH97w1i84OyRep5WV7jNvjLjuEgPub1ADpgrZ8DYFtTnSJpZizP
 BYUM7OgwRRLP2nsIHA/W4JqMQSZpqhZ3VzXryNxYoCmOFSm1Fva6Gefdl9fa3g8iQrid
 zDZ86hZr6Dt10GWCCJrl+2piySrH5PFn+o1H46REkE3TiPJVX+9U60XAWmOTDN/z2HF8
 vH1FPjJ0PjMMFYE8QtFWHs4zwauNGAxdUYkYf6pQ2eDGPqKH/0A3kkxlfbF/IgggIjrU
 FNfYGrkKcw0ohG5TOXykybuDBL+H9aLt8ZIus/9eK+ty+MJQ/fN8FpD0DAg1UxVcYXwy
 RjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xz/ZglyE+Yb6of/zsc4wTKd7m1oNcOd8DFAUJPraomM=;
 fh=5iQTWMxmx5pq27uMZWmZaPKIRR84JZ1OWCg9FNfz8KQ=;
 b=Zzgq9rnp00MJ9M1oVf9+V7tPPvOQPgWC8eTlrWZm2oWGIcg/RbneVxzdGiWNR/vKRt
 2gPZB04zMBd8xfqBSJQjy72c2MoPgH51KiEQvhC5e1qiDfTdv4EluaqjGo2pD3T2S0E8
 +xARKofOf4/8PhE5fiZ3PU0Ri//3dKzYxxKfINmyHtrVTd1xQOrUU9/XhQQaqaAVAV2n
 7oaFvSSsWnJi5ZweMu5FfLGJh+dKVRmhkXNBIzVwuBSe1hf4ZXsYrU0BojpnpvsvTgzm
 cNODyCU62AS4kdot4E1Z/HykE7bDz6nvLlUqMkkNgtpaq8q+o11f/gMSXy8FZilqMOfh
 0hKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793090728; x=1793695528; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xz/ZglyE+Yb6of/zsc4wTKd7m1oNcOd8DFAUJPraomM=;
 b=NDBSFbLBlOov8gm1++s22zqUL9XD9EucQ4/4PMAwEc9aL0/5mtkgIeNSuP3kupdJGU
 EtSwA04RShh0mPpEu6AxA7jHk5dfpWk/TWAHxnX4UkoALLqT/UBGS0vtfYdA/rGRcmaH
 XwRa4h0uNyPX3LdLCjDtImdUqGbX/J+KUNEUnrYMP2Rci0WXxQIV+YVecRfU32lpIKn6
 kDPQm1qdW5wKa9xpbCzztkngaSiazIBRL69XZUK+FtyZSAYDtxSBb2SPn3VSvuiwml+h
 rulbUje/l1IvTSEJc5TBP8cSWiwvk90Q0NB3WWpYAqufP11UkdHEd+AQhaQi8YWdsYE8
 eh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793090728; x=1793695528;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xz/ZglyE+Yb6of/zsc4wTKd7m1oNcOd8DFAUJPraomM=;
 b=VjN4B3KPFTYZ+2Wc9czsaQKe90cMgbyF3DiNbIw/Zcv+43mTrP+vhOr6o/xGY7oVAa
 3kQezM64bAmwXTL9IdDqaZqDTM4CwZ9zYQEF6sYEibdGP3BwjGQ0CVeht1Rc1Z5FejDK
 CzSSZd39nbwnLwCh0XjeQyuHdoQ3n8zF/MVNEwePrPqdmmmjcn6JbSKER100FAievJUM
 AIhdG2rAz8Dmj647M4y0goFuJz4H75poxywdjOaTLX0AzW3ewKXJORc+WTb4nak2Dno+
 lDFy2f9QqQuSdre5X6nRACWGa0kPWP9iBWz2g+GXA76JQI5NDWV+h8DYAowJD/G/NOD2
 LF4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3C83/nOSRuAsuhjvkHOLQ585H79gEQ8mjMtCM+Kz1KHDUCl82EkX3rG+ntuXxw648b3xyn52EIal7@nongnu.org
X-Gm-Message-State: AFq9FYJur/NxpSzq+RQ2W5nlktl7LqHyNR0No2lr9GuZ71BPcCbdz8vS
 RCfY2+xi9yNSiZNN5AuvEYj7j3Eob9X1zQ8UW4ajN0DWuJtPRfEsai8gQBt6getlzf4+VQr0vLc
 jVTJM/5w1SrDJ3yzmwdf1iONIVwWxhSKuC187iYNGLD1P7aTjmaE+fMVmV53t5eYNK5e8x0HhEc
 i9OJalptNt2AD6RnXrJH+YaITAx4oPliQ=
X-Gm-Gg: AYBFou3qKklqGfZ2BkIFdNGeIwlf1kBlO+6apiEsGji0RKF4uLGMgZiUqRfndA8J7K4
 CVQYucze8gNJFnlv6iYFgUu6AvPU/tT9H08rpso7PQygO82wH6mxjhMSZ0x9QeNTSLPlT+39SPi
 OwJiUcUgnVXauk7YCZuK3gSwRQIkbx+/wojJmW/X5bvUdbCOj7tMdnUhruJQ==
X-Received: by 2002:a05:6a00:8018:b0:89f:28c3:aab0 with SMTP id
 d2e1a72fcca58-8a367447253mr6766711b3a.40.1793090727627; 
 Tue, 27 Oct 2026 01:45:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:8018:b0:89f:28c3:aab0 with SMTP id
 d2e1a72fcca58-8a367447253mr6766697b3a.40.1793090727093; Tue, 27 Oct 2026
 01:45:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
 <35dd9653-bde5-42d8-bcc6-20b692010eb1@virtuozzo.com>
 <e5fbac0c-b4d0-4e8f-8865-23791057c570@virtuozzo.com>
 <05d6cf1f-7e20-4ee6-838d-1e455720df76@maciej.szmigiero.name>
In-Reply-To: <05d6cf1f-7e20-4ee6-838d-1e455720df76@maciej.szmigiero.name>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 27 Oct 2026 09:45:15 +0100
X-Gm-Features: AclHuK_mGJozb1vvRB1cVh1tynObdyV9xRohDWjyQ2NxrqggGcWNwFKAJcdoKcA
Message-ID: <CAGxU2F4xm-EsZZYSq7wtuNKxVb393xXQtjMLQV1h6CvmBVSeOg@mail.gmail.com>
Subject: Re: [PATCH v16 00/22] migration/cpr: support vhost-vsock devices
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, clg@redhat.com, 
 den@openvz.org, dongli.zhang@oracle.com, farosas@suse.de, peterx@redhat.com, 
 dwmw2@infradead.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 19:26, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 26.10.2026 08:58, Andrey Drobyshev wrote:
> > On 10/20/26 1:55 PM, Andrey Drobyshev wrote:
> >> On 10/12/26 1:28 PM, Andrey Drobyshev wrote:
> >>> v15 -> v16:
> >>>
> >>>    * Patch 15:
> >>>      - replace the errno filtering in vhost_dev_try_release_owner() with
> >>>        a new 'owner_handed_over' flag in struct vhost_dev.  Release the
> >>>        ownership only if it was handed over to us, and report any failure;
> >>>
> >>>    * Patch 19:
> >>>      - set 'owner_handed_over' in .post_load() on the CPR target;
> >>>      - drop the redundant 'owner_reset' flag, use vhost_dev.owner instead;
> >>>      - drop Stefano's R-b because of that.
> >>>
> >>> v15: https://lore.kernel.org/qemu-devel/20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com
> >>>
> >>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>> ---
> >>> Andrey Drobyshev (22):
> >>>        migration/cpr: forbid saving duplicate CprFds into hash table
> >>>        tests/unit: add test for duplicate keys in CPR FD table
> >>>        migration: forbid snapshots in CPR migration modes
> >>>        migration: forbid snapshots under Xen
> >>>        tests/qtest/migration: add test for snapshot rejection in CPR modes
> >>>        vhost-vsock: block CPR migration modes
> >>>        vhost: add vhost_reset_owner op
> >>>        vhost-vsock: don't reset connections during CPR
> >>>        vhost-vsock: fix FD leak in realize()
> >>>        vhost-vsock: preserve vhost FD during CPR
> >>>        vhost: factor out vhost_dev_init_backend()
> >>>        vhost: make vhost_dev_cleanup() safe on a partially initialized device
> >>>        vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
> >>>        vhost: add vhost_dev_is_initialized() helper
> >>>        vhost: release ownership in vhost_dev_cleanup()
> >>>        migration: add MIG_EVENT_INCOMING_FAILED
> >>>        vhost: release ownership when the incoming migration fails
> >>>        vhost: release ownership on exit
> >>>        vhost-vsock: hand off device ownership across CPR
> >>>        tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
> >>>        tests/functional: add vhost-vsock CPR test with a live guest
> >>>        tests/functional: cover a cpr-transfer target going away with vhost-vsock
> >>>
> >>>   backends/hostmem-memfd.c                        |   5 +-
> >>>   backends/hostmem-shm.c                          |   5 +-
> >>>   backends/iommufd.c                              |   4 +-
> >>>   hw/vfio/container-legacy.c                      |   7 +-
> >>>   hw/vfio/cpr-legacy.c                            |  29 +-
> >>>   hw/vfio/cpr.c                                   |   6 +-
> >>>   hw/vfio/pci.c                                   |   5 +-
> >>>   hw/virtio/vhost-kernel.c                        |   6 +
> >>>   hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
> >>>   hw/virtio/vhost.c                               | 136 +++++++++-
> >>>   include/hw/vfio/vfio-cpr.h                      |   7 +-
> >>>   include/hw/virtio/vhost-backend.h               |   2 +
> >>>   include/hw/virtio/vhost.h                       |  80 ++++++
> >>>   include/migration/cpr.h                         |   2 +-
> >>>   include/migration/misc.h                        |   5 +
> >>>   migration/cpr.c                                 |  64 +++--
> >>>   migration/migration.c                           |  10 +
> >>>   migration/options.c                             |  13 +
> >>>   system/physmem.c                                |   5 +-
> >>>   tests/functional/x86_64/meson.build             |   2 +
> >>>   tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
> >>>   tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
> >>>   tests/unit/meson.build                          |   1 +
> >>>   tests/unit/test-cpr.c                           |  98 +++++++
> >>>   24 files changed, 1084 insertions(+), 81 deletions(-)
> >>> ---
> >>> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> >>> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
> >>>
> >>> Best regards,
> >>> --
> >>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>>
> >>
> >> Friendly ping
> >
> > Ping
>
> I wrote at v3 that I am fine with these patches CPR-wise,
> so if/once vsock maintainers are okay with them too it's

For vhost and vsock, IIRC I acked most of the patches, but TBH I lost
track, so if something is missing, please let me know.

Last time I took a look, it was in good shape, so it can go for me.

Thanks,
Stefano

> only a question of which tree this should get into: vhost,
> migration or CPR?
>
> Thanks,
> Maciej
>
>


