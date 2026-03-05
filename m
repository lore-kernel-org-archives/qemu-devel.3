Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9B3F33A68
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9Kg-0002Pf-NZ; Thu, 05 Mar 2026 09:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy9KK-0002MY-31
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy9KH-0007pR-Sq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:19 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo3016549f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772719515; x=1773324315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4KgU2sxbWBTJDn+mZu1vTbHfc0ooH6hgchR3bFTMEcQ=;
 b=GqjzcKVTCLnIiPlSKA+OFUPKtPQRmiqpWFlKAHFOjx4wFM+vShoLGKl8yHHJ/7Sz2K
 zvlGQAtL4r/ajcN8MC81PKmFKkE/Qb1IUOpyUhl7EGd0suRSgeBBy4sp2e//7XK/5syl
 yjQLMrq7PDeNUF7ho1V8OpRo85sUJF0beqek0SaKbBXmIw3lXTfeMfPryVvMWsP/Lcdf
 UdbysWFpV+jG7OMS2zjz4TmRfd288dd9Sa3xPaV9CM/5WNH+5eEY2TMbFIB7KP6y8TeK
 rlYOJf7oxnGq6Hq83vHWP19NGZKBtgCGWQgM8U2isEexrPHRzYDfVdfNYR8Xz5kOsE3d
 HBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772719515; x=1773324315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KgU2sxbWBTJDn+mZu1vTbHfc0ooH6hgchR3bFTMEcQ=;
 b=GSvkPRQS96g8j/UVxj2YtUKm8pBr3TydzEt/RWxU4LUMZp5gPf87oHgpAoTHKYSKm1
 pJLGKWc8gh4MzuOiusQLwdhviB1nvuYhPjWeSdr5q3GKWrHTp+KJnmWAtXxsoAEWbpKj
 z/7BXhcKwi7GSEDmPw8j0EL/8xxE9az6hAA3DNiVV+ZKVHi51hwDDOG02YQQ4/Ng3R+L
 7CHThSLwd0oC29rq7Nn+GZc7pqVw+y5S99NAf9oM0albriJIqZi3sIGiTqo62GcoXmvN
 4MdDL7kACNJGd27FYcrPgzZJ0RdXmtm4Or6k58Qm13Kc4CwNLZQTVXCPmOHchROC034j
 MnTA==
X-Gm-Message-State: AOJu0Yw19VF+7EVVENJXqhQff/n14SYHgfSZKe/Pt7vOH+LlDuRsjC3S
 sKiZ+EooO2MQnFlfrT2s/DEUFG1sk7THSFoGhSYWxF/uOeaqgbuM5ccCXQ198k+x0w+o4vvczih
 657eB
X-Gm-Gg: ATEYQzwVi49YOMit8M8H8ojtubm3+r08jAcgRMvaTWkLcnYVuhaQuxVAiM1lH6swyiG
 0yb8ozU6GMGGm05mP3tsQnUyfEg6noMK9KWQqkpgKFRFrK/BRILDw5s+P1hmv9JMM7rVB9U5xm1
 QT8MTGlm4FnO4xTsQ+0uobTFU5AnsrRICyaXcZrwKoIfXwL7JdcwrsF9tKdH0m9V4cO91lSTgWP
 D1hnDX/gKKQTqgQMymuwCa4O4KTzuDT4Glech40lo/vVRX1K8BBW6VT9Yn87dVSNMfpLS0QLTXB
 tbVuRddGHHcgCoPbrZnb93XSQbrJIIti/0NVPJZ5Q6s8XjNJTkmqy8fL5n8OqBjwXpKwtfBpW4c
 lHYVC9JULKFwo/gKvvEIsVFXIPL5KLRO5BmrANkCg1qXJ2osEjdi2IGam3OS8zL67dTqpn+9qg+
 zLGD6ePzMkN0dAHAoyll3AquyShMTdK4D62PIWRP9fCbGfX7GJz2Rjhh+D7kqe2HvPo7Z0/9X8W
 LFdgiqGbhUZFZAslLjB8k48N0Z6CK8=
X-Received: by 2002:a05:6000:2f81:b0:437:75c1:578e with SMTP id
 ffacd0b85a97d-439c7f7901bmr12334791f8f.21.1772719514789; 
 Thu, 05 Mar 2026 06:05:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c6129017sm15517241f8f.31.2026.03.05.06.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 06:05:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH v2] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
Date: Thu,  5 Mar 2026 14:05:12 +0000
Message-ID: <20260305140512.1330691-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
---
v2: disable the warning rather than using the incorrect attempt
at a workaround that v1 had.

On the fence about whether this is worth backporting to stable.
---
 hw/net/rtl8139.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 2ad6338ebe..424af73a18 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2124,6 +2124,26 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
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
@@ -2307,6 +2327,9 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
                 /* restore IP header */
                 memcpy(eth_payload_data, saved_ip_header, hlen);
             }
+
+#pragma GCC diagnostic pop
+
         }
 
 skip_offload:
-- 
2.43.0


