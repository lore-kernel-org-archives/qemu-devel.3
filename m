Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1077C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 14:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmDNF-0007pr-VT; Sun, 23 Feb 2025 09:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN6-0007oM-Nm
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:21 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN4-0007df-G6
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:20 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dedae49c63so6555801a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 06:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740322456; x=1740927256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EISobMCtsGJwgBBoRUyUGsapTk7Zv2HzSGY51pLZdkY=;
 b=YQHuYNA8qqmBubBupxF56G7cxiPO2JipK3HTAY8TJ4lANUFetuCF+EEBu1+f54J+rn
 lyNefSXJ9kkOI9Sd/Ev8u9p7/2i6nE2otoSa/lzHCrh3bATdaPckmjhCOR1gkAg/a+Tw
 gbJLFubWVLCXRO+5qlv1u7rJOCu9fb5pzj1d5x0GWgMghfQZBllYFPSDyqroYyREhqQw
 Lm+lz6q/jHZtyrReKJ/gDFtWPQnDewcT1lF/+Fww892Tg3w/mO5p/lgwPvwt1mMsOZcY
 8k9gLJYlrLgObfE02vT6lsMhDYZ1n9+N88F+1CqK7FYhhmgp+fmPaJIAwzHV8lpXzR7U
 bgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740322456; x=1740927256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EISobMCtsGJwgBBoRUyUGsapTk7Zv2HzSGY51pLZdkY=;
 b=ELoSitRWpww77kiQCCwuSUqE+cBwz3PGriZPw8G6dZyOEbkECmwaydZndnMPaUuE/G
 Dw8nNeEAJzGJUpzsqGC0KEMYQKdBAwqSXs2H7Gdaukv5RcU982f9uP1O7JBry6732YSD
 mxhMRGCJZ/uj7ZLVBMqP+pG3FE1TCoA7QgIxK6BnkJKxQ/DXyArXZHCab8Q5rmSoBJZ2
 /+W6rWfbnEiN5foXb70qmuTepmOhpUfgaWBwYRugLAOS2XVnPSgUj/RKKfz9oY8VBTif
 6hDDJHU7O+oMKexXg6VJ+k5EOUNKOAT8hA3ZV95kPWVJIQ8HSWUekP7qw2TNmj9Z6Bbb
 VXQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVULb2w0M/sNVcKpB7Hjy/WFHkM8yjEI1RZ4ldN+Kaoy3QQkAwiIv1TeTnAEW69LycQ6/VAABXKGs/2@nongnu.org
X-Gm-Message-State: AOJu0YwbEm6+mh/i7M2cNy5Uc3zO1V63vWJ3xUHuJqLpaoy/83QiSyaD
 c904jAJI5lDRbFG1rdXmwBWeoQM07s4ofYfWwFR0DxPRVF2hUpKn
X-Gm-Gg: ASbGncuJzbPtMu9iNQy5hd1iNjeOEImQqHvpwqcmhZCaknD4InzC0rAt0y1um+1UhvB
 24VyBO5TcgvGBdi2BBnjZvw8ZJFFM0cgJGxcbUHHoaGLbjPSMZLbQaJ5aPR4CHOHHoBFOO2KKTW
 MvDGEQa5/Nq1drhvDfKMCoMY2S5L1Oca+laYqwC7zO2HvmLJBKA/8l8lqhYKYOVyaxq/XW7wZ4Q
 Z0dgE10XeQtmSvR1tZQnUWmSCMq0toNsjECe2Fzb0l2ZgAybRpkHZI5sZ3YveUB5ZuIsgHCMS/Q
 kZqhesz9Xbeuu1jf0ikMRXTsPkC840gSg4M=
X-Google-Smtp-Source: AGHT+IGcMob6w5BxKrpNJHfXRL/y4UXtRZkCdAQJlM3VLLHNm1cPdzRPc9Ea0ADL+56bguabH3wo4g==
X-Received: by 2002:a05:6402:430f:b0:5e0:4710:5f47 with SMTP id
 4fb4d7f45d1cf-5e0b7243e16mr9487930a12.23.1740322455481; 
 Sun, 23 Feb 2025 06:54:15 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:1283:abda:b08f:72e4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a0310f66sm6431580a12.81.2025.02.23.06.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 06:54:15 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/5] ui/console-vc: introduce parsing of the 'ESC ( <ch>'
 sequence
Date: Sun, 23 Feb 2025 15:53:58 +0100
Message-ID: <20250223145407.259924-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223145407.259924-1-r.peniaev@gmail.com>
References: <20250223145407.259924-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This change introduces parsing of the 'ESC ( <ch>' sequence, which is
supposed to change character set [1]. In the QEMU case, the
introduced parsing logic does not actually change the character set, but
simply parses the sequence and does not let output of a tool to be
corrupted with leftovers: `top` sends 'ESC ( B', so if character
sequence is not parsed correctly, chracter 'B' appears in the output:

  Btop - 11:08:42 up 5 min,  1 user,  load average: 0BB
  Tasks:B 158 Btotal,B  1 Brunning,B 157 Bsleeping,B   0 BsBB
  %Cpu(s):B  0.0 Bus,B  0.0 Bsy,B  0.0 Bni,B 99.8 Bid,B  0.2 BB
  MiB Mem :B   7955.6 Btotal,B   7778.6 Bfree,B     79.6 BB
  MiB Swap:B      0.0 Btotal,B      0.0 Bfree,B      0.0 BB

      PID USER      PR  NI    VIRT    RES    SHR S B
  B    735 root      20   0    9328   3540   3152 R B
  B      1 root      20   0   20084  10904   8404 S B
  B      2 root      20   0       0      0      0 S B

[1] https://vt100.net/docs/vt100-ug/chapter3.html#SCS

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/console-vc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index fe20579832a5..90ff0ffda8c5 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -42,6 +42,8 @@ enum TTYState {
     TTY_STATE_NORM,
     TTY_STATE_ESC,
     TTY_STATE_CSI,
+    TTY_STATE_G0,
+    TTY_STATE_G1,
 };
 
 typedef struct QemuTextConsole {
@@ -694,6 +696,10 @@ static void vc_putchar(VCChardev *vc, int ch)
                 vc->esc_params[i] = 0;
             vc->nb_esc_params = 0;
             vc->state = TTY_STATE_CSI;
+        } else if (ch == '(') {
+            vc->state = TTY_STATE_G0;
+        } else if (ch == ')') {
+            vc->state = TTY_STATE_G1;
         } else {
             vc->state = TTY_STATE_NORM;
         }
@@ -844,6 +850,16 @@ static void vc_putchar(VCChardev *vc, int ch)
             }
             break;
         }
+        break;
+    case TTY_STATE_G0: /* set character sets */
+    case TTY_STATE_G1: /* set character sets */
+        switch (ch) {
+        case 'B':
+            /* Latin-1 map */
+            break;
+        }
+        vc->state = TTY_STATE_NORM;
+        break;
     }
 }
 
-- 
2.43.0


