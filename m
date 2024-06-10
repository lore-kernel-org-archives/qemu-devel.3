Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3ECC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgTw-0008Ta-Nd; Mon, 10 Jun 2024 10:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTu-0008PS-Jj
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTt-0004Xt-4b
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:46 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57c6011d75dso3195155a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718031522; x=1718636322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4LCP0TPUvNWs+1AuzrihN13r1C08nRA9emJSD2ibmQ=;
 b=OiXeQr0De52RwGjKI17FzULjfri1/75yR+aLdPzLLwgGnzzKZBpgw8Bwj0NiJnmP1X
 eZjFKg1CiBGY7ntl8Mdp+bg5/vPCvKlxCsVjEH8I6JaOphH+va4FPQyvtYuFY4G+0GXO
 vs83zKFfVvX2WPgb35tL6B8IJgPZPb1tMxzFyHoC1ji/yYCaZwr7WaEPJ2ZsUKXi8kOD
 Np29nyNn7lPDR5jxjyI8mFhfeB26InWj8SimwoAwocB22lsZNFB4xyjI/Q3whhHiNLeW
 45pf98i72+uS2Pj9IQ/9CUEoTNgxYzKffZ2N16FZ0u221ZiQhpmcrDeV/CMDf0paS9yb
 QRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031522; x=1718636322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4LCP0TPUvNWs+1AuzrihN13r1C08nRA9emJSD2ibmQ=;
 b=QQbpLKU5byq5jYoMyT+NZK8QdTRxIKFn9yNKmjDwb0B+tB8w3nST3CAV/kO2XduwEz
 XNpVR8gbRTNH+ppNj1XEMMPSKojmWrmHDLXQv8VGMdrmFL7h9eTCGBt9UbL1rrENsolb
 nS2vnAsm/Rix06cxVqHLiRj90AWqLQlfChyBRPbJVLHIe95qxpDidGUsDcfVAcevGzJp
 UYDp6Or2kPV0P0BiMiwI2W0wfkWwFbE151trbcgZ1qO0vb6HGV803wSTDYLefh/bZIIX
 pdcYkkZRJS33sbydLmQVNbLQwHdvj6EWjKNjXw4qqsn8QhUf1QS8ICY4C6bw/N+ljJ2J
 34zQ==
X-Gm-Message-State: AOJu0Ywux0G2BtTFcPwwVyx87fhKimHTWlYoaYIPCg9bwzSHWh4jdDrv
 F0VCPZkpeT6qh+E6JVK6MTZt8qRRjz9YUFsg4m5M9E0NUp/mFfSGhgIb0EyHklJEVqdPmuXhyCt
 +
X-Google-Smtp-Source: AGHT+IH4HJsSXFGnFDCizr8fk02btolheHJgtXgnqLae1ceZ0GjeDAaYMQG6S41rN3379jQxpbLq5A==
X-Received: by 2002:a17:906:50e:b0:a6e:f6b0:c4a4 with SMTP id
 a640c23a62f3a-a6ef6b0cd21mr470828766b.57.1718031522420; 
 Mon, 10 Jun 2024 07:58:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef4581827sm439647166b.215.2024.06.10.07.58.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 07:58:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/5] semihosting: Restrict to TCG
Date: Mon, 10 Jun 2024 16:58:07 +0200
Message-ID: <20240610145808.2267-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610145808.2267-1-philmd@linaro.org>
References: <20240610145808.2267-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Semihosting currently uses the TCG probe_access API.
It is pointless to have it in the binary when TCG isn't.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 semihosting/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/Kconfig b/semihosting/Kconfig
index eaf3a20ef5..fbe6ac87f9 100644
--- a/semihosting/Kconfig
+++ b/semihosting/Kconfig
@@ -1,6 +1,7 @@
 
 config SEMIHOSTING
        bool
+       depends on TCG
 
 config ARM_COMPATIBLE_SEMIHOSTING
        bool
-- 
2.41.0


