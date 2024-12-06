Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF2E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 22:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJh7O-0004Md-NK; Fri, 06 Dec 2024 17:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7L-0004LS-JN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJh7J-0002Pv-HV
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 17:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733525288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgUFHeik5gquqKyjKvJG+2JHFRfxmB+aOMmFGA+h4cE=;
 b=Fa/qhzuNLc/Kk7u18TJByRodGPEH9dhGZCw4tdllh3vaME/VRC5wTCiAskBXI3/67Iym3T
 acoR+8FfFZalt0hRT1HPQzRHfwEbwMm/t2vCwf9zZn299O36Q4RADrQKU9A56swFk4ieU+
 XCr3I0h+iqEvAGJ27LuSu3en11tfxVo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-KvNb8RrmMPqJm0p0U_pBmg-1; Fri, 06 Dec 2024 17:48:07 -0500
X-MC-Unique: KvNb8RrmMPqJm0p0U_pBmg-1
X-Mimecast-MFC-AGG-ID: KvNb8RrmMPqJm0p0U_pBmg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-843e86e0b3fso431697139f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 14:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525286; x=1734130086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgUFHeik5gquqKyjKvJG+2JHFRfxmB+aOMmFGA+h4cE=;
 b=A8I6/zK0syGrrzTIQGQHQPTcc/2NZ2MWwwGQ3leGwTgxAANEi3EvlGT5v+9964Mwzl
 KPp8TIDYekOYiNaShW75y7FROfeDscBUxXt+HuuBeBVy9H/n+/thm1gc+qsejab2BMoP
 r9arGhZRRf8jzY2HnM1JYErbrUqZwq63sOPbuG3scPnkqMD8+R5CJGBlxf/a20KRWU9k
 ZgEby4EQv24iFv96ijdlaPUj6/NSANFr2cLtxh73/avSM8rhqt1Bq+VIRGUYoSpTpyaD
 +Ac3hNr07dOts0CDkQj+f4oAJnTPaXzYyfKT05jDM+tkWtbdRxzZz3zTdIufKL6n48CJ
 bbCg==
X-Gm-Message-State: AOJu0YytNPdcPETxSKId8RoKoOTiH8e8DAg9tFPeCfi16LlNjsk1exzZ
 xReSxZDQqh9JwuBgi6FyviytxfnETlqBi9oZCSw3WyG96cWZeu3k9jLzKISh3G8A+5EeJleyykH
 0ZCg2Ld765MFZeJ1i+akd6PGUnZvqIkWfND4r1RUNsf3cZzHLZC8R6piTM5VDYJJeeVEEe+9rhL
 6cHEMBqZlizSQt+bz5eqA4X8iEEk4E4zEkQg==
X-Gm-Gg: ASbGncuBvsWHrhyG3eFFBgwo8C0rsdX+hgV9IO/ePcfKYWH6Z5yItkqp5T5CcImbqJ8
 +vZ+sXC3dcernmC8LUqKHmZQpR9h13jyuHYOvdGjtN0sNRn43aktvcsMqDJulefNWhXfhrHK9v8
 oPI+lClkhteN9us+/8Mhf2PytVm6hAkGhxnmR3irU1sbNpOno7OHBt+ktdoBdeJP/79FCORTbgc
 dKocgrvcty5nGnJXsTzE8DQscNtT2zubVqMX/iKi51eVuX5Hypbpr3UUS6jSfqcaTvCOw0aima6
 BIUUR+j+lcLRr5b929TlQ98c2g==
X-Received: by 2002:a05:6602:3402:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-8447e296ad5mr543146539f.11.1733525286157; 
 Fri, 06 Dec 2024 14:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfo3cpBwgAKEnRhayyIIZVeYSRjfv5pXJbzMtI2PUa/TuuVYh68EXWqS+kAaWNLXuxmfy0Tw==
X-Received: by 2002:a05:6602:3402:b0:82c:e4e1:2e99 with SMTP id
 ca18e2360f4ac-8447e296ad5mr543144739f.11.1733525285771; 
 Fri, 06 Dec 2024 14:48:05 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a5bd28sm125601439f.38.2024.12.06.14.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:48:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 3/7] migration/ram: Move RAM_SAVE_FLAG* into ram.h
