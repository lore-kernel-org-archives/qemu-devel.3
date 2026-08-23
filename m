Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92437C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 08:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy3vd-0002Rd-Bg; Sun, 23 Aug 2026 04:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3vb-0002RE-KM
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:51:43 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wy3va-0003jl-5P
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787475102; x=1819011102;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HsTvkY/tzGD7MqW7u4p4m7bQaDv0rZcBZwz9af28cQY=;
 b=HbcN36Ep30qgKHGmkBS6Q2V8QlU0GoyHpglTySv+q0AdllZRH0cKSXIa
 NpsyeD+h3fkcrQiQ7nLC2RIPi0puwMwBznkc6OmOXH8CQNpFVYYc8g7eb
 +JDK/jMyApeNjswiaF7yjuG9k8VDt3FgI8jnLGBtbZsZk66c5sx7lydfz
 Q9A9jJ3gNlXvYcZQxrp1fuUesjujZgJThyxbG/99g0RpeT4KC8WM6NVdB
 s7xMD/NMykYrGupsdPhrt4Fv83Sf1j2OenyD5Nb+t8i4+nc0VLmfX3h+4
 5d4HWvcOxfSfqw98zX7vuCHEw+xoPdREOTf12SJUu2Zw9sm7vqHelC7v3 w==;
X-CSE-ConnectionGUID: F7r2jTuqSTe8Y+gGen6dsg==
X-CSE-MsgGUID: xZh82xf7SE+tJvate3VQ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="75493388"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="75493388"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2026 01:51:40 -0700
X-CSE-ConnectionGUID: 3+F6gzEpRwujlESadOFDJQ==
X-CSE-MsgGUID: 9hS8K7LwR/27DfzpIIke7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; d="scan'208";a="271945648"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2026 01:51:38 -0700
Date: Sun, 23 Aug 2026 16:51:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 4/9] target/i386/kvm: Use AMD MCE status encoding for
 Hygon
Message-ID: <aoq0mWqm44i+4qw9@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-5-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-5-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 10, 2026 at 04:29:51PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:51 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 4/9] target/i386/kvm: Use AMD MCE status encoding for
>  Hygon
> X-Mailer: git-send-email 2.43.7
> 
> QEMU's KVM memory-failure injection path builds synthetic MCI_STATUS
> records for the guest CPU.  The status encoding is vendor-specific:
> Intel-style records use bits such as MCI_STATUS_S and MCI_STATUS_AR for
> action-required events, while the AMD path uses the AMD memory-failure
> encoding.
> 
> Today QEMU selects the AMD status encoding only for AuthenticAMD guests.
> Hygon guests should use the AMD status encoding as well, but currently
> get Intel-style injected status bits, including MCI_STATUS_S and
> MCI_STATUS_AR for action-required events, and a non-deferred
> action-optional record.  That can prevent a guest OS running on the Hygon
> CPU model from handling the injected MCE correctly.
> 
> Use the AMD injected-memory-failure MCE status encoding for Hygon guests
> as well.  This does not depend on Hygon exposing CPUID 0x80000007.EBX
> recovery features such as SUCCOR, and it does not advertise any new
> recovery capability.  The change is limited to QEMU's synthetic KVM
> memory-failure MCE status; it does not change CPUID, MCE bank state, or
> migrated CPU state.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/kvm/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


