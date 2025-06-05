Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B70CC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQr-00076G-5T; Thu, 05 Jun 2025 12:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQp-000753-HV
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:07 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQk-0007xp-Gj
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:07 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60461fc88d7so2268591a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140821; x=1749745621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHGL3HnA17njL8KC/eaOFn4nJH0BP5PaQATMO4Tu+sY=;
 b=vXZ1KYSd7F03LjSWAgUuv/+GbInx4hOb7MNDM+FOoyc34lqBmXaVhs1x3g2hHnrAuK
 aQgi8Eqwxbbd3Mi9973s36kNidKpF4751ka0gyFS8IJYhMAIVvBaF25Q3rOYGV9cet5U
 RrDBYwge8ebIlwfRdt0wQDnOpChx1DkFTWyoASr+WHBnMvESBFuyO7gWcdYFogcTkMQ2
 lFkzIBfZh5zps2KOZCRqdLUBXaYrAzWI7d9cORPSYjTsHIv95Dkpa3uheM/7MYiME4HF
 NxoVt0UiIFBJ35PVP3lZPH8cSpcltRnw7fuQ3jUK/rmV6v230Bg6d9gd9TJYedjIniRs
 W9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140821; x=1749745621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHGL3HnA17njL8KC/eaOFn4nJH0BP5PaQATMO4Tu+sY=;
 b=RvOsDo+i1QoHvY5ffesTzGCPCFGzk2tuKH6hsOeQo6CHootcekplhJ9m+zSTVSCVng
 D/1xqUDOP5EN/OBxgR5psu/9QtYNBB8JERy6ggT1KGAEKdqtcp1KvDE4iGdgcZOESnYN
 ZXTfhRB5lW7/5LE6Cg8zqP5/ih73/xKb3XQd8PrArzICYqNu8vu0Wr1pJp17H+pqpz5V
 V5UpkO2cpedJ27Iac2yajAA1xk7wahX5npvSLrfwFYq4ZmSriACJ1okB60T7owzzTHZX
 eeGlELeA91rfVGHFebiRI1ZMw5i8/NKAe3zlw3ayQbuoa9reepvtfXCBw7tcNB2IW/Ah
 +k6w==
X-Gm-Message-State: AOJu0Yy+BMsvD9KMpy8wSK18Y4VLyNVlcs+QmBE4hsZA3eyEl0GdZBuD
 UAcJbbr68SPLhWASxF0XMlCUKvVveLLuDhMn72T1r+iSVqIuE4y9Eg4FxFLGUx+orU0=
X-Gm-Gg: ASbGncss7e6rRk7BjDQjCFuZAQtXjy5jyKy8Sgbf4qOauauzyLN1uDxzSr1iIC8eXIB
 99G5sS3IvLdoiO0L24PMt+V/e0l7sfxipLXeye2hKCLrZqChu5fHosvgO7WhyzUANTdO7jfaFT/
 Zic3x5apb9d59j+foFqmW70lzRL6M2KthAmCaorqpUz2XVDaFncvhzytBVakTE4uBZ6rW/jD+Z7
 d9qdTMCk8Y8G95/HPuDCfBpt5wJUTLdqJE1c7SlwkksbeOJHxwgIE+fEGe83tsIxC1OIle03nuk
 vZYg+0Jsvimqd1+6npebi4ofcSB/4bWguw12fEd6vrWKFk7uTuZG
X-Google-Smtp-Source: AGHT+IF4eumeblsy+LBeDuMZphbb6zNSN4KAYX9HRFLoHIqoOmBydjcMAxhYCdBHQx4rWyJzGmGjZg==
X-Received: by 2002:a05:6402:51d2:b0:607:4625:98f5 with SMTP id
 4fb4d7f45d1cf-607462599bamr1537056a12.23.1749140820658; 
 Thu, 05 Jun 2025 09:27:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60699731f06sm4651671a12.27.2025.06.05.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE1915F7F3;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/17] include/gdbstub: fix include guard in commands.h
Date: Thu,  5 Jun 2025 17:26:47 +0100
Message-ID: <20250605162651.2614401-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-15-alex.bennee@linaro.org>

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index 40f0514fe9..bff3674872 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -1,5 +1,5 @@
 #ifndef GDBSTUB_COMMANDS_H
-#define GDBSTUB
+#define GDBSTUB_COMMANDS_H
 
 typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
 
-- 
2.47.2


