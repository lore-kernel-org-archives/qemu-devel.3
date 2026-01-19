Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59E4CA5FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 06:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhipC-0002XK-H2; Mon, 19 Jan 2026 01:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhip8-0002WT-Pz; Mon, 19 Jan 2026 01:33:15 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhip6-0003Y3-1z; Mon, 19 Jan 2026 01:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768804392; x=1800340392;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=f1zvckxP1sVfN4GVJ77Bja0O4O0419dYbsdVoL/Nih8=;
 b=RPNQFCVTjZ7uQ5xxSUvYxsG2qnXTTiYI9VldpESPLUSsgea8jLxUr+FM
 tNdOQUw+y6N2xiMaPb3MaI0Hxo0/vZUT9HP7kWE9mjpDyDRT69CYS0peN
 PmTD8aePW2VX8MQQweBh4U0sgaabBWzC7HSP4T02m/cYN0CIEhXQqi37t
 x2z54Z98LIIad0VDQ/ovbM2Em31GUQiRPdrV7UoRT32esencJEWfmkluI
 SPE6UIUuaTCrTpFBFOcD17B0J8OW2ovrBiQMWAsNBTFN4Pu4OXJNPy1t4
 Yg4g9dKZ4v6Q0A2wBK1gTTd80UNIr1qfc0w9DSzq9fLiSKYh1TwO9xsZj g==;
X-CSE-ConnectionGUID: QS2DTBJlTZaKEHULdEid6w==
X-CSE-MsgGUID: TigeSfakTTKFgU953qFtLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69743819"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="69743819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 22:33:07 -0800
X-CSE-ConnectionGUID: KKIutbL3TZKANG3sAYim0g==
X-CSE-MsgGUID: hA1eP+9gRguGD6+qzQSkSQ==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 18 Jan 2026 22:33:05 -0800
Date: Mon, 19 Jan 2026 14:58:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2 09/16] scripts/qapi: add QAPISchemaIfCond.rsgen()
Message-ID: <aW3WHPutY/4raiMX@intel.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108131043.490084-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jan 08, 2026 at 02:10:36PM +0100, Paolo Bonzini wrote:
> Date: Thu,  8 Jan 2026 14:10:36 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 09/16] scripts/qapi: add QAPISchemaIfCond.rsgen()
> X-Mailer: git-send-email 2.52.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Generate Rust #[cfg(...)] guards from QAPI 'if' conditions; it
> turns out that they are very similar, with both of them using
> not/any/all, so just walk the tree.
> 
> The next commit will put it to use.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/common.py | 19 +++++++++++++++++++
>  scripts/qapi/schema.py |  4 ++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index d7c8aa3365c..14d5dd259c4 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -199,6 +199,25 @@ def guardend(name: str) -> str:
>                   name=c_fname(name).upper())
>  

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


