Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD5EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfj6-00053L-Eu; Fri, 20 Dec 2024 11:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfit-0004f9-25
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:31 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfir-0008Hb-4f
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:19:30 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862df95f92so1112890f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711567; x=1735316367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JVMpa0JyIgG8zlFJaKcpemTbYAOLG8UJqwmC/m7oP4=;
 b=EaRv9uWLEnwQDSWQoUXzdUIVXontJtShmivPIYiXINJpRBOoWATaCdqkgP0H0MYpNr
 SzSkWTO/CMlzN6EA3Ff5cTza9FY9gwkkPHGX2FoT9uRydV4MZSo7Q7Ejy8QwvbV3Fnft
 +surij2C2GUr63sd9AK5lz3XRRapyE5V53TpuIi+GfZUoReA7W9aI3WClurk6YcJovw/
 ISlwvdQi5dSl+E7Hs3aLeGx+SyPVLvmvqMKD2rXf6POix026YvNMIXH7YqAEeytSuObj
 9PzzJaG5BWWHsRsi+BG8FcoGrlXOOwkaAXDCRU/H5/ngPK3P7hIyICmfw1wQ1kGoCrv6
 NFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711567; x=1735316367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JVMpa0JyIgG8zlFJaKcpemTbYAOLG8UJqwmC/m7oP4=;
 b=WLm9e8p01S9G+8sJaPUTHypSi53wUcX0QgTSdlqSZzz6Sb3bWxnT2YpGnstLKH3/Lh
 FiSL3/alfrd4hNWxeiIFFjHkjvM7m+po3HiZW6hutxfg86uYjeiPO70gQkcl+A3KtXq1
 S7b98iYvaSss0S0DIXe3Cv3EqonPPNnw/J7NZUtPPpF799JXUE0nL+LDVDwuKOKmU+EA
 7tKyS3ykIRDEpGumOOYBtPhArMeuDzYuDyxz9ICJUC2sd6OckA9pQOb3BJ/Xcny6lJSI
 09o6fbeMjN52hjH72PcagbcmimY4lGbQohBZwSZaifBNu9kw7IbcQrgCW7dYlHzd+ajc
 Kkuw==
X-Gm-Message-State: AOJu0YzhEjdxpBaOuZncVM9s1+G4CMfHaTKdH3s5XsAKerWYPit0EcmM
 1IzN1wJHV2PAX8Q+pmMIbxCwrbYZ58Iwbu8n3K2MqplOtG3s2zcsNnges27JwYZcpQdVyEznEGA
 Q
X-Gm-Gg: ASbGncuEhPsQyMWCoxYvK+O8YaBMgonMKqaTkggMfOataba6RgSamDdvWvT4TrlTASt
 BqV2PM1fJi+y4mCGNk/CysgMOpRvXXUGmumJL/YzW1N07+IJlXczWIz20lcak1dzg9BWHqOm09N
 ikDb4cLPd0HyjouKgFQf+qL7XQ2IeLCJhvlURGluxHzcB9OL8m7Vftf2SkZx+A+Fv7nMAuYlATF
 IxKLX2/jDeDmOQ2Wx4gLGBAXpugZfA6E8uN+DNpzwFe9mwaxTnmAFH3rjgjJhDowYlsaxnJXcM=
X-Google-Smtp-Source: AGHT+IG9G0U4sbVsXrHchXSytfTIqHkfX/6f7DaVCBVLGfmjVWAqTPpaspsbHgtA6l2MMy5SwU9E0w==
X-Received: by 2002:a5d:648d:0:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-38a221eaf55mr4071043f8f.21.1734711567493; 
 Fri, 20 Dec 2024 08:19:27 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c829297sm4530599f8f.4.2024.12.20.08.19.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:19:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 47/59] qemu/coroutine: Include missing 'qemu/atomic.h' header
Date: Fri, 20 Dec 2024 17:15:38 +0100
Message-ID: <20241220161551.89317-48-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Commit 944f3d5dd21 ("coroutine: Add qemu_co_mutex_assert_locked")
added an inline method which uses qatomic_read(), itself declared
in "qemu/atomic.h". Explicitly include it now to avoid issue when
refactoring unrelated headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20241217141326.98947-3-philmd@linaro.org>
---
 include/qemu/coroutine.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index ff3084538b8..e545bbf620f 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -16,6 +16,7 @@
 #define QEMU_COROUTINE_H
 
 #include "qemu/coroutine-core.h"
+#include "qemu/atomic.h"
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 
-- 
2.47.1


