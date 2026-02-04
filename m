Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E475E9D41D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 17:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vngbQ-0003o4-Dd; Wed, 04 Feb 2026 12:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vngbO-0003ns-Vz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:23:43 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vngbL-0003FW-HH
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 12:23:42 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D28985BCE2;
 Wed,  4 Feb 2026 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770225817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2CjrZ5HMN9euGeZB/JWmRa9ckvC2IRKjUEr90eLlIZ8=;
 b=ij5m6pC975Uo8G9lRXi+XvM8st/LklQnJsB92TNmTkvRaaaljGHpQfAYM/SG4Yi1AynkQc
 wkmaplfAWLm/xny+Lro0bImN2a85hYVJt5ZUFvkoGpJPB3wU/+5sQT65j/JJNkFyW4q6vd
 9BeP+X6Kc+XAJp1HEvf8p+I8Ug1D1/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770225817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2CjrZ5HMN9euGeZB/JWmRa9ckvC2IRKjUEr90eLlIZ8=;
 b=/XKXVTm7e+tQQdMg6QNRPYTk3gxjghX/TRquzojUFKOIKEl271T15QcuLPtfocMeYfNzJY
 hvyjzaSA273dnlCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770225816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2CjrZ5HMN9euGeZB/JWmRa9ckvC2IRKjUEr90eLlIZ8=;
 b=n4ONsRudCImH+ZInT74z4xssI+fpRW5F/r+++W2tzhpHyxY+TfXPW6FPqKUu23QVOmBAu5
 Hbrtb3Eetz7Y0jIhMPomNAY21ej0RDo2J1LIDshncJ/8QhhK5q9uzhdCEpVHLnNIcsRqCm
 xR0ksD3hImaETulc3ANiNbheMics0wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770225816;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2CjrZ5HMN9euGeZB/JWmRa9ckvC2IRKjUEr90eLlIZ8=;
 b=oC7RPH15c9jZ0RwJlxu0YVkcz3DsF+IuN1IPcY9i8W74VyZj+r0aYUfGNOLUNGuyR/GrC7
 0E2uLgZHCpJcy9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BC6F3EA63;
 Wed,  4 Feb 2026 17:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0gq3A5eAg2nQNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Feb 2026 17:23:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 0/4] tests/functional: Fix ppc64 issue with make -j
Date: Wed,  4 Feb 2026 14:23:28 -0300
Message-ID: <20260204172332.21367-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,gitlab.com:url]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

CI run: https://gitlab.com/farosas/qemu/-/pipelines/2306044343

v1:
https://lore.kernel.org/r/20260128142829.25326-1-farosas@suse.de

Fabiano Rosas (4):
  tests/functional/migration: Use socket_dir
  tests/functional/migration: Add migrate_vms
  tests/functional/migration: Use the migrate_vms helper
  tests/functional/ppc64: Remove custom migration routine

 tests/functional/migration.py            | 46 ++++++++++++++----------
 tests/functional/ppc64/test_migration.py | 11 ------
 tests/functional/ppc64/test_pseries.py   |  6 ++--
 3 files changed, 32 insertions(+), 31 deletions(-)

-- 
2.51.0


