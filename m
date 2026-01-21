Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB89C44525
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXtv-0006vT-8F; Wed, 21 Jan 2026 08:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXtr-0006td-Qa
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:05:31 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1viXtm-0005Qa-Bx
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769000726; x=1800536726;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HcPdLMmqmzJhocHKNIBLY++HkHtBNmBg7ubrF2kJ9Zs=;
 b=AoaNi8J+nTKMmiRP2pX1CgTrrw3q/ULlCj6fBIqJBcv3Nhbn3ipGSSiw
 KPNcO0LZVayMh+HMmnr/4sHCZMUoEtYlLKlTHT+GThSpIg/q1mLLDqBlU
 2/UlK0PswKaC8tIYGUF6BKeut36oMlXJ1ZzuPvUXhb9WsI0+jG+c+IVXt
 mPJrAxtcEjBDHjcYuQvL6c++tzdYpYYSfx0cVh0oMYhYWoMxf2wEyvn6P
 d/jB4XFpw11hqd+wCgZtqSANxZl9JtDeHAn8bM5gtBwfGezO5ue4Tz4ae
 vBZ58EWfiwrnQySLGpS0UODmlzyY82/zKMZZj6CWM6KBj/ILlPY6FxtXE A==;
X-CSE-ConnectionGUID: p/nYVw0hS8KFIydZYEa/Yw==
X-CSE-MsgGUID: 9mHX/7JYQIGpI/ahXlCpuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80853318"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="80853318"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 05:05:25 -0800
X-CSE-ConnectionGUID: THbKd6MhRA+G6eaUPXLLKw==
X-CSE-MsgGUID: VZ5AvJ+mQ4ucs0Qfk/aGzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206358813"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2026 05:05:23 -0800
Date: Wed, 21 Jan 2026 21:30:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH v2] tests/functional/x86_64: Limit the memlock test to
 Linux hosts
Message-ID: <aXDVD3YCN1U8Ey3c@intel.com>
References: <20260121111140.99482-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121111140.99482-1-thuth@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Jan 21, 2026 at 12:11:40PM +0100, Thomas Huth wrote:
> Date: Wed, 21 Jan 2026 12:11:40 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH v2] tests/functional/x86_64: Limit the memlock test to
>  Linux hosts
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> The memlock test analyzes /proc/*/status files and expects the layout
> from Linux in there. However, these files also exist on NetBSD hosts
> with a completely different layout, causing this test to fail. Thus
> limit the test to Linux hosts now. We already have a decorator to
> skip a test if it is running on a certain host system, but in this
> case, we rather want to skip if we are not running on a specific
> host system, so introduce a new @skipUnlessOperatingSystem decorator
> for this job.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Check via a decorator, not via meson.build file

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


