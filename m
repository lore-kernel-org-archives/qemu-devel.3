Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF310F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXq4-0001uB-Sd; Wed, 08 Apr 2026 14:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAXpm-0001mS-2V
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:03 -0400
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHJz-0001Pa-Ax
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610185; x=1775869385;
 bh=gGJ1kmQHYlYjGTu2RlWSih+XP5A8EDutC+E37BWHHHc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Bk2cdUZR1QfXgH6p7Wr8y5CsNSzFwflZIkhVOxTOKm3qLEeJ9/glHvWAnMUPrBVxd
 HwcY8+BPzgEABD8zV5d8K8+tJtcB8ZccySSpPz9TwD0wjil2WS/nbh6e0JfyALTe5u
 RIukVkMdT4E2iVoM07PZ8QuPqoCS595SGP6DnzVY2/GgCO372CF9Hihdl8q7py3SGL
 mCJczP5BIif5/rzN4qveE5RHZBk2fj2xvKs+dkWE+hyCoFUpQQBT1WDSRi4vdulTpY
 S8o9NNJtBQ/ozssI6Zx9+6dkkkdveTY7Ld5Y1IfOtYWU89SOILCywp67XfBwqOcO1D
 G82qaT9cpgHaw==
Date: Wed, 08 Apr 2026 01:02:59 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 Paolo Bonzini <pbonzini@redhat.com>, zhao1.liu@intel.com
Subject: [PATCH 7/8] tools/i386: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-8-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: a36fcd87dc2ec4e530b9fc8a20d840b61625bfec
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

Replace g_source_remove() with g_clear_handle_id() to ensure
consistent handling of GSource IDs.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 tools/i386/qemu-vmsr-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index f12fd3c3e8..741993c2ca 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -306,7 +306,7 @@ static void close_server_socket(void)
 {
     assert(server_ioc);
=20
-    g_source_remove(server_watch);
+    g_clear_handle_id(&server_watch, g_source_remove);
     server_watch =3D -1;
     object_unref(OBJECT(server_ioc));
     num_active_sockets--;
--=20
2.53.0



