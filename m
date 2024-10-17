Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1230ED3C52C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 18:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Vh0-0008Rv-Va; Thu, 17 Oct 2024 14:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Vgy-0008RW-PL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 14:57:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1Vgx-0004RZ-67
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 14:57:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 549CE1FD49;
 Thu, 17 Oct 2024 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729191465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUdv7OgMyYMdQfNuORRlZ8D8ygnBCKHyV1/G0yrz5ew=;
 b=06d9FwpHR1fekDJ5tvsNyGP1lyVRqIuLGEfeE6jlRriRcQEEQsgnXtM08cdcbTtnYUc/jg
 dmdD59cNGI0AjQ1OiYPGsM9jz+WMck1NwG+gqW7K49BHgUT7LcIL/rE28EwCXNB9Is5C3G
 0eYPr55Oq2yzUcD+eC0rTay2fvecf9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729191465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUdv7OgMyYMdQfNuORRlZ8D8ygnBCKHyV1/G0yrz5ew=;
 b=S6rCQpinA043DXwxr2SxjzR8a7cZ2maoUzzuWfxN8GT2/z6ORC1iu/0/xLDmqpPGUZtGyw
 fhuv5N8G8ykRqHAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=06d9FwpH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S6rCQpin
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729191465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUdv7OgMyYMdQfNuORRlZ8D8ygnBCKHyV1/G0yrz5ew=;
 b=06d9FwpHR1fekDJ5tvsNyGP1lyVRqIuLGEfeE6jlRriRcQEEQsgnXtM08cdcbTtnYUc/jg
 dmdD59cNGI0AjQ1OiYPGsM9jz+WMck1NwG+gqW7K49BHgUT7LcIL/rE28EwCXNB9Is5C3G
 0eYPr55Oq2yzUcD+eC0rTay2fvecf9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729191465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUdv7OgMyYMdQfNuORRlZ8D8ygnBCKHyV1/G0yrz5ew=;
 b=S6rCQpinA043DXwxr2SxjzR8a7cZ2maoUzzuWfxN8GT2/z6ORC1iu/0/xLDmqpPGUZtGyw
 fhuv5N8G8ykRqHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D280413A42;
 Thu, 17 Oct 2024 18:57:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2w8PJiheEWcZcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 18:57:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 yong.huang@smartx.com
Subject: Re: [PATCH v4 5/6] migration: Support periodic RAMBlock dirty
 bitmap sync
In-Reply-To: <f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
 <f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com>
Date: Thu, 17 Oct 2024 15:57:42 -0300
Message-ID: <87frou36c9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 549CE1FD49
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-2.80)[99.14%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> When VM is configured with huge memory, the current throttle logic
> doesn't look like to scale, because migration_trigger_throttle()
> is only called for each iteration, so it won't be invoked for a long
> time if one iteration can take a long time.
>
> The periodic dirty sync aims to fix the above issue by synchronizing
> the ramblock from remote dirty bitmap and, when necessary, triggering
> the CPU throttle multiple times during a long iteration.
>
> This is a trade-off between synchronization overhead and CPU throttle
> impact.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

