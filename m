Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDD2D2FFE1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jPf-0004Vd-VA; Fri, 18 Oct 2024 05:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jPd-0004OX-S5
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:36:50 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jPc-0001DF-DK
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244208; x=1760780208;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=g/1LyN4RLubWHa651cxoSTuCWqAAsAIe7AJTRTDsTVM=;
 b=GVXM5JpZ9wQzazpLlez2+Xx8Ne3CXwMxwnfFiANYB/HkvKYUQUHNG0Zv
 1TqhC6yMNbcEDGMJtjA4juPgoxwMB+1q/17z6rDhA5/LdYbJkm0i8lhxE
 oHzbNYMCdiAeKWiP0bFDvBvcsIxw6WtKOu0V57KPtgRWe0oQOs+HhwV5/
 /7ViYhaD+b/Wrz6RqAPG7LlZDacTf3WXb96m13absncZwUA5Xqf11huSq
 T9EqAEdq7RLCrgGYCpnU8yRNKGpbGO65tYBZdB/20HKeuZ6+bSSFrbpQ/
 S1Za6gDRwpPzoOdt3RHpe/sHrxpzkiGJL6r3czv8ktWVrjzlhMQsHF+lG g==;
X-CSE-ConnectionGUID: A7qG730dQ9OkW6bn1Yo0xw==
X-CSE-MsgGUID: aYv8AqWyQs+4e++ap6gttg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="40129799"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="40129799"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:36:47 -0700
X-CSE-ConnectionGUID: QFR6LRjGRPuOAcUcu+iCpg==
X-CSE-MsgGUID: 5zLfq/c7QoWcwJIfNJ7LPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="78968297"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Oct 2024 02:36:45 -0700
Date: Fri, 18 Oct 2024 17:53:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/31] dump: adapt to new import path for qobject data
 type headers
Message-ID: <ZxIv/TVJ9BDClpZN@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-9-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-9-berrange@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 17, 2024 at 12:33:20PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:20 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 08/31] dump: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  dump/dump-hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


