Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F34CD585E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJg-0003tY-EG; Wed, 07 Jan 2026 07:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJX-0003rx-B1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJP-00027l-4e
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQBbjvqeMSJZucWEry7QkZZKs/CHmHm4OBO8nD45sws=;
 b=Jm0Diwwthe3j+28HsFoioXjoF5S+1osmMEQcFh7BJ9LRYMWSOKDhf6izXGFj0pPzziMeBJ
 nLRFMsuuoCsqk+NLItvOsYS7a5uVDrHK4mROexBmhr0q4bYDaP2fuoqQRmc9n7dXugt3Ry
 iCXJgNkX4qMS7mv8jsLVJMuv/6i9DBw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-df5vRInBNtuz-evvx3OQtA-1; Wed,
 07 Jan 2026 07:06:46 -0500
X-MC-Unique: df5vRInBNtuz-evvx3OQtA-1
X-Mimecast-MFC-AGG-ID: df5vRInBNtuz-evvx3OQtA_1767787605
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CC1B19560A1; Wed,  7 Jan 2026 12:06:45 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DA611956048; Wed,  7 Jan 2026 12:06:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 03/14] hw/s390x: Un-inline the s390_do_cpu_*() functions
Date: Wed,  7 Jan 2026 13:06:27 +0100
Message-ID: <20260107120638.56735-4-thuth@redhat.com>
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
References: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

These functions are only called via their function pointer by using
the run_on_cpu() function, so it does not make sense to declare these
as "inline" functions. Move the functions from cpu.h to either cpu.c
(when they are still used in multiple places), or to s390-virtio-ccw.c
(when they are only called from that file).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251217144238.37610-1-thuth@redhat.com>
---
 target/s390x/cpu.h         | 24 +-----------------------
 hw/s390x/s390-virtio-ccw.c | 19 ++++++++++++++++++-
 target/s390x/cpu.c         |  5 +++++
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index aa931cb6748..ba2bf177e8f 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -845,30 +845,8 @@ static inline uint64_t s390_build_validity_mcic(void)
     return mcic;
 }
 
-static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    cpu_reset(cs);
-}
-
-static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_NORMAL);
-}
-
-static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_INITIAL);
-}
-
-static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->load_normal(cs);
-}
-
-
 /* cpu.c */
+void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg);
 void s390_crypto_reset(void);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5e9bab2ee7e..3ef009463d1 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -364,7 +364,24 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
     }
 }
 
-static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
+static void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_NORMAL);
+}
+
+static void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    resettable_reset(OBJECT(cs), RESET_TYPE_S390_CPU_INITIAL);
+}
+
+static void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+
+    scc->load_normal(cs);
+}
+
+static void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
 {
     S390CPU *cpu = S390_CPU(cs);
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 6c4198eb1b1..6af7446fd9f 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -141,6 +141,11 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 #endif
 }
 
+void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    cpu_reset(cs);
+}
+
 /* S390CPUClass Resettable reset_hold phase method */
 static void s390_cpu_reset_hold(Object *obj, ResetType type)
 {
-- 
2.52.0


