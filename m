Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E97CAC591
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 17:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbpO-0004Jh-Jj; Tue, 17 Sep 2024 13:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqbpN-0004Io-8b; Tue, 17 Sep 2024 13:17:25 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqbpL-0004pu-C6; Tue, 17 Sep 2024 13:17:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E522720131;
 Tue, 17 Sep 2024 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726593438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KyYkef0jfQX81VnM2HEYNGbYquLz4TCQxi3ghZVPI0=;
 b=KlNjEBMsIb2BdGR+mXGeMUP1KxvdrEgCvmGkhj7bDpnf+9z+QxY3rt2pmHUsnRSR1VTGMv
 MHfGyB3jxmomcugpq3kBLo7Dia+JvJ4DNyrLzWqcvW+z/eyAmhicX2c6Yt6OBnwP8dF7AH
 WwDFbQ4oaQg3tgLKWB1tXVV1tjNIPLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726593438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KyYkef0jfQX81VnM2HEYNGbYquLz4TCQxi3ghZVPI0=;
 b=8Tk2L+hqcP7M/JALhjJgL10fSD5CnV9+70ZZRoHaX/n1o2KUWmGkTpHHQltViz0wqjD8At
 YmqsrnUwToNXpzBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vRRBJFoh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wZyS848S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726593437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KyYkef0jfQX81VnM2HEYNGbYquLz4TCQxi3ghZVPI0=;
 b=vRRBJFohXqpy/hpD5vcJ8MU/bMOHnsJjIdtZP748u13LbDIxjYhlJlzyCysc/LT/pg6Lao
 iS/s5YBS4bvJtVcwtLQlMyCAtdN9owgiaH1YrsY+JvNOhC5wM364MZhWuXgYSbwO2g4yDl
 dtdm7DZ5aVD7swN8s57MB9vGckyuSxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726593437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KyYkef0jfQX81VnM2HEYNGbYquLz4TCQxi3ghZVPI0=;
 b=wZyS848Sc9ZwSKoNPbWV1NTsfGHN+0ILtmd9eTDH9sduJARPd5LBjI8zOFOmrCExahyZXj
 NgaAz93itRhMoADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B523139CE;
 Tue, 17 Sep 2024 17:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A6q7DJ256WYDdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Sep 2024 17:17:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] migration/savevm: Remove extra load cleanup calls
In-Reply-To: <Zumxh3Ey56YhkXcW@x1n>
References: <20240913220542.18305-1-farosas@suse.de>
 <20240913220542.18305-2-farosas@suse.de> <Zumxh3Ey56YhkXcW@x1n>
Date: Tue, 17 Sep 2024 14:17:14 -0300
Message-ID: <87ikuuyzc5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E522720131
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nongnu.org:email, suse.de:dkim, suse.de:mid,
 suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Sep 13, 2024 at 07:05:41PM -0300, Fabiano Rosas wrote:
>> There are two qemu_loadvm_state_cleanup() calls that were introduced
>> when qemu_loadvm_state_setup() was still called before loading the
>> configuration section, so there was state to be cleaned up if the
>> header checks failed.
>> 
>> However, commit 9e14b84908 ("migration/savevm: load_header before
>> load_setup") has moved that configuration section part to
>> qemu_loadvm_state_header() which now happens before
>> qemu_loadvm_state_setup().
>> 
>> Remove the cleanup calls that are now misplaced.
>> 
>> CC: qemu-stable@nongnu.org
>> Fixes: 9e14b84908 ("migration/savevm: load_header before load_setup")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> We don't need to copy stable, am I right?  IIUC it's a good cleanup,
> however not a bug fix, as qemu_loadvm_state_cleanup() can be invoked
> without calling _setup() safely?

Hm, I think you're right. If we fail in the header part the multifd
threads will still be waiting for the ram code to release them.

