Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1BBCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJE-00007H-SY; Thu, 28 Aug 2025 13:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWf-0008Ej-Mw
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:48 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWY-0008Nu-T8
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-248de53d12dso3336865ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383276; x=1756988076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy4YLGNWV0R4ND2Aq+PHs1ssPj/3u/mwblyCWLL2x1w=;
 b=fj3QAQBqo1j7i4SmPQxFu3ATkf6mX927xnHbLO4JeRKyAeaw/0WLvvjv9DZZ3PSFBz
 FHe6MijKB1+Q4kPIxT9WS7jOftT4hTA67WzeUmMQVeRW9vxox586a7S6flII/cMQi6DJ
 dGUtHV4DV0cHabGHGmgDdCxk18CJAQLbxOzc2LVkX7GSwwU2+UHJQ3nwajfqwqHQrJiw
 rQfBo4niclymdpXpY5t7DoGPBULi6tfhZpR0izgooIvf4wi6fgFCdV2Aza5y3c9vhUq6
 RkMIZsFUF1Rtx7GcXbJORoW8ZqF5BLcZwZxvPXgK5XPpmfmdg0nvipykDyLp37nKZz/e
 BFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383276; x=1756988076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jy4YLGNWV0R4ND2Aq+PHs1ssPj/3u/mwblyCWLL2x1w=;
 b=ZxMuXjljQHMw5SfzZch2gj4SHESrs4zAUO8Uou5oy40GBrisaFcHEvNzaA7XgNE0YJ
 zI5KpH3LV3VJT/H2mApdM9dD48Oot0GCLDZc4vdKjywVheUxVSj+TDgpqvBWEswzo7HZ
 NrjMcWzTHwtbFyuKsnbAkMvY6Uwue5Dap2jTKVhNMQ3QkkuEeff4458EFvc8adq/dJ0Q
 ZrSJhMXwi1D+sGnN1wiIT2+ENGWArVhmHitti3Ou8I3Ec+qPmkeZxn0fIhxSokmLkiHD
 I75i+52Gd5fijj5y4aVraPAdMpgFm2HNuCkIM1oL1VeoL6GIAdrP8vEslovBRZxgKp5v
 QlbA==
X-Gm-Message-State: AOJu0YyBbo2Zo3wVSLqSTzrBql3e1z/NS+GLB7aZdspqZPuocK5vCaru
 megLPT3TG0jOlbLumk4WRRocSKk69g+lRDBp2VVZFNvyQTTR6LIG4B60Itp0mpQan5C+4pSTBfK
 01H9p2LA=
X-Gm-Gg: ASbGncvUzd+bJPhGk9Qmjt6g+AVfsow8t1Ocod7ENQ7zrNNA+kMxPL8zRzJRQNl1bEs
 l7ppSp33XzG6G/LVjXBdOnHHtdJH/yF4KZiDcHUaVgjyplGWFkVOoqJtOoRBDFQO7VZ9Y2Jpw4J
 NeXANv7Xz2Buv0oJ4FY372hkzo1c3SMBFyqFl6jAE8YAlO54DrX/DREuvZjU5EyUBR0uTXAuani
 vugruPPn661v7mx3Tc0FsRFwWrUA0QAmG0t0m91mEF/y75ZLj08Yt0/nwPJ3TN4fAclN+1+5/g9
 /FjgBa+KwzOMljCm/topkG2eNtQMsrxtdulIEyFYA/8on6gBQWdvVzT1oByixOjdvDmi/V4qKb8
 qwMQG6DXq/gShg0BA3DSRYhT13g==
X-Google-Smtp-Source: AGHT+IE3+L+GZXGAseFC94ZLYt3OFl7dqQXNruYaKNi910Xj8ZbSGRbofONcPyAiCIG0cEQgt/KjCg==
X-Received: by 2002:a17:903:1ac4:b0:240:66ff:b253 with SMTP id
 d9443c01a7336-2462ef93318mr301445395ad.46.1756383276441; 
 Thu, 28 Aug 2025 05:14:36 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 63/87] linux-user: Remove redundant ELF_DATA definitons
Date: Thu, 28 Aug 2025 22:08:12 +1000
Message-ID: <20250828120836.195358-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We already provide ELF_DATA based on TARGET_BIG_ENDIAN.
Remove the extra definitions from openrisc and s390x.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 59e6605e36..8ff9f83bb8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -305,7 +305,6 @@ typedef abi_int         target_pid_t;
 
 #define ELF_ARCH EM_OPENRISC
 #define ELF_CLASS ELFCLASS32
-#define ELF_DATA  ELFDATA2MSB
 
 #endif /* TARGET_OPENRISC */
 
@@ -333,7 +332,6 @@ typedef abi_int         target_pid_t;
 #ifdef TARGET_S390X
 
 #define ELF_CLASS	ELFCLASS64
-#define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
 #define VDSO_HEADER "vdso.c.inc"
-- 
2.43.0


