Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64896FD2D91
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxd1-0000B6-JF; Tue, 10 Mar 2026 10:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxcz-0000Ak-Jk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:00:05 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxcy-0001bT-0T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773151204; x=1804687204;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IGJnw8s99+s8S95BxkM4BNanYYc8lhhsFrOSNQ3TIpE=;
 b=oKAzGtXsTi4RdxqbmgJgMbc2bXmMyOJznS18XFSdkACu6o1ajBiv4sbW
 kyPULF/NGQ5D4r4A9/wnEEqPAELqJrnTQPf1Uw/1CG1o2lIqLw4jSLc98
 zvYizF1ej+JuClx9xLtSoU4pR72mTqMRsoOhPaO235kSzQP2SnwwWCz6R
 l4qJOa8u2eLgyDIEErY4+hPNELW/vYO+nxraqQJbicqgYmB7Ss7qMqC6g
 ZDd2VdiLOkLK1BXT3Ukyzq/+copj3rkFLEwTSGnrvjR46S4M5tg9JUj7+
 XMijmMtwzDkzlFxQQeauxx+7jURUxuEaj50uHjFIifUKyWe+NjOyg9fLg g==;
X-CSE-ConnectionGUID: iFgLWJP4RFGlez1rKw1YDA==
X-CSE-MsgGUID: +WtX68WOT7W4fH7DzZMkRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85287324"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="85287324"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:00:02 -0700
X-CSE-ConnectionGUID: cwyfQFj8Sr6GJa/nfGBYjA==
X-CSE-MsgGUID: LeqLtg7/Rymbgs6uRs7uHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="225062285"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 10 Mar 2026 06:59:59 -0700
Date: Tue, 10 Mar 2026 22:26:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <graf@amazon.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: Re: [PATCH v2 03/10] hw/i386/x86: Remove @pvh_enabled argument in
 x86_load_linux()
Message-ID: <abAqAP5aaUsJUdyV@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-4-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On Mon, Mar 09, 2026 at 03:50:05PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:05 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 03/10] hw/i386/x86: Remove @pvh_enabled argument in
>  x86_load_linux()
> X-Mailer: git-send-email 2.53.0
> 
> x86_load_linux()'s @pvh_enabled is now always %true: remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20260307152635.83893-4-philmd@linaro.org>
> ---
>  include/hw/i386/microvm.h | 2 +-
>  include/hw/i386/x86.h     | 3 +--
>  hw/i386/microvm.c         | 2 +-
>  hw/i386/nitro_enclave.c   | 2 +-
>  hw/i386/pc.c              | 4 ++--
>  hw/i386/x86-common.c      | 3 +--
>  6 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


