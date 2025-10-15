Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A1ECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xy8-0007S1-Fy; Wed, 15 Oct 2025 05:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v8xy6-0007Ri-IF
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:38:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v8xxv-0002M7-I9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:38:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so6658440f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760521111; x=1761125911; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MM/El5IIBUMqrW83Ypet7wgb+WSTHn/RnuHvXSALrUs=;
 b=ElZeQlOPM6VG/C5zVvs2Pg+e2ZODb28OqOUdNwYddlk/U97MndXnf8/MxJvx9NsHwz
 +b0Q0NuFtXL9T2SISWzjagLlIfB+6JdHiVvrOf+LzsaiNtmsC5/IQ5IU+zZuL5EpqXcP
 1Cm6nO2Mz/KiYpuZvlQz/s/7dHbX9/r+iZsZe1BBXHaWsPQE0+ZCQUm9zMAjZuMUlD9s
 kmdQsc+ZZ2N1r5Vt3DeeeGlS6VBtceJvX07LZXz3THLaz3G6tZP0htOwuma8LfcUAsR9
 WkCIjI2Vep+cqSPhkJAz9QlOBltTGf4BIPqmv6CSUqUIXxbqfXm2FKe+SLNgVtLyyFrw
 fAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760521111; x=1761125911;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MM/El5IIBUMqrW83Ypet7wgb+WSTHn/RnuHvXSALrUs=;
 b=kRMFINySO1ImDUVaQq/HEO4/WgRNC/78v1fv/jR3evLjPuluT3nmZCw3y0uh5j0l/s
 iXoQPNSrZDyXeji54u/zE25v1s5563Ft5mBHlBc4hXSM8DBGY0kPizgElEKv4bVTk3mH
 hbehzIlsgOC5733xu6xZKHFH5rVFgkJzGJPgYImXGO6f1rtYiSluigBLXX/6D7LxevjJ
 +03S4C7KWw4mkXeyTXBXZSGYp0kSgv0UQn+VzOaKK1jtzs8CzBMAJ+mOBCQeAvmKuWw8
 sXcPQyX2rkfKffR4Ok4agGDvucSCBeg4FXe+V6jjwXiwBJGa/kW9X1Jl1RHo4wBtCmCk
 SuIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp0k9Pf+YtH92HBEvT4wDMSmNgKyMx1iIJVql7DatN4V2D3rqGJN+odMzvSmi4M9vtz2JtRbuxBlxp@nongnu.org
X-Gm-Message-State: AOJu0YwaV6xFOznzBkXnOujEKWvdRz4uQpYXriBvjggu3HNxZt47H6cF
 XT9ZADZ6/b7TR697TSt0WUTvTNMecozsP+ioZBTNnpjco5XJtHbYGau3MoL1jv+KL04=
X-Gm-Gg: ASbGnctEg8ZfUirhtNnzwRIK+4ceeQyV/bTfo42g9BnTGqXsxoS/sc6gopgQEafByyv
 8ByTwO/kQFJCuvFxdN/huxkxxBrwCH8jXNO27cqNfHKwgaDZ51ozl4tj8mc9Nlsq4A56DZmV8Ak
 PeFm+m05Y0EjejHZL836t3WM4pFMITQOdxwTAADC8mZ+sOTxqWbE6tb1fFzfve2iDSyUx22cY2d
 Q/z1w62FpxLj3xhCa4lY5uTMgvvQGeYjFW2oVJWkLs/pJ8Mr3Brrp5V3gqmq4lXNS4FQ0w9hHqL
 4Ro/a1W1bZ6l0S8RnbiQkgakkt0Ut4pWHKCPkEHQL6HNnlq+nqHO+uNmm9zjUrBikjKnlzbG6Q+
 MQwtmYvvdSqkNj0JBu0g6WTkLqso8Dc+Llh1/nexIaIvURS4cU7p0u4Qjmpo9oUV1a0HWFfjWIV
 WFp0DtqYWb5iZs1d9lPnBRH7o1NQ==
