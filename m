Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A69C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u144E-00027I-1t; Sat, 05 Apr 2025 10:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u144A-00025F-UM
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:00:11 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u1449-0002Pl-3M
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:00:10 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so2716784b3a.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743861607; x=1744466407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2usuboqUPlKvjXYg/jN9W27aNQUiWnDW2jrzcnUjkSE=;
 b=neUYACTkeA7vtjOSyzHKPj6zvelNdL3fpEQWSZULBceeF3ifAh9lCICFoI4LmKCPmn
 j6NZRKP35N3RPL1+mBDQsQMxleOFnGrPAR3didvhGna73b2aMQnz1chIAqhD5hO5MZFb
 VrV53W9eCxgYtIu+j5mgyW8a183BbJuDgD2F5N60jqQHVjiQN7+3DC/lfpYf8YVh3+hr
 FjbTStbSM3eI3mUnzjd4AJCh4bGWw0BccNgKT3qj20ia8Bu8bu6NYWWUONxIIal/m0QH
 byzBNdM3qD7FyxolyX2KCdBqYK6HQXkCJfIyKa7DWaUicsPTJKBsZe4qoF4TwDoZoalo
 ni3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743861607; x=1744466407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2usuboqUPlKvjXYg/jN9W27aNQUiWnDW2jrzcnUjkSE=;
 b=tnYXFE26panTAO+qUvwTZvncrgpZ8pO3joffrhQrmuXi6lE1UCMo4JIs+f6/QEtE3U
 4reJOo6DrvENVgTJDFftNyMCJlXEJIY2fClhd23TrktEtLCUlbX4UvhLXccUJL88sm/A
 KU0vF7KAl2N7fQKihJ3YDZg7bCKq5t6rWv9c1hPvH1MaMF/COPF+CSy4xXwvhQMlxt9c
 aUo4VoA+LgnkaWzzqjp4pnEDoYLX4oPuvvBO2EW2ORoRBy7/rukioPDcrbDr9sUhKVFP
 VEmKqSi+1q6eAEUJ/SOv9DKgODLZDPk37t4vgbIvbLfzE6lDq378yspFlJTjvoQ+o5E/
 3SWw==
X-Gm-Message-State: AOJu0YwbcPZWQaEfAuxbnG1rL5zPHs3apUf2gqt8B5mirRc+5axLWWQ1
 ql0gUNNO/A6xdOB3fA7BQupjgXnZ7p+8Sh8YRH9Qcb1P9lhQ8+znZJCYAA==
X-Gm-Gg: ASbGncu0XfmQhBi69EPrFNh32oFH28yEoANEdXjHce4v1iPr3Uzug16ZTRETL7hC/fi
 FE02nlTjOjcVYTmEKm0m4651V5fVr9MgZz0kYMBXAMFIBr8rQHx00ZYFhe3A3VPLmAZj1jQ9kH/
 qFHxotXYPMIkY72EZYD4EguMgltX023BsBRkdxMoYZrq7MkdUe8Qi3pXnxbQyDgQOHa0TsDibe2
 Vmc+cX49Omeb6oSVUft6cknH/zfz48pQ7zAaWSsY6RyQikcc/f+3bBqSxgLn3qTtBzH+Kudv+BF
 90WXLq8zIKFr8j1EdpkkbwO0enzXAjkXY7HhrFKlU1ZHymzPP0heQHAyCw==
X-Google-Smtp-Source: AGHT+IGPpzPXfOhtoQnbuoKyjUG3P4YhTC98O6IqKZ8713spjC2J61EwwVxP/a96jNdwEmUQfD4SyA==
X-Received: by 2002:a05:6a20:258e:b0:1f5:8fe3:4e29 with SMTP id
 adf61e73a8af0-2010458cc73mr10103895637.3.1743861607327; 
 Sat, 05 Apr 2025 07:00:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc41c626sm3743062a12.78.2025.04.05.07.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:00:06 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] hw: usb: xhci: Add property to support writing ERSTBA in
 high-low order
Date: Sat,  5 Apr 2025 07:00:01 -0700
Message-ID: <20250405140002.3537411-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250405140002.3537411-1-linux@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

According to the XHCI specification, ERSTBA should be written in Low-High
order. The Linux kernel writes the high word first. This results in an
initialization failure.

The following information is found in the Linux kernel commit log.

[Synopsys]- The host controller was design to support ERST setting
during the RUN state. But since there is a limitation in controller
in supporting separate ERSTBA_HI and ERSTBA_LO programming,
It is supported when the ERSTBA is programmed in 64bit,
or in 32 bit mode ERSTBA_HI before ERSTBA_LO

[Synopsys]- The internal initialization of event ring fetches
the "Event Ring Segment Table Entry" based on the indication of
ERSTBA_LO written.

Add property to support writing the high word first.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-xhci.c | 8 +++++++-
 hw/usb/hcd-xhci.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 64c3a23b9b..8c0ba569c8 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3107,10 +3107,15 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
         } else {
             intr->erstba_low = val & 0xffffffc0;
         }
+        if (xhci->erstba_hi_lo) {
+            xhci_er_reset(xhci, v);
+        }
         break;
     case 0x14: /* ERSTBA high */
         intr->erstba_high = val;
-        xhci_er_reset(xhci, v);
+        if (!xhci->erstba_hi_lo) {
+            xhci_er_reset(xhci, v);
+        }
         break;
     case 0x18: /* ERDP low */
         if (val & ERDP_EHB) {
@@ -3636,6 +3641,7 @@ static const Property xhci_properties[] = {
     DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
     DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVICE,
                      DeviceState *),
+    DEFINE_PROP_BOOL("erstba-hi-lo", XHCIState, erstba_hi_lo, false),
 };
 
 static void xhci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 9c3974f148..cf3f074261 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -189,6 +189,7 @@ typedef struct XHCIState {
     uint32_t numports_3;
     uint32_t numintrs;
     uint32_t numslots;
+    bool erstba_hi_lo;
     uint32_t flags;
     uint32_t max_pstreams_mask;
     void (*intr_update)(XHCIState *s, int n, bool enable);
-- 
2.45.2


