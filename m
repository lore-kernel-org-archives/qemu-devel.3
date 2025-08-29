Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97A9CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNH5-0008S1-W7; Sat, 30 Aug 2025 11:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhq-0000te-1g
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhn-000833-GV
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfsc9amcqQ41jjeMgTPw5ExWTEFHK6iHXDnIIT3wi2Y=;
 b=JZEYXSL4bO6thcqnYeAZ9GZXZfaYDC4Wyc+NDs1zheFmwAUCDct5k4M50W2T8LBowiMBmC
 pCTTG22GGuXYF0XCHsQcXTxddWui5qsS1qQbKi+j/laVkK6+braD43+bmyyMphFEJngdnW
 Mc/CAe74QawK6JhEjT4lRWzXOSKVLR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-Ef3cfSASPjCGhJfrmUbviw-1; Fri, 29 Aug 2025 08:59:44 -0400
X-MC-Unique: Ef3cfSASPjCGhJfrmUbviw-1
X-Mimecast-MFC-AGG-ID: Ef3cfSASPjCGhJfrmUbviw_1756472384
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b05d8d0so14850825e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472383; x=1757077183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfsc9amcqQ41jjeMgTPw5ExWTEFHK6iHXDnIIT3wi2Y=;
 b=nWNvkLM7OxmLR8rdrwZnZQz7j+Y/dNFjyfZdiyNvmQx5Cpor4XY6BagU5gpUhnivsk
 JE8cp+BOzO8cnMKn5EmTawhPiXGXIUAHc5xVAaYwaiO/N5YTszMIM2rDy3Ctkulm0NG+
 4c1kECy2BZelVY+EViOof6hu6NLTCjc1LTnXnMHtiBMz0E1zJ47Otud9pPEM28G+lrf/
 4P90nGLM4nVBgx9sseX6qBFtAvV7fuqLavM8ZPU+hOCaESEGPKJ/Yb92Q0Ygy0pjuN7k
 uIYnCXbVwmQI1Qh2s6WcSsFSsvC54G1A1owwN0o0uGMgJ6BSSFZRAuk3PvfpYez4MqRR
 whEw==
X-Gm-Message-State: AOJu0YzF+kFziiP3yemYx0helxzEa/kEbJtT0LOJCPyRjdVmff5H4zPf
 6OWEYOR87scSsckvhvlyAXO6eHB9mxZJHxRak2HqA3PQS/XtLimERBeKTON6UxUM7XnT+zE8qgW
 H1CAtM4qFbsib1e5KGXBGFFySfWC9LQjuUzL8tNZPYwMg5DJIy3BHbq7YY6rVW7D0yF2hTEYXkW
 EjxUaahPzDGCr3PLew8JxTCfYrO1JRey4XkGTZIfCb
X-Gm-Gg: ASbGncsH410MuYe0P6fD1xmv4QHZogeAR+LFww5QtGxODKWkxlvJNY8wY7IBmSiP/5Z
 iuzHpnkqKsAaRbgS8l9zCT6b6DpFTvqNZ6SQ4DyDU87FP41OFX7Sv/dVEPuo5n70rSz9eTyNg2A
 PMkNnL5+K44Y5Rc6aceqscJqvoB5xsDa8GyZBGCQAPkMJLbs8rkFxLXAezkmHo4Nhlro7RVrCFB
 dMTp1hm7lZSxjIRNVQJ7gg9ZJMt1/8ohULS+Xxwb40TURjvk0aVJfUCbzenWnBeZF232txDrFpn
 Wg1jOxgHS5vjB0gqXvikK4vQLbZ9NjdbylK39hhUExwqOU4tjEvGgJ4KEMXeZLwidXEQMzuJcXw
 Tk4Gvt2usWngH7S9ZZ/JOznrmFtNxlDCqSGCapWZ50jQ=
X-Received: by 2002:a05:600c:4747:b0:45b:627a:60cf with SMTP id
 5b1f17b1804b1-45b627a62cbmr175327855e9.24.1756472382818; 
 Fri, 29 Aug 2025 05:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFykXfgNICbjEkfJnBPpkOxPSDr+eYSMsQ5lhRO6hW02Rnm+jpRgIW7gYoCOPp+nlFXtotyHQ==
X-Received: by 2002:a05:600c:4747:b0:45b:627a:60cf with SMTP id
 5b1f17b1804b1-45b627a62cbmr175327455e9.24.1756472382244; 
 Fri, 29 Aug 2025 05:59:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6ee66bddsm118704745e9.0.2025.08.29.05.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 02/28] hw/i386/pc_piix.c: restrict isapc machine to 3.5G memory
Date: Fri, 29 Aug 2025 14:59:09 +0200
Message-ID: <20250829125935.1526984-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Since the isapc machine is now limited to using 32-bit CPUs, add a hard restriction
so that the machine cannot be started with more than 3.5G memory. This matches the
default value for max_ram_below_4g if not specified and provides consistent
behaviour betweem TCG and KVM accelerators.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Link: https://lore.kernel.org/r/20250828111057.468712-3-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8f5fb3cf90b..9a3b5d88f08 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -461,6 +461,12 @@ static void pc_init_isa(MachineState *machine)
         warn_report("-cpu host is invalid for isapc machine, using pentium3");
     }
 
+    if (machine->ram_size > 3.5 * GiB) {
+        error_report("Too much memory for this machine: %" PRId64 " MiB, "
+                     "maximum 3584 MiB", machine->ram_size / MiB);
+        exit(1);
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
-- 
2.51.0


