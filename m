Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C2AE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 08:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLI0B-0000c9-5S; Wed, 11 Dec 2024 03:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLI08-0000bw-U3; Wed, 11 Dec 2024 03:23:21 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLI06-00045s-Rg; Wed, 11 Dec 2024 03:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733905398; x=1765441398;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QbNMElKkLe5Z28K8XQqkCoXTbVg1QiMIq+2vGW82Ikw=;
 b=gTxe/z4CVqq0L6GGB5ogjsr1Pcp24xfVSye3APyUabJSXkVTa1BCE+MI
 0bAXwmgY1LSRJBYSsYiK673LpV7mbDi1uZf/RS6vBQkJfwPuxehkJ6RWu
 E83bBplaVHxSJFgst2i8zBv0lE5FByU4dB4tSFLKGCmqfLcEwvKcW3GqC
 R97xJx6SWZKTs+vgRvO9moe78bfreMJE841XtF3IG2UiwVZ/bPG/vVQHK
 CgDBtvjAaNMtBRNGehaN+HlU60kPZtT1gET4FhRSoRkONjUM+YeaG5N0E
 8pcNm+65DKqdmg7G8gea+fNuWzJkwh+c/ieCbP9NF/dyooQnwysMTy9TU g==;
X-CSE-ConnectionGUID: 7fhyzV59TI2l/lctqUr/Dw==
X-CSE-MsgGUID: giGdenMZTHyJHYA3eZ0ssg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34399165"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; d="scan'208";a="34399165"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 00:23:14 -0800
X-CSE-ConnectionGUID: XUHTmtEmQi+Y4SgexgU70Q==
X-CSE-MsgGUID: 804ChhI5STiw9zpgqTahmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; d="scan'208";a="126548552"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 11 Dec 2024 00:23:13 -0800
Date: Wed, 11 Dec 2024 16:41:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 15/26] rust: qom: split ObjectType from ObjectImpl trait
Message-ID: <Z1lQOB6gXl4t/unY@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-16-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Mon, Dec 09, 2024 at 01:37:06PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:06 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 15/26] rust: qom: split ObjectType from ObjectImpl trait
> X-Mailer: git-send-email 2.47.1
> 
> Define a separate trait for fields that also applies to classes that are
> defined by C code.  This makes it possible to add metadata to core classes,
> which has multiple uses:
> 
> - it makes it possible to access the parent struct's TYPE_* for types
>   that are defined in Rust code, and to avoid repeating it in every subclass
> 
> - implementors of ObjectType will be allowed to implement the IsA<> trait and
>   therefore to perform typesafe casts from one class to another.
> 
> - in the future, an ObjectType could be created with Foo::new() in a type-safe
>   manner, without having to pass a TYPE_* constant.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs  | 17 ++++++++++++-----
>  rust/qemu-api/src/definitions.rs  |  9 ++++++---
>  rust/qemu-api/src/device_class.rs | 11 ++++++-----
>  rust/qemu-api/src/prelude.rs      |  2 ++
>  rust/qemu-api/src/sysbus.rs       | 10 ++++++++--
>  rust/qemu-api/tests/tests.rs      | 12 +++++++++---
>  6 files changed, 43 insertions(+), 18 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


