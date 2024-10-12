Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9AFD1A45A
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 09:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szYAo-00069I-VH; Sat, 12 Oct 2024 05:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szYAn-000692-JS; Sat, 12 Oct 2024 05:12:29 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szYAk-0006BR-NC; Sat, 12 Oct 2024 05:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728724347; x=1760260347;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Mltib4iAQsYkU6j1CTj6sO6Rv+aGuPHCxB0PFfJcUb8=;
 b=BkjgGrF4ljDke/Ns+AvymQVlCKKwDfOtPzecPsk0Rj4XT/Y5WUyRDGI1
 PoPOJnl0ki5ToFzduWVaXZNy8xFvxdjD9XHCf0KmnAk4tvAGmo9TYRa4e
 4VSoXEYkQ5lTJI6Rl45S7NKb8tpfhNGVNS8ELHdLEQ2PGDmEkPU0n8cWK
 9oKaYG7ziOTO93OlOIApKVymGqk1ChiXGeuXIeVDtNG2IV4HAo0SdOu1w
 mmKrHntgs9iWzsJ1Bke2YduqKWIFRzbYj02Kz/YURNWL7xjlMZTdn9ZMm
 f9nVBpW671mF2LGu1Ts6hGsWwCgHZzQe1Jxkf5d8CCE8xQBjlX6hwcNvI w==;
X-CSE-ConnectionGUID: cPYXtIsyTYuK8wHTEbrATg==
X-CSE-MsgGUID: pt2DU9DpSLWDN6kz9kvKjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28258904"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="28258904"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 02:12:24 -0700
X-CSE-ConnectionGUID: zF163UddRaqxkXFV7sdHmA==
X-CSE-MsgGUID: 0KQWhQCsThO+jxkE0pAG/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="114586340"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 12 Oct 2024 02:12:20 -0700
Date: Sat, 12 Oct 2024 17:28:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZwpBQrx4w4h9v1ah@intel.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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

> This also is consistency with the SDM, where the comment for bit 23-16 of
> CPUID.1:EBX is:
> 
>   The nearest power-of-2 integer that is not smaller than EBX[23:16] is
>   the number of unique initial APIC IDs reserved for addressing
>   different logical processors in a physical package.
> 
> What I read from this is, the nearest power-of-2 integer that is not smaller
> than EBX[23:16] is a different thing than EBX[23:16]. i.e.,

¡°not smaller¡± means ¡°greater than or equal to¡± (¡Ý).


