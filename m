Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9420BC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppUw-0006Gk-5t; Fri, 31 Jul 2026 11:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wppUu-0006GI-HU
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:50:08 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wppUs-0004Li-Mg
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:50:08 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1f5208b38dso211972666b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785513004; x=1786117804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bWvC//SAqY7HOek72Bb6dqbKmT68lwydAR4HUdEThWs=;
 b=IgwQy00voyMYCCy//W5/QCUOPSG32HT+Bfc0YQ61wBa2u8lF3PPoK0sLSaKP9R2sUr
 JSbqHUiSfn3dTU8MsHkWooV34e02QNcwG1lEAJrpdO500Cv8N1L9WxJ5JMJ8+YQ4CMMc
 ZIodjYy2T5eYqDXRCn7MDjqYmU1WiIlEtF+1Xubwd11IKxv2GHYwazjAFkitAidWeOcx
 GhOxxNdz7wNQp8qG8NUYy0/QKgXWSouQv3NNnpjL/Xcq++td+YNu5DF53rvims1bFypW
 4qC8EA8vUDoa6fWU/EqoN+F81NcV1iPWxBexJ8+5rNElOyzAwK1AuIwwNHlKxloxqrdS
 hPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785513004; x=1786117804;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bWvC//SAqY7HOek72Bb6dqbKmT68lwydAR4HUdEThWs=;
 b=HYbVu0BaI8p14O3o5y9FbV3nW2m6QD6Su6nuI12q3jOWus6LgJR0dRZy+rj8f12pfy
 dyA2JxVn/Dr61ic6j4FHA+K8c3ZlikYD+nMFIbmHNVWBkjknba+PX9fInfnpEgQRgOiC
 wQAMW5a3YShfjl36bUHVXnNiXzYv0991+6F9Odp0asivIK6a7izHvXYTsWRfhgsMfB+n
 lFqhaelmk9/03rlRs77YIxm+W3d89vPsL3Msw2gge/ur4AyZOsiaF40QUwfhctOIAkbI
 aOpmLAEeAnZf1733BmUlhm2UkwBOExj4fGe5tla7PQz2kxIMU8qj4myVEfNv0cngFwFz
 Hcdg==
X-Gm-Message-State: AOJu0YwQHOxtMGdAvh5WMIZpzxYd3a6fpEft0tQ2xZnVgceLTn6wR9XQ
 iAkBnZHrQlIYgf5KHCbjKRiku/ARieTX63f9JpHK9y+g6R7qeha1AaCkIwfZDe8Wo3WwQlSONau
 axUUX
X-Gm-Gg: AR+sD13C6HcCymuAY8A4GxCMb+CwpesQHykjv8p7qwAV8Lp3C4RYOEYjjr3nI+izmv9
 tJrjBTlJvmdmbCipoTkaiZkknp1JCFWu0NBQcnf8HB7O0P8paRFRjphbKZfcUXf/3WPeNL1Cgxa
 MPGyWELkpwmzS35Sk1W26IUzdMZ7byzorRvC4Aa6gls2ZOYU2TIFMO4/eNSgztcJAij/9fojQCZ
 8jcVEXC6nTtsnvVmWI+lbAedb/26w98ORP2l666KmmblIJ3CRLsFVKw/c3oGzbX6gBrsNFYCumM
 YmABqwmSW+/JCHiSTNSYQNL7gFoW3aj6A8Za/pfttlTBQ4QyxJEHDtpTy7qW5r/TxgjkGYz0spQ
 R47ckvcweugtr/QrNP08IT7aJpWfLW1/5H6fbLBJg/6Zb38xXy1rm5U4ycJaeteB3oM6n9Y/4an
 Lq45SBTzwS3otPNGK59lrlV6MsMDzjoIR7fTZXzfYNrDzyfm0CX50RM6fA/Z9fAOW72O4=
X-Received: by 2002:a17:906:b308:b0:c19:5d7c:ae72 with SMTP id
 a640c23a62f3a-c1fe816e555mr7341566b.32.1785513003937; 
 Fri, 31 Jul 2026 08:50:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1758:fc6:a5f8:a15f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd38fde4asm187800866b.0.2026.07.31.08.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:50:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/1] qapi/dump: add allowed-by-guest feature to win-dmp
Date: Fri, 31 Jul 2026 17:50:01 +0200
Message-ID: <20260731155001.1204103-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=den@openvz.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Commit 1c0e259c5a35 ("dump: make win_dump_available() check vmcoreinfo
for a Windows dump header") changed two things in a way that is visible
to QMP clients but not to introspection:
query-dump-guest-memory-capability now lists win-dmp only for a guest
that has published a Windows dump header through the vmcoreinfo device,
and dump-guest-memory, which shares win_dump_available(), rejects the
format otherwise. Before that, both accepted win-dmp on any x86
machine.

A client that wants to select win-dmp automatically therefore cannot
trust the capability query on its own: on an older QEMU it reports
win-dmp for every x86 guest, Linux ones included, where the resulting
dump is useless. libvirt ran into exactly this while picking a format
for on_crash and watchdog triggered dumps, and has no way to tell the
two behaviours apart.

Add an 'allowed-by-guest' feature to the win-dmp member of
DumpGuestMemoryFormat so the fixed behaviour becomes discoverable.
DumpGuestMemoryFormat is reachable from both
query-dump-guest-memory-capability's return type and
dump-guest-memory's arguments, so a single flag covers both halves of
the change. Where the feature is absent, a reported win-dmp says
nothing about the guest, and a client that needs the dump to be
loadable afterwards should fall back to elf.

CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
libvirt discussion:
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/7QBRM2GOC7M5E7EAIE44JNWBSKNN62BC/

 qapi/dump.json | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 726b520870..690f3963fe 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -38,6 +38,13 @@
 # @win-dmp: Windows full crashdump format, can be used instead of ELF
 #     converting (since 2.13)
 #
+# Features:
+#
+# @allowed-by-guest: If present, @win-dmp is listed by
+#     `query-dump-guest-memory-capability`, and accepted by
+#     `dump-guest-memory`, only when the guest has published a Windows
+#     dump header through the vmcoreinfo device (since 11.1)
+#
 # Since: 2.0
 ##
 { 'enum': 'DumpGuestMemoryFormat',
@@ -45,7 +52,7 @@
       'elf',
       'kdump-zlib', 'kdump-lzo', 'kdump-snappy',
       'kdump-raw-zlib', 'kdump-raw-lzo', 'kdump-raw-snappy',
-      'win-dmp' ] }
+      { 'name': 'win-dmp', 'features': ['allowed-by-guest'] } ] }
 
 ##
 # @dump-guest-memory:
-- 
2.53.0


