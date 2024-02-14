Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEECC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 18:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raKOk-0001Ad-3B; Wed, 14 Feb 2024 13:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raKOh-0001AH-Lh
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:54:20 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1raKOg-0003ZO-5c
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:54:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E9FF22107;
 Wed, 14 Feb 2024 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707936855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JdVB7VaUAbAUP5FQUHlzy/3vRCifwGSDkVDKpCAJt8=;
 b=ma+wBax3ibzouSrTJqC4uGmJMF9bK0rUB+CZ/kyXe9hPApFg4j/wyAvUOVV0/Pc0oeAh6b
 k3JE7OBvaQwmcxxbyNs2xATarN+Sw8KU7fwx88Uv14dVGUY1LvAHZiRXOCNgYKJj4X4U/o
 lWoW+0JVizSDtXyxrSXJ/i49eb3Zq7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707936855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JdVB7VaUAbAUP5FQUHlzy/3vRCifwGSDkVDKpCAJt8=;
 b=oL3X+gjcQq3uAJkmI+7+LduF7pCZY/HHj3mm26nwVdcN+0F6YwybRHdSaGK+G0pfTvMWJY
 i2jySadJjmcz+eBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707936855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JdVB7VaUAbAUP5FQUHlzy/3vRCifwGSDkVDKpCAJt8=;
 b=ma+wBax3ibzouSrTJqC4uGmJMF9bK0rUB+CZ/kyXe9hPApFg4j/wyAvUOVV0/Pc0oeAh6b
 k3JE7OBvaQwmcxxbyNs2xATarN+Sw8KU7fwx88Uv14dVGUY1LvAHZiRXOCNgYKJj4X4U/o
 lWoW+0JVizSDtXyxrSXJ/i49eb3Zq7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707936855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JdVB7VaUAbAUP5FQUHlzy/3vRCifwGSDkVDKpCAJt8=;
 b=oL3X+gjcQq3uAJkmI+7+LduF7pCZY/HHj3mm26nwVdcN+0F6YwybRHdSaGK+G0pfTvMWJY
 i2jySadJjmcz+eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFAB313A72;
 Wed, 14 Feb 2024 18:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K4zpLFYMzWXEWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Feb 2024 18:54:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH] ci: Fix again build-previous-qemu
In-Reply-To: <20240213154901.109780-1-pbonzini@redhat.com>
References: <20240213154901.109780-1-pbonzini@redhat.com>
Date: Wed, 14 Feb 2024 15:54:12 -0300
Message-ID: <87plwyq3l7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ma+wBax3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oL3X+gjc
X-Spamd-Result: default: False [-4.38 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-2.07)[95.44%]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6E9FF22107
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> The build-previous-qemu job is now trying to fetch from the upstream
> repository, but the tag is only fetched into FETCH_HEAD:
>
> $ git remote add upstream https://gitlab.com/qemu-project/qemu 00:00
> $ git fetch upstream $QEMU_PREV_VERSION 00:02
> warning: redirecting to https://gitlab.com/qemu-project/qemu.git/
> From https://gitlab.com/qemu-project/qemu
>  * tag                     v8.2.0     -> FETCH_HEAD
> $ git checkout $QEMU_PREV_VERSION 00:02
> error: pathspec v8.2.0 did not match any file(s) known to git
>
> Fix by fetching the tag into the checkout itself.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

