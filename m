Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F206C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s00je-0000q4-6a; Thu, 25 Apr 2024 11:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s00jc-0000pn-GT
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:10:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s00ja-0000Sk-RO
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:10:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54A0933E1B;
 Thu, 25 Apr 2024 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714057801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InMLC4PhFIPbAN9VgRqylFHYSfZUji/uT2MdKZI3kKg=;
 b=S+7UTxkUdEzZd3cABHnt8klZdwhrZYERSc7HIa+cUTW+cBWawOJzF1ky7+yKPI5xX2eMsX
 iluarYGl9U+jBb7YWYZtmFNS1LsS3KffrjnnHNBT2DEBh6sp8Ma/b3j85OPpMQCYVL5slU
 jc/9t8zIfpXqHnfppzY1+g4c9v9S008=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714057801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InMLC4PhFIPbAN9VgRqylFHYSfZUji/uT2MdKZI3kKg=;
 b=45I5J8FOdj7xtdIEBbNa9kzpzULLzYHHa3SgV+yZ7s3q38X9NMpcMB1AOY7pge26H9bTGU
 hoyj8cnP2OBtPRDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S+7UTxkU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=45I5J8FO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714057801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InMLC4PhFIPbAN9VgRqylFHYSfZUji/uT2MdKZI3kKg=;
 b=S+7UTxkUdEzZd3cABHnt8klZdwhrZYERSc7HIa+cUTW+cBWawOJzF1ky7+yKPI5xX2eMsX
 iluarYGl9U+jBb7YWYZtmFNS1LsS3KffrjnnHNBT2DEBh6sp8Ma/b3j85OPpMQCYVL5slU
 jc/9t8zIfpXqHnfppzY1+g4c9v9S008=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714057801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InMLC4PhFIPbAN9VgRqylFHYSfZUji/uT2MdKZI3kKg=;
 b=45I5J8FOdj7xtdIEBbNa9kzpzULLzYHHa3SgV+yZ7s3q38X9NMpcMB1AOY7pge26H9bTGU
 hoyj8cnP2OBtPRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED98C1393C;
 Thu, 25 Apr 2024 15:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6PWaLEdyKma9DQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 15:09:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org
Subject: [PATCH 6/6] migration: Deprecate fd: for file migration
Date: Thu, 25 Apr 2024 12:09:39 -0300
Message-Id: <20240425150939.19268-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240425150939.19268-1-farosas@suse.de>
References: <20240425150939.19268-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 54A0933E1B
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

The fd: URI can currently trigger two different types of migration, a
TCP migration using sockets and a file migration using a plain
file. This is in conflict with the recently introduced (8.2) QMP
migrate API that takes structured data as JSON-like format. We cannot
keep the same backend for both types of migration because with the new
API the code is more tightly coupled to the type of transport. This
means a TCP migration must use the 'socket' transport and a file
migration must use the 'file' transport.

If we keep allowing fd: when using a file, this creates an issue when
the user converts the old-style (fd:) to the new style ("transport":
"socket") invocation because the file descriptor in question has
previously been allowed to be either a plain file or a socket.

To avoid creating too much confusion, we can simply deprecate the fd:
+ file usage, which is thought to be rarely used currently and instead
establish a 1:1 correspondence between fd: URI and socket transport,
and file: URI and file transport.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/about/deprecated.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index fadb85f289..11dce324c8 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -484,3 +484,17 @@ both, older and future versions of QEMU.
 The ``blacklist`` config file option has been renamed to ``block-rpcs``
 (to be in sync with the renaming of the corresponding command line
 option).
+
+Migration
+---------
+
+``fd:`` URI when used for file migration (since 9.1)
+''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``fd:`` URI can currently provide a file descriptor that
+references either a socket or a plain file. These are two different
+types of migration. In order to reduce ambiguity, the ``fd:`` URI
+usage of providing a file descriptor to a plain file has been
+deprecated in favor of explicitly using the ``file:`` URI with the
+file descriptor being passed as an ``fdset``. Refer to the ``add-fd``
+command documentation for details on the ``fdset`` usage.
-- 
2.35.3


