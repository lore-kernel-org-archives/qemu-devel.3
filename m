Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85114CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmtO-0001GP-8K; Tue, 25 Nov 2025 01:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNmt7-0001FH-Et
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:50:58 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNmt5-0006zz-9J
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764053455; x=1795589455;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0xMOXh64Qj6FUi9OW+34MUNTCcFZOabjDcChTGpC05g=;
 b=b86tb7EUO1tD0qTimjKu6cRq/B8NB7cJApVRs4ZzVA2euUpTRMEdVdkF
 61gSJP/Mz6AchP0bQMfONTjvL3dyy1okxSmgW66I5t0yIo3IX7K7Uzkwn
 evQoztuYqzw1QHom2G286yP+q5SIZD8Jb/JIkkLTHo3N//zu03RzUHgY6
 TFyk+8+TkpVQY10FBkXjdunq5jgjR9B9bSM3Xeo6cj5XFsXNpFnDKzNQM
 dPJ89Sx45vrBn/DW7T/LT4LNmIzw5DgWO71ONb6kXTCCz/A99YWRPklIo
 TxqUBuquXTIWVXM+4epRR9ZkYktv41sP6DaEBJEY+iXZpahGMqRrpAf4S g==;
X-CSE-ConnectionGUID: nPAzliGqS0idjQGnGnpJew==
X-CSE-MsgGUID: o0PKO+geS4yUhSs4iCyeSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65954465"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="65954465"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 22:50:52 -0800
X-CSE-ConnectionGUID: WclvZ4oGTsW9/afbp8i3Vg==
X-CSE-MsgGUID: /BauVHzGTpuXnO8v/MYFqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; d="scan'208";a="196729166"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 24 Nov 2025 22:50:50 -0800
Date: Tue, 25 Nov 2025 15:15:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v2 2/4] target/i386: Add cache model for Zhaoxin
 Shijidadao vCPUs
Message-ID: <aSVXkYQFH8qG6DO7@intel.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
 <20251027102139.270662-3-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027102139.270662-3-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On Mon, Oct 27, 2025 at 06:21:37AM -0400, Ewan Hai wrote:
> Date: Mon, 27 Oct 2025 06:21:37 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v2 2/4] target/i386: Add cache model for Zhaoxin Shijidadao
>  vCPUs
> X-Mailer: git-send-email 2.34.1
> 
> Zhaoxin "Shijidadao" vCPUs require built-in cache enumeration in QEMU
> to properly report CPUID leaf 0x4 and 0x80000005/0x80000006 when
> 'host-cache-info' is disabled.
> 
> This patch defines the L1/L2/L3 cache parameters for the Shijidadao
> architecture, preparing for use in both client and server models.
> 
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


