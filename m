Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2849C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 20:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s05bM-0007R5-FA; Thu, 25 Apr 2024 16:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s05bJ-0007Qf-P2
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 16:21:49 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s05bH-00083V-4C
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 16:21:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 508EA5C5F9;
 Thu, 25 Apr 2024 20:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714076505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUxyP8gradFuLqSkI7B17QucCnuGEFX2pX/yfE2aWdc=;
 b=buRHbG34UMhOcL9tZ/14ltNN4xhLoPLZbXpPCCoeoNXEx7VVEaIqd5U26+6IwrROMH9NOk
 ovZ/H3IxATED9UkXwgpPmp8frSDtdPVSGWz15T9q1OmDZ2igUzBVXG5zLmxzhcHk3wny7q
 4zqlKBHYFa+7Z3RTH1WBXhYxBSjbb7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714076505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUxyP8gradFuLqSkI7B17QucCnuGEFX2pX/yfE2aWdc=;
 b=/Zfpjo+es/Cn+ACyrHFe0yix/2XBZHNMD97z0PHmhFGBWC3yCUKtijuVL/vci2IaOYLoko
 CqaEnV+cR30w1aAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714076505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUxyP8gradFuLqSkI7B17QucCnuGEFX2pX/yfE2aWdc=;
 b=buRHbG34UMhOcL9tZ/14ltNN4xhLoPLZbXpPCCoeoNXEx7VVEaIqd5U26+6IwrROMH9NOk
 ovZ/H3IxATED9UkXwgpPmp8frSDtdPVSGWz15T9q1OmDZ2igUzBVXG5zLmxzhcHk3wny7q
 4zqlKBHYFa+7Z3RTH1WBXhYxBSjbb7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714076505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUxyP8gradFuLqSkI7B17QucCnuGEFX2pX/yfE2aWdc=;
 b=/Zfpjo+es/Cn+ACyrHFe0yix/2XBZHNMD97z0PHmhFGBWC3yCUKtijuVL/vci2IaOYLoko
 CqaEnV+cR30w1aAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D04BF13991;
 Thu, 25 Apr 2024 20:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QQRyJVi7KmanXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 20:21:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: Re: [PATCH v3 3/4] migration: process_incoming_migration_co():
 rework error reporting
In-Reply-To: <20240425181551.1465739-4-vsementsov@yandex-team.ru>
References: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
 <20240425181551.1465739-4-vsementsov@yandex-team.ru>
Date: Thu, 25 Apr 2024 17:21:42 -0300
Message-ID: <87ttjpgpm1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.27 / 50.00]; BAYES_HAM(-2.97)[99.88%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Unify error reporting in the function. This simplifies the following
> commit, which will not-exit-on-error behavior variant to the function.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

