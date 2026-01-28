Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F332AD3F06D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6X8-0004nB-69; Wed, 28 Jan 2026 09:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl6X6-0004lf-NQ
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:28:36 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl6X5-0007fK-7u
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:28:36 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECF3A5BCFD
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769610513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vaxmxgeQdQ+jWP+wIY8fd26GIlef/k203+L/df2KZek=;
 b=oiA7EUpcjsnZuduDQ+VQPyo0xEqJLcRDNGdZxN0ZZGHk59QwJVzzJADg+BZWPz2jwrn6bc
 ZJ8FTv1baZvZ2XO3mVh6aOqr3avFRnLQcwKNgcfBIqm2jXOSrLM4u2/g8rGtjNMDGPitOl
 rSjwxrugz6SCHZ34x4/xnM9dKT2qCN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769610513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vaxmxgeQdQ+jWP+wIY8fd26GIlef/k203+L/df2KZek=;
 b=a9+HMSBkhRf/CY0MSubiSo0+7iFzi7EKae4NfPDQPWUJaL/SGc2cPEHmPpwuylRXirXsnf
 ysR5SEv9Qex9iBDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769610512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vaxmxgeQdQ+jWP+wIY8fd26GIlef/k203+L/df2KZek=;
 b=hyQ5OEYr9LwYKL+qJnaEcarnJ8OmlAdHNunwA3n9YjEgt1tUixqr9ZD7ZAJilc0Rph88Cl
 eCoxpRVPCKBYCdbHuAHVCBwU5+b6tPAmTd9Lixd0R6ORnfNE1PbpSZMkKMapmdkqFIObkC
 2AAxLLmqYoDmhYrGQpuQcaKza1q2YVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769610512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vaxmxgeQdQ+jWP+wIY8fd26GIlef/k203+L/df2KZek=;
 b=n3qlFPDtJYwJ5MOCeWscv2tBQrwhi4Lka6EPqe2hZ31RYyHjS2KRYcRvJKuLVdjPhHB2UW
 yXwVmFCBBR6m7CAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E1573EA61
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 14:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dy9DNA8demlFfwAAD6G6ig
 (envelope-from <farosas@suse.de>)
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 14:28:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] tests/functional: Fix ppc64 issue with make -j
Date: Wed, 28 Jan 2026 11:28:26 -0300
Message-ID: <20260128142829.25326-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 gitlab.com:url]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

As reported in [1], running the ppc64 functional tests in parallel is
currently broken due to one test importing another and causing
unittest.main to instantiate the imported test twice. Fix by removing
the dependency between tests.

1- https://lore.kernel.org/r/aXOGKb88Yho2jb_o@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com
CI run: https://gitlab.com/farosas/qemu/-/pipelines/2289828999

Fabiano Rosas (3):
  tests/functional/migration: Use socket_dir
  tests/functional/migration: Accept vm objects in do_migrate
  tests/functional/ppc64: Remove custom migration routine

 tests/functional/migration.py            | 31 ++++++++++++++----------
 tests/functional/ppc64/test_migration.py | 11 ---------
 tests/functional/ppc64/test_pseries.py   |  6 +++--
 3 files changed, 22 insertions(+), 26 deletions(-)

-- 
2.51.0


