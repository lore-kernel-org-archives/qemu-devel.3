Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04BAD3C937
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 17:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTOBN-0000ya-V5; Wed, 10 Dec 2025 12:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vTOBI-0000yI-Nj
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:40:54 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vTOBG-0004YZ-Uw
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:40:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2E553394E;
 Wed, 10 Dec 2025 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765388447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWKOqOnpOO90UnDTBSyJM1SPC0Wzafg02837inibEZM=;
 b=DC3QgYHGtdeCINcGAD+flcGTnQp33e4ZlQJIyXQq05ii8PNgnl3Tv+0HdD5XbwsjjDL6J0
 Hs5qQir/uU4yMsRK/MEvv412u0iCTnbidSlOwk/uhUs+AR0024pw3duEbo39gtS4Oo9ZuO
 5GhZxhz8XVBI7GgFEM+tBdS0xJeVibo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765388447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWKOqOnpOO90UnDTBSyJM1SPC0Wzafg02837inibEZM=;
 b=O1boxGfHjsIoODAxCLE8Vy4qduczMtqYIxfElnJxLDDdaGFq4cjwKE3fXFIqY52FUtfiQW
 wLPC514fviybKlAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JvpUPr1I;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mJZK7Fym
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765388445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWKOqOnpOO90UnDTBSyJM1SPC0Wzafg02837inibEZM=;
 b=JvpUPr1IHFzwp/W4o22RD0iYGt2f886He1A6HXQtBcedx8a+3JJIv25W628/N418UBkh6G
 tIP867yNmtPOT1t4FyMq/Xe4Tp9HTYncawxIabIf5mztAJeWWdGQJhpNQCwyh8XV5+RRuB
 liHWclqNOgMRW4EzSQZtXE/UMs3n81Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765388445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWKOqOnpOO90UnDTBSyJM1SPC0Wzafg02837inibEZM=;
 b=mJZK7Fym564/wCto+vrZharaQ5HwI0PTq672l/sPLZexbHZMq0G0RUgZqBLKNAMG2HWJsz
 FsfWpN1fEHpD+oDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 421593EA63;
 Wed, 10 Dec 2025 17:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SH41AZ2wOWkVHwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Dec 2025 17:40:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org, clg@redhat.com
Cc: peterx@redhat.com, mark.kanda@oracle.com, bchaney@akamai.com
Subject: Re: [PATCH] MAINTAINERS: Update reviewers for CPR
In-Reply-To: <20251210143624.416697-1-bchaney@akamai.com>
References: <20251210143624.416697-1-bchaney@akamai.com>
Date: Wed, 10 Dec 2025 14:40:42 -0300
Message-ID: <87h5tyjkv9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C2E553394E
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

Ben Chaney <bchaney@akamai.com> writes:

> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63e9ba521b..dc6235e174 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3118,6 +3118,8 @@ T: git https://gitlab.com/vsementsov/qemu.git block
>  CheckPoint and Restart (CPR)
>  R: Peter Xu <peterx@redhat.com>
>  R: Fabiano Rosas <farosas@suse.de>
> +R: Mark Kanda <mark.kanda@oracle.com>
> +R: Ben Chaney <bchaney@akamai.com>
>  S: Supported
>  F: hw/vfio/cpr*
>  F: include/hw/vfio/vfio-cpr.h

Reviewed-by: Fabiano Rosas <farosas@suse.de>

