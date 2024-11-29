Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5234D6EC07
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH0uS-0001u8-9T; Fri, 29 Nov 2024 08:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH0uO-0001tc-Mg
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:19:44 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH0uN-0005kr-1h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 08:19:44 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 487DD21134;
 Fri, 29 Nov 2024 13:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732886380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqFCi2SQT9VtrOf3vYF6ZliVF0o4ppfImsi9vt/yK0Y=;
 b=QqCzs7R/NHUkJvG0FmIn9TmuQKT+B7EOgZ8XNX3fmuLcNSdOtMY5RSDpwINdWqtTzS3zV2
 FzAEn+vmdmcLtqmyrtyIaCzCR3aSyvohX0jRyceQ2gppZsULQryEH3dSbsHdZRKRhRXrjg
 tX5X39WMegs75Wno8J5+WYtjMUYkKy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732886380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqFCi2SQT9VtrOf3vYF6ZliVF0o4ppfImsi9vt/yK0Y=;
 b=Dknu0qSkljG5bkXy2yVaKRK6hclQtsQoZwsa60DkYYdbAcHT0Oj+E9p3pR6jcAgKVowUnp
 E+ieSdIL+0QLZaCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FDB24+r4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gaz2tr3Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732886379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqFCi2SQT9VtrOf3vYF6ZliVF0o4ppfImsi9vt/yK0Y=;
 b=FDB24+r4Gx0aktxh5D9uVzkqWL+2ZrneCVP9XgBVbK006kK6KcsiRkC/awu1pkDGvMvo+b
 Tou52wtXS9ep/en1nuL3N42ZuhDtfxnKzJ3NVQltLtxMljUIO711FwKdVwCeFI6McIh/ko
 KCQZ1HuJjipqJd8hBARrB6unSSHTj+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732886379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqFCi2SQT9VtrOf3vYF6ZliVF0o4ppfImsi9vt/yK0Y=;
 b=Gaz2tr3QhfF7EVLVhdHwmv+Y3Dp2CWInZ6goh8x28nO5ma6EVK8GMiNPLkHMMB6lctZphs
 cKwL1ipjPOT5CEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFD6C139AA;
 Fri, 29 Nov 2024 13:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FUalIGq/SWc/HQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 Nov 2024 13:19:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v3 03/17] tests/migration: Disambiguate guestperf vs. a-b
In-Reply-To: <20241127182901.529-4-farosas@suse.de>
References: <20241127182901.529-1-farosas@suse.de>
 <20241127182901.529-4-farosas@suse.de>
Date: Fri, 29 Nov 2024 10:19:36 -0300
Message-ID: <87serajhxz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 487DD21134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> The current build structure for migration tests is confusing. There is
> the tests/migration directory, which contains two different guest code
> implementations, one for the qtests (a-b-{bootblock|kernel}.S) and
> another for the guestperf script (stress.c). One uses a Makefile,
> while the other uses meson.
>
> The next patches will add a new qtests/migration/ directory to hold
> qtest code which will make the situation even more confusing.
>
> Move the guest code used by qtests into a new qtests/migration/
> directory and rename the old one to tests/migration-stress.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Please squash this in:

-->8--
From 9f8a693e31be198e1e052d86be99ffaaa0a3e8a8 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Fri, 29 Nov 2024 10:05:21 -0300
Subject: [PATCH] fixup! tests/migration: Disambiguate guestperf vs. a-b

---
 tests/migration-stress/guestperf/shell.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/migration-stress/guestperf/shell.py b/tests/migration-stress/guestperf/shell.py
index c85d89efec..046afeb84e 100644
--- a/tests/migration-stress/guestperf/shell.py
+++ b/tests/migration-stress/guestperf/shell.py
@@ -46,7 +46,8 @@ def __init__(self):
         parser.add_argument("--binary", dest="binary", default="/usr/bin/qemu-system-x86_64")
         parser.add_argument("--dst-host", dest="dst_host", default="localhost")
         parser.add_argument("--kernel", dest="kernel", default="/boot/vmlinuz-%s" % platform.release())
-        parser.add_argument("--initrd", dest="initrd", default="tests/migration/initrd-stress.img")
+        parser.add_argument("--initrd", dest="initrd",
+                            default="tests/migration-stress/initrd-stress.img")
         parser.add_argument("--transport", dest="transport", default="unix")
 
 
-- 
2.35.3


