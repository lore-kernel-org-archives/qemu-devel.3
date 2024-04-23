Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52288C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnS-00065E-9A; Tue, 23 Apr 2024 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnL-0005Oz-Ot
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnJ-0000M5-QT
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJ9NjBd4Ldl0Zbc2tRqgEosye1gIgb6S3EDsnAKGjfk=;
 b=VcQDqY39vPOQAUNZG281+C8vzbeXeUHDavLNxoZZGjqSHp6YX5aUSJejSuqktf6Wmn4rVg
 5+3u0GkSPQPcCrmWOrfnnlPdDDJhv1YbRojNR4gtxgv6UI1NDVw1mhEjrws6rYOnnk7MrS
 a3U2tBeYBn2N9fPXbi1G20H5HGYFi98=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-hRzLme8PNV2r32ZIwtZTkA-1; Tue,
 23 Apr 2024 11:10:51 -0400
X-MC-Unique: hRzLme8PNV2r32ZIwtZTkA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 740C21C0C652;
 Tue, 23 Apr 2024 15:10:51 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE950200E290;
 Tue, 23 Apr 2024 15:10:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 59/63] target/i386/cpu: Consolidate the use of
 warn_report_once()
Date: Tue, 23 Apr 2024 17:09:47 +0200
Message-ID: <20240423150951.41600-60-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The difference between error_printf() and error_report() is the latter
may contain more information, such as the name of the program
("qemu-system-x86_64").

Thus its variant error_report_once() and warn_report()'s variant
warn_report_once() can be used here to print the information only once
without a static local variable "ht_warned".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240327103951.3853425-3-zhao1.liu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eda15b0d4c7..28452983786 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7367,7 +7367,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
     Error *local_err = NULL;
-    static bool ht_warned;
     unsigned requested_lbr_fmt;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
@@ -7610,13 +7609,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      */
     if (IS_AMD_CPU(env) &&
         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-        cs->nr_threads > 1 && !ht_warned) {
-            warn_report("This family of AMD CPU doesn't support "
-                        "hyperthreading(%d)",
-                        cs->nr_threads);
-            error_printf("Please configure -smp options properly"
-                         " or try enabling topoext feature.\n");
-            ht_warned = true;
+        cs->nr_threads > 1) {
+            warn_report_once("This family of AMD CPU doesn't support "
+                             "hyperthreading(%d).", cs->nr_threads);
+            error_report_once("Please configure -smp options properly"
+                              " or try enabling topoext feature.");
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.44.0



