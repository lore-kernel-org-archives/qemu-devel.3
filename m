Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B37E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 12:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaC3g-0007rA-DL; Mon, 29 Dec 2025 07:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC3d-0007pb-PB
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:05 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC3a-00050d-CD
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767010125; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bd8GuRR4rpHSI5S/kq9tPMOeJj1o4JRv1ZaboXGpmhfWAK+pD8RmZ20V2V6Uq3NVZ7nc6udtY0QlHcOmJbf7jU3pjxnoByA44EMOnIofnjnenR/xD0nQtBTEDsHgbKNj3ar2GzoWHu0/9JZ4/PQ5wZR5CYom9QFj4JduP2grTj8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767010125;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nO989N1pTRDKgXYDQSXHOZSK27Yt+2ttn7E9RvfDPRc=; 
 b=CiC8rvIgWElV5aoJN4mZBQVGdfA2UPVSJIAM0x/eiN8/enND+hjJTUFjSs9++Ge7KEjRA21sd1vrwg+C8VJHznmPHAdsfg4VE6k9+DjOr7I/ITU8wkA0O9aQSc4w0yfn85OrvTeqXDmSDd867r02EO+J8Kv1WfjNX656BCzOGik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767010125; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=nO989N1pTRDKgXYDQSXHOZSK27Yt+2ttn7E9RvfDPRc=;
 b=kpCCFIa+DZUCTgaVYdLaYrEKtVTp0vpo7zKAi7ZtqHgTDDmUBeHuSEkMiSHcbTvV
 sNJSXeAckR35Ng0BXp5uy5zdDx61fKjpPhnEhM9Oa5ZEQM3Piis5VPnnifmg4U+TfyH
 iIU97QBdsD13Eyx3H0tBCibWR/D2SVUP9qcEBx8U=
Received: by mx.zohomail.com with SMTPS id 17670101237511013.621651035437;
 Mon, 29 Dec 2025 04:08:43 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, qemu-devel@nongnu.org
Subject: [PATCH 0/3] CPR: shared RAM with /dev/fdset for LUO kexec reboot
Date: Mon, 29 Dec 2025 20:08:34 +0800
Message-ID: <20251229120839.89817-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112; envelope-from=me@linux.beauty;
 helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series improves a CPR workflow for large guests where guest RAM is
shared/external and preserved in place. With shared RAM and x-ignore-shared
enabled, the migration stream skips guest RAM pages and transfers only
non-RAM VM state (vmstate). This avoids copying guest RAM to the on-disk
migration URI, which can significantly reduce checkpoint/restore downtime for
multi-GB guests.

In the LUO/KHO update flow [1], a LUO agent coordinates a host kexec reboot
while keeping VM RAM content intact. LUO creates the guest RAM backing as a
memfd and passes it to QEMU via -add-fd on the initial launch, so that
memory-backend-file can use it as the shared RAM backing. On update, LUO
checkpoints QEMU, reboots the host kernel via kexec, and then re-launches QEMU
to restore vmstate while reusing the same preserved memfd-backed RAM FD.
Today LUO only supports handing off guest RAM via memfd [2].

To re-attach that preserved RAM backing without reopening non-persistent
paths, QEMU needs to let memory-backend-file consume the pre-opened FD using
mem-path=/dev/fdset/<id>. However, memory-backend-file currently uses
open()/creat() directly, so /dev/fdset/<id> cannot be resolved through the
fdset mechanism, making this workflow impossible.

This series allows /dev/fdset/<id> for file-backed RAM, documents the setup,
and adds qtests to validate that x-ignore-shared keeps RAM transfer minimal
in the cpr-reboot path.

[1]: https://docs.kernel.org/next/core-api/liveupdate.html
[2]: https://docs.kernel.org/mm/memfd_preservation.html

Li Chen (3):
  system/physmem: allow /dev/fdset for file-backed RAM
  docs: CPR: document shared RAM with x-ignore-shared
  tests/qtest: cpr-reboot: check ignore-shared transfer

 docs/devel/migration/CPR.rst      | 17 ++++++++--
 system/physmem.c                  | 17 ++++++++--
 tests/qtest/migration/cpr-tests.c | 56 ++++++++++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.52.0

