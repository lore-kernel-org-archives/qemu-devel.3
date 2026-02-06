Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467AEE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 19:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voRqW-0008Ha-Dx; Fri, 06 Feb 2026 14:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voRqR-0008Gm-Ab
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 14:50:23 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voRqP-0005iP-93
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 14:50:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2CE63E6EA;
 Fri,  6 Feb 2026 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770407418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4095VZQr9qGiVsP6njyK3J171M9Ipkhyf3rz8kOGmQ=;
 b=EvlQSY+6IO8P9cgSD4qt9MiDH7bXRd58O6U3FAUfBTs1Aue8WgdSvprJrrkUk1rwSg/YWH
 t56bDJVyzTFnSjiJH5hWKALGh9t0Hn4STnudvsp34TkUzY9iOl9q+5QQy3iRWBwVUK54bj
 qTnHfMxW17iEAmbSZTqiL/iWA4IBjIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770407418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4095VZQr9qGiVsP6njyK3J171M9Ipkhyf3rz8kOGmQ=;
 b=9pVA1g3kbdqTKEyz4brsqYQiLN3TcEcW+SodigmK8JzHgf+ax/DPhaoF7UjJPUCZPAU9Wv
 wQBTHY8y4l0iOZCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770407418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4095VZQr9qGiVsP6njyK3J171M9Ipkhyf3rz8kOGmQ=;
 b=EvlQSY+6IO8P9cgSD4qt9MiDH7bXRd58O6U3FAUfBTs1Aue8WgdSvprJrrkUk1rwSg/YWH
 t56bDJVyzTFnSjiJH5hWKALGh9t0Hn4STnudvsp34TkUzY9iOl9q+5QQy3iRWBwVUK54bj
 qTnHfMxW17iEAmbSZTqiL/iWA4IBjIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770407418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4095VZQr9qGiVsP6njyK3J171M9Ipkhyf3rz8kOGmQ=;
 b=9pVA1g3kbdqTKEyz4brsqYQiLN3TcEcW+SodigmK8JzHgf+ax/DPhaoF7UjJPUCZPAU9Wv
 wQBTHY8y4l0iOZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B2923EA63;
 Fri,  6 Feb 2026 19:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TNBvO/lFhmm6ZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Feb 2026 19:50:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 8/9] migration/options: Stop freeing s->parameters
 members individually
In-Reply-To: <aYYU5fbU5l4grFav@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-9-farosas@suse.de> <aYUWwSxnsWn1Dfu0@x1.local>
 <87a4xmqcmn.fsf@suse.de> <aYYU5fbU5l4grFav@x1.local>
Date: Fri, 06 Feb 2026 16:50:15 -0300
Message-ID: <87343dd53c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Feb 06, 2026 at 09:29:04AM -0300, Fabiano Rosas wrote:
>> There's some amount of rigidness caused by qdev requirements
>> unfortunately.
>> 
>> I'm not sure if I ever posted it, but I wrote some code to move the
>> parameters into a MigrationOptions object so we could make
>> MigrationState not be a TYPE_DEVICE anymore. But then we'd end up with
>> something like -global migration-options by default, so it kinda killed
>> the idea.
>
> It's not strictly about TYPE_DEVICE, but reusing of qdev properties, right?
> At least the issue described by your comment was about offseting and it
> sounds like so.
>

Absolutely, I was just rambling.

Of course, TYPE_DEVICE brings us weirdness such as:

(qemu) device_add migration,help                             
migration options:                                           
  announce-initial=<size> -  (default: 50)         
  announce-max=<size>    -  (default: 550)        
  announce-rounds=<size> -  (default: 5)    
...

So it would be nice to drop this dependency.

> I just want to double check with you that I think the problem you described
> will also present even after applying my other series:
>
> https://lore.kernel.org/r/20251209162857.857593-1-peterx@redhat.com
>
> That series only removes the TYPE_DEVICE dependency, but not qdev
> properties.  I think it's the qdev property trick that is relevant at least
> to the offset issue you mentioned so MigrationParameters cannot be
> g_new()ed.
>
> The major use case for this qdev reuse is: (1) help scripting, so as to use
> -global migration.XXX=YYY, (2) support migration in machine compat
> properties.  IIUC (1) isn't a major thing we ask for (again, maybe I used
> the most of it.. but maybe only me; I'm not sure..), as long as anything
> can keep (2) working then we can consider.

The properties are also useful in providing defaults for the migration
options and perhaps we could make use of the .get/.set methods in a more
convenient way in the migration code, such as implementing per-option
input validation instead of checking all options always. (although I
haven't thought about the overlap with QAPI)

About -global, we should do better to separate the compat options from
the regular options. (and no, a blank line in options.c is not enough
separation!). I worry someday we'll break something in compat while
trying to change the regular options.

Another point is that even after all the recent changes to options.c, we
are still left with a list of migration_properties that is optional to
use. Which means setting defaults is also optional.

If we decide to retroactively add a default we'll suddenly have a new
option showing up in -global! Having to discover mid-way through the
implementation of a new migration feature that setting a default like
the other options do will also add property code to your option and now
you have one more source of SIGSEGV is not super fun either.

I had the intention to somehow force every option to have an equivalent
in migration_properties so that every option would have a default
explicitly set, but seeing the recent work on fixing the StrOrNull
property, I don't think it's worth it to ask that people go through the
hassle of implementing a property (when the new option cannot use the
existing types).


