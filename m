Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24679C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhY8-0000zF-DT; Fri, 22 Mar 2024 12:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXy-0000tM-UM
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:15:14 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhXr-0000p3-52
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:15:08 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d4886a1cb4so31544701fa.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124095; x=1711728895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWERvWbaYA8U7fTdf/uiT9QJ6qMAGAYtIIOsHDWn7CE=;
 b=qR+dr51WAAf3QVHR9pEZEy0YpdMSuSJrCgtAkckqiQyWkWM0r0rzcb0cKx4h+Bc+xC
 4rY2Bp9E3Fo9P3uPy1Otkvzy9f12C0yW11NsCWsAeeI7KjzWMBxkrBxN6mE5bAxFr2nO
 moFWmfWBlE+0ztkLYVZIHn2524MmJZc5KPbqnKVSoCnACeERHi7VBt8aPTS0/dK39/4R
 lVePo5s0VVW2iNVxfZGKvLhIUmJw5C836EvhC9EmXG3a1/SdgLX2FbyDwqKgHJKNaTjk
 KhaCTT0rnKy8ed8V2sxzf2GXLyDe0fo7awWD6ZWiAXKpOy43hROFw0LqMZFU7pRamjP9
 Ozog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124095; x=1711728895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWERvWbaYA8U7fTdf/uiT9QJ6qMAGAYtIIOsHDWn7CE=;
 b=iR+369vZIo9eOUw2pKbcQHmz8cmSSe+kywngBX9EnSUW7pR0Av2DjDVgzxhXYafLLw
 l8bpMVgcqZuGBe4ZHu0tKwk5PAae/1CvBRJwzgX6mYBova5uXmZdxJnS5tDRSZlEmg//
 6oLK+qGt2EZStMyphxN9/2qfqN6lBrl/ShwsRPPKqLLUA5Co1pB8X1fTt0Fk3q/L+Gcr
 oAKCiOksJ3H3DQAIYbWofCnbsT1uuTld4+4KGLxnpEV30MlHvS+yEPhNehapvKJhQLO9
 THEXfLtqiEcSqrdro1P4Emds4sglaaxaEPFGdMra3hqP6W9Ure+bFI78NDje70JZ9QrF
 lYGw==
X-Gm-Message-State: AOJu0YwaFTpNKNkCVE6hcYUCDui2D7I6jPs9NXKZUwkv9pKD8OmMKutr
 60kr7Y3ZSdkq7XjdnaeMvdzi2raZWQR5Mtypw/e3UcpsNBqDeyav6Om1pysas0csXPxqsVhHVof
 6
X-Google-Smtp-Source: AGHT+IGFKaVbKf31VATWjTGdq0ZObqLxjTDJ8xODl4fNGzZ922tI8v36pANqcGwSv9NcRuux+xfNmw==
X-Received: by 2002:a2e:97c7:0:b0:2d4:25df:b8eb with SMTP id
 m7-20020a2e97c7000000b002d425dfb8ebmr2410707ljj.41.1711124095391; 
 Fri, 22 Mar 2024 09:14:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 he11-20020a05600c540b00b004147cfe50e2sm1824710wmb.2.2024.03.22.09.14.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 09:14:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 v2 2/3] hw/core: Remove check on NEED_CPU_H in
 tcg-cpu-ops.h
Date: Fri, 22 Mar 2024 17:14:38 +0100
Message-ID: <20240322161439.6448-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240322161439.6448-1-philmd@linaro.org>
References: <20240322161439.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit fd3f7d24d4 ("include/hw/core: Remove i386 conditional
on fake_user_interrupt") remove the need to check on NEED_CPU_H.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index bf8ff8e3ee..dc1f16a977 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -49,7 +49,6 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
-#ifdef NEED_CPU_H
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
@@ -174,8 +173,6 @@ struct TCGCPUOps {
      */
     bool (*need_replay_interrupt)(int interrupt_request);
 #endif /* !CONFIG_USER_ONLY */
-#endif /* NEED_CPU_H */
-
 };
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.41.0


