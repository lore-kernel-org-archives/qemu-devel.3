Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC12E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkcP-0007v8-Kk; Mon, 09 Dec 2024 15:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcN-0007uG-91
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:35 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tKkcL-0003vv-OB
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:44:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B08C21164
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2024 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+cHXMsQcEvRVgzUUjDLticY6pUewHL3nKkRBpNsB04I=;
 b=wOmSkRFck5dz9eKAsQn8c7y8Pb4Y2zKpBePEshBWbW7Jrr/fY/pAjslrFDtkd2lGOZgWNw
 loozyoeUz/JM+evtMhSl7tMYqUonKU+JQE0QVH08E7TnhY11xRAYlvYrXZCBiPQm/lSkqL
 BwWMciezSAPJ7F1dGuOo9abx/XBuCgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+cHXMsQcEvRVgzUUjDLticY6pUewHL3nKkRBpNsB04I=;
 b=DcucpEwsm0qantHm74EmgHMKNCCgeosBE742lYQ7+1pXpgogD7LVROpakvvFGK46Kx2F9x
 4Evl+DQpLQD2ucDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wOmSkRFc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DcucpEws
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733777071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+cHXMsQcEvRVgzUUjDLticY6pUewHL3nKkRBpNsB04I=;
 b=wOmSkRFck5dz9eKAsQn8c7y8Pb4Y2zKpBePEshBWbW7Jrr/fY/pAjslrFDtkd2lGOZgWNw
 loozyoeUz/JM+evtMhSl7tMYqUonKU+JQE0QVH08E7TnhY11xRAYlvYrXZCBiPQm/lSkqL
 BwWMciezSAPJ7F1dGuOo9abx/XBuCgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733777071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+cHXMsQcEvRVgzUUjDLticY6pUewHL3nKkRBpNsB04I=;
 b=DcucpEwsm0qantHm74EmgHMKNCCgeosBE742lYQ7+1pXpgogD7LVROpakvvFGK46Kx2F9x
 4Evl+DQpLQD2ucDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE3A7138D2
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2024 20:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TLT+I65WV2ebbwAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 20:44:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] qtest: Fix some memory issues
Date: Mon,  9 Dec 2024 17:44:21 -0300
Message-Id: <20241209204427.17763-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B08C21164
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

I'm trying to get the qtests to run with asan/valgrind without any
warnings so I can run a test before every PR. Here are a few fixes.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1580782506

Fabiano Rosas (6):
  tests/qtest/migration: Do proper cleanup in the dirty_limit test
  tests/qtest/migration: Initialize buffer in probe_o_direct_support
  tests/qtest/bios-tables-test: Free tables at dump_aml_files
  tests/qtest/virtio-iommu-test: Don't pass uninitialized data into
    qtest_memwrite
  tests/qtest/qos-test: Plug a couple of leaks
  tests/qtest/test-x86-cpuid-compat: Free allocated memory

 tests/qtest/bios-tables-test.c      |  1 +
 tests/qtest/migration-helpers.c     |  1 +
 tests/qtest/migration-test.c        |  5 +++++
 tests/qtest/qos-test.c              | 35 ++++++++++++++++++++---------
 tests/qtest/test-x86-cpuid-compat.c |  4 ++++
 tests/qtest/virtio-iommu-test.c     |  4 ++--
 6 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.35.3


