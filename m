Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8A6C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfXGw-00088D-QC; Wed, 28 Feb 2024 22:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfXGu-00087u-Ow
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:39:48 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfXGr-0001yM-Lk
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709177986; x=1740713986;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MR9Hfywb5oVKthMwsL85SqTlZD7zmVScv05gZwmLqXQ=;
 b=kgZWqNMz/Mo6zecTTSE+stLRwbnHik6VwIhfywRxtqDNXYC2tozYLS6p
 Bvy9ur6dD9TJm1GiXs3Fe655YcBMoBN35KATdoCtTXbnJnuqK3gwhVxLT
 CJSCNCYhKO7E6IGZG5gFc6EENctJKnbJ5YMd3oy9vj6jPdkk7PERy6nuj
 RPF7K1EBiGbf+AQ41aB6rsaxKuz1B/cAmmxgfkrg4YsWoYZTgAVwulovy
 vO05BRf/GNtcw84ohZpk1rVO/EneiDFo67fvxatmilmtUzZTMjHfDYjUF
 RmY268f4TIo6tW4wEPGJfC+GRkY/uXdvzuLCoRWi8vSnbcuWSutKhlEl7 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21082845"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; d="scan'208";a="21082845"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 19:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7592526"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 19:39:40 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/2] Optimize user_creatable_add_type error path
Date: Thu, 29 Feb 2024 11:37:37 +0800
Message-Id: <20240229033739.1123076-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a simple optimization to user_creatable_add_type error path.
Removed local_err and its check in err path, use *errp instead.

Thanks
Zhenzhong

Zhenzhong Duan (2):
  qom/object_interfaces: Remove unnecessary local error check
  qom/object_interfaces: Remove local_err in user_creatable_add_type

 qom/object_interfaces.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.34.1


