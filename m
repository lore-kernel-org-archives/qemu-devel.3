Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61660C5B54A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjK6W-0002Nj-J4; Wed, 28 Aug 2024 10:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6U-0002MA-TC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:56:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjK6T-00027X-79
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 10:56:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 819DF21B61;
 Wed, 28 Aug 2024 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rioiViJyL96njs3W3GCr6Kk0rSJQHsbO5yZTrwWfHDs=;
 b=W2MwyYQXIQ4v+rLFg2Whuw5+kRVvR621LQWom6DbgLGMLWzKECK77ludwhqKTGvah9JrIB
 HLY+mMRfsOYLLZBujPQp5TCr4CPv6cUsFYIpYlrZq7qTY0FV2bXwEAY41vfmenvO6ztEq8
 uR4k9sCOhNIm+mHFatgbCqt/YY37p6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rioiViJyL96njs3W3GCr6Kk0rSJQHsbO5yZTrwWfHDs=;
 b=GuXFge/FXIJm5H+LSaboMJRxRu9m+WLu0uz+EVCR6E2rf/7Ab46nmnW6/xQhJeN6vLmHsX
 ehZpRN3jviiz/8AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724857014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rioiViJyL96njs3W3GCr6Kk0rSJQHsbO5yZTrwWfHDs=;
 b=W2MwyYQXIQ4v+rLFg2Whuw5+kRVvR621LQWom6DbgLGMLWzKECK77ludwhqKTGvah9JrIB
 HLY+mMRfsOYLLZBujPQp5TCr4CPv6cUsFYIpYlrZq7qTY0FV2bXwEAY41vfmenvO6ztEq8
 uR4k9sCOhNIm+mHFatgbCqt/YY37p6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724857014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rioiViJyL96njs3W3GCr6Kk0rSJQHsbO5yZTrwWfHDs=;
 b=GuXFge/FXIJm5H+LSaboMJRxRu9m+WLu0uz+EVCR6E2rf/7Ab46nmnW6/xQhJeN6vLmHsX
 ehZpRN3jviiz/8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 583F01398F;
 Wed, 28 Aug 2024 14:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FOzyB7U6z2YnRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 14:56:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 0/4] migration/multifd: Remove multifd_send_state->pages
 (leftovers)
Date: Wed, 28 Aug 2024 11:56:46 -0300
Message-Id: <20240828145650.15879-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I queued the rest of the series to migration-staging, these are the
few leftovers that still needed attention.

================================================================
v6:
https://lore.kernel.org/r/20240827174606.10352-1-farosas@suse.de
v5:
https://lore.kernel.org/r/20240826195322.16532-1-farosas@suse.de
v4:
https://lore.kernel.org/r/20240823173911.6712-1-farosas@suse.de
v3:
https://lore.kernel.org/r/20240801123516.4498-1-farosas@suse.de
v2:
https://lore.kernel.org/r/20240722175914.24022-1-farosas@suse.de
v1:
https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de

Fabiano Rosas (4):
  migration/multifd: Stop changing the packet on recv side
  migration/multifd: Fix p->iov leak in multifd-uadk.c
  migration/multifd: Add a couple of asserts for p->iov
  migration/multifd: Add documentation for multifd methods

 migration/multifd-nocomp.c | 29 ++++++---------
 migration/multifd-uadk.c   |  2 +
 migration/multifd.c        | 22 +++++------
 migration/multifd.h        | 76 +++++++++++++++++++++++++++++++++++---
 4 files changed, 95 insertions(+), 34 deletions(-)

-- 
2.35.3


