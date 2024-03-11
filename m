Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA69C54E66
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 23:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjpA3-0007zb-Uh; Mon, 11 Mar 2024 19:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjp9z-0007yq-Li
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 19:34:23 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjp9k-0003M6-PZ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 19:34:23 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A7CA3522A;
 Mon, 11 Mar 2024 23:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710200046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NeM1wNgFcDgc9ZqZAYa78ykTKvkW83TTet6clmvxyXc=;
 b=DuS0R8r/BamBD9K96kY8k+9WFVRtiftszsv3nTLNEfksbHcagXeUhwnykBIo6xx3GweAmS
 toaMHSkxnRV1TMATgMDxMaZtxpVzPCgNiAMv+rB22o9YNDW8NW4uv1YpcVE59nCVQ/fZIN
 GT7nfesRG3EJrI7vj8v4Qn5fwkXo9p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710200046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NeM1wNgFcDgc9ZqZAYa78ykTKvkW83TTet6clmvxyXc=;
 b=TtaTfwRf0extpbVUKOZ9UW1w5LUta4U5kqq8RIFxuId5SHPQKTHs5zGBqIpOdZG9/Fp9Zl
 wlxklzNySjZDR4CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710200046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NeM1wNgFcDgc9ZqZAYa78ykTKvkW83TTet6clmvxyXc=;
 b=DuS0R8r/BamBD9K96kY8k+9WFVRtiftszsv3nTLNEfksbHcagXeUhwnykBIo6xx3GweAmS
 toaMHSkxnRV1TMATgMDxMaZtxpVzPCgNiAMv+rB22o9YNDW8NW4uv1YpcVE59nCVQ/fZIN
 GT7nfesRG3EJrI7vj8v4Qn5fwkXo9p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710200046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NeM1wNgFcDgc9ZqZAYa78ykTKvkW83TTet6clmvxyXc=;
 b=TtaTfwRf0extpbVUKOZ9UW1w5LUta4U5kqq8RIFxuId5SHPQKTHs5zGBqIpOdZG9/Fp9Zl
 wlxklzNySjZDR4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D18F13695;
 Mon, 11 Mar 2024 23:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cLyzEOyU72VSEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 23:34:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] migration: mapped-ram fixes
Date: Mon, 11 Mar 2024 20:33:33 -0300
Message-Id: <20240311233335.17299-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.42 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.12)[67.11%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Here are the fixes for the dup() issues found by Coverity.

@Peter Xu, I fixed the leak you found, but I'm holding on to that patch
because I noticed we're not freeing the ioc in the error paths. I'll
need to add some infrastructure to be able to cancel the glib polling
(qio_channel_add_watch_full) when the channel creation fails before
the source has connnected.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1209529440

Fabiano Rosas (2):
  io: Introduce qio_channel_file_new_dupfd
  migration: Fix error handling after dup in file migration

 include/io/channel-file.h | 18 ++++++++++++++++++
 io/channel-file.c         | 12 ++++++++++++
 migration/fd.c            |  9 ++++-----
 migration/file.c          | 14 +++++++-------
 4 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.35.3


