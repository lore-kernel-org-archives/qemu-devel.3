Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4B3D74EC5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjGrA-0004oX-0m; Fri, 23 Jan 2026 08:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGoN-0002ig-Ch
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:02:51 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjGoK-0006fP-UD
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:02:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB14F5BCD3;
 Fri, 23 Jan 2026 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769173367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYE0i37PMwK0Z+Elj/UHs+ejh5ugRz5WPd5tHZIDRnQ=;
 b=H8x8O9UVsNWx4iPry26mYSOtMT6xb8z7Yg9SnINa//9k+nnw/pOEj3YklbfJHqbnWcqURn
 alu2nFvG0/KXG7UyBl6Xs+7CzWyR0WX9cPX6N4ZQ0joL2I6JchYeLIgGUQNrOe+EPh8kBW
 cMiwN/DZLb88i14bdk7Jdt4it2EUXeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769173367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYE0i37PMwK0Z+Elj/UHs+ejh5ugRz5WPd5tHZIDRnQ=;
 b=6IZFby+p74NbwwlGvNJsorm6XA5VidwkszVG3MQNAqaOIcnqgMaf5vZ1NJWutdocJNPQlL
 cccLQUNXkr9MF+Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MCjTzZT0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="z/XylgQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769173366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYE0i37PMwK0Z+Elj/UHs+ejh5ugRz5WPd5tHZIDRnQ=;
 b=MCjTzZT0nH+Scss9Gz4QcFpW6TbI4Qeex/omZ/HiQl2i69yiE2Va/+DJSpGtX5jJrThrUC
 EmKoLAVdDIB534x2UzYzhKbQYDEocEMYIyX6HQFcpP+vHp06xjQX6rhWHVUk9NnFhR98c5
 wadmnqhV+7JRmObHI1FpL9JaH5QGph8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769173366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYE0i37PMwK0Z+Elj/UHs+ejh5ugRz5WPd5tHZIDRnQ=;
 b=z/XylgQYGauqKNn6XoHjeY+KjjvQqSXBedSl7JkiQMF8k0GyGL90f/7QB65U3EvAaAnclB
 FPAQ8cyCyCiBQMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E6E5136AA;
 Fri, 23 Jan 2026 13:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AVmjB3Zxc2nQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:02:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com
