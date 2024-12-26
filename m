Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A351E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 03:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQeHH-0000ZB-1M; Wed, 25 Dec 2024 22:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQeHF-0000Z1-Ru
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 22:11:09 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQeHB-0002Vl-1J
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 22:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735182666; x=1766718666;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9T3O/Jb631rQymePER93FuTvIpsKxHRDg9V8dTYFMrE=;
 b=CNLPUe7NvpKwrmmrBREm0aZbCjaWwT60UoJQICh+aXRFUuMQ16zxxPOf
 UCYLX/3MZp48lA8tOOL5hmoB6k3w3fQ2lEnhj5v4PNYTIiGsebFhjEbI2
 iagGsqxOfTimm7S71GbAXqZ7wUts4xcDOLfpDJLKStadC1KBy3Sg/xUpb
 MBoo757i9HhW4/WeMMBAZFUbU22N7nMn+D+IAWgfJlaZm+PNVVQkCJUEq
 pRODlxbO5Kkht1p/8Jnw2XCkc8u8dkbGc2XXAv5ZLqwruK2L0p0R9vx6w
 /FID+hGdzzRsCheQZuRmYugbahb5I2Fsij7VwJ3KJt2c+LZ9yelg5XBD0 g==;
X-CSE-ConnectionGUID: cxJpUvUzTyeTSzE3LgcaPQ==
X-CSE-MsgGUID: 4ZUhbVgAQKWBdhy2CoDSUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35741508"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="35741508"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 19:11:02 -0800
X-CSE-ConnectionGUID: tXSmfGMoTbqgYsh1aMPwiw==
X-CSE-MsgGUID: cGeCZzZmQK2T/K3ofqzy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; d="scan'208";a="104672114"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 25 Dec 2024 19:11:00 -0800
Date: Thu, 26 Dec 2024 11:29:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 08/12] rust: qom: make INSTANCE_POST_INIT take a shared
 reference
Message-ID: <Z2zNpxqnthFuXJPq@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Dec 20, 2024 at 03:29:50PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:50 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/12] rust: qom: make INSTANCE_POST_INIT take a shared
>  reference
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 4 ++--
>  rust/qemu-api/src/qom.rs         | 8 ++------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


