Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0490D358D6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV4h-0008T4-FC; Thu, 29 Jan 2026 11:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4d-0008NE-1x
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV4b-00059l-9u
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:50 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so843064f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704847; x=1770309647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbQjc8ZYqWORXyizHA7cHB2eAOXerMSR4t/7ALRc1wY=;
 b=swJR7z31Y9k8iHy7moermWFzaVrkxUf4Nlvds42E4b+JmWcUo0l7kpxTHfBoeFHLAm
 TA+qChGpEeY7gBf+mMRBT2cqYQ0Tbnv1JhlhIbBCC8jeYqc/1y9ose7wSYbNKHJDds2w
 DRn8vbsjovIFjsI7DqC9kL68IYUGm+4n4CKzb/ia0ujojLqbdgLNOtBFjtxX/PRi0GM9
 Ec4QqY+25M511rlp6G2lsn+Zbb0XiylO11z1PY0RCpgXsMQ1O1q3qXGezBmzPxfkKzT7
 P884+MVC6g8cwzi3/Q00WhRMNJ33tmdKBZ60myjKv2ZXQcWZ+RTs/u66OpHWw+pgflJ1
 sM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704847; x=1770309647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XbQjc8ZYqWORXyizHA7cHB2eAOXerMSR4t/7ALRc1wY=;
 b=vgCtcb0qDsdJziaYMFhVnoWKxUBcKP27KHkTl3jj7MeOVuS0Fs3+slfcK+VPjDYCnh
 MUJFN5Yh25n7KNFZAxXrMTSF4XJihcfvlfXLi2GgAXtC121F+s1OfdFAMAkESuF1wdcl
 /cV7mdeGEzNfVkRJwLi5sroCYgVrzXGlcSD1oi8ExaODd9+mxRWozE9Q/qYOlpkKfC4/
 oZUyQQicKHlB++sUZNUNlrrnfc8yww+MpmzOtj7r7f/vfIb0hU7anylc0bf5Up4sMN1b
 GCnv8+PRWQgPXAysfwGo6juWi+FE6ZLG+sObIUNs54DIMddOneeTWYKVCRl/KYkYH3rm
 YfZQ==
X-Gm-Message-State: AOJu0Ywi2CwBAgm8Y7yppb60num0tqV8TZTZbR0d6ExsMfeKrxUTxQSd
 g9mAJsYzZj8Jo4UaoaUwf3zOnqSDvdD83k//wajp4FU2h0iKa4sRaeH5DKadZrXxKlLoqBE6Qjo
 Yw36KTAE=
X-Gm-Gg: AZuq6aKPv39rla87ifAvW/U/FH81xayJtEpfqKT9RdcV9qQDUb3fy+J5J5PqSjpyYQa
 L4vSXOq6YSrKJU8Z8HGn8mKovwm3WHxFpRuRgOQrLE9oWNbv3XL0GelauadouNXNUJCFoTY/26G
 MkN0tDx/3diahOkKh6GkmGzY7IQ2RwNx59bzTf3BHhRi1XXIgGc/RndeqxIBZ807dalCu3AwIgf
 I69vZdqkQZA1fp2Ghe4LPEs647pNeDIEuUnV+MtJf1MvD5GGusLMleLAZfzLpPR2JHkiRqNqbXV
 NGdoKRYLEXmnf/2NxHTC6RuohKwXR3vYrcdMkQQf+5IIl24kfAmly2Rx3Ue1Psm3Wr6PgQn+EGO
 NcBFp1Ke5p0pZP1MRU8T80F7z5va6H5N+G715uehZPRqFtSibV0egzKbs788hSESFm74rvu6quT
 KeXPalWruHrX+fwzhsjpvquXK7z56AqiHqzdSXD9PA6tYAamrclbd91kVoigP2Wl7CFHeyGgQ=
X-Received: by 2002:a05:6000:1885:b0:431:53:1f49 with SMTP id
 ffacd0b85a97d-435f3aab0b0mr309463f8f.41.1769704847451; 
 Thu, 29 Jan 2026 08:40:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132303fsm15886456f8f.36.2026.01.29.08.40.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:40:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 1/9] target/i386: Include missing 'svm.h' header in 'sev.h'
Date: Thu, 29 Jan 2026 17:40:30 +0100
Message-ID: <20260129164039.58472-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"target/i386/sev.h" uses the vmcb_seg structure type, which
is defined in "target/i386/svm.h". Current builds succeed
because the files including "target/i386/sev.h" also include
"monitor/hmp-target.h", itself including "cpu.h" and finally
"target/i386/svm.h".

Include the latter, otherwise removing "cpu.h" from
"monitor/hmp-target.h" triggers:

  ../target/i386/sev.h:62:21: error: field has incomplete type 'struct vmcb_seg'
     62 |     struct vmcb_seg es;
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/sev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6b..4358df40e48 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -14,6 +14,8 @@
 #ifndef I386_SEV_H
 #define I386_SEV_H
 
+#include "target/i386/svm.h"
+
 #ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
-- 
2.52.0


