Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D464CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkbS-00089v-Go; Tue, 28 Oct 2025 10:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDkbP-00089N-ID
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:23:13 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDkbG-0002Cz-QP
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:23:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AC6A9C01F7;
 Tue, 28 Oct 2025 17:22:53 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:582::1:19] (unknown
 [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pMexjm1LwiE0-mBHRlVr3; Tue, 28 Oct 2025 17:22:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761661373;
 bh=3we8w3wzqk0+JvVJJwv2aPYCYRcCXWPRAryMSlqEja4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=LUSTge3z659IVPH+izutXtkwohBhHXGOGTdJXGD7ySw0CM0NoIJScjSeknBr7QyE/
 ROZWJ0vP95rCZfuL4+1goubGD9dl2HhBPLZAyBZidpU36MyC9V7be02qrntKByL8Ix
 hcao7l8D0HvospfGq6vr2CSAXiPJruUXOwH5Nh4s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <40c2af51-c6ec-45eb-8139-9dafc36396e6@yandex-team.ru>
Date: Tue, 28 Oct 2025 17:22:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] migration: Pass in bql_held information from
 qemu_loadvm_state()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-8-peterx@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251022192612.2737648-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 22.10.25 22:26, Peter Xu wrote:
> Teach qemu_loadvm_state() and some of the internal functions to know
> whether we're holding BQL or not.

Actually, this commit does more: not only pass the bql_held information,
but also by introduce some WITH_BQL_HELD() sections.

IMHO it could be split:

1. only add bql_held parameters, which are used only to passthorough to
called functions. That's just to simplify further commits. Make the
information available. At this commit, we only need to check, that
passed information is correct (is it really held, may be add some
comments/assertions to make it obvious)

2. one or more commits, which prepares different functions to be called
in thread: support bql_held=false by introducing WITH_BQL_HELD() sections.
In such commit, we should lookthorgh the whole function and check that it
actually prepared to be called from thread.


Hmm, or without [1.], there may be several commits to prepare different
functions. Or maybe, even one commit as it is, but change commit subject
and message somehow, to reflect all the changes..

> 
> So far, all the callers still always pass in TRUE, hence no functional
> change expected.  But it may change in the near future.
> 
> To reviewers: even if this is not functional change yet, it'll be the major
> core functional change after we switch to threadified loadvm soon.  Please
> Treat it as one to add explicit code to mark out which part of incoming
> live migration would need to be executed always with the BQL, or would need
> to be run always without BQL.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

[..]

> diff --git a/migration/colo.c b/migration/colo.c
> index db783f6fa7..4fd586951a 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -686,7 +686,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>   
>       bql_lock();
>       cpu_synchronize_all_states();
> -    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
> +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, true, errp);

That one is obvious..

>       bql_unlock();
>   
>       if (ret < 0) {
> diff --git a/migration/migration.c b/migration/migration.c
> index 4ed2a2e881..38a584afae 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -878,7 +878,7 @@ process_incoming_migration_co(void *opaque)
>                         MIGRATION_STATUS_ACTIVE);
>   
>       mis->loadvm_co = qemu_coroutine_self();
> -    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> +    ret = qemu_loadvm_state(mis->from_src_file, true, &local_err);

Here, why are we sure? Are coroutines triggered by QMP command always run under BQL?

Maybe, worth an assertion.

>       mis->loadvm_co = NULL;
>   
>       trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 232cae090b..44aadc2f51 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -154,11 +154,12 @@ static void qemu_loadvm_thread_pool_destroy(MigrationIncomingState *mis)
>   }
>   
>   static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
> -                                         MigrationIncomingState *mis)
> +                                         MigrationIncomingState *mis,
> +                                         bool bql_held)
>   {
> -    bql_unlock(); /* Let load threads do work requiring BQL */
> -    thread_pool_wait(mis->load_threads);
> -    bql_lock();
> +    WITH_BQL_RELEASED(bql_held) {
> +        thread_pool_wait(mis->load_threads);
> +    }
>   
>       return !migrate_has_error(s);

The function is now prepared to be called from thread, as migrate_has_error() has own mutex.

>   }
> @@ -2117,7 +2118,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       qemu_file_set_blocking(f, true, &error_fatal);
>   
>       /* TODO: sanity check that only postcopiable data will be loaded here */
> -    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> +    load_res = qemu_loadvm_state_main(f, mis, true, &local_err);

Is it correct? I see, a bit later, postcopy_ram_listen_thread() does

     bql_lock();
     migration_incoming_state_destroy();
     bql_unlock();

so, I assume, that before this, when we call qemu_loadvm_state_main(), BQL is not actually locked?

>   
>       /*
>        * This is tricky, but, mis->from_src_file can change after it
> @@ -2420,7 +2421,8 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>    * Returns: Negative values on error
>    *
>    */
> -static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
> +static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
> +                                      bool bql_held, Error **errp)
>   {
>       int ret;

[..]

-- 
Best regards,
Vladimir

