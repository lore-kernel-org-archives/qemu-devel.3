Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06176C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehdY-00059b-9b; Mon, 26 Feb 2024 15:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehdL-000579-G8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:31:34 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rehdJ-0001lw-Rw
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:31:31 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 446BB2266F;
 Mon, 26 Feb 2024 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708979486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W50IL56jNpF4og7QvhGlGWbPtom7E1VEJ9H8VrmxkSw=;
 b=ek7lcUICrcl6zdGRVa6giYjARloTkYOc7ElWWZZbLQKaePaHarloNUdc3qhGn/rxbgNZK7
 1j26YsBZJfqXBj1ZNM2AnZGW+Xu62WveYYZOFW1rr3dMswW0QsK38wZv1wfJxglmoyQeW0
 Hu7nKdYitdUd2XQ8x+HOFepgJ9kFNXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708979486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W50IL56jNpF4og7QvhGlGWbPtom7E1VEJ9H8VrmxkSw=;
 b=/wq5jLJb7sZ0q37NeURD05IoGFY0ZCD1bGkHvhKvJmpo+2RtXxUaV4LZI0f1DBe+OtDt/4
 Vw3rad8PMFfeP1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708979486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W50IL56jNpF4og7QvhGlGWbPtom7E1VEJ9H8VrmxkSw=;
 b=ek7lcUICrcl6zdGRVa6giYjARloTkYOc7ElWWZZbLQKaePaHarloNUdc3qhGn/rxbgNZK7
 1j26YsBZJfqXBj1ZNM2AnZGW+Xu62WveYYZOFW1rr3dMswW0QsK38wZv1wfJxglmoyQeW0
 Hu7nKdYitdUd2XQ8x+HOFepgJ9kFNXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708979486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W50IL56jNpF4og7QvhGlGWbPtom7E1VEJ9H8VrmxkSw=;
 b=/wq5jLJb7sZ0q37NeURD05IoGFY0ZCD1bGkHvhKvJmpo+2RtXxUaV4LZI0f1DBe+OtDt/4
 Vw3rad8PMFfeP1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CB3013A3A;
 Mon, 26 Feb 2024 20:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IQpFNRz13GWJSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 20:31:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/2] migration: Fix RP shutdown order
Date: Mon, 26 Feb 2024 17:31:20 -0300
Message-Id: <20240226203122.22894-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ek7lcUIC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/wq5jLJb"
X-Spamd-Result: default: False [-1.00 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.19)[70.82%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 446BB2266F
X-Spamd-Bar: /
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These were extracted from:
[PATCH 00/14] migration: Improve error reporting
https://lore.kernel.org/r/20240207133347.1115903-1-clg@redhat.com

We're currently relying on the presence of a QEMUFile error in the
to_dst_file to infer whether the return path file (rp_state.from_dst_file)
might be hanging at a recvmsg() system call.

This has always been buggy because we actually clear the to_dst_file
pointer and close the file before attempting any of the above.

Move the RP cleanup before the to_dst_file cleanup, at both the
migrate_fd_cleanup() and postcopy_pause() paths to make sure we
reference a valid and open to_dst_file.

Also replace the error checking to use s->error instead of
f->last_error. This removes one more dependency on
QEMUFile::last_error.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1191131909

Cédric Le Goater (1):
  migration: Use migrate_has_error() in close_return_path_on_source()

Fabiano Rosas (1):
  migration: Join the return path thread before releasing to_dst_file

 migration/migration.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

-- 
2.35.3


