Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A110C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2Gb-0001HA-RQ; Wed, 15 Jan 2025 07:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.lindgren@linux.intel.com>)
 id 1tY2GZ-0001Gp-S0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:12:59 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.lindgren@linux.intel.com>)
 id 1tY2GX-00024v-3v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736943177; x=1768479177;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mC1XC4djPCDE99XU+hCt7StagXy+WLInG1/ESF761V4=;
 b=ERE75GkQbkEE17M/99w7xokeGO33x8QOqsuE7elGNmTegFWYgLqEkZhb
 Sz2yBnt/DdOG1PxNvQx2ZYjCjLmGJ9+FhqxYYEEKmHICVdXJEs4GjyyCF
 QhOHZaZLnDJ7IrpxYGqrumtCYY9U8SrvZSdCGWVqilO1RBFVKhpqyqYwY
 iJqoQJzhx8v3w1QjmLLgYjx8MM64DrNEAJNt0yD64DdS5DejaSPf1nwu7
 mod6m5s08tZMiFuOX+bhQJHHN8disAexK+GD6goKeZ0Q3nBfOjFTkk799
 Toq9gdxmWqJcZxvUF3TIQ4zej3g3h27wTdXdZMKqJcCNkX5HYnhfcgTEy Q==;
X-CSE-ConnectionGUID: w0k22E1CQaOk26gf7Zjdgw==
X-CSE-MsgGUID: JCqE9h3AQZuBKbbBiIlCzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41037582"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; d="scan'208";a="41037582"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 04:12:30 -0800
X-CSE-ConnectionGUID: s0GYpNuFTU6eWWueralUcQ==
X-CSE-MsgGUID: 5/95xIS+TsSjrweD/IvTGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; d="scan'208";a="105078639"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.31])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 04:12:23 -0800
Date: Wed, 15 Jan 2025 14:12:20 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "Liu, Zhao1" <zhao1.liu@intel.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH v6 09/60] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <Z4emJKi8LBnYKUUw@tlindgre-MOBL1>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-10-xiaoyao.li@intel.com>
 <1235bac6ffe7be6662839adb2630c1a97d1cc4c5.camel@intel.com>
 <c0ef6c19-756e-43f3-8342-66b032238265@intel.com>
 <Zyr7FA10pmLhZBxL@tlindgre-MOBL1> <Z1scMzIdT2cI4F5T@iweiny-mobl>
 <Z2F3mBlIqbf9h4QM@tlindgre-MOBL1>
 <1b03e7a4-c398-4646-9182-e3757f65980e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b03e7a4-c398-4646-9182-e3757f65980e@intel.com>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=tony.lindgren@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 14, 2025 at 08:39:37PM +0800, Xiaoyao Li wrote:
> On 12/17/2024 9:10 PM, Tony Lindgren wrote:
> > Hmm I don't think we should loop forever anywhere, the retries needed should
> > be only a few. Or what do you have in mind?
> 
> "A few" seems not accurate. It depends on how heavy the RDRAND/RDSEED
> traffic from others are. IIRC, it gets > 10 0000 -EAGAIN before success when
> all the LPs in the system are doing RDRAND/RDSEED.

Oh OK :)

> Maybe a timeout? E.g., QEMU exits when it cannot move forward for a certain
> period.
> 
> However, I'm not sure what value is reasonable for the timeout.

Maybe some reasonable timeout could be multiplied by the number of CPUs
or LPs available on the system?

Regards,

Tony

