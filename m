Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3940CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 10:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlGD-0005KH-4e; Mon, 07 Oct 2024 06:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxlFs-00055e-2W; Mon, 07 Oct 2024 06:46:25 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxlFp-0003ut-6X; Mon, 07 Oct 2024 06:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728297977; x=1759833977;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=B7T9+eTv/Zw/x8yFPq2kpJfgxfT66Zaq5LvJc4Qn1No=;
 b=A7Cs4CCDBCU/22adE7q9iA8HB/FdCbfhAjdOlDJ495mTOH0hiQaMbiUg
 fSmyoKDRHNivo+HK7qeFiCiTqmqtC6MxovmsbUTrdDJ1TATCA51nwNJ+g
 WCcwnRl2IBS62h+tAL8e5K9fidpA9xTCDdKJsbdFO0dlH+o8NagK60F4q
 aZqmOM3CDJF8GpT2qGGGtv4QVFEtXY7Qo+4mAKwaVKZ+iUx+YwAwPH5sh
 iehH2jrJ0et3MqA21lsniEj8kU7zPhCEfYqJS3RzE5MGZ9ptdZy7xijR8
 PCBB/oBO5BbzPilxavot/QF0aQfJcKlReva/OWR4a5Q1wwUUD1B5YfYmN w==;
X-CSE-ConnectionGUID: 0TVyqe1uTA2pWQIC8scj8g==
X-CSE-MsgGUID: xDMG9nJTQrqptVXXuSeWAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="30323839"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="30323839"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 03:46:14 -0700
X-CSE-ConnectionGUID: AX+g0EMbQD6q55DiWdQOyA==
X-CSE-MsgGUID: dW1FG9hzTJijhkJ9dGXajQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="75004461"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 07 Oct 2024 03:46:09 -0700
Date: Mon, 7 Oct 2024 19:02:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S.Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 3/7] hw/core: Add smp cache topology for machine
Message-ID: <ZwO/u0T+65b2/cFg@intel.com>
References: <20240908125920.1160236-1-zhao1.liu@intel.com>
 <20240908125920.1160236-4-zhao1.liu@intel.com>
 <20240917100048.00001bcf@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917100048.00001bcf@Huawei.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Sep 17, 2024 at 10:00:48AM +0100, Jonathan Cameron wrote:
> Date: Tue, 17 Sep 2024 10:00:48 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [PATCH v2 3/7] hw/core: Add smp cache topology for machine
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Sun,  8 Sep 2024 20:59:16 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > With smp-cache object support, add smp cache topology for machine by
> > linking the smp-cache object.
> > 
> > Also add a helper to access cache topology level.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>
> Minor stuff. The property stuff is something I seems to mostly get wrong
> so needs more eyes but fwiw looks fine to me.

Yes and thank you!

> With the tweaks suggested below.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> > Changes since Patch v1:
> >  * Integrated cache properties list into MachineState and used -machine
> >    to configure SMP cache properties. (Markus)
> > 
> > Changes since RFC v2:
> >  * Linked machine's smp_cache to smp-cache object instead of a builtin
> >    structure. This is to get around the fact that the keyval format of
> >    -machine can't support JSON.
> >  * Wrapped the cache topology level access into a helper.
> > ---
> >  hw/core/machine-smp.c | 41 ++++++++++++++++++++++++++++++++++++++++
> >  hw/core/machine.c     | 44 +++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/boards.h   | 10 ++++++++++
> >  3 files changed, 95 insertions(+)
> > 
> > diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> > index 5d8d7edcbd3f..b517c3471d1a 100644
> > --- a/hw/core/machine-smp.c
> > +++ b/hw/core/machine-smp.c
> > @@ -261,6 +261,41 @@ void machine_parse_smp_config(MachineState *ms,
> >      }
> >  }
> >  
> > +bool machine_parse_smp_cache(MachineState *ms,
> > +                             const SmpCachePropertiesList *caches,
> > +                             Error **errp)
> > +{
> > +    const SmpCachePropertiesList *node;
> > +    DECLARE_BITMAP(caches_bitmap, CACHE_LEVEL_AND_TYPE__MAX);
> > +
> > +    for (node = caches; node; node = node->next) {
> > +        /* Prohibit users from setting the cache topology level to invalid. */
> > +        if (node->value->topology == CPU_TOPOLOGY_LEVEL_INVALID) {
> > +            error_setg(errp,
> > +                       "Invalid cache topology level: %s. "
> > +                       "The topology should match the "
> > +                       "valid CPU topology level",
> 
> I think that's too much wrapping for an error message. Makes them hard
> to grep for.

I understand you mean the last sentence should not be on separate lines
but should be continuous in one line, right?

> > +                       CpuTopologyLevel_str(node->value->topology));
> > +            return false;
> > +        }
> > +
> > +        /* Prohibit users from repeating settings. */
> > +        if (test_bit(node->value->cache, caches_bitmap)) {
> > +            error_setg(errp,
> > +                       "Invalid cache properties: %s. "
> > +                       "The cache properties are duplicated",
> > +                       CacheLevelAndType_str(node->value->cache));
> > +            return false;
> > +        } else {
> 
> returned anyway in the above path, so can drop the else and reduce
> indent a little.

Sure.

Thanks,
Zhao

> > +            ms->smp_cache.props[node->value->cache].topology =
> > +                node->value->topology;
> > +            set_bit(node->value->cache, caches_bitmap);
> > +        }
> > +    }
> > +
> > +    return true;
> > +}
> > +
> 
> 

