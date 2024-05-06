Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC921C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 23:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s47aM-0002cO-AY; Mon, 06 May 2024 19:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s47aE-0002bK-9P
 for qemu-devel@nongnu.org; Mon, 06 May 2024 19:17:23 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s47aB-0002fz-Rh
 for qemu-devel@nongnu.org; Mon, 06 May 2024 19:17:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 891BD22A0A;
 Mon,  6 May 2024 23:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715037437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OLV1/is1LVGnIw5bRFMN+BoKXmc2dX4gO+1BX9xTZI=;
 b=dN6C8mJb3JpBsv/IKCsoOGFgse61+/sdtFdhqeJwn/XXSO6PEOtrecd5CaVox9TKhYT4IR
 pLik1x696P5p27mL0GWJDQqIXReO2hE4zDx2gX5+UptNf+3nmoSio/fIYVRzWgVZmAhMET
 Xc1ls2CItvTVoLXOU3EkHLILYm+dBmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715037437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OLV1/is1LVGnIw5bRFMN+BoKXmc2dX4gO+1BX9xTZI=;
 b=Eu1M4JNJkF6ckoHKzFbxRRrvx8HaYMNTsRZ9Ez8jcSUJYK05Vrw3pqhoueiKMBLyUcKGyE
 /N0HzDzz5RT3+FAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715037437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OLV1/is1LVGnIw5bRFMN+BoKXmc2dX4gO+1BX9xTZI=;
 b=dN6C8mJb3JpBsv/IKCsoOGFgse61+/sdtFdhqeJwn/XXSO6PEOtrecd5CaVox9TKhYT4IR
 pLik1x696P5p27mL0GWJDQqIXReO2hE4zDx2gX5+UptNf+3nmoSio/fIYVRzWgVZmAhMET
 Xc1ls2CItvTVoLXOU3EkHLILYm+dBmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715037437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OLV1/is1LVGnIw5bRFMN+BoKXmc2dX4gO+1BX9xTZI=;
 b=Eu1M4JNJkF6ckoHKzFbxRRrvx8HaYMNTsRZ9Ez8jcSUJYK05Vrw3pqhoueiKMBLyUcKGyE
 /N0HzDzz5RT3+FAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0874E1386E;
 Mon,  6 May 2024 23:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2ZdeMPxkOWYZFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 06 May 2024 23:17:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 03/26] migration: SAVEVM_FOREACH
In-Reply-To: <1714406135-451286-4-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-4-git-send-email-steven.sistare@oracle.com>
Date: Mon, 06 May 2024 20:17:14 -0300
Message-ID: <878r0mmsxx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
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

> Define an abstraction SAVEVM_FOREACH to loop over all savevm state
> handlers, and replace QTAILQ_FOREACH.  Define variants for ALL so
> we can loop over all handlers vs a subset of handlers in a subsequent
> patch, but at this time there is no distinction between the two.
> No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/savevm.c | 55 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4509482..6829ba3 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -237,6 +237,15 @@ static SaveState savevm_state = {
>      .global_section_id = 0,
>  };
>  
> +#define SAVEVM_FOREACH(se, entry)                                    \
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
> +
> +#define SAVEVM_FOREACH_ALL(se, entry)                                \
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)

This feels worse than SAVEVM_FOREACH_NOT_PRECREATED. We'll have to keep
coming back to the definition to figure out which FOREACH is the real
deal.

