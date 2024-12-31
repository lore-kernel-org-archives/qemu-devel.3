Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A6FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSin1-000726-UH; Tue, 31 Dec 2024 15:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimr-0006ne-A6
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:22 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimp-0000yM-83
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:24:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso67675895e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676657; x=1736281457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OsyYuL+27oK54ZGKawyCinUOguZIMyJUg2PlLlormY=;
 b=RGH+ILdZAKGJBYa2U4p4PmIkbx64MJPwmIHr1sWm5qCUjgFv9Ek+ZrSbvgVxbmZr11
 nqsg8zbUrCbvnUzqAneapNyIt+TpjwqCb5aZW42U6J4+ayNCAr4xxed0oHC355txLQf3
 BLAv+s2rRnBD+RlVeYVDHdfPpnjDCR574iDcHDWxPF8HSZln31bMSxG0VJM4leEimriS
 wiRy9ubRFeYV28b0P52GS7Ee20Vw7xTD8hYMXWgtwrovs+h7LtcNYBB9oeq+FLHCoXK7
 IjdF/EIFkRLMlIufVKsgUBllu4nPXArgZkd8SjZjN9x8Rd6ZOoK0a+ZgPBdeH+BG7ZHC
 psfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676657; x=1736281457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OsyYuL+27oK54ZGKawyCinUOguZIMyJUg2PlLlormY=;
 b=i3XuDN1NbP5ap+ZV5WCiztn/QnoBAvIBHHpk1dyDZfzjUc9yFj0k20hLznBY85JTlI
 /0zz1tNEodH69mn9RVdeCmreik0CpZvHsVweXS3XUCqXz1S1fSoJSUM6J6a5gd7+S671
 9EwtDLDpEC28VKVRsxY2cXXbfoyUF0jHrNh1I9w57oix05/Eo50LWi2glfbo6chcA4lf
 SPPZvgaUU4O9IcUxVTuZrEWfh4QAkCeM4BJuksvBPsSd+6m7FzNFLbCet8NgQCTlva3A
 BJK90GaJnKBitDOqBqLWmpWHc2ro+HgGXmEq75ZMsAmV4ws16/6Kol/+gg8YY9fRCrZl
 M4cw==
X-Gm-Message-State: AOJu0Yw1EkJnJw9jPkj1lNmAoLBNzVdLJX202fEhJOYZd2NT58AcK1N4
 uude0pAsZHs1GydmtEj/W3UWx3boQN336giQblqF0oQ7j+QAvzMvjqBxYMi6CntZaBxuC0Dmxr3
 DdqI=
X-Gm-Gg: ASbGncsd9wb6Lvw9ypVd4RX9mHfxVqta4Qq2IyxsZVA/Lmvrir4a75UBYptnYTVIzGG
 RyNQxBnBclkg7/bIdnBvNllzCiliGdAR0ZB8f9xGYe3EpL56dputuEPdgpKAjtJZ8nAXybynINz
 sT0Gt4B9xN5PjW5x78dGKCE6BqFBzgKb1r7TM0MpaD1uKRqOhTdkaHWEDjg11sFBWS9TvQyVLQZ
 o6kjjl8CJwaHH9wu1Uxa5fh3//jmYhqdvDllPJP6tEDyDrgVlCfqshw0TryT1feaQwawrbRZ8tu
 hER9jjevk8TwClg68qo1MfNwplGCOyY=
X-Google-Smtp-Source: AGHT+IE6r4lvWNGyGxrLvUk7/e5JsFXd4B/ZfL3UgH9EBA5Y6jTZnz6Ar4qNRTfJGugThTleDbdoEw==
X-Received: by 2002:a05:6000:2c3:b0:385:df73:2f3a with SMTP id
 ffacd0b85a97d-38a221fa8eemr31826814f8f.14.1735676657207; 
 Tue, 31 Dec 2024 12:24:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828a8dsm33868515f8f.2.2024.12.31.12.24.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:24:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/29] hw/usb/hcd-xhci: Unimplemented/guest error logging for
 port MMIO
Date: Tue, 31 Dec 2024 21:22:21 +0100
Message-ID: <20241231202228.28819-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

The XHCI device code uses tracing rather than logging on various code
paths that are so far unimplemented. In some cases, these code paths
actually indicate faulty guest software. This patch switches instances
in the read and write handlers for the port MMIO region to use
qemu_log_mask() with LOG_UNIMP or LOG_GUEST_ERROR, as appropriate in
each case.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241227121336.25838-5-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 3719c0f190d..7dc0994c89c 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2810,9 +2810,15 @@ static uint64_t xhci_port_read(void *ptr, hwaddr reg, unsigned size)
     case 0x08: /* PORTLI */
         ret = 0;
         break;
-    case 0x0c: /* reserved */
+    case 0x0c: /* PORTHLPMC */
+        ret = 0;
+        qemu_log_mask(LOG_UNIMP, "%s: read from port register PORTHLPMC",
+                      __func__);
+        break;
     default:
-        trace_usb_xhci_unimplemented("port read", reg);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read from port offset 0x%" HWADDR_PRIx,
+                      __func__, reg);
         ret = 0;
     }
 
@@ -2881,9 +2887,22 @@ static void xhci_port_write(void *ptr, hwaddr reg,
         }
         break;
     case 0x04: /* PORTPMSC */
+    case 0x0c: /* PORTHLPMC */
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: write 0x%" PRIx64
+                      " (%u bytes) to port register at offset 0x%" HWADDR_PRIx,
+                      __func__, val, size, reg);
+        break;
     case 0x08: /* PORTLI */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write to read-only PORTLI register",
+                      __func__);
+        break;
     default:
-        trace_usb_xhci_unimplemented("port write", reg);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write 0x%" PRIx64 " (%u bytes) to unknown port "
+                      "register at offset 0x%" HWADDR_PRIx,
+                      __func__, val, size, reg);
+        break;
     }
 }
 
-- 
2.47.1


