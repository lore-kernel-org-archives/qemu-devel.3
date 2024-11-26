Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A1CD65525
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2gh-0006Dg-05; Tue, 26 Nov 2024 16:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG2gS-0006Ck-97
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:01:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG2gQ-0005bK-Ql
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:01:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB17921170;
 Tue, 26 Nov 2024 21:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732654876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vqeVgQbRJEt+ywp1iMl34OTrYkq50gUeCAQJxqvw0E4=;
 b=uKD61Fea4g/GjH6Q9xih7YyfkdM491r1W7hPAFl4sxbnas73amPs8pcW6XuTtmTj5LNWW3
 zaE/qrbRl+jGhKIpyjW0DH3pA8rVQJOCMP1pxeMVPkbGYS8aCTqDTZ4EE1jy+H07IGj12s
 hB53xpbI4HknAYV33x5+QUfxO1m9kgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732654876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vqeVgQbRJEt+ywp1iMl34OTrYkq50gUeCAQJxqvw0E4=;
 b=/hOjf5RUOsUE+40UhuW24IRGBZUDpp8hXnGecWPRy67JcddpXT3EA7XaMv4SmrKZZvs6rE
 80IOLzJh/nUDQfAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732654876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vqeVgQbRJEt+ywp1iMl34OTrYkq50gUeCAQJxqvw0E4=;
 b=uKD61Fea4g/GjH6Q9xih7YyfkdM491r1W7hPAFl4sxbnas73amPs8pcW6XuTtmTj5LNWW3
 zaE/qrbRl+jGhKIpyjW0DH3pA8rVQJOCMP1pxeMVPkbGYS8aCTqDTZ4EE1jy+H07IGj12s
 hB53xpbI4HknAYV33x5+QUfxO1m9kgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732654876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vqeVgQbRJEt+ywp1iMl34OTrYkq50gUeCAQJxqvw0E4=;
 b=/hOjf5RUOsUE+40UhuW24IRGBZUDpp8hXnGecWPRy67JcddpXT3EA7XaMv4SmrKZZvs6rE
 80IOLzJh/nUDQfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F26B13890;
 Tue, 26 Nov 2024 21:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0kH8OBs3RmdXcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 26 Nov 2024 21:01:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 23/24] migration/qemu-file: Define g_autoptr()
 cleanup function for QEMUFile
In-Reply-To: <952bafd5a7312f04bc7f05068a1fdd4c64be433f.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <952bafd5a7312f04bc7f05068a1fdd4c64be433f.1731773021.git.maciej.szmigiero@oracle.com>
Date: Tue, 26 Nov 2024 18:01:13 -0300
Message-ID: <87jzcpn206.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.34 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 BAYES_HAM(-0.04)[59.02%]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Automatic memory management helps avoid memory safety issues.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  migration/qemu-file.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 11c2120edd72..fdf21324df07 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -33,6 +33,8 @@ QEMUFile *qemu_file_new_input(QIOChannel *ioc);
>  QEMUFile *qemu_file_new_output(QIOChannel *ioc);
>  int qemu_fclose(QEMUFile *f);
>  
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QEMUFile, qemu_fclose)
> +
>  /*
>   * qemu_file_transferred:
>   *

Reviewed-by: Fabiano Rosas <farosas@suse.de>

