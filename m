Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94600E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 12:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaC43-0007zz-GK; Mon, 29 Dec 2025 07:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC3z-0007xv-Oh
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:28 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1vaC3y-0005Bk-1v
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 07:09:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767010129; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c0GcFYFy9KIPyJeFoywGkDvGQ0aDyru6c99K0h7gX383ATbe9CVYQcQq0Q3SMzq1a1m1AuAQLnoi1W0KoVAXyuFK6rTbwVP57huINZICpcog2ojIiWTm5rKAztNOfxPl/uQF3SQEOZoQEfRnVc54ce4vUoapWKuFdFB6I1P/+Ac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767010129;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b6RbZnrLQU46HzS5xhrvB1zLEVHidENk4tAlk9JT9F4=; 
 b=HOYdMmoOoFfS9IfucvmOoDc1mD8mWymQ/wRgBlAJ6nHt/v46RfG+hzq7/nQzKrdIlQS4hEHu5gOxKlQTGUX3ErpXq0XoJMnPdpnGtOEchWMFwrztej7o2mPqYHjKCoi6r+KOUsl7/bvz1UhKIMlRngXkRMon1VxSLvU+/AS/do4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767010129; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=b6RbZnrLQU46HzS5xhrvB1zLEVHidENk4tAlk9JT9F4=;
 b=i0lLJwykfUPiXyewbbNTN9phMRoUtJAgIFGcicGErp2jsW5IjG+sAYi0DB3Bggic
 Tw5aHPXW7fB8bifHs8YGI6lbcyK19ecEcY6w6A0IkMH3XTVTOer+zOrwaXKT0bQYtbC
 aKHBKbS2OIDASoAnxaOZ8OJAE30MFlR/Sqdq7Zc0=
Received: by mx.zohomail.com with SMTPS id 1767010128989281.3144807790054;
 Mon, 29 Dec 2025 04:08:48 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, qemu-devel@nongnu.org,
 Li Chen <me@linux.beauty>
Subject: [PATCH 2/3] docs: CPR: document shared RAM with x-ignore-shared
Date: Mon, 29 Dec 2025 20:08:36 +0800
Message-ID: <20251229120839.89817-3-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229120839.89817-1-me@linux.beauty>
References: <20251229120839.89817-1-me@linux.beauty>
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

Document a CPR setup where guest RAM is shared/external and preserved in
place.

With shared RAM and x-ignore-shared enabled, the migration stream skips
guest RAM pages and transfers only non-RAM VM state (vmstate).

Note that a memfd-backed RAM file is not persistent across a reboot by
itself. For a host kexec reboot, use persistent shared memory (for
example a DAX device), or use an external manager (for example Linux Live
Update Orchestrator (LUO)) to preserve the RAM backing file and re-attach
it to the new QEMU instance.

Signed-off-by: Li Chen <me@linux.beauty>
---
 docs/devel/migration/CPR.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index b6178568a8..e60ae31b45 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -46,9 +46,20 @@ Usage
 
 It is recommended that guest RAM be backed with some type of shared
 memory, such as ``memory-backend-file,share=on``, and that the
-``x-ignore-shared`` capability be set.  This combination allows memory
-to be saved in place.  Otherwise, after QEMU stops the VM, all guest
-RAM is copied to the migration URI.
+``x-ignore-shared`` capability be set.  With shared RAM and
+``x-ignore-shared``, the migration stream skips guest RAM pages and
+transfers only non-RAM VM state (vmstate), while guest RAM is preserved
+in place.  Otherwise, after QEMU stops the VM, all guest RAM is copied
+to the migration URI.
+
+Note that a memfd-backed RAM file is not persistent across a reboot by
+itself.  If you want to reboot to a new host kernel while keeping RAM in
+place, use persistent shared memory (for example a DAX device), or use
+an external manager (for example Linux Live Update Orchestrator (LUO))
+that preserves the RAM backing file and re-attaches it to the new QEMU
+instance (for example with ``-add-fd`` and a ``memory-backend-file``
+pointing at ``/dev/fdset/<id>``).  QEMU does not manage that
+orchestration.
 
 Outgoing:
   * Set the migration mode parameter to ``cpr-reboot``.
-- 
2.52.0


