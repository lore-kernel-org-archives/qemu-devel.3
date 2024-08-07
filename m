Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C68C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbf2c-0006M0-8r; Wed, 07 Aug 2024 07:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2a-0006GA-RK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:16 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2Y-0003BZ-J1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:16 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5afa207b8bfso1710104a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723030871; x=1723635671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n64RF5K4puFYsrbYwUB9onFxORCL/g5Ezx86ohwcFKM=;
 b=UZuobJIOhVaCZbEfVgYmCD/kVMaDkZ7aeet0lYZQjiKjcll1c1pXAn1m74mx0jBM+k
 5MwGDrSNJE9bchRySnm00jj+k3aNWnmbjG/hvnfarFrlHiSNrokNDbGfzWqDId4LJ5GM
 3T+1JTi8apfXF3ASuw2bQkHKwSJPyWmfNmrZE9ntaiLemidYdkJPIoeEI8wB4pETPNUa
 1Ub2Oda700c8/A9UakWd9mBJGFk2xGAQPrrTnhrq2fFbQNt+kdJ63OcE1qyd5jRelHqC
 9cJepkd/ptLrJD8FrQaKP6dZpykDw2IW7VO/zS+HfibnmLiko47qt21wkzz1DhoB1ZQ/
 Dltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723030871; x=1723635671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n64RF5K4puFYsrbYwUB9onFxORCL/g5Ezx86ohwcFKM=;
 b=OrD7bOiVdUdtKtxf8VyFzmouEVXrSTL9MqUgpmQuLA/1gfp0cZ/K4iKxMrZNfP8eRP
 ub6M3DNfTwqVDTq2Bc3jaZDkkF1zswcujlly16KKWvIuhSB1pVsZ9LR/rppY4doBRi9x
 f42fXWhEp8FOjHN+RvwIKY7MlinWhIGzrp4b+vmfKts0shEUw1BnA9G12NFKV6V0SH7J
 ssgWhhNTCroFmhcxQQzULBJJ54Ll85T/wwYXfpGjytRKB5aJ8pKtBBP1NAwtgt5y0yPJ
 ePsdoN/UAeoDSJyzRGn7Jb5r9DskmE6q7m/wWJX+aZfhaARVqO7E7V1bJYXCdKuIMj7A
 wktg==
X-Gm-Message-State: AOJu0YxUpq/oUjkObIprLv2WRqmllWBXZYrfm+XYSAPqfBYMwVl0Mg1Y
 OaM+tz3Sm8pMy3xOFyVFJ41nXI9lzFf8nyW2fE07z4uv+B04jQgsbL016hk9zV3g+Srf8NGdDsN
 E
X-Google-Smtp-Source: AGHT+IHcZudN3GLdiaxqOnd2fkd7/HANgrNYobruFvDZhD8PPE5+X/L9YyqwAgnST1dmsYe8UNP1Sw==
X-Received: by 2002:aa7:d28d:0:b0:5a1:22d:b0ff with SMTP id
 4fb4d7f45d1cf-5b7f56fbe16mr11505299a12.35.1723030870704; 
 Wed, 07 Aug 2024 04:41:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b92cbccsm6931570a12.68.2024.08.07.04.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 04:41:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 595DD5F9E9;
 Wed,  7 Aug 2024 12:41:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 5/6] configure: Fix GDB version detection for GDB_HAS_MTE
Date: Wed,  7 Aug 2024 12:40:58 +0100
Message-Id: <20240807114059.2339021-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807114059.2339021-1-alex.bennee@linaro.org>
References: <20240807114059.2339021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

The test gdbstub/test-mte.py requires a GDB version that supports the
qIsAddressTagged packet. According to GDB NEWS [0], this packet was
first made available in the GDB 15.1 release, not in 15.0, so this
commit fixes it in configure.

[0] https://www.sourceware.org/gdb/news/

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2477
Message-Id: <20240804161850.2646299-4-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 97de85d710..d08b71f14b 100755
--- a/configure
+++ b/configure
@@ -1675,7 +1675,7 @@ for target in $target_list; do
           echo "GDB=$gdb_bin" >> $config_target_mak
       fi
 
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.0; then
+      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
           echo "GDB_HAS_MTE=y" >> $config_target_mak
       fi
 
-- 
2.39.2


