Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE43DC25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9u2Z-0005uo-Ft; Wed, 22 May 2024 18:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9u2X-0005uR-L2; Wed, 22 May 2024 18:02:29 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9u2W-0000gI-3B; Wed, 22 May 2024 18:02:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 854ED1F890;
 Wed, 22 May 2024 22:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716415343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNI8NstOpoXGQnSvfm4ZgKol35tBxj9SrbRkhKOOFE0=;
 b=tyOt4JM+qMhV9ABpDwrICBKggYY1qgtV6izT4V5motavDQXOVVK4zo5A3+r8f2BGu5zJ2W
 i1nDGbdIofvxeggpyAEKTt2oj+qopDD6EhbpqIjTwBUwVMO2wiQN/vyB47exIl5gzJBjx8
 F3MREtVCq6yg7BlK6pGipCnXG2KJX7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716415343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNI8NstOpoXGQnSvfm4ZgKol35tBxj9SrbRkhKOOFE0=;
 b=FA97JBvCnIGjVJPl9gkm/+h+jhIBbPkGA4tUc9XIUnX2aNsq5CmTrpt7ieseE0jCICNytM
 ywrn67LaOtgNkTCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716415343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNI8NstOpoXGQnSvfm4ZgKol35tBxj9SrbRkhKOOFE0=;
 b=tyOt4JM+qMhV9ABpDwrICBKggYY1qgtV6izT4V5motavDQXOVVK4zo5A3+r8f2BGu5zJ2W
 i1nDGbdIofvxeggpyAEKTt2oj+qopDD6EhbpqIjTwBUwVMO2wiQN/vyB47exIl5gzJBjx8
 F3MREtVCq6yg7BlK6pGipCnXG2KJX7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716415343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNI8NstOpoXGQnSvfm4ZgKol35tBxj9SrbRkhKOOFE0=;
 b=FA97JBvCnIGjVJPl9gkm/+h+jhIBbPkGA4tUc9XIUnX2aNsq5CmTrpt7ieseE0jCICNytM
 ywrn67LaOtgNkTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A403D13A1E;
 Wed, 22 May 2024 22:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CD6LGm1rTmbwKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:02:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration-test: Run some basic tests on s390x
 and ppc64 with TCG, too
Date: Wed, 22 May 2024 19:02:09 -0300
Message-Id: <171641446561.2133.7144970086256827850.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522091255.417263-1-thuth@redhat.com>
References: <20240522091255.417263-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.05 / 50.00]; BAYES_HAM(-2.75)[98.90%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[6]
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

On Wed, 22 May 2024 11:12:55 +0200, Thomas Huth wrote:
> On s390x, we recently had a regression that broke migration / savevm
> (see commit bebe9603fc ("hw/intc/s390_flic: Fix crash that occurs when
> saving the machine state"). The problem was merged without being noticed
> since we currently do not run any migration / savevm related tests on
> x86 hosts.
> While we currently cannot run all migration tests for the s390x target
> on x86 hosts yet (due to some unresolved issues with TCG), we can at
> least run some of the non-live tests to avoid such problems in the future.
> Thus enable the "analyze-script" and the "bad_dest" tests before checking
> for KVM on s390x or ppc64 (this also fixes the problem that the
> "analyze-script" test was not run on s390x at all anymore since it got
> disabled again by accident in a previous refactoring of the code).
> 
> [...]

Queued, thanks!

