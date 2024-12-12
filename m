Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E17E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjZf-0002h2-7r; Thu, 12 Dec 2024 08:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLjZV-0002gK-Ml
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:49:42 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLjZT-00040y-Bl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:49:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8E7C1F37C;
 Thu, 12 Dec 2024 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734011377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rW0pGTjuBreHoVvh10CVLL4puWiaZ7MeSik02t1A0tA=;
 b=B6L5AsuklidJNepi3Ds90eHqqLwZWIuZkwPN/zVt891Rvqhqo2uPaqgWsqTM5vau8pMblL
 6fBuiflahjTTSLoH3TWwsEJenbbFVuP+l3VhjyR2gBrQ1W3MJ6ZecCIQjdbSkJfQYV+Nu6
 vT2+yEtPdY2wNU04fNuR8DMUuPfJtyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734011377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rW0pGTjuBreHoVvh10CVLL4puWiaZ7MeSik02t1A0tA=;
 b=AAOpk8LPKegnZsZP/zv3j8isRTaVDQIhWiVgO5+aiN5P5FcBc/eoRVL0S1i5yqElMx43Pu
 VLAKVfZPqTw4poAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qVfSX6MS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kraiFxGQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734011375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rW0pGTjuBreHoVvh10CVLL4puWiaZ7MeSik02t1A0tA=;
 b=qVfSX6MS5FBnN59k9btttyF/0Vqtzmt64Tjfkhr5dYiR1NgStORu8JjaQOH3tqdBewNKSu
 CJqwIR/ko6S0QYsk7xkyJEl2mP/wZ+7yUGqli5Bji64IQk38RL0hVgucTWHYBXA3uzUNHq
 tzFiEQpO7yIgu/54j6qDbFLhCybMUE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734011375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rW0pGTjuBreHoVvh10CVLL4puWiaZ7MeSik02t1A0tA=;
 b=kraiFxGQDZ3mEXCAtUt3Oj6YDMWED2N4yE1t3pFjbUj4yJXIZkIQlMo13epd10plAyWnvt
 Awt15S3p/JWEpJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51C5013939;
 Thu, 12 Dec 2024 13:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I5dFBu/pWmcXYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 13:49:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Daoud LAMALMI <daoudlamalmi@pm.me>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin
 <npiggin@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>
Subject: Re: MPC5553/MPC5554 Emulation (information request)
In-Reply-To: <kvndhk2oZokSDFW29-5pef8r1zmug70mTlHmrKT99LrvOaAflAeBV-vD6I6BAiAkHavpsN23lKJ6mN4Bd7UYFDe2tgbSegrXYVK6p-tR5F4=@pm.me>
References: <kvndhk2oZokSDFW29-5pef8r1zmug70mTlHmrKT99LrvOaAflAeBV-vD6I6BAiAkHavpsN23lKJ6mN4Bd7UYFDe2tgbSegrXYVK6p-tR5F4=@pm.me>
Date: Thu, 12 Dec 2024 10:49:32 -0300
Message-ID: <87ed2df1ub.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C8E7C1F37C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-2.69)[98.63%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[eik.bme.hu,gmail.com,ilande.co.uk];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, nongnu.org:email, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Daoud LAMALMI via <qemu-devel@nongnu.org> writes:

> Goal
> ----
>
> I'd like to know if it is planned for QEMU to be able to emulate the MPC5553/MPC5554 microcontrollers.
>
> Technical details
> -----------------
>
> I know that the e200z6 processor can already be emulated. I don't know how much work is needed to emulate those microcontrollers fully based on the work that has already been done.
>
> Additional information
> ----------------------
>
> If it is not planned, I'll most likely start educating myself on this project to try and patch it in as it's a need that is quite important for me. I'll try not to waste your time and read as much as I can about your guidelines. Would you advise me against trying to do this? I'd like to know how hard you think this will be.
>
> DISCLAIMER : I am still very much a newbie in embedded systems, I'm only in the first year of my master's degree in embedded systems.
>
> Sent with Proton Mail secure email.

Adding some people to CC that might be able to help.

