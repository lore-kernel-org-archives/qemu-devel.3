Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DFBD65551
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 19:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG1NX-0007LW-Ex; Tue, 26 Nov 2024 14:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tG1NU-0007LF-O3
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tG1NR-0002CW-KJ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732649855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dBsCg/xvUw2LKCCBtB7nnDfZh8HHuPMlQdRPaw9bV44=;
 b=jWlVEN9EmKcA5siqRAQA8SRcYbzss4k9eVBLBb5diQ2ox5jIW/5LztjoltjvtBb9gdiDzA
 nOjDLr0PcjK9SX7y2+KX1VYC6nqx2gVlplAppaFcEY/lNck0/7efB6GWXgDygBt9qjOnRc
 hWaW8ns5dtC94oqcPNTQOfIujsbiXMk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-3R1Faf9ZONK7hS_8sCYblw-1; Tue, 26 Nov 2024 14:37:34 -0500
X-MC-Unique: 3R1Faf9ZONK7hS_8sCYblw-1
X-Mimecast-MFC-AGG-ID: 3R1Faf9ZONK7hS_8sCYblw
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-71d46c2ead8so1834808a34.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 11:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732649853; x=1733254653;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBsCg/xvUw2LKCCBtB7nnDfZh8HHuPMlQdRPaw9bV44=;
 b=QYeCoHzb+6ZUiGWP3oK/R5WSteqWpXvwjz+O+CgTJFZosV7WILYoTvm4Zv+tebhTJZ
 mVeqdQOoqZjcUOALR+dAqXVu1YSp6JWlV4Y42mNcdiUBifMzGOp1fIZKWxElQeb8pSD1
 1jo8s2NckpBBxmZPX2eVmu2+/lD1GIa2bN+D/bnoOMHm+I/53HhX/4g6USPNIIOtqZX7
 Wwu7o3TFUryVMTYjciztgjahysajOe9vyWF34yQR3Cqc3dRDCbHCI+Re7/PiZ5VRs5xS
 ba92/E0gMq94o8zc7/jW8LKYVj12cxL3fyhxjPrFi5LfvvodhoeMaVR7OvJvO4mtqxKK
 bT/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYMmVA43NPpZFi64QQ5nHOVyI1D7oPwJRzemMUt9v+4FtdZC/9Vx41TBENIs5u1+W8wDllu0W4+ujA@nongnu.org
X-Gm-Message-State: AOJu0Yw1hvEbz4w4sNeuENSC7hof9aRz6F1WhKBcEiAogxWPFUKTJ7Tq
 Hdpg2Gio85SEs+XGUHm5M/NOhwxz9sM6Pbzi7e27yLkfXjgLckNyrq9Epudpv5bLiWytxcwqe+U
 gj9kA1NSoR+qGA2IprDnAbUi8pywq38oqyApsvtu5/WkWi0kN3eQT
X-Gm-Gg: ASbGnctosyN/kKXWCzALE63mSp1RpMm4uu0biE34bHvToXL/dIhGkrnnxTJAKk6ktwC
 M7CzqH9YgSyhTN6PyplF7Zxfj71gQgfpWxDL+F6DE8x7i8uLeKUxkGzxVBcoiViIfRukHIj0O0Z
 DsfOwtx9uKkIAUJRg0P41YW32oNtDUKFc9lCZZH3aeIZWdJv3jW8DbrBX41+bTw4ATWmrVKV2Ws
 c+oOgwijNbnPbxIheQtYU+pwE142o5P7MX0F2+fylyIHRiKaOr63+LuZnh/5M4cnqvN34Ya7ggz
 YqHtuyisbwoj
X-Received: by 2002:a05:6358:7254:b0:1ca:94ab:4cee with SMTP id
 e5c5f4694b2df-1cab16933cemr93708055d.16.1732649853347; 
 Tue, 26 Nov 2024 11:37:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtRRrm/V+EJ4GYvTSaPGPGGbQaiCXzyiGr/Cbnpr/J2WDqzW1xzz9FwfeQsR4AsN/jqc73bw==
X-Received: by 2002:a05:6358:7254:b0:1ca:94ab:4cee with SMTP id
 e5c5f4694b2df-1cab16933cemr93704655d.16.1732649852957; 
 Tue, 26 Nov 2024 11:37:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b513f9035dsm495704785a.1.2024.11.26.11.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 11:37:32 -0800 (PST)
