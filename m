Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD16CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 22:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvkAF-0007kt-Pt; Mon, 08 Sep 2025 18:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvkA9-0007k2-FX
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 18:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvkA6-000544-Gy
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 18:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757369791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8ipzIXyok96cPQ5Am3yrWX33eT+xQUHvr5CxS60CwM=;
 b=Z+zH/mQOmbtIXudhU6cGv7vKdbq112b5W+KzDPXxRnC12AjY32PSAHh7pv4AktDgBP1U7G
 m8mqp1K73KQSQF3+Dk+3kK4l3cZDwnaUBGrIwyEBsBmP4/aSsY65xAw+EevQGYtsmJ56ky
 TA/gZC04cWPYYafJYok300UGSQojApU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-oGDAW4tvPYOEMavaobtItg-1; Mon, 08 Sep 2025 18:16:30 -0400
X-MC-Unique: oGDAW4tvPYOEMavaobtItg-1
X-Mimecast-MFC-AGG-ID: oGDAW4tvPYOEMavaobtItg_1757369789
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-72023d1be83so173761166d6.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 15:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757369789; x=1757974589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8ipzIXyok96cPQ5Am3yrWX33eT+xQUHvr5CxS60CwM=;
 b=anag/f6IN2VkX6rL4xDqGzwmH5wTQiGP/IimDZ1E1ejzLfZAncUMXj4Mh54RLpdJF8
 72xZU/YCcfnlayQ8w4V81LLjChSoYKQjeWT6nt9IGbHX5lSZSl91TQH59Gm6ZpPawKXo
 aZS7Zr/Xyc764l8o0ISykSLp7MXhYBMCeucKaI4uyc4ltMvaUcjUfeG6dqhXEndOJ1sn
 inm6Mdllpc+BL6Mb0zmkKfCqQb5rHvM9Av0eHD2EnY9impMXrLJ/RYmr+znaxCnOz6m3
 06ChUT+EuxLSeQ4UXlYzURJ0DjfW0MxgI8PdAo/WMZ8yhEix0MbI1wIyJv3L7K2iLxBi
 buuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRQSGSoDXVN/kGpmzxACGTDg5wYaaV8gp3c2jQ0VlFjt36+VjsP6tSHSfR36dKzfFcTOeQzr7TEARK@nongnu.org
X-Gm-Message-State: AOJu0YwXlAMGPaU3tFlmglqC+axHetKwQGoUN2t1fKs2BL4y8cqrzXw9
 ITTGYmjhTsqm8iBRKjO3HPAM5+M8TXISnm7GPbC6hR5+Ke7w0R8O46wjQGHoP2UOU9Pfsl/BqT2
 o1TXI2YZjQF0BnzNW9WGWt01yHE7PJGs0CqPGoczcddtcuj5X9hLn68tz
X-Gm-Gg: ASbGncukBoVDSzPLwC6zuquZsICDG1qlJ5PBA2vmti5g5P98gvIOh20FlkM7i8mF50E
 A0a/1G0SgKhx9Fzs9GxZhgFO9mTCnuQBA0sRLu+W1gaKdOZmpknFHxeTYWsE8QDBlajMqCJ70Xh
 4/raYezkrTbV0avjManODUb2Lfv0I4ibNVZ5sCMWPuouGLjy6HSVlcxBcVGFhv4FvDb2Z+8dsvY
 yQ/vk35hLpCvD9Pp71+zPWRrJXI2TY4/r7SpiWHpWGFj32XRp5AQ7HDAzeIasVUCSEja+cg+Ssm
 GyKdkXU9owu2LjOSr+rn2u77GmYns83HsKHDBGGxAMKPEvWqVTj9DOGKVhh3yQU5XJjwlNyRVKC
 asUk4rKNY7VyL5NZy9Z2wnQ==
X-Received: by 2002:a05:6214:252c:b0:70f:9f02:ff38 with SMTP id
 6a1803df08f44-73924e24dffmr115676186d6.18.1757369789295; 
 Mon, 08 Sep 2025 15:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQwC2ZvwnvoB7bOO5AfmgbYEyvIiXxB3dhW2cMESvT17YuXNTBd6MGirpkvZXKmMbTEa3Syw==
X-Received: by 2002:a05:6214:252c:b0:70f:9f02:ff38 with SMTP id
 6a1803df08f44-73924e24dffmr115675836d6.18.1757369788802; 
 Mon, 08 Sep 2025 15:16:28 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-756c9af8170sm135556d6.64.2025.09.08.15.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 15:16:28 -0700 (PDT)
Date: Mon, 8 Sep 2025 18:16:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
Message-ID: <aL9Vuohpnyn8IcsI@x1.local>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-5-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 12:44:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Use common qemu_set_blocking() instead.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Posix's qemu_socket_set_nonblock() asserts the retval.. While Windows's one
doesn't.  IIUC that's the only reason you provided the generic error
path in all callers, just in case some of them might fail on Windows?

I wished Windows's one has an assertion from the start too.  Maybe none of
the failure path would really trigger.. Not a big deal:

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick below:

> ---
>  contrib/ivshmem-server/ivshmem-server.c |  5 ++++-
>  hw/hyperv/syndbg.c                      |  4 +++-
>  hw/virtio/vhost-user.c                  |  5 ++++-
>  include/qemu/sockets.h                  |  1 -
>  io/channel-socket.c                     |  7 +++----
>  net/dgram.c                             | 16 +++++++++++++---
>  net/l2tpv3.c                            |  5 +++--
>  net/socket.c                            | 20 ++++++++++++++++----
>  qga/channel-posix.c                     |  7 ++++++-
>  tests/unit/socket-helpers.c             |  5 ++++-
>  tests/unit/test-crypto-tlssession.c     |  8 ++++----
>  util/oslib-posix.c                      |  7 -------
>  util/oslib-win32.c                      |  5 -----
>  util/vhost-user-server.c                |  4 ++--
>  14 files changed, 62 insertions(+), 37 deletions(-)
> 
> diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
> index 2f3c7320a6..9ccd436ee4 100644
> --- a/contrib/ivshmem-server/ivshmem-server.c
> +++ b/contrib/ivshmem-server/ivshmem-server.c
> @@ -146,7 +146,10 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
>          return -1;
>      }
>  
> -    qemu_socket_set_nonblock(newfd);
> +    if (!qemu_set_blocking(newfd, false, NULL)) {

Better if with a IVSHMEM_SERVER_DEBUG(), which follows the original lines.

> +        close(newfd);
> +        return -1;
> +    }
>      IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
>  
>      /* allocate new structure for this peer */

-- 
Peter Xu


