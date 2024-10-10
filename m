Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC72ED2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz13a-0007JU-F5; Thu, 10 Oct 2024 17:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13X-0007JC-7x
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz13V-0004eV-Kt
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:50:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e01eff831so1079956b3a.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597044; x=1729201844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AU8VwDQMvjX8OObel+UKUH0COTVBKCyib/wItdKMSMg=;
 b=OS4BppR+dXksYqPZ60kG1brxIiLmtvHKRll2iVRlA6UcLf1WoPZ59Rz2ksMPHRVyle
 dH7T3qzJSMA38rUSdwHEekmeYTH8R7oJXhejxj3tHvBLpQexC6PDFe/e5QnOpvvFSxbs
 lVeEOL+8herEByxEWtL9/PCD9eeg+pGYNW9BcYUgHTaWMJWi5zYSAda/1qL5HqpQIVgp
 lXtwP+tirW66B/d4JpRqymwkHW4AFcKcYoaJTI35Of7RM4sfH6qmBCs0TVXY7blm0mGm
 J6v/nAq2V16/O71WTj3yi/+yp2pn0QqORPIKDuwct8et1GezyqQTrUEQ1MM1LfsVu/TQ
 pF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597044; x=1729201844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AU8VwDQMvjX8OObel+UKUH0COTVBKCyib/wItdKMSMg=;
 b=U7JAux378cKgYGUL0keqDAYAyQTRg2N36EEedYUSOTrj2/tPC30WqearoFh2n2PIst
 xTCGRkox3SjDlPZrfnqrINNBeD2aBAya4Z48Dykp90QTNDObY5aNAXgSbz3SgdqT5NUd
 OYtSRj/2lQhqLQIbyek/tEVlLvE15CX0uDMIHjBSE06PTa0YIzUZH/C+5cyoUlXpqixv
 ZyLwCdfqTJip5PlIEn8o0O7k3yb73mryB8fRtwoxmZOog/aMeWx4Thi6LnOkvLCjYRYJ
 PZ4h4HwMapP8T57n3w/pYmkMeVICxHyPABOlpse+4IkCEhb4jP9aufhTSmhlcrgVLqVJ
 QTGQ==
X-Gm-Message-State: AOJu0Yxapf/lgL172RptadqZCc1Jm/vmcpKN7HMWCuIWFkqiSgmxLZuT
 jquAdWpAJC9JnIVv9NTUIBmCNkDRWgwfq53039cNooX61bm0hiEZW/QdZMgxJsCWg4jN4lA5dzq
 f
X-Google-Smtp-Source: AGHT+IESdkW4mTIXmfX8UBrQfZ/UpdQB8SLWsOHmtT1UQQXdQjezS7te6L2Cso3h3/KJzC+iq4QFVQ==
X-Received: by 2002:a05:6a21:139b:b0:1d2:eb9d:9972 with SMTP id
 adf61e73a8af0-1d8bcf110e0mr587566637.20.1728597043674; 
 Thu, 10 Oct 2024 14:50:43 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aab58d2sm1547005b3a.142.2024.10.10.14.50.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 03/16] target/mips: Introduce mo_endian_env() helper
Date: Thu, 10 Oct 2024 18:50:01 -0300
Message-ID: <20241010215015.44326-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Introduce mo_endian_env() which returns the endian
MemOp corresponding to the vCPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 84c8e5e1ae7..91c786cff8a 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -230,6 +230,11 @@ static inline bool mips_env_is_bigendian(CPUMIPSState *env)
     return extract32(env->CP0_Config0, CP0C0_BE, 1);
 }
 
+static inline MemOp mo_endian_env(CPUMIPSState *env)
+{
+    return mips_env_is_bigendian(env) ? MO_BE : MO_LE;
+}
+
 static inline void restore_pamask(CPUMIPSState *env)
 {
     if (env->hflags & MIPS_HFLAG_ELPA) {
-- 
2.45.2