Date: Fri,  6 Dec 2024 17:47:51 -0500
Message-ID: <20241206224755.1108686-4-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206224755.1108686-1-peterx@redhat.com>
References: <20241206224755.1108686-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Firstly, we're going to use the multifd flag soon in multifd code, so ram.c
isn't gonna work.

Secondly, we have a separate RDMA flag dangling around, which is definitely
not obvious.  There's one comment that helps, but not too much.

Put all RAM save flags altogether, so nothing will get overlooked.

Add a section explain why we can't use bits over 0x200.

Remove RAM_SAVE_FLAG_FULL as it's already not used in QEMU, as the comment
explained.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h  | 28 ++++++++++++++++++++++++++++
 migration/rdma.h |  7 -------
 migration/ram.c  | 21 ---------------------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index 0d1981f888..921c39a2c5 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -33,6 +33,34 @@
 #include "exec/cpu-common.h"
 #include "io/channel.h"
 
+/*
+ * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
+ * worked for pages that were filled with the same char.  We switched
+ * it to only search for the zero value.  And to avoid confusion with
+ * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
+ *
+ * RAM_SAVE_FLAG_FULL (0x01) was obsoleted in 2009.
+ *
+ * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
+ *
+ * RAM_SAVE_FLAG_HOOK is only used in RDMA. Whenever this is found in the
+ * data stream, the flags will be passed to rdma functions in the
+ * incoming-migration side.
+ *
+ * We can't use any flag that is bigger than 0x200, because the flags are
+ * always assumed to be encoded in a ramblock address offset, which is
+ * multiple of PAGE_SIZE.  Here it means QEMU supports migration with any
+ * architecture that has PAGE_SIZE>=1K (0x400).
+ */
+#define RAM_SAVE_FLAG_ZERO                    0x002
+#define RAM_SAVE_FLAG_MEM_SIZE                0x004
+#define RAM_SAVE_FLAG_PAGE                    0x008
+#define RAM_SAVE_FLAG_EOS                     0x010
+#define RAM_SAVE_FLAG_CONTINUE                0x020
+#define RAM_SAVE_FLAG_XBZRLE                  0x040
+#define RAM_SAVE_FLAG_HOOK                    0x080
+#define RAM_SAVE_FLAG_MULTIFD_FLUSH           0x200
+
 extern XBZRLECacheStats xbzrle_counters;
 
 /* Should be holding either ram_list.mutex, or the RCU lock. */
diff --git a/migration/rdma.h b/migration/rdma.h
index a8d27f33b8..f55f28bbed 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -33,13 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-/*
- * Whenever this is found in the data stream, the flags
- * will be passed to rdma functions in the incoming-migration
- * side.
- */
-#define RAM_SAVE_FLAG_HOOK     0x80
-
 #define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
diff --git a/migration/ram.c b/migration/ram.c
index 7284c34bd8..44010ff325 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -71,27 +71,6 @@
 /***********************************************************/
 /* ram save/restore */
 
-/*
- * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
- * worked for pages that were filled with the same char.  We switched
- * it to only search for the zero value.  And to avoid confusion with
- * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
- *
- * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
- *
- * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
- */
-#define RAM_SAVE_FLAG_FULL     0x01
-#define RAM_SAVE_FLAG_ZERO     0x02
-#define RAM_SAVE_FLAG_MEM_SIZE 0x04
-#define RAM_SAVE_FLAG_PAGE     0x08
-#define RAM_SAVE_FLAG_EOS      0x10
-#define RAM_SAVE_FLAG_CONTINUE 0x20
-#define RAM_SAVE_FLAG_XBZRLE   0x40
-/* 0x80 is reserved in rdma.h for RAM_SAVE_FLAG_HOOK */
-#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
-/* We can't use any flag that is bigger than 0x200 */
-
 /*
  * mapped-ram migration supports O_DIRECT, so we need to make sure the
  * userspace buffer, the IO operation size and the file offset are
-- 
2.47.0


