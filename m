Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C092CC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSc-0007mZ-Bh; Fri, 02 May 2025 12:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSZ-0007lf-Qv
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSY-0006SV-7z
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A91K2f2iEcFS5/0lCkwRRzKMl7iUbP8Kzhy9MSsjHe0=;
 b=aZ5Hw3NQS3QyNWUFedF++b7tcgi4y5usCG0IZYhm+jyCYK0Tr3ufue8tfqsXIQdVZNNPQZ
 Hy9rkirmP/2i6aWesZg+remo+hAF7PDoPhXAxulg1QpNhXfDoEqe+8SUtKD6pV8M3Q4OuG
 JiGFFrh4c2xwatuXnV8KNQdYMdshyIY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-KXbdbyu2MaeOIb_9feuGFQ-1; Fri, 02 May 2025 12:41:56 -0400
X-MC-Unique: KXbdbyu2MaeOIb_9feuGFQ-1
X-Mimecast-MFC-AGG-ID: KXbdbyu2MaeOIb_9feuGFQ_1746204116
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c0a3ff7e81so395722385a.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204115; x=1746808915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A91K2f2iEcFS5/0lCkwRRzKMl7iUbP8Kzhy9MSsjHe0=;
 b=aFJlo/PcUqEbclYrP7ot4E8CM4G2Nw1XPRAE2x+p1t9CzOZ4oNtEkAuW7KmBeHB3sV
 LXTk6037sx5ehO2G5Mo0umGjk2dkgzt/j0m8AoCO7fLe4V9lGU56I5Cnslt5eaz+BMKh
 5t8IZo2a+SUQVZMvT+1KsAt2Ad/guRrf1W9ZOH9Cdrir7yp3M0nhSV+qcKTTjUc2e5jn
 1Kt2MsjDnH17zU05z/NyDoY4KbKb6K5mUYnWl5LDOBitfoHqHQ+DdQMcEEW2W4u51WYl
 4slwMFU2lrSipV32Gs1VOgnYZyMSwuw6/fo92AxTYDmhzThIbRvl3Gx5AkNCDoBq6Ui3
 239g==
X-Gm-Message-State: AOJu0YwhIv8q/8bB8Xxe6y92j+Rxo2AOg1YTNGOmX9yj7tztHEmVB936
 xd38Tfof6j8OprfNEN0cXCneJa2JuGYxGBrzbcBAhzyCwugLEduUE467s1CwJQ1V7S813jzRVot
 mvgnbLLHe7elURQsm55DxJV+CJnvyu4NtI1PLU0KBPc0hE1D//HGk1DSchDHwA4P3GnG94GJltj
 YmRHBlQ3YN4IPVhNrd3eSIQAleu3imx+T4Tw==
X-Gm-Gg: ASbGncvh2Bci29RKjFTpFkEh/1L3C8Ko7uBeTfTsZ3fw4Ny+eQuzEaLSYWI0zGIwJIM
 43AO1iQRHoyb3VUHsyZ6VgPpZIKnytA7AOVSb7fnB8k+h6B6VheFmAEA+b5Av4W5cSZIGTHphJt
 vtbQYPbafx5BDSY4Q9xD6hygefD4DRTZIzejZEUjTZ77AO8lE3SAYNeMkyFHlJTUr0d9ELfJb8G
 z2OQYrIgNe4dErGWhhl1bMzorMpHIWHcDpqncTwsjFOPbolbBP6lfhQPMV458SeKLZAB34Mwb5t
X-Received: by 2002:a05:620a:4414:b0:7c9:253d:f226 with SMTP id
 af79cd13be357-7cad5bb7addmr518421885a.51.1746204115443; 
 Fri, 02 May 2025 09:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy0By6NYhfxhE4SizeIlhGDnryvdseEzbnAy9Cu+7NL8RfFPfLMpwGjKsefrnoOa+2SHMg+w==
X-Received: by 2002:a05:620a:4414:b0:7c9:253d:f226 with SMTP id
 af79cd13be357-7cad5bb7addmr518418185a.51.1746204115122; 
 Fri, 02 May 2025 09:41:55 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 07/14] migration/multifd: move macros to multifd header
Date: Fri,  2 May 2025 12:41:34 -0400
Message-ID: <20250502164141.747202-8-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Move MULTIFD_ macros to the header file so that
they are accessible from other source files.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20250411114534.3370816-2-ppandit@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.h | 5 +++++
 migration/multifd.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 2d337e7b3b..9b6d81e7ed 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -49,6 +49,11 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
 bool multifd_recv(void);
 MultiFDRecvData *multifd_get_recv_data(void);
 
+/* Multiple fd's */
+
+#define MULTIFD_MAGIC 0x11223344U
+#define MULTIFD_VERSION 1
+
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
 
diff --git a/migration/multifd.c b/migration/multifd.c
index 86c83e43c0..ec108af624 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -36,11 +36,6 @@
 #include "io/channel-socket.h"
 #include "yank_functions.h"
 
-/* Multiple fd's */
-
-#define MULTIFD_MAGIC 0x11223344U
-#define MULTIFD_VERSION 1
-
 typedef struct {
     uint32_t magic;
     uint32_t version;
-- 
2.48.1


