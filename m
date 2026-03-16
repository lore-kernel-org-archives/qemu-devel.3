Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D9BF4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PD-00012n-Lp; Mon, 16 Mar 2026 06:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PC-0000wm-AE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PA-0003dr-CD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso2368645e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657755; x=1774262555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tLF7kvnzhJViV1rgW0YuvQ5EtzgQNtK+n1ay2fRkX7Q=;
 b=xnuMzFGKIShaZQDHKLjscKx8PtMA410bXFXnQhsb2TVZ0vIoY5olW6KxKRswNjITda
 XdaIyKdAr+5VmgtrYwU4BqbiDognnXNdSjMcC2owx/FAGZIfhT6JmdDqc9w6FtXnsn2Z
 vyyO2+nIlqVzs3FnZKWn7mSLBtbl4lK59GBLUXSwJR1pfderL5SWm2NE8zJZsoLPeyV+
 CVmKwim5C7Rvy5vjq/jCm3FEAUhzIlxe75odwqyvUnRfVdEci/sjCGALpLNBX9diYbnD
 NGLJ1/QZbbiyWruT1/w7QSE3cr8Ax318CW7Z6mMc6yzdeUFysXDl8pAvbU6+uPwKhork
 bqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657755; x=1774262555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tLF7kvnzhJViV1rgW0YuvQ5EtzgQNtK+n1ay2fRkX7Q=;
 b=KA9Z0112EIiuUng4as+yZsW6EoqkZ8of3vl+6UWQtntW42FG9xM6QttM/TX4ceDt/7
 RMZCp5D6zE7nFcm/ERfeglUUqhy3WoF7WoOLFr9AWTvzOOISYY4RSElJ5TI9YFTGy95v
 k3mSx9ECXDFagzXpqwEZe8iN8UkSAsl9k8nbI+oWKU94iuBfzN62CZ4Vg5FY26O6D62f
 aGon3mbe9Rycbo6oArpMSWm99fbg1WW/BG5YIGRsboZsOhTpNv7ISuWdSg+Kr3egUUlJ
 ws3s/FxlnmLPbns8Rw1is2O3NDCQdwjAugbMjPO8bGU170fczI08WH0LIbKPmVfnfzlA
 mfPQ==
X-Gm-Message-State: AOJu0Ywd8Xk5NTBVQ6hpwS8oLqVt4jFDMxj6P595auOEKiHTrefLtaOp
 oSwVhaJrKzIsZ/aEw3vw6SEojEE0HRK7eWriZRxzk/CiB8ro8b+r8QsLb7JbxFGTwtQvwExgsQv
 h48o7
X-Gm-Gg: ATEYQzxaLjgioLJEc1aAFZQ+wQTuu/hKPAbWfPUg2jyvwPrNK3r0Rvcm3Gm8VtnWIkI
 fLbDuUitJD5RqHgD1Hk4y3UCTC3STFZlH6dpqeYvSAbbKe5Jlpo8yEgwwYe8SCHAU+O8sQV+jPD
 RkUFbqF158cV4lGZIOiViSlPpRweA3COI4aX60jax1v0olHBIz9DsjxNQp4GSkX8RRNKhLv2lXH
 4O/swc7eTlYxDhk1B3h6MOcwppgnUABC6WuZ+XONHxsrCWHUIAfd+Dfmnlo731liUxn+SEoO/tn
 s06BZS9K3W0xpoRRHUUQG8jfY1l50iZNv/IzOpO7xS4Vgo+aw5mmMOQMi9CzPCaI+tzhn++4Er7
 aJG/6rgPemTAhWcwlrLM06XtL5oS2SvF1RG0hl0TJTRiDeJOfB8p7oLtR1ddsIU//Sirwb5s4fh
 5CCSVs8dQTV6hYgeLVfdwlRzny20uXh5Qfl+gzh0daoHMrszr11Y+Sub3ftCiKn4zI5LyYLCcAq
 nMEZ1Q/u+A=
X-Received: by 2002:a05:600c:45d3:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-48556705301mr210549345e9.29.1773657754522; 
 Mon, 16 Mar 2026 03:42:34 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] hw/net/rtl8319: Work around GCC sanitizer /
 -Wstringop-overflow bug
Date: Mon, 16 Mar 2026 10:42:14 +0000
Message-ID: <20260316104230.836962-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20260305140512.1330691-1-peter.maydell@linaro.org
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


