Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7041AC02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLc-0001Vp-Qn; Fri, 07 Feb 2025 10:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKY-0008G8-IH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:52 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKI-000447-MI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:45 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dcea5d8f16so4380497a12.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942285; x=1739547085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYLUPD3P/9Yhc9T5gc39GsuYcITC/cYJ3+WE96RAZnc=;
 b=cNWUNp6iqSEN5S+2196aERtNTILTuYe7zoTFQEYG2iVvo6cNmv7LfgHfBLKsjcEKbV
 /TlcM2NFGPJf99CjtpwxiZhWi24C/Z8oUuRFhsWz7z8eH8gqbTBDqiuWNRI63xFdInDJ
 ZDSMJY+gjwYjrIkVOzh0C6sumFaArCuw2eS56B4glzmFGX0bTviMXW0Ehr6Yj8C/eNUr
 NcezNty/W1Sa9wvvLG63REW8sSnWRigyiFvCSfboJwCwBiAOIQrARXTNbOhVcXZE2uM/
 QBniJ7KcLfm0kDseFLy3n5Zt3i7X9yGVV7Z9Y5uah8XSJaAxz4DRNC1Po/Pz7WhxxffP
 1hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942285; x=1739547085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYLUPD3P/9Yhc9T5gc39GsuYcITC/cYJ3+WE96RAZnc=;
 b=Pli35lnk9j7h5XuK3okIfytqzeyIAea76ezTTPC7vZFmMzbBStQJ9PBkvWt+M7PB4m
 12jppk6BlYd8up2RJa/PzEBDqYGkFAE5ZcFjOdorti+RRcx4w1MmO+cMe/Ay10c/hROt
 fZB9/cU7DPqxoyABhkOa1K+ePtJFd+XTczv62XXxUpr6W7fUTCggU7VbiOfFDlPFAmZU
 vZ7fyFFwzdpOD2u+wI3WQYMEU9AfFJHBPeu9cCYosVTgE8SRoW5DdLRTTIUoE3VrLmnX
 ORPdF3elgEvjDUNGr9sntiNl3hkufhgHiQaux6jPRadjWnxq1YIaT7/QZ79ZZuL8TXnq
 FyjQ==
X-Gm-Message-State: AOJu0YypZ7Y9v1RpopSvf73KQUD8mTNdJtwVmvMJkdSoU0+hacQT0dCE
 /VMLCJ+7sEqX3zBueMeKnS9EQIU743bMK4zDiGLZbPqCKjpdYvqMO/61QEG4GRA=
X-Gm-Gg: ASbGncs9J4IhUDMYViydZLx4PsNlRckTDnl5T0YYaskL2QUAFuoolrPX3FP5rZ3vLtg
 Lo7HjLY3/STO+OnDGtUH0dzVqS8YWJaeaobWxKWJsUA+scZrhpEhKGBh3jAaStWbKb8QhXqOAzk
 kk6KGmwjCluL8Ngt4vgnVrXQx6gQ3ylg10mFPY0L8bCvGVUsGh40y1wpcthO1YE5U8owoUVpYl4
 /osYzrMowFkTcg9G5NpdpvxJ5hdADMHtpFoPRVp2yNkaEUgIbVayPwjgxoTFxdCHR2E/c0HXGWB
 +PZgRB1rNHPFl3zBSQ==
X-Google-Smtp-Source: AGHT+IGktyptZvO6wP9Lf0Vti23wWr2h2wRy8URVUKIHWi7WMZ3mQAsLZNP4ZAvhdtyZeAjI8cic8A==
X-Received: by 2002:a17:907:c28:b0:ab7:63fa:e368 with SMTP id
 a640c23a62f3a-ab789c87ec5mr381999866b.52.1738942285213; 
 Fri, 07 Feb 2025 07:31:25 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f842c8sm285285766b.39.2025.02.07.07.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D224960F1B;
 Fri,  7 Feb 2025 15:31:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 16/17] docs/user: Document the %d placeholder and suspend=n
 QEMU_GDB features
Date: Fri,  7 Feb 2025 15:31:11 +0000
Message-Id: <20250207153112.3939799-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-8-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/user/main.rst | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/docs/user/main.rst b/docs/user/main.rst
index 80a77f0a0c..9a1c60448c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -54,7 +54,7 @@ Command line options
 
 ::
 
-   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g port] [-B offset] [-R size] program [arguments...]
+   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g endpoint] [-B offset] [-R size] program [arguments...]
 
 ``-h``
    Print the help
@@ -91,8 +91,18 @@ Debug options:
    Activate logging of the specified items (use '-d help' for a list of
    log items)
 
-``-g port``
-   Wait gdb connection to port
+``-g endpoint``
+   Wait gdb connection to a port (e.g., ``1234``) or a unix socket (e.g.,
+   ``/tmp/qemu.sock``).
+
+   If a unix socket path contains single ``%d`` placeholder (e.g.,
+   ``/tmp/qemu-%d.sock``), it is replaced by the emulator PID, which is useful
+   when passing this option via the ``QEMU_GDB`` environment variable to a
+   multi-process application.
+
+   If the endpoint address is followed by ``,suspend=n`` (e.g.,
+   ``1234,suspend=n``), then the emulated program starts without waiting for a
+   connection, which can be established at any later point in time.
 
 ``-one-insn-per-tb``
    Run the emulation with one guest instruction per translation block.
-- 
2.39.5


