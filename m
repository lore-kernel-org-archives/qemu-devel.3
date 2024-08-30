Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD46CA1009
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 18:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk6mu-0004hQ-1X; Fri, 30 Aug 2024 14:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk6mt-0004gu-1k
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:55:59 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk6mp-0002yM-3R
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:55:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A67521A2C;
 Fri, 30 Aug 2024 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725044149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLoKDm1eQknHH3kfWUTv2F+R1jCF8HBXWzRBEKeYRZ4=;
 b=Owp0Tr7ojbkVMSIzS8A7IvWYhj3wTgXMrDnGcYE9Uqn6B4SMkTJn2eQ+Qpk7Nf6acT+t4j
 nvuBIzcI2Rc9T2Gwtj/i1U1h0zbaZ4YSaxV1j28FkrvV0E+a+mSWxvxHHpZLWnYQWJNRvx
 bzBJ/1LqJicA4m51zvvGT7wdy8Zir+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725044149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLoKDm1eQknHH3kfWUTv2F+R1jCF8HBXWzRBEKeYRZ4=;
 b=lXMs1Any4PBg1V3IOdejyII9JQmKVjXE6B+YSLg699nLSx5xta68JnEuv4mpbyu/a0eRsN
 4ZDK/4jWaRguucDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725044149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLoKDm1eQknHH3kfWUTv2F+R1jCF8HBXWzRBEKeYRZ4=;
 b=Owp0Tr7ojbkVMSIzS8A7IvWYhj3wTgXMrDnGcYE9Uqn6B4SMkTJn2eQ+Qpk7Nf6acT+t4j
 nvuBIzcI2Rc9T2Gwtj/i1U1h0zbaZ4YSaxV1j28FkrvV0E+a+mSWxvxHHpZLWnYQWJNRvx
 bzBJ/1LqJicA4m51zvvGT7wdy8Zir+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725044149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLoKDm1eQknHH3kfWUTv2F+R1jCF8HBXWzRBEKeYRZ4=;
 b=lXMs1Any4PBg1V3IOdejyII9JQmKVjXE6B+YSLg699nLSx5xta68JnEuv4mpbyu/a0eRsN
 4ZDK/4jWaRguucDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E7EF139D3;
 Fri, 30 Aug 2024 18:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FI4yGbQV0mZTNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 30 Aug 2024 18:55:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 13/17] migration/multifd: Add
 migration_has_device_state_support()
In-Reply-To: <8407eb455dfc1dea3cabf065f90833fab337eb98.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <8407eb455dfc1dea3cabf065f90833fab337eb98.1724701542.git.maciej.szmigiero@oracle.com>
Date: Fri, 30 Aug 2024 15:55:46 -0300
Message-ID: <8734mlon65.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Since device state transfer via multifd channels requires multifd
> channels with packets and is currently not compatible with multifd
> compression add an appropriate query function so device can learn
> whether it can actually make use of it.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

Out of curiosity, what do you see as a blocker for migrating to a file?

We would just need to figure out a mapping from file offset some unit of
data to be able to write in parallel like with ram (of which the page
offset is mapped to the file offset).

> ---
>  include/migration/misc.h         | 1 +
>  migration/multifd-device-state.c | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 7266b1b77d1f..189de6d02ad6 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -114,5 +114,6 @@ void dirty_bitmap_mig_init(void);
>  /* migration/multifd-device-state.c */
>  bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>                                  char *data, size_t len);
> +bool migration_has_device_state_support(void);
>  
>  #endif
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> index c9b44f0b5ab9..7b34fe736c7f 100644
> --- a/migration/multifd-device-state.c
> +++ b/migration/multifd-device-state.c
> @@ -11,6 +11,7 @@
>  #include "qemu/lockable.h"
>  #include "migration/misc.h"
>  #include "multifd.h"
> +#include "options.h"
>  
>  static QemuMutex queue_job_mutex;
>  
> @@ -97,3 +98,9 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
>  
>      return true;
>  }
> +
> +bool migration_has_device_state_support(void)
> +{
> +    return migrate_multifd() && !migrate_mapped_ram() &&
> +        migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
> +}

