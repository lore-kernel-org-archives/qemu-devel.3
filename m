Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB5CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBkG-0008KK-6x; Fri, 24 Oct 2025 02:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vCBkE-0008Hi-Ii
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vCBk4-0006lI-3P
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761289059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Knj5o0XKslR8KZibGSIwkm7pF6XSwQomEo4fnIU5PI8=;
 b=fVunw9/HArt65UPaUjO8H7lejxxffeAhmOX7qFpIhVEFX3NzcCa0B2Je1MbI6GZdWVkeSi
 gPKZVWwi7wtz+te5fzAdXsRVYzxuGkF5dk+BJw/qPtltgdA8XKQP0tlQuKtp3q8qt0HhS6
 +r1K2ifdG+XOYEDAnSsSO5jSlNDgous=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-m25K25NfP6GZe2m-AqMZ6Q-1; Fri,
 24 Oct 2025 02:57:35 -0400
X-MC-Unique: m25K25NfP6GZe2m-AqMZ6Q-1
X-Mimecast-MFC-AGG-ID: m25K25NfP6GZe2m-AqMZ6Q_1761289054
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96D1A195609F; Fri, 24 Oct 2025 06:57:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 193F21800452; Fri, 24 Oct 2025 06:57:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/2] target/ppc/cpu_init: Simplify the setup of the TLBxCFG
 SPR registers
Date: Fri, 24 Oct 2025 08:57:25 +0200
Message-ID: <20251024065726.738005-2-thuth@redhat.com>
In-Reply-To: <20251024065726.738005-1-thuth@redhat.com>
References: <20251024065726.738005-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The next commit is going to remove init_proc_e200(), which is one of
the two calling sites of register_BookE206_sprs(). This causes recent
versions of GCC to inline the register_BookE206_sprs() function into
the other only remaining calling site, init_proc_e500(), which in
turn causes some false-positives compiler warnings:

 In file included from ../../devel/qemu/target/ppc/cpu_init.c:46:
 In function ‘register_BookE206_sprs’,
     inlined from ‘init_proc_e500’ at ../../devel/qemu/target/ppc/cpu_init.c:2910:5:
 ../../devel/qemu/target/ppc/cpu_init.c:897:29: error:
  array subscript 3 is outside array bounds of ‘uint32_t[2]’ {aka ‘unsigned int[2]’}
  [-Werror=array-bounds=]
   897 |                      tlbncfg[3]);
       |                      ~~~~~~~^~~
 ../../devel/qemu/target/ppc/spr_common.h:61:39: note: in definition of macro ‘spr_register_kvm_hv’
    61 |                   KVM_ARG(one_reg_id) initial_value)
       |                                       ^~~~~~~~~~~~~
 ../../devel/qemu/target/ppc/spr_common.h:77:5: note: in expansion of macro ‘spr_register_kvm’
    77 |     spr_register_kvm(env, num, name, uea_read, uea_write,                    \
       |     ^~~~~~~~~~~~~~~~
 ../../devel/qemu/target/ppc/cpu_init.c:894:9: note: in expansion of macro ‘spr_register’
   894 |         spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
       |         ^~~~~~~~~~~~
 ../../devel/qemu/target/ppc/cpu_init.c: In function ‘init_proc_e500’:
 ../../devel/qemu/target/ppc/cpu_init.c:2809:14: note: at offset 12 into object ‘tlbncfg’ of size 8
  2809 |     uint32_t tlbncfg[2];
       |              ^~~~~~~
 cc1: all warnings being treated as errors

init_proc_e500() only defines "uint32_t tlbncfg[2];", but it is OK since
it also sets "env->nb_ways = 2", so the code that GCC warns about in
register_BookE206_sprs() is never reached. Unfortunately, GCC is not smart
enough to see this, so it emits these warnings.

To fix it, let's simplify the code in register_BookE206_sprs() a little
bit to set up the SPRs in a loop, so we don't reference the tlbncfg[3]
entry directly anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/cpu_init.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3aa3aefc136..12c645699e8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -850,6 +850,13 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
         SPR_BOOKE_MAS0, SPR_BOOKE_MAS1, SPR_BOOKE_MAS2, SPR_BOOKE_MAS3,
         SPR_BOOKE_MAS4, SPR_BOOKE_MAS5, SPR_BOOKE_MAS6, SPR_BOOKE_MAS7,
     };
+    const char *tlbcfg_names[4] = {
+        "TLB0CFG", "TLB1CFG", "TLB2CFG", "TLB3CFG",
+    };
+    const int tlbcfg_sprn[4] = {
+        SPR_BOOKE_TLB0CFG, SPR_BOOKE_TLB1CFG,
+        SPR_BOOKE_TLB2CFG, SPR_BOOKE_TLB3CFG,
+    };
     int i;
 
     /* TLB assist registers */
@@ -889,34 +896,13 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, SPR_NOACCESS,
                  mmucfg);
-    switch (env->nb_ways) {
-    case 4:
-        spr_register(env, SPR_BOOKE_TLB3CFG, "TLB3CFG",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[3]);
-        /* Fallthru */
-    case 3:
-        spr_register(env, SPR_BOOKE_TLB2CFG, "TLB2CFG",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[2]);
-        /* Fallthru */
-    case 2:
-        spr_register(env, SPR_BOOKE_TLB1CFG, "TLB1CFG",
-                     SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[1]);
-        /* Fallthru */
-    case 1:
-        spr_register(env, SPR_BOOKE_TLB0CFG, "TLB0CFG",
+
+    assert(env->nb_ways <= ARRAY_SIZE(tlbcfg_names));
+    for (i = 0; i < env->nb_ways; i++) {
+        spr_register(env, tlbcfg_sprn[i], tlbcfg_names[i],
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, SPR_NOACCESS,
-                     tlbncfg[0]);
-        /* Fallthru */
-    case 0:
-    default:
-        break;
+                     tlbncfg[i]);
     }
 #endif
 }
-- 
2.51.0


