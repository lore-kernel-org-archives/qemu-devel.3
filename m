Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66690CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuIg-0004m2-Ul; Tue, 12 May 2026 17:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuId-0004Xh-SV; Tue, 12 May 2026 17:05:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIb-0000vy-7u; Tue, 12 May 2026 17:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619299; bh=C5ExII9Zg+qHbyhArwD1N2xdyn7wDizAHICldTj3iGg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VZ1ButC9/wUkpOxI3aqjSzOOKEKDgYVaibwo9qpzk5+EMJLDB4u+LWa+CBoFurmCp
 4cqIlHpPfGMAul71lfCc0mnCJjxlJFCJpfS6bFJgMrt7iIRMIfO8zbO34TmzlRPDAK
 3gt6TDAIJV/1oTlEIB7nTBd5tqClzJLGcFPMMY/i5mJHrvQfH/RnGqVESoS5BY1Nyi
 DsLdNClynyyaVHmjwHB/DskLYPT2Iu30/gnz65n4QwD0KlZjllZ/w3kLlXxyb4Tye0
 ccAm1px/fU6MR/ThglaGI/y5ouMWWMb8Q7iMp4Rc2KPOLUJ/qouCMFpiWoL25a/7RT
 oCN3oPFB9C+fg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAA311AA33C;
 Tue, 12 May 2026 23:54:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D29043ABCAE;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 001/117] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
Date: Tue, 12 May 2026 23:53:03 +0300
Message-ID: <20260512205503.361097-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

If you compile QEMU with GCC with -fsanitize=address and
-Wstringop-overflow, this causes GCC to produce a false-positive
warning which it does not produce when the sanitizer is not enabled
(and which makes compilation fail if you're using -Werror, as we do
by default for builds from git):

../../hw/net/rtl8139.c: In function ‘rtl8139_io_writeb’:
../../hw/net/rtl8139.c:2264:17: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
 2264 |                 memcpy(data_to_checksum, saved_ip_header + 12, 8);
      |                 ^
In file included from ../../hw/net/rtl8139.c:62:
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
      |                     ^
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
../../hw/net/rtl8139.c:2192:21: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
 2192 |                     memcpy(data_to_checksum, saved_ip_header + 12, 8);
      |                     ^
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [8, 48] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~
In file included from /home/pm215/qemu/include/system/memory.h:21,
                 from /home/pm215/qemu/include/hw/pci/pci.h:4,
                 from /home/pm215/qemu/include/hw/pci/pci_device.h:4,
                 from ../../hw/net/rtl8139.c:54:
In function ‘stl_he_p’,
    inlined from ‘stl_be_p’ at /home/pm215/qemu/include/qemu/bswap.h:371:5,
    inlined from ‘rtl8139_cplus_transmit_one’ at ../../hw/net/rtl8139.c:2244:21,
    inlined from ‘rtl8139_cplus_transmit’ at ../../hw/net/rtl8139.c:2345:28,
    inlined from ‘rtl8139_io_writeb’ at ../../hw/net/rtl8139.c:2728:17:
/home/pm215/qemu/include/qemu/bswap.h:284:5: error: writing 4 bytes into a region of size 0 [-Werror=stringop-overflow=]
  284 |     __builtin_memcpy(ptr, &v, sizeof(v));
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/pm215/qemu/include/net/eth.h: In function ‘rtl8139_io_writeb’:
/home/pm215/qemu/include/net/eth.h:50:14: note: at offset [24, 64] into destination object ‘ip_ver_len’ of size 1
   50 |     uint8_t  ip_ver_len;     /* version and header length */
      |              ^~~~~~~~~~

This has been triaged as a bug in GCC:
 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
(the sanitizer pass rewrites the IR in a way that conflicts with its
use by the warning pass that runs afterwards).

Since this is the only place in our code where we hit this, work
around it by disabling the -Wstringop-overflow in the part of
the function that hits it. We do this only when using the
address sanitizer on GCC, so that we still get the benefit
of the warning in most compilation scenarios.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20260305140512.1330691-1-peter.maydell@linaro.org
(cherry picked from commit b83a42dc779a36b454ce6eeade4584018491faf4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 324fb932aa..eb0bc782bf 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2132,6 +2132,26 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
                     hlen, ip->ip_sum);
             }
 
+            /*
+             * The code in this function triggers a GCC bug where an
+             * interaction between -fsanitize=address and -Wstringop-overflow
+             * results in a false-positive stringop-overflow warning that is
+             * only emitted when the address sanitizer is enabled:
+             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=114494
+             *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
+             * GCC incorrectly thinks that the eth_payload_data buffer has
+             * the type and size of the first field in 'struct ip_header', i.e.
+             * one byte, and then complains about all other attempts to access
+             * data in the buffer.
+             *
+             * Work around this by disabling the warning when building with
+             * GCC and the address sanitizer is enabled.
+             */
+#pragma GCC diagnostic push
+#if !defined(__clang__) && defined(QEMU_SANITIZE_ADDRESS)
+#pragma GCC diagnostic ignored "-Wstringop-overflow"
+#endif
+
             if ((txdw0 & CP_TX_LGSEN) && ip_protocol == IP_PROTO_TCP)
             {
                 /* Large enough for the TCP header? */
@@ -2315,6 +2335,9 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
                 /* restore IP header */
                 memcpy(eth_payload_data, saved_ip_header, hlen);
             }
+
+#pragma GCC diagnostic pop
+
         }
 
 skip_offload:
-- 
2.47.3


