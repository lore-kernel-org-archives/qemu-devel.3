Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7DDC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBsZ-0005cg-Sa; Thu, 05 Jun 2025 10:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghe9702@163.com>)
 id 1uNBrO-0005Vm-0G
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:46:26 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhanghe9702@163.com>) id 1uNBrK-0000ZG-HV
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Wb
 QUc+TddGyYGAA9DJxEdBCR8n6wzab7EGx9y/VtN2M=; b=jhuYiz/ECFqKvj3vBj
 sK12lhIVcXF825/Zw/XH9YJwXEp7AkbmdTMPGQgYSmNKelOfXas81m4a/mJ82SIX
 o7lUc+vSuOBBkAfreYntTy+jwVH6OGO/kJGiRW8m21IGhN8CzzSS8ky2DE4Yu1MS
 HIOKMepC+vdkW2VvgzZ4NjSDQ=
Received: from zhanghe-System-Product-Name.. (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wCHKeOurUFos7y8Gg--.27062S2; 
 Thu, 05 Jun 2025 22:46:07 +0800 (CST)
From: Zhang He <zhanghe9702@163.com>
To: laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	Zhang He <zhanghe9702@163.com>
Subject: [PATCH] Fixes: failed to call mq_open/mq_unlink in qemu-arm
Date: Thu,  5 Jun 2025 22:46:03 +0800
Message-ID: <20250605144603.17475-1-zhanghe9702@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHKeOurUFos7y8Gg--.27062S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1DXr4rtF1xJF1Uur17Jrb_yoWDKrX_ur
 W7try7GFWUCa9rZ3WfKw45Ar4av348JF4IqFn8KrW2yr4xJr93JasYvr9Yyr43uFW09wsI
 ga4kX3W09r1SvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRLZ23UUUUU==
X-Originating-IP: [183.14.214.161]
X-CM-SenderInfo: x2kd0wlkhzliqs6rljoofrz/1tbiWwljamhBrEovHQAAsm
Received-SPF: pass client-ip=117.135.210.5; envelope-from=zhanghe9702@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Jun 2025 10:47:38 -0400
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

i write some bare-metal c code need mq_open/mq_unlink syscall, but
the syscall failed in passed name param check, arg1 in this scenario
is the correct address from user-space, arg1 - 1 not.
i have tested in arm cortex-m55 cpu model, maybe should add conditional compile macro?

Signed-off-by: Zhang He <zhanghe9702@163.com>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc37028597..be9610176a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13058,7 +13058,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                 }
                 pposix_mq_attr = &posix_mq_attr;
             }
-            p = lock_user_string(arg1 - 1);
+            p = lock_user_string(arg1);
             if (!p) {
                 return -TARGET_EFAULT;
             }
@@ -13068,7 +13068,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         return ret;
 
     case TARGET_NR_mq_unlink:
-        p = lock_user_string(arg1 - 1);
+        p = lock_user_string(arg1);
         if (!p) {
             return -TARGET_EFAULT;
         }
-- 
2.43.0


