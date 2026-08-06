Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7DBC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrrU6-0005Er-Ks; Thu, 06 Aug 2026 02:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrrU4-0005EJ-4D
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 02:21:40 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengrong_li@linux.alibaba.com>)
 id 1wrrU0-00007Y-Gt
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 02:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785997281; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 bh=aVrtlsA7Jg/Ha9/qbJG0kFJ5A7fFXUivVpxYdndNPFs=;
 b=jbdto/FgOijlPpjvhEyGS7QMDrn4Pqoq0voYd1j2PAN4b6Y+2dPbf0yTQTy9ZiYCKgeayLFVOE2uxcH+1/ID0VEiDDQ2F4BuItsbINof7AMGcrX5dOD/YezKT+RBzMfbFSjtU6Fp5iEC5R/rtvzrRe9tP8UVQACfo6A+0JCRHw0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=zhengrong_li@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X8T272f_1785997275; 
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com
 fp:SMTPD_---0X8T272f_1785997275 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 06 Aug 2026 14:21:21 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, philmd@qualcomm.com, pbonzini@redhat.com,
 viktor.prutyanov@phystech.edu, zhengrong_li@linux.alibaba.com
Subject: [PATCH v3 1/3] runstate: set crash_occurred on guest crashloaded
Date: Thu, 06 Aug 2026 14:20:59 +0800
Message-ID: <178599725914.10029.16439793637263128090@linux.alibaba.com>
In-Reply-To: <178599725914.10029.4441302124415593392@linux.alibaba.com>
References: <178599725914.10029.4441302124415593392@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=zhengrong_li@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Windows pvpanic driver writes PVPANIC_CRASH_LOADED (bit 1) on
bugcheck, not PVPANIC_PANICKED (bit 0). As a result,
qemu_system_guest_panicked() is never called and crash_occurred
stays false for Windows guests.

Set crash_occurred in qemu_system_guest_crashloaded() as well,
so the faulting CPU can be identified in the guest dump.

Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
---
 system/runstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/system/runstate.c b/system/runstate.c
index 08acf801b0..c7961cc1df 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -724,6 +724,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *i=
nfo)
 void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+
+    if (current_cpu) {
+        current_cpu->crash_occurred =3D true;
+    }
+
     qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
     qapi_free_GuestPanicInformation(info);
 }
--=20
2.43.0


