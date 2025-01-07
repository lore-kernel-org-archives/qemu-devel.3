Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC3E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFbQ-0003CW-Ol; Tue, 07 Jan 2025 14:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFb3-00037y-9s
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:37 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFaz-0002Dk-UW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D4AE1F390;
 Tue,  7 Jan 2025 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ciyW2+ZxJR+LBw6viyH8kY5E8GAR3qiVmD5vANs6y5o=;
 b=W9uTn1I0ZsVldj+ISig158YsEi5mbTbMt8R3/D07jW5s7TS8A1uURO24lYfJQFls4khwQH
 63kkPt2fQPNx+h7PbhcI0my5h7MVIxSfcUVrPDwIIwhlw9sx2zO0a9dOw98hVCr9mUJIzn
 kMMvgXBISqjxzZQ2FjfhHUaekMLnN18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ciyW2+ZxJR+LBw6viyH8kY5E8GAR3qiVmD5vANs6y5o=;
 b=TfWkDKSC+dZlbKe2YIvtze0Cqo1TroUTe4nuimDHBUL0mR93Tu7rHPbtvyvva/M2g3DFwk
 jcAvIFm/wuQ+H3Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W9uTn1I0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TfWkDKSC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ciyW2+ZxJR+LBw6viyH8kY5E8GAR3qiVmD5vANs6y5o=;
 b=W9uTn1I0ZsVldj+ISig158YsEi5mbTbMt8R3/D07jW5s7TS8A1uURO24lYfJQFls4khwQH
 63kkPt2fQPNx+h7PbhcI0my5h7MVIxSfcUVrPDwIIwhlw9sx2zO0a9dOw98hVCr9mUJIzn
 kMMvgXBISqjxzZQ2FjfhHUaekMLnN18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ciyW2+ZxJR+LBw6viyH8kY5E8GAR3qiVmD5vANs6y5o=;
 b=TfWkDKSC+dZlbKe2YIvtze0Cqo1TroUTe4nuimDHBUL0mR93Tu7rHPbtvyvva/M2g3DFwk
 jcAvIFm/wuQ+H3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36CA213A6A;
 Tue,  7 Jan 2025 19:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ik2JOoOFfWeCGAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 Jan 2025 19:50:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/7] migration: Fix s390 regressions + migration script
Date: Tue,  7 Jan 2025 16:50:18 -0300
Message-Id: <20250107195025.9951-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D4AE1F390
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,gitlab.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,analyze-script.py:url,analyze-migration.py:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1615060320

Fabiano Rosas (6):
  migration: Add more error handling to analyze-migration.py
  migration: Remove unused argument in vmsd_desc_field_end
  migration: Document the effect of vmstate_info_nullptr
  migration: Fix parsing of s390 stream
  migration: Fix arrays of pointers in JSON writer
  s390x: Fix CSS migration

Peter Xu (1):
  migration: Dump correct JSON format for nullptr replacement

 hw/s390x/s390-virtio-ccw.c   |   2 +-
 migration/vmstate-types.c    |   6 ++
 migration/vmstate.c          | 151 ++++++++++++++++++++++++++++-------
 scripts/analyze-migration.py | 111 +++++++++++++++++--------
 4 files changed, 209 insertions(+), 61 deletions(-)

-- 
2.35.3


