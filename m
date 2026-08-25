Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C964C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn4O-0005Vs-DI; Tue, 25 Aug 2026 05:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4H-0005Lt-1X; Tue, 25 Aug 2026 05:03:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4F-0003BM-G0; Tue, 25 Aug 2026 05:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=rZlybv4kCq+v5NMBwGzdVpoMTvk4FmeA+h268foUNlQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kR81XCIt+YV9UndhsLQcI7Wie7lyh3RZ+RQDKgCWOx0GwhmHwWxNNT1WexYQSU9sM
 zDFA61/aHZt9IiD9s8V2vbnUWP6OTDwnUCZK0yDuqbj8plTb5nuqjjq4FH0dbaoSW+
 H/PkCjkjYu9EtMzrY/+RBivWSQdWuxHm0GAgkCanVYFtYfzGfYVKYlX5c2HvfQmvB/
 vcb8UjPlpO9/M+1JJW87632Dy6mcNY6GkIYNggolGKwmsGr9PrInSQScbDqSzEOLpA
 0Wvp3lWPa+eFA70mqFhRCUTWwLnfvFDqIMIbSMGKmlVbOxIXMuACbh79U6qGV4Fi6I
 Wymr2y/YTu5bQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5F5C21CE3B5;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4B3EC416177;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C314532553; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 171/196] meson: make linker warnings non-fatal on
 Linux
Date: Tue, 25 Aug 2026 12:01:28 +0300
Message-ID: <20260825090157.471948-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

These cause a werror=true build to fail with Meson 1.12.0, as it now
makes linker warnings fatal as well.

Cc: qemu-stable@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 501187d0bc62a46628acc25e0ea0187094f04246)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 1d54b6fb74e..4b2571eaae6 100644
--- a/meson.build
+++ b/meson.build
@@ -602,6 +602,11 @@ if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-seh', '-Wl,--nxcompat')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
+if host_os == 'linux' and get_option('werror') and get_option('prefer_static')
+  # On glibc systems, glib causes warnings about getpwuid, getpwuid_r
+  # and getpwnam_r not being supported with static linking
+  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-fatal-warnings')
+endif
 
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
-- 
2.47.3


