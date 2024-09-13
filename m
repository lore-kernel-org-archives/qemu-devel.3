Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9219FFA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp807-0001wL-Eg; Fri, 13 Sep 2024 11:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp803-0001gC-WA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp801-0007lX-GZ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso19964585e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240456; x=1726845256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g85Nw8e2tTDyn0qB7KAq1h44RJ0NB7pCYIPMzzFh5bY=;
 b=YcSGCXB2qqeIWFb5yCexYVDFfnfOne6AFMb2MGq4WiMnxI04JF8JoGADz1KeP2/Oia
 lfwrgfE1dEoUl9PTolojBs1BybEbwrPmOp0iYVwK3EfRmTL9AuOK1bmJKKYwSgDKBFOv
 mbaGuhwxgzBaq/uU6rJz+wmaqbYnStCS6py0n03yPrMIj/WZZUdlynvbwlq0euJL6fhu
 m06WCpvx4IWFBaamFnlie3tc/4SdpNucKgKj1mExAb82jy2L35acPH1/kDLKMogUDqQW
 NG/DlSvL8k+ErtPtPoYwmznTFQ46vAWtpf8WPneksyuXQTU56SnN92N26Bg+fR0jUPtj
 yz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240456; x=1726845256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g85Nw8e2tTDyn0qB7KAq1h44RJ0NB7pCYIPMzzFh5bY=;
 b=VQiFc28wUSFjl1KKjqoUUh96PRIfKPPIOYViasNxk/KjYtSTNFhOIuCP2hMCJ9Y5Zm
 XxEsTDhhNsu1kUbP4biSqsP4tdam1JrblW3Rm5F9RMYHX/u1U7IkszN6QGBrO1RaxJDu
 6L+LG4ouFp8GFvpAJ+L4ZCophejak82FFkmmwG+UeTnPjXNMAFjhxBuWRA+bk6/63ym4
 sG48ZVePvkWYHDRVhYd7V66HRMTAhXgwUwERIJqsvmc140UZFoCydC7vRJRbsMMTRrxB
 6HulKrjBtybRo+ALsmGWrO5NkSaa2QBkUh413edh3kDW9co2sS7agqkBTq1h2TI3WXAf
 PMBQ==
X-Gm-Message-State: AOJu0YwVVA39Wn568Ki+d8/F4RppbCqnyTf79hS2xj+RNn+vrYfSoKUv
 wV9iRAEhUjyZfu8MHJgoTNJPbvn0RPFgjeoDByLG8iA/y99M6XcyDxRuOPbXpR6nBszWBW3EJMJ
 n
X-Google-Smtp-Source: AGHT+IG2He7/xjI3q3Kwvg0xTy2Alek7HVv28kSdQtfABWGvxI6w9o9ZZKRVj6rpMSiJ9cC+LTPydQ==
X-Received: by 2002:a05:600c:297:b0:42c:afea:2a10 with SMTP id
 5b1f17b1804b1-42cdb54d5e8mr55524545e9.21.1726240455406; 
 Fri, 13 Sep 2024 08:14:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/27] target/alpha, hppa: Remove unused parent_reset fields
Date: Fri, 13 Sep 2024 16:13:49 +0100
Message-Id: <20240913151411.2167922-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The Alpha and HPPA CPU class structs include a 'parent_reset'
field which is never used; delete them.

(These targets don't seem to implement reset at all; if they did they
should do it using the three-phase reset mechanism, which uses a
'ResettablePhases parent_phases' field instead of the old
'DeviceReset parent_reset' field.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240830145812.1967042-6-peter.maydell@linaro.org
---
 target/alpha/cpu.h | 2 --
 target/hppa/cpu.h  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index f9e2ecb90ab..3556d3227f8 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -267,7 +267,6 @@ struct ArchCPU {
 /**
  * AlphaCPUClass:
  * @parent_realize: The parent class' realize handler.
- * @parent_reset: The parent class' reset handler.
  *
  * An Alpha CPU model.
  */
@@ -275,7 +274,6 @@ struct AlphaCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 43074d80bfa..f4e051f1767 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -281,7 +281,6 @@ struct ArchCPU {
 /**
  * HPPACPUClass:
  * @parent_realize: The parent class' realize handler.
- * @parent_reset: The parent class' reset handler.
  *
  * An HPPA CPU model.
  */
@@ -289,7 +288,6 @@ struct HPPACPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
 };
 
 #include "exec/cpu-all.h"
-- 
2.34.1


