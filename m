Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB37CF8861
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5jC-00040G-05; Thu, 20 Nov 2025 09:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5jA-0003zS-F1; Thu, 20 Nov 2025 09:33:40 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5j8-0006bx-UD; Thu, 20 Nov 2025 09:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763649219; x=1795185219;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sQyxYXW7PPbgad6LMRVwa4jqmK6s2KwTJtkRXoZqVk8=;
 b=beQHTH7LO/Y3nK9spZ2K0TfKTXqUZVzlCLUQZgQBFwLtzLGB3iJO5+Kl
 87EdeC9m2IA+LQNXvhoQ7acQBUqcR2bJ0J6R86xpR9JvsleoI5Ua13sPf
 eC925KN1c6/dgXofl9z5Ptbg/X1aAyDZPIIOpA0Yg0HYEdCxpJmNQV7Gj
 lgQmUXaqHE7Me1dRr9MsONxZaEkir1Eg6VQn6//B/BFuNnSnyjn++Qr+0
 j74SP66zdWDl6bs8f5BlBZOTUIZwHl34nWQ/VtELBVtnU8ge21HBUqoon
 gsz3OT3MFtJUvLMF2a5gyMuEs+VHixf7Byecnl5QJqIdE4/VzdN+wfWwT w==;
X-CSE-ConnectionGUID: RhUOtFLeQ0aUWgHEUm5+KQ==
X-CSE-MsgGUID: Kinya3hDQcWTraCTMB5wGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76824898"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="76824898"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:33:36 -0800
X-CSE-ConnectionGUID: iNkqu0PST0O5MuzQO2Nlgw==
X-CSE-MsgGUID: eSoSkmy/QXuBrOhkef7vzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="191058805"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 20 Nov 2025 06:33:28 -0800
Date: Thu, 20 Nov 2025 22:55:48 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 3/5] nbd/client-connection: Replace error_propagate() by
 assignment
Message-ID: <aR8r9PwcBCqidxUp@intel.com>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-4-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Nov 19, 2025 at 02:08:53PM +0100, Markus Armbruster wrote:
> Date: Wed, 19 Nov 2025 14:08:53 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 3/5] nbd/client-connection: Replace error_propagate() by
>  assignment
> 
> connect_thread_func() sets a variable to null, then error_propagate()s
> an Error * to it.  This is a roundabout way to assign the Error * to
> it, so replace it by just that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  nbd/client-connection.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


