Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EFACEF17A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB4d-0001Y8-5L; Tue, 08 Oct 2024 10:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syB4S-0001XO-PS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:20:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syB4P-0000Ll-GY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:20:15 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEA2121D45;
 Tue,  8 Oct 2024 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728397206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1FPxUFJmISibyiaXo2YhSC7c6fawt+MLBgRNWi2bso=;
 b=SwAQQuwppS8l4Lx0/ajdSxAAG71m3PfBf2EreCgHSeUJ0D32BqiOB1cwAasUfBmbG7wBH9
 54ij/4GVPkoqgTliUHC1xVgvk/37yELYkCcIykuBox7qd3MN9hks5bDyqLldlHIjy8DpEk
 LZKQRlXlvUvGw29NohBRIQFT4MRw3D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728397206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1FPxUFJmISibyiaXo2YhSC7c6fawt+MLBgRNWi2bso=;
 b=jRGF53Ir8wOTwSRRUXX8dQIzvkmeQq/WzWa9/pPIGyyTKKzc0lTM3ZT3TMekeLXADFyGXL
 iAsEH0J5iKTSiKAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728397206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1FPxUFJmISibyiaXo2YhSC7c6fawt+MLBgRNWi2bso=;
 b=SwAQQuwppS8l4Lx0/ajdSxAAG71m3PfBf2EreCgHSeUJ0D32BqiOB1cwAasUfBmbG7wBH9
 54ij/4GVPkoqgTliUHC1xVgvk/37yELYkCcIykuBox7qd3MN9hks5bDyqLldlHIjy8DpEk
 LZKQRlXlvUvGw29NohBRIQFT4MRw3D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728397206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y1FPxUFJmISibyiaXo2YhSC7c6fawt+MLBgRNWi2bso=;
 b=jRGF53Ir8wOTwSRRUXX8dQIzvkmeQq/WzWa9/pPIGyyTKKzc0lTM3ZT3TMekeLXADFyGXL
 iAsEH0J5iKTSiKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B5EA1340C;
 Tue,  8 Oct 2024 14:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K436AJY/BWe3HQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 08 Oct 2024 14:20:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] Use multifd state to determine if multifd cleanup is
 needed
In-Reply-To: <ZwQLzf8mGHCr1Itg@x1n>
References: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
 <ZwQLzf8mGHCr1Itg@x1n>
Date: Tue, 08 Oct 2024 11:20:03 -0300
Message-ID: <87h69mu164.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Mon, Oct 07, 2024 at 03:44:51PM +0000, Shivam Kumar wrote:
>> If the client calls the QMP command to reset the migration
>> capabilities after the migration status is set to failed or cancelled
>
> Is cancelled ok?
>
> Asked because I think migrate_fd_cleanup() should still be in CANCELLING
> stage there, so no one can disable multifd capability before that, it
> should fail the QMP command.
>
> But FAILED indeed looks problematic.
>
> IIUC it's not only to multifd alone - is it a race condition that
> migrate_fd_cleanup() can be invoked without migration_is_running() keeps
> being true?  Then I wonder what happens if a concurrent QMP "migrate"
> happens together with migrate_fd_cleanup(), even with multifd always off.
>
> Do we perhaps need to cleanup everything before the state changes to
> FAILED?
>

Should we make CANCELLED the only terminal state aside from COMPLETED?
So migrate_fd_cleanup would set CANCELLED whenever it sees either
CANCELLING or FAILED.

