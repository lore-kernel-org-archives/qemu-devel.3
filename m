Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925C2C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 11:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5OAP-0007Uo-H6; Fri, 10 May 2024 07:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5OAJ-0007US-N3; Fri, 10 May 2024 07:11:51 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5OAB-0007yH-Tn; Fri, 10 May 2024 07:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715339504; x=1746875504;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8cRorBn5W4tPzPzXs0pSRSwG6nj57Es8FpZ40ERWXv8=;
 b=TUb7RN8uc9GfCIiVNnrC+EINoTquff8iFbU6vBFwFJprz9kzkA9wDZq6
 5laiO0ADGR7BjjnPlyLcw5c1dDzstKH70y89UscHKEt4eMCk/Df0QRHMf
 m+Ns9+29QAlGTHwRrGz+nMomBdCCxnLC5z3COC+izA3OwT55UOL5f+2Bw
 RYeXiSzXy6WYlHKApwesFwFa+jv6ziT6CXONqRsnhCvNnZXUuCbc7jvy3
 aaxYMYzv0ADNWXASYGpdKCNpPZFFM3jkinTKc3So+5+F0wLyL3AyOtR3E
 4p55YD+tNwQIs/XwtsHDnG91yBxPLlH5v5CD1NcAC1rKnpuIHPEXXv6JG Q==;
X-CSE-ConnectionGUID: R4hg0b/aSMiWDdlsI6aUfA==
X-CSE-MsgGUID: T+wg2baGRjyzzExbbf7IVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11445627"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="11445627"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 04:11:40 -0700
X-CSE-ConnectionGUID: B4GP6Jb+R8ucIz34xNvcZg==
X-CSE-MsgGUID: m47JkZyGQSiHv6XlK+DnNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="30138852"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 10 May 2024 04:11:38 -0700
Date: Fri, 10 May 2024 19:25:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386: fix operand size for DATA16 REX.W POPCNT
Message-ID: <Zj4EQI2sZKBGN8ny@intel.com>
References: <20240509152526.141855-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509152526.141855-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, May 09, 2024 at 05:25:26PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 17:25:26 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: fix operand size for DATA16 REX.W POPCNT
> X-Mailer: git-send-email 2.45.0
> 
> According to the manual, 32-bit vs 64-bit is governed by REX.W
> and REX ignores the 0x66 prefix.  This can be confirmed with this
> program:
> 
>     #include <stdio.h>
>     int main()
>     {
>        int x = 0x12340000;
>        int y;
>        asm("popcntl %1, %0" : "=r" (y) : "r" (x)); printf("%x\n", y);
>        asm("mov $-1, %0; .byte 0x66; popcntl %1, %0" : "+r" (y) : "r" (x)); printf("%x\n", y);
>        asm("mov $-1, %0; .byte 0x66; popcntq %q1, %q0" : "+r" (y) : "r" (x)); printf("%x\n", y);
>     }
> 
> which prints 5/ffff0000/5 on real hardware and 5/ffff0000/ffff0000
> on QEMU.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/translate.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)

Awesome!
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


