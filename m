Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7074E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfj-0004Jf-Cb; Wed, 18 Feb 2026 08:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfa-000468-G2
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfO-0005hJ-V4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LiGqoSdYSKFAOkGzSKy1bBHdWLKT+JAo0Uk73BDkFRI=;
 b=SKb+jCPc6CFTYY2VKpp/N2K/KCAf7s24f8WjBcwjmS+RO1VcEuBiVj8giP0qDW8wcapfdh
 hNPbIeAO7UGFTg1dagWNJysyCTuFjUuDPRQzHfXxxvjdyPcdNTan8QPsIHFQbyhxMgicZv
 JUSfrniWWSR2U10EIk7aLkp0w41V7oM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-wrp-KNkgOli8WrcqDEXgtw-1; Wed, 18 Feb 2026 08:27:27 -0500
X-MC-Unique: wrp-KNkgOli8WrcqDEXgtw-1
X-Mimecast-MFC-AGG-ID: wrp-KNkgOli8WrcqDEXgtw_1771421247
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48372facfedso10050585e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421246; x=1772026046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiGqoSdYSKFAOkGzSKy1bBHdWLKT+JAo0Uk73BDkFRI=;
 b=pE3g0qySRdepVxULysg34YlAYSC8zYTT/nE2m4NQstoLNLNtr0nNHA9wykQjvKvifP
 3+djHMAHGMVq6gwoTXUl63+xuPh56SSicRZG04OnTzA9Rtc5/HJwDGbKL/yO9u1qF4Gz
 redYrcEGZro3qhAC+A7y2DBJhQ1bvFC8hqqbDTgbqaqBRj0XrfzqjSG30mvza/xJ6r7h
 QshzKRMfDYVWZvAmrKAqIL0DfT6BzbYn8LcTqjoXiHepzpG63Twbe6hd/NqWnDIQ0wH4
 0ih5Mhi+AhWlc2xtLDA1wNHE0qNNCqwZPjnHxQ67yNnUN0accwGRG64l4IvwngwGADiJ
 luWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421246; x=1772026046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LiGqoSdYSKFAOkGzSKy1bBHdWLKT+JAo0Uk73BDkFRI=;
 b=OCacfcwqCxif8KnguNkD6ik0w+GQ4KdJu9SI3EvE9kYuAzsM81MQzOeNZo9wySjwbc
 XIZW8yVzNtOrgaz9+FodeOzTWADyODI74hyQRWTO+xjpjuvle5gHo+8HiKThNeJsUw/n
 5l5h60rKp3orWfIF3UJ5I0HjdI9RHCkIekabSgBVXKK0tvCaxNywiV/o2E5bZX9raPuS
 n1pMLQEJD5WwExGb1sH7LyNEWoLynJNNASmUyxmeWhqwFhVPWp8CnM+uJD89aqbmz+EL
 CGILBVwde1kwe6H0qJHx4l9bkRmVrSveU2Sj4eme1gFRlfmvyfD4eZwxXHk0+OeLS8sH
 kg7w==
X-Gm-Message-State: AOJu0YzjHDMYpX2mr/xFUWLeCzo0MQ9MpvxvZ8hU41mTeoE6d1o/di8r
 VcZvpq0la4Q886tHUlSZd553LK8vrmnl6QgeCTEp5m/mACpuCtvDVXnEZtKvH6P5RGn4/Dsrq0v
 WzvIO9ctmUt4FhUGCZbL3VgiLOi9kkUydA14UPVz0hXdnm3302Oa/TCJO
X-Gm-Gg: AZuq6aIeBIkGxZeAAQKnRfy4bcjkrhJtnRw2Dz3tzimryP3tI+8mhOZRPRwN73G+yGA
 eszk0I+AIBimu5z5+cvl5jzUxNrt/jS3kKarYmCoFrzh94La5LJhbxg2aaIpuvD6uOPbzo//TW5
 XNiugI3EyM9JpMA5twolI8vXstCuy7RB9pZrVkaI2X2qFHFOTLPZHjKbgnTQ3yeCPA0Onn7oLtv
 TiPX3OhTNGTB8CO7I33Ipr2GnpDaf/ZyzCZEmrXFVqNusIZlNXUsUgOypS7g6RosgNyl+WmZRD4
 0O4GghYx9tlUDHDh1BiVknOi+FRCUhta5fzdWxB5yN3nQlZOaJ5zd/qjaq7Qv3+e2EVjLZSNVoQ
 TNoLQuaR6wdFioU5R3mlykgtquXYR/dMzjSjHKpCzQMZ74EsTFO8BPm5RSv0St6l0IAmfgX5SDN
 jCTUQT
X-Received: by 2002:a05:600c:22cc:b0:483:6cf0:5d8b with SMTP id
 5b1f17b1804b1-48398ca3d13mr23483285e9.9.1771421246452; 
 Wed, 18 Feb 2026 05:27:26 -0800 (PST)
X-Received: by 2002:a05:600c:22cc:b0:483:6cf0:5d8b with SMTP id
 5b1f17b1804b1-48398ca3d13mr23482835e9.9.1771421245863; 
 Wed, 18 Feb 2026 05:27:25 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dcfb28dsm544576195e9.11.2026.02.18.05.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:24 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 17/24] fuse: Reduce max read size
Date: Wed, 18 Feb 2026 14:26:26 +0100
Message-ID: <20260218132633.29748-18-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We are going to introduce parallel processing via coroutines, a maximum
read size of 64 MB may be problematic, allowing users of the export to
force us to allocate quite large amounts of memory with just a few
requests.

At least tone it down to 1 MB, which is still probably far more than
enough.  (Larger requests are split automatically by the FUSE kernel
driver anyway.)

(Yes, we inadvertently already had parallel request processing due to
nested polling before.  Better to fix this late than never.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c481fb72a2..8c5a1d397d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -45,7 +45,7 @@
 #endif
 
 /* Prevent overly long bounce buffer allocations */
-#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1024))
+#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 /* Small enough to fit in the request buffer */
 #define FUSE_MAX_WRITE_BYTES (64 * 1024)
 
-- 
2.53.0


