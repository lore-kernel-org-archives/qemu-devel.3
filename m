Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4514C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXky-000896-7U; Fri, 20 Jun 2025 05:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1uSXko-00080n-6B
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1uSXkk-0005Jl-Ip
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750410579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=RyiulEU030/U1hDHCh+D3w7yCk1IRUDLH2brxnYKOHw=;
 b=E5dl77uFxLQKeCxngAPh+JNr3h6c9QFpR4NyculHHJYcZtFvpywGekyrSG40Df4+PjbN63
 zNOBGt6bOlDbTBSLqd8/WeuxUGSqjxlGebMHwnhPLzKtFhdMi4OGl9k54UDbsZk/wfSbvr
 cUGQUJIQWiy77TkBtwMREbxLAboN2mk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-N4qA-ub2M-qwdjFtPPv37A-1; Fri, 20 Jun 2025 05:08:29 -0400
X-MC-Unique: N4qA-ub2M-qwdjFtPPv37A-1
X-Mimecast-MFC-AGG-ID: N4qA-ub2M-qwdjFtPPv37A_1750410508
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-86d0aa2dc99so119629039f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 02:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750410508; x=1751015308;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RyiulEU030/U1hDHCh+D3w7yCk1IRUDLH2brxnYKOHw=;
 b=OhekYsR4+hCMB64S05QO+KMiWMuMAK6Foc7snxnvKGDZRl1iei6QNjy7KZrmLubKEe
 xieHi+weyrI17Ju3Z69TL7ctY5Nf3zO+hXhZTHH33iwgVY6aTrWn7onaVknssybQQeBI
 Otpq3mKFMpEL9+WQD+nLgnJ7vtv0YzbFATZrdYM8M3ds9fv72ZayxL2veUZfeFXKJ4zu
 JCR0dQdu+/MtGaqIH6jwk++80un2uIuNSkrcIZIGIvwrWFpYBTITk87dgzsOVYeqRrRZ
 IKAdmF1vU0agkZ5MxepqTnuobBjCHhtiXymh4FcXllUUi7zF2CP/xlcrOgeH8F3IpQyT
 WS9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpaznBSiYp3KTWFT4WQ0nlfs+/N9dVh56WUV3w2GHjWOi3lAY82W9EXVNBliJPjkzQjpPsqHmAYo9Z@nongnu.org
X-Gm-Message-State: AOJu0YzZ5+cnES2zQCzLdPajCbfk0qBHCyfK3vHoK5xqAiBHJ+UtO/Rh
 BtirEgifuobUkB5MR5dccsAjqbdMayI5Y1wzvdZRB5M3jAL3CCF0+NKMleAwD0+8PIXQbe5XkoD
 K1h3G5ksP4dzTcGB3SSnbz0ZWjTUzpA7CGTkaVq98PXhvEkuoHlv+QFqAF5JKX1JkiRt0cE0C3k
 /jxg4jYXmBQ8UAifYVG1JMZ8oiupYdqF8=
X-Gm-Gg: ASbGncuvOIN7Oe9MAeE2JKmwLh0/fCUnC3psjRdqYHzG5FjgXVmEtPC0bwjI3FqEuoT
 o3DgkvDr1Gmkx5BosRF6eBjUg0It5QdC0Lw0EicwufKBebu64+8WMc+WspLFka72Tm6yAlsUEpL
 9yeVYVJQ==
X-Received: by 2002:a05:6e02:1b07:b0:3dd:f745:1c1a with SMTP id
 e9e14a558f8ab-3de38c1572dmr22891205ab.4.1750410508174; 
 Fri, 20 Jun 2025 02:08:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU6T84jNqWkrf1eei4tSZnrvxw5oTQmgjlddM0b8LEGr0R2+vETz7ewW3eBpEoa/TBQBN62qTbut81cec6P2Q=
X-Received: by 2002:a05:6e02:1b07:b0:3dd:f745:1c1a with SMTP id
 e9e14a558f8ab-3de38c1572dmr22890995ab.4.1750410507891; Fri, 20 Jun 2025
 02:08:27 -0700 (PDT)
MIME-Version: 1.0
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 20 Jun 2025 11:08:17 +0200
X-Gm-Features: AX0GCFsR3k1SPdTNqZB_DkmAzt3kAKBYrGuWQUb6NfWXrIuByknzSsYEStLMdHw
Message-ID: <CACzuRyy7p6FPeu6qugzihecOE8ET-wA87+NTBGscdO4B=HLsrg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] vhost-user-devive: Add shmem BAR
To: Albert Esteve <aesteve@redhat.com>
Cc: alex.bennee@linaro.org, David Hildenbrand <david@redhat.com>, hi@alyssa.is,
 Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Albert,

Thank you for these patches, just a small issue you could add to your
next series.

>
> +
> +            memory_region_init(virtio_new_shmem_region(vdev, i)->mr,
> +                               OBJECT(vdev), "vub-shm-" + i,
> +                               memory_sizes[i]);

Here, `"vub-shm-" + i` looks like string concatenation but uses
pointer arithmetic,
which could cause a crash at runtime for e.g., when `i` is > 0. I
believe you can use
g_strdup_printf("vub-shm-%d", i) to fix this, it constructs a new
null-terminated
string like "vub-shm-0", "vub-shm-1", "vub-shm-2", etc. If that was
your intention.

BR,
Dorinda.


