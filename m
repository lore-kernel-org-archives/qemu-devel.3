Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED053C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqAI-0004A2-HY; Mon, 21 Jul 2025 09:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udqAA-0003B0-OK; Mon, 21 Jul 2025 09:02:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udqA6-0008PE-N4; Mon, 21 Jul 2025 09:02:38 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56LD1PCM055660
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 22:01:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WlJ4lUWQ5MrGO/kVfeU1p9gtRVo1LPBqG1C81SJYIvA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753102885; v=1;
 b=JoufxLfQDq3tKjgoY0ufYk6Z7e4apigsIK4IZ9v+D2yZ7bFwbg67fjRiKUw4IjjI
 pcS2U10l+a5lv/LZi5G/AREUXEnOsDEDDf8dRPyb9nrW8KdPF5qTN7bjZ/TN0GQr
 IxKNrmPcb4I8UI3fYSGUpv+u3L89xgPCHojaJr5/wkG7AFWnwovfLW4/HllEpAmH
 QMS2WzMVHxk/ju31TU9D77CV1vXS6njHR4BEYGkPRGOC8ZtInhu/s22ElpTJZH25
 oFineZSXEDRYtO707mb5aS3k6ltuxjd1MadoMjog8tMGl8CHXOn630gyp9DvDIUv
 twqmYZQnGLn6eOly3FIOLw==
Message-ID: <155575ab-29c0-4591-a62a-19a6ae3283a6@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 22:01:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/24] migration: push Error **errp into
 qemu_loadvm_state()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-20-fef740e15e17@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250721-propagate_tpm_error-v6-20-fef740e15e17@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/07/21 20:29, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/migration.c |  5 +++--
>   migration/savevm.c    | 25 +++++++++++++------------
>   migration/savevm.h    |  2 +-
>   3 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index d748a02712dc4ebc2de6b0488fb199c92c4d4079..09fadf36dbbbd2f68df1e4cafbf3a51b18531978 100644
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
> +        error_prepend(&local_err, "load of migration failed: %s ",
> +                      strerror(-ret));
>           goto fail;
>       }
>   
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ba146f91427f2a36880aadeb16b11ab2b7df099a..1261e81c86f836e6b5a155ba1880b5823a779567 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3137,27 +3137,24 @@ out:
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
> -    ret = qemu_loadvm_state_header(f, NULL);
> +    ret = qemu_loadvm_state_header(f, errp);
>       if (ret) {
>           return ret;
>       }
>   
> -    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> -        error_report_err(local_err);
> +    if (qemu_loadvm_state_setup(f, errp) != 0) {
>           return -EINVAL;
>       }
>   
> @@ -3167,7 +3164,7 @@ int qemu_loadvm_state(QEMUFile *f)
>   
>       cpu_synchronize_all_pre_loadvm();
>   
> -    ret = qemu_loadvm_state_main(f, mis, NULL);
> +    ret = qemu_loadvm_state_main(f, mis, errp);
>       qemu_event_set(&mis->main_thread_load_event);
>   
>       trace_qemu_loadvm_state_post_main(ret);
> @@ -3185,8 +3182,12 @@ int qemu_loadvm_state(QEMUFile *f)
>           if (migrate_has_error(migrate_get_current()) ||
>               !qemu_loadvm_thread_pool_wait(s, mis)) {
>               ret = -EINVAL;
> +            error_setg(errp, "Error while loading vmstate : %d", ret);

Printing ret here does not help much as ret is always -EINVAL here.

Having an error message different from qemu_file_get_error() will help 
more as it will allow reliably distinguishing these two error conditions.

>           } else {
>               ret = qemu_file_get_error(f);
> +            if (ret < 0) {
> +                error_setg(errp, "Error while loading vmstate : %d", ret);
> +            }
>           }
>       }
>       /*
> @@ -3472,10 +3473,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>       f = qemu_file_new_input(QIO_CHANNEL(ioc));
>       object_unref(OBJECT(ioc));
>   
> -    ret = qemu_loadvm_state(f);
> +    ret = qemu_loadvm_state(f, errp);
>       qemu_fclose(f);
>       if (ret < 0) {
> -        error_setg(errp, "loading Xen device state failed");
> +        error_prepend(errp, "loading Xen device state failed ");
>       }
>       migration_incoming_state_destroy();
>   }
> @@ -3546,13 +3547,13 @@ bool load_snapshot(const char *name, const char *vmstate,
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
> +        error_prepend(errp, "Error %d while loading VM state ", ret);
>           return false;
>       }
>   
> diff --git a/migration/savevm.h b/migration/savevm.h
> index fd7419e6ff90062970ed246b3ea71e6d49a6e372..a6df5198f3fe1a39fc0e6ce3e79cf7a5d8e032db 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
>   void qemu_savevm_live_state(QEMUFile *f);
>   int qemu_save_device_state(QEMUFile *f);
>   
> -int qemu_loadvm_state(QEMUFile *f);
> +int qemu_loadvm_state(QEMUFile *f, Error **errp);
>   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                              Error **errp);
> 


