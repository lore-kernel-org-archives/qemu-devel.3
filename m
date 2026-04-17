Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C813F43680
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDet5-00038G-7N; Fri, 17 Apr 2026 04:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wDest-00036X-5r
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:49:09 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wDesp-0002R5-2Z
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776415743; x=1807951743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bpZW03NehBjFWJkspr9o8dFmsMQ8ImT8rM8K+haBca0=;
 b=D3RPXJtmsAOCYGaxzu8b9NoEajuopc7SVNSvRiN3aQ618zpJthjcOZER
 G/it8eQ7BTq6dumdz9hK1o7oOFwrWGkVOV4rKT4ra7DunSYfMwrWYLKiw
 0EDG6yvcUfHrNEGerR4a/qLuthqoCX2HQmGFHC6LgYnvTJiKwrNkq2TeG
 RmMZGBmf7ZNLKmdXrAkz13mLPaH2lrfCCBN3oF7sl19eZ9U0PuRpeSJXq
 IV+/az3Eb8FyOMMOAU6/Lf1GGNraGtaVKky6ZoKlMqQlZ1xflgAsDRYBa
 tpIei4T4vkwSS/ydAQMI/nTsWBrdgS/78ehLTvnYo9Sid7UBpAmjWScZD Q==;
X-CSE-ConnectionGUID: w7K/ay68SBWVx7Okf9Rs2w==
X-CSE-MsgGUID: nLymYfnPTsOLDBzehghEJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88047809"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; d="scan'208";a="88047809"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 01:48:59 -0700
X-CSE-ConnectionGUID: Fo+FJx5fR1yTjeMFBpHVow==
X-CSE-MsgGUID: J/AlHmM0RZy4FWVUjqXrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; d="scan'208";a="230125696"
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
 by orviesa010-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:48:57 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH v3 0/4] io/channel: complete pread/pwrite_all API and fix
 multifd_file_recv_data
Date: Sat, 18 Apr 2026 00:51:55 +0800
Message-ID: <20260417165155.7714-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413214549.926435-1-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel, Peter,

Just checking in on this series -- does v3 look alright to you?

I have a follow-up series that depends on this one to fix the
remaining positioned I/O call sites in migration, so it would be
great to get this moving.

Many thanks,
Junjie

