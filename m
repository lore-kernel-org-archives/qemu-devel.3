Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B64FDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzdE-0005kl-0p; Thu, 23 Apr 2026 15:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcb-0004L9-Ic
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcY-0002Af-2Y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:55 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A4E06A894;
 Thu, 23 Apr 2026 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTPFHDxtJ9FnO+BjlFenJ4bFm2rrC6F0pyANu2MHGgQ=;
 b=mOA0EGxLByaYagKQPOT69mnk/ESKNJWTKAbEuZ6QfWC9kMe8G62X/8rQdSsiN5hZ2VrSM+
 1EZCq/EGF+am2t7bZ91H0nDFn/yjHibxvNt/OvpTfQwrRxux6OR1Aa3nziSzqN6GaoMDuJ
 /16hxIfaHuHAQBZ42s2r01rYgxDagLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTPFHDxtJ9FnO+BjlFenJ4bFm2rrC6F0pyANu2MHGgQ=;
 b=nZOpcn6egVYNO3J0jILBSY+c10dg0qxTnLjO9Z/GpIGMhCbj0qQSE4tqzH4t2X0xvQi8ld
 Y/MP6FsyaOd8WRCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mOA0EGxL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nZOpcn6e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTPFHDxtJ9FnO+BjlFenJ4bFm2rrC6F0pyANu2MHGgQ=;
 b=mOA0EGxLByaYagKQPOT69mnk/ESKNJWTKAbEuZ6QfWC9kMe8G62X/8rQdSsiN5hZ2VrSM+
 1EZCq/EGF+am2t7bZ91H0nDFn/yjHibxvNt/OvpTfQwrRxux6OR1Aa3nziSzqN6GaoMDuJ
 /16hxIfaHuHAQBZ42s2r01rYgxDagLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTPFHDxtJ9FnO+BjlFenJ4bFm2rrC6F0pyANu2MHGgQ=;
 b=nZOpcn6egVYNO3J0jILBSY+c10dg0qxTnLjO9Z/GpIGMhCbj0qQSE4tqzH4t2X0xvQi8ld
 Y/MP6FsyaOd8WRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 971BC593A3;
 Thu, 23 Apr 2026 19:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8JzwGApx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 28/43] vmstate: Rename VMS_NULLPTR_MARKER to VMS_MARKER_PTR_NULL
Date: Thu, 23 Apr 2026 16:19:42 -0300
Message-ID: <20260423191958.1440-29-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0A4E06A894
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Prepare for a new MARKER for non-NULL pointer.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-6-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h | 2 +-
 migration/vmstate-types.c   | 4 ++--
 tests/unit/test-vmstate.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 350e62a55a..7396e38531 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -283,7 +283,7 @@ extern const VMStateInfo vmstate_info_uint64;
 extern const VMStateInfo vmstate_info_fd;
 
 /** Put this in the stream when migrating a null pointer.*/
-#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
+#define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
 extern const VMStateInfo vmstate_info_nullptr;
 
 extern const VMStateInfo vmstate_info_cpudouble;
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 23f3433696..7622cf8f01 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -363,7 +363,7 @@ static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
                          const VMStateField *field, Error **errp)
 
 {
-    if (qemu_get_byte(f) == VMS_NULLPTR_MARKER) {
+    if (qemu_get_byte(f) == VMS_MARKER_PTR_NULL) {
         return true;
     }
 
@@ -377,7 +377,7 @@ static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
 
 {
     if (pv == NULL) {
-        qemu_put_byte(f, VMS_NULLPTR_MARKER);
+        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
         return true;
     }
 
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 6a42cc1a4e..dae15786aa 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -620,7 +620,7 @@ static void test_arr_ptr_str_no0_load(void)
 
 static uint8_t wire_arr_ptr_0[] = {
     0x00, 0x00, 0x00, 0x00,
-    VMS_NULLPTR_MARKER,
+    VMS_MARKER_PTR_NULL,
     0x00, 0x00, 0x00, 0x02,
     0x00, 0x00, 0x00, 0x03,
     QEMU_VM_EOF
-- 
2.51.0


