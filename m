Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39556C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 05:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK8wN-0003QS-76; Wed, 28 May 2025 01:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uK8wG-0003Ll-V6; Wed, 28 May 2025 01:02:54 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uK8wA-00012s-PI; Wed, 28 May 2025 01:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748408567; x=1779944567;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=YTrDOo3og3ow/vshYxgybPn/VW37aD897O1rYMU/oj0=;
 b=OYSW/K6NfCX+YO2k9LnU8q2KVMi8whFB98r9cJcxo3lRefzX1YsmWKwH
 +Yhc0D4HaL1XW8zc9KC9DdaLX/qbqyDa+P5i66D6ADNZEwRUjlLGGeQ9D
 fJdqDGCBaVMdlejgbvT6DIdUgR1sIk/TeBcfujZ6spDm1vfhH9P3eXYfN
 8QOUAaWXwaEeUUKVh3y1nSpRrN6f12My95bNly8yMGhpN20tRQ7SUMBcd
 4WWV6sOgSugTFjbAQfb+eYn4jmAMG48VevEYXKteBFmZbgq9CJrG0+qWF
 vp0rSbn4JMQNT/k8jy3w4V4dXX+hFpiTQDCsnJHBUFKVOgrbSQWnjNu8W g==;
X-CSE-ConnectionGUID: 20k601caSyGts1qyCz3ACQ==
X-CSE-MsgGUID: BpuncPBQTdWCYEfpTADhJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="60674123"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="60674123"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 22:02:44 -0700
X-CSE-ConnectionGUID: pFvX0X3+S2SNesHxbWOiUA==
X-CSE-MsgGUID: lJhui115QOu0cl0wqSkrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="148252801"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 27 May 2025 22:02:39 -0700
Date: Wed, 28 May 2025 13:23:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Message-ID: <aDad5elq0bgZ/tvp@intel.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
 <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Wed, May 28, 2025 at 10:09:56AM +0800, Xiaoyao Li wrote:
> Date: Wed, 28 May 2025 10:09:56 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid
>  field
> 
> On 5/12/2025 4:39 PM, Philippe Mathieu-Daud¨¦ wrote:
> > The X86CPU::check_cpuid boolean was only set in the
> > pc_compat_2_4[] array, via the 'check=off' property.
> > We removed all machines using that array, lets remove
> > that CPU property and simplify x86_cpu_realizefn().
> 
> No.
> 
> We cannot do this. Because it changes the behavior of QEMU.
> 
> 'check_cpuid' is true by default while 'enforce_cpuid' is false. So that
> QEMU emits warnings in x86_cpu_filter_features() by default when user
> requests unsupported CPU features. If remove "check" property and the
> internal 'check_cpuid', QEMU will not do it unless user sets enforce_cpuid
> explicitly.

One option would be to have x86_cpu_filter_features() unconditionally
turn on verbose and print warnings, but some people might want to turn
off these warning prints, I don't know if anyone would, but it would be
possible.

The other option is still to keep the ¡°check¡± property.

IMO, the latter option is the better way to reduce Philippe's burden.

Regards,
Zhao


