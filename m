Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA39C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjeT-0000In-5h; Fri, 19 Apr 2024 04:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxje4-00008M-1f; Fri, 19 Apr 2024 04:30:57 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rxjdx-0003Pe-TT; Fri, 19 Apr 2024 04:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713515451; x=1745051451;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+yYx2sWsMD6lkFSsuh3wolXlVNvWzT7nEUBQt0r5Eiw=;
 b=durqBlUT1iDo8hhBoOhYNSulCyu6z+oNknB9sRzFh/2d/F0xdkifxeeN
 AT6w8P5609Y+OZ2NbN+GgwyGxMRL0To/qM/0FMxY6bCYztKwK11Vqw//Z
 6U6pH0j9LxJhdYAuuJl4PF4d1PibqzUWBrMSuPJ9w9b4Iic2UQUKXDmms
 xSa8vMKhaK5qf90g4TtwNdeMTKi5975Nb9IRl8+t8tLuEBbECA1rMLsxO
 wvKdO6sS/EmKJzCKozHplY3VFK4MDAw+Hg3nzzjEZ912MraJ1/OnryLF+
 1pnQO9NSZHcl97Xelo72JcWn9QdNZix4F5VScSTWovLLSGOi0iG/MW2TI g==;
X-CSE-ConnectionGUID: Idgtz2g4SgusuD4AWn7ZkQ==
X-CSE-MsgGUID: wULu3lYlSRqIYyoP/Av40A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="31589874"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="31589874"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 01:30:48 -0700
X-CSE-ConnectionGUID: 0Zu9lRIRR++O18xk4EUMvg==
X-CSE-MsgGUID: RjzTa16oQwKHt/JqOV0seA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="23323817"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 19 Apr 2024 01:30:44 -0700
Date: Fri, 19 Apr 2024 16:44:49 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
 kvm_s390_get_host_cpu_model() return boolean
Message-ID: <ZiIvAXd6wFQ2pwoM@intel.com>
References: <20240419065712.1225038-1-zhao1.liu@linux.intel.com>
 <20240419065712.1225038-4-zhao1.liu@linux.intel.com>
 <0ae778e1-b4aa-4021-bdbc-4c6a663db41a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae778e1-b4aa-4021-bdbc-4c6a663db41a@redhat.com>
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Thomas,

On Fri, Apr 19, 2024 at 09:50:46AM +0200, Thomas Huth wrote:
> Date: Fri, 19 Apr 2024 09:50:46 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [PATCH 3/6] target/s390x/cpu_models: Make
>  kvm_s390_get_host_cpu_model() return boolean
> 
> On 19/04/2024 08.57, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > As error.h suggested, the best practice for callee is to return
> > something to indicate success / failure.
> > 
> > So make kvm_s390_get_host_cpu_model() return boolean and check the
> > returned boolean in get_max_cpu_model() instead of accessing @err.
> > 
> > Additionally, since now get_max_cpu_model() returns directly if
> > kvm_s390_get_host_cpu_model() fills @err, so make
> > kvm_s390_get_host_cpu_model() return true by default for the non-KVM
> > case in target/s390x/cpu_models.h.
> 
> You could also argue the other way round that there should be something in
> *model if it returns "true" ... anyway, the stub should never be executed,
> so it likely doesn't matter too much, but I'd still prefer if we'd rather
> return "false" in the non-KVM stub instead.

I see, since this interface in wrapped in kvm_enabled() condition, so
the non-kvm sutb wouldn't be called.

Thanks! Will change to return false.

Regards,
Zhao


