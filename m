Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A261DCED608
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 05:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syPdY-00075T-5e; Wed, 09 Oct 2024 01:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syPdV-00074u-Iz; Wed, 09 Oct 2024 01:53:25 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1syPdU-0005KI-1v; Wed, 09 Oct 2024 01:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728453204; x=1759989204;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0ilS+TEIzCQiqFlC+TTsmPgQDdJ1qwzqdbAsWGUD5hs=;
 b=Zr5rhHR/G921f8tCbQh+PSJu9VdXNQFAc+FtmAISd5L3gwEnOpf4o+A9
 Xzz5bF5j7MD7/fqQ7iWLvHzOOnCW7Lqf2FjH0vb/Ws+St7mGSLrL5es7M
 h0trpNmyV4Wp1DDK7IYy61E1Q0vEIYtEAGAjUmddcXq5FKsp9jrVPRXDP
 68+G0bzg1tojCZ4Z3jeHYwamYoS8OiWAu9X3KsgbJ+ikFIYmy6/yCctU5
 tY5TWdvj1mrGBheOwxI1gcQB6t2iLzyccTyusJigqP9fj8MezoGQl+WCd
 WNxvYBZqX5W2UTEZ2VKtLCcr44ocqun7G8plm7QWYfX3QsBRbwI+y53WT g==;
X-CSE-ConnectionGUID: LFAD0MRmRWa+8+rmffJ5Bw==
X-CSE-MsgGUID: akM9yqJqTGuPu8w/ppfq9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27546157"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="27546157"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2024 22:53:21 -0700
X-CSE-ConnectionGUID: 1uy9UXJzR5WlZmqSMcANiA==
X-CSE-MsgGUID: DtsvWWfiTvid0l0/6LauKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="76449252"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 08 Oct 2024 22:53:15 -0700
Date: Wed, 9 Oct 2024 14:09:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC v2 01/12] qdev: Allow qdev_device_add() to add specific
 category device
Message-ID: <ZwYeFofVARVuL1i6@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
 <20240919061128.769139-2-zhao1.liu@intel.com>
 <20241008101425.00003b90@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008101425.00003b90@Huawei.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Oct 08, 2024 at 10:14:25AM +0100, Jonathan Cameron wrote:
> Date: Tue, 8 Oct 2024 10:14:25 +0100
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [RFC v2 01/12] qdev: Allow qdev_device_add() to add specific
>  category device
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Thu, 19 Sep 2024 14:11:17 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Topology devices need to be created and realized before board
> > initialization.
> > 
> > Allow qdev_device_add() to specify category to help create topology
> > devices early.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> It's not immediately obvious what the category parameter is.
> Can you use DeviceCategory rather than long?

...

> > -DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> > +DeviceState *qdev_device_add_from_qdict(const QDict *opts, long *category,
> >                                          bool from_json, Error **errp)
> >  {
> >      ERRP_GUARD();
> > @@ -655,6 +655,10 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >          return NULL;
> >      }
> >  
> > +    if (category && !test_bit(*category, dc->categories)) {
> > +        return NULL;
> > +    }
> > +

The category parameter is a bit not a bitmap, so, YES.

Thanks,
Zhao


