Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DF7C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 12:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgNKb-00064M-Ml; Fri, 07 Feb 2025 07:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgNKZ-00063T-GD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:19:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgNKX-0000wP-Px
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:19:35 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D48AA1F443;
 Fri,  7 Feb 2025 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738930771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zodSMxnYvDQmbFDNfQvYp15mnXufK5NWGdH5YePjylA=;
 b=xAKEYye6Rt356gSSbokjTXrmK2HX6AuXQOrzEwjYKfjWi7kt0OHJAMFJYvGA+YkIvRPKdq
 pfsoZP7nl7Rs9bcVbYiYv+5HZ+EbHob+sWRY0MiVGlMtI55jIrF3cXiJmykSgLHobv86I4
 WqLRntfCabmttNCTI1iq+A4rs4Iegp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738930771;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zodSMxnYvDQmbFDNfQvYp15mnXufK5NWGdH5YePjylA=;
 b=HOmvBQ6H3OmLKC9N5pbrJXM1ZWErzeaUop5bxhkysjnV/9sDi+pZz1ODqMYJgqhEhWixRy
 EIQSCowNPQ5R2XCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738930770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zodSMxnYvDQmbFDNfQvYp15mnXufK5NWGdH5YePjylA=;
 b=N6nCBXBe7cFn7Ukmf7XPf3sRFhwvGF+8opxsCtq+zVRNxNABXegFZysCS/YznCwDC0nA2P
 0UQJ65nfLn4viDo8Z0r5/EA9e1C9D3uc4qrzJaoQTez6F92fJiKklk55pBUiUo/3qMbzw6
 FlR8nqZmu5Ij5corpfv7lSR6zHMrxiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738930770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zodSMxnYvDQmbFDNfQvYp15mnXufK5NWGdH5YePjylA=;
 b=6aFIJlynbwu7Ve31918G++VQOg/+nDyPeiHKj2VMMSfXXNUG1VSjLhAeN/WGVGsLEamqBs
 9u/HXH1delU2x6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 469FF139CB;
 Fri,  7 Feb 2025 12:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id He8mAVL6pWdIFAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 12:19:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 2/5] migration: refactor ram_save_target_page functions
In-Reply-To: <Z6U6-_oKIwqXz9kl@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-3-ppandit@redhat.com> <Z6U6-_oKIwqXz9kl@x1.local>
Date: Fri, 07 Feb 2025 09:19:27 -0300
Message-ID: <87frkqlzg0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Wed, Feb 05, 2025 at 05:57:09PM +0530, Prasad Pandit wrote:
>> From: Prasad Pandit <pjp@fedoraproject.org>
>> 
>> Refactor ram_save_target_page legacy and multifd
>> functions into one. Other than simplifying it,
>> it frees 'migration_ops' object from usage, so it
>> is expunged.
>> 
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One nitpick below:

Too late, this one went in the last PR.

