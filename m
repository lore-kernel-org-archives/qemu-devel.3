Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B411AC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 13:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0LPb-0002zS-7z; Fri, 26 Apr 2024 09:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0LPP-0002x5-7u
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:14:38 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s0LPL-0001eg-V4
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:14:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9971934DE2;
 Fri, 26 Apr 2024 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714137270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9K1RFpCbFkI/wQkeuDSMOO9cC8tN4qS2q4gfFh8pIpo=;
 b=qknbQr9SS1bWF2zg1LuQMRdf1A4KxazGqVstVd761Gg/nxLk+sFF5aSMHyRE9/o6O6Dajn
 9qIy7lSIm757/9RkGRpveS3UrGeQGLtA21/S0g80ZrZmaQBNl/OXol5OTseDMWnitUsCL5
 rwZp9DMlGovLzR/E5qtxoQwqgGkWzTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714137270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9K1RFpCbFkI/wQkeuDSMOO9cC8tN4qS2q4gfFh8pIpo=;
 b=+1eBle7DMdg5m7RDGaiZKd3Yza5LjWZWEmAegEnvr1YKMoJsi5R0ZE7xHeUZLaI0OYqqO+
 LLlwWpG7GylHabAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qknbQr9S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+1eBle7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714137270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9K1RFpCbFkI/wQkeuDSMOO9cC8tN4qS2q4gfFh8pIpo=;
 b=qknbQr9SS1bWF2zg1LuQMRdf1A4KxazGqVstVd761Gg/nxLk+sFF5aSMHyRE9/o6O6Dajn
 9qIy7lSIm757/9RkGRpveS3UrGeQGLtA21/S0g80ZrZmaQBNl/OXol5OTseDMWnitUsCL5
 rwZp9DMlGovLzR/E5qtxoQwqgGkWzTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714137270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9K1RFpCbFkI/wQkeuDSMOO9cC8tN4qS2q4gfFh8pIpo=;
 b=+1eBle7DMdg5m7RDGaiZKd3Yza5LjWZWEmAegEnvr1YKMoJsi5R0ZE7xHeUZLaI0OYqqO+
 LLlwWpG7GylHabAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CDCF1398B;
 Fri, 26 Apr 2024 13:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uGZTAbWoK2bcXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Apr 2024 13:14:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, devel@lists.libvirt.org
Subject: [PATCH v2 6/6] migration: Deprecate fd: for file migration
Date: Fri, 26 Apr 2024 10:14:08 -0300
Message-Id: <20240426131408.25410-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240426131408.25410-1-farosas@suse.de>
References: <20240426131408.25410-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9971934DE2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
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
index 0fb5c82640..813f7996fe 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -464,3 +464,17 @@ both, older and future versions of QEMU.
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


