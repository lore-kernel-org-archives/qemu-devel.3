Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609FBC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTkY-0005Ah-M1; Wed, 27 Mar 2024 09:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTkW-00055W-NE
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:55:28 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTkV-0003ao-4s
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711547727; x=1743083727;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=i0EcAAnq53NHStJ9iZBFbjQjUZBA+j3pG6cA6qV3wAM=;
 b=CfkacYIUB9kQteNauggSdxKWGI/A8qcRXi2vyldu2bg7caTRs5PCClvX
 U5YVFEWeILO8c8rAiF7VLj7Y2zqdekUOOk972OM/tGv75q7kiTXdWvCfT
 +cJZHehU6XZ7SG7lqkI2dZ3xCPGnCpudnnCvbZrdE7gfMfPN3pqBz7B6N
 XYyDeR4+0AnrWAE5Zz3QI0fYJp492AiULMJZaS9yxp1BkKr+44WV1EJF3
 rE4IObkPUaUMA0qatqDslup/36jhwqD7LL4FQ4nV73aQllb8Prq2AX1Tn
 a5aUyp/u1voQ03YNCMJ/xXWdw87irNT1MHd+XRq3Vi/YuyKY1yiZMyoMq A==;
X-CSE-ConnectionGUID: iSxrXMvWR1i6NBc3+MEufQ==
X-CSE-MsgGUID: 6O62upxwSRGAWehM5qXhYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24101939"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; d="scan'208";a="24101939"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 06:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; d="scan'208";a="21010990"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 27 Mar 2024 06:55:23 -0700
Date: Wed, 27 Mar 2024 22:09:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH-for-9.1 v2 11/21] hw/smbios: Remove
 'smbios_uuid_encoded', simplify smbios_encode_uuid()
Message-ID: <ZgQojkI3y4AhCzAr@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-12-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:13AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:13 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 11/21] hw/smbios: Remove 'smbios_uuid_encoded',
>  simplify smbios_encode_uuid()
> X-Mailer: git-send-email 2.41.0
> 
> 'smbios_encode_uuid' is always true, remove it,
> simplifying smbios_encode_uuid().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/smbios/smbios.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


