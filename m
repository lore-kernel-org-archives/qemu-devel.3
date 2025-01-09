Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B958FE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxeN-0002H9-Cv; Thu, 09 Jan 2025 13:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeM-0002Gz-6G
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:52:58 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeK-0005sf-0t
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:52:57 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E87A71F453;
 Thu,  9 Jan 2025 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ncnRO7hf9YdrXHDls95006Jhn7UmsrycizjIOesTI34=;
 b=ZW/xhdhUOBtLrUG3qn0WU2kCV/E0RsOj8ywxJfjgWhDNmVHorKzb1KCLziiBZ1kOBah/Zp
 zjbSRHSLXRcleYloAlO0eigzuZ10TQP7VUwiGOhKToaYS9WbVhWRVTJzNMKGcYjLRXqq1/
 Kx1kaRkVE0laoJzYrnvcLyztzJmjKd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ncnRO7hf9YdrXHDls95006Jhn7UmsrycizjIOesTI34=;
 b=Kul+J5oOI6w/xwFqJXrEgCJeLqTxawM6Likg+mX+ifW3Rr3HVo/+QB4rMhnLXEL7gw3WE/
 rvxX7w8ATWu6iRCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="X/mQSRx4";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Drxmtjpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ncnRO7hf9YdrXHDls95006Jhn7UmsrycizjIOesTI34=;
 b=X/mQSRx4To6tlnCtZ4PQFPen2sh9VF45Q912vPEqFb9YHD31MB+MpYW7SZA/OR9hMcwM21
 bUpynLdCYzW4+1TQnx5UL+hwar0QQWDrFgldA2BMqdmnf/3hlz1EMxow60maM2gNvJ5lpP
 i5LGIvAeCDgu5EJF8ISk0XXviv1Qngg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ncnRO7hf9YdrXHDls95006Jhn7UmsrycizjIOesTI34=;
 b=DrxmtjpbFV5QZxXydBQljqZiay6xR9kKz1CAEzHrq95Tj2ELZ9hlYD8DKtYd4LOhMKOZZ+
 KpHWZ3o6SxSJWGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6F16139AB;
 Thu,  9 Jan 2025 18:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 346CHgQbgGdcMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 18:52:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 0/7] migration: Fix s390 regressions + migration script
Date: Thu,  9 Jan 2025 15:52:42 -0300
Message-Id: <20250109185249.23952-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E87A71F453
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

changes:

- fixed appending again
- changed the VMSDFieldNull class to inherit from VMSDFieldGeneric

v2:
https://lore.kernel.org/r/20250109140959.19464-1-farosas@suse.de

- dropped comments patch
- new patch 4: rename the field to nullptr
- patch 6: add a sample JSON, fix the appending code

v1:
https://lore.kernel.org/r/20250107195025.9951-1-farosas@suse.de

Hi,

The situation that broke the last migration PR was:

1) emitting of JSON data by QEMU for
   VMSTATE_ARRAY_OF_POINTER_TO_STRUCT when NULL pointers are present
   has been broken for a while;

2) parsing of s390x migration stream by analyze-script.py has been
   broken for a while;

   (there's indications that it worked on s390x hosts, I'm assuming due
   to byte order coincidences)

3) s390x CSS migration has been broken for a while;

The s390x CSS migration uses VMSTATE_ARRAY_OF_POINTER_TO_STRUCT with
NULL pointers, triggering #1, but hidden due to #2 on TCG hosts and
due to #3 overall.

- patches 1: just to make rebase easier
- patches 2-3: cleanups
- patch 4: fixes #2
- patches 5-6: fix #1
- patch 7: fixes #3

Fabiano Rosas (6):
  migration: Add more error handling to analyze-migration.py
  migration: Remove unused argument in vmsd_desc_field_end
  migration: Fix parsing of s390 stream
  migration: Rename vmstate_info_nullptr
  migration: Fix arrays of pointers in JSON writer
  s390x: Fix CSS migration

Peter Xu (1):
  migration: Dump correct JSON format for nullptr replacement

 hw/s390x/s390-virtio-ccw.c   |   2 +-
 migration/vmstate-types.c    |   2 +-
 migration/vmstate.c          | 151 ++++++++++++++++++++++++++++-------
 scripts/analyze-migration.py | 142 +++++++++++++++++++++++---------
 4 files changed, 228 insertions(+), 69 deletions(-)

-- 
2.35.3


