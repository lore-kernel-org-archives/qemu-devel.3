Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481A3CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ6cH-0004RA-JS; Thu, 21 May 2026 12:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wQ6bo-0004MF-3p
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:50:57 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wQ6bm-00071k-Am
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:50:55 -0400
Received: from laptop.localdomain (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4732820B716A;
 Thu, 21 May 2026 09:50:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4732820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779382246;
 bh=JlpbxG0l5HnNNZhi6MoHMmlFp4OaZ+gjEkjpeb/dFsw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EY678/l8Fj+U7XglZr5L4s9Qqym2YO/qwM7o13Fnd8+NNeEWwemHqXztf/5KEbhLA
 Q91Dr0yrZwkVLJ0dPWBuBytZt6H8skstptdIQKVCfq0rC9VHlQWdgheO8COIHR5g/3
 9hxeL8tG+JGU7oNbGcSe1HXHvwGptF0RQmtJky4Y=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH v3 2/7] accel/mshv: move vcpu arch specific initialization
 after vcpu creation
Date: Thu, 21 May 2026 19:50:36 +0300
Message-ID: <20260521165041.131477-3-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521165041.131477-1-dblanzeanu@linux.microsoft.com>
References: <20260521165041.131477-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Call mshv_arch_init_vcpu after the vcpu is created to ensure a valid
vcpu fd.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 accel/mshv/mshv-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 58af674bd9..e3da583f21 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -415,13 +415,14 @@ static int mshv_init_vcpu(CPUState *cpu)
     int ret;
 
     cpu->accel = g_new0(AccelCPUState, 1);
-    mshv_arch_init_vcpu(cpu);
 
     ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
     if (ret < 0) {
         return -1;
     }
 
+    mshv_arch_init_vcpu(cpu);
+
     cpu->accel->dirty = true;
 
     return 0;
-- 
2.53.0


