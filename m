Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DE1D5E367
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kKB-0007Uc-Fz; Sat, 09 Nov 2024 07:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kIa-00049J-I7; Sat, 09 Nov 2024 07:10:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kIY-0004JT-TZ; Sat, 09 Nov 2024 07:10:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8939AA1606;
 Sat,  9 Nov 2024 15:07:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4FBD5167F94;
 Sat,  9 Nov 2024 15:08:03 +0300 (MSK)
Received: (nullmailer pid 3295345 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 30/57] linux-user: Emulate /proc/self/maps under
 mmap_lock
Date: Sat,  9 Nov 2024 15:07:32 +0300
Message-Id: <20241109120801.3295120-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

If one thread modifies the mappings and another thread prints them,
a situation may occur that the printer thread sees a guest mapping
without a corresponding host mapping, leading to a crash in
open_self_maps_2().

Cc: qemu-stable@nongnu.org
Fixes: 7b7a3366e142 ("linux-user: Use walk_memory_regions for open_self_maps")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241014203441.387560-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit bbd5630a75e70a0f1bcf04de74c94aa94a145628)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fix in linux-user/syscall.c due to missing v9.0.0-421-g59272469bd13
 "user: Use get_task_state() helper")

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2edbd1ef15..caa91c3b1d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8132,17 +8132,19 @@ static int open_self_maps_1(CPUArchState *env, int fd, bool smaps)
 {
     struct open_self_maps_data d = {
         .ts = env_cpu(env)->opaque,
-        .host_maps = read_self_maps(),
         .fd = fd,
         .smaps = smaps
     };
 
+    mmap_lock();
+    d.host_maps = read_self_maps();
     if (d.host_maps) {
         walk_memory_regions(&d, open_self_maps_2);
         free_self_maps(d.host_maps);
     } else {
         walk_memory_regions(&d, open_self_maps_3);
     }
+    mmap_unlock();
     return 0;
 }
 
-- 
2.39.5


