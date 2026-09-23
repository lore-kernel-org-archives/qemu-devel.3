Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47B9C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9GyJ-00080P-9k; Wed, 23 Sep 2026 03:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x9GyB-00080A-4P
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:00:46 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x9Gy5-0005AZ-GM
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:00:41 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68N6xkeh069881
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 23 Sep 2026 15:59:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=17woF6sRmLNxpRXtHW7HcqnXXiFBUW4XYDmChjR89eA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790146787; v=1;
 b=LMIuymd5fFidWS+EnDoom5/Y06Nv+b0X8VquLe8YO1SEAh0YYnEMqImzuJIcUqBS
 V/8HxrA/CQ/sfVkRTHhCm3YF2yMCJf21D1ezAaSWhJImk7u4VDHmb3IHOpj1zgli
 xlZ+btQvCvBN/L7xiED31FiQIbdWTc4bGXE3PTEhOxrMxr46jW7+uJPvMOAwV6ZF
 rkf9ew/77LqcmpplAxHAxWZDKZadgaW3qLmhTvSYG5HgQ732X289AbEzZsi7Y0A2
 V022PLAogRNimTExR+g8pF84AeDzso8hBj0nnuCFVVM2SG/3RChSM/Cbzm3dIMfk
 OupXoWFrRkXtoD7tKAkO9A==
Message-ID: <78984db5-6de9-40c7-abf4-884c539232da@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 23 Sep 2026 15:59:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] migration: Implement Xen migration blocker
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260912-xen-v1-0-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
 <20260912-xen-v1-2-ebd6a2aa519f@rsg.ci.i.u-tokyo.ac.jp>
 <87v77x9x8u.fsf@suse.de>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <87v77x9x8u.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/22 23:28, Fabiano Rosas wrote:
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
> 
>> xen-save-devices-state saves device VMState outside QEMU's normal
>> migration-mode machinery, so it currently ignores migration blockers.
>> Add a separate blocker class for this command.
>>
>> Blockers registered with migrate_add_blocker() or
>> migrate_add_blocker_internal() now include this class. Existing
>> mode-specific blocker masks remain unchanged, except that vhost-scsi's
>> default blocker now covers normal migration and Xen device-state
>> saving. Its CPR exemption assumes that the replacement QEMU runs on
>> the same host and not concurrently with the old QEMU; Xen save and
>> restore do not guarantee those conditions. Users can set
>> migratable=true when shared storage or orchestrator-migrated target
>> state makes migration safe.
>>
> 
> So one thing is rejecting the xen-save-devices-state command if there
> are blockers. This could very well just use the normal mode (default),
> no? Or all modes, like qmp_dump_guest_memory() does?

In general, blockers registered via migrate_add_blocker_normal() are 
specific to standard QEMU live migration and do not apply to Xen. For 
example, block formats like qcow or vhd register normal migration 
blockers, but Xen explicitly supports migration with them [1]. 
Unconditionally applying normal-mode blockers to Xen would cause 
regressions. vhost-scsi is the exception here and is handled specifically.

Checking every mode would lead to the same regression. Note that 
qmp_dump_guest_memory() registers an all-mode blocker during execution; 
it does not check all existing blocker lists when invoked.

[1] https://xenbits.xen.org/docs/4.22-testing/SUPPORT.html#blkback

> 
> Another thing (complementary, could be in the same patch) is rejecting
> the command line if there are blocked devices, including any ones used
> along with Xen acceleration. Again, why does this need a new blocker
> category? I'm not seeing it.
You can use -only-migratable.

