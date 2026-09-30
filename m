Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB1CCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpvE-0002jx-8z; Wed, 30 Sep 2026 04:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpvC-0002jG-0B; Wed, 30 Sep 2026 04:44:14 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpvA-0001k4-EQ; Wed, 30 Sep 2026 04:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790757852; x=1822293852;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=21Vq33Ujyd0x0lL76DGV9qDfEt4z+KPcnZdMqv8cOzU=;
 b=DVfxUGz6DIglsSjy+l1o36lmrvV4o66BBHCc0tP+aTdS+1V/ycmhpyke
 wGPddwxOaDde6EtLJuyjFPMSO22Q3stFSgX9f/lFgTIVjukmVLO21D85H
 MRcGrgUlSDPIPHqSnuLpq1wM1V/b2SuSQqP6BVArjPQaap130aF6/hWtP
 f6Zvc4o+yK1qrZWxq+ILkL/0a7x3+kOi5Bwek/iwaVtXngEyddlgvwp1p
 OazPtIj0D6K/12T/hGa2nhVDbDhqDORSvKyZrmuoS9I2T7lu56EWaySfI
 oCI7S+/a5AZo3s5Nr3P5qiIRBnwlHdWs4JJtwRERhC6dkVh2Jio5g0mHT w==;
X-CSE-ConnectionGUID: 5UpkBPkBTNeBeisVnt0Oog==
X-CSE-MsgGUID: tWX32FMYTi2YwkcpiCyZfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90531999"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90531999"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:44:08 -0700
X-CSE-ConnectionGUID: ifvxWTVaT2K1EUp+PptNyw==
X-CSE-MsgGUID: 5YiOmoCFTtWZ3cMk/t3shw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="275185911"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2026 01:44:03 -0700
Date: Wed, 30 Sep 2026 16:44:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
Message-ID: <arzL0lS6kAnoctY5@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260926081551.29-2-luoyonggang@gmail.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sat, Sep 26, 2026 at 04:15:41PM +0800, Yonggang Luo wrote:
> Date: Sat, 26 Sep 2026 16:15:41 +0800
> From: Yonggang Luo <luoyonggang@gmail.com>
> Subject: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
> X-Mailer: git-send-email 2.52.0.windows.1
> 
> - Add machine_class_set_name() so boards can keep a stable -M name
>   when the QOM type is uniquified. machine_class_base_init still
>   defaults the name to the QOM type without -machine.
> - Document that MachineClass::name is the -M name, not the QOM type.
> - Sort -M help by MachineClass::name so order matches the printed names
>   when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/core/machine.c        |  6 ++++++
>  include/hw/core/boards.h | 12 +++++++++++-
>  system/vl.c              |  8 +++-----
>  3 files changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


