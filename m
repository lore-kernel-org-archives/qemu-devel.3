Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8002CC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vey-00049D-J0; Mon, 31 Aug 2026 02:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0vex-00048J-Ag; Mon, 31 Aug 2026 02:38:23 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0veu-0003qh-Cz; Mon, 31 Aug 2026 02:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788158300; x=1819694300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9wlVfmVmE1FZIlAm8hbt7PCWwaL9R9CYrkrpj+LUYAQ=;
 b=jA+MhHsZpdO8WxHka+6hkNGZB1KqKdX+urRAluGkWUKn/cR2938q5LTi
 SwgkVOfQqRJnGy2mIaGwNgfzql9QccPuGee2PPJS4pZsX6D9Cmi7L4FwY
 Qos5nEn3qnikD3py+rwvecvNCtK9sh8NYdBtMw/WlgQB1TaahL/6JbiRy
 CJ3J5wQdzSWpaTB9P5QjimHK7fqh3XdkslUCAsvJlpKPsV8QBYrbV7FJH
 AwIfnTURnU8ofMl93lYOq2GLMJTzD0sJv0F4xFNzzPbANX/b3volKKV4M
 k0YKGApbgC7PtsQoa57FlH9tEU4hDT8rjnbiP8EIj/BTK5UCdgpvhQI7u Q==;
X-CSE-ConnectionGUID: Z24rHW33TsKpMCVR/whE9Q==
X-CSE-MsgGUID: I5LeYrWiTsy48HRXXaYT8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88578122"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88578122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:38:19 -0700
X-CSE-ConnectionGUID: JUPwQEiNT/mU6WXlM/OV2w==
X-CSE-MsgGUID: Jx1uA8N4ThaLKIpiq0tCKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="293521550"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:38:14 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 5/6] tests/qtest: Add RISC-V ACPI bios tables test for
 CXL
Date: Mon, 31 Aug 2026 14:38:07 +0800
Message-ID: <20260831063808.409069-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-6-cp0613@linux.alibaba.com>
References: <20260828151317.815-6-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Chen Pei,

On Fri, 28 Aug 2026 23:13:04 +0800, Chen Pei wrote:
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie

