Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA0AC3DA62
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 18:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU9Yv-00038s-5K; Wed, 17 Jul 2024 14:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU9Yu-00038O-Cm
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:39:36 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU9Ys-0003B9-KZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:39:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5845921A77;
 Wed, 17 Jul 2024 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721241573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7fJQXeToqjFz8yCd9Lvcj3zs1EICaJgUO/2Q+sMPnSk=;
 b=hx4clKv5yI9EEk5uTuVe/RjwqkgDlqdUCFEwUONGTdmSQwzsybKvLRWu4lKvlf2K35BNVH
 nNcGyfym/MoI+By0LyxnPNnMaeHxhGavY/eZJsmXM8r2RGV3r9+KApmRrPCIebcIoIkRMw
 7osM1B0dYSEke0joH7YYWc92mWD36xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721241573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7fJQXeToqjFz8yCd9Lvcj3zs1EICaJgUO/2Q+sMPnSk=;
 b=e/LQYr0guZUY8yK/Eots/wbMmfT5r1YfZ1fsp8k4HeF8sV2I4I9vNsjdivl4yMiC7A9K4U
 nLuxt8yJr1Kx+sAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721241573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7fJQXeToqjFz8yCd9Lvcj3zs1EICaJgUO/2Q+sMPnSk=;
 b=hx4clKv5yI9EEk5uTuVe/RjwqkgDlqdUCFEwUONGTdmSQwzsybKvLRWu4lKvlf2K35BNVH
 nNcGyfym/MoI+By0LyxnPNnMaeHxhGavY/eZJsmXM8r2RGV3r9+KApmRrPCIebcIoIkRMw
 7osM1B0dYSEke0joH7YYWc92mWD36xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721241573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7fJQXeToqjFz8yCd9Lvcj3zs1EICaJgUO/2Q+sMPnSk=;
 b=e/LQYr0guZUY8yK/Eots/wbMmfT5r1YfZ1fsp8k4HeF8sV2I4I9vNsjdivl4yMiC7A9K4U
 nLuxt8yJr1Kx+sAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C481368F;
 Wed, 17 Jul 2024 18:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P5GGJuQPmGbSTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 18:39:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 03/11] migration: save cpr mode
In-Reply-To: <1719776434-435013-4-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-4-git-send-email-steven.sistare@oracle.com>
Date: Wed, 17 Jul 2024 15:39:30 -0300
Message-ID: <87v813278d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Save the mode in CPR state, so the user does not need to explicitly specify
> it for the target.  Modify migrate_mode() so it returns the incoming mode on
> the target.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/cpr.h |  7 +++++++
>  migration/cpr.c         | 23 ++++++++++++++++++++++-
>  migration/migration.c   |  1 +
>  migration/options.c     |  9 +++++++--
>  4 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 8e7e705..42b4019 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -8,6 +8,13 @@
>  #ifndef MIGRATION_CPR_H
>  #define MIGRATION_CPR_H
>  
> +#include "qapi/qapi-types-migration.h"
> +
> +#define MIG_MODE_NONE MIG_MODE__MAX

What happens when a QEMU that knows about a new mode migrates into a
QEMU that doesn't know that mode, i.e. sees it as MIG_MODE__MAX?

I'd just use -1.

> +
> +MigMode cpr_get_incoming_mode(void);
> +void cpr_set_incoming_mode(MigMode mode);
> +
>  typedef int (*cpr_walk_fd_cb)(int fd);
>  void cpr_save_fd(const char *name, int id, int fd);
>  void cpr_delete_fd(const char *name, int id);
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 313e74e..1c296c6 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -21,10 +21,23 @@
>  typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>  
>  typedef struct CprState {
> +    MigMode mode;
>      CprFdList fds;
>  } CprState;
>  
> -static CprState cpr_state;
> +static CprState cpr_state = {
> +    .mode = MIG_MODE_NONE,
> +};
> +
> +MigMode cpr_get_incoming_mode(void)
> +{
> +    return cpr_state.mode;
> +}
> +
> +void cpr_set_incoming_mode(MigMode mode)
> +{
> +    cpr_state.mode = mode;
> +}
>  
>  /****************************************************************************/
>  
> @@ -124,11 +137,19 @@ void cpr_resave_fd(const char *name, int id, int fd)
>  /*************************************************************************/
>  #define CPR_STATE "CprState"
>  
> +static int cpr_state_presave(void *opaque)
> +{
> +    cpr_state.mode = migrate_mode();
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_cpr_state = {
>      .name = CPR_STATE,
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_save = cpr_state_presave,
>      .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(mode, CprState),
>          VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index e394ad7..0f47765 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -411,6 +411,7 @@ void migration_incoming_state_destroy(void)
>          mis->postcopy_qemufile_dst = NULL;
>      }
>  
> +    cpr_set_incoming_mode(MIG_MODE_NONE);
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
>  
> diff --git a/migration/options.c b/migration/options.c
> index 645f550..305397a 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -22,6 +22,7 @@
>  #include "qapi/qmp/qnull.h"
>  #include "sysemu/runstate.h"
>  #include "migration/colo.h"
> +#include "migration/cpr.h"
>  #include "migration/misc.h"
>  #include "migration.h"
>  #include "migration-stats.h"
> @@ -758,8 +759,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
>  
>  MigMode migrate_mode(void)
>  {
> -    MigrationState *s = migrate_get_current();
> -    MigMode mode = s->parameters.mode;
> +    MigMode mode = cpr_get_incoming_mode();
> +
> +    if (mode == MIG_MODE_NONE) {
> +        MigrationState *s = migrate_get_current();
> +        mode = s->parameters.mode;
> +    }
>  
>      assert(mode >= 0 && mode < MIG_MODE__MAX);
>      return mode;

