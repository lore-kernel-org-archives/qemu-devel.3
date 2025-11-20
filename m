Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6188CF8861
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5p3-0006u2-Pj; Thu, 20 Nov 2025 09:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5or-0006mI-N5
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:39:34 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5oq-000816-3f
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763649572; x=1795185572;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8FGYCWAz8QYukCIxgyGWKUfL2dbOf8m9/cH+qDQWWow=;
 b=k0SGA3wsB5ohsxqYWZv357HCtzBSCJCK0KcDhfNP4aku2yVSI8Ahl7ei
 wSWf+W/3TB7oGB6IEMbiNtjf6ZYJOvEymJE0hi5HRyRYi8/ZFuJclQhbx
 s4O59y1lr9o4/M9rRqdsX09x7fVgT1MfBLfIxFmIWz7o7q4IAUE3u7l9m
 GJy/ctXIPcW3esg/+Vfae/hWLj3rcucDVX7o7QVZuWF+5VLFqsrP1c0rC
 75tMa8DMLvIyFWy07wY3YVYLXhgsnc0vNOnfMjRYqIHGonZCa3y3V4GyJ
 3Tyr14CgcoEA2dS8FUYLmYpcrphcGIDMbLYMAXWR4OkpnnVucTM20OiIB g==;
X-CSE-ConnectionGUID: aJL2nbtIQHaMh4A0+SnGKA==
X-CSE-MsgGUID: 9UdPso2uQnK7wAUoQ+Jwsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65746331"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="65746331"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:39:30 -0800
X-CSE-ConnectionGUID: hhnk3hwLSxe7kfwQ4U5E+Q==
X-CSE-MsgGUID: h3YmkuXdTluECcwu6PGGHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="196524920"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Nov 2025 06:39:25 -0800
Date: Thu, 20 Nov 2025 23:01:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH for-11.0 07/15]
 tests/functional/x86_64/test_reverse_debug: Silence pylint warning
Message-ID: <aR8tWWKdvTe6m1Eg@intel.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-8-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119082636.43286-8-thuth@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Nov 19, 2025 at 09:26:28AM +0100, Thomas Huth wrote:
> Date: Wed, 19 Nov 2025 09:26:28 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH for-11.0 07/15] tests/functional/x86_64/test_reverse_debug:
>  Silence pylint warning
> 
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint does not like the underscores in the class name here, so
> rename the class accordingly to make pylint happy here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/x86_64/test_reverse_debug.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


