Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC14C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFOU-0003up-2Q; Wed, 16 Jul 2025 23:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ucFOO-0003nZ-Ev; Wed, 16 Jul 2025 23:34:46 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ucFOL-0007p6-Ll; Wed, 16 Jul 2025 23:34:43 -0400
Received: from [10.160.60.105] (p7852202-ipoefx.ipoe.ocn.ne.jp
 [123.225.53.201]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56H3YLUQ077978
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 17 Jul 2025 12:34:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ysEhbl9MT9V7zfnzi1fSBIITqXqE3U1zCQftwAh0D+Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752723262; v=1;
 b=OpMccscIZqFSZSxpbtkosxmFyK4UeSih5SE3pw3FMHHkpJlycKOITFtEtTwunqHv
 cfF86nZZIMr86O5iG14Z4TDnLtFzKGkdsDQVokrTdsDjS1Ni3etzOSk8SH8Ejj+b
 otxBFbYDqeQ21X2xnvXAkk6nLGI8Gdx7BgCxIaTqZKZa+KsWPaV4GII799B4Z0wC
 Qv8bzT1fmod7PKTLG9CDKwPDC52tgXFKXZhvdXTkPmhvzD/CYRxmgLuCmywJhEeL
 04IobVN1MXErMNFNmd+elrN8MXeQlSsYztclzquY56ZeMk9OkZ8LPV654V5sdBGq
 zi4M+2UZEkAq7SVoUXav5w==
Message-ID: <c535b2b0-78d6-4afa-bd6a-d11159d3a952@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 17 Jul 2025 12:34:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/23] migration: push Error **errp into
 ram_postcopy_incoming_init()
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
 <20250717-propagate_tpm_error-v5-9-1f406f88ee65@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250717-propagate_tpm_error-v5-9-1f406f88ee65@redhat.com>
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
> It is ensured that ram_postcopy_incoming_init() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/postcopy-ram.c | 9 ++++++---
>   migration/postcopy-ram.h | 2 +-
>   migration/ram.c          | 6 +++---
>   migration/ram.h          | 2 +-
>   migration/savevm.c       | 2 +-
>   5 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a316baf1e4 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -681,6 +681,7 @@ out:
>    */
>   static int init_range(RAMBlock *rb, void *opaque)
>   {
> +    Error **errp = opaque;
>       const char *block_name = qemu_ram_get_idstr(rb);
>       void *host_addr = qemu_ram_get_host_addr(rb);
>       ram_addr_t offset = qemu_ram_get_offset(rb);
> @@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
>        * (Precopy will just overwrite this data, so doesn't need the discard)
>        */
>       if (ram_discard_range(block_name, 0, length)) {
> +        error_setg(errp, "failed to discard RAM block %s len=%zu",
> +                   block_name, length);
>           return -1;
>       }
>   
> @@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
>    * postcopy later; must be called prior to any precopy.
>    * called from arch_init's similarly named ram_postcopy_incoming_init
>    */
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
>   {
> -    if (foreach_not_ignored_block(init_range, NULL)) {
> +    if (foreach_not_ignored_block(init_range, errp)) {
>           return -1;
>       }
>   
> @@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
>       return false;
>   }
>   
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)
>   {
>       error_report("postcopy_ram_incoming_init: No OS support");
>       return -1;
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c58a9a4f48 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis);
>    * postcopy later; must be called prior to any precopy.
>    * called from ram.c's similarly named ram_postcopy_incoming_init
>    */
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis);
> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);
>   
>   /*
>    * At the end of a migration where postcopy_ram_incoming_init was called.
> diff --git a/migration/ram.c b/migration/ram.c
> index 7208bc114fb5c366740db380ee6956a91b3871a0..8223183132dc0f558f45fbae3f4f832845730bd3 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3708,7 +3708,7 @@ static int ram_load_cleanup(void *opaque)
>   /**
>    * ram_postcopy_incoming_init: allocate postcopy data structures
>    *
> - * Returns 0 for success and negative if there was one error
> + * Returns 0 for success and -1 if there was one error

This is true but not relevant in this patch's goal.

Besides, I'm not in favor of letting callers make an assumption on 
integer return values (i.e., let callers assume a particular integer 
value in the error conditions). It is subtle to make a mistake to return 
-errno while the documentation says it returns -1.

I think a proper way to avoid bugs due to return values here is to 
change the type to bool, which ensures there are two possible values; 
that is a nice improvement but something that can be done later.

>    *
>    * @mis: current migration incoming state
>    *
> @@ -3716,9 +3716,9 @@ static int ram_load_cleanup(void *opaque)
>    * postcopy-ram. postcopy-ram's similarly names
>    * postcopy_ram_incoming_init does the work.
>    */
> -int ram_postcopy_incoming_init(MigrationIncomingState *mis)
> +int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp)
>   {
> -    return postcopy_ram_incoming_init(mis);
> +    return postcopy_ram_incoming_init(mis, errp);
>   }
>   
>   /**
> diff --git a/migration/ram.h b/migration/ram.h
> index 921c39a2c5c45bc2344be80854c46e4c10c09aeb..275709a99187f9429ccb4111e05281ec268ba0db 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -86,7 +86,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms);
>   void ram_postcopy_send_discard_bitmap(MigrationState *ms);
>   /* For incoming postcopy discard */
>   int ram_discard_range(const char *block_name, uint64_t start, size_t length);
> -int ram_postcopy_incoming_init(MigrationIncomingState *mis);
> +int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
>   int ram_load_postcopy(QEMUFile *f, int channel);
>   
>   void ram_handle_zero(void *host, uint64_t size);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d1edeaac5f2a5df2f6d94357388be807a938b2ef..8eba151a693b7f2dc58853292c92024288eae81e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1983,7 +1983,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>           return -1;
>       }
>   
> -    if (ram_postcopy_incoming_init(mis)) {
> +    if (ram_postcopy_incoming_init(mis, NULL)) {
>           return -1;
>       }
>   
> 


