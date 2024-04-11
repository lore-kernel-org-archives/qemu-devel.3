Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvai-0004F8-Cd; Thu, 11 Apr 2024 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruvaa-0004EZ-TX
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:39:44 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ruvaW-0002rs-Tt
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:39:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF93E375B5;
 Thu, 11 Apr 2024 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712846376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=WBNvzVpZF0lcpbITGVaq735Fov1GdvVgbyazH/jItqU=;
 b=VW8u5dlZ7ieEH/tDZrQkI2vm1NIj1tQ5zax6ZHYbA16lpRnui7W/oVRkntfTwr4B2LDcBj
 Yqt/7lEwRA1oRfYlBcxMjaSKwxazFwk1k81ObYQOFw8+qUajLkzAyE5ly06TunxRJZuZWM
 fas2wGj2NDCLE16OW7buQKfk4mkN63k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712846376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=WBNvzVpZF0lcpbITGVaq735Fov1GdvVgbyazH/jItqU=;
 b=qQS42Hj7cfBb4C5AwuXT5ZqK9zd0fTmX/3+wOZA3mW6cyKUNZLHdCJi8aOWcu/6a7T7Ktf
 TDZzDwFLAdP8rmAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712846376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=WBNvzVpZF0lcpbITGVaq735Fov1GdvVgbyazH/jItqU=;
 b=VW8u5dlZ7ieEH/tDZrQkI2vm1NIj1tQ5zax6ZHYbA16lpRnui7W/oVRkntfTwr4B2LDcBj
 Yqt/7lEwRA1oRfYlBcxMjaSKwxazFwk1k81ObYQOFw8+qUajLkzAyE5ly06TunxRJZuZWM
 fas2wGj2NDCLE16OW7buQKfk4mkN63k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712846376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=WBNvzVpZF0lcpbITGVaq735Fov1GdvVgbyazH/jItqU=;
 b=qQS42Hj7cfBb4C5AwuXT5ZqK9zd0fTmX/3+wOZA3mW6cyKUNZLHdCJi8aOWcu/6a7T7Ktf
 TDZzDwFLAdP8rmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A33B13685;
 Thu, 11 Apr 2024 14:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pRjHACj2F2a+SQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Apr 2024 14:39:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hailiang Zhang <zhanghailiang@xfusion.com>, Zhang Chen
 <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: COLO state?
Date: Thu, 11 Apr 2024 11:39:33 -0300
Message-ID: <87pluwarq2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.16 / 50.00]; BAYES_HAM(-2.86)[99.41%];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Hi COLO maintainers,

Would you please take a look at this issue?

https://gitlab.com/qemu-project/qemu/-/issues/2277

The reporter claims it affects from 9.0-rc2 all the way back to QEMU
7.2. I don't have any kind of setup for COLO, so it will take me a while
to be able to verify this.

Could you also provide clarification on what is the state of COLO these
days? Are any of you looking at it? Do we know of active users of the
feature?

Also, is the MAINTAINERS file reflecting the actual maintenance state
according to you?

COLO Framework
M: Hailiang Zhang <zhanghailiang@xfusion.com>
S: Maintained
F: migration/colo*
F: include/migration/colo.h
F: include/migration/failover.h
F: docs/COLO-FT.txt

COLO Proxy
M: Zhang Chen <chen.zhang@intel.com>
M: Li Zhijian <lizhijian@fujitsu.com>
S: Supported
F: docs/colo-proxy.txt
F: net/colo*
F: net/filter-rewriter.c
F: net/filter-mirror.c
F: tests/qtest/test-filter*

Thanks

