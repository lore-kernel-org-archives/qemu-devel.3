Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC62BC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 18:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2wuK-0004ro-3Y; Thu, 10 Apr 2025 14:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u2wuH-0004rW-0z
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:45:45 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u2wuF-0006aj-7x
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 14:45:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76FB521168;
 Thu, 10 Apr 2025 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744310740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=se5ERugMkInhAOjcSg8z0e8sE7njd/B/oEM3txb127c=;
 b=WeuOFyu0RxVUmBB5sURc54jHBLqMlJ1fLKW1At8dg9zTIwJlxlo4tL4rirUo+V8u6uFmCE
 AkV2TQl5DTXR2ca7x7U92d6YZq2A1V1v9+hbsOC6SnrkiIPCDiNEyUpW/NG2gia16G5uto
 I2A1wBgjGpNPbkgc4+1sMF1dx6iGNtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744310740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=se5ERugMkInhAOjcSg8z0e8sE7njd/B/oEM3txb127c=;
 b=yzzSsj3YROSobXTHeLO7oAteS2FmuDwCa5Pje4/iVJFhlbG0x3d30psazTyGFIJ3oEJoR2
 LKSOyQ6eZVnPTMBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WeuOFyu0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yzzSsj3Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744310740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=se5ERugMkInhAOjcSg8z0e8sE7njd/B/oEM3txb127c=;
 b=WeuOFyu0RxVUmBB5sURc54jHBLqMlJ1fLKW1At8dg9zTIwJlxlo4tL4rirUo+V8u6uFmCE
 AkV2TQl5DTXR2ca7x7U92d6YZq2A1V1v9+hbsOC6SnrkiIPCDiNEyUpW/NG2gia16G5uto
 I2A1wBgjGpNPbkgc4+1sMF1dx6iGNtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744310740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=se5ERugMkInhAOjcSg8z0e8sE7njd/B/oEM3txb127c=;
 b=yzzSsj3YROSobXTHeLO7oAteS2FmuDwCa5Pje4/iVJFhlbG0x3d30psazTyGFIJ3oEJoR2
 LKSOyQ6eZVnPTMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7D9F13886;
 Thu, 10 Apr 2025 18:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gInSJNMR+Gc5SgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Apr 2025 18:45:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, lvivier@redhat.com,
 vsementsov@yandex-team.ru, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] [for-10.1] qtest: introduce qtest_init_ext
In-Reply-To: <20250410162250.329941-1-vsementsov@yandex-team.ru>
References: <20250410162250.329941-1-vsementsov@yandex-team.ru>
Date: Thu, 10 Apr 2025 15:45:36 -0300
Message-ID: <87mscnhn3j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 76FB521168
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Merge qtest_init_with_env_and_capabilities() and qtest_init_with_env()
> into one qtest_init_ext().
>
> Reasons:
>
> 1. qtest_init_with_env() is just wrong: it gets do_connect parameter
>    but always pass true to qtest_init_with_env_and_capabilities().
>    Happily, all qtest_init_with_env() callers pass true as well.
>
> 2. qtest_init_with_env() is not used outside of libqtest.c, so no
>    reason to keep it as public function
>
> 3. and in libqtest.c it's used not often, so no problem to use
>    more generic function instead.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks, it was my mistake fixing a conflict during merge.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

