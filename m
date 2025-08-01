Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A37C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 07:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhk2f-0000TE-Rm; Fri, 01 Aug 2025 03:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhk1Y-0007mZ-Bo; Fri, 01 Aug 2025 03:17:53 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhk1U-000232-AO; Fri, 01 Aug 2025 03:17:51 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5717H5da043232
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 1 Aug 2025 16:17:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Go7DRx8urcI1UlkZOsuuJgj8QU68u4ouTflImUD5JQg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754032625; v=1;
 b=ZPmmgoQmd8/K/ezGOqK7vjTdImpMp2PbMgCOk5M/6xzbYuFX8pNJYeL/h5WHIH79
 C8BXWxbAfU9BgibIi0hlQu+SGHVN/gRpoUrytcy52vgMGDKiQy8YkxwsAdx4R4J+
 WBacPNLHbClZ7ltJYah1BdIZmaYxysgd/EwZel3LyaHEVOL81Dy72fdQ3+tssNdi
 NWv2FKwpRsYNqflSkRj3+8m/+Pbfda8qbzetm4G7puKYU+U829bqKpLnRMa2Bix5
 tSSNTJdK+clMEwUSCePl/Uh9xgRlMLK4WnbZ4TBd9CDlh2qPlWnke7Lq0ic/yJso
 HG7wXV3AmRlVU6IA4a/x2w==
Message-ID: <91c9a8ab-6fdb-4945-8e7d-da60cd037116@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 1 Aug 2025 16:17:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/27] migration: push Error **errp into
 qemu_loadvm_state_main()
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
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-19-28fd82fdfdb2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250731-propagate_tpm_error-v8-19-28fd82fdfdb2@redhat.com>
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

On 2025/07/31 22:20, Arun Menon wrote:
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
>   migration/savevm.c | 27 ++++++++++++++++-----------
>   migration/savevm.h |  3 ++-
>   3 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 981bd4bf9ced8b45b4c5d494acae119a174ee974..529794dfc8d943b8ba3a25391ee2132c0c3f312e 100644
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
> index e885f1724f223771d60081fea199320abc549d2f..f5903995edd2b4c4f6c1a214c7126d831f10c9f1 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2111,7 +2111,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       qemu_file_set_blocking(f, true);
>   
>       /* TODO: sanity check that only postcopiable data will be loaded here */
> -    load_res = qemu_loadvm_state_main(f, mis);
> +    load_res = qemu_loadvm_state_main(f, mis, NULL);
>   
>       /*
>        * This is tricky, but, mis->from_src_file can change after it
> @@ -2412,6 +2412,7 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>    */
>   static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
>   {
> +    ERRP_GUARD();
>       int ret;
>       size_t length;
>       QIOChannelBuffer *bioc;
> @@ -2461,9 +2462,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
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
> @@ -3066,8 +3067,10 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
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
> @@ -3075,8 +3078,10 @@ retry:
>       while (true) {
>           section_type = qemu_get_byte(f);
>   
> -        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
> +        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
>           if (ret) {
> +            error_prepend(errp, "Failed to load device state section ID: %d: ",
> +                          ret);

I noticed this is after the "retry" label; errp already contains an 
error when retried so the error needs to be properly reported and freed.

>               break;
>           }
>   
> @@ -3084,20 +3089,20 @@ retry:
>           switch (section_type) {
>           case QEMU_VM_SECTION_START:
>           case QEMU_VM_SECTION_FULL:
> -            ret = qemu_loadvm_section_start_full(f, section_type, NULL);
> +            ret = qemu_loadvm_section_start_full(f, section_type, errp);
>               if (ret < 0) {
>                   goto out;
>               }
>               break;
>           case QEMU_VM_SECTION_PART:
>           case QEMU_VM_SECTION_END:
> -            ret = qemu_loadvm_section_part_end(f, section_type, NULL);
> +            ret = qemu_loadvm_section_part_end(f, section_type, errp);
>               if (ret < 0) {
>                   goto out;
>               }
>               break;
>           case QEMU_VM_COMMAND:
> -            ret = loadvm_process_command(f, NULL);
> +            ret = loadvm_process_command(f, errp);
>               trace_qemu_loadvm_state_section_command(ret);
>               if ((ret < 0) || (ret == LOADVM_QUIT)) {
>                   goto out;
> @@ -3107,7 +3112,7 @@ retry:
>               /* This is the end of migration */
>               goto out;
>           default:
> -            error_report("Unknown savevm section type %d", section_type);
> +            error_setg(errp, "Unknown savevm section type %d", section_type);
>               ret = -EINVAL;
>               goto out;
>           }
> @@ -3171,7 +3176,7 @@ int qemu_loadvm_state(QEMUFile *f)
>   
>       cpu_synchronize_all_pre_loadvm();
>   
> -    ret = qemu_loadvm_state_main(f, mis);
> +    ret = qemu_loadvm_state_main(f, mis, NULL);
>       qemu_event_set(&mis->main_thread_load_event);
>   
>       trace_qemu_loadvm_state_post_main(ret);
> @@ -3245,7 +3250,7 @@ int qemu_load_device_state(QEMUFile *f)
>       int ret;
>   
>       /* Load QEMU_VM_SECTION_FULL section */
> -    ret = qemu_loadvm_state_main(f, mis);
> +    ret = qemu_loadvm_state_main(f, mis, NULL);
>       if (ret < 0) {
>           error_report("Failed to load device state: %d", ret);
>           return ret;
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 2d5e9c716686f06720325e82fe90c75335ced1de..fd7419e6ff90062970ed246b3ea71e6d49a6e372 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
>   
>   int qemu_loadvm_state(QEMUFile *f);
>   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           Error **errp);
>   int qemu_load_device_state(QEMUFile *f);
>   int qemu_loadvm_approve_switchover(void);
>   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> 


