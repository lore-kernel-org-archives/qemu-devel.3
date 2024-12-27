Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85884E77191
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 12:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR9Eb-00030w-Em; Fri, 27 Dec 2024 07:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9E9-0002v2-AT
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:14:04 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tR9Dz-0005Fu-P6
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 07:13:55 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so941578366b.1
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 04:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735301628; x=1735906428;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cZzMlorZxepNwBN9OE1rEkxv6kXqEyMS3VAO9/DPjk=;
 b=YCO8JANzQYkZ1f0Sf05+iATSdesLm4kUkdc7wIf3Tkd2FNfvU30Mewrk29WDbFFDT8
 DhGn8rl1+sOhBGrYhRg8ljQsiMWjZNBPjU1ryNKdksoKXqdnbpUDK0JzwPVOkUu0jns1
 x3o7kPHU1UHXQiv6H+HYij+HmAzuQIERCMN/IewVVvHo+MXKswQOBNOTza06DvuAYOsv
 8H0/jnSrmVcyWYxhINJLSCUvaTsc9S9A/S3P3Dfu21vybe7pqGuiZvzShtnTsV2mF8Uu
 pUqPRkweNOORdavC/7AZF6Vdm6EDmhPLYH4ZpFG9Nr0b9cFkw3NPbwm50xpq5BLSyLqr
 ZD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735301628; x=1735906428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cZzMlorZxepNwBN9OE1rEkxv6kXqEyMS3VAO9/DPjk=;
 b=hI/hkWf+BVOTZv4b6g7li6WTWv2VjeRSDPZ5apIPVDPcAF1AYkTdI0UopsRt5B3sm4
 yr9qLfCePu/Nc7UtaSxhAmQ601qpPf1bJZxDSbokyibkScvO+TYBMtsWHy7eiIqV4wX8
 Q8GBMRIbR63Ewkcd/w/L9CoLWfwlJCNnSf0AAGTGLjUKqVsYskEZUCazszKES8L+000f
 ZpGUB5pgc6+jPFsOk1PMZ0yOlxxx2zVGFZiCI7w4kEddrLtDAnVej3lLgh2Q6hLDHG1C
 GbARBSzn6jZNIPDLdjdFVTltrOfok+9MaVFqfms292P9u1nMhh7eCUZgVFf+XqqiVcpA
 7K1g==
X-Gm-Message-State: AOJu0Yw+s9NnMUe1WrOHOb5rKQkZFJV5c9heT7g3Kn91/o/tn6RynSc5
 sOUMfz6JB8XLd/a876sanRPoBkqNK9JfbZR3b3chIC7DDjcFbEdINiK5MzrrZ8SfbjQU8+9fSHI
 =
X-Gm-Gg: ASbGncsInHuitNbBr7N65Zq8KZZRDF5kimtyCDgoQhSnLGGA/FFCamJxQ7DzGfwA/9Y
 +y58xSmetH3bjZkr5p2BNkMV0RafMtPhE0pNUMmIB3QNZ3ValgbVEKqBPU9liRP887ldMdaUV76
 bQ262+yQwFbeIQqhrmVvGv+n1SlUB34tVecYKswRDv73BZ8HEz4oiv4NW8EfMEsoIAIBLReDUVc
 YArHCYExotMdLzG4uDv2VrOOWih4POYo+QNcYqnbktX8x5QbmKQHiBn3BYPnagn4XoZZZiWHuVK
 ypDmsFeWgtblWWNWHdBcgkLNLcXdGcjo
X-Google-Smtp-Source: AGHT+IE5dK31E6/U/uH+HBvl95wXI8KbV1zJZaXpDRO9NAL4sjOO3k6TsmtHXfAhvELhIewyO20jRg==
X-Received: by 2002:a17:906:7311:b0:aac:278:98fd with SMTP id
 a640c23a62f3a-aac2ad80073mr2447233466b.17.1735301627989; 
 Fri, 27 Dec 2024 04:13:47 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82ede9sm1098662766b.2.2024.12.27.04.13.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 04:13:47 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com, akihiko.odaki@daynix.com,
 npiggin@gmail.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 4/6] hw/usb/hcd-xhci: Unimplemented/guest error logging for
 port MMIO
Date: Fri, 27 Dec 2024 13:13:34 +0100
Message-Id: <20241227121336.25838-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241227121336.25838-1-phil@philjordan.eu>
References: <20241227121336.25838-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62c;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

The XHCI device code uses tracing rather than logging on various code
paths that are so far unimplemented. In some cases, these code paths
actually indicate faulty guest software. This patch switches instances
in the read and write handlers for the port MMIO region to use
qemu_log_mask() with LOG_UNIMP or LOG_GUEST_ERROR, as appropriate in
each case.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/usb/hcd-xhci.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 011c445443..00d5bc3779 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2814,9 +2814,15 @@ static uint64_t xhci_port_read(void *ptr, hwaddr reg, unsigned size)
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
 
@@ -2885,9 +2891,22 @@ static void xhci_port_write(void *ptr, hwaddr reg,
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
2.39.5 (Apple Git-154)


