Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8DAC531D0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 02:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woXN0-0001jI-CP; Mon, 27 Jul 2026 22:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1woXMy-0001j4-7M
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 22:16:36 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1woXMw-00054Y-HE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 22:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785204994; x=1816740994;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e9B2XuUbw9gkM4v5b7dH80+GKhEcyobHN2CEWZ/qlFo=;
 b=Vv9KZ5ssiZEYndq8YtzTJckJL85tky7YCiDhwMhgI2cIR+ugDM1CpniT
 BjVECzcdSUcmruJr5ctxfeEmEZAf4541GX4ym+KgnE+wyPvfd+3NPXTp8
 0y98upwYjnOMGPYaXptvvN87UwtFBPVtNYFl2rVtobNX2qw1KM9NqCQB6
 FscPDyqmawJyFUat3Kr+bpTVA4gr56q1gJ5BScMSit7CcuIEzfcPtVr7Z
 sL2Pe2hwPZb7tRtuXr+gqhe+OjJrq1WheFowVoVMAaea7+HjB22uOTMMY
 451zwiDLMLy4YufaCXOuu//TFVVchCURpRuw07UF76h9gKlPzrQluRWh2 g==;
X-CSE-ConnectionGUID: zW3+3a3SStezRXRI3fBoow==
X-CSE-MsgGUID: Rs93k/Z+Q2ebyypfP7VlmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96137616"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="96137616"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 19:16:29 -0700
X-CSE-ConnectionGUID: oGXMZR70S+qq5l83EgtJTQ==
X-CSE-MsgGUID: 1YvSg3d4QPy8vyNO8xU2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="258305617"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 19:16:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: jic23@kernel.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hw/cxl: free in-flight sanitize state on reset
Date: Tue, 28 Jul 2026 10:15:35 +0800
Message-ID: <20260728021535.514056-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <14f4c087-6d7b-4839-88d5-8134b8120007@oss.qualcomm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Hi Philippe,

Thanks for the review!

Will do both in v3 -- a cxl_destroy_mailbox_t3() teardown counterpart
called from the reset path and ct3_exit(), with the sanitize discard
folded into it via a helper shared with __do_sanitize().

One naming tweak: the helper is cxl_discard_media_op_sanitize() rather
than "cancel", since __do_sanitize()'s normal completion path shares it.

Many thanks,
Junjie

