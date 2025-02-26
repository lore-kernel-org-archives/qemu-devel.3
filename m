Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5ECC021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCKE-0007PH-JQ; Wed, 26 Feb 2025 02:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCKA-0007IJ-Vy
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:23 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCK8-0007g3-Vd
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:59:22 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1305276366b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740556759; x=1741161559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EISobMCtsGJwgBBoRUyUGsapTk7Zv2HzSGY51pLZdkY=;
 b=K5Dg4OvfqrvdOmvG2hbYK7yXIxN9LEUDWAVxjA+pLxk4z8+tXH9bkyQHm1qV5xL8t6
 raaD6rcLBAZBBmuNEK6WWxjOi1T/4o/qT+22KbdcpvxlDPS9VcuhkeJZH8Es0HYeEoSx
 GuHN1v4O4e/LITIZkxACKugVuWHoX3uM5rGqrXMYmdIpMZuJxfGt269mtbdtdLNUDCdd
 np0T5LM9jQAY8FexRxY2Uv7X1je73Uz13zxFcZ6qehXyNAQNgj4ZNjp3+LiVNTlhWy6/
 kqCUykYEJR4W2Ho4fUZqn+xmYfXjWGQPOt6nibWn4qMaI1zUQOT8r0/2vIPDXsuwvTnR
 15eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556759; x=1741161559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EISobMCtsGJwgBBoRUyUGsapTk7Zv2HzSGY51pLZdkY=;
 b=OQWswkJ0jKON6TyrhhPPyUnsefz4+mSDY37sXXv2o/xbcjRuII2PlCkxG5+qk6NuBm
 0HK4Nrx1ZdGuNwRD+03nG1+fheo6Stum9mf3W2/V2iCxq6ed/8MGgsKkp4wCbUJ8+6Dk
 ukOnyz0F+hIk4erwtzEDIPyQ7TUHxgWKvnWqtzNgM3H9yg3YU8CTSDhlJla+yeNDvcF3
 B1l07fIkUrnZQhqry5t88iKPXWxwVcTLvBHF74mSAK1Bk6xV48x7VhnHt18Se5n4eBSG
 dYqnY6yC67OOx+AAXocBT1mjoz9rg0d5oEnduMqY6oxByHMPUZwigCg1ewFXli1iqbG3
 F6oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdOuWsplHAo4gYWVbtMoXaGEmSqv3+iGBhVWYY4HJCB9jP8TPDIbPus6e56NHuCOSxMaaVPRWPqq0B@nongnu.org
X-Gm-Message-State: AOJu0YyZnyt9R+Bhj/b9kqpvmg6s6j38cCOmJv2g5Su2Dcux16SXKrkF
 cM4zqqlhuOQMLcHv5mHSXAJ9W1AyNX119IScfm7gXejAq5E0RmoW
X-Gm-Gg: ASbGnctU8z92Wv3NMIUUhymPdU/Z6coBDx0oYjTlkKLhFEwxYZxHizpToLctelE0e4p
 h58uKZDfW2nfZZn5glpGSNql42ASVk4FERqybMuvmt20B7Z4aPi9ncYKJjxlAqv2QUBs1rId22z
 daMmw5dwP3xDehXh1ZdSDPfrj3UDnz55AZCWgmXuZPyxyzIQq6g09oxzmWfxt/yrmUltFhdvDth
 WIuWhQs+C2qfjwrbq6Vry2NDzOT5K+26pgYVFtr/A21uUwHXCNcmzH0kezwzYuyGGFeR0iPr6fX
 70xVfDbK0srqrik9NAHZJZ+oUVbG2ZlT9gQ=
X-Google-Smtp-Source: AGHT+IHWUH++GE8qoFPI1YIgth4LbdXUIY7e/s3mqIulhuZtZcEt6D3YItDv9e5k4A7jfUTQVp9oXQ==
X-Received: by 2002:a17:907:7f90:b0:ab7:bc17:b3a4 with SMTP id
 a640c23a62f3a-abed0e098a3mr808370866b.34.1740556759090; 
 Tue, 25 Feb 2025 23:59:19 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:c48e:2efa:cdfc:e268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2013355sm280107866b.113.2025.02.25.23.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 23:59:18 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] ui/console-vc: introduce parsing of the 'ESC ( <ch>'
 sequence
Date: Wed, 26 Feb 2025 08:59:07 +0100
Message-ID: <20250226075913.353676-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226075913.353676-1-r.peniaev@gmail.com>
References: <20250226075913.353676-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62a.google.com
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


