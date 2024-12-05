Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FFFE77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGyQ-0003F1-Ed; Thu, 05 Dec 2024 13:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJGyO-0003Ei-Cb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJGyM-000181-SS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733424789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=es3XBObQHiGtgZBVTVbSw3WDegXk2q8ebNuAwrDJ0N0=;
 b=MeNTp9mbIgOLmcPpmt+YBwQWijiuJZyVzvxVBomBTOXHntdJdSZi0WXDMsNXwfjE79/xPo
 iyJaoXz8fb2iEQEhBvS/Y34I6HX3EHFbsWSJtALl+DleKI+li4c7DeTG5vSJdbRbXP7kYl
 oiE/HZYDcd/gq/ZJXtHbS+UCzgMZpkc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-8Ql7xzLlNYyjDKAQxVRV6A-1; Thu, 05 Dec 2024 13:53:08 -0500
X-MC-Unique: 8Ql7xzLlNYyjDKAQxVRV6A-1
X-Mimecast-MFC-AGG-ID: 8Ql7xzLlNYyjDKAQxVRV6A
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8866dc8d3so35090706d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733424787; x=1734029587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=es3XBObQHiGtgZBVTVbSw3WDegXk2q8ebNuAwrDJ0N0=;
 b=cZ9l6Qg3CvmwBZ/8bqGu2J1ptNBxEgEoLJGrf5m3tAd0x8lmV7WTk9mGTEc4Opfslm
 Qg6V9org7+VjL4yh4gvg/Ixj6MEu3D4fdlIGZ9Sj6OMIl/RPY3B5ao/unvT2weW+7HU+
 pzruoFZEQKJfCr/2R+/SC2LHr7CZqSu0JeuzpVLYzDum4daEvhJP+BsW6PZ4OY0VnWlZ
 rLXn7dFDn/h4xGuIk1ioP5j7xFUGAFjNLzSppE21l3pOzy0YTH1VlV4UHIJyVlneZRml
 n8dKXZXiEHH1M4kE8aZHYyuMxNLe1L0WlasL0W4yKK8GX7ozPIM8VWc/9BM8pgmCPixK
 f0PQ==
X-Gm-Message-State: AOJu0Ywm6GFriUZHAvfbaswd0L7Udm/nPuhdnQFqrAYJmN76qWJPqMg6
 2AVoXJss/8Sq0chuU3yt5/8GXbc9XNML8/Ati/eTChQlY3n9zluCWHyBhjwnB+WhpEn4aVlYrmD
 TtZmTkgWuyDNARWjfX/q/6bvcqjIrd/uhpPUjJW737+qm7LTMtbS9eG6S8mxYR0S+XsXbBkycfX
 jxL3pyA9LtmOApelkustMseuv5G0V1tiBnbg==
X-Gm-Gg: ASbGncvIiGEeqquWOzwttpSaf2YNqCg6oi8E9ZswxZmhg0tH6G1Cb+oCa0R2mOt8WcT
 3oy1ba1Nbi7ciZhd91dSKQMk+PS5MXqiB8Ig8cHDIH6ahtEP+t3LuTdGyYnNbMEYa3926dCYz7R
 FAVHKCNtUSTbcou3o7UV6/Y9dNRgB/ql1PZQbAfqFL5S9lXRn9Fs66xij6hxVbWUOieisBW4ZUO
 FN6dkDZt2n+9o4HhvbSpJJ1tgmMx1jUfsl7WgZ+Nr+D5nqDiGkEattBaY3W1AhOftaeUmqek3Mw
 Q2GiVqa8QWK9gu7cz9I6taJGyw==
X-Received: by 2002:a05:620a:472c:b0:7b6:6a3b:53af with SMTP id
 af79cd13be357-7b6bcad37a1mr46468685a.14.1733424787206; 
 Thu, 05 Dec 2024 10:53:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHthN2iKmmfyMVYa4h2ruHmGGxkxJ9nIWlyXGiSc6XByyTY4KhymJr8CKdRhJozmqjnQy4pLw==
X-Received: by 2002:a05:620a:472c:b0:7b6:6a3b:53af with SMTP id
 af79cd13be357-7b6bcad37a1mr46465485a.14.1733424786861; 
 Thu, 05 Dec 2024 10:53:06 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a841b8sm86150485a.87.2024.12.05.10.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 10:53:06 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/2] migration/multifd: Further remove the SYNC on complete
Date: Thu,  5 Dec 2024 13:53:02 -0500
Message-ID: <20241205185303.897010-2-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205185303.897010-1-peterx@redhat.com>
References: <20241205185303.897010-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
complete()") removed the FLUSH operation on complete() which should avoid
one global sync on destination side, because it's not needed.

However that commit overlooked multifd_ram_flush_and_sync() part of things,
as that's always used together with the FLUSH message on the main channel.

For very old binaries (multifd_flush_after_each_section==true), that's
still needed because each EOS received on destination will enforce
all-channel sync once.

For new binaries (multifd_flush_after_each_section==false), the flush and
sync shouldn't be needed just like the FLUSH, with the same reasoning.

Currently, on new binaries we'll still send SYNC messages on multifd
channels, even if FLUSH is omitted at the end.  It'll make all recv threads
hang at SYNC message.

Multifd is still all working fine because luckily recv side cleanup
code (mostly multifd_recv_sync_main()) is smart enough to make sure even if
recv threads are stuck at SYNC it'll get kicked out.  And since this is the
completion phase of migration, nothing else will be sent after the SYNCs.

This may be needed for VFIO in the future because VFIO can have data to
push after ram_save_complete(), hence we don't want the recv thread to be
stuck in SYNC message. Remove this limitation will make src even slightly
faster too to avoid some more code.

Stable branches do not need this patch, as no real bug I can think of that
will go wrong there.. so not attaching Fixes to be clear on the backport
not needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..7284c34bd8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_ram_flush_and_sync();
-    if (ret < 0) {
-        return ret;
+    if (migrate_multifd() &&
+        migrate_multifd_flush_after_each_section()) {
+        /*
+         * Only the old dest QEMU will need this sync, because each EOS
+         * will require one SYNC message on each channel.
+         */
+        ret = multifd_ram_flush_and_sync();
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     if (migrate_mapped_ram()) {
-- 
2.47.0


