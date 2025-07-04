Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F53C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXd3K-0004Oq-Ob; Fri, 04 Jul 2025 05:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd3I-0004Nk-5A
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:49:52 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd3G-0006hS-Gq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751622590; x=1783158590;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=PIS68G1zhqLECHS9Ut4+RGih5rMWO3qh6yCZ+1OvrkQ=;
 b=MQMN0XmF1bvGGrY3LZ+cKL+QGzQPHZAZSkNPm6OK2b8OujrKK8LSAhVz
 I2AUTHSM3D1Kzoi+c02FnvcGIZ/kauai5U9lzglO18Lo+lPG+unqs7WFJ
 dogFAGYvzQzMUqf56yBZeu9eNAHJoXKkGdsj6727C5kL7Lurm37QMvOkU
 Lkt+xy4s28+RsIJjoJsvzh8x6YQh8WMS6nKVD/2x+GrQJvs2vH6CRF+Dd
 2RbntypHUjT8y2IqCp2YNTVixzO4d6UQFWJekEAPnxAwG2mIzg9UOu3G+
 F7UE/GuEMTAUt+AQYNTM+DeSUmgXC0BY9Rn1O2zdsZ4RJKqsWeRxfw2BA w==;
X-CSE-ConnectionGUID: L8iiXg0RQI6b3S1HT79mBA==
X-CSE-MsgGUID: Ii/Q+e1ZRyaR+XQQhTAL6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53179105"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53179105"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:49:47 -0700
X-CSE-ConnectionGUID: L29Oe+YhQlKPiA9AaH3jRw==
X-CSE-MsgGUID: ZFt0l1xlROqwKnAUA3Tf8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="155367705"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2025 02:49:47 -0700
Date: Fri, 4 Jul 2025 18:11:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 20/39] accel/whpx: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Message-ID: <aGeowBfypeHVUAJe@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-21-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-21-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 03, 2025 at 07:32:26PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:26 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 20/39] accel/whpx: Replace @dirty field by generic
>  CPUState::vcpu_dirty field
> X-Mailer: git-send-email 2.49.0
> 
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/whpx/whpx-all.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


