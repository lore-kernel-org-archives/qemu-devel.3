Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCF2D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jY3-0001vN-6e; Fri, 18 Oct 2024 05:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jY2-0001v6-GT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:45:30 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jY1-000274-1y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729244729; x=1760780729;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Mhe4QwFWqBOejXbhJUnZkjB4tRpAMFfPzB0Mb6ctaY4=;
 b=dXHfmrkApr6c4ed2yciJucj2PoJSTC2TrOCYGKrclXnOPYNdWTshXl+K
 7+6bDp1g4D+6pqg8B0iaqJQRb6q4sR/z/5nCoUMGXH1MT9ug0iVnbVsX3
 N5uZ0soj16mr9/SgSGYff7z7qS+rVNs+w+wBFNBeqeoS5HBd6c39zbgpQ
 1XyaPeIyIi3ioBzhOJFk7DtTnD6iC2FFyN0WPFZCvymNT525xmhjk5BG9
 vo+cdhkTA/eY5HMJRRnAZ+ferCh6Sem9vOouAkwJjc6TkCCkhtvapXm0p
 ndhR+ILVjjvJTBj4b4kQsL7d26+3h1+33KuXJXRY1bjo+BDheWTk+ZRXv Q==;
X-CSE-ConnectionGUID: CsRE6Bc0Syu9gYggl1qnig==
X-CSE-MsgGUID: kPRNrG/ITGOK8WYrNovKNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28558835"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28558835"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:45:28 -0700
X-CSE-ConnectionGUID: IZ5ysOSbTOOfGkucOK4BWQ==
X-CSE-MsgGUID: jlvKUhAuQLW6t0T5q6s5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="83891229"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 18 Oct 2024 02:45:26 -0700
Date: Fri, 18 Oct 2024 18:01:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 17/31] qom: adapt to new import path for qobject data
 type headers
Message-ID: <ZxIyBfD39cr0tVnO@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-18-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-18-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Thu, Oct 17, 2024 at 12:33:29PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:29 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 17/31] qom: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qom/object.c            | 10 +++++-----
>  qom/object_interfaces.c |  6 +++---
>  qom/qom-hmp-cmds.c      |  4 ++--
>  qom/qom-qmp-cmds.c      |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