X-Google-Smtp-Source: AGHT+IFVFeYT2IBZ7/Ptea4tmzAalfjoHK+FNQp9LADYwgnvtfNBBEFgLBPU1dWvfkwckbQjAflMww==
X-Received: by 2002:a05:6000:4014:b0:3e8:b4cb:c3a0 with SMTP id
 ffacd0b85a97d-42666ac4a18mr16291222f8f.8.1760521110580; 
 Wed, 15 Oct 2025 02:38:30 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-215-65.home.otenet.gr. [2.86.215.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c23a52sm17364535e9.12.2025.10.15.02.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:38:30 -0700 (PDT)
Date: Wed, 15 Oct 2025 12:29:59 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: stevensd@chromium.org, jasowang@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, hi@alyssa.is,
 Laurent Vivier <lvivier@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>, david@redhat.com,
 manos.pitsidianakis@linaro.org, Fabiano Rosas <farosas@suse.de>,
 Michael S. Tsirkin <mst@redhat.com>, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, slp@redhat.com, dbassey@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v9 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
User-Agent: meli/0.8.12
References: <20251015085930.1517330-1-aesteve@redhat.com>
 <20251015085930.1517330-4-aesteve@redhat.com>
In-Reply-To: <20251015085930.1517330-4-aesteve@redhat.com>
Message-ID: <t462s4.1g2keahxb4duv@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

On Wed, 15 Oct 2025 11:59, Albert Esteve <aesteve@redhat.com> wrote:
>Add SHMEM_MAP/_UNMAP request to the vhost-user
>spec documentation.
>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---

I found a minor typo (response inline) but otherwise LGTM

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> docs/interop/vhost-user.rst | 58 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 58 insertions(+)
>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index 436a94c0ee..dab9f3af42 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -350,6 +350,27 @@ Device state transfer parameters
>   In the future, additional phases might be added e.g. to allow
>   iterative migration while the device is running.
> 
>+MMAP request
>+^^^^^^^^^^^^
>+
>++-------+---------+-----------+------------+-----+-------+
>+| shmid | padding | fd_offset | shm_offset | len | flags |
>++-------+---------+-----------+------------+-----+-------+
>+
>+:shmid: a 8-bit shared memory region identifier
>+
>+:fd_offset: a 64-bit offset of this area from the start
>+            of the supplied file descriptor
>+
>+:shm_offset: a 64-bit offset from the start of the
>+             pointed shared memory region
>+
>+:len: a 64-bit size of the memory to map
>+
>+:flags: a 64-bit value:
>+  - 0: Pages are mapped read-only
>+  - 1: Pages are mapped read-write
>+
> C structure
> -----------
> 
>@@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>           VhostUserInflight inflight;
>           VhostUserShared object;
>           VhostUserTransferDeviceState transfer_state;
>+          VhostUserMMap mmap;
>       };
>   } QEMU_PACKED VhostUserMsg;
> 
>@@ -1057,6 +1079,7 @@ Protocol features
>   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>   #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
>+  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> 
> Front-end message types
> -----------------------
>@@ -1865,6 +1888,41 @@ is sent by the front-end.
>   when the operation is successful, or non-zero otherwise. Note that if the
>   operation fails, no fd is sent to the backend.
> 
>+``VHOST_USER_BACKEND_SHMEM_MAP``
>+  :id: 9
>+  :equivalent ioctl: N/A
>+  :request payload: fd and ``struct VhostUserMMap``
>+  :reply payload: N/A
>+
>+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
>+  successfully negotiated, this message can be submitted by the backends to
>+  advertise a new mapping to be made in a given VIRTIO Shared Memory Region.
>+  Upon receiving the message, the front-end will mmap the given fd into the
>+  VIRTIO Shared Memory Region with the requested ``shmid``.
>+  If``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and

Space missing after initial "If"

>+  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
>+  must respond with zero when operation is successfully completed,
>+  or non-zero otherwise.
>+
>+  Mapping over an already existing map is not allowed and requests shall fail.
>+  Therefore, the memory range in the request must correspond with a valid,
>+  free region of the VIRTIO Shared Memory Region. Also, note that mappings
>+  consume resources and that the request can fail when there are no 
>resources
>+  available.
>+
>+``VHOST_USER_BACKEND_SHMEM_UNMAP``
>+  :id: 10
>+  :equivalent ioctl: N/A
>+  :request payload: ``struct VhostUserMMap``
>+  :reply payload: N/A
>+
>+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
>+  successfully negotiated, this message can be submitted by the backends so
>+  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in the
>+  VIRTIO Shared Memory Region with the requested ``shmid``. Note that the
>+  given range shall correspond to the entirety of a valid mapped region.
>+  A reply is generated indicating whether unmapping succeeded.
>+
> .. _reply_ack:
> 
> VHOST_USER_PROTOCOL_F_REPLY_ACK
>-- 
>2.49.0
>

