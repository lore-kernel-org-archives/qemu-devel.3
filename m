Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4558EC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDd0-0004Hd-0B; Thu, 07 Mar 2024 08:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riDcw-0004FR-9a
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:17:38 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riDcu-0003vb-OV
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:17:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7504376C07;
 Thu,  7 Mar 2024 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709815523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Xdv23Oqut3UL2nLwFj4ADKnLgmQBMGuDN1e+n35Jgw=;
 b=vg7Eb/9tLfol2xy0kxwMWPA6FSmpTncmQR7of69773VxKYH10QRYlzfV978IuT4i3PYL7P
 CXaR6zf3UxsYMk1fDa+QAbDYr5kxgkkcng9oiw5ezhg4EJselg4kDr0AU/EIuDoru65ozF
 Mdl3f7N38RnkmPYNOA5dyokCQvDgOOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709815523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Xdv23Oqut3UL2nLwFj4ADKnLgmQBMGuDN1e+n35Jgw=;
 b=5/YDFMFcorrxNwvVjq38nTe1r+0bZQ91d96znmqlVbWCP9h2Vz1WAJqayuXtF0rz5j9Lgt
 lrQU3cewrofakPDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709815523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Xdv23Oqut3UL2nLwFj4ADKnLgmQBMGuDN1e+n35Jgw=;
 b=vg7Eb/9tLfol2xy0kxwMWPA6FSmpTncmQR7of69773VxKYH10QRYlzfV978IuT4i3PYL7P
 CXaR6zf3UxsYMk1fDa+QAbDYr5kxgkkcng9oiw5ezhg4EJselg4kDr0AU/EIuDoru65ozF
 Mdl3f7N38RnkmPYNOA5dyokCQvDgOOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709815523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Xdv23Oqut3UL2nLwFj4ADKnLgmQBMGuDN1e+n35Jgw=;
 b=5/YDFMFcorrxNwvVjq38nTe1r+0bZQ91d96znmqlVbWCP9h2Vz1WAJqayuXtF0rz5j9Lgt
 lrQU3cewrofakPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F295D136BA;
 Thu,  7 Mar 2024 12:45:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sGs6LeK26WUMSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 Mar 2024 12:45:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus Armbruster
 <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
In-Reply-To: <20240306133441.2351700-11-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com>
Date: Thu, 07 Mar 2024 09:45:20 -0300
Message-ID: <87h6hiqkgv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vg7Eb/9t";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5/YDFMFc"
X-Spamd-Result: default: False [-6.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.99)[99.95%];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 7504376C07
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> This prepares ground for the changes coming next which add an Error**
> argument to the .save_setup() handler. Callers of qemu_savevm_state_setup=
()
> now handle the error and fail earlier setting the migration state from
> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>
> In qemu_savevm_state(), move the cleanup to preserve the error
> reported by .save_setup() handlers.
>
> Since the previous behavior was to ignore errors at this step of
> migration, this change should be examined closely to check that
> cleanups are still correctly done.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

