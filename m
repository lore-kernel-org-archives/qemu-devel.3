Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A49C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmO6-0003kf-Ra; Mon, 27 May 2024 22:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBmO4-0003kH-7p
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:16:28 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBmNz-0007mp-9N
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716862583; x=1748398583;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xwskCFtjJm9HY3fmEi22EpR4C/6Y0ofxp7Cw19m98z4=;
 b=iRMQNeYBDovcYxFQZx1fruz1Kv6SRSAkfzC+ClKiKPHi2PucBGE/5nj9
 hqh6JCz4TJBBaRt8SPoC2EJJ4tA31Lz63ZbuJYcdMWsqAKjLU5267SW/f
 pS/1Y7WVDs+WP+2HF0A/WQgFHEFLq0Eu5cPIjyB8sQIbDdmYOcZzgTr98
 hjVV6KhmATThCiD0H68VUqbWrf70c1LjXL9ILwZadQkzBcTvkBZ9VYF7u
 8GT5BJmBIVDC34hscp8uYQlDaNGHG3ms1nB1cKeIn1upGUw1fbRrTm1c7
 C7+6hAuRu+J7K/NYyYLTPHUPgOOhtaQa1VUIHlafk5czUnSsqdAK3NTgz Q==;
X-CSE-ConnectionGUID: z6MBfhB6T7OGFKh6NVgZqQ==
X-CSE-MsgGUID: CMJHGHxlRjCHx7yhglFIkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24604125"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="24604125"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 19:16:20 -0700
X-CSE-ConnectionGUID: ns9X9y6PR12O6/PniafeCg==
X-CSE-MsgGUID: zKuWqogDQLGHqCh/qEaH2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="34828926"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 27 May 2024 19:16:18 -0700
Date: Tue, 28 May 2024 10:31:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] x86: cpu: fixup number of addressable IDs for processor
 cores in the physical package
Message-ID: <ZlVCDdpTvu9HmV/W@intel.com>
References: <20240527031333.85932-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527031333.85932-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 11:13:33AM +0800, Chuang Xu wrote:
> Date: Mon, 27 May 2024 11:13:33 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH] x86: cpu: fixup number of addressable IDs for processor
>  cores in the physical package

According to the usual practice of QEMU commits, people tend to use
"i386/cpu" as the subject prefix, which indicates the code path.

> X-Mailer: git-send-email 2.24.3 (Apple Git-128)
> 
> When QEMU is started with:
> -cpu host,host-cache-info=on,l3-cache=off \

Just a discussion, "l3-cache=off" doesn't work in host cache pssthu
case, do you have a specific need that you don't want to see l3 cache?

> -smp 2,sockets=1,dies=1,cores=1,threads=2
> Guest can't acquire maximum number of addressable IDs for processor cores in
> the physical package from CPUID[04H].
> 
> This bug was introduced in commit d7caf13b5fcf742e5680c1d3448ba070fc811644.
> Fix it by changing the judgement condition to a >= 1.

Pls add a "Fixes" tag like:

Fixes: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")

Since this is a historical issue that deserves to be ported to the
stable branch, you can cc stable list by:

Cc: qemu-stable@nongnu.org

> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>

As the patch sender, it's better to put your signature on the last line.
;-)

> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cd16cb893d..0369c01153 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6097,7 +6097,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              if (*eax & 31) {
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                  int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> -                if (cs->nr_cores > 1) {
> +                if (cs->nr_cores >= 1) {

Like Igor suggested, this condition could be removed since cs->nr_cores can't
be 0.

>                      *eax &= ~0xFC000000;
>                      *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
>                  }

...the code is outdated, pls rebase on the latest master branch.

Regards,
Zhao



