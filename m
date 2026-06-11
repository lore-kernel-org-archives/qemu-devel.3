Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A883ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZ21-0002ek-2v; Thu, 11 Jun 2026 02:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXZ1r-0002Yh-MV; Thu, 11 Jun 2026 02:36:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXZ1o-0002aw-Nw; Thu, 11 Jun 2026 02:36:39 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B6ZnFK023462
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 15:35:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QJRQbh4Vp7+ROWhKqqXXYujUryc5YKkBTrxDxJHDvqY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1781159759; v=1;
 b=eHspIBBtwcgbSb6qp4mFggZ9NmQnM1/Bt048VjpXL3aIj0cK2NHVpH6pq4c+8nkZ
 s27CvY79bzlAODvZlIOFs1nRvVQZbJ51eBETpuUDXcPV6uUBmmorAo95S4fKH+0b
 WNjhDpSII2MbOwq787S/1TnhvcpuCgwPmZZPavuJcyivKI/9vxEOCC5MjnNpSRy4
 4V6dUbinian5Tbes8j/dVajWCex00JrFI4qNdhcpD+v+TDrF2HkkmFKnnkeQNA6N
 YQFrpx2ouUmbid9XBPEtb8uHJy3z2u/XaPTYG5+ibKibIRh/eVKYUwsoAa42NEOH
 Z5Lg4sb8DMqywAs3pAq1zw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM changes
Date: Thu, 11 Jun 2026 15:35:47 +0900
Message-Id: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDINQtSszVTUlOTTM0STMwMExLUgKqLChKTcusAJsSHQvhF5cmZaUml4C
 0KtXWAgANeVcsZwAAAA==
X-Change-ID: 20260606-ram-dcef14f001fb
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=zun5J46n07yrxt8B36zgDHuFJ7LctWerMZAfkBTFbZY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5ZWuGfKzD9vOYVL4ipWy9itqcwTiokNrqh2ehM8MUZ4m
 smqqeUdpSwMYlwMsmKKLClFu7k1oms/FSbEt8DMYWUCGcLAxSkAE8k+y8gwZc3B3ct1/WcWTd07
 aaNy4ievT+H7Kv/XMjqrq52XFjvbzPA/58Ld0607F4p1H9xUFJxx4kv93lu7rZZVJTlV7Zq4aoE
 VCwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH] system/physmem: Assert migration invariants")

ram_mig_ram_block_resized() already aborts migration when migratable RAM
is resized. Extend the same handling to other unsupported changes to the
migratable RAMBlock set, such as removing a migratable RAMBlock or
changing a RAMBlock's migratable state.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (3):
      system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
      system/physmem: Notify RAMBlock migratable and idstr changes
      migration/ram: Abort on unsupported migratable RAM changes

 include/migration/misc.h    |   2 +-
 include/system/ramlist.h    |  24 ++++++---
 block/block-ram-registrar.c |   8 +--
 hw/core/numa.c              |  54 ++++++++++++++++---
 hw/xen/xen-mapcache.c       |   6 +--
 migration/ram.c             | 125 ++++++++++++++++++++++++++++++++++++--------
 system/physmem.c            |  16 ++++--
 target/i386/nvmm/nvmm-all.c |   4 +-
 target/i386/sev.c           |   8 +--
 util/vfio-helpers.c         |   7 +--
 10 files changed, 194 insertions(+), 60 deletions(-)
---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20260606-ram-dcef14f001fb

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


