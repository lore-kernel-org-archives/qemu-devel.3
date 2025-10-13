Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D236CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8DuA-0006nr-D8; Mon, 13 Oct 2025 04:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Du8-0006na-5O
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:27:40 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Du5-0006C9-Op
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760344058; x=1791880058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=q7TYhdYTv86/nxawYtKgBBDeue+nyd2hDrQSnR0MzNA=;
 b=h1r/bicODkiANq67xVikWvz4gMUxsc5nuV79hYrXa1ByGE9ImG7AKx/p
 DQdYrWdaC4dWE+Jdh+MQqz3l6OU0PpchWL6GGSOIdubWDmnqhW8eSUJia
 lMDXm6hPsbarTVvZXHP0pCQPkjpFFKVZKVzqTamOhAkxjjcjFVR3ZkTJz
 o/pOcOoJUDjrxoygpVxxppIUqab9RWlGcy/ZJ/Ycq1gJBoHDUdmxnkc6V
 9NpaVvVdDqs0zwszs8anst0EXBhqbs5IipS3TTt+yRzonA9kLJi994M/1
 NFp8tBMEfi6BdhYvc49iAYzsiZ9MbSaXCjxzlANVWr31sbkAk16DSncLH A==;
X-CSE-ConnectionGUID: SmkyWGAsQu61QdH3EUm6Lw==
X-CSE-MsgGUID: vZsXHJF/Q+Wwu3wWAqpdPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62510662"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="62510662"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 01:27:34 -0700
X-CSE-ConnectionGUID: 8D1b+olRQGqL8PCbyWeGoQ==
X-CSE-MsgGUID: Yc34iv/3RO+C5qmbYOwUVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="182300892"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 13 Oct 2025 01:27:33 -0700
Date: Mon, 13 Oct 2025 16:49:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/11] rust: bql: add BqlRefCell::get_mut()
Message-ID: <aOy9IRfyUP8UWQNz@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Oct 01, 2025 at 09:52:00AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:00 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/11] rust: bql: add BqlRefCell::get_mut()
> X-Mailer: git-send-email 2.51.0
> 
> This method is rarely useful in QEMU due to the pervasiveness of
> shared references, but add it for when a &mut BqlRefCell<> is used.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/bql/src/cell.rs | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


