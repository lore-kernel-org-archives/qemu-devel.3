Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128F0E6C60F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 07:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tINB0-0008Ar-Fq; Tue, 03 Dec 2024 02:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tINAy-00089v-SY; Tue, 03 Dec 2024 02:18:28 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tINAx-0007OV-Bo; Tue, 03 Dec 2024 02:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733210307; x=1764746307;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=g1p7ypTgbIDo2kAakWW29oZ132lTGOCrVOm0ThfGnhA=;
 b=Tkhk9U7+2x3UXuYrqnq4/ahLzw0aqCVpVxuTFjyzmTUnbh2CS9g6EJx4
 JTv5fqDUrCV7zBUMuCrVSmK+zQdneyOqBYeOfFUYMMn3J5BWK8Ks+89DG
 88f1Tu6EKy3OBvtS2ehLHO9bXMEZdC+TU6oAMmM8wugZ6RCIo/ET+omsu
 6tTtZ4No7I8HpwfTYa1FMJGY1ijo/Q8BUEucGnVnBpAdUAl/5+WlHIjtv
 SGfHlMs9TeUSWbbzzakESKNZr0SMcXkT/lVOqlvfvd9EZowhjaF67bN7e
 3RgQjPhf4d5z9ZOoFZuTfDQQss3k1VuM8L5olqCGi+OF1ZF9QoHM/74Qw g==;
X-CSE-ConnectionGUID: dEnMzftHTl6OaI35Pj7QbA==
X-CSE-MsgGUID: oGVSreouRi2T6rzcp/Y61A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33332364"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; d="scan'208";a="33332364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2024 23:18:25 -0800
X-CSE-ConnectionGUID: WR1f7qTFT0+mdhuFGPYDpA==
X-CSE-MsgGUID: RGRB0EFDToK4dt+4P3QvXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="98362748"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 02 Dec 2024 23:18:22 -0800
Date: Tue, 3 Dec 2024 15:36:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <Z061AeZRyw4jwWjd@intel.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Hi Chuang,

Could I pick this fix in my later series (with another overflow fix)?
I can help you push this fix forward :-).

Regards,
Zhao

On Wed, Oct 09, 2024 at 11:56:38AM +0800, Chuang Xu wrote:
> Date: Wed,  9 Oct 2024 11:56:38 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
>  processors in the physical package
> X-Mailer: git-send-email 2.39.3 (Apple Git-146)
> 
> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> On Intel platform:
> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
> logical processors in the physical package".
> 
> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> CPUID.04H.EAX[31:26], which matches the expected result.
> 
> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though threads-per-core should actually be 2.
> 
> And on AMD platform:
> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
> result meets our expectation.
> 
> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> only for Intel platform to solve the unexpected result.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>

