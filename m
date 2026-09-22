Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669E1C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zhH-0002pu-KD; Tue, 22 Sep 2026 08:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zh2-0002mG-Vu
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:33:54 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x8zh1-0008SY-3e
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:33:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 828EE1FEFC;
 Tue, 22 Sep 2026 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFc5HV6CwAAmCTRHe1iZYbsFokiBsf0yWKeHeXNb3aA=;
 b=Vkie9FUu698Yp26x7Bj4o0pDqJUSzwG7TpUA26ONHGvi3AA1+IMSH6ReErBaUpU1W8BtxL
 rmefVosOLIgQowy3ncWXemTmnS0eJ7mfgEwjvQVqFPMn4ArH4U5CfJjDPqvi2TGw2c7xX4
 w5JSOqQYaB9C/zVb6AVedsWFN1K0b7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080425;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFc5HV6CwAAmCTRHe1iZYbsFokiBsf0yWKeHeXNb3aA=;
 b=a6AQic7nFySD/NmDn8jC5u+ZRFoglPaLp5nkU7w21M826OZtecSiVyz/wG+BPLvTdCxrNi
 hDz4YHnbBi+eb0CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o3dBAvIN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B4r3JPtj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790080421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFc5HV6CwAAmCTRHe1iZYbsFokiBsf0yWKeHeXNb3aA=;
 b=o3dBAvINwipaTW8O9Nec8Tiq45g5eULrFXhxYN36k+lFzan/TK/IR/SqkeRj7Y99U6HIzh
 q7OP4MVOAeR2B2SticqXRBEYXM7yVFVIsuY34ATCRTMFwPw+Sfnk0Ug5aYQaMM+Qgq/2nE
 g6NpSOKedJ0dnHaBoIPGVvd30MSEQO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790080421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFc5HV6CwAAmCTRHe1iZYbsFokiBsf0yWKeHeXNb3aA=;
 b=B4r3JPtjOSE/waYtpGzTHFOF7XeatIPLLSQQf1loAn9VHFCDayf+EWnHcoanbrJFKMektx
 ItK1kfXY8Ce1RcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1D50136D9;
 Tue, 22 Sep 2026 12:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3ObDFaR1smr2NwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Sep 2026 12:33:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, lizhijian@fujitsu.com, jinpu.wang@cloud.ionos.com,
 isyanfei.xu@gmail.com, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH v3 0/3] migration/rdma: Misc RDMA migration fixes
In-Reply-To: <20260823021657.2824542-1-yanfei.xu@bytedance.com>
References: <20260823021657.2824542-1-yanfei.xu@bytedance.com>
Date: Tue, 22 Sep 2026 09:33:34 -0300
Message-ID: <877bkdbh41.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 828EE1FEFC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,fujitsu.com,cloud.ionos.com,gmail.com,bytedance.com];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

"Yanfei Xu" <yanfei.xu@bytedance.com> writes:

> This series fixes three RDMA migration issues.
>
> v2->v3:
>   - patch3: Change the type of return value to bool. And add an assert
>             check to unexpected WR type. (Peter)
>
> v1->v2:
>   - patch1/2: Collect Reviewed-by
>   - patch2: Add reproducation step and error logs in commit message
>   - patch3: Wrap the post-send op and retry logic into a helper, and
>             retry only once after draining a completion when the queue
>             is full. (I believe ENOMEM is only recoverable in the
>             queue-full case, so we retry once; it should succeed after
>             a completion is drained. Any further ENOMEM is treated as
>             non-recoverable.)
>
> Yanfei Xu (3):
>   migration/rdma: Fix write-side shutdown
>   migration/rdma: Post initial receive before accepting
>   migration/rdma: Retry control sends on full queue
>
>  migration/rdma.c       | 89 +++++++++++++++++++++++++-----------------
>  migration/trace-events |  2 +-
>  2 files changed, 55 insertions(+), 36 deletions(-)

Queued, thanks.

