Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EF1C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqfp-0001M1-On; Wed, 20 Mar 2024 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmqfn-0001KN-Ey
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:47:43 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmqfj-00018d-Ev
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710920859; x=1742456859;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KAzBtWUPLMWo3A0VWruC2KAAnRAzfB4DTtjDm5gFQi8=;
 b=Nm6D4VNTRS1dr+LmhRQAdg5MNwqo3bMLAGb/E4aV91Oe8HTOyVq9T12+
 B7u3aVVCC7ZVdeOl57lbP6RKGlsoqKgrT4mgaldPR/C5mxVpNWEtiylex
 SStlOcc69rrRU+Y+GY0I5Zr2CGAhrn6hJ43v1YC7jf/FGuaf+oryMuuTk
 kpW8g8qomFkJRuf9i+yISg6hKvFOw/oP//H0o851GoyYLXEfWYDoU8H4S
 8Q7ZgJnO3sFZKMltOk1kC7/3Rkfa8I2ySdQq6k2ydI7E6+EklVPKty6z3
 w6/i/QXrHDWnl4z3Jo71FbKF8mdIYd2kpS6G0GIqD4e29nTtbeaXSXhzo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5665198"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5665198"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 00:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="18534572"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 00:47:34 -0700
Date: Wed, 20 Mar 2024 15:44:43 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 alex.bennee@linaro.org
Subject: Re: [PATCH] target/i386: Check NULL monitor pointer when injecting MCE
Message-ID: <ZfqT6zm7Z7m7GFSj@linux.bj.intel.com>
References: <20240320052118.520378-1-tao1.su@linux.intel.com>
 <87le6dwid5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le6dwid5.fsf@pond.sub.org>
Received-SPF: none client-ip=192.198.163.18;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 07:02:46AM +0100, Markus Armbruster wrote:
> Tao Su <tao1.su@linux.intel.com> writes:
> 
> > monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
> > may have a parameter with NULL monitor pointer. Check the monitor pointer
> > before calling monitor_puts().
> >
> > Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
> > Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > ---
> >  target/i386/helper.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/helper.c b/target/i386/helper.c
> > index 2070dd0dda..a9ff830a17 100644
> > --- a/target/i386/helper.c
> > +++ b/target/i386/helper.c
> > @@ -430,7 +430,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
> >          if (need_reset) {
> >              emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
> >                                        recursive);
> > -            monitor_puts(params->mon, msg);
> > +            if (params->mon)
> > +                monitor_puts(params->mon, msg);
> >              qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
> >              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >              return;
> 
> Could instead revert the broken part of commit bf0c50d4aa85:
> 
>   -            monitor_puts(params->mon, msg);
>   +            monitor_printf(params->mon, "%s", msg);
>                qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
> 
> Then the fact that we send the same message to monitor and log is again
> more obvious.

Good suggestion. I will send a v2 with this change.

> 
> Either way:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks for review!

> 

