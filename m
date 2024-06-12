Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079CCC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTGg-0003XT-Ul; Wed, 12 Jun 2024 15:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHTGe-0003Wn-Lx
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:04:20 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHTGd-0001UF-3y
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:04:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7A2C347D9;
 Wed, 12 Jun 2024 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718219057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAptmcXZtmSxvMQBZM9N2BjMVQAxr/zt/7gwmY5LSSQ=;
 b=iNpOm7CRDM1dPLmc2eAQ/2Rpce51hgcUX/YyTugi/IWiQccoBtDULbROZoD07Y2PAvYrCj
 JoGsyS1yJ9IpUY1pARqE6gCY0HUqW+o2I9YVq1+0TTdxPL5yAJ4kO7+s7SC/+8rgKr8qTj
 aJehIu5OPd6gO2UUvX2jh+5gxn6Q1fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718219057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAptmcXZtmSxvMQBZM9N2BjMVQAxr/zt/7gwmY5LSSQ=;
 b=Fv074oBsBFFIhzXx/AjKmDxyVbe31uii1Umsa/NJpKhudW6JuFAp04c7VvIZQhVM7yIOAg
 GXOcrNqd0wyThaDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718219057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAptmcXZtmSxvMQBZM9N2BjMVQAxr/zt/7gwmY5LSSQ=;
 b=iNpOm7CRDM1dPLmc2eAQ/2Rpce51hgcUX/YyTugi/IWiQccoBtDULbROZoD07Y2PAvYrCj
 JoGsyS1yJ9IpUY1pARqE6gCY0HUqW+o2I9YVq1+0TTdxPL5yAJ4kO7+s7SC/+8rgKr8qTj
 aJehIu5OPd6gO2UUvX2jh+5gxn6Q1fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718219057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAptmcXZtmSxvMQBZM9N2BjMVQAxr/zt/7gwmY5LSSQ=;
 b=Fv074oBsBFFIhzXx/AjKmDxyVbe31uii1Umsa/NJpKhudW6JuFAp04c7VvIZQhVM7yIOAg
 GXOcrNqd0wyThaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31B8B132FF;
 Wed, 12 Jun 2024 19:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +NchOjDxaWZDFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 12 Jun 2024 19:04:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Bandan Das <bdas@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 2/4] migration: Rename thread debug names
In-Reply-To: <20240612144228.1179240-3-peterx@redhat.com>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-3-peterx@redhat.com>
Date: Wed, 12 Jun 2024 16:04:14 -0300
Message-ID: <878qzac79t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.28 / 50.00]; BAYES_HAM(-2.98)[99.89%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> The postcopy thread names on dest QEMU are slightly confusing, partly I'll
> need to blame myself on 36f62f11e4 ("migration: Postcopy preemption
> preparation on channel creation").  E.g., "fault-fast" reads like a fast
> version of "fault-default", but it's actually the fast version of
> "postcopy/listen".
>
> Taking this chance, rename all the migration threads with proper rules.
> Considering we only have 15 chars usable, prefix all threads with "mig/",
> meanwhile identify src/dst threads properly this time.  So now most thread
> names will look like "mig/DIR/xxx", where DIR will be "src"/"dst", except
> the bg-snapshot thread which doesn't have a direction.
>
> For multifd threads, making them "mig/{src|dst}/{send|recv}_%d".
>
> We used to have "live_migration" thread for a very long time, now it's
> called "mig/src/main".  We may hope to have "mig/dst/main" soon but not
> yet.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

