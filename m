Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8570C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 22:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFgwL-0006a1-F5; Thu, 15 May 2025 18:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwI-0006Xc-Rf
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uFgwD-0000Xn-RA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 18:20:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E2F01F7EF;
 Thu, 15 May 2025 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jPKuBxHBeREsdn7zjPw2/YPqO1WVgcDCcgB1PR0eYE8=;
 b=rNxyHwFfhJhfbwREiwox+fGJnn4cGtxyNKX6f04gUbdkM9k9uv0X/5Cexo/4jtw7vxbfFJ
 QAcbjzTcHJOxM2orUjx8jVK4KrcLbXF0ykqgB7VsUcAoaYqPyzMacJ+d3eLLkPuNBhUbiC
 UvppJ2+vp6FAWuHv7f9qHZiyZxrNNoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jPKuBxHBeREsdn7zjPw2/YPqO1WVgcDCcgB1PR0eYE8=;
 b=mmtzZpQNEbVWrxLcDD9VfUVt0KCRn2/4N+Wn2EfskyUMHHrfNtfdVBoS8Foa+heo3e5+f8
 1+61QjxH7O+ea/Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747347619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jPKuBxHBeREsdn7zjPw2/YPqO1WVgcDCcgB1PR0eYE8=;
 b=rNxyHwFfhJhfbwREiwox+fGJnn4cGtxyNKX6f04gUbdkM9k9uv0X/5Cexo/4jtw7vxbfFJ
 QAcbjzTcHJOxM2orUjx8jVK4KrcLbXF0ykqgB7VsUcAoaYqPyzMacJ+d3eLLkPuNBhUbiC
 UvppJ2+vp6FAWuHv7f9qHZiyZxrNNoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747347619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jPKuBxHBeREsdn7zjPw2/YPqO1WVgcDCcgB1PR0eYE8=;
 b=mmtzZpQNEbVWrxLcDD9VfUVt0KCRn2/4N+Wn2EfskyUMHHrfNtfdVBoS8Foa+heo3e5+f8
 1+61QjxH7O+ea/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEF1813A3E;
 Thu, 15 May 2025 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U735IqFoJmhUNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 May 2025 22:20:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	pbonzini@redhat.com
Subject: [PATCH 0/4] chardev: Fix issues found by vhost-user-test
Date: Thu, 15 May 2025 19:20:10 -0300
Message-Id: <20250515222014.4161-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Running vhost-user-test with ASAN on a loaded machine reveals several
intermittent issues. These show up every time I test the qtest tree so
I'm trying to get rid of them.

1- UAF of IOWatchPoll.
   This one is self explanatory, ASAN caught it.

2- Reference counting issues in glib. It seems it's possible to unref
   a source while adding a callback to it, and glib asserts. This
   shows up on all architectures, only on the ASAN build after
   hundreds of iterations.

3- Extra yank_unregister_function call leads to abort(). This shows up
   on all architectures, but it's quite hidden due to vhost-user-test
   using a dedicated server thread which dies and causes timeouts in
   the test.

   Manifests as assert(s->fds_num) failing. Only on the ASAN build,
   after tens of iterations (quite common).

Thanks

Fabiano Rosas (4):
  chardev: Fix QIOChannel refcount
  chardev: Don't attempt to unregister yank function more than once
  chardev: Consolidate yank registration
  chardev: Introduce a lock for hup_source

 chardev/char-io.c      |  5 +++++
 chardev/char-socket.c  | 38 ++++++++++++--------------------------
 chardev/char.c         |  2 ++
 include/chardev/char.h |  1 +
 4 files changed, 20 insertions(+), 26 deletions(-)

-- 
2.35.3


