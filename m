Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170E2C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFCQ-0003Fw-BU; Thu, 03 Jul 2025 04:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFCK-0003DD-Jw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:21:36 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFCI-0003wF-W8
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751530895; x=1783066895;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=jVUXjMb7kRtNiepQR/ImXR4huaPt7WQgGicc8HW7yl0=;
 b=H7DXxlfC4+YX1nQRq5ZgcsPh17ywImhLUHgt4v3X1T2917SFILDRh5Gc
 opteBdtXtJ9EKecudHqNxMz0K8ncDFQSZWex5UnqY9QfZpY847tKJGJLh
 Y/JpHGfAyrACGV9nzkkvdvvxUkpoKP6b14Jg/Lnbx+SzTt9zi2Vd6v3si
 AX99LzrLdmE8aPc4mzJVGOU6+zziQnVORHY3ldUDesKbkYdcUpQ5uWsV3
 JaUgRlCtTQo5qY5YUw9LcX5iaUZYU9MxWil5T3vHkGtuUYiOZ0cqbnkHp
 ZCXtAIWdt0i8xywftnG6ex8xK6ut4F8twQYe84x8yGEbA8TDBkbWrpul3 w==;
X-CSE-ConnectionGUID: YAqu9hUPSxeHQioQFpnaFg==
X-CSE-MsgGUID: LTZCK6UnTcyKJa93UK2cJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64897638"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="64897638"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:21:33 -0700
X-CSE-ConnectionGUID: WZp2ts+OSgGhnj+ngACLrA==
X-CSE-MsgGUID: Ozl/wDxITiag2bdPBkJcdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="154873949"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 01:21:31 -0700
Date: Thu, 3 Jul 2025 16:42:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 23/65] accel/system: Introduce @x-accel-stats QMP
 command
Message-ID: <aGZCkM7LKEi4VGUi@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-24-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-24-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

On Wed, Jul 02, 2025 at 08:52:45PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  2 Jul 2025 20:52:45 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 23/65] accel/system: Introduce @x-accel-stats QMP command
> X-Mailer: git-send-email 2.49.0
> 
> Unstable QMP 'x-accel-stats' dispatches to the
> AccelOpsClass::get_stats() and get_vcpu_stats() handlers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  qapi/accelerator.json      | 17 +++++++++++++++++
>  include/qemu/accel.h       |  2 ++
>  include/system/accel-ops.h |  3 +++
>  accel/accel-qmp.c          | 34 ++++++++++++++++++++++++++++++++++
>  accel/accel-system.c       |  1 +
>  accel/meson.build          |  2 +-
>  6 files changed, 58 insertions(+), 1 deletion(-)
>  create mode 100644 accel/accel-qmp.c

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


