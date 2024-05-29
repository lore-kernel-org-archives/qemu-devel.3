Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB58C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNDz-0001eG-NY; Wed, 29 May 2024 13:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNDy-0001e0-3B
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:36:30 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNDw-0001dT-HZ
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:36:29 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-681907af6a8so1879623a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717004187; x=1717608987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=I/+lHjJMmybcT4W+784daRuxyy90MIVVzPTYXumJvT4=;
 b=vPrdVxp40kBr5qqN+yiY+CeWr0a6AvbPLDiZkxHcuNyAENT1+uz6/ySUrEKkU7itDt
 A14XeSV85EwfEVVCjHdLxvaFuRQNDUbHB7TkLUgnL/dVCXSOzOUY6Za8fQ/7uovix1Mv
 rFw7oQKdOR/nLg6MjMxm2zWOpuTIEeS9qAKP+tpM1wg9bq85peMR8xlRFlnmuYJJj7/+
 BlkDEj65VlnIgqWTXViPxKQ+ix6L3FVlGIm0SqEKdEX+JJghOjaPzGpn8pMqtNPC0wQ9
 Njd6fDpX0ZVn6hGb+XO6xUWj4U2NG2acRWfdfgAvf+DWr1AN0RJj/eh/KgNQqu7sDxRV
 4c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717004187; x=1717608987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/+lHjJMmybcT4W+784daRuxyy90MIVVzPTYXumJvT4=;
 b=LKUAeW7iUmWAcAx6zzABubNe9UZv+/bbOQ0vn7XA4NaMCeh/k1uXk0K86y9zaDnH7s
 E+iaaWaNumHRDzy5nrPOXxHDLFO+Kyj2t9uHmdJhnNMEiWL+jxdR3Wq8cWhpl45MxUwm
 VRPGPLFc5z68bP8R9JnsUVvS+WckqO+Vt8ROII3LnMnwC77I/GGOfIWQ0uhW0skEJ45R
 N4EAt+jzmE4NPlkAffZhyyW2E9yMSLxyG2n/DvPqkDHNNTbOTw5nnhTxbeVV0zwf/Ge9
 1/GDtgbq4Nkp/eAA6pSf7BGH+iaB0UB/RyI7ZGR43zXQKuEsQBbttoUQflX25hlBh1s/
 DUew==
X-Gm-Message-State: AOJu0YyEOxxIXKh8MPf8AYklP1zh8FY42gGKzw49yvWBT6dTr9FJRSGc
 ImImf8Z6EiUnbhIO8GjoI3/KPtG7LCS1NRKvbESy49J+Kwbf4fASR8t5/l/Jw4Lh0DD+htw9tsA
 6
X-Google-Smtp-Source: AGHT+IG2j3gWmRqc3HpvFrzJzHRcptX93sEfRlMT4tCrKkxirTfWzZmfINxheTAX2yskbOmSTLGEgQ==
X-Received: by 2002:a17:902:ce84:b0:1f4:aa72:1c7 with SMTP id
 d9443c01a7336-1f4aa72038fmr100468815ad.26.1717004186838; 
 Wed, 29 May 2024 10:36:26 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c967cd2sm101704155ad.166.2024.05.29.10.36.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 10:36:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH RISU] risugen/arm: Refine prefetch and memory hintspace
 patterns
Date: Wed, 29 May 2024 10:36:25 -0700
Message-Id: <20240529173625.800102-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Avoid prefetch patterns that are UNPREDICTABLE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 thumb.risu | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/thumb.risu b/thumb.risu
index 357b791..6a05bf2 100644
--- a/thumb.risu
+++ b/thumb.risu
@@ -33,7 +33,20 @@ SMMUL T1 11111 0110 101 rn:4 1111 rd:4 000 r rm:4
 # preload and memory hint space (in the byte and halfword
 # load space, where Rt == 15).
 # The constraint is to avoid UNPREDICTABLE space
-HINTSPACE T1 111 1100 op1:2 0 z 1 y:4 1111 op2:6 any:6 { ($y == 15) || (($op1 & 1) != 0) || !((($op2 & 0x24) == 0x24) || (($op2 & 0x3c) == 0x38)) ; }
+PLD_pi        TI 1111 1000 10 w 1 rn:4 1111 imm:12            { $rn != 0xf; }
+PLD_ni        TI 1111 1000 00 w 1 rn:4 1111 1100 imm:8        { $rn != 0xf; }
+PLD_li        TI 1111 1000 u 00 1 1111 1111 imm:12
+PLD_rr        TI 1111 1000 00 w 1 rn:4 1111 000000 imm:2 rm:4 \
+              { $rn != 0xf && $rm != 0xf; }
+PLI_pi        TI 1111 1001 1 00 1 rn:4 1111 imm:12            { $rn != 0xf; }
+PLI_ni        TI 1111 1001 0 00 1 rn:4 1111 1100 imm:8        { $rn != 0xf; }
+PLI_li        TI 1111 1001 u 00 1 1111 1111 imm:12
+PLI_rr        TI 1111 1001 0 00 1 rn:4 1111 000000 imm:2 rm:4 \
+              { $rn != 0xf && $rm != 0xf; }
+HINTSPACE_rr  T1 1111 1001 0011 rn:4 1111 000000 imm:2 rm:4   { $rn != 0xf; }
+HINTSPACE_ni  T1 1111 1001 0011 rn:4 1111 1100 imm:8          { $rn != 0xf; }
+HINTSPACE_pi  T1 1111 1001 1011 rn:4 1111 imm:12              { $rn != 0xf; }
+HINTSPACE_li  T1 1111 1001 u 011 1111 1111 imm:12
 
 # VMLAL, VMLSL, VQDMLAL, VQDMLSL, VMULL, VQDMULL
 # NB that enc T1 is actually VMLA/VMLS only, T2 is VMLAL/VMLSL only
-- 
2.34.1


