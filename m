Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27523F8FA98
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDOr-0001pp-Kq; Tue, 21 Apr 2026 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFDOp-0001pb-Ms
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:52:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1wFDOn-000258-QT
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 11:52:31 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso2872031b3a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776786748; x=1777391548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3xAss2Zrtrg0dH9Eea4Ig0ZJK+cZEfXpf8g8d6E127s=;
 b=RzvqIZGf82Vm3aWGrHxg5iFogZdpjYHNBA5oJBDlNRAXcw0IHB31VpV4u32Ew39hLb
 A1ILIgKn0c20P9Udkt0XG54yauL9aLpbl1xUiAEsd1mJfEbMjtXoIz+wt06gDL5buDSY
 HWgdlx7lyf1iTK+P5HIyRg81IsDahroQqDLPr5IHc+eQW3yqRYJ/jnSFMGD5Iim4YpbV
 c9P9CRSSmLn18u1J4vlM2ZFUU1HaJYubAmPiAf1zgHkEplEmuY3Rmq8c7Z1J6lvr+buX
 yieEDjfY0FBpTLqKuqVDnbT6yaMIkcP7/nn2s3L2DS15ImaKQWIFa1yPGMSxDjFFURcP
 zT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776786748; x=1777391548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xAss2Zrtrg0dH9Eea4Ig0ZJK+cZEfXpf8g8d6E127s=;
 b=c51YMrW7zP21wDxyPUayvWklhn8h7VmFbTeQ4FC296+qdeyZfmebhxzKOgQFKJN2UT
 h6ivW7xr2lW26fxvW30JNIb3RfTLn0S9v3GtvfwpF1huy+0Md21apNqaWDCzCuzZN/ys
 w8duDkTCLllDSe9XhyG7qcsh3X/wzDcKsRFD221cpF2sowrtS8eQ0PJ9fH1t8tdF/1Tz
 CCjc0Z9irggJ6MtEJEmJSGRAyE1CU4LD/pw4/HrGIM8vf+wbI/5VpKlS/vIZoY4JrE3T
 xmkAk0j8dFJ28vLGKB9trpKsjj+J76uJhIYW80oWLeZG2FgLpClv1OG67T9+XHE87YGI
 Z7gA==
X-Gm-Message-State: AOJu0Yw//5LIhr3YydI2VJQrXAWuW3fjCnQ9GX2gPQu2WHL8AmRqnPio
 WDAj/VdHbMzgGANdluObtvt6naVAv0zKNMQI+Ukz1RZAFAZ1SpYVO0bI5sBvAGT1
X-Gm-Gg: AeBDieswKTais8l0yk9z24Qi7chcpfTqnm4EJkxpD6ZYA0sm4iup7ciTcCAJ/L68yz7
 IiZnqMhTWiuqVsp8n64Mi+3IcpDF6alsMIpj7/1LFLeMHQ2/inMAqB/zXjk69NOb1zNK+8kai31
 20bQktFbKz1FlRh4N2aRPM7uiSgTfm+Jb5pTbwuUswWca8z6tCp2YtPHdjtlRUaZbUDs+G8C0C1
 GmtghPuw9UBnhgMnurSeiwPH//oCX+irqEbpt9wTX9OHhNrFbFpuxvN2aYyIO00rvCRUa1oRMF/
 I3TFNoZu1uNuyfIBbcWc/SvnGF3LTfXYjV8HfcLKnIjlPU25R4Tr01Ra6W4ZChCPv6o8JHS4wIz
 yWHm9snYhlskpqSEUvcBvtUd3eVjca1CZUQW90SVhUxZyhfrVl8gJDicGlFPb57OZTKHWClitb3
 Vp8oas7HpuE6clZMuOcgQFMYhu+FBJM/thmK7tGdxsGG4Nr2HYqGxhbODAzQ==
X-Received: by 2002:a05:6a00:908a:b0:81f:9b4c:81c0 with SMTP id
 d2e1a72fcca58-82f8c90c380mr21266848b3a.41.1776786747592; 
 Tue, 21 Apr 2026 08:52:27 -0700 (PDT)
Received: from localhost.localdomain ([42.114.219.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981a0asm14848193b3a.3.2026.04.21.08.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:52:27 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration/vmstate: replace NULL pointer assert with proper
 error
Date: Tue, 21 Apr 2026 22:52:19 +0700
Message-ID: <20260421155219.14506-1-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Trieu Huynh <vikingtc4@gmail.com>

vmstate_load_state() contains an assert added in commit
("migration/vmstate: split up vmstate_base_addr" [1])
to catch NULL pointer dereferences early:

  assert(first_elem || !n_elems || !size);

However, the assert fires as an unrecoverable crash in a valid user
scenario, for instance: loading a snapshot saved with -icount auto
into a QEMU started without -icount. The "timer/icount/warp_timer"
subsection is present in the stream, but icount_warp_timer is NULL
because icount was never initialized. QEMU aborts with:

  qemu-system-x86_64: ../migration/vmstate.c:185:
  vmstate_load_state: Assertion `first_elem || !n_elems || !size'
  failed.

Replace the assert with a proper error_setg() and -EINVAL return so
QEMU reports a clear diagnostic instead of crashing.

Also remove the error_prepend() in vmstate_subsection_load() that
wrapped the error at each subsection level, producing a redundant and
noisy error chain. The original error message is now propagated as-is.

[1] https://lore.kernel.org/qemu-devel/20170228124056.5074-4-dgilbert@redhat.com/
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2736

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
Steps to reproduce:
* 1. Start src with icount config:
./qemu-system-x86_64 \
  -icount auto \
  -<other_options>

* 2. Save snapshot
(qemu) savevm snap1

* 3. Start dest without icount config:
./qemu-system-x86_64 \
  -<other_options>

* 4. Load snapshot
* As-is:
~ # QEMU 10.2.94 monitor - type 'help' for more information
(qemu) loadvm snap1
qemu-system-x86_64: ../migration/vmstate.c:185: vmstate_load_state:
Assertion `first_elem || !n_elems || !size' failed.
Aborted (core dumped)

* To-be:
** Before removing error_prepend()
~ # QEMU 10.2.94 monitor - type 'help' for more information
(qemu) loadvm snap1
Error: error while loading state for instance 0x0 of device 'timer':
Loading VM subsection 'timer/icount' in 'timer' failed: -22:
Loading VM subsection 'timer/icount/warp_timer' in 'timer/icount' failed: -22:
VM load of device 'timer/icount/warp_timer': field 'icount_warp_timer'
is a NULL pointer but snapshot contains data for it.

** After removing error_prepend()
~ # QEMU 10.2.94 monitor - type 'help' for more information
(qemu) loadvm snap1
Error: error while loading state for instance 0x0 of device 'timer':
VM load of device 'timer/icount/warp_timer': field 'icount_warp_timer'
is a NULL pointer but snapshot contains data for it.

 migration/vmstate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4d28364f7b..32ecc8ed35 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -182,7 +182,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
-                assert(first_elem || !n_elems || !size);
+                if (!first_elem && n_elems && size) {
+                    error_setg(errp,
+                               "VM load of device '%s': field '%s' is a NULL "
+                               "pointer but snapshot contains data for it.",
+                               vmsd->name, field->name);
+                    return -EINVAL;
+                }
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
@@ -651,9 +657,6 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
-            error_prepend(errp,
-                          "Loading VM subsection '%s' in '%s' failed: %d: ",
-                          idstr, vmsd->name, ret);
             return ret;
         }
     }
-- 
2.43.0


