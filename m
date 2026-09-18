Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DFEC982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7h64-0007ns-Kh; Fri, 18 Sep 2026 18:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h61-0007nU-RC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7h60-0000Vg-1X
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:30:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 588D72000A;
 Fri, 18 Sep 2026 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hoJi5p0jgy31QJh6Subo0C5KDRomfPMSPEfvDXMMJEk=;
 b=FV7xcZoC9Q+P7bUNRMcq75hR4GQ5W2wXy0hy+hMe21ILATAHiODuYG+y8wBuFTT/vbrAC4
 NQo8wVE0fBx4nWvRFOLyqhRaYcZ1noJHzqQgXXPLh1BqUrQZnrf0TKLxWhqX1QxYr9bthm
 cQQlSomUUYloHRnkC4J55xROFEBrGOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hoJi5p0jgy31QJh6Subo0C5KDRomfPMSPEfvDXMMJEk=;
 b=Ggl9YqKLaw0tZ2EXuyzyE/VIElVmOLUbByU9aE6g1QMw4CBgRygmLYRCWiXaCNzJeS1+zj
 HBCLkU2n9EJKbQCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="f/LcamPB";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ERrpKu9d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789770606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hoJi5p0jgy31QJh6Subo0C5KDRomfPMSPEfvDXMMJEk=;
 b=f/LcamPBIZS/JeIYpi4XBz3293p9fgBVUAweycUp/39bDsQESUUWnR97cTIVH6XHIm+A9M
 dm4OibUPKsVv/9YDpL11xumAlCfb480jUXLAh21Um3FiY3tdiYRAldcb2OQPmOFHIawEDU
 HDgCY//FeGS3fZMbpmIQub7TeXL7Iec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789770606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hoJi5p0jgy31QJh6Subo0C5KDRomfPMSPEfvDXMMJEk=;
 b=ERrpKu9dxRBXT1oW+7qe+TqC9m+K+YYfry1/pX4492nIXggU8GOkPYhBBKzygaKzOSyGmM
 H75BhDAfp8RD2XBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 720D01348F;
 Fri, 18 Sep 2026 22:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hQIbBW27rWrsdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:30:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 00/14] qemu-options: Remove some complexity
Date: Fri, 18 Sep 2026 19:29:47 -0300
Message-ID: <20260918223002.1892021-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 588D72000A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The call chain around qemu_opts_parse() is a bit convoluted. The main
issues are:

- It's split in two versions, one that uses Error and another that
  prints messages directly.

- Callers sometimes fetch the QemuOptsList with qemu_opts_find()
  before calling into qemu_opts_parse, sometimes a list is already
  available.

- The printing of help options, warnings and errors is done at
  different levels, passing booleans and pointers to booleans around
  to get the information at the right place.

- It can't always handle a NULL list (segfaults).
  https://lore.kernel.org/r/20260915134412.4187164-1-farosas@suse.de

This series attempts to make it simpler by:

- Merging the code into a single function with wrappers taking either
  QemuOpts or QemuOptsList;

- Removing a couple of function arguments by always setting the Error
  at the leaf level and letting the callers decide what to do with it.

Plain refactoring, no functional change intended.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2862893421

Fabiano Rosas (14):
  meson: Fix meson suites invocation from make check
  qemu-options: Use g_autofree when calling get_opt_name_value()
  qemu-options: Consolidate branches in opts_parse
  qemu-options: Add qemu_opts_parse_list
  qemu-options: Change qemu_parse_opts() to take the group name
  qemu-options: Call qemu_opts_print_help() one level down
  qemu-options: Consolidate qemu_opts_parse* functions
  qemu-options: Add qemu_opts_parse_list_noisily
  qemu-options: Change qemu_opts_parse_noisily() to take the group
  qemu-options: Check for NULL list at qemu_opts_parse()
  qemu-options: pass an Error into get_opt_name_value
  qemu-options: merge warn and help flags
  qemu-options: Further simplify qemu_opts_parse_list()
  qemu-options: Remove opts_parse()

 block/monitor/block-hmp-cmds.c       |   4 +-
 blockdev.c                           |   2 +-
 chardev/char-hmp-cmds.c              |   5 +-
 include/qemu/option.h                |   8 +-
 monitor/hmp.c                        |   2 +-
 net/net.c                            |   2 +-
 plugins/loader.c                     |   2 +-
 qemu-img.c                           |  13 +-
 qemu-io-cmds.c                       |   2 +-
 qemu-io.c                            |   7 +-
 qemu-nbd.c                           |   6 +-
 scripts/mtest2make.py                |  11 +-
 semihosting/config.c                 |   4 +-
 storage-daemon/qemu-storage-daemon.c |   4 +-
 system/qdev-monitor.c                |   2 +-
 system/tpm.c                         |   2 +-
 system/vl.c                          |  86 +++++-------
 tests/qemu-iotests/meson.build       |   2 +-
 tests/unit/test-char.c               |  12 +-
 tests/unit/test-opts-visitor.c       |  12 +-
 tests/unit/test-qemu-opts.c          | 169 ++++++++++++-----------
 tests/unit/test-replication.c        |   6 +-
 tests/unit/test-seccomp.c            |   6 +-
 tools/qemu-vnc/qemu-vnc.c            |   2 +-
 trace/control.c                      |   3 +-
 ui/vnc.c                             |   3 +-
 util/qemu-option.c                   | 197 ++++++++++++++++-----------
 util/qemu-sockets.c                  |   2 +-
 28 files changed, 293 insertions(+), 283 deletions(-)

-- 
2.53.0


