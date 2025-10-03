Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC3DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hug-0005Cl-3o; Fri, 03 Oct 2025 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hu5-0004sD-D8
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htY-0007g1-Fn
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HsiZUf2uNVaT0SkDMrPZ5jEh6VlZlFLTfAX8wGLb1k=;
 b=Be2CpGfK6qL2Ntvghzcxvuxi21lDryb63Rq45WbuGBU2JUjgQJEvzcb8QRrkXgrkUoryXn
 7gGvnFDzwUFY6yiDSDZuMSyUHIyeDN0caElnF5QY4R1KnnF5LuOSWEY+HPoS3Y5Ppikz3q
 Py6jLimdLrgcvnFCQP2Iw9ubApvlFyo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-yEUHG7QgM7yIgoGQ2VfB9A-1; Fri, 03 Oct 2025 11:40:26 -0400
X-MC-Unique: yEUHG7QgM7yIgoGQ2VfB9A-1
X-Mimecast-MFC-AGG-ID: yEUHG7QgM7yIgoGQ2VfB9A_1759506026
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-79390b83c48so49178936d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506026; x=1760110826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HsiZUf2uNVaT0SkDMrPZ5jEh6VlZlFLTfAX8wGLb1k=;
 b=dRamMqj1pZw+SYNTd3GPVq1Tv7FNGz90Xx1VPQKYWua9vWpcnmHlyktBv2LiOSAcgy
 blQAQSjBmQrHTirEUEoG+Gvav0Ksqo7aBVC9pumlhB1P+Wb8bsHLoy+xBNWmWyrSbqyi
 2aOu4h+jgEVkfozIEeCp5aPzUY/uHVZvb1cFxpUPRgHUIF0QUzogg0CZykZH3Vp5xGx8
 u9KmiKVhbz2su15p2UngQrDBiskWOD/4dXEcI9HwQzgZ82AouqOy/zUzdkYidQrlMKIs
 AiI6LdMLsRlbyuODmEANc4kDmCmI2jcN2ICFFDd9GyvEMUD0Se1OrIyGTwcdcdTMYxHj
 K5xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiHLxTOanDUID1C0BR9sxoWoRM0wCC7LdFbEvW34321cTKSFu9uzZN++6pSMKFNFscs20aA0x4DXiQ@nongnu.org
X-Gm-Message-State: AOJu0YxOHofXhALCtDMwetJ6qNg7ydzrjg+PR+qGMg6tAlK5SMAxGFO3
 d2ZTHm7dh7/RHnz5+Tdp2SgiDAjJ5mNcz7mX3KqWRGcb+86zPGagAwqSYbyAvQ8tFzuCjrh1DK5
 7UzMTvqm9nYZ6upBgID+t4TO57tmiuV9y/xbJVmUg6Ut3stXI93RIoSAPMRiGGAD2
X-Gm-Gg: ASbGncv2YS8/ipOCqI6lxU0qfLy1A4y8LS1/YoDz+OoohF1394zgUWNud+I8tEC0tRu
 RQmZZFlZfvpSFkkZApcoIqer1y+gMR2335JA7Rz3AIist3FaUTarRAzGfUTe0aaHEv5N/RbQl0O
 zQLHUlg5FvZNZwdU4Fm0JvijNaO+0Un5GpbGBJRHEu1zoddG1nlvR8qHD1LKyN/yBwNn18iAsZt
 1UeWb0kRzcc+hDdBBUjtpSvpZWDYQyriuXqW2cSe3z5lM//myyl7D2W9B11N7tDRSZSVYgoIfVx
 +x1rkRU0v5c+01deKURsIR7+XsIW58juaASiPw==
X-Received: by 2002:a05:6214:5186:b0:767:1821:d46c with SMTP id
 6a1803df08f44-879dc860af1mr46709406d6.50.1759506025554; 
 Fri, 03 Oct 2025 08:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5204SjdlXiYbm22dOzKsPdQhX0NyE+Gzw1U3UeS2wg4ovmy5HBgYbnxQN+hZMdszKGw+GnA==
X-Received: by 2002:a05:6214:5186:b0:767:1821:d46c with SMTP id
 6a1803df08f44-879dc860af1mr46708876d6.50.1759506024966; 
 Fri, 03 Oct 2025 08:40:24 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 22/45] migration: push Error **errp into
 loadvm_postcopy_handle_switchover_start()
Date: Fri,  3 Oct 2025 11:39:25 -0400
Message-ID: <20251003153948.1304776-23-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading code to report
error via Error objects instead of directly printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_switchover_start() must report
an error in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-22-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8937496d9f..34b7a28d38 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2534,7 +2534,7 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis,
     return ret;
 }
 
-static int loadvm_postcopy_handle_switchover_start(void)
+static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
 
@@ -2547,6 +2547,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
 
         ret = se->ops->switchover_start(se->opaque);
         if (ret < 0) {
+            error_setg(errp, "Switchover start failed: %d", ret);
             return ret;
         }
     }
@@ -2655,11 +2656,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
-        ret = loadvm_postcopy_handle_switchover_start();
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_switchover_start(errp);
     }
 
     return 0;
-- 
2.50.1


