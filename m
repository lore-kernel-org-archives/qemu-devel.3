Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B83C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkW9P-0007R6-FM; Wed, 13 Mar 2024 17:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkW9M-0007QY-Dj
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:28:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkW9J-0006op-Bj
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:28:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28FA41F7EB;
 Wed, 13 Mar 2024 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710365309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x05CQlcb6Yvi/3eCSTsya6CX3q4bjBsSk5RmGMDTU8c=;
 b=LgEIoSbsrJ6KREBVECPrc0JhlZvjqTc39ACA9FSJZEmDOSPP6/iCXKf2lbr/0F+SpEyk8A
 Nkt1AQs3v59kqVTB8G5rkaN9Nsw0jehvTPTKCa75oLslGfNVGTIuBDUYZJduIbQFVrNAE+
 AK1X7itmZWv5BdeR/9KwMIvJf+LwKMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710365309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x05CQlcb6Yvi/3eCSTsya6CX3q4bjBsSk5RmGMDTU8c=;
 b=sdMncz8hqctHiJI/YAnoZCYqplK4KjCyMagGa7UDPkTS9xWfwOqQ7eaPX6bexRe1BpPeoD
 4XcKfccYsLX9qRCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710365309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x05CQlcb6Yvi/3eCSTsya6CX3q4bjBsSk5RmGMDTU8c=;
 b=LgEIoSbsrJ6KREBVECPrc0JhlZvjqTc39ACA9FSJZEmDOSPP6/iCXKf2lbr/0F+SpEyk8A
 Nkt1AQs3v59kqVTB8G5rkaN9Nsw0jehvTPTKCa75oLslGfNVGTIuBDUYZJduIbQFVrNAE+
 AK1X7itmZWv5BdeR/9KwMIvJf+LwKMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710365309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x05CQlcb6Yvi/3eCSTsya6CX3q4bjBsSk5RmGMDTU8c=;
 b=sdMncz8hqctHiJI/YAnoZCYqplK4KjCyMagGa7UDPkTS9xWfwOqQ7eaPX6bexRe1BpPeoD
 4XcKfccYsLX9qRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E79C413977;
 Wed, 13 Mar 2024 21:28:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +leXKnsa8mX/ZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Mar 2024 21:28:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 0/2] migration mapped-ram fixes
Date: Wed, 13 Mar 2024 18:28:22 -0300
Message-Id: <20240313212824.16974-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.78 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.92)[86.27%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

In this v2:

patch 1 - The fix for the ioc leaks, now including the main channel

patch 2 - A fix for an fd: migration case I thought I had written code
          for, but obviously didn't.

Thank you for your patience.

based-on: https://gitlab.com/peterx/qemu/-/commits/migration-stable
CI run: https://gitlab.com/farosas/qemu/-/pipelines/1212483701

Fabiano Rosas (2):
  migration: Fix iocs leaks during file and fd migration
  migration/multifd: Ensure we're not given a socket for file migration

 migration/fd.c   | 35 +++++++++++---------------
 migration/file.c | 65 ++++++++++++++++++++++++++++++++----------------
 migration/file.h |  1 +
 3 files changed, 60 insertions(+), 41 deletions(-)

-- 
2.35.3