Message-ID: <3d208919-7ac0-4922-a61c-8475d8697822@redhat.com>
Date: Tue, 26 Nov 2024 20:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/24] migration: Add MIG_CMD_SWITCHOVER_START and its
 load handler
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/17/24 20:20, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This QEMU_VM_COMMAND sub-command and its switchover_start SaveVMHandler is
> used to mark the switchover point in main migration stream.
> 
> It can be used to inform the destination that all pre-switchover main
> migration stream data has been sent/received so it can start to process
> post-switchover data that it might have received via other migration
> channels like the multifd ones.
> 
> Add also the relevant MigrationState bit stream compatibility property and
> its hw_compat entry.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/core/machine.c                  |  1 +
>   include/migration/client-options.h |  4 +++
>   include/migration/register.h       | 12 +++++++++
>   migration/colo.c                   |  3 +++
>   migration/migration-hmp-cmds.c     |  2 ++
>   migration/migration.c              |  3 +++
>   migration/migration.h              |  2 ++
>   migration/options.c                |  9 +++++++
>   migration/savevm.c                 | 39 ++++++++++++++++++++++++++++++
>   migration/savevm.h                 |  1 +
>   migration/trace-events             |  1 +
>   scripts/analyze-migration.py       | 11 +++++++++
>   12 files changed, 88 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a35c4a8faecb..ed8d39fd769f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,7 @@
>   
>   GlobalProperty hw_compat_9_1[] = {
>       { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
> +    { "migration", "send-switchover-start", "off"},
>   };
>   const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>   
> diff --git a/include/migration/client-options.h b/include/migration/client-options.h
> index 59f4b55cf4f7..289c9d776221 100644
> --- a/include/migration/client-options.h
> +++ b/include/migration/client-options.h
> @@ -10,6 +10,10 @@
>   #ifndef QEMU_MIGRATION_CLIENT_OPTIONS_H
>   #define QEMU_MIGRATION_CLIENT_OPTIONS_H
>   
> +
> +/* properties */
> +bool migrate_send_switchover_start(void);
> +
>   /* capabilities */
>   
>   bool migrate_background_snapshot(void);
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 0b0292738320..ff0faf5f68c8 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -279,6 +279,18 @@ typedef struct SaveVMHandlers {
>        * otherwise
>        */
>       bool (*switchover_ack_needed)(void *opaque);
> +
> +    /**
> +     * @switchover_start
> +     *
> +     * Notifies that the switchover has started. Called only on
> +     * the destination.
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*switchover_start)(void *opaque);

We don't need an 'Error **' parameter  ? Just asking.

>   } SaveVMHandlers;
>   
>   /**
> diff --git a/migration/colo.c b/migration/colo.c
> index 9590f281d0f1..a75c2c41b464 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -452,6 +452,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>           bql_unlock();
>           goto out;
>       }
> +
> +    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);

I would drop '_maybe_' from the name.


Thanks,

C.


> +
>       /* Note: device state is saved into buffer */
>       ret = qemu_save_device_state(fb);
>   
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 20d1a6e21948..59d0c48a3e0d 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -46,6 +46,8 @@ static void migration_global_dump(Monitor *mon)
>                      ms->send_configuration ? "on" : "off");
>       monitor_printf(mon, "send-section-footer: %s\n",
>                      ms->send_section_footer ? "on" : "off");
> +    monitor_printf(mon, "send-switchover-start: %s\n",
> +                   ms->send_switchover_start ? "on" : "off");
>       monitor_printf(mon, "clear-bitmap-shift: %u\n",
>                      ms->clear_bitmap_shift);
>   }
> diff --git a/migration/migration.c b/migration/migration.c
> index 8c5bd0a75c85..2e9d6d5087d7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2543,6 +2543,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>       }
>       restart_block = true;
>   
> +    qemu_savevm_maybe_send_switchover_start(ms->to_dst_file);
> +
>       /*
>        * Cause any non-postcopiable, but iterative devices to
>        * send out their final data.
> @@ -2742,6 +2744,7 @@ static int migration_completion_precopy(MigrationState *s,
>        */
>       s->block_inactive = !migrate_colo();
>       migration_rate_set(RATE_LIMIT_DISABLED);
> +    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
>       ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
>                                                s->block_inactive);
>   out_unlock:
> diff --git a/migration/migration.h b/migration/migration.h
> index 0956e9274b2c..2a18349cfec2 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -403,6 +403,8 @@ struct MigrationState {
>       bool send_configuration;
>       /* Whether we send section footer during migration */
>       bool send_section_footer;
> +    /* Whether we send switchover start notification during migration */
> +    bool send_switchover_start;
>   
>       /* Needed by postcopy-pause state */
>       QemuSemaphore postcopy_pause_sem;
> diff --git a/migration/options.c b/migration/options.c
> index ad8d6989a807..f916c8ed4e09 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -92,6 +92,8 @@ Property migration_properties[] = {
>                        send_configuration, true),
>       DEFINE_PROP_BOOL("send-section-footer", MigrationState,
>                        send_section_footer, true),
> +    DEFINE_PROP_BOOL("send-switchover-start", MigrationState,
> +                     send_switchover_start, true),
>       DEFINE_PROP_BOOL("multifd-flush-after-each-section", MigrationState,
>                         multifd_flush_after_each_section, false),
>       DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
> @@ -206,6 +208,13 @@ bool migrate_auto_converge(void)
>       return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
>   }
>   
> +bool migrate_send_switchover_start(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->send_switchover_start;
> +}
> +
>   bool migrate_background_snapshot(void)
>   {
>       MigrationState *s = migrate_get_current();
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f4e4876f7202..a254c38edcca 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -90,6 +90,7 @@ enum qemu_vm_cmd {
>       MIG_CMD_ENABLE_COLO,       /* Enable COLO */
>       MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
>       MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
> +    MIG_CMD_SWITCHOVER_START,  /* Switchover start notification */
>       MIG_CMD_MAX
>   };
>   
> @@ -109,6 +110,7 @@ static struct mig_cmd_args {
>       [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
>       [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
>       [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
> +    [MIG_CMD_SWITCHOVER_START] = { .len =  0, .name = "SWITCHOVER_START" },
>       [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
>   };
>   
> @@ -1201,6 +1203,19 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
>       qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
>   }
>   
> +static void qemu_savevm_send_switchover_start(QEMUFile *f)
> +{
> +    trace_savevm_send_switchover_start();
> +    qemu_savevm_command_send(f, MIG_CMD_SWITCHOVER_START, 0, NULL);
> +}
> +
> +void qemu_savevm_maybe_send_switchover_start(QEMUFile *f)
> +{
> +    if (migrate_send_switchover_start()) {
> +        qemu_savevm_send_switchover_start(f);
> +    }
> +}
> +
>   bool qemu_savevm_state_blocked(Error **errp)
>   {
>       SaveStateEntry *se;
> @@ -1713,6 +1728,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>   
>       ret = qemu_file_get_error(f);
>       if (ret == 0) {
> +        qemu_savevm_maybe_send_switchover_start(f);
>           qemu_savevm_state_complete_precopy(f, false, false);
>           ret = qemu_file_get_error(f);
>       }
> @@ -2413,6 +2429,26 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis)
>       return ret;
>   }
>   
> +static int loadvm_postcopy_handle_switchover_start(void)
> +{
> +    SaveStateEntry *se;
> +
> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> +        int ret;
> +
> +        if (!se->ops || !se->ops->switchover_start) {
> +            continue;
> +        }
> +
> +        ret = se->ops->switchover_start(se->opaque);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   /*
>    * Process an incoming 'QEMU_VM_COMMAND'
>    * 0           just a normal return
> @@ -2511,6 +2547,9 @@ static int loadvm_process_command(QEMUFile *f)
>   
>       case MIG_CMD_ENABLE_COLO:
>           return loadvm_process_enable_colo(mis);
> +
> +    case MIG_CMD_SWITCHOVER_START:
> +        return loadvm_postcopy_handle_switchover_start();
>       }
>   
>       return 0;
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 9ec96a995c93..4d402723bc3c 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -53,6 +53,7 @@ void qemu_savevm_send_postcopy_listen(QEMUFile *f);
>   void qemu_savevm_send_postcopy_run(QEMUFile *f);
>   void qemu_savevm_send_postcopy_resume(QEMUFile *f);
>   void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
> +void qemu_savevm_maybe_send_switchover_start(QEMUFile *f);
>   
>   void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>                                              uint16_t len,
> diff --git a/migration/trace-events b/migration/trace-events
> index bb0e0cc6dcfe..551f5af0740f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -39,6 +39,7 @@ savevm_send_postcopy_run(void) ""
>   savevm_send_postcopy_resume(void) ""
>   savevm_send_colo_enable(void) ""
>   savevm_send_recv_bitmap(char *name) "%s"
> +savevm_send_switchover_start(void) ""
>   savevm_state_setup(void) ""
>   savevm_state_resume_prepare(void) ""
>   savevm_state_header(void) ""
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 8a254a5b6a2e..a4d4042584c0 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -564,7 +564,9 @@ class MigrationDump(object):
>       QEMU_VM_SUBSECTION    = 0x05
>       QEMU_VM_VMDESCRIPTION = 0x06
>       QEMU_VM_CONFIGURATION = 0x07
> +    QEMU_VM_COMMAND       = 0x08
>       QEMU_VM_SECTION_FOOTER= 0x7e
> +    QEMU_MIG_CMD_SWITCHOVER_START = 0x0b
>   
>       def __init__(self, filename):
>           self.section_classes = {
> @@ -626,6 +628,15 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>               elif section_type == self.QEMU_VM_SECTION_PART or section_type == self.QEMU_VM_SECTION_END:
>                   section_id = file.read32()
>                   self.sections[section_id].read()
> +            elif section_type == self.QEMU_VM_COMMAND:
> +                command_type = file.read16()
> +                command_data_len = file.read16()
> +                if command_type != self.QEMU_MIG_CMD_SWITCHOVER_START:
> +                    raise Exception("Unknown QEMU_VM_COMMAND: %x" %
> +                                    (command_type))
> +                if command_data_len != 0:
> +                    raise Exception("Invalid SWITCHOVER_START length: %x" %
> +                                    (command_data_len))
>               elif section_type == self.QEMU_VM_SECTION_FOOTER:
>                   read_section_id = file.read32()
>                   if read_section_id != section_id:
> 


