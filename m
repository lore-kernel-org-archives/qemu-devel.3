Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B76C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 20:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s05mP-0001hy-DT; Thu, 25 Apr 2024 16:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s05mO-0001hd-1y
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 16:33:16 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s05mL-0005Mz-SU
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 16:33:15 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7CB85C642;
 Thu, 25 Apr 2024 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714077192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtIBOBcw5MkS6gGhSNZih1kX3f/qjrsWcJ4V870H82Y=;
 b=rGMyZ6+r4GFRgsu90qsxFkuT8uoFiQmAu6zDA1uB4C1FT4d1QInyD8qzVCQ47fm2s7W+/i
 VGTlbTPMANeJyRITfkrvnuXVcNtMVjm/ZcU/XmzCDZ3mFwXpOtbKmItgA/sOof0BLAkzlk
 BXqn5d06YaNdpOFhb09fS7tO/ocAYYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714077192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtIBOBcw5MkS6gGhSNZih1kX3f/qjrsWcJ4V870H82Y=;
 b=kQXOxJdYOetFPYSKJ2CRIT8axbMvye8+t1g8Ea92ERLf5rNBHA1lz0fEgRvMptg7GCoCce
 /ua30IXhqKTSoqCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714077190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtIBOBcw5MkS6gGhSNZih1kX3f/qjrsWcJ4V870H82Y=;
 b=SWbNXwCfXVS6CfInbuSzhfuw7IvvsJxULeaXyrik2BA0118sorFuMT5PJe4BoK9ndqTwzY
 Bec/PnSRzCCZVVDU1kPmrsYkSN+XST1FqkrwSKOlh0lJMsAqlGdCdmepAmS+MzS+2cA7nR
 EXBqUvQlobAUrQ1i9QeuZ3FKxf/e7JI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714077190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtIBOBcw5MkS6gGhSNZih1kX3f/qjrsWcJ4V870H82Y=;
 b=xpJYOF5BEp3bfWll93GvZ+VW/MOH5ygXyx19kbSmngtgut1Ed67diQqiMbkIc5LUN3128r
 0GzmI+LlPrKEixDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3498D13991;
 Thu, 25 Apr 2024 20:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +rIdOwW+KmZvXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 20:33:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@linux.dev>, marcandre.lureau@redhat.com,
 peterx@redhat.com, armbru@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: Re: [PATCH v4 02/14] util/dsa: Add dependency idxd.
In-Reply-To: <20240425022117.4035031-3-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-3-hao.xiang@linux.dev>
Date: Thu, 25 Apr 2024 17:33:07 -0300
Message-ID: <87o79xgp30.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-1.41)[90.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, linux.dev:email]
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

Hao Xiang <hao.xiang@linux.dev> writes:

> Idxd is the device driver for DSA (Intel Data Streaming
> Accelerator). The driver is fully functioning since Linux
> kernel 5.19. This change adds the driver's header file used
> for userspace development.

Have you looked at the update-linux-headers script?


