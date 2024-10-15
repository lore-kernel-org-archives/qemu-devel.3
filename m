Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F653D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlY-0004rs-SK; Tue, 15 Oct 2024 11:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlI-0003MY-Ce
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:04 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlG-0000xi-Lx
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:04 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2e23f2931so4275453a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007221; x=1729612021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIdGHos2kceOOOIgzSCtXbavAnuw+Mxycbvbjx7Wmpw=;
 b=WQeoiZ9CpjZvAGMq4L9OSsIpc0E2JWa/gmcKa+tR1XV9w3Z9xGK9fjKJNg0YN6fMnw
 t/DSfo9w4QJGjMkuvaZjjf9J0LUj6bSkclpzUgao+02Jap/oOYPkE0m7SvuLMe8e+1Eq
 ZzY9BYU/HXcz/cDGtck/tugf0tFM00pD3IH9dBQQpjekf9Fx5Zz6u+IUXsICY2D7QI/D
 aWS/E3FgPxsg4rFy1dMxNQ1g5mUd7KrsH8G3ge7+nVg7RYE0zQvJYRa+Jw9I0TxebV+3
 +ugQyGrZKSyWAptVDCd+gvrvx+02NqFAkFincnAknp4ndX9vfFX0ITwivaT8n28v9qaj
 UdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007221; x=1729612021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIdGHos2kceOOOIgzSCtXbavAnuw+Mxycbvbjx7Wmpw=;
 b=WUCJ48lzGMuZvm+oyt76/vNQ0Rj9plfsi5Ys6KCsDU3FIeVYzEEZX3FkJ0e25L0dib
 iN8aX9Rco2ynxckz00gYLeykPCTe4kqj60aoVAcBw1ctO36LwKDBVnhTExV3k9K9n5hK
 pVflnIiHnR24zfxA0yupYL5uVjWJ5c6dBajm58OdhEc5ih0zrfzYakyM+pm2hhpfQzLH
 t0JiFkmMaxbTCQpLOIenQ8ec2GLb7ECheHG5B2cmPC4+mlBdhaLhjwBUEs1YtfdQ9yHY
 sHgL8dMf9gW2ojZkXDRILTTcRpqoTihmTXGf+E8NJQaoANqmfLbRZ0nLmmvnZSrNrGr2
 DLRg==
X-Gm-Message-State: AOJu0Yw7+GPtLcvfnxhEobyntaH4DsjLVW5L3pc7rWC8f92wrYiAOSUi
 IN9hVO3fAwXdBrBrnESGEvDsD5ZEe2ftjJyzOzYGgOZop3Ke/1OVmyFJ15d8tkEupSJe5SHYVp6
 I
X-Google-Smtp-Source: AGHT+IGnQ9w3Vdc2tRELiZt2y5uf6zP6f/6pQjG9xa6Tu6Tr1CM9eRpSOfJMTVYqqJWM5JtXHqwK/Q==
X-Received: by 2002:a17:90a:ae0b:b0:2e2:b514:ca1 with SMTP id
 98e67ed59e1d1-2e3151b78b6mr16398981a91.6.1729007220903; 
 Tue, 15 Oct 2024 08:47:00 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392e8cf1csm1957605a91.6.2024.10.15.08.46.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/33] target/mips: Introduce mo_endian_env() helper
Date: Tue, 15 Oct 2024 12:44:28 -0300
Message-ID: <20241015154443.71763-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1034.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-4-philmd@linaro.org>
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


