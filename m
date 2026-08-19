Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530BBC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhKv-0003hz-AE; Wed, 19 Aug 2026 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKo-0003gI-S5
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:08 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wwhKn-0003GQ-8Z
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:32:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2523EC1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OOegS3IQwrob4LlA+WorPmsdE0GuPzKgu0vcFaZ1vQY=;
 b=WOe7qGbIBkHBV23YQ1JeBicPzGgJSq5pyhy/YjyuBQ/6Ct8ApN9ZrXCaeb91zwxnZ0Q7g6
 RdaSr1BgQ+5ApFlpLk312gRbOx81EkrARmjcWq0r2dV3OEYTd0COXYkVHDOXuAjylI4m4v
 KTqGT4Li/cUcFA1PdkRbXJnhTwB7xXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OOegS3IQwrob4LlA+WorPmsdE0GuPzKgu0vcFaZ1vQY=;
 b=xWEhsyvbsXHgYUfS0PXWAYaIE037FOYj+oWTMLjDM/02SHKv7jrwLhD1yeWYcuZO5LOTS6
 1N6EsK28dAHDk9Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787149915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OOegS3IQwrob4LlA+WorPmsdE0GuPzKgu0vcFaZ1vQY=;
 b=dNuceXcVm1xJMVTtLyPE/CBc93/yj1wxQ3GTdzMQnCcVu0eCGICJeJm7m8Kh1G62y47Cko
 fpnk8Enpim3dugZuLt8W1M+I0ySsO8n8FeEuWMzHX1OlKmzRYKm9ckB+ii5mRsrJ6Yz5jf
 DsnINyoCdq979JCWY84qgUwr6qok4qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787149915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OOegS3IQwrob4LlA+WorPmsdE0GuPzKgu0vcFaZ1vQY=;
 b=tYEt3i6rsWRo1IBvsoKbpEBIWq6r6mg6g8WPkuqeEDqZNteuAn9Gq9EH89VjmekxuJ5nGx
 tGc6lJU1w4cBlvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D39042F81
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fAGpKFq+hWqxCwAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:31:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Qtest patches for 2026-08-19
Date: Wed, 19 Aug 2026 11:31:48 -0300
Message-ID: <20260819143152.1541266-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
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

The following changes since commit fa19879df1658f96ac07365fca8835b7decd6995:

  Merge tag 'pull-block-jobs-2026-08-17' of https://gitlab.com/vsementsov/qemu into staging (2026-08-17 15:37:53 -0700)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/qtest-20260819-pull-request

for you to fetch changes up to bb98963d6df300fe6fc6d2074198e220571cd0cd:

  tests/qtest/pxe-test: skip per-row cases whose machine is unavailable (2026-08-19 11:27:58 -0300)

----------------------------------------------------------------
QTest pull request

- Use GLib wrappers during QTEST_LOG parsing
- Skip tests when 'pc' machine is not built in

----------------------------------------------------------------

Amit Machhiwal (1):
  tests/qtest/libqtest: Use GLib functions for proper const correctness

Rohitashv Kumar (3):
  tests/qtest/device-plug-test: skip pc tests when 'pc' machine is
    unavailable
  tests/qtest/drive_del-test: skip pc tests when 'pc' machine is
    unavailable
  tests/qtest/pxe-test: skip per-row cases whose machine is unavailable

 tests/qtest/device-plug-test.c |  8 ++++++++
 tests/qtest/drive_del-test.c   | 16 ++++++++++++++++
 tests/qtest/libqtest.c         |  9 ++++-----
 tests/qtest/pxe-test.c         |  4 ++++
 4 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.53.0


