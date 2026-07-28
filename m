Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A9CC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonpn-0003ww-TK; Tue, 28 Jul 2026 15:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonpm-0003vC-5w
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:51:26 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonpk-0007PE-KX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:51:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3B603E09;
 Tue, 28 Jul 2026 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785268278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrIkapmc3185hD+cX8AuCOj77twXsIixL/SHinxq9Z8=;
 b=U5lOFksukeIzqmFRO1mqAR7J1fLaXNyuCSTg6rhpHzfZHJLKBVBjelyZxD3RnHFp5IOLR1
 dBPYOulfDz2zm4RI4fXuWMIR6Pa3nDx5BbEsesDWD2d5RAjgFypbO4MTNbVlh4uJtsxGNd
 T0pB5eVPLge0XWcm7A57gXKBqSJwC4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785268278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrIkapmc3185hD+cX8AuCOj77twXsIixL/SHinxq9Z8=;
 b=a4XYzC7SQmME07B2yH5QWq/IMAj/wbEzQilzVmDfa8rUfH+WUGTy82qW3UPSsFm6kNXiZT
 uiCRHFafoL0+G5Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QUbUu2yF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zuk64LEK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785268274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrIkapmc3185hD+cX8AuCOj77twXsIixL/SHinxq9Z8=;
 b=QUbUu2yFLI+puuGfg0KIlm9w+zLVQ0Hfjtgh6kGxCvzE7D8JLgsDPjhdHYmdxApBofzJ16
 bylmEuraPuHzf3X7lA3rbNHMseH6vll5Pm0VymHTUT2PMN1d3rjDOuZyctRc+TgcmYOgK0
 kAqHzv2na9W70QvDrAWZXr6sOtZwfq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785268274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OrIkapmc3185hD+cX8AuCOj77twXsIixL/SHinxq9Z8=;
 b=zuk64LEKphfHObnj0mUET3O0xzJd6gRcixGnGq7k2afiuN+rzcqFFUoEE0qT97LwL0S9ar
 ci96CW68VijduICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51C77779B1;
 Tue, 28 Jul 2026 19:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id og3sCDIIaWq7SQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 19:51:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, qemu-stable
 <qemu-stable@nongnu.org>, Yuan Liu <yuan1.liu@intel.com>, Yichen Wang
 <yichen.wang@bytedance.com>
Subject: Re: [PATCH 3/5] migration/multifd: Replace assert() with
 error_setg() in recv paths
In-Reply-To: <20260728155247.1894355-4-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-4-peterx@redhat.com>
Date: Tue, 28 Jul 2026 16:51:07 -0300
Message-ID: <87tspiopuc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,bytedance.com:email,intel.com:email,nongnu.org:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B3B603E09
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

Peter Xu <peterx@redhat.com> writes:

> QPL and UADK multifd backends use assert() to validate wire-controlled
> fields like per-page compressed lengths and packet size consistency.  These
> asserts will stop working with released version of binaries, so may stop
> working.

This is not true, asserts are always on. Same for the similar comment in
the previous patch commit message.

>
> Replace all assert() calls in the receive path with proper error_setg() so
> validation failures are reported gracefully rather than crashing or
> silently ignored.
>
> While at it, touch up an assert() in qatzip recv path too.
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Yuan Liu <yuan1.liu@intel.com>
> Cc: Yichen Wang <yichen.wang@bytedance.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

