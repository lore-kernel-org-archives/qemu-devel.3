Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29F1C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 03:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1renxa-0007sZ-Ij; Mon, 26 Feb 2024 22:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1renxZ-0007sP-Hk
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 22:16:49 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei4.wang@intel.com>)
 id 1renxX-0002lA-0B
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 22:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709003807; x=1740539807;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qcPf2j6txC4wMHLDDPbqZJqXdwBXT1F+/Dc6SYcmGYw=;
 b=igp0oZSZDfL8+GU+HQSKCfBArPIFowUNmVbRQ5HrBup3JopQgcoaPiRb
 ZAqu6XyCfcVxSqAXdyADQx9CKsorpLvs+H0BTVe9SWTeetHe6l8YpbZkz
 8+dqgDmq6Qu3At0qHONQhJHu6n+dsWgd2H9ANLRxdAdStD997ObgD8Oro
 OswvF7ofnhmXOD1mYRXOO1+ozDaVviK6I6NKNdi4VYdKgOfyO/UJ49lSU
 rKGJTsKKesGckJUQsNvO8eVCsFpd3KP2y7ZUJZ5li1SvKaGjRllhbSLbF
 OymCLZJ1BXEu2TFX8NwmP6Yca8r43GzZLatRnaP8KDLGCmS3I4uP9utUG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7142341"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7142341"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 19:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="30062086"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.124.244.145])
 ([10.124.244.145])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 19:16:41 -0800
Message-ID: <6fa132c5-8ed8-41a6-a70d-90230ce3ca84@intel.com>
Date: Tue, 27 Feb 2024 11:16:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20240222155627.14563-1-avihaih@nvidia.com>
From: "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <20240222155627.14563-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=lei4.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/22/2024 23:56, Avihai Horon wrote:
> Currently, migration code serializes device data sending during pre-copy
> iterative phase. As noted in the code comment, this is done to prevent
> faster changing device from sending its data over and over.
> 
> However, with switchover-ack capability enabled, this behavior can be
> problematic and may prevent migration from converging. The problem lies
> in the fact that an earlier device may never finish sending its data and
> thus block other devices from sending theirs.
> 
> This bug was observed in several VFIO migration scenarios where some
> workload on the VM prevented RAM from ever reaching a hard zero, not
> allowing VFIO initial pre-copy data to be sent, and thus destination
> could not ack switchover. Note that the same scenario, but without
> switchover-ack, would converge.
> 
> Fix it by not serializing device data sending during pre-copy iterative
> phase if switchover was not acked yet.

Hi Avihai,

Can this bug be solved by ordering the priority of different device's handlers?

> 
> Fixes: 1b4adb10f898 ("migration: Implement switchover ack logic")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  migration/savevm.h    |  2 +-
>  migration/migration.c |  4 ++--
>  migration/savevm.c    | 22 +++++++++++++++-------
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 74669733dd6..d4a368b522b 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -36,7 +36,7 @@ void qemu_savevm_state_setup(QEMUFile *f);
>  bool qemu_savevm_state_guest_unplug_pending(void);
>  int qemu_savevm_state_resume_prepare(MigrationState *s);
>  void qemu_savevm_state_header(QEMUFile *f);
> -int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> +int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
> diff --git a/migration/migration.c b/migration/migration.c
> index ab21de2cadb..d8bfe1fb1b9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3133,7 +3133,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      }
>  
>      /* Just another iteration step */
> -    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy);
> +    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy, can_switchover);
>      return MIG_ITERATE_RESUME;
>  }
>  
> @@ -3216,7 +3216,7 @@ static MigIterateState bg_migration_iteration_run(MigrationState *s)
>  {
>      int res;
>  
> -    res = qemu_savevm_state_iterate(s->to_dst_file, false);
> +    res = qemu_savevm_state_iterate(s->to_dst_file, false, true);
>      if (res > 0) {
>          bg_migration_completion(s);
>          return MIG_ITERATE_BREAK;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d612c8a9020..3a012796375 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1386,7 +1386,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>   *   0 : We haven't finished, caller have to go again
>   *   1 : We have finished, we can go to complete phase
>   */
> -int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
> +int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover)
>  {
>      SaveStateEntry *se;
>      int ret = 1;
> @@ -1430,12 +1430,20 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>                           "%d(%s): %d",
>                           se->section_id, se->idstr, ret);
>              qemu_file_set_error(f, ret);
> +            return ret;
>          }
> -        if (ret <= 0) {
> -            /* Do not proceed to the next vmstate before this one reported
> -               completion of the current stage. This serializes the migration
> -               and reduces the probability that a faster changing state is
> -               synchronized over and over again. */
> +
> +        if (ret == 0 && can_switchover) {
> +            /*
> +             * Do not proceed to the next vmstate before this one reported
> +             * completion of the current stage. This serializes the migration
> +             * and reduces the probability that a faster changing state is
> +             * synchronized over and over again.
> +             * Do it only if migration can switchover. If migration can't
> +             * switchover yet, do proceed to let other devices send their data
> +             * too, as this may be required for switchover to be acked and
> +             * migration to converge.
> +             */
>              break;
>          }
>      }
> @@ -1724,7 +1732,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>      qemu_savevm_state_setup(f);
>  
>      while (qemu_file_get_error(f) == 0) {
> -        if (qemu_savevm_state_iterate(f, false) > 0) {
> +        if (qemu_savevm_state_iterate(f, false, true) > 0) {
>              break;
>          }
>      }

