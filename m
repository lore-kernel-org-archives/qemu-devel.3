Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6658D6406D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 03:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vViF4-0002TT-2X; Tue, 16 Dec 2025 22:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vViF1-0002TF-17; Tue, 16 Dec 2025 22:30:19 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vViEy-0005HZ-P1; Tue, 16 Dec 2025 22:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765942217; x=1797478217;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fZfcEjPUKBFnIVchpem3UoWR6ijquN/H5TV75jV+iJM=;
 b=bd6zjo39GT+wg5nDYAVLHq71LrKrRK/0WPa/tObYeHPcKBes7YGqG6m0
 yIvc5uzEB7l655ju7/KmIGJBje5/4cJP21W0uLPnUvo56MNao85E5o4bf
 ihMxZuRC2HQzxehj1gXNE6BUG8EtNAnd3U27Uwt/Ei/MOwT3WWI5ZTHDU
 t+S1beYax9bKP9k64sKgaiDRqKESC6hsiYF53LTe5761JpgIbB7ngf/A3
 nDO9O3MKPsSIzVxVOL+p3/0Xuq89sm9qyo66V26aLrnPub8juahimFzpH
 Ki7XZ3gPcGvS0QhzyLnjYQSBx+XNnEGFcif6xEYCcHWLaLPQt0s648c8t Q==;
X-CSE-ConnectionGUID: wYH1Rph2TRiDt7iaLsVR1A==
X-CSE-MsgGUID: RCkC/gVoSuK3gOjd2ozGnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67810540"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67810540"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 19:30:13 -0800
X-CSE-ConnectionGUID: 2LNb3YkDRQO0jH2fc+hysQ==
X-CSE-MsgGUID: wFWJxZyuTdOAsrMOXMoD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; d="scan'208";a="202382794"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 16 Dec 2025 19:30:11 -0800
Date: Wed, 17 Dec 2025 11:55:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: Re: [PATCH 08/11] rust: skip compilation if there are no system
 emulators
Message-ID: <aUIplPBhj/rhakbf@intel.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
 <20251215075000.335043-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215075000.335043-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Mon, Dec 15, 2025 at 08:49:57AM +0100, Paolo Bonzini wrote:
> Date: Mon, 15 Dec 2025 08:49:57 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/11] rust: skip compilation if there are no system
>  emulators
> X-Mailer: git-send-email 2.52.0
> 
> Otherwise, the Rust crates require the corresponding C code
> (e.g. migration/ for rust/migration/) but the dependencies of
> that C code, for example the trace files, have not been built.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/meson.build | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


