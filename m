Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE11C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udrXc-00059T-3D; Mon, 21 Jul 2025 10:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrWf-0004Bf-O0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:29:58 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrWd-00041I-I3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:29:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A21721A3D;
 Mon, 21 Jul 2025 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753108194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDz8Ux23jgexgUuOuinxOzDk+7i+aLIQk/TlGNBzkj4=;
 b=aYtcgwd2PKlEYz0FhbbPjVM7fzXk3UrmKbMn+XirefDWN3ROOUwXEvbjBwLPrxZ9Cpy12F
 Z6FQsNp7mXox8nxAHWDOJzN98iaJtXTpwd1sWLsWVO94DGtAYnf/n4fo0jcQUQrxip/KDd
 LCRqlLACCZ2m/nIjGZXasjpL2qGPH70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753108194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDz8Ux23jgexgUuOuinxOzDk+7i+aLIQk/TlGNBzkj4=;
 b=ZXn6lQimYtW1N8913yvOEhi21n5+guiMkVHdakXG50eDQgbl07DmS5y6+aZzBr4qz/+OL0
 V1aJG0HKMW6bh/Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753108194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDz8Ux23jgexgUuOuinxOzDk+7i+aLIQk/TlGNBzkj4=;
 b=aYtcgwd2PKlEYz0FhbbPjVM7fzXk3UrmKbMn+XirefDWN3ROOUwXEvbjBwLPrxZ9Cpy12F
 Z6FQsNp7mXox8nxAHWDOJzN98iaJtXTpwd1sWLsWVO94DGtAYnf/n4fo0jcQUQrxip/KDd
 LCRqlLACCZ2m/nIjGZXasjpL2qGPH70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753108194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDz8Ux23jgexgUuOuinxOzDk+7i+aLIQk/TlGNBzkj4=;
 b=ZXn6lQimYtW1N8913yvOEhi21n5+guiMkVHdakXG50eDQgbl07DmS5y6+aZzBr4qz/+OL0
 V1aJG0HKMW6bh/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97E0B13A88;
 Mon, 21 Jul 2025 14:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G89fFeFOfmg/ZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Jul 2025 14:29:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] migration: show error message when postcopy fails
In-Reply-To: <20250721133913.2914669-1-berrange@redhat.com>
References: <20250721133913.2914669-1-berrange@redhat.com>
Date: Mon, 21 Jul 2025 11:29:50 -0300
Message-ID: <87frepliqp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The 'info migrate' command only shows the error message when the
> migration state is 'failed'. When postcopy is used, however,
> the 'postcopy-paused' state is used instead of 'failed', so we
> must show the error message there too.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmd=
s.c
> index cef5608210..07fd227edc 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -153,7 +153,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
>      if (info->has_status) {
>          monitor_printf(mon, "Status: \t\t%s",
>                         MigrationStatus_str(info->status));
> -        if (info->status =3D=3D MIGRATION_STATUS_FAILED && info->error_d=
esc) {
> +        if ((info->status =3D=3D MIGRATION_STATUS_FAILED ||
> +             info->status =3D=3D MIGRATION_STATUS_POSTCOPY_PAUSED) && in=
fo->error_desc) {
>              monitor_printf(mon, " (%s)\n", info->error_desc);
>          } else {
>              monitor_printf(mon, "\n");

Reviewed-by: Fabiano Rosas <farosas@suse.de>

queued

