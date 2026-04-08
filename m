Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46B110F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKs-0004qU-8q; Wed, 08 Apr 2026 15:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAYJT-0008Qu-VY
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:44 -0400
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHJq-0001P0-7w
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610173; x=1775869373;
 bh=H3u1e6oqrvjOVue/AzgRE2wOemZMtQFe4II1WfBXrww=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=AYiwC0E8Ua31xK/RfacfzYUctL3QqJvOXd+KF23ebGWEBmA0K1+CPvkQb6BDxdMGS
 pjiHyuoDqYfcLRmh2h/yWAzAl4EFEO6ebpGqIdNw+EjCI5fwRRwnWm+79G8y1Rkc5S
 bXvXgsDQsWhtMYCJXy+6rjPY0LtNmYu2SoMiStzpOgf28r3J8TpCctquO8YBdKyHVZ
 Z4X4bK+wO5aaW/f8hWYkOlCw+UCZVe4dMnCr8qN7tCL64Bt+ww/ByEtNl/dF1t4MVd
 EmXrbTgKlxCJvBseaQCK+K4YNNge1eiUEMXbuniyr9XaEzgGj5qhd23DG9VmVhi1hJ
 QnFWWxMCsjivg==
Date: Wed, 08 Apr 2026 01:02:49 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, kvm@vger.kernel.org
Subject: [PATCH 6/8] target/i386/kvm: use g_clear_handle_id() for GSource
 cleanup
Message-ID: <20260408010026.4611-7-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 02f22ade2439bebbfcb019f0bd7f951675313f34
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.18; envelope-from=matt@matthewpenney.net;
 helo=mail-4318.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace g_source_remove() and explicit watch id check with
g_clear_handle_id().

This simplifies the code and ensures consistent handling of GSource IDs,
since g_clear_handle_id() checks for a non-zero ID before calling the
cleanup function.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 target/i386/kvm/tdx-quote-generator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-qu=
ote-generator.c
index dee8334b27..ab10986efa 100644
--- a/target/i386/kvm/tdx-quote-generator.c
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -75,9 +75,7 @@ static void tdx_generate_quote_cleanup(TdxGenerateQuoteTa=
sk *task)
 {
     timer_del(&task->timer);
=20
-    if (task->watch) {
-        g_source_remove(task->watch);
-    }
+    g_clear_handle_id(&task->watch, g_source_remove);
     qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
     object_unref(OBJECT(task->sioc));
=20
--=20
2.53.0



