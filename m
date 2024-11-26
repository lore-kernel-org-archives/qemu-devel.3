Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0385AD3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7s-0003fV-Os; Tue, 26 Nov 2024 09:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7n-0003My-SH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw7m-0005J4-14
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:01:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43497839b80so23793205e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629664; x=1733234464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tardOrbKTYXoxRnABs7gTXmCmfB9GEPw0cdGe0ErewQ=;
 b=EcAGGetuA5u+FyCq6ph+9WYIzg3PcsxzXHxprvoO/AO9yCcBDY9tibY2LpAuy/7E76
 MZinY/Q5NJePHoY7Z4LZBJuFSGlu/oL6LbbAuALmxacUnZzbjzkRiUmP22LqWPQqkzrm
 ZZmx+shku9Ev3tewnJJCOxd7grdLRXpyG98rnCKmk9BhLmDL6RVgKQhrG2AOL/K/SQfb
 kVphWf8tONMkOiX1Qae8TqNPSPT/OeIZuj3xe/yI5ITk4hfcw9gU7Dl+imIrOj92wUxt
 dfYk86F+IqsdIPIj9rRRO6P4ZAcwS6BnZ6adaQIuwUAjKoTPOctPHD9Pco0r6qHd+9F+
 8f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629664; x=1733234464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tardOrbKTYXoxRnABs7gTXmCmfB9GEPw0cdGe0ErewQ=;
 b=ei4VZFEkr7FbhlIhnql983HZDJFzDltlkVh1g7NB5zLpsdFQq6sLPGMiXjxKZg0KhD
 bU/+oWYWC7zJF8oyCywUYFZ6gK2T5SXxo2eXkqM55hcrsRYLyyci2f5xPDG8Ay4WC2Mm
 BVM1SxjrebG3QReoOl/soroBlnUqxxYeXDUa1O1yfSp3fkS8HkBXsBA4pCyX9sBbtMj6
 DIXqRpd9Jn4x0Z09zRlGUQP3HInBUzjLbsdgqDQ/xy8Liyxbn716/EdPK2mFDZ74W0w1
 P3kUh0aBGdfr3LwxVGzmhfjhDEG9iOkmIASYrkvYu2GHOVZYBjuH5zstLEufs51JgepC
 9DEw==
X-Gm-Message-State: AOJu0YxkGVrHGoPcwyWgwc8gLwYUEvpWPMRx4ZGS/j2+mwkCncgPk3ki
 vrZqN+5/TtaJMl9/4iZTJj7F7ZHW3OU5KRhrta4PZwxxKQ7gLK68htsxUPgyQzntyQ1s6GMal1i
 R
X-Gm-Gg: ASbGncuR8a3oQ40qinYaQIiUgo8/dtXTu8nb6nLZo+KKWOWER3YeHHnIYJlmb+VW5hZ
 lPTR4q6n91RccwUXZKfRKuvmeyg8pnR0Uvk7USyijK11r7f8h3eHYUYXSeJqsDCrOxZ6wELkDNk
 kknaawYs9iHaiYdZ+OgES7qLWLGROGsgEsyOJptBcxhBMLU0JWZP3c2s539fT0m2itqh8Iu4YiY
 0h2kwR1PPLXzfJuuzAbJHeqUSErirmS6YtnNRFATWNpcNGjHakMXGY6q0UOPhk20egEMRb7
X-Google-Smtp-Source: AGHT+IEKpTpLGorfWPGdjBVdLylZK75l9mVp8elZDwaEcA+TS2DHsdl5qRAdr+EBzhnv+0CTsU9yyQ==
X-Received: by 2002:a05:600c:3509:b0:431:5187:28dd with SMTP id
 5b1f17b1804b1-433ce4d3e48mr121677815e9.28.1732629663782; 
 Tue, 26 Nov 2024 06:01:03 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d4dd6sm236632255e9.24.2024.11.26.06.01.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 09/16] scripts/decodetree: Add support for 48-bit
 instructions
Date: Tue, 26 Nov 2024 14:59:55 +0100
Message-ID: <20241126140003.74871-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Some nanoMIPS instructions are encoded using 48-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/decodetree.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index e8b72da3a97..88cd476d2d3 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1543,6 +1543,10 @@ def main():
                 insntype = 'uint64_t'
                 insnmask = 0xffffffffffffffff
                 bitop_width = 64
+            elif insnwidth == 48:
+                insntype = 'uint64_t'
+                insnmask = 0xffffffffffff
+                bitop_width = 64
             elif insnwidth != 32:
                 error(0, 'cannot handle insns of width', insnwidth)
         elif o == '--test-for-error':
-- 
2.45.2


