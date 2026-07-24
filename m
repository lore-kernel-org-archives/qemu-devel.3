Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6832C53200
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFaQ-00071l-Qh; Fri, 24 Jul 2026 09:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFaK-0006rp-4C
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFaI-0003K0-L2
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7LhqzlhIkEc1PUvxOHl110NE+DRMQHiyuUIzTmvaxOQ=;
 b=LfcD0CSA0qQrXogdc1Dlf5lSKEme00O5AY4D1jfeDQcykKF1e/zkUNzEeuMVfh2M86lYVB
 RhWqYM1onQhP9ZgV9/XyKJ1oi6ErOu+dhF+rqJSWX72B6Y8sgNvl5nCzGO3IukqnwKd0/L
 g01ey2lSgYPacBb+wYOdEF4zdySzaU0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-K2x_5QsJMmWQR3u2thSXhg-1; Fri, 24 Jul 2026 09:05:00 -0400
X-MC-Unique: K2x_5QsJMmWQR3u2thSXhg-1
X-Mimecast-MFC-AGG-ID: K2x_5QsJMmWQR3u2thSXhg_1784898299
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso3064945e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898299; x=1785503099; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7LhqzlhIkEc1PUvxOHl110NE+DRMQHiyuUIzTmvaxOQ=;
 b=O3tgxWE1EVB7pnyX275Bk+khRg9Dzid///6bQi5SV4waR9UgtJMbKsvmNb5yYtoIqs
 80gmgYRzTgvowN502P0VBna4Q7gAWNZU6mFS4+dBc9xV3WSR40gehBTzegBr1cTwKXv3
 /Q+jxkTp73g9QsEiVbt2Pph0lWPH1FPsbjLBOPjNi9IsnLNT22fKb6JD7vHZVUIp7rxg
 WLLU+MRCrrn+IbEyAebu4uzMjsKpKDzCm+fOw/KvLL7Oze/UPIvNJq4IyXGyZD+g5S22
 ds9YFN2FmirzWUQQwjcov6FaU5j263prBulR6dU6s5qsYbsxvlNaB4CrebKYeCXwEIO/
 KC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898299; x=1785503099;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7LhqzlhIkEc1PUvxOHl110NE+DRMQHiyuUIzTmvaxOQ=;
 b=q87MLsP85YvM19uJlYChFqG2OXAigU1ggDS+YM+PRNxFsDXjJSO6xN+mB4fF1LXQ70
 ed7vubSWRUtCc7AvTTjYfFnq84NWNp0mUGmDXrz1dR7p7Y8sJKZuFLMVw94Pv0R8SfFb
 tr/Uw/BWVdb3U6WsUO0ZrsAq8+ZQ/Abz0ZJDj9gfOE7r195+TIV/gi5RVPBYqIJO0VUx
 tZaRNr89nYayr1wCdX5XRO1SFA8cxUxcyyj6aInvTzAOpojbZv07bref0wM29Y7q0Kfy
 Xb/gZkI1LJSJls813ipm+tPBy4Bfo8XvlMaY8oM0Qf9ZOmnEsuBj3z7Yif0rMizfwBh0
 k5MQ==
X-Gm-Message-State: AOJu0Yy9eFkZeRq+STXZT2viquMIpQSQfdsI1aJwTkCbuIIh0uxhLCz2
 KpwXjYqz2iBnUtqN0U38g211bs4GxZoqt6JLHMEIDkHdfB6S6BLaREOVg6OL9FGKBa/kA/A1TjQ
 OTtiEvM0PZlDaEQ1lavv4TCOQN6QUlGnbTJo0HhSJlLsuk65TBwLVkIZmquWYTJyaoAGJaNBtKK
 0Oh/xJabXNqVXXo6y2vY68gLhhSAZTkG5pWQ==
X-Gm-Gg: AR+sD12pnjMJ6rLf7avofa0exQLASOQN7WoAETxTjMZX++Yo0pZez8gEKJEoR34d0Jw
 R7ksI40ntdlBWb8ATWSeenjFln8D1qYxnY3dstzNWXY8yt+vBw/nfC0aadTuM2EW+rad/YHj/r/
 Cs6PcJ6ThfwsjbyG0ybQ3yYwLZSwdep2mbom4S4l9FRT0QTsV3E0O0gO7X6s7XhGRmRy8IV4pWP
 7pqrmXDFCd2N9ukjvruWV2f5lIxIXxpsfjFzDGHOHQSUiYsvCR57tMAkmxQWKIYCb+mcZkpWvws
 qGCpZYe0gb9Y8EVnKV6++vKR/dtnvERoe+P9WmNpQRn6K711uISyzetP1t5ozYV3Jp26wMmGduo
 xa4+fzHMTbtdrqnHoeHFWoA==
X-Received: by 2002:a05:600c:35d5:b0:493:c601:3e23 with SMTP id
 5b1f17b1804b1-49573c8c8c4mr77367795e9.5.1784898298643; 
 Fri, 24 Jul 2026 06:04:58 -0700 (PDT)
X-Received: by 2002:a05:600c:35d5:b0:493:c601:3e23 with SMTP id
 5b1f17b1804b1-49573c8c8c4mr77367325e9.5.1784898297973; 
 Fri, 24 Jul 2026 06:04:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af5d910sm71016705e9.3.2026.07.24.06.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:04:56 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 3/3] mptsas: do not crash QEMU on migration errors
Message-ID: <258d84f5af807e0103bf6f59165dd7450918e58c.1784898250.git.mst@redhat.com>
References: <3777347521a12252e228e4a6243c75250bf76626.1784898250.git.mst@redhat.com>
 <a0afc9ea82d68f3447c9f58d89c9b46fa074d6c3.1784898250.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0afc9ea82d68f3447c9f58d89c9b46fa074d6c3.1784898250.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

Currently mptsas asserts on invalid sg list count in the migration
stream.

Fail migration gracefully instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/mptsas.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 6da8a740f3..e8cbd5bc15 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -36,6 +36,8 @@
 #include "qapi/error.h"
 #include "mptsas.h"
 #include "migration/qemu-file-types.h"
+#include "migration/qemu-file.h"
+#include "qemu/error-report.h"
 #include "migration/vmstate.h"
 #include "mpi.h"
 
@@ -1241,12 +1243,13 @@ static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq)
     qemu_get_buffer(f, (unsigned char *)&req->scsi_io, sizeof(req->scsi_io));
 
     n = qemu_get_be32(f);
-    /* TODO: add a way for SCSIBusInfo's load_request to fail,
-     * and fail migration instead of asserting here.
-     * This is just one thing (there are probably more) that must be
-     * fixed before we can allow NDEBUG compilation.
-     */
-    assert(n >= 0);
+    if (n < 0) {
+        error_report("mptsas: invalid sg list count %d in migration stream",
+                     n);
+        qemu_file_set_error(f, -EINVAL);
+        g_free(req);
+        return NULL;
+    }
 
     pci_dma_sglist_init(&req->qsg, pci, n);
     for (i = 0; i < n; i++) {
-- 
MST


