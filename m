Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0556E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZ43-0004W6-U6; Fri, 06 Dec 2024 09:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZ41-0004Vn-G3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:12:13 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZ3z-0006M2-St
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:12:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8C901F7ED;
 Fri,  6 Dec 2024 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733494328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rH0JcEE1mQWshJr3HME8efAwp7/D3OHeZI7h1KYP8rw=;
 b=M6FyAu2kATglZur5gKnQPwd+1YsGmLGeqfhY75ynEIj70+rxUbOlRJHn4h1c4a0n3KKUkY
 4B4VmSEmItee6rbCRlU1tjEjphUQuYTRQfp911Q+YQBYayR4DahxKGARZUHL4x7fOwC8+X
 E6kqqganxfQw1U7+NqKVb6lgQYAPf9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733494328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rH0JcEE1mQWshJr3HME8efAwp7/D3OHeZI7h1KYP8rw=;
 b=iZn+2TRqJIkIMU13cu3mRb0mStKiDONcp/Larekz+f22jxJNWIOyvYmdtSbnvrolscAAlA
 VgHg0oH0F5aif8Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733494327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rH0JcEE1mQWshJr3HME8efAwp7/D3OHeZI7h1KYP8rw=;
 b=I3GmtcVLL/uIGdHg+RplL43xLzKmPwbFzaS9JeCsyFwIPqdSrofeaDd0/3SqRg87HNyeIe
 0zadHpgznJbIYC7mOVyuGBLf0vuyi+FMnk+u9owEXVnjDmN9RuhuBGitCGUd+1lRRdb2WW
 XLAd8Vv5Qyj0Fx2jhbN8CzC8Zt7QATY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733494327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rH0JcEE1mQWshJr3HME8efAwp7/D3OHeZI7h1KYP8rw=;
 b=vOERNPyQx6PQnoDRUXhNBNYPdxsivE3VL67tDrG/ZhNcFqBEzldH8ypc5eYXpH6kZ9hD5x
 vlBV+3JE0RQ3f3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDAA138A7;
 Fri,  6 Dec 2024 14:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p9pRDDcGU2e+ZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 14:12:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 4/7] migration/multifd: Unify
 RAM_SAVE_FLAG_MULTIFD_FLUSH messages
In-Reply-To: <20241206005834.1050905-5-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-5-peterx@redhat.com>
Date: Fri, 06 Dec 2024 11:12:04 -0300
Message-ID: <87y10sc34b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-2.80)[99.16%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> RAM_SAVE_FLAG_MULTIFD_FLUSH message should always be correlated to a sync
> request on src.  Unify such message into one place, and conditionally send
> the message only if necessary.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

