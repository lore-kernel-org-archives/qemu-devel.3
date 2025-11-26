Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E09ED10F39
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOF56-0005Dx-J0; Wed, 26 Nov 2025 07:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vOF53-000536-8j
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:57:09 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vOF51-00014v-Mt
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:57:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D99C22D61;
 Wed, 26 Nov 2025 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764161825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BVvevV/KD+W/7F8jX91Naz83rLpfQgrCW+ufhyd1l0=;
 b=BoAScTAd35uPMFxL81e/vrbXtT64IFYZfi9aqYzQKW+qWaL6Xbv5CDflp6TxtQYBMh12vs
 WKi+JcwvUuyARLGkqk53UAKWW7giKP+oEqoEC7CRYvcOcv+LNCmTiVMrmP1gSwpPWhQKdX
 G8Od0UsAk7gBBEiz48fuom0fNWivywQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764161825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BVvevV/KD+W/7F8jX91Naz83rLpfQgrCW+ufhyd1l0=;
 b=NdS5UwLUkoVeQJf5qXBofl+B2KeFxUKFhqlL3EWspOLDoSsXe86snB/4qu6evPVyTmw5PM
 jgAJw8R5VpFdBYBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BoAScTAd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NdS5UwLU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764161825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BVvevV/KD+W/7F8jX91Naz83rLpfQgrCW+ufhyd1l0=;
 b=BoAScTAd35uPMFxL81e/vrbXtT64IFYZfi9aqYzQKW+qWaL6Xbv5CDflp6TxtQYBMh12vs
 WKi+JcwvUuyARLGkqk53UAKWW7giKP+oEqoEC7CRYvcOcv+LNCmTiVMrmP1gSwpPWhQKdX
 G8Od0UsAk7gBBEiz48fuom0fNWivywQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764161825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BVvevV/KD+W/7F8jX91Naz83rLpfQgrCW+ufhyd1l0=;
 b=NdS5UwLUkoVeQJf5qXBofl+B2KeFxUKFhqlL3EWspOLDoSsXe86snB/4qu6evPVyTmw5PM
 jgAJw8R5VpFdBYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0DA33EA63;
 Wed, 26 Nov 2025 12:57:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1Xw7IiD5JmlzYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Nov 2025 12:57:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pawel Zmarzly <pzmarzly0@gmail.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH v2] migration: fix parsing snapshots with
 x-ignore-shared flag
In-Reply-To: <20251126121233.542473-1-pzmarzly0@gmail.com>
References: <20251126121233.542473-1-pzmarzly0@gmail.com>
Date: Wed, 26 Nov 2025 09:57:02 -0300
Message-ID: <87ldjtdk9t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D99C22D61
X-Rspamd-Action: no action
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

Pawel Zmarzly <pzmarzly0@gmail.com> writes:

> Snapshots made with mapped-ram and x-ignore-shared flags are
> not parsed properly.
>

I'd suggest some extra words to help people in the future (no need to
resend, we can add it while merging):

"The ignore-shared feature adds and extra field in the stream, which
needs to be consumed on the destination side. Even though mapped-ram has
a fixed header format, the ignore-shared is part of the "generic" stream
infomation so the mapped-ram code is currently skipping that be64 read
which incorrectly offsets every subsequent read from the stream.

The current ignore-shared handling can simply be moved earlier in the
code to encompass mapped-ram as well since the ignore-shared doubleword
is the first one read when parsing the ramblock section of the stream."

> Co-authored-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>

taking or leaving my additions:
Reviewed-by: Fabiano Rosas <farosas@suse.de>

@Peter, we can probably merge this and deal with the rest of the
ignore-shared situation later, right?


