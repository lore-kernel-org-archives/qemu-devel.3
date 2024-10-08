Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A747CEFC3D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syF8p-0003PX-Cb; Tue, 08 Oct 2024 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syF8k-0003PI-2x
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:40:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1syF8h-0001D9-4G
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:40:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18E3A21D8D;
 Tue,  8 Oct 2024 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728412851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugooexaY0u4h6LrqvUhc/Kj0BhsRtNYiUig/5y3MUeM=;
 b=Cyi8KDAZPc3/we7y+3gvr4MCoQ+JTcwfDCgRKv/TrWDA43ju8WplDg0f4BGHU9CelniE5L
 Ci3Lk1ZnnY13IPjoRujVU3Xi+ypWzXetCo1itMSY4thR7sAe2wLDEC+HrFZJFAeJ8GanrT
 42GMk8BRDjUbJZJQMA8VuFbhrnFEKr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728412851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugooexaY0u4h6LrqvUhc/Kj0BhsRtNYiUig/5y3MUeM=;
 b=J5W1cxz/yHwqfVJlAIaIiSoGH4zczj3ni9YO8L3UYyCVoTf/VHy4zJCQcgtv+l1nI7d5ny
 lbyvcCnJVbD5HJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728412851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugooexaY0u4h6LrqvUhc/Kj0BhsRtNYiUig/5y3MUeM=;
 b=Cyi8KDAZPc3/we7y+3gvr4MCoQ+JTcwfDCgRKv/TrWDA43ju8WplDg0f4BGHU9CelniE5L
 Ci3Lk1ZnnY13IPjoRujVU3Xi+ypWzXetCo1itMSY4thR7sAe2wLDEC+HrFZJFAeJ8GanrT
 42GMk8BRDjUbJZJQMA8VuFbhrnFEKr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728412851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugooexaY0u4h6LrqvUhc/Kj0BhsRtNYiUig/5y3MUeM=;
 b=J5W1cxz/yHwqfVJlAIaIiSoGH4zczj3ni9YO8L3UYyCVoTf/VHy4zJCQcgtv+l1nI7d5ny
 lbyvcCnJVbD5HJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E3F01340C;
 Tue,  8 Oct 2024 18:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NFqsDrJ8BWeDbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 08 Oct 2024 18:40:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Shivam Kumar <shivam.kumar1@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Use multifd state to determine if multifd cleanup is
 needed
In-Reply-To: <ZwVJ16JDW_U6fPeo@x1n>
References: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
 <ZwQLzf8mGHCr1Itg@x1n> <87h69mu164.fsf@suse.de> <ZwVJ16JDW_U6fPeo@x1n>
Date: Tue, 08 Oct 2024 15:40:47 -0300
Message-ID: <87a5fetp3k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

> On Tue, Oct 08, 2024 at 11:20:03AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Oct 07, 2024 at 03:44:51PM +0000, Shivam Kumar wrote:
>> >> If the client calls the QMP command to reset the migration
>> >> capabilities after the migration status is set to failed or cancelled
>> >
>> > Is cancelled ok?
>> >
>> > Asked because I think migrate_fd_cleanup() should still be in CANCELLING
>> > stage there, so no one can disable multifd capability before that, it
>> > should fail the QMP command.
>> >
>> > But FAILED indeed looks problematic.
>> >
>> > IIUC it's not only to multifd alone - is it a race condition that
>> > migrate_fd_cleanup() can be invoked without migration_is_running() keeps
>> > being true?  Then I wonder what happens if a concurrent QMP "migrate"
>> > happens together with migrate_fd_cleanup(), even with multifd always off.
>> >
>> > Do we perhaps need to cleanup everything before the state changes to
>> > FAILED?
>> >
>> 
>> Should we make CANCELLED the only terminal state aside from COMPLETED?
>> So migrate_fd_cleanup would set CANCELLED whenever it sees either
>> CANCELLING or FAILED.
>
> I think that may be a major ABI change that can be risky, as we normally
> see CANCELLED to be user's choice.

Ok, I misunderstood your proposal.

>
> If we really want an ABI change, we could also introduce FAILING too, but I
> wonder what I replied in the other email could work without any ABI change,
> but close the gap on this race.

I don't think we want a FAILING state, but indeed something else that
conveys the same meaning as CANCELLING. I have already suggested
something similar in our TODO list[1]. We need a clear indication of
both "cancelling" and "failing" that's decoupled from the state ABI. Of
course we're talking only about "failing" here, we can leave
"cancelling" which is more complex for another time maybe.

What multifd does with ->exiting seems sane to me.

1- https://wiki.qemu.org/ToDo/LiveMigration#Migration_cancel_concurrency

