Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D3C88E7B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIaK-0000x6-5L; Mon, 26 Jan 2026 04:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vkIaA-0000vY-My
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:08:29 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vkIa6-00033b-SA
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:08:25 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7F793336FF;
 Mon, 26 Jan 2026 09:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769418495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dqkguxi6Aku1WKcGxWCUSW5PFM51sdIUIKEjuMqWg0I=;
 b=DBM4ivkIKxbBCFtSgNkZIcW4E3eL08J70g5fzyfV8mc/3dr1JFG1K6zUBGRXIi+nGxLNG9
 S31cPLwiDejp1KQYZLPGQOtqPe55gRhUKPxskPylzDXhNLL+QBwa+OSQ7b2KMn6ny1N2zx
 KNetfoKiovywC/6JoYtjifJVzlZ32Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769418495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dqkguxi6Aku1WKcGxWCUSW5PFM51sdIUIKEjuMqWg0I=;
 b=AUD9KCq/pp5xqtB86CLPoEF6EIv/KW5pUK+iDfh5usCuwjg0WguV7Uaa7lMQ/ekffOVbN6
 nOYEqZ2UJPclM6Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769418494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dqkguxi6Aku1WKcGxWCUSW5PFM51sdIUIKEjuMqWg0I=;
 b=ILeQ+zCKA8ac7RQugbKFN8a4qPS7ZJ4vTXvfIuT3skGVBTmshIT9ewvNahokMFNYZkyKuo
 WIa3IooR1ThillMBX0WtwKlQse0XdpJ5rJc4wgsumwn4md2CjTI7PV5mhKJSwWMzbgb+9l
 vXnaOV4QwJYIVIAbY5g0jKQkrmUXUo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769418494;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dqkguxi6Aku1WKcGxWCUSW5PFM51sdIUIKEjuMqWg0I=;
 b=KZv2l8U/WScNk1fxfpyWHhtoV+xuD9ebekfNasX3FEb/cdxRRFBkXXIv7g26jdgKT5a6ri
 MI7KukyepaP+frDA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 709B94A04CD; Mon, 26 Jan 2026 10:08:14 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,  laurent@vivier.eu
Subject: Re: [PATCH] linux-user: look up executable in emulation dir for
 execve syscall
In-Reply-To: <c332e60e-86ed-47e9-bee6-b71657f9cf5e@gmx.de> (Helge Deller's
 message of "Fri, 23 Jan 2026 15:32:54 +0100")
References: <mvmtsyixb4m.fsf@suse.de>
 <c332e60e-86ed-47e9-bee6-b71657f9cf5e@gmx.de>
Date: Mon, 26 Jan 2026 10:08:14 +0100
Message-ID: <mvm4io8lp1d.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; RCVD_COUNT_ONE(0.00)[1];
 FREEMAIL_ENVRCPT(0.00)[gmx.de]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FREEMAIL_TO(0.00)[gmx.de];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[hawking.nue2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=schwab@suse.de; helo=smtp-out1.suse.de
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

On Jan 23 2026, Helge Deller wrote:

> could you maybe explain why this is needed?
> Did you face a real problem?

It allows the target to find the executable in the target sysroot.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

