Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C26C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsKn-00049K-Ko; Wed, 20 Mar 2024 05:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmsKe-0003xq-9G
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:34:00 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmsKb-0003mG-8i
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710927237; x=1742463237;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2kbFZDBMdWPpGfdyoGRhQG8BDG98VozoPezIc8NCCKg=;
 b=LeTztP2GZEtATkw5BuHcBEZovODhnc4GVyDmhPSZgyBl+D2UdonKXn2I
 gkdRKWvJR97N3BwjKu3A5ODko/+wGeLqODFSl3QRXljVcE+yARg7HSNMN
 FmeJR9Qtek9PhED5L3nE+vePLZaqZQNw9FoohEiw2VQ0BTz6Mm7N6QQI9
 mEnO/Wxo4BYQC71ec0EFL9AURWTyAalx+rBrozfEtmNCRwxqDlcp2ldwe
 9tt0jJ2plT0HpEmifEmiHNrnkyDSwXYonLMSjkQLpdUtg7rcNNfNVZG2b
 F7jOONnKxpeBtiqtwK4Z3M89l1AGb91IAgf8VkyR/3+2sT1ff8bjBPC12 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16483093"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="16483093"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 02:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="18562290"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 02:33:42 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, xiangfeix.ma@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 0/1] Introduce Icelake-Server-v7 to enable TSX
Date: Wed, 20 Mar 2024 17:31:37 +0800
Message-Id: <20240320093138.80267-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

This is a new effort trying to enable TSX in Icelake model.

Currently Icelake-Server-v3 and above has TSX disabled but taa-no enabled.
This is a invalid config as taa-no hints TSX exist and is invulnerable.
When start L2 guest with both L1/L2 using Icelake-Server-v3 or above,
QEMU reports below warning:

"warning: host doesn't support requested feature: MSR(10AH).taa-no [bit 8]"


Different from v2 patch https://www.mail-archive.com/qemu-devel@nongnu.org/msg907730.html
This patch add a new version Icelake-Server-v7, so the compatility of old
version is guaranteed.

Comments welcome!

Thanks
Zhenzhong

Zhenzhong Duan (1):
  target/i386: Introduce Icelake-Server-v7 to enable TSX

 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.34.1


