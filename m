Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1618D3E787
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 02:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Vh2-0004G2-5d; Tue, 05 Nov 2024 21:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8Vgz-0004F1-Gn; Tue, 05 Nov 2024 21:22:45 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8Vgw-0004px-W0; Tue, 05 Nov 2024 21:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730859763; x=1762395763;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/KCEcEIHXIG9K9E4TK1RWwzLaP/150mljJM4/TKE848=;
 b=GWJMB30WG1Laf81wVJBZvL15I+PhIx3RRMNkG3U5IUKj8Pib/pbut1Oo
 cAjvwIhyjcLT7SmxT+34mHlZnOgp9UI4opIc2udNXWOGVYPyzMMXlglgi
 QsXS62V3C65gS3kZfW/2pM5tYkJV7fVVuqUCZKbgVL7Rcz2eaZ8S5v0/x
 ZYbc2XxTJVBdpBwGF0O8VVwSXDn4tzQPgodDkBZ7wtu0xwzYmZvbKrc4n
 VVn8g6rZFa9ALyLji9cPndPiRxsA5ETITaefxCGob253LAjImFot9YOXp
 /d+aydHhpoVfUW2ZnOU7Meumh64U+cXRe8J2rHfnt4/1iXm02IHadsGf4 A==;
X-CSE-ConnectionGUID: GPbRjeWmS+itoM4XMJE5iA==
X-CSE-MsgGUID: Sq3IClVlTDKtCbBNLYlwKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30859563"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="30859563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 18:22:37 -0800
X-CSE-ConnectionGUID: ZMKbsAMBSOWwOHuYvFepng==
X-CSE-MsgGUID: ZhO/mQhGT9Wl8MpmIjIr+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="84365673"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2024 18:22:33 -0800
Date: Wed, 6 Nov 2024 10:40:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v5 0/9] Introduce SMP Cache Topology
Message-ID: <ZyrXGPlVfAVUCfTO@intel.com>
References: <20241101083331.340178-1-zhao1.liu@intel.com>
 <1b00ec74-4dda-48d4-b74f-9ce45cf1a429@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b00ec74-4dda-48d4-b74f-9ce45cf1a429@linaro.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Hi Philippe,

On Tue, Nov 05, 2024 at 10:54:07PM +0000, Philippe Mathieu-Daudé wrote:
> Date: Tue, 5 Nov 2024 22:54:07 +0000
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v5 0/9] Introduce SMP Cache Topology
> 
> Hi Zhao,
> 
> On 1/11/24 09:33, Zhao Liu wrote:
> > Hi Paolo,
> > 
> > This is my v5, if you think it's okay, could this feature get the final
> > merge? (Before the 9.2 cycle ends) :-)
> 
> 
> > ---
> > Zhao Liu (8):
> >    i386/cpu: Don't enumerate the "invalid" CPU topology level
> >    hw/core: Make CPU topology enumeration arch-agnostic
> >    qapi/qom: Define cache enumeration and properties for machine
> >    hw/core: Check smp cache topology support for machine
> >    hw/core: Add a helper to check the cache topology level
> 
> Since the first patches aim to be generic I took the liberty to
> queue them via the hw-misc tree. The rest really belongs to the
> x86 tree.

Thank you! I'm glad I could catch the last train for version 9.2.

> >    i386/cpu: Support thread and module level cache topology
> >    i386/cpu: Update cache topology with machine's configuration
> >    i386/pc: Support cache topology in -machine for PC machine
> > Alireza Sanaee (1):
> >    i386/cpu: add has_caches flag to check smp_cache configuration
> >

I'll continue to push the rest during the merge window of v10.0.

Thanks,
Zhao



