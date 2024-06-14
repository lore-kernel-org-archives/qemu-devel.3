Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A33C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 12:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI6TT-0006YE-Kn; Fri, 14 Jun 2024 08:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trentmhuber@gmail.com>)
 id 1sHzHE-0003uE-0m; Fri, 14 Jun 2024 01:15:04 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trentmhuber@gmail.com>)
 id 1sHzHC-0008OJ-Co; Fri, 14 Jun 2024 01:15:03 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b0871bd288so2635956d6.2; 
 Thu, 13 Jun 2024 22:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718342100; x=1718946900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7GTksfZRb2NSXlR1E0cPWHKFmqRx4/aAfvMPhoC8MME=;
 b=j+hqaxfrcCRIUauXzn/0COvKt8jqBLZFPJk1xmQAQOzGCwoz5wuDaDkISDCNFnZGgj
 UzM+83cPLhD0jAFUFsShfmuuNgiiCl++R5xPU6HFcO/Pkgaaqb7SPKYzc6gZhKzcpnvC
 nedEnLhT5bm+NgFUP4EoP4DFVR76S+2J8Ci1007CAcRJcUaKCGnf0kLC+GZ23ov/Dl4B
 NH7auCcUQrlZ9yYL9u+10mvbi9NiYaOxlRD3dGsDeuxnVsfhpWFeBaB1B4mBhGxwbodH
 Z2CFA1thpoO/h8dWvbAW31FXJUh+Jpt+qA8aariqB14aq/9eUsjKyOy35i1snii0H2aQ
 Wgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718342100; x=1718946900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GTksfZRb2NSXlR1E0cPWHKFmqRx4/aAfvMPhoC8MME=;
 b=S+LGjIpCHiJfv1zEaAdvMUSa9B/fo7kWT8WWrYXTGV6ZoihfgEjtEIUlBAfZTA4B9i
 giD4pzyUnkCLpDsyHAvHbCzmvrNpuq/U44FqagB+XJupnAizFdAxopudWj1Qo6WV2oR8
 LtvqmMcbuOBuuhZtBSe/oyG7LcB/y1Gv0YREM58NI6BNotht1ZFhWzDKL+kV3W3URNFW
 6Oh/1aRBNyolxqxl+z3nTulNkPSuGe93VFysm9I873O1x4Wo4J7TCOFBQz/lyXh9AF71
 VyIiUBkyufbZqep9hqEA/FOmDOOxNB6cuhGN/4JvjJMDDQ3JkURdClq94Jyh4r0nVmWj
 kSJw==
X-Gm-Message-State: AOJu0YwnMEpxKHYfgr/olqrMvtIX5+U6QGBKoPOrDdXGZ0r9bwvp6UWR
 5Nr60QF/Bc4S3SuwzDQI95A1foEI445EMAAg5Oa6Tu+xHHOYARwiJ2pt8b2XpcY=
X-Google-Smtp-Source: AGHT+IGcZDGWNahJgfpt3OZT3Ts7iQqObbRjGY1bDAyCAJvWbozfx8mvVJRPjappPKA0P6+9Maf8KA==
X-Received: by 2002:a05:620a:8903:b0:795:59b1:526a with SMTP id
 af79cd13be357-798d1f81d99mr180965085a.0.1718342100048; 
 Thu, 13 Jun 2024 22:15:00 -0700 (PDT)
Received: from localhost.localdomain
 (pool-96-227-82-228.phlapa.fios.verizon.net. [96.227.82.228])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abe47c96sm113217485a.102.2024.06.13.22.14.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Jun 2024 22:14:59 -0700 (PDT)
From: Trent Huber <trentmhuber@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com,
 Trent Huber <trentmhuber@gmail.com>
Subject: [PATCH] os-posix: Expand setrlimit() syscall compatibility
Date: Fri, 14 Jun 2024 01:14:22 -0400
Message-Id: <20240614051422.13532-1-trentmhuber@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=trentmhuber@gmail.com; helo=mail-qv1-xf31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 14 Jun 2024 08:56:09 -0400
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

Darwin (I'm running version 19.6.0) uses a subtly different version
of the setrlimit() syscall as described in the COMPATIBILITY section
of the macOS man page. I adjusted the way the rlim_cur member is set
to accommodate and which shouldn't affect any non-Darwin systems.

Signed-off-by: Trent Huber <trentmhuber@gmail.com>
---
 os-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/os-posix.c b/os-posix.c
index a4284e2c07..5766346521 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -270,7 +270,7 @@ void os_setup_limits(void)
         return;
     }
 
-    nofile.rlim_cur = nofile.rlim_max;
+    nofile.rlim_cur = OPEN_MAX < nofile.rlim_max ? OPEN_MAX : nofile.rlim_max;
 
     if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
         warn_report("unable to set NOFILE limit: %s", strerror(errno));
-- 
2.24.3 (Apple Git-128)


