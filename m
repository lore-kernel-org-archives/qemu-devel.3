Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75202C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQt-000773-32; Thu, 05 Jun 2025 12:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQn-00073A-4w
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:05 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQl-0007y5-7D
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:04 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so211291566b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140821; x=1749745621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJVseqRaD6Laof0iJpbCH6iD9WwznG/NmTZUaRCwaMA=;
 b=oFicJmi9XhFx04le9Jr3yawLTBS3KSDvqc7aQ+35SlAqhrNuHekgJPc3O/cpXhX5wd
 UnuA3mgUSxqWTUggVi6HaJuuuDGmiuKpK+EbaZvkglU/9A8r4v1qjOOCWUpDWY8dWMYL
 lI/y9/uiy2XaBPjV/U9NW4ju/VKipY3M2+Ap8WS+jenZlWotRC7kVRzFe6xPf0daAc+Y
 Z8yM9zMlB2r7nnMzApcVeqFwG848ryQvIDXP6/QwEMUEuptal7xCkT9q5BpwZuMRW0g4
 ws5/5f2iE2YTeHxF8ZsAEmN5WW2EbdhQPbBB4EBUs6e9OndPC10IAm84PwaDeVBSA+El
 6BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140821; x=1749745621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJVseqRaD6Laof0iJpbCH6iD9WwznG/NmTZUaRCwaMA=;
 b=ozXiCVzOswAeXH07tt3rY4x0A2ugI28FZTnEx1ibkpPuSE6P9dxVjC09VEodQyfEnl
 NeAzTFqpXXHqHLnzghQDfkUctfIEnwMErNqDiIdIbB0Q1mO9VZ9goOI/EZtcPwXXEXjH
 sh2DlDgsGfx86mOJoUTugj781KgWfN7w3jjwGYpN5G7XA5Yh08lofb3K09MZvYwgbAPW
 LZFgmiGAb8vy7xiMcQOqq2vbu6IkQ6bWG/TmxA3AIsAYFwqSiV+FGvy5hAKqnmK6FoAn
 Qhd5CKHJfSsBLmj0wRpemW4+4BfK7MTH6vrvYu53wLwPfIdaPAFyx7O7fSmvzcZTz70k
 BoqA==
X-Gm-Message-State: AOJu0YxMcZcaBZnkBKXs/2EcUw7n27UDrpSySDQcRtrQ7IwxI/QLhC34
 bOQR8mg4DB66olCU1GhB47BQsNRwuCrHqOiku9WmIuMzY3ZVgHlvRFrOKmzC7sXqrl7KJGhVEmR
 ybbW9ea4=
X-Gm-Gg: ASbGnctS7xanVtjaoFCwWui0R4VOmqKEqtgaO7UDXw4fBpYATYO4mBe9RHa8WrqQndv
 9z1Hkr7a7oqDyBRbRSbp/12nNOJltfEwkEITaBiz/QrZnRGBHLAq5GlQP3RoaFxw57KEuUCks/d
 bsu36qU72mxc5gYFbEX9en3jFXN/t7D5Ok4SY//ys9kvqm4UyG8S9T0hvYQo/42f3OzwgP4JMy3
 M5FSby5GJRb5osF920ZtY2pA9BRdcFNBFYWRZQFbY37RduSEQsVEbcE0rYoBEfKyonxO1GcTs1X
 6D1feTUln5CfglqZBM2IylUZfRg1m2txlc8UHsDa2JpvCyzrI3tx
X-Google-Smtp-Source: AGHT+IEoUaIifQgf8lGtzJm1EDvBxSdALCND3d5XAtrUel5ZNT6cBG4BPKx/4OOTQNdCYq6tm/cYrQ==
X-Received: by 2002:a17:907:3dac:b0:ad2:2fdb:b0ab with SMTP id
 a640c23a62f3a-ade07901184mr448467866b.29.1749140821295; 
 Thu, 05 Jun 2025 09:27:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade125a01c3sm79920566b.95.2025.06.05.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3FB85F832;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/17] gdbstub: assert earlier in handle_read_all_regs
Date: Thu,  5 Jun 2025 17:26:48 +0100
Message-ID: <20250605162651.2614401-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

When things go wrong we want to assert on the register that failed to
be able to figure out what went wrong.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-16-alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 565f6b33a9..6023c80d25 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1343,8 +1343,8 @@ static void handle_read_all_regs(GArray *params, void *user_ctx)
         len += gdb_read_register(gdbserver_state.g_cpu,
                                  gdbserver_state.mem_buf,
                                  reg_id);
+        g_assert(len == gdbserver_state.mem_buf->len);
     }
-    g_assert(len == gdbserver_state.mem_buf->len);
 
     gdb_memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     gdb_put_strbuf();
-- 
2.47.2


