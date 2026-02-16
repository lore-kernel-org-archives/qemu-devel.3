Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE9BE83840
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7TR-0003ZE-4M; Mon, 16 Feb 2026 17:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TL-0003Na-8q
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TJ-0006gL-JQ
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48372efa020so25637845e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282418; x=1771887218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jB5by0knWSnD5A5J5m+cWeRbk2ACccSNC+pzW4uTeBM=;
 b=g5vHVB1FvMnb7kbtDnqQry4Ve0uUGyNLobkmOkcLro5OHrO/UCAfHlUDMrm2kWi3nI
 rKS4Lf3y1Pjd2MJbplihiF2XmNwLENvJhsbjP2zJLaZth+Q1sy9AJ62FFxVvlxrRZVf0
 nUpf9781IAhAOthyCX7PtfUEHgKii0Xw7mHTPr9YbzFBWUyrKdmV3J8SaMZbz79rN2WY
 42prnBTSAzuDfOMa7/TMAPnCOKGrf4N6g8LQgWeLuvJgBVaFVyW3YLdxKmevHU6JZkBw
 M3BjRcCJ38a5CviFzHCK9k8oZkXEiQXxcCBg+dQrowFNxNkII+0i6mPYtfjQFJj0MKD0
 wCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282418; x=1771887218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jB5by0knWSnD5A5J5m+cWeRbk2ACccSNC+pzW4uTeBM=;
 b=TfB1KckHXLWEOTc7YvlT+84iv4ZDhM6z+AFzZ9YIXVm0i0BwrJqnmhHccrCy0orQHp
 e7R8nq6BmTJwSDHj8Yw1O5JF4uHGksCqOioVXAcTzDTdkqXqKF1n1dnfMzUt0bRDbbCK
 6CsDXmFDDKVBu3iiTnBwn+VLdblrkGEuZ0xeOCDuiP7uKHIpvAilTXuz2ibzxX/DfPjt
 8f5ktbnTf0RSxdh5CCLsJ5qTEwQwj8tyyIKZeI9ia1DlCEycgARBGXfJsbLIwqJPYl4j
 LMlfZ3ISMxWcFtIiC8NRMCqUq+J0b08vvbTbGObFpv69f62lzpjZMDm8LHi7a3Uq+8K1
 /zlA==
X-Gm-Message-State: AOJu0YyXeWD2LvbqmQhYb568WfmKs518rYVyloXN2iY8Eh5ghxPrFxxD
 Grw1rJGa3QziwkUNQygJU+x5xOEGcA/ALKJ272Db7tRdwq4C68KYjdLCX12ZOHOHuKIOdR/dTx1
 eRNA04tA=
X-Gm-Gg: AZuq6aKjO3PcMGYoV33cHN58vWWfM7H30AFatw1NBEr9w75Kg87LG2e6w2hQZYiN7BA
 sfG7S92ImHz+0f5ImRAc3OJbC4ckPJXHP8Nm9V01MkK7IalOayyR6qEbIdP/gp/eLQw/VERLt0g
 BOIqz6sO2fftBREFzrvLRqFeweIj02f8NTbEqp2MC38QBApGycUTkoumRIq32rkU2wc33eJsPjA
 zWTf5wKgf/0G5gvUnS6OlCyKs9nqdpjQu5G1HL22wM7Vn0+W6EoLygVUC9LuFpPzu0/6wdRWNRB
 BPyU8ldcMdmrtRjvFYtjapDdEOPxprdOgv1qbiZWLcOmQFGD6lZ2NvSLFoaRSAi27RYN++ZSJUC
 9qEJf1tBBDa7ot+S/iEsXQP5eK+JHymTZtZP4C80UAaum9Rnc5gGIAYXzaRmdHdl/CCyAfdrJCA
 nJ6wMShiQF2urvHu/bAFI5mQ19fvuT2FhWYH7hwoy3HVXrq7+qhtA1+WbTi7l16J9mscsFYIqE
X-Received: by 2002:a05:600c:5491:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-48379bfd732mr153201565e9.20.1771282418402; 
 Mon, 16 Feb 2026 14:53:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a409a5sm91123625e9.26.2026.02.16.14.53.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 09/11] target/i386: Remove MonitorDef register entries
 available via gdbstub
Date: Mon, 16 Feb 2026 23:52:25 +0100
Message-ID: <20260216225228.53959-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/monitor.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 99b32cb7b0f..0660fcabc2f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -605,41 +605,6 @@ const MonitorDef monitor_defs[] = {
     { name, offsetof(CPUX86State, segs[seg].selector), NULL, MD_I32 },\
     { name ".base", offsetof(CPUX86State, segs[seg].base) },\
     { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_I32 },
-
-    { "eax", offsetof(CPUX86State, regs[0]) },
-    { "ecx", offsetof(CPUX86State, regs[1]) },
-    { "edx", offsetof(CPUX86State, regs[2]) },
-    { "ebx", offsetof(CPUX86State, regs[3]) },
-    { "esp|sp", offsetof(CPUX86State, regs[4]) },
-    { "ebp|fp", offsetof(CPUX86State, regs[5]) },
-    { "esi", offsetof(CPUX86State, regs[6]) },
-    { "edi", offsetof(CPUX86State, regs[7]) },
-#ifdef TARGET_X86_64
-    { "r8", offsetof(CPUX86State, regs[8]) },
-    { "r9", offsetof(CPUX86State, regs[9]) },
-    { "r10", offsetof(CPUX86State, regs[10]) },
-    { "r11", offsetof(CPUX86State, regs[11]) },
-    { "r12", offsetof(CPUX86State, regs[12]) },
-    { "r13", offsetof(CPUX86State, regs[13]) },
-    { "r14", offsetof(CPUX86State, regs[14]) },
-    { "r15", offsetof(CPUX86State, regs[15]) },
-    { "r16", offsetof(CPUX86State, regs[16]) },
-    { "r17", offsetof(CPUX86State, regs[17]) },
-    { "r18", offsetof(CPUX86State, regs[18]) },
-    { "r19", offsetof(CPUX86State, regs[19]) },
-    { "r20", offsetof(CPUX86State, regs[20]) },
-    { "r21", offsetof(CPUX86State, regs[21]) },
-    { "r22", offsetof(CPUX86State, regs[22]) },
-    { "r23", offsetof(CPUX86State, regs[23]) },
-    { "r24", offsetof(CPUX86State, regs[24]) },
-    { "r25", offsetof(CPUX86State, regs[25]) },
-    { "r26", offsetof(CPUX86State, regs[26]) },
-    { "r27", offsetof(CPUX86State, regs[27]) },
-    { "r28", offsetof(CPUX86State, regs[28]) },
-    { "r29", offsetof(CPUX86State, regs[29]) },
-    { "r30", offsetof(CPUX86State, regs[30]) },
-    { "r31", offsetof(CPUX86State, regs[31]) },
-#endif
     { "eflags", offsetof(CPUX86State, eflags) },
     { "eip", offsetof(CPUX86State, eip) },
     SEG("cs", R_CS)
-- 
2.52.0


