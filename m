Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD17FC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 05:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujWUH-0006d8-12; Wed, 06 Aug 2025 01:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWUD-0006an-CW; Wed, 06 Aug 2025 01:14:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWUB-00048v-1J; Wed, 06 Aug 2025 01:14:48 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5765EVW7023744
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 6 Aug 2025 14:14:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nE0i74BD5wcpbEQNg2pf5vXz//5dq0ZIDWhmJRVRv0c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754457272; v=1;
 b=SrJwSsgQs6mEBEJiiAgNrIbDVLY5Xqpq4uANC7I+i9tre/v1iE59PBQrbCVI56ed
 Sy3cbhGhK+SjVuK/z//XUNmpfOogX0X+yosDof5ZhmUu3lzK9wfRC5GtErunjodO
 NQaYA2G0SwjNqPUPG3atKaR6St5Zz84g7fpTKwwED1O1oH4Wjc6rR5qmrll0Uj+M
 gEm7ObF7Yza3dYtPnvWxQqUqu5dEemxzYNO1XbY1YOKi0Gk1GG3r6Q/7kLeCpQvk
 +5WY5VN3c+jN5MElZqRxNp7K2A857cJxe7gm1ufGXWmRt6/DttPbFrOjdfsey96J
 msn6K9KNrG7fyEagmDPXAw==
Message-ID: <e7ce2d52-865c-4f54-8054-125b37f1b48f@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 6 Aug 2025 14:14:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-9-123450810db7@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250805-propagate_tpm_error-v9-9-123450810db7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/08/06 3:25, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state_main() must report an error
> in errp, in case of failure.
> loadvm_process_command also sets the errp object explicitly.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/colo.c   |  5 +++--
>   migration/savevm.c | 33 ++++++++++++++++++++-------------
>   migration/savevm.h |  3 ++-
>   3 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c736c3b4879ff04e58 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
>   static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>                         QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
>   {
> +    ERRP_GUARD();
>       uint64_t total_size;
>       uint64_t value;
>       Error *local_err = NULL;
> @@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>   
>       bql_lock();
>       cpu_synchronize_all_states();
> -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
>       bql_unlock();
>   
>       if (ret < 0) {
> -        error_setg(errp, "Load VM's live state (ram) error");
> +        error_prepend(errp, "Load VM's live state (ram) error: ");
>           return;
>       }
>   
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f3b91c8ae0eee6078406081f0bd7f686fed28601..ad3dd9b172afc541f104d2187a79bafa8e380466 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       qemu_file_set_blocking(f, true);
>   
>       /* TODO: sanity check that only postcopiable data will be loaded here */
> -    load_res = qemu_loadvm_state_main(f, mis);
> +    load_res = qemu_loadvm_state_main(f, mis, NULL);
>   
>       /*
>        * This is tricky, but, mis->from_src_file can change after it
> @@ -2407,6 +2407,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>    */
>   static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
>   {
> +    ERRP_GUARD();
>       int ret;
>       size_t length;
>       QIOChannelBuffer *bioc;
> @@ -2456,9 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
>           qemu_coroutine_yield();
>       } while (1);
>   
> -    ret = qemu_loadvm_state_main(packf, mis);
> +    ret = qemu_loadvm_state_main(packf, mis, errp);
>       if (ret < 0) {
> -        error_setg(errp, "VM state load failed: %d", ret);
> +        error_prepend(errp, "Loading VM state failed: %d: ", ret);
>       }
>       trace_loadvm_handle_cmd_packaged_main(ret);
>       qemu_fclose(packf);
> @@ -3074,8 +3075,10 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>       return true;
>   }
>   
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           Error **errp)
>   {
> +    ERRP_GUARD();
>       uint8_t section_type;
>       int ret = 0;
>   
> @@ -3083,8 +3086,10 @@ retry:
>       while (true) {
>           section_type = qemu_get_byte(f);
>   
> -        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
> +        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
>           if (ret) {
> +            error_prepend(errp, "Failed to load device state section ID: %d: ",
> +                          ret);
>               break;
>           }
>   
> @@ -3105,7 +3110,7 @@ retry:
>               }
>               break;
>           case QEMU_VM_COMMAND:
> -            ret = loadvm_process_command(f, NULL);
> +            ret = loadvm_process_command(f, errp);
>               trace_qemu_loadvm_state_section_command(ret);
>               if ((ret < 0) || (ret == LOADVM_QUIT)) {
>                   goto out;
> @@ -3115,7 +3120,7 @@ retry:
>               /* This is the end of migration */
>               goto out;
>           default:
> -            error_report("Unknown savevm section type %d", section_type);
> +            error_setg(errp, "Unknown savevm section type %d", section_type);
>               ret = -EINVAL;
>               goto out;
>           }
> @@ -3123,6 +3128,9 @@ retry:
>   
>   out:
>       if (ret < 0) {
> +        if (*errp == NULL) {
> +            error_setg(errp, "Loading VM state failed: %d", ret);
> +        }
>           qemu_file_set_error(f, ret);
>   
>           /* Cancel bitmaps incoming regardless of recovery */
> @@ -3143,6 +3151,8 @@ out:
>               migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
>               /* Reset f to point to the newly created channel */
>               f = mis->from_src_file;
> +            error_free(*errp);
> +            *errp = NULL;

error_free_or_abort() is a convenient alternative that can save "*errp = 
NULL" and also catch a bug that called functions return a negative value 
without setting an error.

>               goto retry;
>           }
>       }
> @@ -3176,10 +3186,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>   
>       cpu_synchronize_all_pre_loadvm();
>   
> -    ret = qemu_loadvm_state_main(f, mis);
> -    if (ret < 0) {
> -        error_setg(errp, "Load VM state failed: %d", ret);
> -    }
> +    ret = qemu_loadvm_state_main(f, mis, errp);
>       qemu_event_set(&mis->main_thread_load_event);
>   
>       trace_qemu_loadvm_state_post_main(ret);
> @@ -3260,9 +3267,9 @@ int qemu_load_device_state(QEMUFile *f, Error **errp)
>       int ret;
>   
>       /* Load QEMU_VM_SECTION_FULL section */
> -    ret = qemu_loadvm_state_main(f, mis);
> +    ret = qemu_loadvm_state_main(f, mis, errp);
>       if (ret < 0) {
> -        error_setg(errp, "Failed to load device state: %d", ret);
> +        error_prepend(errp, "Failed to load device state: %d: ", ret);
>           return ret;
>       }
>   
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
>   
>   int qemu_loadvm_state(QEMUFile *f, Error **errp);
>   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           Error **errp);
>   int qemu_load_device_state(QEMUFile *f, Error **errp);
>   int qemu_loadvm_approve_switchover(void);
>   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> 