> 
>> Fixes: a7ae8355b446 ("Introduce "xen-save-devices-state"")
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   include/migration/blocker.h | 10 ++++++-
>>   include/qemu/accel.h        |  2 +-
>>   migration/migration.h       |  2 ++
>>   accel/accel-system.c        | 25 +++++++++++++-----
>>   hw/scsi/vhost-scsi.c        |  5 +++-
>>   migration/migration.c       | 63 ++++++++++++++++++++++++++++++++++++++-------
>>   migration/savevm.c          |  4 +++
>>   system/vl.c                 |  9 ++++---
>>   8 files changed, 99 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/migration/blocker.h b/include/migration/blocker.h
>> index 80b75ad5cbdb..0fbaaac83ce8 100644
>> --- a/include/migration/blocker.h
>> +++ b/include/migration/blocker.h
>> @@ -16,6 +16,14 @@
>>   
>>   #include "qapi/qapi-types-migration.h"
>>   
>> +/**
>> + * define MIG_XEN - identifier for Xen migration
> 
> Hm.
> 
>> + *
>> + * Xen migration is distinct from those expressed with &typedef MigMode.
>> + * Use this for migration blockers that affect Xen.
>> + */
>> +#define MIG_XEN MIG_MODE__MAX
> 
> This could be fine, Xen migration is pre-existing and 'mode' is part of
> QAPI, we don't want to create a new mode for Xen.
> 
>> +
>>   /**
>>    * @migrate_add_blocker - prevent all modes of migration from proceeding
>>    *
>> @@ -80,7 +88,7 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp);
>>    *
>>    * @reasonp - address of an error to be returned whenever migration is attempted
>>    *
>> - * @modes - the migration modes to be blocked, a bit set of MigMode
>> + * @modes - the migration modes to be blocked, a bit set of MigMode and %MIG_XEN
> 
> But it's not a mode, so we shouldn't re-use @modes. We just want a place
> to store the Xen blockers, let's not introduce the confusion that this
> could be a mode somehow.
> 
> We could just add migrate_add_blocker_xen and call add_blockers directly
> since you're changing that function to use the array size instead of
> MIG_MODE__MAX.

I would prefer to keep a single function for adding blockers across all 
migration types so that the full scope of a blocker can be seen at a 
single call site (see the vhost-scsi changes for an example).

Practically speaking, I think the risk of reusing @modes is minimal 
because there is no alternative selective-blocking API to misuse. It 
would indeed be cleaner to have a parameter name that encompasses both 
MigMode and MIG_XEN, but I haven't come up with a better name yet; 
suggestions are welcome.

> 
>>    *
>>    * @errp - [out] The reason (if any) we cannot block migration right now.
>>    *
>> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
>> index 6f65f1cb89a0..b6b456a82fc3 100644
>> --- a/include/qemu/accel.h
>> +++ b/include/qemu/accel.h
>> @@ -47,7 +47,7 @@ const char *current_accel_name(void);
>>   
>>   void accel_init_interfaces(AccelClass *ac);
>>   
>> -int accel_init_machine(AccelState *accel, MachineState *ms);
>> +int accel_init_machine(AccelState *accel, MachineState *ms, Error **errp);
>>   
>>   /* Called just before os_setup_post (ie just before drop OS privs) */
>>   void accel_setup_post(MachineState *ms);
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 683bc7bdd521..f53fdb2df107 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -568,7 +568,9 @@ void migration_start_incoming(void);
>>   int migration_call_notifiers(MigrationEventType type, Error **errp);
>>   
>>   int migrate_init(MigrationState *s, Error **errp);
>> +bool enforce_only_migratable(Error **errp);
>>   bool migration_is_blocked(Error **errp);
>> +bool xen_migration_is_blocked(Error **errp);
>>   /* True if outgoing migration has entered postcopy phase */
>>   bool migration_in_postcopy(void);
>>   bool migration_postcopy_is_alive(MigrationStatus state);
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index 1325b23864c8..75a691cb3cfe 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -26,7 +26,9 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/accel.h"
>>   #include "qom/compat-properties.h"
>> +#include "qapi/error.h"
>>   #include "qapi/qapi-commands-accelerator.h"
>> +#include "migration/migration.h"
>>   #include "monitor/monitor.h"
>>   #include "monitor/hmp.h"
>>   #include "hw/core/boards.h"
>> @@ -37,20 +39,31 @@
>>   #include "qemu/error-report.h"
>>   #include "accel-internal.h"
>>   
>> -int accel_init_machine(AccelState *accel, MachineState *ms)
>> +int accel_init_machine(AccelState *accel, MachineState *ms, Error **errp)
>>   {
>>       AccelClass *acc = ACCEL_GET_CLASS(accel);
>>       int ret;
>>       ms->accelerator = accel;
>>       *(acc->allowed) = true;
>> +
>> +    if (!enforce_only_migratable(errp)) {
>> +        ret = -EACCES;
>> +        goto fail;
>> +    }
> 
> Here I think you want to fail the initialization if the accelerator is
> Xen, -only-migratable is set and there are blockers. At this point is
> not clear whether these blockers really need a xen-specific category.

The category reflects the specific requirements of the blocker itself. 
Looking at vhost-scsi (which registers a Xen-affecting blocker) 
clarifies why this distinction is necessary; this code merely enforces 
registered blockers.

> 
> Isn't this too soon anyway? What blockers will be registered at this
> point and if there are blockers on the list, why the
> is_only_migratable() check at migrate_add_blocker_modes() hasn't already
> rejected the cmdline?

This check is placed here because qemu_create_early_backends() runs 
before configure_accelerators(). Command-line backends (such as qcow or 
vmdk) can register blockers before xen_enabled() accurately reflects the 
selected accelerator.

> 
>> +
>>       ret = acc->init_machine(accel, ms);
>>       if (ret < 0) {
>> -        ms->accelerator = NULL;
>> -        *(acc->allowed) = false;
>> -        object_unref(OBJECT(accel));
>> -    } else {
>> -        object_set_accelerator_compat_props(acc->compat_props);
>> +        error_setg(errp, "%s", strerror(-ret));
>> +        goto fail;
>>       }
>> +
>> +    object_set_accelerator_compat_props(acc->compat_props);
>> +    return ret;
>> +
>> +fail:
>> +    ms->accelerator = NULL;
>> +    *(acc->allowed) = false;
>> +    object_unref(OBJECT(accel));
>>       return ret;
>>   }
>>   
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 657403cad011..f9847b5e7096 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -262,12 +262,15 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>>       }
>>   
>>       if (!vsc->migratable) {
>> +        unsigned int modes = BIT(MIG_MODE_NORMAL) | BIT(MIG_XEN);
>> +
>>           error_setg(&vsc->migration_blocker,
>>                   "vhost-scsi does not support migration in all cases. "
>>                   "When external environment supports it (Orchestrator migrates "
>>                   "target SCSI device state or use shared storage over network), "
>>                   "set 'migratable' property to true to enable migration.");
>> -        if (migrate_add_blocker_normal(&vsc->migration_blocker, errp) < 0) {
>> +        if (migrate_add_blocker_modes(&vsc->migration_blocker,
>> +                                      modes, errp) < 0) {
>>               goto free_virtio;
>>           }
>>       }
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d0b864a76066..c177dc52a1c1 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -23,6 +23,7 @@
>>   #include "system/runstate.h"
>>   #include "system/system.h"
>>   #include "system/cpu-throttle.h"
>> +#include "system/xen.h"
>>   #include "ram.h"
>>   #include "migration/cpr.h"
>>   #include "migration/global_state.h"
>> @@ -94,7 +95,8 @@ enum mig_rp_message_type {
>>   static MigrationState *current_migration;
>>   static MigrationIncomingState *current_incoming;
>>   
>> -static GSList *migration_blockers[MIG_MODE__MAX];
>> +static GSList *migration_blockers[MIG_MODE__MAX + 1];
>> +static bool enforcing_only_migratable;
>>   
>>   static bool migration_object_check(MigrationState *ms, Error **errp);
>>   static bool migration_switchover_start(MigrationState *s, Error **errp);
>> @@ -1760,15 +1762,22 @@ static bool is_busy(Error **reasonp, Error **errp)
>>       return false;
>>   }
>>   
>> +static void propagate_disallowed_blocker(Error **errp, Error **reasonp)
>> +{
>> +    error_propagate_prepend(errp, *reasonp,
>> +                            "disallowing migration blocker "
>> +                            "(--only-migratable) for: ");
>> +    *reasonp = NULL;
>> +}
>> +
>>   static bool is_only_migratable(Error **reasonp, unsigned modes, Error **errp)
>>   {
>> +    unsigned mode = xen_enabled() ? MIG_XEN : MIG_MODE_NORMAL;
>> +
>>       ERRP_GUARD();
>>   
>> -    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
>> -        error_propagate_prepend(errp, *reasonp,
>> -                                "disallowing migration blocker "
>> -                                "(--only-migratable) for: ");
>> -        *reasonp = NULL;
>> +    if (enforcing_only_migratable && (modes & BIT(mode))) {
>> +        propagate_disallowed_blocker(errp, reasonp);
>>           return true;
>>       }
>>       return false;
>> @@ -1776,7 +1785,7 @@ static bool is_only_migratable(Error **reasonp, unsigned modes, Error **errp)
>>   
>>   static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
>>   {
>> -    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>> +    for (MigMode mode = 0; mode < ARRAY_SIZE(migration_blockers); mode++) {
> 
> Not a MigMode anymore.

Good catch. I will fix the type in the next version.

> 
>>           if (modes & BIT(mode)) {
>>               assert(g_slist_index(migration_blockers[mode],
>>                                    *reasonp) == -1);
>> @@ -1809,7 +1818,7 @@ int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
>>   
>>   int migrate_add_blocker_internal(Error **reasonp, Error **errp)
>>   {
>> -    unsigned modes = BIT(MIG_MODE__MAX) - 1;
>> +    unsigned modes = BIT(ARRAY_SIZE(migration_blockers)) - 1;
>>   
>>       if (is_busy(reasonp, errp)) {
>>           return -EBUSY;
>> @@ -1820,7 +1829,7 @@ int migrate_add_blocker_internal(Error **reasonp, Error **errp)
>>   void migrate_del_blocker(Error **reasonp)
>>   {
>>       if (*reasonp) {
>> -        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>> +        for (MigMode mode = 0; mode < ARRAY_SIZE(migration_blockers); mode++) {
> 
> Same here, just use int i.

Will update the variable name and type accordingly.

> 
>>               migration_blockers[mode] = g_slist_remove(migration_blockers[mode],
>>                                                         *reasonp);
>>           }
>> @@ -1948,6 +1957,26 @@ void qmp_migrate_pause(Error **errp)
>>                  "during postcopy-active or postcopy-recover state");
>>   }
>>   
>> +bool enforce_only_migratable(Error **errp)
>> +{
>> +    unsigned mode = xen_enabled() ? MIG_XEN : MIG_MODE_NORMAL;
>> +    GSList *blockers = migration_blockers[mode];
> 
> For Xen, what blockers are those? Is it the case that existing blockers
> are simply not taking effect for Xen because the QMP command never
> checks blockers? Or do you intend to add xen-specific blockers?

The former.

Existing migration blockers currently do not take effect for Xen, which 
this patch fixes. However, applying all blockers from an existing 
MigMode could cause a regression for the reasons stated above. 
Therefore, this patch ensures that only blockers relevant to Xen are 
applied.

Specifically, it enforces the blockers added via migrate_add_blocker() 
and the vhost-scsi blocker. The remaining blockers have not been proven 
incompatible with Xen migration, so applying them unconditionally could 
cause regressions.

Regards,
Akihiko Odaki

> 
>> +    Error *reason;
>> +
>> +    if (!only_migratable) {
>> +        return true;
>> +    }
>> +
>> +    if (blockers) {
>> +        reason = error_copy(blockers->data);
>> +        propagate_disallowed_blocker(errp, &reason);
>> +        return false;
>> +    }
>> +
>> +    enforcing_only_migratable = true;
>> +    return true;
>> +}
>> +
>>   bool migration_is_blocked(Error **errp)
>>   {
>>       GSList *blockers = migration_blockers[migrate_mode()];
>> @@ -1964,6 +1993,22 @@ bool migration_is_blocked(Error **errp)
>>       return false;
>>   }
>>   
>> +bool xen_migration_is_blocked(Error **errp)
>> +{
>> +    GSList *blockers = migration_blockers[MIG_XEN];
>> +
>> +    if (qemu_savevm_state_blocked(errp)) {
>> +        return true;
>> +    }
>> +
>> +    if (blockers) {
>> +        error_propagate(errp, error_copy(blockers->data));
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   /* Returns true if continue to migrate, or false if error detected */
>>   static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>   {
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 4b590ea672d2..4e5e1af1b202 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3418,6 +3418,10 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>>       int saved_vm_running;
>>       int ret;
>>   
>> +    if (xen_migration_is_blocked(errp)) {
>> +        return;
>> +    }
>> +
>>       if (!has_live) {
>>           /* live default to true so old version of Xen tool stack can have a
>>            * successful live migration */
>> diff --git a/system/vl.c b/system/vl.c
>> index 9bd7664b85c7..21fa810637c3 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2392,6 +2392,7 @@ static int accelerator_set_property(void *opaque,
>>   
>>   static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>   {
>> +    Error *local_err = NULL;
>>       bool *p_init_failed = opaque;
>>       const char *acc = qemu_opt_get(opts, "accel");
>>       AccelClass *ac = accel_find(acc);
>> @@ -2418,10 +2419,12 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>                        accel,
>>                        &error_fatal);
>>   
>> -    ret = accel_init_machine(accel, current_machine);
>> +    ret = accel_init_machine(accel, current_machine, &local_err);
>>       if (ret < 0) {
>> -        if (!qtest_with_kvm || ret != -ENOENT) {
>> -            error_report("failed to initialize %s: %s", acc, strerror(-ret));
>> +        if (qtest_with_kvm && ret == -ENOENT) {
>> +            error_free(local_err);
>> +        } else {
>> +            error_reportf_err(local_err, "failed to initialize %s: ", acc);
>>           }
>>           goto bad;
>>       }


