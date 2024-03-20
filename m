Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125ABCD11DC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqo0-0004Cz-LR; Wed, 20 Mar 2024 03:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmqnz-0004Cj-9w
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:56:11 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1rmqnt-00043I-D5
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710921365; x=1742457365;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7PnlrVeRUkZmaEp989dK3yBBozkUUu5OWUvh3k472iE=;
 b=bUwz/xC5D4RDFw53I1HiVZyPgdhjCUjI+/T6YRL0IeQc+LnTFp2YqU0r
 ns301DTeW7dKTGRSIUEdGeQ4Nk6geLb6mRx1wqTkC6bUXOZUSMUiTHuVP
 MpjYA7yl2TgqufSQn5c6Q75B/8p3+jMK/T9pv6BOQeg7/4u6Dujco7KCp
 fWFNB2qZZ3byik4Q8EIaJoL+bzIAvDfa4WwkApD1Tvn5gkCkyLMCwzwar
 NVG9iwp5j5Z3BZeSXC37hlD9uqhUzUM58OwduSoQfYFGkCBNAXlwjvdvO
 XWeMZ/b3k7Do5r00gKh0GeZeElsWAHotKeo9D/o9tDwEmk0s9o3phJzDs Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5666333"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5666333"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 00:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="14046832"
Received: from linux.bj.intel.com ([10.238.157.71])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 00:55:51 -0700
Date: Wed, 20 Mar 2024 15:53:04 +0800
From: Tao Su <tao1.su@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, xiaoyao.li@intel.com, alex.bennee@linaro.org
Subject: Re: [PATCH] target/i386: Check NULL monitor pointer when injecting MCE
Message-ID: <ZfqV4BBkfN4IcPfK@linux.bj.intel.com>
References: <20240320052118.520378-1-tao1.su@linux.intel.com>
 <87le6dwid5.fsf@pond.sub.org>
 <740bcdb9-4a5e-4510-a0b4-0121608f5ab3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <740bcdb9-4a5e-4510-a0b4-0121608f5ab3@linaro.org>
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

On Wed, Mar 20, 2024 at 08:17:36AM +0100, Philippe Mathieu-Daudé wrote:
> Hi Tao,
> 
> On 20/3/24 07:02, Markus Armbruster wrote:
> > Tao Su <tao1.su@linux.intel.com> writes:
> > 
> > > monitor_puts() doesn't check the monitor pointer, but do_inject_x86_mce()
> > > may have a parameter with NULL monitor pointer. Check the monitor pointer
> > > before calling monitor_puts().
> > > 
> > > Fixes: bf0c50d4aa85 (monitor: expose monitor_puts to rest of code)
> > > Reviwed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> > > ---
> > >   target/i386/helper.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/target/i386/helper.c b/target/i386/helper.c
> > > index 2070dd0dda..a9ff830a17 100644
> > > --- a/target/i386/helper.c
> > > +++ b/target/i386/helper.c
> > > @@ -430,7 +430,8 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
> > >           if (need_reset) {
> > >               emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
> > >                                         recursive);
> > > -            monitor_puts(params->mon, msg);
> > > +            if (params->mon)
> 
> Missing braces, see QEMU coding style:
> https://www.qemu.org/docs/master/devel/style.html#block-structure

Yes, I prefer to revert the broken part.

Anyway, I got this point and will always pay attention to it, thanks for
reminding.

> 
> > > +                monitor_puts(params->mon, msg);
> > >               qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
> > >               qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > >               return;
> > 
> > Could instead revert the broken part of commit bf0c50d4aa85:
> > 
> >    -            monitor_puts(params->mon, msg);
> >    +            monitor_printf(params->mon, "%s", msg);
> >                 qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
> > 
> > Then the fact that we send the same message to monitor and log is again
> > more obvious.
> > 
> > Either way:
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > 
> > 
> 

