Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87E8D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4H-0000wa-CR; Fri, 11 Oct 2024 13:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szJ4D-0000hu-3z
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szILz-0004xq-Kg
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 12:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728663534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0xq9oS9Q8pSgDX6vHbWASCKcp4gd4kByVEIjsyz6pf8=;
 b=DeUinpEUdzhXmNWIkMvMk9YxURLon97kt3SFeh4dQpB9iBOjgxGIpxDkVPIftaa8ByX22Z
 FUBqeBWNsK8vro5B8RrUKn5Tsax9oILHY7quFVjbEB1Qiau71ehVt/szrhwcaWHOg3MWvO
 rtCIFVN5ER044tk6FI329NpdS7Icy/I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-V63sUWriPu64JHNXQBOcWg-1; Fri,
 11 Oct 2024 12:18:51 -0400
X-MC-Unique: V63sUWriPu64JHNXQBOcWg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D370819560AA; Fri, 11 Oct 2024 16:18:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5998219560AA; Fri, 11 Oct 2024 16:18:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: dave@treblig.org, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] linux-user/vm86: Fix compilation with Clang
Date: Fri, 11 Oct 2024 18:18:45 +0200
Message-ID: <20241011161845.417342-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since commit 95b9c27c81 ("linux-user: Remove unused handle_vm86_fault")
a bunch of other "static inline" function are now unused, too. Clang
warns about such unused "static inline" functions in .c files, so the
build currently breaks when compiling with "--enable-werror". Remove
the unused functions to get it going again.

Fixes: 95b9c27c81 ("linux-user: Remove unused handle_vm86_fault")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/vm86.c | 65 -----------------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 31a2d707cf..5091d53fb8 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -47,30 +47,6 @@ static inline void vm_putw(CPUX86State *env, uint32_t segptr,
     cpu_stw_data(env, segptr + (reg16 & 0xffff), val);
 }
 
-static inline void vm_putl(CPUX86State *env, uint32_t segptr,
-                           unsigned int reg16, unsigned int val)
-{
-    cpu_stl_data(env, segptr + (reg16 & 0xffff), val);
-}
-
-static inline unsigned int vm_getb(CPUX86State *env,
-                                   uint32_t segptr, unsigned int reg16)
-{
-    return cpu_ldub_data(env, segptr + (reg16 & 0xffff));
-}
-
-static inline unsigned int vm_getw(CPUX86State *env,
-                                   uint32_t segptr, unsigned int reg16)
-{
-    return cpu_lduw_data(env, segptr + (reg16 & 0xffff));
-}
-
-static inline unsigned int vm_getl(CPUX86State *env,
-                                   uint32_t segptr, unsigned int reg16)
-{
-    return cpu_ldl_data(env, segptr + (reg16 & 0xffff));
-}
-
 void save_v86_state(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -131,19 +107,6 @@ static inline void return_to_32bit(CPUX86State *env, int retval)
     env->regs[R_EAX] = retval;
 }
 
-static inline int set_IF(CPUX86State *env)
-{
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-
-    ts->v86flags |= VIF_MASK;
-    if (ts->v86flags & VIP_MASK) {
-        return_to_32bit(env, TARGET_VM86_STI);
-        return 1;
-    }
-    return 0;
-}
-
 static inline void clear_IF(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
@@ -162,34 +125,6 @@ static inline void clear_AC(CPUX86State *env)
     env->eflags &= ~AC_MASK;
 }
 
-static inline int set_vflags_long(unsigned long eflags, CPUX86State *env)
-{
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-
-    set_flags(ts->v86flags, eflags, ts->v86mask);
-    set_flags(env->eflags, eflags, SAFE_MASK);
-    if (eflags & IF_MASK)
-        return set_IF(env);
-    else
-        clear_IF(env);
-    return 0;
-}
-
-static inline int set_vflags_short(unsigned short flags, CPUX86State *env)
-{
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-
-    set_flags(ts->v86flags, flags, ts->v86mask & 0xffff);
-    set_flags(env->eflags, flags, SAFE_MASK);
-    if (flags & IF_MASK)
-        return set_IF(env);
-    else
-        clear_IF(env);
-    return 0;
-}
-
 static inline unsigned int get_vflags(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.46.1


