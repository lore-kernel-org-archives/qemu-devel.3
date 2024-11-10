Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C81D5E38D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA8Ob-00083T-4z; Sun, 10 Nov 2024 08:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA8OV-000835-Vn
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:54:24 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA8OR-0000DZ-4f
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 08:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731246859; x=1762782859;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=VfG2+AfLmgSmjDjUO/b/kaRO2O/x4lH7i4GEVGEUQ/w=;
 b=O5v5uj32iRTmdzjpPv4mQNdLLgM7b5U1FCRH77/aWSAm3NOBN5IAhjTn
 WWthsVkJeu56DzMcTbXlzHnrQORJuIeEKqtDAHa10UBG7tgxwd1CKrbQ1
 CTy3ETFmJWpCaOuaNcVryM5aZN9KJ7Mcvv8qXfRJjhf7impWfVHJ0IML4
 eaaRDhK+sgmjcI2mOgNIa4zKaoRhXoKtmWRNavgJtAe0jlIISZFRLAL16
 P9kZHO2CcapzuS3aM858KrRResOfNVJb6+DSv0qZwvSDa9rTCNocwzUtt
 zNJ5kLRsN3mGvctDPJPOJbA3dvRUZAIjgL224XTlZzt3a/FfIttFUialV A==;
X-CSE-ConnectionGUID: nw98eTXhRAyAslkqDDEQvQ==
X-CSE-MsgGUID: Hm51+Wt5ReC13gypAkLgKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="56465299"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="56465299"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2024 05:54:14 -0800
X-CSE-ConnectionGUID: mr7cXgrXTa+3SPxOE/v1Tw==
X-CSE-MsgGUID: 0ogGfTP6SpW1PhDMkHK5SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="86576163"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 10 Nov 2024 05:54:13 -0800
Date: Sun, 10 Nov 2024 22:12:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PULL 10/29] hw/core: Check smp cache topology support for machine
Message-ID: <ZzC/Otesa2X4fLwo@intel.com>
References: <20241105224727.53059-1-philmd@linaro.org>
 <20241105224727.53059-11-philmd@linaro.org>
 <CAFEAcA-6e-o480iPeesKPnvcBtjVwWsL=zYOuNNddPNZu7Uc6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-6e-o480iPeesKPnvcBtjVwWsL=zYOuNNddPNZu7Uc6g@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

Hi Peter,

On Fri, Nov 08, 2024 at 07:16:50PM +0000, Peter Maydell wrote:
> Date: Fri, 8 Nov 2024 19:16:50 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [PULL 10/29] hw/core: Check smp cache topology support for
>  machine
> 
> On Tue, 5 Nov 2024 at 22:49, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > Add cache_supported flags in SMPCompatProps to allow machines to
> > configure various caches support.
> >
> > And check the compatibility of the cache properties with the
> > machine support in machine_parse_smp_cache().
> 
> Hi; Coverity points out an issue in this code (CID 1565391):
> 
> >  bool machine_parse_smp_cache(MachineState *ms,
> >                               const SmpCachePropertiesList *caches,
> >                               Error **errp)
> >  {
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> >      const SmpCachePropertiesList *node;
> >      DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
> >
> > @@ -283,6 +305,25 @@ bool machine_parse_smp_cache(MachineState *ms,
> >          set_bit(node->value->cache, caches_bitmap);
> >      }
> >
> > +    for (int i = 0; i < CACHE_LEVEL_AND_TYPE__MAX; i++) {
> > +        const SmpCacheProperties *props = &ms->smp_cache.props[i];
> > +
> > +        /*
> > +         * Reject non "default" topology level if the cache isn't
> > +         * supported by the machine.
> > +         */
> > +        if (props->topology != CPU_TOPOLOGY_LEVEL_DEFAULT &&
> > +            !mc->smp_props.cache_supported[props->cache]) {
> > +            error_setg(errp,
> > +                       "%s cache topology not supported by this machine",
> > +                       CacheLevelAndType_str(node->value->cache));
> 
> This error message looks at "node", but "node" was the iteration
> variable in the first loop in this function, so generally at
> this point it will be NULL because that is the loop termination
> condition.
> 
> The code looks like it ought to be reporting an error relating
> to the 'props' variable, not 'node' ?

Thank you! My fault and you're right, here I should use "props->cache"
instead of "node->value->cache". I'll submit a patch to fix this.

Regards,
Zhao


