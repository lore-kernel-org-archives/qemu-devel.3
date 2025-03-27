Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A90C36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoVj-0001zl-JI; Thu, 27 Mar 2025 10:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoVi-0001zG-0y
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:47:10 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoVb-0006jw-04
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:47:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0D9E1F7A6;
 Thu, 27 Mar 2025 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTXrw1cSDMG5z0hcIG+tRTg8S5CKh7+x8poMtCkyZcE=;
 b=0qQ5mpmSJyheFFCiMDTf+T9wcI6cDlXuT+U9RditY+YVpaMFkL1vcU1WPhAHWo/hf3rx8i
 UWE6dQzXVfpELf8SYIZCGb+lHlWKBljOGSXbhdikQ+uJPOCACgSp46z4hHD4tEp9VZ6YmB
 t7EOJ/gwXrmPNRU6KSROOqgTmDuC7Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTXrw1cSDMG5z0hcIG+tRTg8S5CKh7+x8poMtCkyZcE=;
 b=Jn+CrQzuj4b3SyqYakmsjLoYmxpNmmdXyxF9dIli6H+aEFbhLD21H9Lr0ZED7SsIjeR0ac
 Wq+PzbjhB4YmDACg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0qQ5mpmS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jn+CrQzu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTXrw1cSDMG5z0hcIG+tRTg8S5CKh7+x8poMtCkyZcE=;
 b=0qQ5mpmSJyheFFCiMDTf+T9wcI6cDlXuT+U9RditY+YVpaMFkL1vcU1WPhAHWo/hf3rx8i
 UWE6dQzXVfpELf8SYIZCGb+lHlWKBljOGSXbhdikQ+uJPOCACgSp46z4hHD4tEp9VZ6YmB
 t7EOJ/gwXrmPNRU6KSROOqgTmDuC7Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTXrw1cSDMG5z0hcIG+tRTg8S5CKh7+x8poMtCkyZcE=;
 b=Jn+CrQzuj4b3SyqYakmsjLoYmxpNmmdXyxF9dIli6H+aEFbhLD21H9Lr0ZED7SsIjeR0ac
 Wq+PzbjhB4YmDACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 395E8139D4;
 Thu, 27 Mar 2025 14:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q8KoAONk5WeLaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:46:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>, Juraj
 Marcin <jmarcin@redhat.com>, berrange@redhat.com, Marco Cavenati
 <Marco.Cavenati@eurecom.fr>
Subject: Re: [PATCH 0/4] migration: savevm testing
In-Reply-To: <20250327143934.7935-1-farosas@suse.de>
References: <20250327143934.7935-1-farosas@suse.de>
Date: Thu, 27 Mar 2025 11:46:56 -0300
Message-ID: <87a596a5un.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C0D9E1F7A6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Fabiano Rosas <farosas@suse.de> writes:

> Hi, we had a bug report that enabling multifd and attempting
> savevm/loadvm crashes QEMU. This seems to have been around for many
> years.
>
> I'm adding a fix for this in the form of a capabilities check for
> snapshots.
>
> I'm also adding a couple of tests that validate migration capabilities
> are properly rejected by savevm.
>
> There is a larger discussion to be had which is whether we want to
> attempt to implement every migration capability for snapshots or
> should we try to convert snapshots into a regular migration or some
> third option. For now I'm trying to avoid this by not touching
> capabilities that don't cause a crash, but let me know your thoughts.

Turns out, there's a patch that just arrived on the mailing list adding
mapped-ram support for savevm/loadvm, so I guess we'll have this
discussion now =)

migration: add FEATURE_SEEKABLE to QIOChannelBlock
https://lore.kernel.org/r/20250327141451.163744-3-Marco.Cavenati@eurecom.fr

>
> Thanks
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1738368896
>
> Fabiano Rosas (4):
>   migration/savevm: Add a compatibility check for capabilities
>   tests/qtest/migration: Extract machine type resolution
>   tests/qtest/migration: Add QMP helpers for snapshot
>   tests/qtest/migration: Add savevm tests
>
>  migration/options.c                   |  26 +++++
>  migration/options.h                   |   1 +
>  migration/savevm.c                    |   8 ++
>  tests/qtest/meson.build               |   1 +
>  tests/qtest/migration-test.c          |   1 +
>  tests/qtest/migration/framework.c     |  54 ++++++----
>  tests/qtest/migration/framework.h     |   5 +
>  tests/qtest/migration/migration-qmp.c | 120 +++++++++++++++++++++
>  tests/qtest/migration/migration-qmp.h |   4 +
>  tests/qtest/migration/savevm-tests.c  | 144 ++++++++++++++++++++++++++
>  10 files changed, 345 insertions(+), 19 deletions(-)
>  create mode 100644 tests/qtest/migration/savevm-tests.c

