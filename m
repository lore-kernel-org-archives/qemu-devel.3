Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FCECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO0K-00026N-I2; Sat, 30 Aug 2025 12:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usEbs-00017p-Eo; Sat, 30 Aug 2025 01:58:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usEbp-0006YS-5m; Sat, 30 Aug 2025 01:58:44 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57U5w6CP037926
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 30 Aug 2025 14:58:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RJxMCmU5wog2MxWwEYOR+b7BMonDcxbBjo6oScYrd84=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756533486; v=1;
 b=l0CeNTgEeGETu/RrcfL4a84aCiVOm9rb3GYmzCzrZh2P+DTf3TErZq1XgwjQWGR8
 Pe3POt8SeONeJZk9kx3aIAwJ+T2xOctrOt8R7ykARqOiCNZxt2LxQp3dDugQQ5A4
 btAgSsg/WC/Cdx8v4Mk74RHnJzi36fZ7W47XtZYpOlco6PAd2eQ+QSv1XT/TPKoq
 ylFQlyuA7q9s64CuRxcUsvw2E02K0V+6hYBVBhmiTOeYYyLbonqpNlEAFNVwbK+E
 mX9ymVURZVFC6s++PyuWOne9jZuA0Aisa8l4FL21NADRHnKxlJBZNcfQ/MiVneMF
 ALbDSi30SXGpnZ3agi+n/A==
Message-ID: <078e2ef1-fbfa-450a-a2ab-d1e77cc8e850@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 30 Aug 2025 14:58:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/27] migration: push Error **errp into
 qemu_loadvm_state()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
 <20250830-propagate_tpm_error-v13-7-a4e777b7eb2c@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250830-propagate_tpm_error-v13-7-a4e777b7eb2c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/30 5:01, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state() must report an error
> in errp, in case of failure.
> 
> When postcopy live migration runs, the device states are loaded by
> both the qemu coroutine process_incoming_migration_co() and the
> postcopy_ram_listen_thread(). Therefore, it is important that the
> coroutine also reports the error in case of failure, with
> error_report_err(). Otherwise, the source qemu will not display
> any errors before going into the postcopy pause state.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/migration.c |  9 +++++----
>   migration/savevm.c    | 30 ++++++++++++++++++------------
>   migration/savevm.h    |  2 +-
>   3 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b9957300766ff69effc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
>                         MIGRATION_STATUS_ACTIVE);
>   
>       mis->loadvm_co = qemu_coroutine_self();
> -    ret = qemu_loadvm_state(mis->from_src_file);
> +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
>       mis->loadvm_co = NULL;
>   
>       trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
>       }
>   
>       if (ret < 0) {
> -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
> +        error_prepend(&local_err, "load of migration failed: %s: ",
> +                      strerror(-ret));
>           goto fail;
>       }
>   
> @@ -924,13 +925,13 @@ fail:
>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                         MIGRATION_STATUS_FAILED);
>       migrate_set_error(s, local_err);
> -    error_free(local_err);
> +    error_report_err(local_err);

This is problematic because it results in duplicate error reports when
!mis->exit_on_error; in that case the query-migrate QMP command reports 
the error and this error reporting is redundant.

>   
>       migration_incoming_state_destroy();
>   
>       if (mis->exit_on_error) {
>           WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -            error_report_err(s->error);
> +            error_free(s->error);

This change is problematic because s->error set somewhere else here will 
be ignored.

I think the two changes I commented can be simply removed without 
causing other problems.

>               s->error = NULL;
>           }
>   
> diff --git a/migration/savevm.c b/migration/savevm.c
> index de5671ffd1cd06e728227a3056c3f895d3a6e6f3..0087fca15ce108685667d3808350d80d37b807b1 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3159,28 +3159,24 @@ out:
>       return ret;
>   }
>   
> -int qemu_loadvm_state(QEMUFile *f)
> +int qemu_loadvm_state(QEMUFile *f, Error **errp)
>   {
>       MigrationState *s = migrate_get_current();
>       MigrationIncomingState *mis = migration_incoming_get_current();
> -    Error *local_err = NULL;
>       int ret;
>   
> -    if (qemu_savevm_state_blocked(&local_err)) {
> -        error_report_err(local_err);
> +    if (qemu_savevm_state_blocked(errp)) {
>           return -EINVAL;
>       }
>   
>       qemu_loadvm_thread_pool_create(mis);
>   
> -    ret = qemu_loadvm_state_header(f, &local_err);
> +    ret = qemu_loadvm_state_header(f, errp);
>       if (ret) {
> -        error_report_err(local_err);
>           return ret;
>       }
>   
> -    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> -        error_report_err(local_err);
> +    if (qemu_loadvm_state_setup(f, errp) != 0) {
>           return -EINVAL;
>       }
>   
> @@ -3191,6 +3187,9 @@ int qemu_loadvm_state(QEMUFile *f)
>       cpu_synchronize_all_pre_loadvm();
>   
>       ret = qemu_loadvm_state_main(f, mis);
> +    if (ret < 0) {
> +        error_setg(errp, "Load VM state failed: %d", ret);
> +    }
>       qemu_event_set(&mis->main_thread_load_event);
>   
>       trace_qemu_loadvm_state_post_main(ret);
> @@ -3208,8 +3207,15 @@ int qemu_loadvm_state(QEMUFile *f)
>           if (migrate_has_error(migrate_get_current()) ||
>               !qemu_loadvm_thread_pool_wait(s, mis)) {
>               ret = -EINVAL;
> +            error_setg(errp,
> +                       "Error while loading vmstate");
>           } else {
>               ret = qemu_file_get_error(f);
> +            if (ret < 0) {
> +                error_setg(errp,
> +                           "Error while loading vmstate: stream error: %d",
> +                           ret);
> +            }
>           }
>       }
>       /*
> @@ -3474,6 +3480,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
>   
>   void qmp_xen_load_devices_state(const char *filename, Error **errp)
>   {
> +    ERRP_GUARD();
>       QEMUFile *f;
>       QIOChannelFile *ioc;
>       int ret;
> @@ -3495,10 +3502,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>       f = qemu_file_new_input(QIO_CHANNEL(ioc));
>       object_unref(OBJECT(ioc));
>   
> -    ret = qemu_loadvm_state(f);
> +    ret = qemu_loadvm_state(f, errp);
>       qemu_fclose(f);
>       if (ret < 0) {
> -        error_setg(errp, "loading Xen device state failed");
> +        error_prepend(errp, "loading Xen device state failed: ");
>       }
>       migration_incoming_state_destroy();
>   }
> @@ -3569,13 +3576,12 @@ bool load_snapshot(const char *name, const char *vmstate,
>           ret = -EINVAL;
>           goto err_drain;
>       }
> -    ret = qemu_loadvm_state(f);
> +    ret = qemu_loadvm_state(f, errp);
>       migration_incoming_state_destroy();
>   
>       bdrv_drain_all_end();
>   
>       if (ret < 0) {
> -        error_setg(errp, "Error %d while loading VM state", ret);
>           return false;
>       }
>   
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baeae73d90955 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
>   void qemu_savevm_live_state(QEMUFile *f);
>   int qemu_save_device_state(QEMUFile *f);
>   
> -int qemu_loadvm_state(QEMUFile *f);
> +int qemu_loadvm_state(QEMUFile *f, Error **errp);
>   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>   int qemu_load_device_state(QEMUFile *f);
> 


