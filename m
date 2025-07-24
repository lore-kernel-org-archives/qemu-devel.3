Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A48C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 14:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uewsk-00047a-Sp; Thu, 24 Jul 2025 10:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uewsj-00044e-1j
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uewsg-00039j-BE
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 10:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753367107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q2Wajd1NZzV/qH1M03PLApg56wAU20i9NKcr78qlEwU=;
 b=BR8vHcAPDhcfU1I7CnkLYIR9vGpoRJGzNV2HHzy0EnfPrD+J1YBA7irN7i7LV9f9j+oEUy
 luB9f7KOJ0zxb4W9VXwwV0mqMvcFdp+YA2q7fZY3edraXA89ukIBlGu5InNOuQQYssv3FK
 zME7MGmcU+s2EFguTRH7SlI+zgDaROU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-_8Ps2BW_MR-T13FDOCthMw-1; Thu, 24 Jul 2025 10:25:05 -0400
X-MC-Unique: _8Ps2BW_MR-T13FDOCthMw-1
X-Mimecast-MFC-AGG-ID: _8Ps2BW_MR-T13FDOCthMw_1753367105
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fb3bb94b5cso16586046d6.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 07:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753367105; x=1753971905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2Wajd1NZzV/qH1M03PLApg56wAU20i9NKcr78qlEwU=;
 b=sLpIJQ6hwDd6gtYKdQ7+Y+MNz/FxuGr4E2d8ghBXPVRW1hFwlxtCtwAw4TXob/X2d4
 H/Bxb3LhgWJ317JzkiQA9ygZqm9JG1FypLXi6cZgkmtUAY+i4LanIzeN0I7zELt4cqVa
 yQtqUnE5p82lS6bh3SFOs5lD5GMD34ehfryzhLJVzYN361KWdhtYd9rqrqUrdp+MMM1y
 G/y3iJ9tYbw9JOPz/OjsqRYrVYuk1O870ewzLYHSTZb8qfkoiTBBK9QviIKT0uj0kKwt
 twWd8lanOcc2gX9VM37B0yrNeiaRUnAybgfmX5APmmcWPhyDXED3BiOqxt0GnoftZsXY
 GiAg==
X-Gm-Message-State: AOJu0YyVwAZWt5Z7px9foycEL8b8bIM4s6jcbbzTdfA+ZgvrutVDMicN
 0Guu6jkSKALEbtr38WIcVrd4yMxmhXQGbQ324hGibYlRUuPHl1a2tSuv3JIbgLY6xk7jKipverZ
 8cAGturSR0/MUXXg4ry9PfHgjebw2n0Rv2FLdGzVWYY4TCKVwwbd/ZNHAAMp0I7ioMo4=
X-Gm-Gg: ASbGnctzGAFjtol9AOz+OqoXoPzeEwa7qjNsEm7cxKCUrNEvo3o92USt3fLXCZUeoFe
 J3PeTyFg8DN7PWdB0kiWTfVy7xIIvaOvMVx+ihCxh0Dil+QsQdcW4tBrmkvodkWGo2uWNrMdwxI
 V4vxgjQp4uHRMFuzKD/U75u8y+ji9jCAPGrHOan/0rQZlKLQM7MeLg31QaA4QjiFTqUbjJgv6Ls
 p1NOFsm+43Lh24+MbsioZOHhDxhliWkfWrM0vFm1PtaLqrZmHsQCuXUELW/8z13mgE6ehAgJQuo
 S/m28QA8O1GNl3ZVJ6xTefP8Mcw10loIGUWMR8Va5fvLj145543y4Xons02m/xVGjE/CffUNACW
 45yipY/aS7f0qip8=
X-Received: by 2002:a05:6214:c67:b0:6f5:40d5:e51 with SMTP id
 6a1803df08f44-707005136bbmr102476096d6.11.1753367104781; 
 Thu, 24 Jul 2025 07:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdg6c+a1zmPman/ztyXB9otN+aU6ytsDOiLectu6j4mORtxKg11XrNW/oTxq/hXzumTc0DfA==
X-Received: by 2002:a05:6214:c67:b0:6f5:40d5:e51 with SMTP id
 6a1803df08f44-707005136bbmr102475606d6.11.1753367104262; 
 Thu, 24 Jul 2025 07:25:04 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7070faec0aesm13797616d6.8.2025.07.24.07.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 07:25:03 -0700 (PDT)
Date: Thu, 24 Jul 2025 16:24:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] vhost: Do not abort on log-start error
Message-ID: <tjqbvfrpzqgp65ibiasyct7k2ibzkhdrlev4ov45i3xsaxox2g@wwojtijmv6hs>
References: <20250724125928.61045-1-hreitz@redhat.com>
 <20250724125928.61045-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250724125928.61045-2-hreitz@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jul 24, 2025 at 02:59:27PM +0200, Hanna Czenczek wrote:
>Commit 3688fec8923 ("memory: Add Error** argument to .log_global_start()
>handler") enabled vhost_log_global_start() to return a proper error, but
>did not change it to do so; instead, it still aborts the whole process
>on error.
>
>This crash can be reproduced by e.g. killing a virtiofsd daemon before
>initiating migration.  In such a case, qemu should not crash, but just
>make the attempted migration fail.
>
>Buglink: https://issues.redhat.com/browse/RHEL-94534
>Reported-by: Tingting Mao <timao@redhat.com>
>Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>---
> hw/virtio/vhost.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

IIUC we always had the problem, so it's not a regression, but should we 
queue the patch in stable as well?

Anyway, it LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index c30ea1156e..05ad5de629 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1110,7 +1110,8 @@ static bool vhost_log_global_start(MemoryListener *listener, Error **errp)
>
>     r = vhost_migration_log(listener, true);
>     if (r < 0) {
>-        abort();
>+        error_setg_errno(errp, -r, "vhost: Failed to start logging");
>+        return false;
>     }
>     return true;
> }
>-- 
>2.50.1
>


