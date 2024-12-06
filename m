Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301EEE7716E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 01:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJMgE-0003a6-Nw; Thu, 05 Dec 2024 19:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgD-0003ZC-5h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJMgB-0005ks-1K
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 19:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733446726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNEQZ+vPm4wSXR/zObKahxluS5nzwSvUVA2E+LmCCII=;
 b=ObLgKXlBCcauAmbFid098fLBTPLc98NoOFTnUVb7HgpmtJJM1dKeofkS26TbocgjtTX1pd
 tx/dZ3gedGWqlcVI0wRVHIdOWajL4GYUFnWZOt7/tPDW/n7VOynFICIc9AtY33qbnPdPbH
 U1flHyF5ffFkgtUBZbtpTrCgNH6Kspo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-RkZwR9mPMTOSVnF-Mnb7Uw-1; Thu, 05 Dec 2024 19:58:45 -0500
X-MC-Unique: RkZwR9mPMTOSVnF-Mnb7Uw-1
X-Mimecast-MFC-AGG-ID: RkZwR9mPMTOSVnF-Mnb7Uw
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-515cf20f2c7so376676e0c.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 16:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733446724; x=1734051524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNEQZ+vPm4wSXR/zObKahxluS5nzwSvUVA2E+LmCCII=;
 b=kzSemO+NoDlPzSJlVHz8oQcvNTm6DdKYOhLByR+LlpDUEKQBDj8DmzEGDPZTxjiNNh
 4AtsEn107FpF+mGY3qEf63MmdWlUbsWLxGyEZfAX7PfKH2b8y5XaU5aL0IQPmtbVo7Fb
 RfvRvnU2253dftvN3VTBVPQvVyIXyc2xaPy1Pg/aEYjY5n2HIWz+1lm05+lIk9d1FaRP
 lwNB18XoLa9OOA6Jy+qg4gJYlE9+qEiuhwoMygaFXffXO3SmbjSdsBdWJFjKW/p+/EeL
 itPz6zPDzDb0mqRwSyMoCNMdJX8LDl3Son3XkxkNyqGzW76fE7LPUJ+mZiaRj+o9MCl/
 ro4g==
X-Gm-Message-State: AOJu0Yzoud3N/ad/3Uq70Tan/V4R0FHm4UttfG7zAit9SCmlWrUCMH1Z
 W+xfvqjQvL4guJhzDiymt+cAcwrxFgiFkazH/w+uLqV7jUx3aO1qsfXdrDSGsYxEOZS2Bd025jD
 mKpLqB+RU0DWMAuuGEn0zNEi6VfPMktBO4ig91KoyvbQV2BV5ybBp4rSt9xlGKlLqPi0aGx0Pro
 g7ivVMvixOG5L93SOQH3Af02ZH7cT1tFw34g==
X-Gm-Gg: ASbGncu6Ull6mN2opODZg7i4r3p5B0yauOlziSM1LXpnhqjDXlA38qt1oACINrBnZXU
 uqDC8uf30Am/y+32BB1qD6ruPqU9VhbQUbWIy0r16v59yPl4KoX4VksUXmeLXAVC8BNkm5+Zqo0
 vbPrjyGbOJlbW3B20cGg6lPUAo7GcRwDrpDFHp1twJY9HQ5lmvO2V3yJVYoKouIOdGU1dFFl4OQ
 GpUheaUv/aoDl1G1m/Ulmt/wD4WFn2daeenY32alCRSi06rhKLuwRTVFTE2Rpo3qOTYNkMmSNCE
 5ewep+9JdSwAkEtWQrB8/2B2UA==
X-Received: by 2002:a05:6122:320b:b0:50d:83e1:94fb with SMTP id
 71dfb90a1353d-515fcb17e77mr2258133e0c.12.1733446724507; 
 Thu, 05 Dec 2024 16:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVeQ36fQkMVtmBstad6PzSsgH1UitLG9zUgtKUvTEJ/gJIZmBcg3Str9mpOaZcVRjl7pN6YA==
X-Received: by 2002:a05:6122:320b:b0:50d:83e1:94fb with SMTP id
 71dfb90a1353d-515fcb17e77mr2258098e0c.12.1733446724038; 
 Thu, 05 Dec 2024 16:58:44 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac016cbsm12635226d6.117.2024.12.05.16.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:58:43 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 3/7] migration/ram: Move RAM_SAVE_FLAG* into ram.h
Date: Thu,  5 Dec 2024 19:58:30 -0500
Message-ID: <20241206005834.1050905-4-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206005834.1050905-1-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
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

Firstly, we're going to use the multifd flag soon in multifd code, so ram.c
isn't gonna work.

Secondly, we have a separate RDMA flag dangling around, which is definitely
not obvious.  There's one comment that helps, but not too much.

We should just put it altogether, so nothing will get overlooked.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h  | 25 +++++++++++++++++++++++++
 migration/rdma.h |  7 -------
 migration/ram.c  | 21 ---------------------
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index 0d1981f888..cfdcccd266 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -33,6 +33,31 @@
 #include "exec/cpu-common.h"
 #include "io/channel.h"
 
+/*
+ * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
+ * worked for pages that were filled with the same char.  We switched
+ * it to only search for the zero value.  And to avoid confusion with
+ * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
+ *
+ * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
+ *
+ * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
+ */
+#define RAM_SAVE_FLAG_FULL     0x01
+#define RAM_SAVE_FLAG_ZERO     0x02
+#define RAM_SAVE_FLAG_MEM_SIZE 0x04
+#define RAM_SAVE_FLAG_PAGE     0x08
+#define RAM_SAVE_FLAG_EOS      0x10
+#define RAM_SAVE_FLAG_CONTINUE 0x20
+#define RAM_SAVE_FLAG_XBZRLE   0x40
+/*
+ * ONLY USED IN RDMA: Whenever this is found in the data stream, the flags
+ * will be passed to rdma functions in the incoming-migration side.
+ */
+#define RAM_SAVE_FLAG_HOOK     0x80
+#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
+/* We can't use any flag that is bigger than 0x200 */
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


