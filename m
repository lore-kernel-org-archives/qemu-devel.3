Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3DCCF3959
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 15:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srIjg-0007ip-9O; Thu, 19 Sep 2024 11:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srIjd-0007aT-V9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:06:22 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1srIja-0007lZ-Jb
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:06:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48C4233949;
 Thu, 19 Sep 2024 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726758375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F6DnHWLW1NzJhVOkLCp/8BfsqV0+GSrxsZe/u+cUp+Q=;
 b=uh7Mx3pOQSuuzCqvE20Zjcu25BQ+4ol/UmIlToQriqZJdcPXNZ0gX0Xpjcmsm8zrjQuWOH
 ybiQw65G7ZotzfepxHmpXVf29cE57kmI1Vlkuv6ygG9eRInKUaC1G5gsPKGzSQHZ9Da9A1
 31eFMihhWMYRuYLRCbd7aqNuePvq0tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726758375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F6DnHWLW1NzJhVOkLCp/8BfsqV0+GSrxsZe/u+cUp+Q=;
 b=me2TunaV/AKfihtsVHecLy3WKJxrbZIAeuj0xeLV9jb3LJ7Tvjg3oOmoe04k533LaTIpYb
 A04uN4iYZKbKCfCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726758375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F6DnHWLW1NzJhVOkLCp/8BfsqV0+GSrxsZe/u+cUp+Q=;
 b=uh7Mx3pOQSuuzCqvE20Zjcu25BQ+4ol/UmIlToQriqZJdcPXNZ0gX0Xpjcmsm8zrjQuWOH
 ybiQw65G7ZotzfepxHmpXVf29cE57kmI1Vlkuv6ygG9eRInKUaC1G5gsPKGzSQHZ9Da9A1
 31eFMihhWMYRuYLRCbd7aqNuePvq0tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726758375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F6DnHWLW1NzJhVOkLCp/8BfsqV0+GSrxsZe/u+cUp+Q=;
 b=me2TunaV/AKfihtsVHecLy3WKJxrbZIAeuj0xeLV9jb3LJ7Tvjg3oOmoe04k533LaTIpYb
 A04uN4iYZKbKCfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 239A613A1E;
 Thu, 19 Sep 2024 15:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ydnCNuU97Ga0WwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Sep 2024 15:06:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] migration/multifd: Ensure packet->ramblock is null-terminated
Date: Thu, 19 Sep 2024 12:06:11 -0300
Message-Id: <20240919150611.17074-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Coverity points out that the current usage of strncpy to write the
ramblock name allows the field to not have an ending '\0' in case
idstr is already not null-terminated (e.g. if it's larger than 256
bytes).

This is currently harmless because the packet->ramblock field is never
touched again on the source side. The destination side reads only up
to the field's size from the stream and forces the last byte to be 0.

We're still open to a programming error in the future in case this
field is ever passed into a function that expects a null-terminated
string.

Change from strncpy to QEMU's pstrcpy, which puts a '\0' at the end of
the string and doesn't fill the extra space with zeros.

(there's no spillage between iterations of fill_packet because after
commit 87bb9e953e ("migration/multifd: Isolate ram pages packet data")
the packet is always zeroed before filling)

Resolves: Coverity CID 1560071
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 07c63f4a72..55191152f9 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -17,6 +17,7 @@
 #include "multifd.h"
 #include "options.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -201,7 +202,8 @@ void multifd_ram_fill_packet(MultiFDSendParams *p)
     packet->zero_pages = cpu_to_be32(zero_num);
 
     if (pages->block) {
-        strncpy(packet->ramblock, pages->block->idstr, 256);
+        pstrcpy(packet->ramblock, sizeof(packet->ramblock),
+                pages->block->idstr);
     }
 
     for (int i = 0; i < pages->num; i++) {
-- 
2.35.3


