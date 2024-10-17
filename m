Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13E8D3C52C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 19:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Vl7-0000s9-Lq; Thu, 17 Oct 2024 15:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Vl6-0000rx-9m
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:02:04 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Vl4-0004oa-KS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:02:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDBCB1FD49;
 Thu, 17 Oct 2024 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729191720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZqMgmKIxxTsKkDqdR33JvkAyWyKwARsGpT3vmocORE=;
 b=SaoWJw3EWu+tG6VNfJbzXoC107fK6YhvRz3CwWZQ5nMeJAr2O7ww0FKwVcL+zgWDK3zs0r
 xmTFf9Ae7vU2Alcqas8LpHIJFr4Da0fsGMdTYk6Ib3qmYPkehaNNE2dOuX0iFXMIERRS3O
 BlY1KpWrHvUcf60EUFoT73kVaQNRjxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729191720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZqMgmKIxxTsKkDqdR33JvkAyWyKwARsGpT3vmocORE=;
 b=hFK6kqoaZrosCkHWq0wzMcPb96XfDNkDsADXnupJhs0iOk/5uSpD47kn2wnTynNHtOlBRq
 Y3UEV7Jx9nR8nvAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SaoWJw3E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hFK6kqoa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729191720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZqMgmKIxxTsKkDqdR33JvkAyWyKwARsGpT3vmocORE=;
 b=SaoWJw3EWu+tG6VNfJbzXoC107fK6YhvRz3CwWZQ5nMeJAr2O7ww0FKwVcL+zgWDK3zs0r
 xmTFf9Ae7vU2Alcqas8LpHIJFr4Da0fsGMdTYk6Ib3qmYPkehaNNE2dOuX0iFXMIERRS3O
 BlY1KpWrHvUcf60EUFoT73kVaQNRjxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729191720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZqMgmKIxxTsKkDqdR33JvkAyWyKwARsGpT3vmocORE=;
 b=hFK6kqoaZrosCkHWq0wzMcPb96XfDNkDsADXnupJhs0iOk/5uSpD47kn2wnTynNHtOlBRq
 Y3UEV7Jx9nR8nvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DE3213A42;
 Thu, 17 Oct 2024 19:02:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NXOdAShfEWdqcwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 19:02:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 yong.huang@smartx.com
Subject: Re: [PATCH v4 6/6] tests/migration: Add case for periodic ramblock
 dirty sync
In-Reply-To: <cb61504f1a1e9d5f2ca4dac12e518deb076ce9f3.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
 <cb61504f1a1e9d5f2ca4dac12e518deb076ce9f3.1729146786.git.yong.huang@smartx.com>
Date: Thu, 17 Oct 2024 16:01:57 -0300
Message-ID: <87cyjy3656.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: BDBCB1FD49
X-Spamd-Result: default: False [-4.39 / 50.00]; BAYES_HAM(-2.88)[99.47%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

