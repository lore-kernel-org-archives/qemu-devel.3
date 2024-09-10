Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF353EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4yD-0004zY-Om; Tue, 10 Sep 2024 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1so4yC-0004tL-4l; Tue, 10 Sep 2024 13:48:04 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1so4y9-0005Nc-Nw; Tue, 10 Sep 2024 13:48:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3A915C0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1725990476;
 bh=4QsFfFrZoRT77mRNJG0cC173MESBb5MmQI1WFQepicA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=K+iNU/BxedCQ2Cc91lQ3VgHugKiAjaq5gHwIDiiFnbriuLC7mzXA9KWy75xhSLZok
 pK/d5nyvT88tucHTi1AtyvRpRMODiARIFMObY1awRlvgcGgI3E8kx81kFNsl7v2LcS
 e3BJRcEFuQa6HLC9xAf0UMEZI5J2O8bqvzGxZn0GKbgoVUXHb2J+fscG1BfH6TSqIk
 AgVeKWkw0xesv+lk956ukwPKNZ35nlA18JYqIV9vfBqZxfFlZCbIFaaRXnJ/kXYIpY
 uRpT2c2QQzykkevSdM5MuAdeZWhFVdEBrilJKlju8Fu0FAZIONPDzTYVTi2iDlCL9V
 p2p3NkFzszIkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1725990476;
 bh=4QsFfFrZoRT77mRNJG0cC173MESBb5MmQI1WFQepicA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=MazBcqZfwxtkfiGe3dSfDajR3eWVM6ox6rr3cRWWrVe8NimbZxYbwim31qy3g80wg
 qUxwLoGt46QEH8x4Qkd1VJE3r2pXIETOilmVDPDnd9XqTp1psLEwHv3XY6U1RwcmFN
 KvfA7VcFl3p/aM952enQH2Xu2LyEOI/aNeBVEl1SMUZ1Vak0+bYXDVhBt4OExyQTp1
 fGQOouLWaRz7v+64LZmvFz2Gt/RZ2HwSGvRRzhge5UgV9zR3cwY/KyAZ9WEXQaGwcA
 BKoJTbzUuAkyNsESfDFoNDrtKnqGg1l4CpzT/RkBLhfBJ4Vgc13LKtZM+hxdxRXpw9
 Kjezzg7hqDmLQ==
From: Alexei Filippov <alexei.filippov@syntacore.com>
To: <palmer@dabbelt.com>
CC: <alexei.filippov@syntacore.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <liwei1518@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [RFC PATCH 0/2] target/riscv: Add support for machine specific pmu's
 events
Date: Tue, 10 Sep 2024 20:47:45 +0300
Message-ID: <20240910174747.148141-1-alexei.filippov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Following original patch [1] here's a patch with support of machine
specific pmu events and PoC with initial support for sifive_u's HPM.

== Test scenarios ==

So, I tested this patches on current Linux master with perf.
something like `perf stat -e branch-misses perf bench mem memcpy` works
just fine, also 'perf record -e branch-misses perf bench mem memcpy'
collect samples just fine and `perf report` works.

== ToDos / Limitations ==

Second patch is only inital sifive_u's HPM support, without any
filtering, events combining features or differrent counting
algorithm for different events. There are also no tests, but if you
have any suggestions about where I need to look to implement them, please
point me to.

== Changes since original patch ==

- Rebased to current master

[1] https://lore.kernel.org/all/20240625144643.34733-1-alexei.filippov@syntacore.com/

Alexei Filippov (2):
  target/riscv: Add support for machine specific pmu's events
  hw/riscv/sifive_u.c: Add initial HPM support

 hw/misc/meson.build            |   1 +
 hw/misc/sifive_u_pmu.c         | 384 +++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c            |  14 ++
 include/hw/misc/sifive_u_pmu.h |  24 +++
 target/riscv/cpu.c             |  20 +-
 target/riscv/cpu.h             |   9 +
 target/riscv/csr.c             |  93 +++++---
 target/riscv/pmu.c             | 138 ++++++------
 target/riscv/pmu.h             |  19 +-
 9 files changed, 599 insertions(+), 103 deletions(-)
 create mode 100644 hw/misc/sifive_u_pmu.c
 create mode 100644 include/hw/misc/sifive_u_pmu.h

-- 
2.34.1


