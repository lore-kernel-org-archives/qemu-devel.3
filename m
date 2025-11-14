Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4662CDE032
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 08:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJpC0-0005H1-Fl; Fri, 14 Nov 2025 03:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vJpBy-0005Fl-7h
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:30:02 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vJpBw-0003Vw-PV
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:30:01 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-297f35be2ffso25963085ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 00:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763108999; x=1763713799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Eo5lMGMP26qKrgv6jGZObkpCj8ATVhZDB5hGLeZncZ0=;
 b=TtstIb/g1Y8X9QA0jYlbFYnaKJn5We2A1Fy5Uw24mooaLWKWYHnqDnjQE4GxmJlCpQ
 r/BSxVwqZyy8YOcClLmuRpZk+wguKqC449t5183r7AX2HiQS+T41d2Bufm1ZE2bOjnbc
 tPH1hBRJ0qVC6J6e465zEpUQV49ciFUaZ9JpqSzXJtswUyx8ESUf+QeG5lz8GwvRt6/q
 aivbRrf1lXzJeXWoHNUPF0ybuIh9n8XK3Wg/YoA246j6LszkUmB2or+fi8PBwbyzVRQR
 AGM88S2pXI/I2I0AcSY+FihJcMwcP4o8FgEJvtbT9snM/fUIFZMMhMYTpmx052/52lMF
 PKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763108999; x=1763713799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eo5lMGMP26qKrgv6jGZObkpCj8ATVhZDB5hGLeZncZ0=;
 b=cfZYDx7XKpR+YoeZs2bYG5suDjttXI7mwdbCysNxjQnS011wxwjIxfxcNRafwFnJJ7
 yoBW/tnYiMjG69Niswj+267Wp5cIaMG5NmVtXq0iipyhmnJS3Sp7n0LW9zwMU6p9+r/R
 74VA6d+xo4Kaub7R2aIOlj6B94uMHa5guDZluLQ6GuDfhqdmisuIsP3BG9shFupTiw2z
 5ZmoWhMbfIS0zqrOnpATOdTQM1qbKH49hPvoXIVdPZvYcugDy3st3TbTz1fPTYEzwJvF
 3pta6l46YOT2RoSkQF6Ff54QtEKETC8cfae6G+DXU8v0sy7LeQdjpxLHL+gJOqF4iyms
 F39w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqjEGDNc5VeuWxpyz2oIs8H3qc6WI9FEebgz9FvbrVO871bTJzOJ+m3/GCzQktabXZ6x5CDNKM3xkt@nongnu.org
X-Gm-Message-State: AOJu0YyljOqTOCQifqYUCGS1Gl16ZfiKa6Umn+wvnVtxx/906J+yKQCB
 /DK0UQMRhN0E9fz7EarCV+cZ7+PNAPWoVHzpXVBLBOBckDtdY+DqaG0FB0MI/AVa
X-Gm-Gg: ASbGnct0/J75cnX2yWs9981Exce6G+9tBiXlV1XN4D5a1cB3NH8wWRkmocvLtQmvczF
 4C3b9XFtmj3RHDHQTTKFRMewJXpAv6A/hO/wrBzjZmyIK/CwKY2PMJYIrQep60sfnroWiuaLZKi
 /PwVBvhC9hVMpj3DfC2tcwJfZ+sai38JkSxrwyYSkjq6UXbQ4McrKM2F7k8ZNVgJeszD7nz6hlo
 nANrENRhb62LEay4iTet+cWQFXe1qlgKt4aUAIdZgQEgtvHCBzdYgDzPPuMWdO0iI9glDsUMPyH
 AXyMVjHMeJPVkBJ+ty/B5z9FXpu1sQsA7n3pPyu6xjnqth/wNBESiZzMsTxXqVlQ1+hBlWV5+HN
 GmZHQyAQDSb4bDOdn4XdOMf0DAtIpO70rmkvrdiCxm6crcLYXB4n+Czy/bsilknGujg628UJdEu
 MV0cfeIQgUBjnhIjHQTQJjOP/pYa9T5uOvHfxEpFgs39WDU/JCTm9vcwJ1mRw3sm8=
X-Google-Smtp-Source: AGHT+IGEP42CoJ9cXexn0HURQwxwR/e34sDZcQtcwU11YmjFXD70zI2oPHMI0tPOLNigCCf9gNcjjw==
X-Received: by 2002:a17:903:94b:b0:297:e3c4:b2b0 with SMTP id
 d9443c01a7336-2986a76efc8mr25021855ad.54.1763108998981; 
 Fri, 14 Nov 2025 00:29:58 -0800 (PST)
Received: from C02G720XMD6P.sg.corp.seagroup.com ([122.11.166.8])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2985c24941csm48345625ad.41.2025.11.14.00.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 00:29:58 -0800 (PST)
From: phind.uet@gmail.com
To: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] Make sure fetch_instruction exist before calling it
Date: Fri, 14 Nov 2025 16:29:15 +0800
Message-ID: <20251114082915.71884-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Currently, this function is only available in MSHV. If a different accelerator
is used, and the code jumps to this section, a segfault will occur.
(I ran into this with HVF)

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 target/i386/emulate/x86_decode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 97bd6f1a3b..d037ed1142 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -77,7 +77,11 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         memcpy(&val, decode->stream->bytes + decode->len, size);
     } else {
         target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
-        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
+        if (emul_ops->fetch_instruction) {
+            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
+        } else {
+            emul_ops->read_mem(env_cpu(env), &val, va, size);
+        }
     }
     decode->len += size;
 
-- 
2.50.1 (Apple Git-155)


