Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA0CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNbaz-0002Jg-7R; Thu, 14 May 2026 15:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wNbas-0002IS-3f
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:19:40 -0400
Received: from mail-4397.protonmail.ch ([185.70.43.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wNbap-0004H7-Cd
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1778786364; x=1779045564;
 bh=7FhMb7sBXDZ6CsSIZO7EzfJPesa87v+7jGOEe8Qr960=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=fq5NP0VkKLcKFP5eaEMoj7qy86oCgCVd6ilnNEwjo9xm1bMVL2XhV29vk2HC3IpPo
 CZB7xVP/G0emEiEJ2INxMgTEXn2yBLbZYBUxV9vW7k4o6cC2KXDzfBXgyXC4VbMwq/
 8lbiM6OfhkzDURpQ0FHuyazB84mjt2goyqq72rdA3D8tU9BO60rQHt4Of2OzF5gjIs
 hS7ftEOJn3lb9nW/o349V9LQAAN7JPbwbUoXCxINocxqew6J6mAzZTuQcH1M1d05MQ
 Ba/Bq5Hyw++zOj/Nx4BjGxEdJ20zIXPw4HPRZ41DAJU0bsZVjCdB7bxvaOxMCMdy7f
 4wfyDRo37Nohg==
Date: Thu, 14 May 2026 19:19:18 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>, farosas@suse.de,
 lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qtest: fix discarded const qualifier warning
Message-ID: <20260514191844.105888-1-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 8e6596e175fdba6eb34262246ddf80a4957c6f68
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.97; envelope-from=matt@matthewpenney.net;
 helo=mail-4397.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Modern compilers warn that the result of strstr() may discard
const qualifiers when assigned to a non-const pointer.

Make 'found' a const char * to fix the warning.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 tests/qtest/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index bf9284b9a1..b1e06ea364 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2146,7 +2146,7 @@ bool mkimg(const char *file, const char *fmt, unsigne=
d size_mb)
 bool qtest_verbose(const char *domain)
 {
     const char *log =3D getenv("QTEST_LOG");
-    char *found;
+    const char *found;
=20
     assert(domain);
=20
--=20
2.54.0



