Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEB0C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txL77-0001EE-I4; Wed, 26 Mar 2025 03:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txL71-0001DY-Lz; Wed, 26 Mar 2025 03:23:43 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1txL6y-0002Oe-KM; Wed, 26 Mar 2025 03:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742973821; x=1774509821;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=MTmY8VBrp7YuMwKO2+30MHDzGmx7JSYdpNSgryyowJ4=;
 b=CeRthE/fdSE5mq6qu9JxnI/VNY0NkrDXwhtaQrZmzOLL3BFUdKhMp3Rv
 pgtqqiSTMOJI0iI36FUKygseU0r4kWytOrrc10hrOgb2VuFlyG34vlVw4
 /f+/1v6NueQJttQNaMK5xInh8pr3etwbbnTe9bTWZnfCXkCzkUvHKuCqh
 +6L362vdfbI619xc8fQMWUOA5d9g3yzB4ZFPpuK6c88sIm+W1RkcwMK1L
 RTRj5dlXJEscwMOIuFvAmCDDe3OtBUss1xJdFg5BoYDc6OZw6r3pW+as1
 M+fLSU3GUA47BqHqaROx+fJOq0sKTCnA1Hu6OMYk67Z0XGOqIBcKRIhKp g==;
X-CSE-ConnectionGUID: nwgun8ajR3K3diBiuYSD/w==
X-CSE-MsgGUID: HtSJmDHwQgWMlKsjbqJ+1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="69609504"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="69609504"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 00:23:35 -0700
X-CSE-ConnectionGUID: onB4UjmyTV2s/tO0rGplBg==
X-CSE-MsgGUID: euAoLTdsQXyr2E5dieCW2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; d="scan'208";a="147853431"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2025 00:23:31 -0700
Date: Wed, 26 Mar 2025 15:43:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 1/7] cpus: Introduce CPUClass::list_cpus() callback
Message-ID: <Z+OwM74aDxNs/qG/@intel.com>
References: <20250324185837.46506-1-philmd@linaro.org>
 <20250324185837.46506-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324185837.46506-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Mon, Mar 24, 2025 at 07:58:31PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 24 Mar 2025 19:58:31 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 1/7] cpus: Introduce CPUClass::list_cpus() callback
> X-Mailer: git-send-email 2.47.1
> 
> Some targets define cpu_list to a method listing their
> CPUs on stdout. In order to make list_cpus() generic,
> introduce the CPUClass::list_cpus() callback.
> When no callback is registered, list_cpus() defaults
> to the cpu_list definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/core/cpu.h | 2 ++
>  cpu-target.c          | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


