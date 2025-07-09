Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA79C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZWNF-00032d-Ll; Wed, 09 Jul 2025 11:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZWKH-00080d-Ot; Wed, 09 Jul 2025 11:03:14 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZWKF-0006nn-6i; Wed, 09 Jul 2025 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752073391; x=1783609391;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=RuK/7oDKhoPhxVyY3ucbYaeqSF7K9KntfsU5n0OHoYI=;
 b=hAlBCnruXFxcmYkho5kBAW87O6UZDx8ojwOjaf5no0c7hNE/dQwzu8yr
 YccuUBQ+qvT46gzk/6PKtZA6KYi2bl1QKclempfugcBNpZEzahiyWXwyJ
 0UG4uAo1eeowb/Cz+JxqzrCsEG8DaZuxE+20aM6nw2A6v4Fpb/FNLisW1
 SCgdrcq858qYmsk5D0eHU/jwQFJXL67fLWJXBV8z0D6u+/Mv24dnthtwD
 wxRJ23nOGBDt3R5kBVt1WRLSxl3aKTh2JL7oTTJu66zL6czOeiVakqArX
 JiO41h8hchAcm0ikEiMQ0UING/HIBh56xX9oGglp066WjF8xyYhPen7Jh w==;
X-CSE-ConnectionGUID: o2u37cctR2mP76zgZLZvpw==
X-CSE-MsgGUID: PUzqXNX2S5S7EESkRoDZAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58003937"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="58003937"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 08:03:05 -0700
X-CSE-ConnectionGUID: sMJp4dFoTNOnmpW98Wup9w==
X-CSE-MsgGUID: DuQrMr40S+Ku6oQD/z0D3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="186791145"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 09 Jul 2025 08:03:01 -0700
Date: Wed, 9 Jul 2025 23:24:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH-for-10.1 v6 02/14] qemu/target-info: Factor target_arch()
 out
Message-ID: <aG6JrfAI5fkjQ+yN@intel.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707172009.3884-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 07, 2025 at 07:19:56PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Mon,  7 Jul 2025 19:19:56 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-10.1 v6 02/14] qemu/target-info: Factor target_arch()
>  out
> X-Mailer: git-send-email 2.49.0
> 
> To keep "qemu/target-info.h" self-contained to native
> types, declare target_arch() -- which returns a QAPI
> type -- in "qemu/target-info-qapi.h".
> 
> No logical change.
> 
> Keeping native types in "qemu/target-info.h" is necessary
> to keep building tests such tests/tcg/plugins/mem.c, as
> per the comment added in commit ecbcc9ead2f ("tests/tcg:
> add a system test to check memory instrumentation"):
> 
> /*
>  * plugins should not include anything from QEMU aside from the
>  * API header. However as this is a test plugin to exercise the
>  * internals of QEMU and we want to avoid needless code duplication we
>  * do so here. bswap.h is pretty self-contained although it needs a
>  * few things provided by compiler.h.
>  */
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/qemu/target-info-qapi.h | 21 +++++++++++++++++++++
>  include/qemu/target-info.h      |  2 +-
>  hw/core/machine-qmp-cmds.c      |  8 +++-----
>  target-info.c                   |  8 ++++++++
>  4 files changed, 33 insertions(+), 6 deletions(-)
>  create mode 100644 include/qemu/target-info-qapi.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


