Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35F3107BCD6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17HS-0007eS-Ug; Fri, 13 Mar 2026 14:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17Gv-0007a1-VZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17Gu-0005Ej-9D
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A22275BFA0;
 Fri, 13 Mar 2026 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZbVtQ2+oPEqk39L5GdOllRcURJm4QNCrbTtJ4AALYP4=;
 b=AanX6e3H223hiMHZKgt1gkn3uvBPTIOnHpG31RxLlD1BJ7UXVEq3M7/EgQVTnZ1ji96jMP
 rdQZZo2pp51diB16b1NqFybQeXDhVSTaBr6KcgQKZxzedoDsz+gZiEoNYJV0vIPaNS8zE2
 QI3DPqfpGPeDx+qpwnys8ldFK8KvkLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZbVtQ2+oPEqk39L5GdOllRcURJm4QNCrbTtJ4AALYP4=;
 b=KHz6rezO23lVLLwei0yHPdBhFICJyhL1lfIgtTS0k/3jSD5aGyySk/mNC5jb3cJ1uIwX88
 pEYRR5DN0QZfgjBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZbVtQ2+oPEqk39L5GdOllRcURJm4QNCrbTtJ4AALYP4=;
 b=AanX6e3H223hiMHZKgt1gkn3uvBPTIOnHpG31RxLlD1BJ7UXVEq3M7/EgQVTnZ1ji96jMP
 rdQZZo2pp51diB16b1NqFybQeXDhVSTaBr6KcgQKZxzedoDsz+gZiEoNYJV0vIPaNS8zE2
 QI3DPqfpGPeDx+qpwnys8ldFK8KvkLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZbVtQ2+oPEqk39L5GdOllRcURJm4QNCrbTtJ4AALYP4=;
 b=KHz6rezO23lVLLwei0yHPdBhFICJyhL1lfIgtTS0k/3jSD5aGyySk/mNC5jb3cJ1uIwX88
 pEYRR5DN0QZfgjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B308240678;
 Fri, 13 Mar 2026 18:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2zYZHqdXtGn9MwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Mar 2026 18:29:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v1 0/4] Fix leaks reached by make check-qtest
Date: Fri, 13 Mar 2026 15:29:52 -0300
Message-ID: <20260313182957.28432-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.77 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.17)[-0.859];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

../configure --enable-asan --enable-ubsan \
	     --target-list=\
	     x86_64-softmmu,i386-softmmu,\
	     aarch64-softmmu,arm-softmmu,\
	     ppc64-softmmu,\
	     s390x-softmmu,\
	     riscv64-softmmu,\
	     loongarch64-softmmu,\
	     sparc-softmmu,sparc64-softmmu

make -j$(nproc) TIMEOUT_MULTIPLIER=2 check-qtest-$TARGET

(running all targets at once triggers timeouts even with 3x
multiplier, bios-tables-test also has it's own timeout of 600s at
qtest/acpi-utils.c)

Tested on top of the migration-test fixes:
https://lore.kernel.org/r/20260311213418.16951-1-farosas@suse.de

CI run on top of master:
https://gitlab.com/farosas/qemu/-/pipelines/2383870717

Fabiano Rosas (4):
  tests/qtest: Don't dup machine name in qtest_cb_for_every_machine
    callbacks
  tests/qtest/test-hmp: Free machine options
  target/riscv: Don't leak general_user_opts
  hw/riscv: Free resources allocated at riscv_iommu_instance_init

 hw/riscv/riscv-iommu.c      | 16 +++++++++++++---
 target/riscv/cpu.c          |  3 +--
 tests/qtest/cpu-plug-test.c | 11 +++++------
 tests/qtest/qom-test.c      |  3 +--
 tests/qtest/test-hmp.c      |  6 +++---
 5 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.51.0


