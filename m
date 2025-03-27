Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8813C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 17:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txqcZ-0004sK-5i; Thu, 27 Mar 2025 13:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txqcX-0004s3-8G
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 13:02:21 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txqcT-0000KD-GS
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 13:02:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7050F1F388;
 Thu, 27 Mar 2025 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743094933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gy6XX4wwiMLXtUZ6qvRehKcwju7U2UeQrHSor76vVzo=;
 b=slm9p9Z0Ol8L/SNsDLgcTAsFo7C45v7AxUfIxvb7nlt8Q1PGeh4jwS3/K+rS7327KS+1Lq
 YlNXSPT6No9y4aY6yydW/fTpALDqzAZGlq6eOtL88+S0/mZbVfAFBAKOh+VrO2nIAH6dFh
 GsynESyJz4I3HenEr0ILT0WJn1FRNP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743094933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gy6XX4wwiMLXtUZ6qvRehKcwju7U2UeQrHSor76vVzo=;
 b=ceJA6Rg2f9oe+jenTqpM5c8bq4cQMZsNX5U32PQC/uVf/RpCLLpdlfBnu99m+98z/gE0mb
 tv5pGEgjniHKRAAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=slm9p9Z0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ceJA6Rg2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743094933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gy6XX4wwiMLXtUZ6qvRehKcwju7U2UeQrHSor76vVzo=;
 b=slm9p9Z0Ol8L/SNsDLgcTAsFo7C45v7AxUfIxvb7nlt8Q1PGeh4jwS3/K+rS7327KS+1Lq
 YlNXSPT6No9y4aY6yydW/fTpALDqzAZGlq6eOtL88+S0/mZbVfAFBAKOh+VrO2nIAH6dFh
 GsynESyJz4I3HenEr0ILT0WJn1FRNP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743094933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gy6XX4wwiMLXtUZ6qvRehKcwju7U2UeQrHSor76vVzo=;
 b=ceJA6Rg2f9oe+jenTqpM5c8bq4cQMZsNX5U32PQC/uVf/RpCLLpdlfBnu99m+98z/gE0mb
 tv5pGEgjniHKRAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D08AA1376E;
 Thu, 27 Mar 2025 17:02:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ScgrI5SE5We+EwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 17:02:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 berrange@redhat.com
Subject: Re: [PATCH 1/4] migration/savevm: Add a  compatibility check for
 capabilities
In-Reply-To: <1d2f0f-67e58100-9ef-73c46680@132395354>
References: <20250327143934.7935-1-farosas@suse.de>
 <20250327143934.7935-2-farosas@suse.de>
 <1d2f0f-67e58100-9ef-73c46680@132395354>
Date: Thu, 27 Mar 2025 14:02:09 -0300
Message-ID: <87bjtmmmpa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 7050F1F388
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

"Marco Cavenati" <Marco.Cavenati@eurecom.fr> writes:

> Hello Fabiano,
>
> First of all thanks a lot for the quick follow up to my issue!
>
> I just want to point out that with only mapped-ram enabled (without
> multifd) savevm/loadvm do not lead to a crash but just to an error
> according to my (few) experiments (on upstream).
>

Yes, absolutely. I used imprecise language. Thanks for the correction,
I'll explain it better in the following versions.

