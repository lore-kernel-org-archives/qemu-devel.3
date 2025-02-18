Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF9FC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIr9-0001zv-1d; Tue, 18 Feb 2025 03:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkIr6-0001zA-4j; Tue, 18 Feb 2025 03:21:24 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkIr4-00016l-67; Tue, 18 Feb 2025 03:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739866882; x=1771402882;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gtUfZTFBrpSiRhD1YiYX57VNWMSKg8+WuLdttZUdjTQ=;
 b=SPUDHHdf/XGwBRy3RcFnEcSfRFZQn54pvDUcF/abUZhHpYgh6Ac9l3K9
 etS4ymGjj6yd+U9fckYnVtrhuTQHs04/S4PAtncWa1LVUXIej3qS0cTvi
 9DKrFuZw4JFHUm0nLyHkhXpnBDXd/oKUVywOWXaEcsohoHadT+umFjWR6
 pTWj/gKNGLF8uzZ6bDkxEYKmfJ8J379gCUQBcKcgrByVGvfKmQh7SoJO5
 R7pXde4DdMNHnZp5XzkIDWn3XI0Tl4aGG3MHOVjZWvxe1sGH0qjGz+p5q
 H5EM2mHdrnFJPmPkNvYXNXKLY/ymtM4LBS8SDNWEWQjRjiCs0HfOK2Eul w==;
X-CSE-ConnectionGUID: uexrVhPaSsKxu5qEE5vSfg==
X-CSE-MsgGUID: baGylXERR02qvCWdzCX/+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58087786"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="58087786"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:21:20 -0800
X-CSE-ConnectionGUID: 0rnF1547QgW5g8lWr6grhA==
X-CSE-MsgGUID: BjqEu0hqQlG6jPItSV/EtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114302862"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2025 00:21:19 -0800
Date: Tue, 18 Feb 2025 16:40:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] i386: Fix the missing Rust HPET configuration option
Message-ID: <Z7RHlbXUQuz1gfj7@intel.com>
References: <20250217154416.3144571-1-zhao1.liu@intel.com>
 <e43f8169-4017-4a3a-9274-4daf9919c290@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e43f8169-4017-4a3a-9274-4daf9919c290@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> The config item is already declared in rust/hw/timer/Kconfig, so it's enough
> to do
> 
> diff --git b/rust/hw/timer/Kconfig a/rust/hw/timer/Kconfig
> index afd98033503..42e421317a5 100644
> --- b/rust/hw/timer/Kconfig
> +++ a/rust/hw/timer/Kconfig
> @@ -1,2 +1,3 @@
>  config X_HPET_RUST
>      bool
> +    default y if PC && HAVE_RUST
> 
> I applied it with your commit message.
> 

Ah, thanks! I misunderstood your comment before...

Regards,
Zhao


