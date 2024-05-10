Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A5AC25B77
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MJl-0006ig-22; Fri, 10 May 2024 05:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5MJi-0006hq-I1
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:13:26 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5MJR-0008Nr-OD
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715332390; x=1746868390;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YKnyL1zebXTo6AGvNJTCdPY2g+GVkqs/p83tgJ3LPxw=;
 b=Rwu4Nh0clK8EizXF95waYhi1c5mqvHojGeKirn4Bu+TFAKa9rAvdc9er
 5m0j8tjhLEHTfnTuF31QvJA7/sjR8n6JvZ4mjZb0SH+3yd/0ZStTxW3nj
 F++fE+WBoMWY9E/oEt/fBhqe+6UhuKxHfn4Q6GKAd2zjEGHTkLcBIXxRE
 7f2ylGZZZp2QQjIrmCFaMNi4YBpzMWz9GsJi2nAHT0QyFmV1l58uR5y2T
 P6qehWxlN30Snx5HhwvHeDp2Z/os/w0yJPofI4B+/kwdTblWQ9ddffOQa
 gqnG22G1HNQG2fr9ZNNqIHudpqU4/WUgk1FDto2HPdTLIY8ELl1ZDY3p0 w==;
X-CSE-ConnectionGUID: UqnSqwPMSGa+cj4UGCQ9Jg==
X-CSE-MsgGUID: dayOEG31TxiCPs4Y2pl1ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="14254727"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="14254727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 02:13:06 -0700
X-CSE-ConnectionGUID: iIb2jAd5RqeEFe0LQjg5UA==
X-CSE-MsgGUID: 8VXSMUFjT+6KnQ2oSl8iBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="29496503"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 10 May 2024 02:13:05 -0700
Date: Fri, 10 May 2024 17:27:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/tcg: cover lzcnt/tzcnt/popcnt
Message-ID: <Zj3od3uT1ukuCVb6@intel.com>
References: <20240509152532.141935-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509152532.141935-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 09, 2024 at 05:25:32PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 17:25:32 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] tests/tcg: cover lzcnt/tzcnt/popcnt
> X-Mailer: git-send-email 2.45.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tcg/i386/test-i386.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


