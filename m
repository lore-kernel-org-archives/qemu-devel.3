Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBC1C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFGx-0004Nw-43; Wed, 16 Jul 2025 23:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ucFGi-0003ev-WF; Wed, 16 Jul 2025 23:26:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ucFGf-0006ni-It; Wed, 16 Jul 2025 23:26:48 -0400
Received: from [10.160.60.105] (p7852202-ipoefx.ipoe.ocn.ne.jp
 [123.225.53.201]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56H3QGIg074529
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 17 Jul 2025 12:26:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6ICodstAUrhkYCIC0wqsaV70Ry7XrMDrg9q1lX1LroI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752722777; v=1;
 b=OIzzSQDFcTUwI1XlO7ed7lxQuAiIrUsoCnUuBs3Q0Otto5qOxgYMNyHTYYXq/Rd6
 qVAdOh3yD35poxMoZSXBLhRKrwKdnnWRfw4bSZecaJteh0hKs8/G2fSGX2iXQ88k
 TpRLE7F34uEZa6xe47ow/ESLAwtTYFW4mQKmM2BQTKfHyEPw1XwqmbTAC2oNZlhc
 vEH6wBGaIT9tV87ordJCl18YClspkx+ipxJJv2HPi0EB2x81pbEhn3O5y5m1L27L
 08NEk9AKNFlA6qA4n4ekrH5cVjj2bS59SebhxS7QD5WXRr0PzavscHHHfI26rprx
 C7oxFqjz/elo5Z8SVjD77g==
Message-ID: <172e1d7c-e603-46fe-8ce4-fd60f28f6f35@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 17 Jul 2025 12:26:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/23] migration: push Error **errp into
 loadvm_process_enable_colo()
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
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
 <20250717-propagate_tpm_error-v5-16-1f406f88ee65@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250717-propagate_tpm_error-v5-16-1f406f88ee65@redhat.com>
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

On 2025/07/17 9:37, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_process_enable_colo() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   include/migration/colo.h |  2 +-
>   migration/migration.c    | 12 ++++++------
>   migration/ram.c          |  8 ++++----
>   migration/ram.h          |  2 +-
>   migration/savevm.c       | 25 ++++++++++++-------------
>   5 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fcd73287a0e 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
>   bool migration_in_colo_state(void);
>   
>   /* loadvm */
> -int migration_incoming_enable_colo(void);
> +int migration_incoming_enable_colo(Error **errp);
>   void migration_incoming_disable_colo(void);
>   bool migration_incoming_colo_enabled(void);
>   bool migration_incoming_in_colo_state(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25dec01f206eacad2edd24d21f00e614c..326487882c8d41e2f89f99f69df0d9d4d42705e4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
>       migration_colo_enabled = false;
>   }
>   
> -int migration_incoming_enable_colo(void)
> +int migration_incoming_enable_colo(Error **errp)
>   {
>   #ifndef CONFIG_REPLICATION
> -    error_report("ENABLE_COLO command come in migration stream, but the "
> -                 "replication module is not built in");
> +    error_setg(errp, "ENABLE_COLO command come in migration stream, but the "
> +               "replication module is not built in");
>       return -ENOTSUP;
>   #endif
>   
>       if (!migrate_colo()) {
> -        error_report("ENABLE_COLO command come in migration stream, but x-colo "
> -                     "capability is not set");
> +        error_setg(errp, "ENABLE_COLO command come in migration stream"
> +                   ", but x-colo capability is not set");
>           return -EINVAL;
>       }
>   
>       if (ram_block_discard_disable(true)) {
> -        error_report("COLO: cannot disable RAM discard");
> +        error_setg(errp, "COLO: cannot disable RAM discard");
>           return -EBUSY;
>       }
>       migration_colo_enabled = true;
> diff --git a/migration/ram.c b/migration/ram.c
> index 8223183132dc0f558f45fbae3f4f832845730bd3..607c979cc15a3d321e5e3e380ac7613d80d86fc9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)
>    * memory of the secondary VM, it is need to hold the global lock
>    * to call this helper.
>    */
> -int colo_init_ram_cache(void)
> +int colo_init_ram_cache(Error **errp)
>   {
>       RAMBlock *block;
>   
> @@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)
>               block->colo_cache = qemu_anon_ram_alloc(block->used_length,
>                                                       NULL, false, false);
>               if (!block->colo_cache) {
> -                error_report("%s: Can't alloc memory for COLO cache of block %s,"
> -                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
> -                             block->used_length);
> +                error_setg(errp, "%s: Can't alloc memory for COLO cache of "
> +                           "block %s, size 0x" RAM_ADDR_FMT, __func__,
> +                           block->idstr, block->used_length);
>                   RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>                       if (block->colo_cache) {
>                           qemu_anon_ram_free(block->colo_cache, block->used_length);
> diff --git a/migration/ram.h b/migration/ram.h
> index 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6baeea2f0627 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
>                                      bool set);
>   
>   /* ram cache */
> -int colo_init_ram_cache(void);
> +int colo_init_ram_cache(Error **errp);
>   void colo_flush_ram_cache(void);
>   void colo_release_ram_cache(void);
>   void colo_incoming_start_dirty_log(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1cbc44a5314043a403d983511066cf137681a18d..755ba7e4504d377a4649da191ad9875d9fd66f69 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2510,15 +2510,19 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>       return 0;
>   }
>   
> -static int loadvm_process_enable_colo(MigrationIncomingState *mis)
> +static int loadvm_process_enable_colo(MigrationIncomingState *mis,
> +                                      Error **errp)
>   {
> -    int ret = migration_incoming_enable_colo();
> +    int ret;
>   
> -    if (!ret) {
> -        ret = colo_init_ram_cache();
> -        if (ret) {
> -            migration_incoming_disable_colo();
> -        }
> +    if (migration_incoming_enable_colo(errp) < 0) {
> +        return -1;

Returning -1 here while colo_init_ram_cache() returns -errno results in 
an inconsistent semantics of this function's return value.

Ideally, I think this function (and other similar functions) should stop 
returning -errno and instead return a bool value to prevent callers to 
make any assumption based on the return value other than 
success/failure. But that could be done later; let it return -errno 
until then.

