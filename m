Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98DCC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiul1-0001vg-5u; Fri, 14 Feb 2025 07:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tiuky-0001vR-HL
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:25:20 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tiukw-0003oo-Jy
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 07:25:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FC751F385;
 Fri, 14 Feb 2025 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739535915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0kpspJ1R8Oxo43erWNU9Sp1zS10azEvx6g4sbFBK3i8=;
 b=KK4JE2jpEWGnWIFo3DwPqv/oCzapv6isrnZJk8+mxpeH1SIXAbsJkkVDg39Znp7yg1PteE
 k4hlkugNba46lPYtWHQpELYCjALEhLuEUdja/V0nhrLn4TwRvbtuib4VHDPP/HvukJ9A9C
 A9/dF7zVueoWrvcgcI/9/JxSnFydMA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739535915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0kpspJ1R8Oxo43erWNU9Sp1zS10azEvx6g4sbFBK3i8=;
 b=nosp42M2yhSvNo0TfsIfJS3mibpbeLU7b+ZU9vtgQkNvVDZFK4WFzBvFENTmtvPOO1ug3f
 aWmfqWSLmhBTO9DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739535915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0kpspJ1R8Oxo43erWNU9Sp1zS10azEvx6g4sbFBK3i8=;
 b=KK4JE2jpEWGnWIFo3DwPqv/oCzapv6isrnZJk8+mxpeH1SIXAbsJkkVDg39Znp7yg1PteE
 k4hlkugNba46lPYtWHQpELYCjALEhLuEUdja/V0nhrLn4TwRvbtuib4VHDPP/HvukJ9A9C
 A9/dF7zVueoWrvcgcI/9/JxSnFydMA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739535915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0kpspJ1R8Oxo43erWNU9Sp1zS10azEvx6g4sbFBK3i8=;
 b=nosp42M2yhSvNo0TfsIfJS3mibpbeLU7b+ZU9vtgQkNvVDZFK4WFzBvFENTmtvPOO1ug3f
 aWmfqWSLmhBTO9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF9F13285;
 Fri, 14 Feb 2025 12:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LBvSIio2r2dvdQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 12:25:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v3 6/9] migration: Don't set FAILED state when cancelling
In-Reply-To: <Z65eTACUqiKQaaz1@x1.local>
References: <20250213175927.19642-1-farosas@suse.de>
 <20250213175927.19642-7-farosas@suse.de> <Z65eTACUqiKQaaz1@x1.local>
Date: Fri, 14 Feb 2025 09:25:12 -0300
Message-ID: <87jz9svhlj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Feb 13, 2025 at 02:59:24PM -0300, Fabiano Rosas wrote:
>> The expected outcome from qmp_migrate_cancel() is that the source
>> migration goes to the terminal state
>> MIGRATION_STATUS_CANCELLED. Anything different from this is a bug when
>> cancelling.
>> 
>> Make sure there is never a state transition from an unspecified state
>> into FAILED. Code that sets FAILED, should always either make sure
>> that the old state is not CANCELLING or specify the old state.
>> 
>> Note that the destination is allowed to go into FAILED, so there's no
>> issue there.
>> 
>> (I don't think this is relevant as a backport because cancelling does
>> work, it just doesn't show the right state at the end)
>> 
>> Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
>> Fixes: d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")
>> Fixes: 8518278a6a ("migration: implementation of background snapshot thread")
>> Fixes: bf78a046b9 ("migration: refactor migrate_fd_connect failures")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Not like migrate_set_state_failure(MigrationState *s)?  Not a huge deal,
> though..

I thought we had agreed over IRC that it was best to hold that until the
other MigrationStatus work happens?

Anyway, looking closer at this, there are places that handle CANCELLING
beforehand (_detect_error) and places that only set FAILED after
specific states (multifd), so a single helper will require more
churn. Let's postpone that please.

>
> Reviewed-by: Peter Xu <peterx@redhat.com>

