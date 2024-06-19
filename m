Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD934C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2PW-0002Cc-9P; Wed, 19 Jun 2024 17:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PR-0002BQ-Dy
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:01 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PP-0000Jl-Mo
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:01 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso152279a12.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830798; x=1719435598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lTcCjJ3oR/AagcegLt/3bpmmkWF2oByWozOC0a9UQ8=;
 b=KFCLGD5mc9QnxYFZlQ9WYarDasUe12FRtDXXkVTo4uHfhwYEZgVf3xqAZ/Y0oFd4dq
 4kDSBDEjkZEXGV/p8T1MTC7Iey0bE94OjkOfDi0TaIi+DNreVjmgUQ9RJsR8rMRRuHng
 2v257iZXdPO8t60mNCoqy5lfBumLFiq2Gw8W8c9MqjojaRGaZgQQB2sSZdQV423MTZSb
 SU5RTyo3OiMY53xRODkxwTJjNKPlXJu4p/66y4c1RjRCjuRHcQhe/n5iK8RmRoIP5SoX
 ADzPF+rwYa+8VMi7Qdml8M4d+TqeKwvBP+6teddi82EuTJ0kY0M9l0mNHbCD9bWDQuZ1
 vIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830798; x=1719435598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lTcCjJ3oR/AagcegLt/3bpmmkWF2oByWozOC0a9UQ8=;
 b=qChzzpCfg5I1+h5MNKsvtiDQNZShHAySK9HfQpKMp8pU64ZzVs4qNp/grpUTsMz4Wv
 IMiutUPe1G8TnzuhBqMDv5S3IlDpdf18WCQq4dX57OI0Y0H4kMRM+qH1G5+0Qsi8aysR
 44XIEoVcpXSV0Nv6JKi3zWHNZPYRW026agNVPzF32BeKMAVhsdJXCft8No7OwSQ1NYLU
 z+WtVL6+W3nbz7CHPxsGwUQdkzdq28+N4zRKY9IbWrfWH67RRma4XSwj8OIygvS6qt9v
 y6MLnjYv1oF+N2NMYQJc41TMQAzIU0xURRAC3lMm58FNc4emCQMMAGYVbWxV68NwucYU
 lvhw==
X-Gm-Message-State: AOJu0YxBFnd1caAg+6dSzYz/9L+Y5x34y8N8TjS/yNFXnL/CPLKuO6ty
 aY1NvtBvnubYZMmfSjvyT0RP55Lja+wUIco2/t5Jg/wOXHLd9+qAY6xQA9wxL0jD1FSTT8y798y
 p
X-Google-Smtp-Source: AGHT+IGjU/C4WiheAxh41fu3jSsG7+CO+ID8yUWzlBRbx7d6FyudpgWCIbV1iif3hAk5pPJSAffjiw==
X-Received: by 2002:a17:903:230d:b0:1f7:3e19:6d9f with SMTP id
 d9443c01a7336-1f9aa3dab89mr43615635ad.19.1718830798211; 
 Wed, 19 Jun 2024 13:59:58 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/24] util/loongarch64: Detect LASX vector support
Date: Wed, 19 Jun 2024 13:59:33 -0700
Message-Id: <20240619205952.235946-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/loongarch64/host/cpuinfo.h | 1 +
 util/cpuinfo-loongarch.c                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/host/include/loongarch64/host/cpuinfo.h b/host/include/loongarch64/host/cpuinfo.h
index fab664a10b..d7bf27501d 100644
--- a/host/include/loongarch64/host/cpuinfo.h
+++ b/host/include/loongarch64/host/cpuinfo.h
@@ -8,6 +8,7 @@
 
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
 #define CPUINFO_LSX             (1u << 1)
+#define CPUINFO_LASX            (1u << 2)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-loongarch.c b/util/cpuinfo-loongarch.c
index 08b6d7460c..bb1f7f698b 100644
--- a/util/cpuinfo-loongarch.c
+++ b/util/cpuinfo-loongarch.c
@@ -29,6 +29,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     info = CPUINFO_ALWAYS;
     info |= (hwcap & HWCAP_LOONGARCH_LSX ? CPUINFO_LSX : 0);
+    info |= (hwcap & HWCAP_LOONGARCH_LASX ? CPUINFO_LASX : 0);
 
     cpuinfo = info;
     return info;
-- 
2.34.1