> +
> +#define SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se)                   \
> +    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se)
> +
>  static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id);
>  
>  static bool should_validate_capability(int capability)
> @@ -674,7 +683,7 @@ static uint32_t calculate_new_instance_id(const char *idstr)
>      SaveStateEntry *se;
>      uint32_t instance_id = 0;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH_ALL(se, entry) {

In this patch we can't have both instances...

>          if (strcmp(idstr, se->idstr) == 0
>              && instance_id <= se->instance_id) {
>              instance_id = se->instance_id + 1;
> @@ -690,7 +699,7 @@ static int calculate_compat_instance_id(const char *idstr)
>      SaveStateEntry *se;
>      int instance_id = 0;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {

...otherwise one of the two changes will go undocumented because the
actual reason for it will only be described in the next patch.

>          if (!se->compat) {
>              continue;
>          }
> @@ -816,7 +825,7 @@ void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque)
>      }
>      pstrcat(id, sizeof(id), idstr);
>  
> -    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
> +    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
>          if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
>              savevm_state_handler_remove(se);
>              g_free(se->compat);
> @@ -939,7 +948,7 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
>  {
>      SaveStateEntry *se, *new_se;
>  
> -    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
> +    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
>          if (se->vmsd == vmsd && se->opaque == opaque) {
>              savevm_state_handler_remove(se);
>              g_free(se->compat);
> @@ -1223,7 +1232,7 @@ bool qemu_savevm_state_blocked(Error **errp)
>  {
>      SaveStateEntry *se;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->vmsd && se->vmsd->unmigratable) {
>              error_setg(errp, "State blocked by non-migratable device '%s'",
>                         se->idstr);
> @@ -1237,7 +1246,7 @@ void qemu_savevm_non_migratable_list(strList **reasons)
>  {
>      SaveStateEntry *se;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->vmsd && se->vmsd->unmigratable) {
>              QAPI_LIST_PREPEND(*reasons,
>                                g_strdup_printf("non-migratable device: %s",
> @@ -1276,7 +1285,7 @@ bool qemu_savevm_state_guest_unplug_pending(void)
>  {
>      SaveStateEntry *se;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->vmsd && se->vmsd->dev_unplug_pending &&
>              se->vmsd->dev_unplug_pending(se->opaque)) {
>              return true;
> @@ -1291,7 +1300,7 @@ int qemu_savevm_state_prepare(Error **errp)
>      SaveStateEntry *se;
>      int ret;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->save_prepare) {
>              continue;
>          }
> @@ -1321,7 +1330,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>      json_writer_start_array(ms->vmdesc, "devices");
>  
>      trace_savevm_state_setup();
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->vmsd && se->vmsd->early_setup) {
>              ret = vmstate_save(f, se, ms->vmdesc, errp);
>              if (ret) {
> @@ -1365,7 +1374,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>  
>      trace_savevm_state_resume_prepare();
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->resume_prepare) {
>              continue;
>          }
> @@ -1396,7 +1405,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>      int ret;
>  
>      trace_savevm_state_iterate();
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->save_live_iterate) {
>              continue;
>          }
> @@ -1461,7 +1470,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>      SaveStateEntry *se;
>      int ret;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->save_live_complete_postcopy) {
>              continue;
>          }
> @@ -1495,7 +1504,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>      SaveStateEntry *se;
>      int ret;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops ||
>              (in_postcopy && se->ops->has_postcopy &&
>               se->ops->has_postcopy(se->opaque)) ||
> @@ -1543,7 +1552,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>      Error *local_err = NULL;
>      int ret;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->vmsd && se->vmsd->early_setup) {
>              /* Already saved during qemu_savevm_state_setup(). */
>              continue;
> @@ -1649,7 +1658,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>      *must_precopy = 0;
>      *can_postcopy = 0;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->state_pending_estimate) {
>              continue;
>          }
> @@ -1670,7 +1679,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>      *must_precopy = 0;
>      *can_postcopy = 0;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->state_pending_exact) {
>              continue;
>          }
> @@ -1693,7 +1702,7 @@ void qemu_savevm_state_cleanup(void)
>      }
>  
>      trace_savevm_state_cleanup();
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->ops && se->ops->save_cleanup) {
>              se->ops->save_cleanup(se->opaque);
>          }
> @@ -1778,7 +1787,7 @@ int qemu_save_device_state(QEMUFile *f)
>      }
>      cpu_synchronize_all_states();
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          int ret;
>  
>          if (se->is_ram) {
> @@ -1801,7 +1810,7 @@ static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
>  {
>      SaveStateEntry *se;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH_ALL(se, entry) {
>          if (!strcmp(se->idstr, idstr) &&
>              (instance_id == se->instance_id ||
>               instance_id == se->alias_id))
> @@ -2680,7 +2689,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
>      }
>  
>      trace_qemu_loadvm_state_section_partend(section_id);
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->load_section_id == section_id) {
>              break;
>          }
> @@ -2755,7 +2764,7 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
>  {
>      SaveStateEntry *se;
>  
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->switchover_ack_needed) {
>              continue;
>          }
> @@ -2775,7 +2784,7 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>      int ret;
>  
>      trace_loadvm_state_setup();
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (!se->ops || !se->ops->load_setup) {
>              continue;
>          }
> @@ -2801,7 +2810,7 @@ void qemu_loadvm_state_cleanup(void)
>      SaveStateEntry *se;
>  
>      trace_loadvm_state_cleanup();
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +    SAVEVM_FOREACH(se, entry) {
>          if (se->ops && se->ops->load_cleanup) {
>              se->ops->load_cleanup(se->opaque);
>          }

