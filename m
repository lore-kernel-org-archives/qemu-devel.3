Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50781C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPL1-0001QH-E5; Fri, 07 Feb 2025 09:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPKw-0001P9-Kz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:08 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPKu-0007f3-9c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FA791F45A;
 Fri,  7 Feb 2025 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v6Ai/7bP5tmA4IzgQuemzID5rsAWSaJ2kOKVvpW8Q2U=;
 b=xkSD9lv2e6WCIurcLJbdpbFPss00kIOXzlWSCLQPEfTlUHoQvzJrq6EhSOSDo/SNyQXYHA
 uyXHxW9MXVinCv2L9sA9bzPfnWpa0mm4OwUAbbSoNIgdcIY7NNlPF4x1S3fb/PyEPUivSG
 78jiKGNsA0PIyUPJPuUpsIe3gN9lSAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v6Ai/7bP5tmA4IzgQuemzID5rsAWSaJ2kOKVvpW8Q2U=;
 b=MgqBFJ80tP2Afjir9QjiOjAPSX8rvvy973+mqoIZQGZ0qWyOMbdbVv6YKFUVGdhYswuGJm
 Sk8MA1hUhTIf5eCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v6Ai/7bP5tmA4IzgQuemzID5rsAWSaJ2kOKVvpW8Q2U=;
 b=xkSD9lv2e6WCIurcLJbdpbFPss00kIOXzlWSCLQPEfTlUHoQvzJrq6EhSOSDo/SNyQXYHA
 uyXHxW9MXVinCv2L9sA9bzPfnWpa0mm4OwUAbbSoNIgdcIY7NNlPF4x1S3fb/PyEPUivSG
 78jiKGNsA0PIyUPJPuUpsIe3gN9lSAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v6Ai/7bP5tmA4IzgQuemzID5rsAWSaJ2kOKVvpW8Q2U=;
 b=MgqBFJ80tP2Afjir9QjiOjAPSX8rvvy973+mqoIZQGZ0qWyOMbdbVv6YKFUVGdhYswuGJm
 Sk8MA1hUhTIf5eCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE293139CB;
 Fri,  7 Feb 2025 14:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kqhOKnAYpmcoOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 14:28:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v2 0/8] crypto,io,migration: Add support to gnutls_bye()
Date: Fri,  7 Feb 2025 11:27:50 -0300
Message-Id: <20250207142758.6936-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

v2:

Added the premature_ok logic;
Added compat property for QEMU <9.1;
Refactored the existing handshake code;

CI run:
https://gitlab.com/farosas/qemu/-/pipelines/1660800456

v1:
https://lore.kernel.org/r/20250206175824.22664-1-farosas@suse.de

Hi,

We've been discussing a way to stop multifd recv threads from getting
an error at the end of migration when the source threads close the
iochannel without ending the TLS session.

The original issue was introduced by commit 1d457daf86
("migration/multifd: Further remove the SYNC on complete") which
altered the synchronization of the source and destination in a manner
that causes the destination to already be waiting at recv() when the
source closes the connection.

One approach would be to issue gnutls_bye() at the source after all
the data has been sent. The destination would then gracefully exit
when it gets EOF.

Aside from stopping the recv thread from seeing an error, this also
creates a contract that all connections should be closed only after
the TLS session is ended. This helps to avoid masking a legitimate
issue where the connection is closed prematurely.

Fabiano Rosas (8):
  crypto: Allow gracefully ending the TLS session
  io: tls: Add qio_channel_tls_bye
  migration/multifd: Terminate the TLS connection
  migration: Check migration error after loadvm
  crypto: Remove qcrypto_tls_session_get_handshake_status
  io: Plumb read flags into qio_channel_read_all_eof
  io: Add a read flag for relaxed EOF
  migration/multifd: Add a compat property for TLS termination

 crypto/tlssession.c                 | 105 +++++++++++++++++-----------
 hw/remote/mpqemu-link.c             |   2 +-
 include/crypto/tlssession.h         |  46 ++++++------
 include/io/channel-tls.h            |  12 ++++
 include/io/channel.h                |   7 ++
 io/channel-tls.c                    |  92 +++++++++++++++++++++++-
 io/channel.c                        |  13 ++--
 io/trace-events                     |   5 ++
 migration/migration.h               |  33 +++++++++
 migration/multifd.c                 |  42 ++++++++++-
 migration/multifd.h                 |   2 +
 migration/options.c                 |   2 +
 migration/savevm.c                  |   6 +-
 migration/tls.c                     |   5 ++
 migration/tls.h                     |   2 +-
 tests/unit/test-crypto-tlssession.c |  12 ++--
 tools/i386/qemu-vmsr-helper.c       |   3 +-
 util/vhost-user-server.c            |   2 +-
 18 files changed, 308 insertions(+), 83 deletions(-)

-- 
2.35.3


