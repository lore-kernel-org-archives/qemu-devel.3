Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669B5C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 09:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDhIN-0008SX-PG; Sun, 02 Jun 2024 05:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhIJ-0008Pt-5D
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:14:27 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhIH-0002GJ-CD
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717319666; x=1748855666;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FzCltDZcaYQ0ko5ZtEtfUJ+WZffvUMa61a8Q6kSusnU=;
 b=R4Xsd/bUtjVHUwZiy+I4A69Bg7SPfb7wdzIT54nmwWF02OHQS0+xia6V
 +U0txfd/TM2LlDoAxFpgniobg8v+nVRWAv/qCaKVM5oIXZA+7yfaWFzOa
 OeKW3MiAGWcpUGyerwd+swLyM+GcxmFOQ7JguGgTOcj69/KAm31ANKJjD
 YwnV1IxS8EQ5D1cIJaGtyBZzD52w05Kv84TxYn2E/0Y6T/IE5iUR1hgPg
 bJswinpkeDwlgo1HhrxonAdUX07OEdh5V50ZGrE2aND1wsPWF333ExpK9
 DW4NDOti6TzuafA7bodPKuxsQdWk9LtysX0iS2baPwcUt3kOYX3pr+muv w==;
X-CSE-ConnectionGUID: xJJrKHzxSBGuD6OQtt218w==
X-CSE-MsgGUID: +FoVtQYkS5CQnq94SfUAwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24400989"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="24400989"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 02:14:22 -0700
X-CSE-ConnectionGUID: v0jMSUUoQvm2DjxXVck6fA==
X-CSE-MsgGUID: pmNPg4lpTwSyWtHY5ljPMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="36523876"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 02 Jun 2024 02:14:20 -0700
Date: Sun, 2 Jun 2024 17:29:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/6] host/i386: assume presence of CMOV
Message-ID: <Zlw7ikB4YyF4b3Oi@intel.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
 <20240531091457.42200-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531091457.42200-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
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

On Fri, May 31, 2024 at 11:14:54AM +0200, Paolo Bonzini wrote:
> Date: Fri, 31 May 2024 11:14:54 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/6] host/i386: assume presence of CMOV
> X-Mailer: git-send-email 2.45.1
> 
> QEMU now requires an x86-64-v2 host, which always has CMOV.
> Use it freely in TCG generated code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  host/include/i386/host/cpuinfo.h |  1 -
>  util/cpuinfo-i386.c              |  1 -
>  tcg/i386/tcg-target.c.inc        | 15 +--------------
>  3 files changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
 

