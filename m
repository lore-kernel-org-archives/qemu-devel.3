Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F69E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwK-0001H9-Do; Sun, 15 Dec 2024 14:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwD-0001Fo-Q1
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:58 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwB-00010R-1B
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:56 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eba0f09c3aso971207b6e.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289554; x=1734894354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7vC3VBtjcoNOh8750/uU7guz65QUQ+vUNGoylWHOnw=;
 b=NhQR/n6oUg20DqgXV8swsk0xz02mc54rj4hDHGb/baRAfX2hZyTtNJse4bPWkJAOyU
 BG6SeItL7rttXS3NZa0HamCKXOwg2FAporpJKQJT/ldZpbkaBSi81EJzAWDxmLqJToHe
 +fi8vkbg2nMhb8wU/+iyh+oXk9kBet1dVzuowv9c+K5sfSItIYAe3eCslWxe4jnXamcD
 zQnLoSsvMBx3nWY8AZF3jHvS9QaNlx8JB1QO6VI1O0sTrrjBOu1rC6kdbeYgZXa6PQfN
 QU+oSqXi+/ulD/p5AQmMqbjhprOKaot7kkX+3zTfvHuiGBUPE5O4mmSQCfqAdoSE3Mbe
 XKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289554; x=1734894354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7vC3VBtjcoNOh8750/uU7guz65QUQ+vUNGoylWHOnw=;
 b=Oomp9+rvzhPazL5/YJjzbsCOkd2CjIFI8p8X4+TRrhRpUuSB6nDejbVxhVaPXM78qW
 yZU7Tb9T2sk0TJFiLQ/5T8f5Q4M5BbpOiDY+Qc5e3IUbuHTa2g9uhiaqjT5EaTUqc4Eh
 gj4qs3K/2Muun9TprrttR6+ioFRUVkk6fSXiaHy8TOAGO8c95T1ajw+GXQMxyQa0MDxn
 Mx+9wF/QIHYkdy4iVE8d4uoQimkygKZroJA7hicZS0UBIuDGwY3c+w3CenjkbR7/wmu+
 tKVxiut527RHnTY6ZG9erlOaRiKqgyZs9LIzx5jFr5GhhFb/Ul06gn3pgi/nURn7jpQC
 O2cQ==
X-Gm-Message-State: AOJu0YznUdnuxGIC/gJJeAkIcTLymvZevcGBhkPgjPReSGtFy7uiaZ+k
 sNmtKBAP9petkGKGoj4KgqKb+VUONfEkGqnel48WnRWrYlF35JHuWJkWEbAT5ec+cee1JejL7nY
 k14ZH5U3S
X-Gm-Gg: ASbGncvtqP/WnvaLhgfAavlqxrUprcX8ZHQNeFObPdjNRR4h5OFZzEa7dPzwlPV0n6B
 Qi0E4N0AJFCjlY9ItoJH2xYWnB4uTcycl8vl5Vjt2jLaXfBOiai65mkRR5Qdqc/uE/KrZYcmT3v
 QdsTEtGurgiOMoy4elhQ3cHM5a7pS390JE7facSFytjqxbMEkh0BY118N9jjL8dQ8NyzVFIVZH/
 1VJH98+aHWy8+AAdhMHEcTX59Dff3/pRiNiAeHIp4uRNY5ZHiDzVvVKn+/cvQrbURx4LtqYWL9M
 3l0iRjmpgrSGwSZwhN+LBRitYxEW6avQoBgRtjTHUEA=
X-Google-Smtp-Source: AGHT+IGXuu8Xi5AahyzYP+jdCm+vqg0lUhsPioOB1OMuLaMN5QfVSyTCyVWPd6tYCZ95Doq/bnHkWQ==
X-Received: by 2002:a05:6870:ecac:b0:29e:4a6c:4010 with SMTP id
 586e51a60fabf-2a3ac4ab788mr5111341fac.6.1734289553983; 
 Sun, 15 Dec 2024 11:05:53 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/67] cpu-target: Constify all Property
Date: Sun, 15 Dec 2024 13:04:36 -0600
Message-ID: <20241215190533.3222854-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 cpu-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpu-target.c b/cpu-target.c
index 499facf774..2ae07a779e 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -183,7 +183,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
  * This can't go in hw/core/cpu.c because that file is compiled only
  * once for both user-mode and system builds.
  */
-static Property cpu_common_props[] = {
+static const Property cpu_common_props[] = {
 #ifdef CONFIG_USER_ONLY
     /*
      * Create a property for the user-only object, so users can
-- 
2.43.0


