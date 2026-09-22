Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E084CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96u2-000821-4v; Tue, 22 Sep 2026 16:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x96tS-0007rj-Nk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:15:14 -0400
Received: from mxa.tachyum.com ([66.160.133.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x96tR-0007Sw-43
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:15:10 -0400
Received: from mxa.tachyum.com (localhost.localdomain [127.0.0.1])
 by mxa.tachyum.com (Proxmox) with ESMTP id 2B7511EA446;
 Tue, 22 Sep 2026 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tachyum.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=dkim; bh=uVxBmePR13eUox6qhtIT
 ECbkMTpQsXf+qlwrW+DGYMU=; b=S4XzLU6XfvYv4KApiIRLIrIELTHLQVh5HE+Y
 WqikX1jJgejebkv4qkLQ8/RWhew+bpnlK3O5+lbR3dvYYv2Fm84bZxQfUn/sUJOB
 cWHt0/5mCwB/2SQQLmdP4UDIClF5YU4tZSoeiRHNCD/vGf9XKVpnvnDAQjxIZDHb
 fILKNPppHpnaFfjBwueExubWkt+Ry4Z4trvLOpobodsIuJx4MCM2Igt4YoDwFeCg
 eG7iq6WrCoK9GbgZ1STGg7Hzi6Mpva3wT1+TqAKdYvYSr+VCFNnrHgULUKauXu7g
 y1Tj+r7SLZvaxUi7Pi/dwwmcvyW7S6fgsDk06ZDTw2Egpvgs3A==
From: Michael Morrell <mmorrell@tachyum.com>
To: Michael Morrell <mmorrell@tachyum.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>
Subject: RE: [PATCH v2] linux-user: implement mlock2(2) syscall
Thread-Topic: [PATCH v2] linux-user: implement mlock2(2) syscall
Thread-Index: AQHdRKE+h2cjoxG/q0ataDhr+AKuH7bbFMEg
Date: Tue, 22 Sep 2026 20:14:53 +0000
Message-ID: <f1e132a7611c45f088ff2d7e07a3391e@tachyum.com>
References: <20260914233204.314810-1-mmorrell@tachyum.com>
In-Reply-To: <20260914233204.314810-1-mmorrell@tachyum.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=66.160.133.173; envelope-from=mmorrell@tachyum.com;
 helo=mxa.tachyum.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping

-----Original Message-----
From: Michael Morrell <mmorrell@tachyum.com>=20
Sent: Monday, September 14, 2026 4:32 PM
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>; Helge Deller <deller@gmx.de>; Pierr=
ick Bouvier <pierrick.bouvier@oss.qualcomm.com>; Michael Morrell <mmorrell@=
tachyum.com>
Subject: [PATCH v2] linux-user: implement mlock2(2) syscall

TARGET_NR_mlock2 is defined for every target's syscall table (it has been a=
vailable on all Linux architectures since it was added in kernel 4.4), and =
linux-user/strace.list already has an entry for it, but linux-user/syscall.=
c has no case handler for it. A guest mlock2() call therefore falls through=
 to the default case and gets -ENOSYS instead of being emulated, on every t=
arget.

mlock2() differs from mlock() only by a third `flags` argument (MLOCK_ONFAU=
LT). Add TARGET_MLOCK_ONFAULT and a case that validates the flags argument =
and forwards to the host mlock2(), mirroring the existing TARGET_NR_mlock c=
ase immediately above it.

Signed-off-by: Michael Morrell <mmorrell@tachyum.com>
---
 linux-user/syscall.c      | 9 +++++++++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c index cfa68dfbdb..=
9f454502cb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11230,6 +11230,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env,=
 int num, abi_long arg1,
     case TARGET_NR_mlock:
         return get_errno(mlock(g2h(cpu, arg1), arg2));  #endif
+#ifdef TARGET_NR_mlock2
+    case TARGET_NR_mlock2:
+        if (arg3 & ~TARGET_MLOCK_ONFAULT) {
+            return -TARGET_EINVAL;
+        }
+        return get_errno(mlock2(g2h(cpu, arg1), arg2,
+                                 (arg3 & TARGET_MLOCK_ONFAULT) ?
+                                 MLOCK_ONFAULT : 0)); #endif
 #ifdef TARGET_NR_munlock
     case TARGET_NR_munlock:
         return get_errno(munlock(g2h(cpu, arg1), arg2)); diff --git a/linu=
x-user/syscall_defs.h b/linux-user/syscall_defs.h index e28853c93b..f5831a6=
bad 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2795,6 +2795,10 @@ struct target_mount_attr_ver0 {  #ifndef RESOLVE_IN_=
ROOT
 #define RESOLVE_IN_ROOT         0x10
 #endif
+
+/* flags for mlock2() */
+#define TARGET_MLOCK_ONFAULT    0x01
+
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
     (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
     defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
--
2.43.0




