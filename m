Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE01EC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 16:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMUAh-0006oV-Fa; Tue, 03 Jun 2025 12:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMUAa-0006nt-I7
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:07:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMUAU-0004CJ-DC
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 12:07:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 937C4219AD;
 Tue,  3 Jun 2025 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748966830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjAIcunqx/41OorzZ00bGA6yB0Xm5K1YSdV6w8QXgHs=;
 b=1Wbv/eo/iwa0oj3essLyzIUa7OzCVQoH+fd2wTtY5Ey/sFO9B/9bPt3j3vJsw7n5SPXe8e
 4ZIn2s7sIAcKGpyvjW8pTAoMkUh1o5QxpEUpLZehFKed0UG4GYCCIk/cxHzpO4FXYPQ4xX
 iGtLjfI2ZZREFSTDYqFcJaNq34oy2Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748966830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjAIcunqx/41OorzZ00bGA6yB0Xm5K1YSdV6w8QXgHs=;
 b=eduYwL7BiTYwF6g2sMzsYprhVbMxs3oun95GEWsKHw/Vur6/AWtZcLhvZBZEedhdrMuAK/
 HZ7YlI7B1sLnJmCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748966830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjAIcunqx/41OorzZ00bGA6yB0Xm5K1YSdV6w8QXgHs=;
 b=1Wbv/eo/iwa0oj3essLyzIUa7OzCVQoH+fd2wTtY5Ey/sFO9B/9bPt3j3vJsw7n5SPXe8e
 4ZIn2s7sIAcKGpyvjW8pTAoMkUh1o5QxpEUpLZehFKed0UG4GYCCIk/cxHzpO4FXYPQ4xX
 iGtLjfI2ZZREFSTDYqFcJaNq34oy2Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748966830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mjAIcunqx/41OorzZ00bGA6yB0Xm5K1YSdV6w8QXgHs=;
 b=eduYwL7BiTYwF6g2sMzsYprhVbMxs3oun95GEWsKHw/Vur6/AWtZcLhvZBZEedhdrMuAK/
 HZ7YlI7B1sLnJmCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F78513A92;
 Tue,  3 Jun 2025 16:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e2ijMK0dP2i8QwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 16:07:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Alexey
 Perevalov <a.perevalov@samsung.com>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 08/13] migration/postcopy: Report fault latencies in
 blocktime
In-Reply-To: <20250527231248.1279174-9-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-9-peterx@redhat.com>
Date: Tue, 03 Jun 2025 13:07:07 -0300
Message-ID: <875xhc4xn8.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Blocktime so far only cares about the time one vcpu (or the whole system)
> got blocked.  It would be also be helpful if it can also report the latency
> of page requests, which could be very sensitive during postcopy.
>
> Blocktime itself is sometimes not very important, especially when one
> thinks about KVM async PF support, which means vCPUs are literally almost
> not blocked at all because the guest OS is smart enough to switch to
> another task when a remote fault is needed.
>
> However, latency is still sensitive and important because even if the guest
> vCPU is running on threads that do not need a remote fault, the workload
> that accesses some missing page is still affected.
>
> Add two entries to the report, showing how long it takes to resolve a
> remote fault.  Mention in the QAPI doc that this is not the real average
> fault latency, but only the ones that was requested for a remote fault.
>
> Unwrap get_vcpu_blocktime_list() so we don't need to walk the list twice,
> meanwhile add the entry checks in qtests for all postcopy tests.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

