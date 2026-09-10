Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961F3C88E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oWY-0003Tt-B3; Thu, 10 Sep 2026 19:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lU1-0005wx-4N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lTg-0002Xc-Ok
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kbCiydol7NCeGRxJ9uKdT9EoWt9Zlq2cgE3irIl6fTc=;
 b=KEyP1gGR8pMMkim5ufttuuGtBK6hdjB5p349lj2ZtWo4yKMYVHpD1uHYsLzc6C0LLJh7NK
 ezo/pisMPaWpOeKgMn3+NR2iF6Dsc0iaZKkGgEkw8LzSnB7F9Vzts/r1NUyq8ANAnQK70B
 KksUu/yS38ORKvC3KxtoCec5XJHUp4s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-h4kDUhucOJuC9fr5p3a59A-1; Thu, 10 Sep 2026 16:11:45 -0400
X-MC-Unique: h4kDUhucOJuC9fr5p3a59A-1
X-Mimecast-MFC-AGG-ID: h4kDUhucOJuC9fr5p3a59A_1789071104
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486e9338393so71210f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071104; x=1789675904; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kbCiydol7NCeGRxJ9uKdT9EoWt9Zlq2cgE3irIl6fTc=;
 b=QOzfpYUH4/7xyl7cM6sTuYyATBwuNj7DIszSpYCAeEh+nPwTlaD+yDUiYWKusmDy88
 F832PXCBNeEM4wyxVXL6pVa3dNCmgwfL/4BednPvfl5Ypc572ojA2XiBmz5d+Wxoq+w8
 NQOXFSCLdSmDWyoD0FujrtxPsa7Xn27vv76bj1OGKI0q+W3dJVcxVqia+PmxvnKKhD8c
 A9uytypb+tRP550PuDrUyeF2t0brIjQdiEnCgr/ObtjtkREBUw4fkFn9+dPAFkNSVgg1
 oMzqKo6tcyQ5k2LO4TgqH/LMSx6NMOAreD/eF7MDdatmPw4Y2JFOMK1QdQ+qRnA4btIo
 WSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071104; x=1789675904;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kbCiydol7NCeGRxJ9uKdT9EoWt9Zlq2cgE3irIl6fTc=;
 b=RxI5hH09ATVJMTU6xljw1G/kV2/wXFeuy+W09PLvEeqiLbx972aER829MmIQlkedTP
 /FFjvPl76Gu1VmuOWCVeSHr4jwF0LD82LA06jo3qcnfgoJo6OrewPwW05kW02PwP5uEl
 vUCU8eHUlP0eEOliIsAnRhZIwjfGXN4vP7ZIOf+M4dddUilGdpejeYMmMVonoCYKOo/3
 2gE/omGQM0b0dG45fc5jGWOnYHW9hDH7tukmHzm7yaEpLpSEcNBOJICYpUy9ofANyVjk
 RdlBUeUlNd1lXO2LrRHyLlR5R3iCaEvzVdNECjrQJ0KMZTz0fdZ9PA7RGI5bCkuEypRt
 4DBQ==
X-Gm-Message-State: AFuF++nR2qCsp7b8J59OjKMzsNQ4EFd570EHlImQIH+vVLuiZ3w5q6XV
 bOeKbPBX/u83mXwOTBJUTqBi9tuXhHlhQIxTccqrhYpwZZAMO0wDEVJEHIbbc/6+4O3CeKl87hr
 U7RSUYKfO00lAbOGmQjfKvB9Hsav5Bag2aloCy3CfXq3nnu7m3SfF/criI2Ra6+McmPz9FkP/OY
 yWuhRxUf98UkssM7e/a9ia6YTX/YVUqqXPZw==
X-Gm-Gg: AYBFou13GaQm9cQ120+DeKvrK0QcpV4DhdMuzPTb5/H0BHu/b0gRILesA27MpD0gwEo
 biBhSYwY9kaNQAYg/tNhsE9RJpZ4QkhmkuMI46aEDU7ko5eo0saXQlUCey9g+oRvpZyvND7HEGz
 Hj81RxcKNumIPL9c+moV1O8RfSxGYElt1jd4EHvmscL4fJqvDVb+d9hWQHhPqBM9glgqquveJeY
 wO0EGhRMEPyhFc31O7h3G3aKS25Z5Wf4N0g4iWqcwWxMN5P0eUfpsxijeYV47cx1fzOmdjmaOKN
 AM/5i3v6WfTMOuGjFi0+ot/hjzf6/txGnk3LBNGYMHTPcKkoyMWd+xXZyiKniO6fK79DJZ4l6Mg
 I9cZ1CErl9juVnAJyriktJ7U=
X-Received: by 2002:a05:6000:240a:b0:485:ac96:724b with SMTP id
 ffacd0b85a97d-486eb2d9756mr789558f8f.7.1789071103964; 
 Thu, 10 Sep 2026 13:11:43 -0700 (PDT)
X-Received: by 2002:a05:6000:240a:b0:485:ac96:724b with SMTP id
 ffacd0b85a97d-486eb2d9756mr789503f8f.7.1789071103155; 
 Thu, 10 Sep 2026 13:11:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm792448f8f.37.2026.09.10.13.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:42 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 08/90] vhost-vsock: fix FD leak in realize()
Message-ID: <c68e619fb38d69bebf8931213fbbb8ad361d8e45.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-5-andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc..3ec20d8760 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);
-- 
MST


