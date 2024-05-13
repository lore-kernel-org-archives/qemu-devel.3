Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED76C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 21:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6dgY-0006qu-Ks; Mon, 13 May 2024 17:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6dgW-0006qb-Rg
 for qemu-devel@nongnu.org; Mon, 13 May 2024 17:58:16 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6dgI-0005vN-JZ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 17:58:16 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3677B37C5E;
 Mon, 13 May 2024 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715637476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VG0hVDR1A3gz1Vaf0Jg/sQ/kKPTZLnLIteZM6s+JY50=;
 b=Bp7EdyZDHQWkWogf75fUX4kRIkh2whdLDfJidl0453xWBWJ2uXBh7TgLjeyJNpxouhHZTV
 NIzSh5v6ETmYr/M3OpWkp7WDohcINiRVu+psWaoEgGNM25Gbo/IWFGME5++1IlOdTjeAjI
 /4Vsanw2hQYzGLhQ6AMc+MMsNwsRAtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715637476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VG0hVDR1A3gz1Vaf0Jg/sQ/kKPTZLnLIteZM6s+JY50=;
 b=u8OQs3eMugvjiMiTXy3iDYj6KoZC3/32DivZmi0dtpL69jX0B7ckcslwIIdaNsgTyeoGZv
 aPHuz0+6dPfBqeCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715637476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VG0hVDR1A3gz1Vaf0Jg/sQ/kKPTZLnLIteZM6s+JY50=;
 b=Bp7EdyZDHQWkWogf75fUX4kRIkh2whdLDfJidl0453xWBWJ2uXBh7TgLjeyJNpxouhHZTV
 NIzSh5v6ETmYr/M3OpWkp7WDohcINiRVu+psWaoEgGNM25Gbo/IWFGME5++1IlOdTjeAjI
 /4Vsanw2hQYzGLhQ6AMc+MMsNwsRAtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715637476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VG0hVDR1A3gz1Vaf0Jg/sQ/kKPTZLnLIteZM6s+JY50=;
 b=u8OQs3eMugvjiMiTXy3iDYj6KoZC3/32DivZmi0dtpL69jX0B7ckcslwIIdaNsgTyeoGZv
 aPHuz0+6dPfBqeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB55B13A52;
 Mon, 13 May 2024 21:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id icehHOOMQma3OQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 May 2024 21:57:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 26/26] migration: only-migratable-modes
In-Reply-To: <9e5a8874-84c3-4c7b-aa0e-6d01ea6a63de@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-27-git-send-email-steven.sistare@oracle.com>
 <87ikzmkdaq.fsf@suse.de> <9e5a8874-84c3-4c7b-aa0e-6d01ea6a63de@oracle.com>
