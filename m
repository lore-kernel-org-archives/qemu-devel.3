Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7086EFCC9C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq6N-0002Jd-Ca; Tue, 10 Mar 2026 01:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5l-00013F-LP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5h-0006MU-60
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60UgrVo6Hzx9RlCFMM7bh5XcXcJpuiQZ08J0En/TgF8=;
 b=Jgw8jOV1kkLTtoQhb7ifSwXo2W+S4lSAmCzLKtg9KuLg8DvVdZQ6fTj0Ff4IZIREN+d6ui
 YHY+4eSzd1fZy0VedgpcXiU7GJ2Km56nS2EOcbsYfBwng9VIv2IixlJsri7U/4qDr0bPjA
 /WduVK7xqOLDezITx7WBmwJC5/CXJsc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-J0br5LovOdS__GafBgfu2Q-1; Tue,
 10 Mar 2026 01:57:06 -0400
X-MC-Unique: J0br5LovOdS__GafBgfu2Q-1
X-Mimecast-MFC-AGG-ID: J0br5LovOdS__GafBgfu2Q_1773122225
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4747918005B4; Tue, 10 Mar 2026 05:57:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABE2F1956095; Tue, 10 Mar 2026 05:57:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Farhan Ali <alifm@linux.ibm.com>
Subject: [PULL 24/25] pc-bios/s390-ccw: Fix compiler warning when compiling
 with DEBUG enabled
Date: Tue, 10 Mar 2026 06:55:29 +0100
Message-ID: <20260310055530.8893-25-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When compiling with DEBUG=1, there is currently a compiler warning:

 pc-bios/s390-ccw: Compiling main.o
 In file included from /home/thuth/devel/qemu/pc-bios/s390-ccw/main.c:14:
 In file included from /home/thuth/devel/qemu/pc-bios/s390-ccw/helper.h:16:
 /home/thuth/devel/qemu/pc-bios/s390-ccw/s390-ccw.h:122:31: warning: format specifies type
       'unsigned int' but the argument has type 'u64' (aka 'unsigned long long') [-Wformat]
   122 |     printf("%s 0x%X\n", desc, addr);
       |                  ~~           ^~~~
       |                  %llX
 1 warning generated.

Fix it by using the right format string here.

Message-ID: <20260306203645.28232-1-thuth@redhat.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/s390-ccw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index ccd68ff0a4b..1e1f71775ec 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -112,7 +112,7 @@ static inline void fill_hex_val(char *out, void *ptr, unsigned size)
 static inline void debug_print_int(const char *desc, u64 addr)
 {
 #ifdef DEBUG
-    printf("%s 0x%X\n", desc, addr);
+    printf("%s 0x%llx\n", desc, addr);
 #endif
 }
 
-- 
2.53.0


