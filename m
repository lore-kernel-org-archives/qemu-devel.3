Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B0CC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLTq-0006qb-47; Thu, 16 Jan 2025 03:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYLTm-0006p0-83; Thu, 16 Jan 2025 03:43:54 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYLTg-0006nn-Np; Thu, 16 Jan 2025 03:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=tjqHi7zeaRi1ZPcfAv+eUnMUtGpd7kq8NDwOvC3nsVk=; b=bSv6dzL1vdg3gqEa+FP0eVjouM
 j1nwqH+kRmJ+mY1u3/gaLep/NqlwSpdMpOcYt1dytUykeQJVgUuDnW4v49K4RgJNc1dx01+0jassk
 JhfKQKY5znnu+hthvlM4rlvAL7lOcloj9F/r3RlWMgiPSzFm/nh/QaAZWfD39v3o2hNz6zOeabUBz
 iOU0OF5os3V/ZMvjShsLmfv83KQ99Fhq7pJ/v1xsw+hZYc7c0qoRIKFqE2/q5yXXsUWMrvUMsP4l4
 VDN+WWnfDRy1TysjP3lpzq4ulph49cnnjXzdy+j4ZY6W56keXvTz9FkFo8EXnhsclB1dGNdfwLaZO
 I9gZjIXw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYLTd-0000000Akbc-0hzA; Thu, 16 Jan 2025 08:43:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYLTc-00000007pIP-3i2w; Thu, 16 Jan 2025 08:43:44 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PULL 8/8] system/runstate: Fix regression,
 clarify BQL status of exit notifiers
Date: Thu, 16 Jan 2025 08:43:32 +0000
Message-ID: <20250116084332.1864967-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250116084332.1864967-1-dwmw2@infradead.org>
References: <20250116084332.1864967-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

By changing the way the main QEMU event loop is invoked, I inadvertently
changed the BQL status of exit notifiers: some of them implicitly
assumed they would be called with the BQL held; the BQL is however
not held during the exit(status) call in qemu_default_main().

Instead of attempting to ensuring we always call exit() from the BQL -
including any transitive calls - this change adds a BQL lock guard to
qemu_run_exit_notifiers, ensuring the BQL will always be held in the
exit notifiers.

Additionally, the BQL promise is now documented at the
qemu_{add,remove}_exit_notifier() declarations.

Fixes: f5ab12caba4f ("ui & main loop: Redesign of system-specific main
thread event handling")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2771
Reported-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/system/system.h | 1 +
 system/runstate.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/system/system.h b/include/system/system.h
index 5364ad4f27..0cbb43ec30 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -15,6 +15,7 @@ extern bool qemu_uuid_set;
 
 const char *qemu_get_vm_name(void);
 
+/* Exit notifiers will run with BQL held. */
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
 
diff --git a/system/runstate.c b/system/runstate.c
index 3a8fe866bc..272801d307 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -850,6 +850,7 @@ void qemu_remove_exit_notifier(Notifier *notify)
 
 static void qemu_run_exit_notifiers(void)
 {
+    BQL_LOCK_GUARD();
     notifier_list_notify(&exit_notifiers, NULL);
 }
 
-- 
2.47.0


