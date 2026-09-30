Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB58CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2Wg-0007vD-4b; Wed, 30 Sep 2026 18:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2WX-0007uj-Oz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:38 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2WV-00051P-KK
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 859EF21EC5;
 Wed, 30 Sep 2026 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VSih/YDxK/KxZXwEpralutYNoTnxsjH4RWglBpC1iTQ=;
 b=mAkDcEkn0Y5YYT8BjQ5+EY/hEAAiJD7c9BVRmDwLsTNJ7AjWdfsG3AqNPTdbzw/fcSIuLJ
 F2anTmW++lA31/ye1HDJB1vFpK96WW0U0KPsXZc35ycmsLD4YGtES9J/l4VNWvqzZlRAEL
 seZiGZuKMn4i4ZnCZqs4HY9NLSZBEJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VSih/YDxK/KxZXwEpralutYNoTnxsjH4RWglBpC1iTQ=;
 b=4uk8Wlj1iB0Yx2ZqOOQBvWNHl8wkp2EkKyWkIuDPcvGEmk/wBCU0Wm+Ks1wqGNhT2MLHfD
 tpN6JubvgW7qxiDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VSih/YDxK/KxZXwEpralutYNoTnxsjH4RWglBpC1iTQ=;
 b=NN9de89eddrU3lbeZtoVLOOCUUFhfJ3hXIXR68VhiIawv9IArkUmASw/if65T8/L9VZ5YX
 ME+FXPYV3ynH5jW/Fd34O/JyrApm4vjEGzbQM967EX+MWPoG5WkLyYn/PBPbpm/cSoz6v6
 YPlw0O4SHQplpBvV5W7b/uEQnxCl8m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VSih/YDxK/KxZXwEpralutYNoTnxsjH4RWglBpC1iTQ=;
 b=87/ibvO12By8XlaKmR+vgIVW50uMFsSuSnq6lNTYcE4QQ8qDwQ8IiDKahDAiWG60a1FFEv
 1fOVWkeS+nqwz7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54F3213AF1;
 Wed, 30 Sep 2026 22:11:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/11] qemu-options: Spring cleanup
Date: Wed, 30 Sep 2026 19:10:54 -0300
Message-ID: <20260930221105.2262063-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.990]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Remove support for command-line option parameters without values. Only
key=val from now on. However, keep 'help' without a value.

Stop passing around pointers to booleans. This is mostly due to the
handling of 'help'. In the process, fix 'help=foo' which is currently
accepted.

Cleanup the arguments of qemu_opts_parse* (due to the above, but also)
to stop passing in the return of qemu_opts_find() as first argument,
which can return NULL and lead to segfault. Add _parse_list and
_parse_list_noisily versions to keep things clear.

Replace instances of the _parse_*noisily functions with the
non-noisily variant wherever possible.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2897412802

Thanks!

---
RFC:
https://lore.kernel.org/r/20260918223002.1892021-1-farosas@suse.de

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

Fabiano Rosas (11):
  qemu-option: Use g_autofree when calling get_opt_name_value()
  tests/unit/test-qemu-opts: Validate help=foo options
  qemu-option: Remove short form options support
  qemu-option: Fix 'help' parameter parsing
  qemu-option: Add qemu_opts_parse_list
  qemu-option: Change qemu_parse_opts() to take the group name
  qemu-option: Add qemu_opts_parse_list_noisily
  qemu-option: Use qemu_opts_parse_list_noisily where appropriate
  qemu-option: Change qemu_opts_parse_noisily() to take the group
  qemu-option: Check for NULL list at qemu_opts_parse()
  qemu-option: Remove a few instances of noisily parsing

 block/monitor/block-hmp-cmds.c       |   6 +-
 blockdev.c                           |   2 +-
 chardev/char-hmp-cmds.c              |   5 +-
 docs/about/deprecated.rst            |  13 --
 include/qemu/option.h                |   8 +-
 include/qemu/option_int.h            |   1 +
 include/system/tpm.h                 |   3 +-
 monitor/hmp.c                        |   4 +-
 net/net.c                            |   4 +-
 plugins/loader.c                     |   5 +-
 qemu-img.c                           |  14 +-
 qemu-io-cmds.c                       |   2 +-
 qemu-io.c                            |  10 +-
 qemu-nbd.c                           |   6 +-
 semihosting/config.c                 |   4 +-
 storage-daemon/qemu-storage-daemon.c |   4 +-
 system/qdev-monitor.c                |   2 +-
 system/tpm.c                         |   8 +-
 system/vl.c                          | 114 +++++-------
 tests/qemu-iotests/084               |   2 +-
 tests/qemu-iotests/146               |   2 +-
 tests/qemu-iotests/197               |   2 +-
 tests/qemu-iotests/215               |   2 +-
 tests/unit/test-char.c               |  12 +-
 tests/unit/test-opts-visitor.c       |  12 +-
 tests/unit/test-qemu-opts.c          | 252 ++++++++++++++++-----------
 tests/unit/test-replication.c        |  17 +-
 tests/unit/test-seccomp.c            |   6 +-
 tests/unit/test-util-sockets.c       |  33 ----
 tools/qemu-vnc/qemu-vnc.c            |   2 +-
 trace/control.c                      |   3 +-
 ui/vnc.c                             |   3 +-
 util/qemu-option.c                   | 202 +++++++++++++--------
 util/qemu-sockets.c                  |   2 +-
 34 files changed, 395 insertions(+), 372 deletions(-)

-- 
2.53.0


