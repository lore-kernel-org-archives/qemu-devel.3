Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EEECD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU69g-0001Y2-Iq; Mon, 01 Jun 2026 13:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wU69b-0001Wt-EU
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:10:19 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wU69Z-00011J-AA
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 13:10:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:99a2:0:640:9cf5:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9E5D0C021A;
 Mon, 01 Jun 2026 20:10:11 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:66f::1:39])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id AAiFcx0iJ0U0-404tuB0u; Mon, 01 Jun 2026 20:10:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1780333811;
 bh=w/x1zXvSQg3m2epVBhxEE9b6zk/PDsy+I7cSXhQFoUg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Poqhb8UrrFUlayA0v3WkKpvr7HG3p7YKMwPtMErIjbY4v+6KHjU6T+d6YZ8Dw0a02
 /P0NbQYiB3GjU81kPKix/J8W59DxYXpWDlxRmnhEYhlclN2ekpjrhJoeqdTG/tZuZH
 A6ZfEp+hwmzkWDdRGcPSnnJnWa1ApDJoq/jih1XI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: chao.liu.zevorn@gmail.com,
	vsementsov@yandex-team.ru
Subject: [PATCH] checkpatch: calculate UTF-8 characters correctly
Date: Mon,  1 Jun 2026 20:10:08 +0300
Message-ID: <20260601171008.159147-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We do check UTF-8 correctness in checkpatch.pl (search for "patch and
commit message should be encoded in UTF-8"), but we count bytes, not
symbols when limiting line-length. Let's be consistent.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 scripts/checkpatch.pl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2189db19f54..711539bdd7c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7,6 +7,7 @@
 
 use strict;
 use warnings;
+use Encode qw(decode);
 use Term::ANSIColor qw(:constants);
 
 my $P = $0;
@@ -596,7 +597,11 @@ sub line_stats {
 	# Pick the indent from the front of the line.
 	my ($white) = ($line =~ /^(\s*)/);
 
-	return (length($line), length($white));
+	# Use character count (not byte count) so multi-byte UTF-8 characters
+	# are counted as single characters.
+	my $line_chars  = length(decode('UTF-8', $line,  Encode::FB_DEFAULT));
+	my $white_chars = length(decode('UTF-8', $white, Encode::FB_DEFAULT));
+	return ($line_chars, $white_chars);
 }
 
 my $sanitise_quote = '';
-- 
2.52.0


