Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A79C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTc8-0002FE-G6; Wed, 27 Mar 2024 09:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTc5-0002F3-Ao
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:46:45 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpTc2-00022z-0u
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711547202; x=1743083202;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2p2UnKsg9rmaiIH6JacynVD4rD0PMYy7fe62WSye7rg=;
 b=Zj1q7UzOiIu1tZlcKkLznWaS6Xi+fLjV351DhDKvWtMPLYmdK8fksTCr
 YkZk8vBoFCKZnogh0CA8J6K6K9pixNLDoiy9nq7v7RamYUbGtTmJngfwi
 4H+k9LdH93K1A/MBGsyhnUIJCDIQ6fufnKsqOGWDl2WVT37govZlJ95m2
 CKSfZPtcz9NZ0xqal+YLWhREi06JmdVMvm3jiBU37Mp20n2kkXjaNV0at
 L2i7s6nOPIaIzJAR//DgSNlaO54szYDEFl3fgVOoH8cYieIFv1g9C0dHZ
 /LDk3xABBP4pxlY7b+HE3IcXx9tFxmRh4psxpiKCi72nkmg5i4OERJyqB w==;
X-CSE-ConnectionGUID: q3xMGIkTTq6MiFO6l9QVxg==
X-CSE-MsgGUID: fvIcVrMhSeOpeARh4dui6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10430039"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; d="scan'208";a="10430039"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 06:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; d="scan'208";a="21008482"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 27 Mar 2024 06:46:36 -0700
Date: Wed, 27 Mar 2024 22:00:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.1 v2 09/21] hw/i386/pc: Remove
 PCMachineClass::smbios_uuid_encoded
Message-ID: <ZgQmf4huw0/HXKUR@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-10-philmd@linaro.org>
 <ZgQkVZMiZnDrjeiR@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgQkVZMiZnDrjeiR@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

> Since this parameter is always ture, then we can drop it and further
> clean up the static flag "smbios_uuid_encoded" in hw/smbios/smbios.c.

Oops, my email didn't sync up well, the next two patches were doing
just that.

Thanks,
Zhao


