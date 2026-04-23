Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F361FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcu-0004xc-GF; Thu, 23 Apr 2026 15:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcA-0002OC-1i
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:31 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzc8-0001y8-Cu
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3A6B5BD62;
 Thu, 23 Apr 2026 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3tdehQEFkrIn/2FNGCIRkVgGSAZaOiQ4sokOcOKXPw=;
 b=qpUgwWCDtw11grVlzevzRdW6SbtQQdQtqfPI3udSn80ywu5W4YRilwBuCmz234qFXKc1Rs
 tZuBbo0ZPlY0hMj1byLwt49cAzmkTaKaJCR0K5to3uYpRHgPOBxfpmbHZZFAYkjFlqf/c9
 GZFifW1auWCmB1/q16Oq5ZFYbUOt3PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3tdehQEFkrIn/2FNGCIRkVgGSAZaOiQ4sokOcOKXPw=;
 b=cwS0bR33Mk3jIMfQogvN32ivVso9ohCgGI+tipQQfaoncbErk4dY6TFB2S5i3zRsKj4rTD
 SHq2YnNW7IFJGPDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qpUgwWCD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cwS0bR33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3tdehQEFkrIn/2FNGCIRkVgGSAZaOiQ4sokOcOKXPw=;
 b=qpUgwWCDtw11grVlzevzRdW6SbtQQdQtqfPI3udSn80ywu5W4YRilwBuCmz234qFXKc1Rs
 tZuBbo0ZPlY0hMj1byLwt49cAzmkTaKaJCR0K5to3uYpRHgPOBxfpmbHZZFAYkjFlqf/c9
 GZFifW1auWCmB1/q16Oq5ZFYbUOt3PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3tdehQEFkrIn/2FNGCIRkVgGSAZaOiQ4sokOcOKXPw=;
 b=cwS0bR33Mk3jIMfQogvN32ivVso9ohCgGI+tipQQfaoncbErk4dY6TFB2S5i3zRsKj4rTD
 SHq2YnNW7IFJGPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C105593A3;
 Thu, 23 Apr 2026 19:20:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UGyOCgVx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 25/43] vmstate: Pass in struct itself for
 VMSTATE_VARRAY_OF_POINTER_UINT32
Date: Thu, 23 Apr 2026 16:19:39 -0300
Message-ID: <20260423191958.1440-26-farosas@suse.de>
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
X-Rspamd-Queue-Id: C3A6B5BD62
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Passing in a pointer almost never helps.  Convert it to pass in struct for
further refactoring on VMS_ARRAY_OF_POINTER.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260401202844.673494-3-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/hw/intc/riscv_aclint.h | 6 +++---
 include/migration/vmstate.h    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 5310615cbf..0e0b98acb0 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -80,8 +80,8 @@ enum {
     RISCV_ACLINT_SWI_SIZE              = 0x4000
 };
 
-#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
-VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
-                                                        QEMUTimer *)
+#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                          \
+    VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
+                                     QEMUTimer)
 
 #endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d4880e75c2..32bb8e8ebc 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -567,9 +567,9 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                             \
     .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
     .info       = &(_info),                                               \
-    .size       = sizeof(_type),                                          \
+    .size       = sizeof(_type *),                                          \
     .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
-    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
+    .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
 }
 
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
-- 
2.51.0


