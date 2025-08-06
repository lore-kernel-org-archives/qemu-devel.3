Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957D6C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujl2K-00055F-Bl; Wed, 06 Aug 2025 16:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1ujl2G-00054g-RN; Wed, 06 Aug 2025 16:46:56 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1ujl2F-0004BR-2p; Wed, 06 Aug 2025 16:46:56 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 0EF51DA1C16;
 Wed, 06 Aug 2025 22:46:52 +0200 (CEST)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=weilnetz.de (policy=none)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id DE97C46003A; Wed, 06 Aug 2025 22:46:51 +0200 (CEST)
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH for-10.1] meson: Fix brlapi compile test for Windows builds
Date: Wed,  6 Aug 2025 22:45:58 +0200
Message-ID: <20250806204624.510091-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.10 / 12.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[];
 DMARC_POLICY_SOFTFAIL(0.10)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine,sampled_out]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; R_DKIM_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 R_SPF_SOFTFAIL(0.00)[~all:c];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.weilnetz.de:helo,qemu.weilnetz.de:rdns]
X-Rspamd-Server: v2201612906741603
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0EF51DA1C16
X-Spamd-Bar: ++
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

brlapi__openConnection returns a brlapi_fileDescriptor which is a pointer
for Windows builds.

The test for brlapi fails with cross builds on Debian trixie
(x86_64-w64-mingw32-gcc (GCC) 14-win32):

testfile.c:4:30: error: returning 'brlapi_fileDescriptor' {aka 'void *'} from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    4 |      int main(void) { return brlapi__openConnection (NULL, NULL, NULL); }
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----------
../../../meson.build:1607: WARNING: could not link brlapi, disabling

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

I think that this patch is trivial because it does not change
anything for Linux.

Note that this patch only fixes the configure test and allows builds
with the Braille API for Windows.

A similar change can be applied to chardev/baum.c and will be sent
separately because it is not required for 10.1.

Note that for 64 bit Windows there is an issue because brlapi_fileDescriptor
is a 64 bit pointer while QEMU assumes int for file descriptors. But the
good news is that the resulting code seems to work nevertheless – at least
the people who asked me for Braille support on Windows are satisfied as
far as I know.

Regards,
Stefan W.


 meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index e53cd5b413..d6abe1917e 100644
--- a/meson.build
+++ b/meson.build
@@ -1586,9 +1586,11 @@ if not get_option('brlapi').auto() or have_system
   brlapi = cc.find_library('brlapi', has_headers: ['brlapi.h'],
                          required: get_option('brlapi'))
   if brlapi.found() and not cc.links('''
-     #include <brlapi.h>
-     #include <stddef.h>
-     int main(void) { return brlapi__openConnection (NULL, NULL, NULL); }''', dependencies: brlapi)
+    #include <brlapi.h>
+    #include <stddef.h>
+    int main(void) {
+      return brlapi__openConnection(NULL, NULL, NULL) == BRLAPI_INVALID_FILE_DESCRIPTOR;
+    }''', dependencies: brlapi)
     brlapi = not_found
     if get_option('brlapi').enabled()
       error('could not link brlapi')
-- 
2.47.2


