Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A246FEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAU-000849-VZ; Wed, 04 Feb 2026 14:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAJ-0007WN-QL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAH-0007uc-Sm
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1eEfcRbtK2xlCfiX35UT2DVbhf1pwTVIcDLjUARGxQM=;
 b=YCf/BWIoElUWtMwnmdg9i3xcs3h5dS0riL/SYG/6AQi5i9P1T7tEoliNMYIVhmltiEzLa6
 jCyxHiAzy9sxvj47/7nDUFduz0qFcxf/+trb/TpCM8KUJifpw3P2rTin0ifkS3XYQHZduK
 nVuxmcfxCbqVcm6Yo9P8ks8pwoQ/wso=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28--qxdtjUqOCKEuWHiyj18fQ-1; Wed, 04 Feb 2026 14:03:47 -0500
X-MC-Unique: -qxdtjUqOCKEuWHiyj18fQ-1
X-Mimecast-MFC-AGG-ID: -qxdtjUqOCKEuWHiyj18fQ_1770231827
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-436164e7f42so188258f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231826; x=1770836626; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1eEfcRbtK2xlCfiX35UT2DVbhf1pwTVIcDLjUARGxQM=;
 b=sUio0CruBpA1z13Su8LVckuFGDdyWxtWq+45MnOwD3ykZjua6MLba9g5A9w+IsyWqt
 JklCMV6XYLHrS0sDIoG6ZL0JzxD5a7vi3zA6XpZ5ziIKAwUzKJKeYYtk3A0fG7QXdUSe
 +cExfHEHN/mQ2lm5WdgqSeVtvvOG+BChuMFR94BIDreIz2HPfcMFZVzsZXrqkY3R1Huw
 EfItmcn/nn6toGu3OyMBtoRPGj+XJ27rGhgIRcFp/Tpb+yHCcXYu9o5nM32PShNhndaK
 lZBjj4P+FMLDzQ4SGb6zP1jW4bUwDIW3+sMn95LmxZ5v0Rlwm8FPy9kUsGw9/YWhRYhp
 Zk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231826; x=1770836626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eEfcRbtK2xlCfiX35UT2DVbhf1pwTVIcDLjUARGxQM=;
 b=pYY0Uy/1YK40C7xBJQ7YNGIjQ64Je93Y0O1LNtQTSb2z/HmW0hY8rW8Pd1vjd1wcT+
 rMWz0P+RS0iXnSHRcW1VMsVhyxbWWOKOZcHXeNc+agLS79WRtf9282GmLUr0KsNrENX2
 QPZEQXgbxVgXIq8zVbImOqbHKxgQubgAhrlaiPIG4PJVP+D0QreCIXufp+28GK5qUjpy
 H+HFUDp6ktth2fThR0taBTIBwrp2RqsqsC6R5ro+eHdsAp7+brjBzu4zUbSKv6DOItcu
 NBLZcrHkbvEpwYoJqwqEMgnlcS8+Vzi3Fl/zkNDme2OABAjb7uCJ+FYQ0MvR4BM39bmT
 /g0A==
X-Gm-Message-State: AOJu0YzuHED+4yIhWwit5CWZ/H/f50C1o0P8oAFA6xRs0PRNtzY0NsSe
 iFxC8utUDIkHkv1sfqgn3GlNv6NH2NMtBoEAkRYRttvsi5K7mOU6OeLJ+AFJLxc0jdOrdwHzQcx
 dn2Q7HMKS7T3fm4i62NTipsbUanR3uAgr6sx1JmZ1Bi0fNJX8Spmr+ZU8Bf0UOZYd5jaq3hK8pK
 vltQVNroB0kyv/jzB/11Zhu8Y/tHMwRbZzFA==
X-Gm-Gg: AZuq6aLjXzNBKrj9h/CbyIQWNK3d59/TfOTdRhdWQ6n+tzDey3ZQQSSDnMGap1f7fab
 2/ukWtwwPnh02k5PlbBKraOEkskn6LRAQ88GPFMHPi1ohOGj03xy58Hv3WKFW1YLSi1temSvC0Z
 +xKhvVJIQvfY3IXlI8bNxxaA6SxLJFXB3uNFyN++O2ogs8D3DSZfcKfQB6oiBOObhfu7x3BbPmH
 Foro1pOtKHeBnTRrHhbGfoF9hTDJpxrfxYYqHvgO/Y/Xs+16CK+0yEqvVj2SuWFinsBnzutC+nW
 +eaqb0cxeo2ebF2eb8H8kx0Z4EQ8OvumRlUH+UYVdXaoJB144UgZm8RZzv1HiLPhDL9BUvw2WqM
 5NM/pZUQp+5FsADnxUGutJvrpMeTdwL5S2A==
X-Received: by 2002:a5d:64e6:0:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-436180551e9mr6170079f8f.33.1770231826191; 
 Wed, 04 Feb 2026 11:03:46 -0800 (PST)
X-Received: by 2002:a5d:64e6:0:b0:42f:b707:56dd with SMTP id
 ffacd0b85a97d-436180551e9mr6170025f8f.33.1770231825628; 
 Wed, 04 Feb 2026 11:03:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180659b8sm7888347f8f.43.2026.02.04.11.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:45 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 24/51] virtio/vhost: don't consider non-MAP_SHARED regions
 public
Message-ID: <158f8d3bb06f65cac00bccb681fbd145189a1211.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

Just having a file descriptor is not enough to consider a memory region
public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
writes to this region won't be visible to the vhost-user backend, thus
causing it to read all zeroes or garbage. Make sure we don't pass such
regions and include that to our definition of what a private region is.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Fixes: 552b25229c ("vhost: Rework memslot filtering and fix "used_memslot" tracking")
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 31e9704cdc..c6a5928cb1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -592,11 +592,13 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
         /*
          * Some backends (like vhost-user) can only handle memory regions
          * that have an fd (can be mapped into a different process). Filter
-         * the ones without an fd out, if requested.
-         *
-         * TODO: we might have to limit to MAP_SHARED as well.
+         * the ones without an fd out, if requested. Also make sure that
+         * this region is mapped as shared so that the vhost backend can
+         * observe modifications to this region, otherwise we consider it
+         * private.
          */
-        if (memory_region_get_fd(section->mr) < 0 &&
+        if ((memory_region_get_fd(section->mr) < 0 ||
+            !qemu_ram_is_shared(section->mr->ram_block)) &&
             dev->vhost_ops->vhost_backend_no_private_memslots &&
             dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
             trace_vhost_reject_section(mr->name, 2);
-- 
MST


