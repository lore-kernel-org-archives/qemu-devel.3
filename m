Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3E7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scML2-0001uJ-Jv; Fri, 09 Aug 2024 05:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scMKu-0001tX-Sz
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:55:05 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scMKs-0003Gq-5I
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723197302; x=1754733302;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=p8g+9B5tMORtQKh2R9PgceAD87B+S1OHWDx0BeOlyr0=;
 b=Yl15ZGvAzM42eDyyk3ziuNB/0J0oQ8440prwz5a2xQufc6WSksz8RW/i
 H3AYrtwcQffQOcJRqKCb00OckKPQDxxiqKfB1r/L4gPwFuES6oyNxtl9Q
 ejuhn8FhYVDNTSia3WZcK7ESYKMDP3tVK5Jztolx08u9Gu9lLYfTTaJ4J
 EsPGjcSHHrKyW1J2J3x8WVS9zOWavGBA11NqWTBuH/OkTcLE7mCcJ6dxK
 w9tVaOG59TcFOvO2fosTLdVowwq358rZPOfLV6l90wvYiNnoGHp2XUTTI
 JMbvMdx4/JDknkbUZscF8GSi2UxAGlpco+vb2VK00uuwSqUQ4GS6mLK6y Q==;
X-CSE-ConnectionGUID: mLgn3t3+T4u+nukyzTDUHw==
X-CSE-MsgGUID: tcIWMJAyTteZbIJ4V9QP+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25235336"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="25235336"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 02:54:51 -0700
X-CSE-ConnectionGUID: /YYhKRwjTtev612rYsp60A==
X-CSE-MsgGUID: E+YXEPWmQNKwd9tp2SdAhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="88153015"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 09 Aug 2024 02:54:50 -0700
Date: Fri, 9 Aug 2024 18:10:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] target/i386: Fix arguments for vmsr_read_thread_stat()
Message-ID: <ZrXrIPHgJCiaandh@intel.com>
References: <20240807124320.1741124-1-aharivel@redhat.com>
 <20240807124320.1741124-2-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807124320.1741124-2-aharivel@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 02:43:20PM +0200, Anthony Harivel wrote:
> Date: Wed,  7 Aug 2024 14:43:20 +0200
> From: Anthony Harivel <aharivel@redhat.com>
> Subject: [PATCH 1/1] target/i386: Fix arguments for vmsr_read_thread_stat()
> 
> Snapshot of the stat utime and stime for each thread, taken before and
> after the pause, must be stored in separate locations
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  target/i386/kvm/kvm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


