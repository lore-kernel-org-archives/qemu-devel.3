Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FEFCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIR-0006gW-KQ; Wed, 17 Jun 2026 10:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIQ-0006g0-4g
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIO-0007m2-CW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbVQBwoCXt49csIrXi0y/OwMoxrKUAGzvxobp7FDldw=;
 b=DFc0PCChdT7O+cGXYlKTAjYMvDPcbLbq9kotFFxH4z9Tq7O0p+egTKvRCYEgN7vS3ra3Wj
 pSfBGPYi9aqbqUXOn6L8Om/wZeKokroTtpdthu7vViwGuFzcGD6g+PxWVu3kegQ8TN5Hqz
 pXVAggGTAgtZqtyRYjmHuxZD/a+dIYE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-nAnjIXpXPAq8KixQYDNC1A-1; Wed, 17 Jun 2026 10:31:10 -0400
X-MC-Unique: nAnjIXpXPAq8KixQYDNC1A-1
X-Mimecast-MFC-AGG-ID: nAnjIXpXPAq8KixQYDNC1A_1781706669
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-462c1cf9003so590017f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706669; x=1782311469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbVQBwoCXt49csIrXi0y/OwMoxrKUAGzvxobp7FDldw=;
 b=b0E4SGdcqs6nddDMNRrc7hfoEilSzAtcQVqJPNzZR1VhvknKnRWppU4YTOdQZO9r+O
 pBDi9jwJexzp+AdZRW80vmVZLiiCKjSzmeXBRhk1jvfgCLQyls9DpYFTt9f+lalf4G/J
 WeuGJuvc5adA6bXXMsllxjHsQWVeckfRmZ5t71uDOfqC0HzsD2pIiDrylcbfXdqyR4ny
 yXoqJG9mqr1GRIibKicg5+9OJyaC2N/b6dTKlSMF9uO4wZT0CBPdHmO/hPAjWva1J2rd
 +ELOmJAchLdKTgS1dd4bSvQwbVapHMnGRn5p3njGcWMCGzEbyM4nEz3eM6LraeYIkhb2
 m91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706669; x=1782311469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GbVQBwoCXt49csIrXi0y/OwMoxrKUAGzvxobp7FDldw=;
 b=Lj4CFpNlUFo9+S5+AtQkWL0/0va0fb702BeUKzLjmziCh83RITYhAspK/xg8M98BYZ
 GatrnfDO+QBhZ2BaC4pqkQx/LB2SQk/gPyQK3kNd+HMgOM+42SJKxHYm6qXjEYTfgNBv
 RwJRNUz5cbrHi/XZASdgsS3KA25umPdb4kju7k6/Jicdr9Lx/uBmZdyKm8szGAMKFQlU
 zh1fM21TnjsEFE42SwztH9veBfHBUqa/ExCRfoYtAfcxgaM4kL44JOwCcEwHgiCPBFQO
 SHokljWlGqMDCFcPoDGR7CNs2z1382rSR+ykLjXQQgwAlp6hX9+FsjhvkiIZOYicrCbi
 Jdgg==
X-Gm-Message-State: AOJu0YzgC5JUTONbbtZXDg3a3QdiDY2/CvvFkMRObdQZsi4vFmWYbSrK
 YCFGv20eNBil0yegOlIAp6nZnJ3dAQBcOIOChoQyFA6ngGhZeSQckMiuDZIX5jzMfVOw+UMsW7r
 P2O+6F11XGTtrjOTrvhqkHQFybAV4GqVkP6IqAW904ey4j024PzKkCU/MgtKPGNjyNbVewVEdWN
 8yrOqe2u7hCFd0C2bD1Qnk2v3u4ZUUmPRoNaY4gu7o
X-Gm-Gg: AfdE7clDI18LeTKCFmVn+COlTVB6FRyy0l+4PTQD1swd85NgDnT9j6Bc5fAjFbnjfQ5
 eRWvnqBag/9pC9ibc8cci4qcVhfihsCOdrjoU1axz3qsjJlhRwUhHLFrISTCRMhsbA/r0A3BD6j
 oc/4/TbPMlihZtMk5o6e47a4rzSGRJIaljwft8L6JZVnTljy06NY9duSlmlLunEvUW3ngehdeyg
 FXO0fyq8i+cxqY7c/T4+N6Yw+QCPf3seZVeVdeV5yex2icmgqxHkHN5YIg5VxAlJBI4XajpVrX/
 TcNoisVg+hrloGg4+hL7Rpg5nU6j6Al7hAybaCjlh0h0jQL2OPyl++bCxGzB8BZWhjw0vfRhSg2
 VV9JcGRP3jieuqjrK4+tCAuAFgTbhvwvwhC+gd4deq4eIOqSeDJzhjqxZ7XqXCzXnV8ikdItoLA
 XbAAJL8JULmLyWdom8
X-Received: by 2002:a05:6000:1281:b0:45e:f1c5:709 with SMTP id
 ffacd0b85a97d-462418923damr4672085f8f.37.1781706669041; 
 Wed, 17 Jun 2026 07:31:09 -0700 (PDT)
X-Received: by 2002:a05:6000:1281:b0:45e:f1c5:709 with SMTP id
 ffacd0b85a97d-462418923damr4672008f8f.37.1781706668316; 
 Wed, 17 Jun 2026 07:31:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d1c7sm11174095f8f.7.2026.06.17.07.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Damien Zammit <damien@zamaudio.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 08/16] block/file-posix: Clean up sys/ioctl import
Date: Wed, 17 Jun 2026 16:30:38 +0200
Message-ID: <20260617143046.445322-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Damien Zammit <damien@zamaudio.com>

Since all platforms except sun include this header,
clean up the ifdefs.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260208055858.2166524-5-damien@zamaudio.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 5019ddade9b..5998448b1e8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -43,9 +43,11 @@
 #include "scsi/constants.h"
 #include "scsi/utils.h"
 
-#if defined(__APPLE__) && (__MACH__)
+#ifndef __sun__
 #include <sys/ioctl.h>
-#if defined(HAVE_HOST_BLOCK_DEVICE)
+#endif
+
+#if defined(__APPLE__) && (__MACH__) && defined(HAVE_HOST_BLOCK_DEVICE)
 #include <paths.h>
 #include <sys/param.h>
 #include <sys/mount.h>
@@ -57,7 +59,6 @@
 //#include <IOKit/storage/IOCDTypes.h>
 #include <IOKit/storage/IODVDMedia.h>
 #include <CoreFoundation/CoreFoundation.h>
-#endif /* defined(HAVE_HOST_BLOCK_DEVICE) */
 #endif
 
 #ifdef __sun__
@@ -65,7 +66,6 @@
 #include <sys/dkio.h>
 #endif
 #ifdef __linux__
-#include <sys/ioctl.h>
 #include <sys/param.h>
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -95,27 +95,20 @@
 #endif
 
 #ifdef __OpenBSD__
-#include <sys/ioctl.h>
 #include <sys/disklabel.h>
 #include <sys/dkio.h>
 #endif
 
 #ifdef __NetBSD__
-#include <sys/ioctl.h>
 #include <sys/disklabel.h>
 #include <sys/dkio.h>
 #include <sys/disk.h>
 #endif
 
 #ifdef __DragonFly__
-#include <sys/ioctl.h>
 #include <sys/diskslice.h>
 #endif
 
-#ifdef EMSCRIPTEN
-#include <sys/ioctl.h>
-#endif
-
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
 #ifdef O_SYNC
-- 
2.54.0