Subject: Re: [PATCH 5/5] migration: Rename MIG_EVENT_PRECOPY_* to MIG_EVENT_*
In-Reply-To: <20260122230331.3543312-6-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-6-peterx@redhat.com>
Date: Fri, 23 Jan 2026 10:02:43 -0300
Message-ID: <87y0loiirw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EB14F5BCD3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> All three events are shared between precopy and postcopy, rather than
> precopy specific.
>
> For example, both precopy and postcopy will go through a SETUP process.
>
> Meanwhile, both FAILED and DONE notifiers will be notified for either
> precopy or postcopy on completions / failures.
>
> Rename them to make them match what they do, and shorter.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h | 14 +++++++-------
>  hw/intc/arm_gicv3_kvm.c  |  2 +-
>  hw/net/virtio-net.c      |  4 ++--
>  hw/vfio/cpr-legacy.c     |  2 +-
>  hw/vfio/cpr.c            |  8 ++++----
>  hw/vfio/migration.c      |  4 ++--
>  migration/cpr-exec.c     |  6 +++---
>  migration/migration.c    |  8 ++++----
>  net/vhost-vdpa.c         |  4 ++--
>  ui/spice-core.c          |  6 +++---
>  10 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index b002466e10..766de998cb 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -60,10 +60,10 @@ bool migration_is_running(void);
>  bool migration_thread_is_self(void);
>  
>  typedef enum MigrationEventType {
> -    MIG_EVENT_PRECOPY_SETUP,
> -    MIG_EVENT_PRECOPY_DONE,
> -    MIG_EVENT_PRECOPY_FAILED,
> +    MIG_EVENT_SETUP,
>      MIG_EVENT_POSTCOPY_START,
> +    MIG_EVENT_DONE,
> +    MIG_EVENT_FAILED,
>      MIG_EVENT_MAX
>  } MigrationEventType;
>  
> @@ -73,7 +73,7 @@ typedef struct MigrationEvent {
>  
>  /*
>   * A MigrationNotifyFunc may return an error code and an Error object,
> - * but only when @e->type is MIG_EVENT_PRECOPY_SETUP.  The code is an int
> + * but only when @e->type is MIG_EVENT_SETUP.  The code is an int
>   * to allow for different failure modes and recovery actions.
>   */
>  typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
> @@ -83,9 +83,9 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
>   * Register the notifier @notify to be called when a migration event occurs
>   * for MIG_MODE_NORMAL, as specified by the MigrationEvent passed to @func.
>   * Notifiers may receive events in any of the following orders:
> - *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_DONE
> - *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_FAILED
> - *    - MIG_EVENT_PRECOPY_FAILED
> + *    - MIG_EVENT_SETUP -> MIG_EVENT_DONE
> + *    - MIG_EVENT_SETUP -> MIG_EVENT_FAILED
> + *    - MIG_EVENT_FAILED
>   */
>  void migration_add_notifier(NotifierWithReturn *notify,
>                              MigrationNotifyFunc func);
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 6f311e37ef..fddeefa26f 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -774,7 +774,7 @@ static void vm_change_state_handler(void *opaque, bool running,
>  static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
>                                    MigrationEvent *e, Error **errp)
>  {
> -    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +    if (e->type == MIG_EVENT_DONE) {
>          GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
>          return kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>                                   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 317f1ad23b..3e2dc30da6 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3786,7 +3786,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
>  
>      should_be_hidden = qatomic_read(&n->failover_primary_hidden);
>  
> -    if (e->type == MIG_EVENT_PRECOPY_SETUP && !should_be_hidden) {
> +    if (e->type == MIG_EVENT_SETUP && !should_be_hidden) {
>          if (failover_unplug_primary(n, dev)) {
>              vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
>              qapi_event_send_unplug_primary(dev->id);
> @@ -3794,7 +3794,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
>          } else {
>              warn_report("couldn't unplug primary device");
>          }
> -    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +    } else if (e->type == MIG_EVENT_FAILED) {
>          /* We already unplugged the device let's plug it back */
>          if (!failover_replug_primary(n, dev, &err)) {
>              if (err) {
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 7c03ddb961..033a546c30 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -137,7 +137,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>          container_of(notifier, VFIOLegacyContainer, cpr.transfer_notifier);
>      VFIOContainer *bcontainer = VFIO_IOMMU(container);
>  
> -    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
> +    if (e->type != MIG_EVENT_FAILED) {
>          return 0;
>      }
>  
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 998230d271..ffa4f8e099 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -18,7 +18,7 @@
>  int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>                               MigrationEvent *e, Error **errp)
>  {
> -    if (e->type == MIG_EVENT_PRECOPY_SETUP &&
> +    if (e->type == MIG_EVENT_SETUP &&
>          !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
>  
>          error_setg(errp,
> @@ -186,7 +186,7 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
>                                         MigrationEvent *e,
>                                         Error **errp)
>  {
> -    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +    if (e->type == MIG_EVENT_DONE) {
>          vfio_kvm_device_close();
>      }
>      return 0;
> @@ -272,9 +272,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>      VFIOPCIDevice *vdev =
>          container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
>  
> -    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
> +    if (e->type == MIG_EVENT_SETUP) {
>          return vfio_cpr_set_msi_virq(vdev, errp, false);
> -    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +    } else if (e->type == MIG_EVENT_FAILED) {
>          return vfio_cpr_set_msi_virq(vdev, errp, true);
>      }
>      return 0;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f857dc25ed..76a902b79c 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -917,10 +917,10 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
>  
>      trace_vfio_migration_state_notifier(vbasedev->name, e->type);
>  
> -    if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +    if (e->type == MIG_EVENT_FAILED) {
>          /*
>           * MigrationNotifyFunc may not return an error code and an Error
> -         * object for MIG_EVENT_PRECOPY_FAILED. Hence, report the error
> +         * object for MIG_EVENT_FAILED. Hence, report the error
>           * locally and ignore the errp argument.
>           */
>          ret = vfio_migration_set_state_or_reset(vbasedev,
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index da287d8031..18a71828c3 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -164,7 +164,7 @@ static void cpr_exec_cb(void *opaque)
>      err = NULL;
>  
>      /* Note, we can go from state COMPLETED to FAILED */
> -    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> +    migration_call_notifiers(s, MIG_EVENT_FAILED, NULL);
>  
>      if (!migration_block_activate(&err)) {
>          /* error was already reported */
> @@ -182,12 +182,12 @@ static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +    if (e->type == MIG_EVENT_DONE) {
>          QEMUBH *cpr_exec_bh = qemu_bh_new(cpr_exec_cb, NULL);
>          assert(s->state == MIGRATION_STATUS_COMPLETED);
>          qemu_bh_schedule(cpr_exec_bh);
>          qemu_notify_event();
> -    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +    } else if (e->type == MIG_EVENT_FAILED) {
>          cpr_exec_unpersist_state();
>      }
>      return 0;
> diff --git a/migration/migration.c b/migration/migration.c
> index 5bef14ea99..7ba37afb27 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1540,7 +1540,7 @@ static void migration_cleanup(MigrationState *s)
>       * migration completed successfully.
>       */
>      if (!migration_has_failed(s)) {
> -        migration_call_notifiers(s, MIG_EVENT_PRECOPY_DONE, NULL);
> +        migration_call_notifiers(s, MIG_EVENT_DONE, NULL);
>      }
>  
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> @@ -1720,7 +1720,7 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>          notifier = (NotifierWithReturn *)elem->data;
>          ret = notifier->notify(notifier, &e, errp);
>          if (ret) {
> -            assert(type == MIG_EVENT_PRECOPY_SETUP);
> +            assert(type == MIG_EVENT_SETUP);
>              return ret;
>          }
>      }
> @@ -3598,7 +3598,7 @@ static void migration_iteration_finish(MigrationState *s)
>           * Notify FAILED before starting VM, so that devices can invoke
>           * necessary fallbacks before vCPUs run again.
>           */
> -        migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> +        migration_call_notifiers(s, MIG_EVENT_FAILED, NULL);
>  
>          if (runstate_is_live(s->vm_old_state)) {
>              if (!runstate_check(RUN_STATE_SHUTDOWN)) {
> @@ -4064,7 +4064,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>          rate_limit = migrate_max_bandwidth();
>  
>          /* Notify before starting migration thread */
> -        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
> +        if (migration_call_notifiers(s, MIG_EVENT_SETUP, &local_err)) {
>              goto fail;
>          }
>      }
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 74d26a9497..f4b1f0e9e0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -378,9 +378,9 @@ static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
>  {
>      VhostVDPAState *s = container_of(notifier, VhostVDPAState, migration_state);
>  
> -    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
> +    if (e->type == MIG_EVENT_SETUP) {
>          vhost_vdpa_net_log_global_enable(s, true);
> -    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +    } else if (e->type == MIG_EVENT_FAILED) {
>          vhost_vdpa_net_log_global_enable(s, false);
>      }
>      return 0;
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index ce3c2954e3..ee13ecc4a5 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -583,13 +583,13 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
>          return 0;
>      }
>  
> -    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
> +    if (e->type == MIG_EVENT_SETUP) {
>          spice_server_migrate_start(spice_server);
> -    } else if (e->type == MIG_EVENT_PRECOPY_DONE ||
> +    } else if (e->type == MIG_EVENT_DONE ||
>                 e->type == MIG_EVENT_POSTCOPY_START) {
>          spice_server_migrate_end(spice_server, true);
>          spice_have_target_host = false;
> -    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> +    } else if (e->type == MIG_EVENT_FAILED) {
>          spice_server_migrate_end(spice_server, false);
>          spice_have_target_host = false;
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

