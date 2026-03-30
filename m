Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC4AFF493A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w74ud-00027Q-KO; Mon, 30 Mar 2026 01:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w74uL-00026p-Nm
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:11:27 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w74uJ-0002tK-VZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774847484; x=1806383484;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dmwMMcDYcAa6hBKkGozfmUQZoylD24wVipEXWxaZ6ok=;
 b=e7pp2UT1Umkv4n9hqQnQoYt8HAOHvKfOtUfoF3BdrzCQ/m5HCKoJUBm/
 Pze2vrLjE9hoo003KUR8IrXeBp4tZfoCyik8ou3CPhKYPFxSgCKyPgI+G
 Jq6ykWuMa8zwr8DKmoMoeGkOnLPrwxEQSFxwX9IZJSS1NCA58J6f0KDre
 eWY+3E9xwSl+DXLez2BkXtcK0CD5F7VxUoLZbnIZgUo8NiaoW+v7U+h1p
 sfiBnNIjdSIuNcMFp/zPNsjDip7W1sPRo0+xPc8Kwoarj9aGSO4qHrF8n
 Y2HUhg/sOIt7QZMGWxF9Ri0a2EAWflQj9i1tw7ju6x//2nD9G8ipll/re g==;
X-CSE-ConnectionGUID: 5REGrfiNTWOUQzRnqYNOhw==
X-CSE-MsgGUID: Fwmu/T6nSdmbqRw1lTqriQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75009526"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="75009526"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 22:11:22 -0700
X-CSE-ConnectionGUID: eJcbkJTGTS2F1zgeKBAwig==
X-CSE-MsgGUID: b377fU6ZRwW88yRSm8ZC/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="227563613"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 29 Mar 2026 22:11:20 -0700
Date: Mon, 30 Mar 2026 13:37:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 04/41] pc: Start with modern CPU hotplug interface by
 default
Message-ID: <acoMIqS7lT2yZNhT@intel.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-5-pbonzini@redhat.com>
 <CAFEAcA-O4g5ZrRdK1s5kBjMfRbWhPnD0hLZwhpVHVHVbE7LKdQ@mail.gmail.com>
 <abjXUtJNrcmSFUP4@intel.com>
 <CAFEAcA8FJz1WgKxU_VMc_MVGgAWk5iy2=S67SFsUSPKh1yiE8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8FJz1WgKxU_VMc_MVGgAWk5iy2=S67SFsUSPKh1yiE8A@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Mar 29, 2026 at 01:35:15PM +0100, Peter Maydell wrote:
> Date: Sun, 29 Mar 2026 13:35:15 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [PULL 04/41] pc: Start with modern CPU hotplug interface by
>  default
> 
> On Tue, 17 Mar 2026 at 03:57, Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > +Philippe & Aurelien
> >
> > (And seeking Igor's input)
> >
> > > The problem is that the vmstate_cpu_hotplug VMStateDescription
> > > that is being used has a NULL "fields" (it is the "stub" one).
> > > This used to be OK because the "piix4_pm/cpuhp" vmstate had
> > > a "needed" function that would return false for Malta, so we
> > > never tried to use the stub code.
> > >
> > > What's the intention here ? Shouldn't we still have a "needed"
> > > function that returns "false" for the cases where we would be
> > > using the stub version of vmstate_cpu_hotplug ? Otherwise we
> > > would be changing the migration data. We can permit a compat
> > > break for MIPS boards, but the commit message suggests that
> > > this wasn't intended to be a compat break.
> >
> > Thanks, this is my bad - I didn't realize it would break Malta. The
> > "needed" method looks necessary, but previously making the "stub" one
> > depend on cpu_hotplug_legacy=true also sounds a bit not proper.
> >
> > Maybe in the needed() method we should also check whether the board/
> > machine supports CPU hotplug: check mc->has_hotpluggable_cpus. IIUC,
> > Malta doesn't support this.
> >
> > > In this thread Fabiano suggests a fix which is probably OK
> > > if we want to take the "break migration compat" route:
> > > https://lore.kernel.org/qemu-devel/CAFEAcA9BzSp9F8yv4eZv5eeUM4JXSy9T-QnRr_UbJZpNmhtHyw@mail.gmail.com/T/#m6f4a672ddfa8a0a34dfdf9b57bb04e529ab5c9a4
> >
> > I think Fabiano's patch is a clean solution. Or I think there's another
> > option: we can bring needed() back but check mc->has_hotpluggable_cpus
> > instead, like acpi-ged/cpuhp did ().
> >
> > Igor, what do you think?
> 
> Hi, what's the plan here ? We need to fix this before 11.0
> releases. Are you going to send your proposed ich9.c fix
> as a proper patch ?

Hi Peter,

Now I post a patch here:

https://lore.kernel.org/qemu-devel/20260330053008.2721532-1-zhao1.liu@intel.com

Thanks,
Zhao


