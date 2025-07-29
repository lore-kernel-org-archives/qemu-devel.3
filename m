Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61DBC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugua9-00016l-Po; Tue, 29 Jul 2025 20:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJT-000520-7B
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJQ-0004iD-Ro
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74b54cead6cso4142264b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833891; x=1754438691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1+P6kcom5eZVcs4b+LLYYeR5bzhVw4lKdm1pavD8/Ww=;
 b=WhT1E6w6kp2wZJaLwpmnLgJ0SKJdNbsm7xNo3eWNCtAAqpHxjxeEPy2yWapk1cNi0z
 r/OWZPp+YUk9TOwu7HN7kccswAJw8A0DQVHyDv6HN7khHQV3JI5M41J0tJnWfG/HA5le
 bNZ3wlfaDLZDElIq2SToP7JFRYzguck/netwKVZ34Gr1qEenpci+X527JrSQYlmu9ZCE
 xUibGaa7DbFtI1Y2vfanVFSdncBLQ8xEtv0twosRuYZ9PI06s4+eyJl6j7ojG5q907Iz
 xXnX887r6XkVIjYzKg7bSi2+RvY/tJGXZg+sF1nZNSUHCh9F0OpbaXBdtwNpLReyRkSY
 Ma0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833891; x=1754438691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+P6kcom5eZVcs4b+LLYYeR5bzhVw4lKdm1pavD8/Ww=;
 b=LEmTFQYwfIznlIqWF465ml+EVVU8vmFV3jh3f182XrnD0dzoIvfZDgdd1LyiRi10GF
 ubQF+5CjZK3v6hgcoVPwhK2hwuXX8qQiqmQLZug3Nvf+LG62/JtxSkYGwoOTyRETUdug
 2Ltq30C0Xl7XttugY4z6ZfdiuYBqwRYbA9R8+xYqriRukZWgbSCDC/+kJpkK1CxZFd2B
 3n3aY6hfTLwpKjub1U+PNkB/JYSl1pMXlM4qOANbk2FbRU8I277VU3XDLMSHU7ZIpSM5
 yozsNL3dQDHZvLg6su8lO92k6K1N9HNrgJvi9gOzeGyw5CZWxFiDihRGnT7CGxktjEcS
 MRyA==
X-Gm-Message-State: AOJu0Yynec1k3ofYZjh2tVlhjK7QRLLMaCHCC/J3z1wIEAeAfL2q2YIO
 gSOo+rlUZQpFS9shGlXS6AhKxBuu36y6/Mk/vKopykFcJvoKxYESrM3Uv7rZsR6gDT2/vTGV1Ra
 uNTeK
X-Gm-Gg: ASbGncudOxyxNIE0jqA78lEr9E0U/bdlg/BSDQh5y7XtI3h7kaCUR2wU+xYvTjzBEfO
 +B+xohQ//RuQdVpqY3KvXlyTzVEKjpTe27kr1wFZiwDV6w0PlCUr3eiptz9w7h9qIo0DJC1ahjC
 H1h0VWm2OjNy8zaoKlQ0PI346RXyNJUpu/aiw/r0chLX8lBdfGxnKhJOYm0hygBrgppmZk5klQy
 LOGxTyk2GtEPovcr2hGqj5oA42Hf7wUV84f45Bx5wzbKfitqtF7bL6b0UUqGNbKZsGuaP6vizyw
 ixKmFO1oZYlnc2Z0HSc/wZK3+pSA9xHzltnifD8Ivk5zuZ0rjx1FOsdb35UcXbMtjQ731mOTZl6
 /mqa2ydNSr6mDkgZjW7aDmAKJnMI0uKAWwaqBnGHOKvp+xMvvCvA9VyHgkgmSQpwiTGY74oT3eC
 Ym8ti9UzSchw==
X-Google-Smtp-Source: AGHT+IH1AQFW8LikGQ8I7UKsfMJJK33lFQ8jSphVSt5qCnGWon06cjLP6pI87Q0kTqqJos0L6PbWjg==
X-Received: by 2002:a05:6a00:2e17:b0:736:51ab:7aed with SMTP id
 d2e1a72fcca58-76ab2e55d58mr1847586b3a.16.1753833890959; 
 Tue, 29 Jul 2025 17:04:50 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 74/89] linux-user: Move elf parameters to s390x/target_elf.h
Date: Tue, 29 Jul 2025 13:59:47 -1000
Message-ID: <20250730000003.599084-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/s390x/target_elf.h |  6 ++++++
 linux-user/elfload.c          | 12 ------------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
index e51b053339..aa12ecf36b 100644
--- a/linux-user/s390x/target_elf.h
+++ b/linux-user/s390x/target_elf.h
@@ -8,4 +8,10 @@
 #ifndef S390X_TARGET_ELF_H
 #define S390X_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_DATA                ELFDATA2MSB
+#define ELF_ARCH                EM_S390
+#define VDSO_HEADER             "vdso.c.inc"
+#define USE_ELF_CORE_DUMP
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4294a6582e..28407a7a00 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,18 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_S390X
-
-#define ELF_CLASS	ELFCLASS64
-#define ELF_DATA	ELFDATA2MSB
-#define ELF_ARCH	EM_S390
-
-#define USE_ELF_CORE_DUMP
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_S390X */
-
 #ifdef TARGET_RISCV
 
 #define ELF_ARCH  EM_RISCV
-- 
2.43.0


