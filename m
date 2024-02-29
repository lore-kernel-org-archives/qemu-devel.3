Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E525C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfh38-0004cR-16; Thu, 29 Feb 2024 09:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfh36-0004YT-9w
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:06:12 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfh31-0008IQ-RN
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:06:12 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e17fc5aceso25443f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709215566; x=1709820366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WoVosFwQaEZl4XUftl7Ubl1ydaYzG5CY3CcyjZ9HpZc=;
 b=MxMDL354baHkdQadGlQoNrlbOQPPTSgatQcljW0vgZzQfCRcAApMVkJzgyaQwuPAim
 ddAVTFqEhihiUBBf746NrZ81/NKrDH8QwTwsEicsPULvkWxc95fc+ZQlbVV136UZFz8i
 ARHe1mpKH93VB0IXvTJ0jD6ryQv2oUJi5ENY8adG1WxhHOdF2U+esTHAYLF6f9Q9ShTz
 Mi26tEBNcGUamTS6HbUzKBAT0QmhfMowB/yF5RfG9z3dWoQdEnqfsBJH3xCd2nk6Out1
 Ek3EPpCdMxKJWQaVDUEbw67cV1NSjFBt4qiq0dDGj2WWFa/ccnPkkfBFnmZnsvDRUtTx
 rYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709215566; x=1709820366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WoVosFwQaEZl4XUftl7Ubl1ydaYzG5CY3CcyjZ9HpZc=;
 b=Iv9xPNVYMYDj/m23GgfdBzByjIxJG+fpGmed1LwPtHy6E+X7Oi2L+mC4zmxMVFmKzu
 ufX3xPJWVHYkOoAvswA7BbYfdyCnUHlqML9VNyYOzFLTYAMNOlghcQcck3vjWIqCZsuf
 XuwOUhk6nZx4FBOO34lOFWX7R08xArFMROkcZMsdYaLo6BK7rW2o2rw7ghdrivJmMTK3
 aTEXIVuKqdsSSxYnmV4r6x36gc69GVm81KPLAc5dVLqrXAN6TT4ShWyHDq0GzaqLp9Mg
 c3APZoHoDxAnj3XvKpZr1ghByKnIqBrUHRzKtJukpScdSrJ6DXPc1A/8xxrGHvS2KL7t
 /jww==
X-Gm-Message-State: AOJu0Yxx9jc8tzPwTBocn1RvNZPRk2BRfOcl2thZhqZMiMN6cnLvlOsp
 nRmLLBWZ/IH9Vp9E+bxEqKAVhxkbGI/MdF3ALwcav0Tg2uiOuQRSTpTqes9DwuY=
X-Google-Smtp-Source: AGHT+IFZXOE9SBgIHCjzLNQocNr9OPNow0+Y6bXwKzYr9r3ZqaVe4XSnI4+N6oUGxd/UdgvXgl0Seg==
X-Received: by 2002:adf:f643:0:b0:33d:3c0c:ad53 with SMTP id
 x3-20020adff643000000b0033d3c0cad53mr2131719wrp.30.1709215566032; 
 Thu, 29 Feb 2024 06:06:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bt6-20020a056000080600b0033db9383e70sm1950286wrb.81.2024.02.29.06.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:06:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A2F05F875;
 Thu, 29 Feb 2024 14:06:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH] disas/hppa: drop raw opcode dump
Date: Thu, 29 Feb 2024 14:05:57 +0000
Message-Id: <20240229140557.1749767-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

The hppa disassembly is different from the others due to leading with
the raw opcode data. This confuses plugins looking for instruction
prefixes to match instructions. For plugins like execlog there is
another mechanism for getting the instruction byte data.

For the sake of consistently just present the instruction assembly
code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 disas/hppa.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index 22dce9b41bb..dd34cce211b 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1972,10 +1972,6 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 
   insn = bfd_getb32 (buffer);
 
-  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
-                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
-                (insn >>  8) & 0xff, insn & 0xff);
-
   for (i = 0; i < NUMOPCODES; ++i)
     {
       const struct pa_opcode *opcode = &pa_opcodes[i];
-- 
2.39.2


