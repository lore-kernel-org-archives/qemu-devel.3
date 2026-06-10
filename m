Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC88CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXCBF-0004a6-1e; Wed, 10 Jun 2026 02:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@fujitsu.com>)
 id 1wXAEp-0007wX-En
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 00:08:23 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itaru.kitayama@fujitsu.com>)
 id 1wXAEn-0003wR-97
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 00:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1781064502; x=1812600502;
 h=date:from:to:subject:message-id:mime-version;
 bh=/b8+sD5AEBEacHSQLWuAcMxN3dF+Y1CJfi7lOuoZabo=;
 b=dYx50hfrizaThoD3y7/tpv+OrfEUXfwTF2aC8HN5VP35gymIR8Y28Swq
 IvI8GQhWaThUnia32gIfY8UjTpHklwl7A7auRj4NN41+9i6uOHgIzrQYb
 5G9mvYUXe5NzQMLiudd7LsKf9D7unfyQO5IXYINJBsJl2AFRi3ki0tJH7
 82DWytUJbB38zSebzcYZD4Bs84axePqDjYGF1x0bwvAnSc2biF7uP1sQc
 yUvzjrZtjO0Sb72/uSbvvLclyENeZ/FRZnk7f4nymgddOxO+7gJn79I/f
 4r9zOiyNMSf1pG7du2I+7pNjIg/lfcGI5r8BhFcL/MZbEiA4GxYzLlXzq g==;
X-CSE-ConnectionGUID: DIUAPMAoT/eKFykX6hixrQ==
X-CSE-MsgGUID: akg7NAIFSD6dU200GvYG9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="243550272"
X-IronPort-AV: E=Sophos;i="6.24,197,1774278000"; d="scan'208";a="243550272"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 13:08:17 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id C49AA8204C2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:08:16 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 7ECAA1810797
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:08:16 +0000 (UTC)
Received: from sm-arm-grace07 (unknown [10.124.178.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTPS id EAEF740432D
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:08:14 +0000 (UTC)
Date: Wed, 10 Jun 2026 13:08:12 +0900
To: qemu-devel@nongnu.org
Subject: arm64 guest performance: 16K page granule slower than 4K/64K
Message-ID: <aijjLJ1JF_-o9fE9@sm-arm-grace07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.54.90.49;
 envelope-from=itaru.kitayama@fujitsu.com; helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Jun 2026 02:12:46 -0400
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
Reply-to:  Itaru Kitayama <itaru.kitayama@fujitsu.com>
From:  Itaru Kitayama via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,
I have been seeing emulation slowness when running a KVM selftest
on the 16KB kernel (built from the kvmarm/fixes branch) with the 
updated master branch of QEMU in TCG mode; while the test, vgic_init 
finishes within 10 to 20 seconds with the 4KB/64KB kernels, it takes 
about 5 minutes. I am wondering if there are tests that check TCG
is working correctly for 16KB as well as the other page granule.

Thanks,
Itaru.

