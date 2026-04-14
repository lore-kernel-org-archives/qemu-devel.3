Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A078FA0C26
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 04:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCrXk-0006nv-CT; Wed, 15 Apr 2026 00:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCneg-0008FH-4X
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elirazamumtaz@gmail.com>)
 id 1wCnee-0003XT-I2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:58:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4832c8f9d87so9049675e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776211131; x=1776815931; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kHFAcl/jzvkoKQBJ6saCtlCSuiizvOoPEDXt1Y+LFq8=;
 b=isA1l+pK64WbYxJREb7ZYIXQ5HbipPsN+46nl8aplIgMG2BkrYZAHDvQ24va2ls+0w
 1MNoKy3HElRnlK1ndB7QGaVlaTwzKdKmOVMauJbN7s3eXMAfq1zl7t5Yf0ADyXePSIeD
 TTCwySGyMbrXjioJ1VvSSvxu2u2B9EqiF37dznnwL8wqRhy+Gb4ZDJU+PiRpRyQ0fPR/
 Kc/z+hGBz0a2SH+ELorbRkKtZXMcEiEir4DPjmaY4+SyJXHGq9HQcwFmR8+vpUmIfBFc
 csQ33FLSxEWCZAbrS8zunzS/LTM3Nnk5UogmdJCo83JPiV0dT1mIHxVtdzl/PGNAIbwy
 Q2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776211131; x=1776815931;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kHFAcl/jzvkoKQBJ6saCtlCSuiizvOoPEDXt1Y+LFq8=;
 b=J0RXQsUuxLRi0j+xwYJ94hQ7eo0IbXdziasJVnM8sRcJkUQhtlomVGqc+hCasGfPtG
 Ib8Q43qtRTwpkoyNdc2hb4m9HU/xErhE6KYvoAak5RMF722qeFJhAf+i1YT3iwI0uoKb
 znL+J5YgzADv1Esb9H1MKuwzGgCPaZ9I1TTScROKjQDJgvX1Fxs84fuA9kvytJ8bTAgf
 6/8fSU1pO0lp8tm5SAh9ZOwmWRjsS1JpFlrkIPkAKzcXdRYmiSYnnk3zXc3gaCCaysUO
 pmTtx3oKm0DZijJ3hMFnSZfoBmxoNe6YiIBxxI62A6bSAQPPchD+JPTCH2AjJJtYjY9N
 o1dA==
X-Gm-Message-State: AOJu0YxKo5EQt0rbEkcXUe5iHA4UklI08s0PnfJ384M9xLEZ2UYev814
 esg1mz3oQCv7ge+4feUAfZWQ+nLRxa+mibfJ0M4HVV4Mx/0uU2lDneF8Atn9cfPO
X-Gm-Gg: AeBDieu1kcEu14CAk+KTnSxCGXY/9MOCW5nnYaU4m1fenif5fST+d4UFRcaRT4bQUIF
 BGdhKgQ4IIA09hZtKgruAy1TUKjPo7zQh8Nhh19l8UdWBvixqxNmEkoz13/piWPgx09u450ahcC
 tMQZk8YGuqNY9pw4Quakgcwhl7mZfoZDzBhubqKzzRPI1+67ATcCdmIY/wvbxVh8rpfQCJI+0aj
 2dKm3ZjviBk6EH4EnhNq/bllLfgOwXzs/F0I222xNGKYMfUd5YjZ/O6GhL4TNgO0ciSqttpg8Qa
 vvpG6ftKRJAoawGTUC7wJkQLoi8bMqoWZ0y+UqwXDpz5psPwDzDZSHR8C5rWfknTMZ4c7E5h8m7
 KQqUWq+GW/JsjW3JKaq/TIwN4xDdJU31gsy2CqIa3IQD9GWlZyvZP4o2wi4rpOLFhJpEMyjknHV
 8qQZ0JOeN7lQUZW+Q1hcIgfljjzz7EGqpx
X-Received: by 2002:a5d:5d01:0:b0:43c:fd0b:c5c5 with SMTP id
 ffacd0b85a97d-43eacf77b7fmr171133f8f.6.1776211130863; 
 Tue, 14 Apr 2026 16:58:50 -0700 (PDT)
Received: from [192.168.10.11] ([182.181.137.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5f11sm115535f8f.18.2026.04.14.16.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 16:58:50 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Wed, 15 Apr 2026 04:58:35 +0500
Subject: [PATCH 2/3] linux-user: Validate tkill/tgkill targets are guest
 threads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-master-v1-2-8dd2ef111eee@gmail.com>
References: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
In-Reply-To: <20260415-master-v1-0-8dd2ef111eee@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ali Raza <elirazamumtaz@gmail.com>, morgan@kernel.org
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=elirazamumtaz@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Apr 2026 00:07:57 -0400
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

The tkill and tgkill syscall handlers pass the guest-supplied TID
directly to the host kernel without checking whether it belongs to a
guest thread.  This allows a guest to send signals to QEMU-internal
host threads (RCU, TCG workers) that have no CPUState and no guest
signal handlers, which can cause hangs or disrupt QEMU operation.

Add validation that checks the target TID against the guest CPU list
before forwarding the signal to the host.  For tgkill, also verify
that the tgid matches the current process.  Return -ESRCH for TIDs
that do not correspond to any guest thread, matching the behavior a
real kernel would return for a nonexistent thread.

This complements the /proc/*/task/ filtering in the previous commit
to provide defense-in-depth: even if a guest discovers or guesses a
QEMU-internal thread TID, it cannot send signals to it.

Signed-off-by: Ali Raza (@locus-x64)
---
 linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b5a912dc22..a075b9a90b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13449,11 +13449,41 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
 
     case TARGET_NR_tkill:
-        return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg2)));
+    {
+        int tid = (int)arg1;
+        /*
+         * Reject signals to host threads that are not guest threads.
+         * QEMU-internal threads (RCU, TCG) share the host PID but have
+         * no CPUState and cannot handle guest-originated signals.
+         */
+        WITH_RCU_READ_LOCK_GUARD() {
+            if (!is_guest_tid(tid)) {
+                return -TARGET_ESRCH;
+            }
+        }
+        return get_errno(safe_tkill(tid, target_to_host_signal(arg2)));
+    }
 
     case TARGET_NR_tgkill:
-        return get_errno(safe_tgkill((int)arg1, (int)arg2,
+    {
+        int tgid = (int)arg1;
+        int tid = (int)arg2;
+        /*
+         * Validate that the target TID is a guest thread.  Also verify
+         * that the tgid matches our process, since all guest threads
+         * share the same host tgid.
+         */
+        if (tgid != getpid()) {
+            return -TARGET_ESRCH;
+        }
+        WITH_RCU_READ_LOCK_GUARD() {
+            if (!is_guest_tid(tid)) {
+                return -TARGET_ESRCH;
+            }
+        }
+        return get_errno(safe_tgkill(tgid, tid,
                          target_to_host_signal(arg3)));
+    }
 
 #ifdef TARGET_NR_set_robust_list
     case TARGET_NR_set_robust_list:

-- 
2.43.0


