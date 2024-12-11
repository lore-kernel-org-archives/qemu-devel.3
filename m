Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B141BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVx0-0005xF-Py; Wed, 11 Dec 2024 18:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVwz-0005x0-IG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:17:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVwx-0004gt-Ne
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:17:01 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e3621518so4566487f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733959017; x=1734563817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gbSGjVPA/lUnmHLhOPQnoo2PcyTUkwD5q//e7yXLaso=;
 b=QAHGtcgx7yfn3mehPzNZGEGf9pw0LAEVTQa3H1/2jZRRYtOPmrEGV1GkRpT6D50ERo
 R0Z3YyrzoTE0CvZK06f202rpfywWKUCsWm0GL+jC0jNNGGzQjG6NkXa299VqmfKGSH6e
 8jB74hwXY/KHt4UuYgys9XByEpKp5QGXEflRR+rXPae5s+PvUdnjmIJNv6nJd3uXzgnl
 CiJTYg8ymUKncIU4AD8EhKgjGxnk1OxQf4sq8zenSHYPmwCZpiOpx7VLwzJtGpM/TQHN
 /CyhBnbWZY2/N6SKBYgcKCA9IxMWgXIJR/UEmSlUYJIUm17Vc8626mkMaMzFRnNJFGw4
 KWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733959017; x=1734563817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbSGjVPA/lUnmHLhOPQnoo2PcyTUkwD5q//e7yXLaso=;
 b=CV/mqzEVdaKmD+dEBVDlUFBD10MDRDMZRsCFkuT31JOww5GTt6l41o+pgXfauV5lhX
 c6SG7zbfeK+10wuiWyd6iqKdKxHhtE09oNkj00b+Xwdqi9591o1rSTxpnuq6Hg+MHvKZ
 EZGbnu09r2G+6+EKaRu/q9PN+OARsLg799CtznZDIWFfBS8w7lUrSaM/GNZyemioFcCa
 jr5zQ/T2+oEeYnY40LtH4TTrZ+dqFXD74xt9RLScbOvsTEhcSMMtPDSfvmnjI6K0rtuM
 Q7OEJQMyKaP8rhMXK05jcXRX1x8ZcDCEaS65f5Ruz63m+m5XjU92Ff4NabedNdl5mOIh
 fc2A==
X-Gm-Message-State: AOJu0YyH5ltgwWB3jv4T6mZYeL/krzPOv2i1ewJZhm/0XuZ8oflW3huh
 rO5rP5RsKACBfZiENqHh5LMxdI5DcBV9iqO5PU5wFdjUWD5tgWyCYecGhJsnQWM370HILvwQrzC
 p
X-Gm-Gg: ASbGncuiSSektNWKsrwghcX/lVrvZWsH3Am1Tqv0ubAya1ksEyg/oHNmLSvykJJomQF
 bIlzrVi5Iqg4w6TPI0lB+nk24JndLPYDwLfsIY57q19lu8OqGSgCxuD+IU3Hi240WqxFcAJWLat
 J0wh/vJOxoGEpAhHmEl0iv3KGIkxawIhgPQi1O64qR0a7Zi765BynJNstbJ06tqLb++Jecgtptl
 F8Jta5e2+jlvMLZ3laBPw4aEwqBLgCIz4RWLUnAmIxpvAhlCvJOA/CucQ2d/FyWxCRYHg5SNvTq
 3gkrikjKyfqbqj75ewhGb4vGSIbTA61zgA==
X-Google-Smtp-Source: AGHT+IEWEFOix3wu54uX7iFSdKYiJQep4+oz/Md/7zVlYeKMKB7tfUMDhtanImxPXlI4broaPTLnHQ==
X-Received: by 2002:a5d:6dac:0:b0:386:2ebe:7ae2 with SMTP id
 ffacd0b85a97d-387876aeddemr1213478f8f.45.1733959017526; 
 Wed, 11 Dec 2024 15:16:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f810sm2316596f8f.22.2024.12.11.15.16.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:16:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] meson: Run some compiler checks using -Wno-unused-value
Date: Thu, 12 Dec 2024 00:16:55 +0100
Message-ID: <20241211231655.98148-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

