Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCEBCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 08:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN5N5-0004qu-Ia; Wed, 13 May 2026 04:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pfalcato@suse.de>) id 1wN5N3-0004q7-H5
 for qemu-devel@nongnu.org; Wed, 13 May 2026 04:55:13 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pfalcato@suse.de>) id 1wN5N0-0006FJ-Re
 for qemu-devel@nongnu.org; Wed, 13 May 2026 04:55:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B393625B0;
 Wed, 13 May 2026 08:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778662507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrvmwqNVnh+cKjHozCEtXLm91zioJX8XdWZ1ef92xSY=;
 b=djJm+a/bSOUjIo63eLhPR8HwDBOLlVkUsdr4k3hjw3lS+9SLR5XlK/t10xoCF7eKczSV0J
 7PwoUGX0OVCfwZZDEgywQBOxlM+NWuD1XWNHIH+tNPGOfqkvNfkHL4fDlUomj+PDN3HqHV
 yGFZD97apU2YDpNIUhCaHM3/dNK0R4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778662507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrvmwqNVnh+cKjHozCEtXLm91zioJX8XdWZ1ef92xSY=;
 b=pIxMG4KkMhYtYUDIM0IAbFbtaOPkF74yJkKjDRtNi1mca8XmRRMf208JYqz03mz0jcyTak
 vsaFLpAVoAOXwhAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="djJm+a/b";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pIxMG4Kk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778662507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrvmwqNVnh+cKjHozCEtXLm91zioJX8XdWZ1ef92xSY=;
 b=djJm+a/bSOUjIo63eLhPR8HwDBOLlVkUsdr4k3hjw3lS+9SLR5XlK/t10xoCF7eKczSV0J
 7PwoUGX0OVCfwZZDEgywQBOxlM+NWuD1XWNHIH+tNPGOfqkvNfkHL4fDlUomj+PDN3HqHV
 yGFZD97apU2YDpNIUhCaHM3/dNK0R4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778662507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrvmwqNVnh+cKjHozCEtXLm91zioJX8XdWZ1ef92xSY=;
 b=pIxMG4KkMhYtYUDIM0IAbFbtaOPkF74yJkKjDRtNi1mca8XmRRMf208JYqz03mz0jcyTak
 vsaFLpAVoAOXwhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C11BE593A9;
 Wed, 13 May 2026 08:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JnvdK2o8BGqHSAAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Wed, 13 May 2026 08:55:06 +0000
Date: Wed, 13 May 2026 09:55:04 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Niklas Cassel <cassel@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] ide: Set IDENTIFY word 93 to 0 on SATA drives
Message-ID: <agQ62QjEtcYoSAs_@pedro-suse.lan>
References: <20260318162951.1060969-1-pfalcato@suse.de>
 <a5a1a227-0df6-4d99-9850-b863bfd4cac6@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a1a227-0df6-4d99-9850-b863bfd4cac6@tls.msk.ru>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6B393625B0
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=pfalcato@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 13, 2026 at 09:30:57AM +0300, Michael Tokarev wrote:
> Hi!

Hi!

> 
> What's the outcome of all this, in the end?

Apologies for the delay, other things got in the way.
> 
> It looks like the problem should be fixed, one way or another, -
> can we perhaps fix it for qemu 11.1?

Yes, I plan on sending an adequate respin. As soon as I find some time
and properly grok the various folks' comments :)

-- 
Pedro

