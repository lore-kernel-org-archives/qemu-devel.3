Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3955C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkXs-0007ZO-GY; Mon, 24 Jun 2024 10:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sLkXn-0007Z4-Re
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:19:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sLkXm-0002me-7J
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:19:43 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:10:168:4:11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 207E2210EE
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719238780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=CLUzwVo3O+JmH3pCS8DAkxAP2Btw8Lo6O1mSXS0Pw1A=;
 b=FP1MIJ4HiAoM0Du0iaRi5I5HZn8kYtkzQP6NfIz+MbDsv9iDfVmeJwfgjNFMohC+Ps344k
 Qhab3SsxsYMu66/6suWQwWQ04tMiDL2pU3yhYHl6ZJjVAbuKZ2wL5ZnEDg3DZgGI2ZAOAy
 Nh3ilDOVKpmKa6362EQcl4pHp4a/WKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719238780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=CLUzwVo3O+JmH3pCS8DAkxAP2Btw8Lo6O1mSXS0Pw1A=;
 b=AmTqZCa7W1wNfPLwA7zFYGJvoqvWGq81iZVPNpwklZ22rG8IZgzw8uBZdujQB1499Qqrcc
 8LPkK7fLExeeODBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FP1MIJ4H;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AmTqZCa7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719238780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=CLUzwVo3O+JmH3pCS8DAkxAP2Btw8Lo6O1mSXS0Pw1A=;
 b=FP1MIJ4HiAoM0Du0iaRi5I5HZn8kYtkzQP6NfIz+MbDsv9iDfVmeJwfgjNFMohC+Ps344k
 Qhab3SsxsYMu66/6suWQwWQ04tMiDL2pU3yhYHl6ZJjVAbuKZ2wL5ZnEDg3DZgGI2ZAOAy
 Nh3ilDOVKpmKa6362EQcl4pHp4a/WKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719238780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=CLUzwVo3O+JmH3pCS8DAkxAP2Btw8Lo6O1mSXS0Pw1A=;
 b=AmTqZCa7W1wNfPLwA7zFYGJvoqvWGq81iZVPNpwklZ22rG8IZgzw8uBZdujQB1499Qqrcc
 8LPkK7fLExeeODBg==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id F10C94A03D4; Mon, 24 Jun 2024 16:19:39 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: linux-user crash in python test
X-Yow: Somewhere in Tenafly, New Jersey, a chiropractor is viewing
 ``Leave it to Beaver''!
Date: Mon, 24 Jun 2024 16:19:39 +0200
Message-ID: <mvmjziepgn8.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [1.60 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 RDNS_NONE(1.00)[]; NEURAL_HAM_LONG(-0.99)[-0.995];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.975]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MX_GOOD(-0.01)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 207E2210EE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=schwab@suse.de; helo=smtp-out1.suse.de
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

$ /usr/bin/python3.11 -m unittest -v test.test_signal.StressTest.test_stress_modifying_handlers
test_stress_modifying_handlers (test.test_signal.StressTest.test_stress_modifying_handlers) ... ok

----------------------------------------------------------------------
Ran 1 test in 0.526s

OK
$ qemu-x86_64 /usr/bin/python3.11 -m unittest -v test.test_signal.StressTest.test_stress_modifying_handlers
test_stress_modifying_handlers (test.test_signal.StressTest.test_stress_modifying_handlers) ... qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

