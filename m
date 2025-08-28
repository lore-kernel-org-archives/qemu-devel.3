Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4D7C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgDv-00059F-4H; Thu, 28 Aug 2025 13:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXr-0001Iu-8T
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:16:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbXp-0000Mb-Dp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:15:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-244580523a0so8879095ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383355; x=1756988155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2UyNXYokJ6TnLyjAm0R/ws5bbTquqkinE1D7/JLlk4=;
 b=uWbov3XRzJ9G61Ekh8in2u0cAyUFh+nCqo6heHRO/9xWBLxXhxv6VvYiJHy1vf+VdG
 kIkHqDdhSaYpt/TP43K0mRbjADSWubuJ5M52wi5g+RGqfSmzPn9/R8GYsqFF+cpyJRtu
 v91d1/MorBIGyVpzc9o+YamYdbqINKBy2WCCg++gDrhT7XJ9WhJHgDqwn4LJMxjbh1jS
 3wBBECXfxwyN8YiMa/pWY/1nVTZ9cOE++4luNE3KCsBeYQ3jIgCMcOhqZ6mkBnSdYoAd
 d+pbq/fZuvptwamnIxJnmdwv8K68xbmqkzeSJQNjPk7ARGA3Y0RGRzR/bqowPuoWJMXg
 z9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383355; x=1756988155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2UyNXYokJ6TnLyjAm0R/ws5bbTquqkinE1D7/JLlk4=;
 b=VO1CotL2vcR93AdPl2nDHqhOrHjMaSBKiEajqF9x1kBlojhl7pWLgfpmsnH3qbiYLF
 QtLx41GSCHO3uqsDJ05CvYYI5lB9OVwAkAHlWhBNHkX3SaSA/TG54m5kZ9WGuMsO8HlY
 hdzQPIjVTF4xnZ+PYGQGnpxG3JFl8wGbR+IRP7ADLehSvmGcft/gFxKRqtep3aE/4nNP
 4NKjj4P7r69XH2gA9PRQFB1uPY5Wm+Tm17ruWM8Q9NsvrDk1ijfrRXjn6HMaRdsRfMxj
 hwJWGNPfIk5LoU86VNk/gR/HpO0y3ydg+yUNPDkSLvwP3yS6ZvXF9s4gfJuwnNQLrplL
 +xRg==
X-Gm-Message-State: AOJu0YyuS0GA+y7XHpW4ylRHF+FuMp1r0FP0rbPWiO4fnt+H1MRvfAo7
 WUhDKoQoyDW6opvTXIXy/FPjpQQdvZUi/hcGJ6z7YabUStisCNkGz5yoJMV0OlEbXD2bsxDVkLz
 /Rlp1bFc=
X-Gm-Gg: ASbGncsQ0FaGGwdokJgkYYTG2I6RJTbLkWVERxgEnDaHDV1DOpX23vjEZv8zC555s1y
 5QwsQt2zG4Dhu5y2llGepFqjd2A57hph4NjCn/sMm5/mF39RuzinmkXrNcfqLiaKIaZC6Wp2nZz
 HK17HGAfKP48yQhYIU35A0eOzbWY20M6meO+kOXNpqUJ+NtDqHX0zTl81wZaTV4znXqdXsMxv+U
 C6zPSFPQ0LlU01sVnbWGQU5EOxU1EkTKF+cS/IaII7bUJjzo97svEVgydzrq3EfY/IknY5Noc+e
 DqOEBwzA9rn6bs91v0pIAHWoSaBEsGTIfYuzvymrtMRo0lJMvN/mRpr4ieqc+nGeg1WZVOXekOQ
 a6OXvWVKCVtqMNkqgUxj3VwBJfVhuT6rSy0VR
X-Google-Smtp-Source: AGHT+IEFuvdnFSu/MsqCdQTMmYp7ydIr8SBXfm48KdesngkDEBtqTpN/H8hgI48zNL/aM30rGGjPOA==
X-Received: by 2002:a17:903:1b48:b0:246:6113:f1a8 with SMTP id
 d9443c01a7336-2466113f4e7mr257577815ad.40.1756383355445; 
 Thu, 28 Aug 2025 05:15:55 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:15:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 79/87] linux-user: Move elf parameters to
 hexagon/target_elf.h
Date: Thu, 28 Aug 2025 22:08:28 +1000
Message-ID: <20250828120836.195358-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hexagon/target_elf.h | 3 +++
 linux-user/elfload.c            | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
index eccf207f6b..a9f6d77fc6 100644
--- a/linux-user/hexagon/target_elf.h
+++ b/linux-user/hexagon/target_elf.h
@@ -18,4 +18,7 @@
 #ifndef HEXAGON_TARGET_ELF_H
 #define HEXAGON_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_HEXAGON
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 804a819471..33c4214c95 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HEXAGON
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_HEXAGON
-
-#endif /* TARGET_HEXAGON */
-
 #ifndef ELF_MACHINE
 #define ELF_MACHINE ELF_ARCH
 #endif
-- 
2.43.0