Date: Mon, 13 May 2024 18:57:53 -0300
Message-ID: <8734qlfk7y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 5/9/2024 3:14 PM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Add the only-migratable-modes option as a generalization of only-migratable.
>>> Only devices that support all requested modes are allowed.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   include/migration/misc.h       |  3 +++
>>>   include/sysemu/sysemu.h        |  1 -
>>>   migration/migration-hmp-cmds.c | 26 +++++++++++++++++++++++++-
>>>   migration/migration.c          | 22 +++++++++++++++++-----
>>>   migration/savevm.c             |  2 +-
>>>   qemu-options.hx                | 16 ++++++++++++++--
>>>   system/globals.c               |  1 -
>>>   system/vl.c                    | 13 ++++++++++++-
>>>   target/s390x/cpu_models.c      |  4 +++-
>>>   9 files changed, 75 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index 5b963ba..3ad2cd9 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -119,6 +119,9 @@ bool migration_incoming_postcopy_advised(void);
>>>   /* True if background snapshot is active */
>>>   bool migration_in_bg_snapshot(void);
>>>   
>>> +void migration_set_required_mode(MigMode mode);
>>> +bool migration_mode_required(MigMode mode);
>>> +
>>>   /* migration/block-dirty-bitmap.c */
>>>   void dirty_bitmap_mig_init(void);
>>>   
>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>> index 5b4397e..0a9c4b4 100644
>>> --- a/include/sysemu/sysemu.h
>>> +++ b/include/sysemu/sysemu.h
>>> @@ -8,7 +8,6 @@
>>>   
>>>   /* vl.c */
>>>   
>>> -extern int only_migratable;
>>>   extern const char *qemu_name;
>>>   extern QemuUUID qemu_uuid;
>>>   extern bool qemu_uuid_set;
>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>> index 414c7e8..ca913b7 100644
>>> --- a/migration/migration-hmp-cmds.c
>>> +++ b/migration/migration-hmp-cmds.c
>>> @@ -16,6 +16,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "block/qapi.h"
>>>   #include "migration/snapshot.h"
>>> +#include "migration/misc.h"
>>>   #include "monitor/hmp.h"
>>>   #include "monitor/monitor.h"
>>>   #include "qapi/error.h"
>>> @@ -33,6 +34,28 @@
>>>   #include "options.h"
>>>   #include "migration.h"
>>>   
>>> +static void migration_dump_modes(Monitor *mon)
>>> +{
>>> +    int mode, n = 0;
>>> +
>>> +    monitor_printf(mon, "only-migratable-modes: ");
>>> +
>>> +    for (mode = 0; mode < MIG_MODE__MAX; mode++) {
>>> +        if (migration_mode_required(mode)) {
>>> +            if (n++) {
>>> +                monitor_printf(mon, ",");
>>> +            }
>>> +            monitor_printf(mon, "%s", MigMode_str(mode));
>>> +        }
>>> +    }
>>> +
>>> +    if (!n) {
>>> +        monitor_printf(mon, "none\n");
>>> +    } else {
>>> +        monitor_printf(mon, "\n");
>>> +    }
>>> +}
>>> +
>>>   static void migration_global_dump(Monitor *mon)
>>>   {
>>>       MigrationState *ms = migrate_get_current();
>>> @@ -41,7 +64,7 @@ static void migration_global_dump(Monitor *mon)
>>>       monitor_printf(mon, "store-global-state: %s\n",
>>>                      ms->store_global_state ? "on" : "off");
>>>       monitor_printf(mon, "only-migratable: %s\n",
>>> -                   only_migratable ? "on" : "off");
>>> +                   migration_mode_required(MIG_MODE_NORMAL) ? "on" : "off");
>>>       monitor_printf(mon, "send-configuration: %s\n",
>>>                      ms->send_configuration ? "on" : "off");
>>>       monitor_printf(mon, "send-section-footer: %s\n",
>>> @@ -50,6 +73,7 @@ static void migration_global_dump(Monitor *mon)
>>>                      ms->decompress_error_check ? "on" : "off");
>>>       monitor_printf(mon, "clear-bitmap-shift: %u\n",
>>>                      ms->clear_bitmap_shift);
>>> +    migration_dump_modes(mon);
>>>   }
>>>   
>>>   void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 4984dee..5535b84 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -1719,17 +1719,29 @@ static bool is_busy(Error **reasonp, Error **errp)
>>>       return false;
>>>   }
>>>   
>>> -static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
>>> +static int migration_modes_required;
>>> +
>>> +void migration_set_required_mode(MigMode mode)
>>> +{
>>> +    migration_modes_required |= BIT(mode);
>>> +}
>>> +
>>> +bool migration_mode_required(MigMode mode)
>>> +{
>>> +    return !!(migration_modes_required & BIT(mode));
>>> +}
>>> +
>>> +static bool modes_are_required(Error **reasonp, Error **errp, int modes)
>>>   {
>>>       ERRP_GUARD();
>>>   
>>> -    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
>>> +    if (migration_modes_required & modes) {
>>>           error_propagate_prepend(errp, *reasonp,
>>> -                                "disallowing migration blocker "
>>> -                                "(--only-migratable) for: ");
>>> +                                "-only-migratable{-modes}  specified, but: ");
>> 
>> extra space before 'specified'
>
> Will fix, thanks.
>
>>>           *reasonp = NULL;
>>>           return true;
>>>       }
>>> +
>>>       return false;
>>>   }
>>>   
>>> @@ -1783,7 +1795,7 @@ int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
>>>       modes = get_modes(mode, ap);
>>>       va_end(ap);
>>>   
>>> -    if (is_only_migratable(reasonp, errp, modes)) {
>>> +    if (modes_are_required(reasonp, errp, modes)) {
>>>           return -EACCES;
>>>       } else if (is_busy(reasonp, errp)) {
>>>           return -EBUSY;
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 6087c3a..e53ac84 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -3585,7 +3585,7 @@ void vmstate_register_ram_global(MemoryRegion *mr)
>>>   bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
>>>   {
>>>       /* check needed if --only-migratable is specified */
>>> -    if (!only_migratable) {
>>> +    if (!migration_mode_required(MIG_MODE_NORMAL)) {
>>>           return true;
>>>       }
>>>   
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index f0dfda5..946d731 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -4807,8 +4807,20 @@ DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>>>       "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
>>>   SRST
>>>   ``-only-migratable``
>>> -    Only allow migratable devices. Devices will not be allowed to enter
>>> -    an unmigratable state.
>>> +    Only allow devices that can migrate using normal mode. Devices will not
>>> +    be allowed to enter an unmigratable state.
>> 
>> What's a "normal" mode is what people will ask. I don't think we need to
>> expose this. This option never had anything to do with "modes" and I
>> think we can keep it this way. See below...
>
> We now have a mode parameter and enum MigMode which includes normal, and is
> documented in qapi.
>

Alright, I take your point below. We could declare -only-migratable
superseded by -only-migratable-modes then:

``-only-migratable``
   Only allow devices that can migrate using normal mode. Devices will not
   be allowed to enter an unmigratable state. Same as
   -only-migratable-modes normal. Kept for backward-compatibility.


>>> +ERST
>>> +
>>> +DEF("only-migratable-modes", HAS_ARG, QEMU_OPTION_only_migratable_modes, \
>>> +    "-only-migratable-modes mode1[,...]\n"
>>> +    "                allow only devices that are migratable using mode(s)\n",
>>> +    QEMU_ARCH_ALL)
>>> +SRST
>>> +``-only-migratable-modes mode1[,...]``
>>> +    Only allow devices which are migratable using all modes in the list,
>>> +    which guarantees that migration will not fail due to a blocker.
>>> +    If both only-migratable-modes and only-migratable are specified,
>>> +    or are specified multiple times, then the required modes accumulate.
>>>   ERST
>>>   
>>>   DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
>>> diff --git a/system/globals.c b/system/globals.c
>>> index e353584..fdc263e 100644
>>> --- a/system/globals.c
>>> +++ b/system/globals.c
>>> @@ -48,7 +48,6 @@ const char *qemu_name;
>>>   unsigned int nb_prom_envs;
>>>   const char *prom_envs[MAX_PROM_ENVS];
>>>   uint8_t *boot_splash_filedata;
>>> -int only_migratable; /* turn it off unless user states otherwise */
>>>   int icount_align_option;
>>>   
>>>   /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
>>> diff --git a/system/vl.c b/system/vl.c
>>> index b76881e..7e73be9 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -3458,7 +3458,18 @@ void qemu_init(int argc, char **argv)
>>>                   incoming = optarg;
>>>                   break;
>>>               case QEMU_OPTION_only_migratable:
>>> -                only_migratable = 1;
>>> +                migration_set_required_mode(MIG_MODE_NORMAL);
>> 
>> ...from the point of view of user intent, I think this should be
>> MIG_MODE_ALL. 
> If only-migratable applies to all modes, then:
> If a user only intends to use mode A, then a blocker for mode B will terminate
> qemu.  Not good.

Ok, we can't know the mode before migration time, nevermind.

>
> Defining only-migratable to apply to normal mode is the backwards-compatible
> solution.
>
> - Steve
>
>> If I have this option set I never want to see a blocker,
>> period. That's not a change in behavior because the mode has to be
>> explicitly selected anyway.
>> 
>>> +                break;
>>> +            case QEMU_OPTION_only_migratable_modes:
>>> +                {
>>> +                    int i, mode;
>>> +                    g_autofree char **words = g_strsplit(optarg, ",", -1);
>>> +                    for (i = 0; words[i]; i++) {
>>> +                        mode = qapi_enum_parse(&MigMode_lookup, words[i], -1,
>>> +                                               &error_fatal);
>>> +                        migration_set_required_mode(mode);
>> 
>> This option can be used to refine the modes being considered, it should
>> take precedence if both are present.
>> 
>>> +                    }
>>> +                }
>>>                   break;
>>>               case QEMU_OPTION_nodefaults:
>>>                   has_defaults = 0;
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index 8ed3bb6..42ad160 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -16,6 +16,7 @@
>>>   #include "kvm/kvm_s390x.h"
>>>   #include "sysemu/kvm.h"
>>>   #include "sysemu/tcg.h"
>>> +#include "migration/misc.h"
>>>   #include "qapi/error.h"
>>>   #include "qemu/error-report.h"
>>>   #include "qapi/visitor.h"
>>> @@ -526,7 +527,8 @@ static void check_compatibility(const S390CPUModel *max_model,
>>>       }
>>>   
>>>   #ifndef CONFIG_USER_ONLY
>>> -    if (only_migratable && test_bit(S390_FEAT_UNPACK, model->features)) {
>>> +    if (migration_mode_required(MIG_MODE_NORMAL) &&
>>> +        test_bit(S390_FEAT_UNPACK, model->features)) {
>>>           error_setg(errp, "The unpack facility is not compatible with "
>>>                      "the --only-migratable option. You must remove either "
>>>                      "the 'unpack' facility or the --only-migratable option");

