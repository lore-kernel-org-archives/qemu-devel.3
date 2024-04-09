Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1ADC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCwf-0001iT-GU; Tue, 09 Apr 2024 10:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwd-0001hg-R9; Tue, 09 Apr 2024 10:59:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwc-0005st-9b; Tue, 09 Apr 2024 10:59:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2E8333A56;
 Tue,  9 Apr 2024 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4t2aH2iKWUlJYkBhU1yzSeFXAMp0nqmYIhFgYQ3imc=;
 b=noxhu/+NEKPkMkQ1zqTzNs0UPPkkqJbjV5moEbWjH2koe0fG64deFF8Kh0OCCptB+MM5j0
 UQtR1cRShzbvOUyzDyU8hUJXPrSPN6KIl8Il+IRa2dzMU6Nj2EVN1q7WMPeCTixPv2y6ge
 juIzMOJlYHceEtfcQ4YNmhhI0eiV6s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4t2aH2iKWUlJYkBhU1yzSeFXAMp0nqmYIhFgYQ3imc=;
 b=4NM3xVWjUB+VSGOs0s5GB7yOKluIbgPzKQb74o4Sa85qbmmNIUNIs5DP65jzjpfjZN5DT4
 D5cKStuo7JX9MUCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qdALqJ3f;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gPciXh25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4t2aH2iKWUlJYkBhU1yzSeFXAMp0nqmYIhFgYQ3imc=;
 b=qdALqJ3fnBb53dIUsGHsXXbPMkVMUIlWCeP5zAzGQMsuVElaBy33SY1tELquGvdtPu8ngV
 C5vk6TrqwOz9t9dbCLs2AoIq9uwWDMeSVHWkymK94OQk5Sp7X7OsYgvWbcLI9geumRKqQL
 +Tfr87AL47FG+BixzNtnwRfL9chYaz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4t2aH2iKWUlJYkBhU1yzSeFXAMp0nqmYIhFgYQ3imc=;
 b=gPciXh25fLSCCOcfTtYuR/UBvVNA5gg4WsOmOL7aA/rvsT/1mTbck5CxMZSwgCWCFabwfx
 UB48R8FYMjZVwVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4039413313;
 Tue,  9 Apr 2024 14:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EHc6AsxXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 01/11] block: Allow the wrapper script to see functions
 declared in qapi.h
Date: Tue,  9 Apr 2024 11:59:07 -0300
Message-Id: <20240409145917.6780-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[14];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E2E8333A56
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The following patches will add co_wrapper annotations to functions
declared in qapi.h. Add that header to the set of files used by
block-coroutine-wrapper.py.

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/meson.build                  | 1 +
 scripts/block-coroutine-wrapper.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/meson.build b/block/meson.build
index e1f03fd773..8fe684d301 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -154,6 +154,7 @@ block_gen_c = custom_target('block-gen.c',
                                       '../include/block/dirty-bitmap.h',
                                       '../include/block/block_int-io.h',
                                       '../include/block/block-global-state.h',
+                                      '../include/block/qapi.h',
                                       '../include/sysemu/block-backend-global-state.h',
                                       '../include/sysemu/block-backend-io.h',
                                       'coroutines.h'
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index dbbde99e39..067b203801 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -44,6 +44,7 @@ def gen_header():
 #include "block/block-gen.h"
 #include "block/block_int.h"
 #include "block/dirty-bitmap.h"
+#include "block/qapi.h"
 """
 
 
-- 
2.35.3