When running Clang static analyzer on macOS I'm getting:

  include/qemu/osdep.h:634:8: error: redefinition of 'iovec'
    634 | struct iovec {
        |        ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/_types/_iovec_t.h:31:8: note: previous definition is here
     31 | struct iovec {
        |        ^
  1 error generated.

Looking at meson-logs.txt, the analyzer enables -Wunused-value
making meson generated code to fail:

    Code:
    #include <sys/uio.h>
            void bar(void) {
                sizeof(struct iovec);
            }
    -----------
    stderr:
    meson-private/tmpe8_1b_00/testfile.c:3:13: error: expression result unused [-Werror,-Wunused-value]
        3 |             sizeof(struct iovec);
          |             ^~~~~~~~~~~~~~~~~~~~
    1 error generated.
    -----------
    Checking for type "struct iovec" : NO

    Code:
    #include <utmpx.h>
            void bar(void) {
                sizeof(struct utmpx);
            }
    -----------
    stderr:
    meson-private/tmp3n0u490p/testfile.c:3:13: error: expression result unused [-Werror,-Wunused-value]
        3 |             sizeof(struct utmpx);
          |             ^~~~~~~~~~~~~~~~~~~~
    1 error generated.
    -----------
    Checking for type "struct utmpx" : NO

    Code:

            #include <getopt.h>
            int main(void) {
                /* If it's not defined as a macro, try to use as a symbol */
                #ifndef optreset
                    optreset;
                #endif
                return 0;
            }
    -----------
    stderr:
    meson-private/tmp1rzob_os/testfile.c:6:17: error: expression result unused [-Werror,-Wunused-value]
        6 |                 optreset;
          |                 ^~~~~~~~
    1 error generated.
    -----------
    Header "getopt.h" has symbol "optreset" : NO

    Code:

            #include <vmnet/vmnet.h>
            int main(void) {
                /* If it's not defined as a macro, try to use as a symbol */
                #ifndef VMNET_BRIDGED_MODE
                    VMNET_BRIDGED_MODE;
                #endif
                return 0;
            }
    -----------
    stderr:
    meson-private/tmpl9jgsxpt/testfile.c:6:17: error: expression result unused [-Werror,-Wunused-value]
        6 |                 VMNET_BRIDGED_MODE;
          |                 ^~~~~~~~~~~~~~~~~~
    1 error generated.
    -----------
    Header "vmnet/vmnet.h" has symbol "VMNET_BRIDGED_MODE" with dependency appleframeworks: NO
    ../meson.build:1174: WARNING: vmnet.framework API is outdated, disabling

Fix by explicitly disabling -Wunused-value from these meson checks.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Probably meson should do that in has_header_symbol() / has_type()?
---
 meson.build | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 147097c652e..a431aa982ac 100644
--- a/meson.build
+++ b/meson.build
@@ -1166,7 +1166,8 @@ cocoa = dependency('appleframeworks',
 vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
 if vmnet.found() and not cc.has_header_symbol('vmnet/vmnet.h',
                                               'VMNET_BRIDGED_MODE',
-                                              dependencies: vmnet)
+                                              dependencies: vmnet,
+                                              args: '-Wno-unused-value')
   vmnet = not_found
   if get_option('vmnet').enabled()
     error('vmnet.framework API is outdated')
@@ -2690,7 +2691,7 @@ config_host_data.set('CONFIG_RTNETLINK',
 config_host_data.set('CONFIG_SYSMACROS',
                      cc.has_header_symbol('sys/sysmacros.h', 'makedev'))
 config_host_data.set('HAVE_OPTRESET',
-                     cc.has_header_symbol('getopt.h', 'optreset'))
+                     cc.has_header_symbol('getopt.h', 'optreset', args: '-Wno-unused-value'))
 config_host_data.set('HAVE_IPPROTO_MPTCP',
                      cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
 
@@ -2708,10 +2709,12 @@ config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
 # has_type
 config_host_data.set('CONFIG_IOVEC',
                      cc.has_type('struct iovec',
-                                 prefix: '#include <sys/uio.h>'))
+                                 prefix: '#include <sys/uio.h>',
+                                 args: '-Wno-unused-value'))
 config_host_data.set('HAVE_UTMPX',
                      cc.has_type('struct utmpx',
-                                 prefix: '#include <utmpx.h>'))
+                                 prefix: '#include <utmpx.h>',
+                                 args: '-Wno-unused-value'))
 
 config_host_data.set('CONFIG_EVENTFD', cc.links('''
   #include <sys/eventfd.h>
-- 
2.45.2


