Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC9C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF7rT-0005Ug-T1; Thu, 06 Jun 2024 03:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF7rS-0005U4-Iq
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:48:38 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF7rP-0002Rg-EG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717660116; x=1749196116;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mmoo8koMuTWt5p5Ev7dQQqyehIK8jskOxZcc38HwHAw=;
 b=Tk6PMDjrhOezQswc9szI0m6JL7/up8pAgLXyO8m8oDbTvQq7JGzmL1bM
 3CPou2CGDW8JcqgjPfqLxPiSK7jbOqwR1jjcWhCiqCgwc/oqrb5iPJn0S
 6hcdmElyqtzu1/goashf5ZkhI/Le0W4vqVPZwat95QdIYRsjUHISxT6dJ
 zRMzjUElp42UVAQZ46F7ICJ1AobIzP2GrYPyiuorP+O5zVXfsTYUnqAiy
 nxEcFpUWUQKu5LEvvo7/1T+O0h72U1ycQJdxY2XQpb+9Wr4P9WQvX1i4P
 IZEcW3a2wIQPF/peYVs1MElZYZXm8/O6TXWqB8ckR+yj6YcusXqLzVFFd g==;
X-CSE-ConnectionGUID: xA9Sb49DQPeOzDqRUblsfQ==
X-CSE-MsgGUID: YA0He0jfRUmYhyCAfbJinw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18156028"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="18156028"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 00:48:33 -0700
X-CSE-ConnectionGUID: QCbU2/RVR/ivWyTxrloOnw==
X-CSE-MsgGUID: aRC2u38FRqCXyTwhqOTN5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="37944200"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 06 Jun 2024 00:48:31 -0700
Date: Thu, 6 Jun 2024 16:03:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] stubs/meson: Fix qemuutil build when --disable-system
Message-ID: <ZmFtbTZCPbEldfMC@intel.com>
References: <20240605152549.1795762-1-zhao1.liu@intel.com>
 <a9271307-dee6-43f7-ba96-89d29310e43d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9271307-dee6-43f7-ba96-89d29310e43d@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 06, 2024 at 09:41:47AM +0200, Paolo Bonzini wrote:
> Date: Thu, 6 Jun 2024 09:41:47 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH] stubs/meson: Fix qemuutil build when --disable-system
> 
> On 6/5/24 17:25, Zhao Liu wrote:
> > Compiling without system, user, tools or guest-agent fails with the
> > following error message:
> > 
> > ./configure --disable-system --disable-user --disable-tools \
> > --disable-guest-agent
> > 
> > error message:
> > 
> > /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `error_printf':
> > /media/liuzhao/data/qemu-cook/build/../util/error-report.c:38: undefined reference to `error_vprintf'
> > /usr/bin/ld: libqemuutil.a.p/util_error-report.c.o: in function `vreport':
> > /media/liuzhao/data/qemu-cook/build/../util/error-report.c:215: undefined reference to `error_vprintf'
> > collect2: error: ld returned 1 exit status
> > 
> > This is because tests/bench and tests/unit both need qemuutil, which
> > requires error_vprintf stub when system is disabled.
> > 
> > Add error_vprintf stub into stub_ss for all cases other than disabling
> > system.
> 
> Should be "other than enabled system emulation", but...
> 
> > -if have_ga
> > -  stub_ss.add(files('error-printf.c'))
> > -endif
> > -
> >   if have_block or have_user
> >     stub_ss.add(files('qtest.c'))
> >     stub_ss.add(files('vm-stop.c'))
> >     stub_ss.add(files('vmstate.c'))
> > -
> > -  # more symbols provided by the monitor
> > -  stub_ss.add(files('error-printf.c'))
> >   endif
> 
> ... these should be left in, since it's possible to build with
> --enable-guest-agent --enable-system.
> 
> The best and easiest solution is simply to move error-printf.c to the
> unconditional section at the top of the file.  I queued the patch with that
> change.

Thanks!! I can delete my v2 branch now. :-)


