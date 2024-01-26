Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB732C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUYK-0006U5-Vf; Fri, 26 Jan 2024 17:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYI-0006TG-8a
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:58 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rTUYE-00021x-7A
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:19:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 129CE1F899;
 Fri, 26 Jan 2024 22:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eQajHzT1DkQVKtwboR/g1iq6rctr37kaU6l3q0j7J9I=;
 b=oEdCLOvDFKm0kjnHnh3bRm9MWi0lugsnzXbVwXuynnTxkDWhYJipXmckxagm7ZlLKujQVp
 6koLTZRVK6WrV0DzqISyx4P1rtKWSRUqE4cr4EKQlKp7IGFkoGC4gJL7B/poccuzfBY1Pj
 r9tO2l/OjsppVs948xAz9mZvioxE8O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eQajHzT1DkQVKtwboR/g1iq6rctr37kaU6l3q0j7J9I=;
 b=P5dkZOXIZ63abXJI023Ai+ed/tvOu+UJtSDfA/j06KDV1tcZFUHxHylYFHeE3TBAy/3gX5
 2BjAdbVxjhSw0PAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706307588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eQajHzT1DkQVKtwboR/g1iq6rctr37kaU6l3q0j7J9I=;
 b=oEdCLOvDFKm0kjnHnh3bRm9MWi0lugsnzXbVwXuynnTxkDWhYJipXmckxagm7ZlLKujQVp
 6koLTZRVK6WrV0DzqISyx4P1rtKWSRUqE4cr4EKQlKp7IGFkoGC4gJL7B/poccuzfBY1Pj
 r9tO2l/OjsppVs948xAz9mZvioxE8O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706307588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eQajHzT1DkQVKtwboR/g1iq6rctr37kaU6l3q0j7J9I=;
 b=P5dkZOXIZ63abXJI023Ai+ed/tvOu+UJtSDfA/j06KDV1tcZFUHxHylYFHeE3TBAy/3gX5
 2BjAdbVxjhSw0PAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7719713A22;
 Fri, 26 Jan 2024 22:19:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rQO+DwIwtGWScwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Jan 2024 22:19:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 0/5] migration/multifd: Prerequisite cleanups for ongoing work
Date: Fri, 26 Jan 2024 19:19:38 -0300
Message-Id: <20240126221943.26628-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Hi,

Here are two cleanups that are prerequiste for the fixed-ram work, but
also affect the other series on the list at the moment, so I want to
make sure it works for everyone:

1) Separate multifd_ops from compression. The multifd_ops are
   currently coupled with the multifd_compression parameter.

We're adding new multifd_ops in the fixed-ram work and adding new
compression ops in the compression work.

2) Add a new send hook. The multifd_send_thread code currently does
   some twists to support zero copy, which is a socket-only feature.

This might affect the zero page and DSA work which add code to
multifd_send_thread.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1154332360

(I also tested zero copy locally. We cannot add a test for it because
it needs root due to memory locking limits)

Fabiano Rosas (5):
  migration/multifd: Separate compression ops from non-compression
  migration/multifd: Move multifd_socket_ops to socket.c
  migration/multifd: Add multifd_ops->send
  migration/multifd: Simplify zero copy send
  migration/multifd: Move zero copy flag into multifd_socket_setup

 migration/multifd-zlib.c |   9 ++-
 migration/multifd-zstd.c |   9 ++-
 migration/multifd.c      | 164 +++++----------------------------------
 migration/multifd.h      |   6 +-
 migration/socket.c       |  90 ++++++++++++++++++++-
 5 files changed, 128 insertions(+), 150 deletions(-)

-- 
2.35.3


