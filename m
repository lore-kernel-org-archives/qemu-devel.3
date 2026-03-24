Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD177F532F0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4x7A-0001Ws-Kj; Tue, 24 Mar 2026 04:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w4x79-0001WJ-EF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:27:51 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1w4x76-0003MW-EL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774340867; x=1805876867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sEzOecBAeLInZVU7Oy8wPWznLBPjBo2F4mUcxbDRw24=;
 b=hpTnhs7QjmsdqL7wSqClPWNPXwm2nFscYCok+KJCjqvnETuqcAfMJR5S
 omWFx4RzEtXQzcITPSC3thxFrgdUqIboZdhmwfmzd0iXZODRkYZI2ew2a
 Wy4WVM+WudrTGUULpZ9Q6/M1DJJNvPoPugJFMlKPLl//uaaIsnxMlasdl
 yJBelv3iu/WomfwCYKo6eQJHxnwO26pmpu+RPjD9ZzmPimuNgWVufuN6B
 kDpljJsnHDGQpdrnwlbR4PsLp7zkyBSt81vgSzqg9Wujxk05/N8pEz+kj
 ASrGsU9CEzTeESL+C8A/c1DhFKbWhJDSq47msMbRdz8JnsnWjBGlVR8EM A==;
X-CSE-ConnectionGUID: rRK6BzAWQ7e5Xk4YUJHJtg==
X-CSE-MsgGUID: LAouPrlATuK97Ljq1YVvqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86424450"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="86424450"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 01:27:44 -0700
X-CSE-ConnectionGUID: n1aTnLcYThWLJ0eqbq9mqw==
X-CSE-MsgGUID: 7LPltfwSRPazg86nsY4xlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="229217046"
Received: from junjieca-mobl.ccr.corp.intel.com ([10.124.242.111])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 01:27:44 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, farosas@suse.de,
 junjie.cao@intel.com
Subject: Re: [PATCH v2 0/3] migration/file: fix type mismatch and NULL deref
 in multifd_file_recv_data
Date: Tue, 24 Mar 2026 16:27:38 +0800
Message-ID: <20260324082738.841-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260318140113.434-1-junjie.cao@intel.com>
References: <20260316084618.52-1-junjie.cao@intel.com>
 <20260318140113.434-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=junjie.cao@intel.com;
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

Hi Peter, Daniel,

I wanted to follow up on this series.  Looking back, I went
straight to adding new public API in io/channel.  I should 
have confirmed my approach and whether the Suggested-by
tag was appropriate here with you before sending.  Sorry for that.

I see two possible paths and would appreciate your guidance:

  (a) Keep it purely a fix in migration/file.c: add a local
      retry loop around qio_channel_pread() in
      multifd_file_recv_data(), fix the ssize_t/size_t
      mismatch, and use ERRP_GUARD() so error_prepend()
      is safe.

  (b) If pread_all() retry helpers are worth having as a
      general facility in io/channel, I'm happy to propose
      them as a separate RFC so we can discuss the API design
      on its own merits.

I'm leaning toward (a) and can send a v3 quickly.
Does that sound right?

Thanks,
Junjie

