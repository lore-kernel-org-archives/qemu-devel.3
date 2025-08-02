Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3608EC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPb-000763-Qg; Sat, 02 Aug 2025 19:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLPI-0006My-Vo
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:53 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLPH-0001wO-GT
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:52 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-615950642d9so928484eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176370; x=1754781170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SILBGhBUmTMCfemjzfu//plks4jMSfbHFV5+GJ2zWkI=;
 b=JdrQpuKMXLbgnQJSIa9M93ZjtbMGKiI3z53QVMk2v1lZNEfcoV2V3a2c+t8d8CXoJC
 2TzgVdEeRv/NPNZQ1i7AK/donSTdoiImOefBWNb/07BbovQRT5/ZWXFJjMNmYbl2SH3A
 PsP7n6txVuzNDPmpweRop0lWMh0B0JMF4/FTFR6cJ9It+jbmAwRoEpG9O+gswkoG4f5g
 dE8SzJeksJvd0Xlo3CdtPbnQ7CFZwQjX/gwcBdSTnzCl1LAhA1qBl2dyYvH5EUy3Po9T
 stajZEiK/nYMQa2I1GJca4i2dnDIaKAPIsXej2EzGJmd/MgoKU50y7aCXyLrDll8XGCO
 TyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176370; x=1754781170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SILBGhBUmTMCfemjzfu//plks4jMSfbHFV5+GJ2zWkI=;
 b=NttKeufZE1nJxdUKqlhQw2P5Tvz+6L2ph2k5QFEP3ERzILtVa8w5dOsutBOtCOwwW4
 c+xvJmhB0Qh7xaeTAsIjTS0tFm+VVVkFPpdy5A0XTomtylz/HYGJxnFSguME5a4HzHPM
 D0hvBgaFpWNntovjkC5x/2uhVHG6Ap2boV7MCgqHI/vKBtoP1JfsfSwgc/1lEYvV/HK4
 NXn7fvcPYvrxwGSMuFLvyun2Q849tqbqnNEqMRo64J+gADKiWT+FqdUeonNbZqp13xkL
 R2sgue6Y3SMBdYitkw+L97cntDfxuJgLsZfC5GXNY5Zkoc+Alro6I4VJB1dQSzIMxvc+
 EDcw==
X-Gm-Message-State: AOJu0YwsemiisN16MpWsQbWO+CIFItuAA7WnFkJJJ+gpDX3kOvlZS4mf
 tlBjDoaRhYJrfQI5WE1ySbFDrUPkdqEKcyvUyjORdaoTqnhXGMPadpS44JzGBNVRmpJVFa4v+Ia
 cF0HRgOw=
X-Gm-Gg: ASbGncuMCPojglmrBkostICOj2VspyTs4u3WxxHuwypWvq97/j88T3LiVBezYubVE78
 umg8HN1OGSsu3PHhbdH2+CdgbzSAHrlkRwcNLzSPxVWRWTDdr4aVOvF5bbQFkikvYSHiu4ILZxo
 yVyqO01X9LF4HcthZi6cBl+GFZnQiLvwStgev9Ervhl/NqckgBzwEedaKBxzYKc26NLXUBhcGbx
 tfHJIQoPQHnvOmOlgWBGBrKMKSEJ2JO4/wP+074mzDTt7ZzU1kCxXiXEi4nsHLk5KgawZIW2YgQ
 CTb+xqjhyfGKuJAtarphrwaCiTM+CVyjcPyBUf9jjwxZWabCVhz4dvOBxMXZGLCp5Lp/jfsDela
 twnNke2WHpnU3BAxfwrijaPY9FWzfkiBWEah5VEA1UvwhcDVtFMig
X-Google-Smtp-Source: AGHT+IHZcIb+/bKRDUHcZvWY19rPhPX8vAZT6eHfFg2Esn6oeIz8S1uAoInJfVPg5PdZt/xFXnW02g==
X-Received: by 2002:a05:6820:138e:b0:619:6fea:3343 with SMTP id
 006d021491bc7-6198f2af271mr2381640eaf.7.1754176370374; 
 Sat, 02 Aug 2025 16:12:50 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 79/95] linux-user: Move elf parameters to alpha/target_elf.h
Date: Sun,  3 Aug 2025 09:04:43 +1000
Message-ID: <20250802230459.412251-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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
 linux-user/alpha/target_elf.h | 3 +++
 linux-user/elfload.c          | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
index 52b68680ad..f9d6372c9f 100644
--- a/linux-user/alpha/target_elf.h
+++ b/linux-user/alpha/target_elf.h
@@ -8,4 +8,7 @@
 #ifndef ALPHA_TARGET_ELF_H
 #define ALPHA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_ALPHA
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8c908db2df..729ce4dc19 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_ALPHA
-
-#define ELF_CLASS      ELFCLASS64
-#define ELF_ARCH       EM_ALPHA
-
-#endif /* TARGET_ALPHA */
-
 #ifdef TARGET_S390X
 
 #define ELF_CLASS	ELFCLASS64
-- 
2.43.0


