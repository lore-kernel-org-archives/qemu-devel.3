Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BA2C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFE4A-0001zd-4q; Wed, 14 May 2025 11:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDz7-0000vU-Ul; Wed, 14 May 2025 11:25:38 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFDz4-0008Un-Ng; Wed, 14 May 2025 11:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747236326; x=1778772326;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ThBSYUvZ/XFGiiD4RABQ4r41Ig4HRacFIVGrlo60hFA=;
 b=du19S7cKvtYSIdS7jNOuD7watvtUrtMw71ZiCUQ5lLGnCtoe4ivYerVS
 D1Uwt/ODo7cQoDz2phx+oHFXTFwFQLxHeZ7W/hjVd0w4qvtpB4XgKUIMY
 yol8kKtvtylqWyBVgUpsQ/Y6XwU4hYZDRMZFUsWvMP+hgcHphGW93nASG
 JW0HVR3H4lhvtrIcvmr8eLhkd8Kv5XkWQ945yfkKJVWnIekd2XFeo2GeU
 cxa8hm5uf6O1e4BjioyoY2rLHPIfz3SiudzuVYngwxYx3ar1/sEpHESCP
 qKWeSSiXHJu/TzEGfmiBCuZQf/o8qJ5bE+bGhhM7eJcurqOgpt+pfW2f5 w==;
X-CSE-ConnectionGUID: TSiOSmtASQalooKNknahFw==
X-CSE-MsgGUID: GUMaQocqTMu/XSXZLapbGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66694050"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="66694050"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 08:25:24 -0700
X-CSE-ConnectionGUID: OKPjvWWoTPyP9Up68FI36g==
X-CSE-MsgGUID: vgqUiby3SQig+cuf6cDfEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="142101402"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 14 May 2025 08:25:22 -0700
Date: Wed, 14 May 2025 23:46:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?utf-8?B?TWFyYy1BbmRy77+9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 4/9] hw/char/sh_serial: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Message-ID: <aCS60tfK6hEh3n25@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-5-zhao1.liu@intel.com>
 <f8d5d5ac-9b79-ab87-6fd7-ac7bf025c3e7@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d5d5ac-9b79-ab87-6fd7-ac7bf025c3e7@eik.bme.hu>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, May 14, 2025 at 02:07:41PM +0200, BALATON Zoltan wrote:
> Date: Wed, 14 May 2025 14:07:41 +0200
> From: BALATON Zoltan <balaton@eik.bme.hu>
> Subject: Re: [PATCH 4/9] hw/char/sh_serial: Consolidate
>  OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
> 
> On Wed, 14 May 2025, Zhao Liu wrote:
> > The QOM type of SHSerialState is declared by OBJECT_DECLARE_SIMPLE_TYPE,
> > which means it doesn't need the class!
> > 
> > Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
> 
> Patch uses OBJECT_DEFINE_SIMPLE_TYPE not
> OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES so change commit message to match
> the patch.

Good catch! Thanks!

Regards,
Zhao


