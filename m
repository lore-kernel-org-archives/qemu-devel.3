Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F40EC87FD2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 20:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujOIF-0005WW-Ic; Tue, 05 Aug 2025 16:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujOIE-0005WE-J8
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:29:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ujOIC-00020i-OB
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:29:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9865A2124D;
 Tue,  5 Aug 2025 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754425790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+yDVHH+i/EBL9RZzllsm3kzW2O8hIOcHwEjh9EKSG7A=;
 b=qrra55NvQP+QyFWFaiROFnF6vJvndLtPNAWqOCUoCfibRcanMu1RKa6hq3Ec0d5FMjT+p/
 0gEj+aWqLwGGmaZUDHNskXnTm6FcOkuWjaxsm5BNlRLlabI16Irv4jYCb4AInOUu15kAut
 TaqbllqdL5G2iUzH4Gt46hnST5fe+iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754425790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+yDVHH+i/EBL9RZzllsm3kzW2O8hIOcHwEjh9EKSG7A=;
 b=IAvqutgX3/aEN0FNCaTgIs3Nnp4ktmhD5QnAoWumSWY5rX4i7uqm7bWnVamEjewx2R+Wif
 5ZmNfZZdhITGQLBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754425790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+yDVHH+i/EBL9RZzllsm3kzW2O8hIOcHwEjh9EKSG7A=;
 b=qrra55NvQP+QyFWFaiROFnF6vJvndLtPNAWqOCUoCfibRcanMu1RKa6hq3Ec0d5FMjT+p/
 0gEj+aWqLwGGmaZUDHNskXnTm6FcOkuWjaxsm5BNlRLlabI16Irv4jYCb4AInOUu15kAut
 TaqbllqdL5G2iUzH4Gt46hnST5fe+iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754425790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+yDVHH+i/EBL9RZzllsm3kzW2O8hIOcHwEjh9EKSG7A=;
 b=IAvqutgX3/aEN0FNCaTgIs3Nnp4ktmhD5QnAoWumSWY5rX4i7uqm7bWnVamEjewx2R+Wif
 5ZmNfZZdhITGQLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7748113AA8;
 Tue,  5 Aug 2025 20:29:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Uw4iDb1pkmjpQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Aug 2025 20:29:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 0/1] Migration patches for 2025-08-05
Date: Tue,  5 Aug 2025 17:29:45 -0300
Message-Id: <20250805202946.19644-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.29 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 gitlab.com:url]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

The following changes since commit a41280fd5b94c49089f7631c6fa8bb9c308b7962:

  Merge tag 'pull-aspeed-20250804' of https://github.com/legoater/qemu into staging (2025-08-04 08:57:07 -0400)

are available in the Git repository at:

  https://gitlab.com/farosas/qemu.git tags/migration-20250805-pull-request

for you to fetch changes up to a04ba043a3b03b49466b8ba95290e0507f268069:

  meson: remove 'gnutls-bug1717-workaround' for migration TLS crashes (2025-08-05 16:27:25 -0300)

----------------------------------------------------------------
Migration pull request

- Disable GNUTLS bug workaround

----------------------------------------------------------------

Daniel P. Berrangé (1):
  meson: remove 'gnutls-bug1717-workaround' for migration TLS crashes

 meson.build                   | 6 +++---
 meson_options.txt             | 2 --
 scripts/meson-buildoptions.sh | 5 -----
 3 files changed, 3 insertions(+), 10 deletions(-)

-- 
2.35.3


