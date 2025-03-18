Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0710FC28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuVfZ-0000g5-5Y; Tue, 18 Mar 2025 08:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuVes-0000HI-Lp; Tue, 18 Mar 2025 08:03:01 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuVeq-0006Mt-Ga; Tue, 18 Mar 2025 08:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742299376; x=1773835376;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CkGHQD58mLdqwAQYIS0pfNA2P8eyvFs/LXDjSC3+Mlc=;
 b=Zr+1roTtPASVRNO6e/44eHJkfqaoz0NVE3KPrLG7K0rpNMVyMXlnx+pA
 xxwwzeZTG/US82ujDJAjKX6n7pg9x59ZlntgqArIWxlaj7BnV3MeI7oxr
 fcetRrZQiqI15zqhmRV3crx2MpRgLIsc/ddlatqdM81I8PQHRAKtcgeZy
 0T6S29YNltdUWY8kC1oYdk0MhxLXy/HqxGn/TB4C+SHi88P3PmP7qezOb
 lNuo5QXudEtmFwQ6rM7Hs2oedEdskDtKQovqikP9MFlidOgh8Hn/EdHvh
 +2exFSTmXuf2JKOX1JmLehrcqwH5hXAm6/4ESqHZNNgJcc1HcLEwEnlYJ A==;
X-CSE-ConnectionGUID: 5ESGqJCGSLOE5wwDJu+5Qw==
X-CSE-MsgGUID: JzTMmEhSQNWICuBYlq5llQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="47322771"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="47322771"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:02:53 -0700
X-CSE-ConnectionGUID: 08q52vdWSCaQLrG7QJuCxQ==
X-CSE-MsgGUID: n2N9vEntQWyHhRHrggwp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="153230347"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 05:02:52 -0700
Date: Tue, 18 Mar 2025 20:23:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 10/14] rust/vmstate: Support vmstate_validate
Message-ID: <Z9llqtHLLTJIju/j@intel.com>
References: <20250318083248.1402990-1-zhao1.liu@intel.com>
 <20250318083248.1402990-11-zhao1.liu@intel.com>
 <9e8743b8-99b2-4aab-84de-7630edcc7e10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e8743b8-99b2-4aab-84de-7630edcc7e10@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

>  /// This macro can be used (by just passing it a type) to forward the `VMState`
> @@ -572,9 +548,9 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
>                  }
>                  Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
>              },

I want to keep the comment here as C version did, because there's an array flag :

// Though VMS_ARRAY is set, the num is 0: no data, only run test_fn callback

> +            flags: VMStateFlags(VMStateFlags::VMS_MUST_EXIST.0 | VMStateFlags::VMS_ARRAY.0),
>              ..$crate::zeroable::Zeroable::ZERO
>          }
> -        .with_validate_flag()
>      };
>  }
> 
> Otherwise the series looks great, thanks!

Let me refresh the v3. :-)

Thanks,
Zhao


