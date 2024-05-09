Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24181C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s579K-0002Ut-Lf; Thu, 09 May 2024 13:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s579E-0002Tt-9g
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s5799-0003d1-NW
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfwFcUpcowXHmSd2Ge81kDPkuiKnyaodHB6RPGeDEk8=;
 b=ZuvsuOH9DtLPvLZRzl7pNuBctAKNV0AsLYEjzVVMf67/FEQJmnEiS+0d4A2QK6n721S8Qr
 Nnl2qK5NdQuCIZsUVXYq8a8BiurzuTqgQpsGzqojKQHRR5ZxTR3U4cdTyEwaFdQYCtPLgr
 60xf99GlNNMPM9gh2pUvEBI5hIClTkc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-QEbgvFLNNCenoEE-bZjfbw-1; Thu, 09 May 2024 13:00:58 -0400
X-MC-Unique: QEbgvFLNNCenoEE-bZjfbw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso58964166b.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274056; x=1715878856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfwFcUpcowXHmSd2Ge81kDPkuiKnyaodHB6RPGeDEk8=;
 b=sGta77f6rwL5wt9/AYgjEFH1TkD6G0EB0deOEGltiW9cBqs1zjdDu8MOfLfpUobbPs
 YRv4y8GXkIDpUYKwNr0Aa0fRasxuJhlOC/v2QtxT/CSLUDzcaeCK9yd9EyJLnzOaaQCZ
 zfjdKNDaRe6fU3YKcJKWhX8VBg9Dsv6NWR7m9c8xVHlmh4ckKklZa3+tEo2lb8IgJlok
 XrNcEHR395MdD179VuxB2nPdXc2Ypz3+uIAf/jjVciLHVJ/GL9Dq2fopPunp+782xmCG
 LZnp3GQAUu3/K3Wds8Hea6T7H505kD0Tq1ztH+c0aSqf2ra6WAqDmYLFn98fiO8tu6zc
 Ia1g==
X-Gm-Message-State: AOJu0YzM5aQjAJ/B7xGjPiA9mnVqoZSeaM6zFdFhWunLmFTlo7n7jEqI
 hW+SSRt2OKtihANw7xZ3eChVts8E/oc1lVcCtJ+9tTXqdBCA08K0EXD7pzFnJ90/gal5exTsGHC
 GIjNNsHSARb1i++nn0NOQMvvCdC9Zii6i3N4MFHe9hXMNunmEZQjh4x+aEI9ggLTiSR917mWBo6
 rfpoJiOd37JOoUd6/9v1xCXJFZdff5xjNfa72O
X-Received: by 2002:a17:907:7da3:b0:a59:d063:f5f3 with SMTP id
 a640c23a62f3a-a5a2d673401mr16521966b.63.1715274056446; 
 Thu, 09 May 2024 10:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9LZyJu+Hm3YRCK3W7zrnGKvxq2cylzn9xsCzrd2jeQC1+YO5WhwNzZsClGWl6H0UwHXXAUw==
X-Received: by 2002:a17:907:7da3:b0:a59:d063:f5f3 with SMTP id
 a640c23a62f3a-a5a2d673401mr16520666b.63.1715274056114; 
 Thu, 09 May 2024 10:00:56 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7ebcsm91884466b.117.2024.05.09.10.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:00:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 05/13] tests/qtest: s390x: fix operation in a build without
 any boards or devices
Date: Thu,  9 May 2024 19:00:36 +0200
Message-ID: <20240509170044.190795-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Do the bare minimum to ensure that at least a vanilla
--without-default-devices build works for all targets except i386,
x86_64 and ppc64.  In particular this fixes s390x-softmmu; i386 and
x86_64 have about a dozen failing tests that do not pass -M and therefore
require a default machine type; ppc64 has the same issue, though only
with numa-test.

If we can for now ignore the cases where boards and devices are picked
by hand, drive_del-test however can be fixed easily; almost all tests
check for the virtio-blk or virtio-scsi device that they use, and are
already skipped.  Only one didn't get the memo; plus another one does
not need a machine at all and can be run with -M none.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/drive_del-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 8a6f3ac963d..7b67a4bbee4 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -173,7 +173,7 @@ static void test_drive_without_dev(void)
     QTestState *qts;
 
     /* Start with an empty drive */
-    qts = qtest_init("-drive if=none,id=drive0");
+    qts = qtest_init("-drive if=none,id=drive0 -M none");
 
     /* Delete the drive */
     drive_del(qts);
@@ -192,6 +192,11 @@ static void test_after_failed_device_add(void)
     QDict *response;
     QTestState *qts;
 
+    if (!has_device_builtin("virtio-blk")) {
+        g_test_skip("Device virtio-blk is not available");
+        return;
+    }
+
     snprintf(driver, sizeof(driver), "virtio-blk-%s",
              qvirtio_get_dev_type());
 
-- 
2.45.0


