Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D96CC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWc8b-0004cZ-GO; Tue, 01 Jul 2025 10:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWc8Y-0004cC-Kd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:39:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWc8W-0006UQ-Ky
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:39:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12EA621163;
 Tue,  1 Jul 2025 14:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751380742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dm0NiFIO0QjF7xIqBB7nj6t4xESkqtHDg4a4euYhfcg=;
 b=FYTImx0VOoTyupJ/BUtOabQyQcwJtMp2lY7GuqybLmb4Lp7xSfHUfGhdfcNyuh35iEtdQH
 X4qlCqliX4mnAVvwjgiBt8omROFIPIRSWo9clUoSFNmrJ20VbS0BsjDrIfdX8W08QJ7lb1
 Y/j7y94xDM6EWoiwZpu3tl8dBpvqx0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751380742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dm0NiFIO0QjF7xIqBB7nj6t4xESkqtHDg4a4euYhfcg=;
 b=+cCGo7c+4taXYT8lhSfTPjfFx8Quu70XUhUghrcp6EQyZadsLCsFah+7xjUHvOfYlm5X+9
 45juBRkEkItu0EAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751380741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dm0NiFIO0QjF7xIqBB7nj6t4xESkqtHDg4a4euYhfcg=;
 b=aZHGUeLy14TGCC3wHNL6KckW5Bde65e8OMtN9iGOAHa9A+WMCU61bUEPfSDM80vONtPQHe
 GGrY32Lw6rXGZDkkzb0f39D9mQFjNJz0wi3QIlC5O87qNKzJmFUuS5/4jLMxy+Z3Z2WNGv
 /FOONW8lUAEkh4Ufb/IUsNDZwPID18A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751380741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dm0NiFIO0QjF7xIqBB7nj6t4xESkqtHDg4a4euYhfcg=;
 b=goeKJ0VotKsBWVeVwfvcIxwbnxkaa8OwzIUQtpclR+VOOHvH2fje50oFrEhvqiebE0D+65
 T3fw1slsAHcnvsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 893F81364B;
 Tue,  1 Jul 2025 14:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ObtREgTzY2jLEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 01 Jul 2025 14:39:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Alexey Perevalov <a.perevalov@samsung.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU
 results
In-Reply-To: <20250609161855.6603-3-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
 <20250609161855.6603-3-peterx@redhat.com>
Date: Tue, 01 Jul 2025 11:38:57 -0300
Message-ID: <87ldp8562m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, samsung.com:email,
 treblig.org:email, imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> Unfortunately, it was never correctly shown..
>
> This is only found when I started to look into making the blocktime feature
> more useful (so as to avoid using bpftrace, even though I'm not sure which
> one will be harder to use..).
>
> So the old dump would look like this:
>
>   Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59
>
> Even though there're actually 40 vcpus, and the string will merge same
> elements and also sort them.
>
> To fix it, simply loop over the uint32List manually.  Now it looks like:
>
>   Postcopy vCPU Blocktime (ms):
>    [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
>     33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
>     40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
>     22, 3, 0, 0, 0, 0, 0, 0, 0, 0]
>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Alexey Perevalov <a.perevalov@samsung.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

