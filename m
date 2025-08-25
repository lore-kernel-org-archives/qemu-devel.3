Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AD1CA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqY58-0006zU-PQ; Mon, 25 Aug 2025 10:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqY56-0006y9-BT
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:21:56 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqY4s-00009B-Ra
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756131703; x=1787667703;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=soHQT2XDSKmb9Ao5/45S7jWsuFcQiY3vokX8Xm3zERU=;
 b=aJ/iFY4RT1AHJU4tPZG0el9sQ6qxCRjkBjYfeeICedoDqoCSiWMAFfTD
 ATlqP5kL/IJdnBNHQ7XSug6r1mrY7vbl4CSX5kC0reCaBKGzzNSPg/oNf
 Cad0Njh4LvqXOyD3S9xyL5jojjs0Z4wbe0h3ASatTvqWZnpdL6pZC9YkD
 vzRCa1duzjwpfVWGZ5onZrMEARiTue69q4MNqSf4XmUef6EPj4oa6OhKv
 em5pxmCydyGTJh6EgQIkt7UYbpm+/Fce5sc54wYmsb4pmmZww6210MSFz
 e6TsIe8F9camGeqRPVOmh2zreejeLjKhYtaCt7RAw8P8TfGzQzCK6ZjE8 w==;
X-CSE-ConnectionGUID: DZhqrB64TjOhiIglYLWNSw==
X-CSE-MsgGUID: tfjcEfAiTOGOiVIYAVYIyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58414310"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="58414310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 07:21:32 -0700
X-CSE-ConnectionGUID: RRKdyBx4S+q+uHT1ClFI1w==
X-CSE-MsgGUID: Gh+GC/ULTA+kpDvGEkJGnA==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2025 07:21:30 -0700
Date: Mon, 25 Aug 2025 22:43:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 mtosatti@redhat.com
Subject: Re: [PATCH v4 3/8] hpet: switch to fain-grained device locking
Message-ID: <aKx2glRrPLUt8iUu@intel.com>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-4-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814160600.2327672-4-imammedo@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 14, 2025 at 06:05:55PM +0200, Igor Mammedov wrote:
> Date: Thu, 14 Aug 2025 18:05:55 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v4 3/8] hpet: switch to fain-grained device locking
> 
> as a step towards lock-less HPET counter read,
> use per device locking instead of BQL.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/timer/hpet.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


