Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB46C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 11:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rivKZ-0005P6-Qt; Sat, 09 Mar 2024 06:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rivKY-0005Oy-NV
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 06:57:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rivKX-0002KW-46
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 06:57:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41312232c7aso13908255e9.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 03:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709985451; x=1710590251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z2HOCsiaKFrxl5nqN8e2WRaePniA2rmNLlhW+OGGN+c=;
 b=zA0LltMNQ3M4VqALPOoTvjnTmOBzwIH7kngKTnVqxeOKa9I6jYlA39i0nl5C1WqW/y
 /D50PheeHb2KD4H7nPB6wpZRod4oAZCpCYnlP1SwQV8vBAGwn5t2Zk4kDTA40NWLNI4I
 AGkCnNlwqXgNCnS0hQeUNkNNTs/LN45ywSXgCu1ACungTZd5C1vNfmNwjVAQBVu9LkmV
 F1IwKAlKRrNX4FRj4jSrkiT3thGBZIWDeXKk/d1sKn3UmaVkrdzdJz2F9OiS4G1zfbEA
 zoKG5bwAJwAkbyiB2L/takaNn8zgQPQqzDPViXLQPQFpXOz6nhXEdpVvE25MtiDMTug9
 WCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709985451; x=1710590251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2HOCsiaKFrxl5nqN8e2WRaePniA2rmNLlhW+OGGN+c=;
 b=OWWp/EbUWb60lrubf68asdKoLo5EAmLhrWg46cXUFIgTVrlHARHoAqIXfk+F1ufIcx
 Lh7CUt44YSVJzgqGLVlf2EAqDUZUo+JfvlHig+45OYd++ekizli5DJ+UKM9GJ0xkchct
 t3P+9rjTVrEY2g5TE+kFq270xr4ua3zJm0mNubDn62LNdwsTFRvM9EcsC9DcS/yv6a8D
 a2lFLbDDOY+JW4zd/dGjAhbNN8EFvDvlrY6nVTmgRwI0Q/QGtnhRg1ZYoat/zTru4zLj
 fxSPTINZqSKdByN2AGWsP3YEGOT+3hSOd+Lu2i7032B6FZt/AodXRtVxC5qyDhlYJWph
 siWw==
X-Gm-Message-State: AOJu0Yzu/t8GWi9DDI47mCBIPHyYTfcaILNt5Cyg1VOb3sB2byp6zij3
 3W/oqjy4sGGeiFZY8toV2rKUf8AV8xFLqnkWH+/IY7N8yOHH8BZ8DMPPL6BUQMg=
X-Google-Smtp-Source: AGHT+IGCEZ1X9Xza6i3H7erTLd2VXQ1mf9sK0jQmEPUTZUiCMCovk39gIKKiGIz5DqUADMwkTdfvpQ==
X-Received: by 2002:a05:600c:358a:b0:413:1ee4:692e with SMTP id
 p10-20020a05600c358a00b004131ee4692emr1539199wmq.9.1709985450964; 
 Sat, 09 Mar 2024 03:57:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fc20-20020a05600c525400b00412ae4b45b3sm8679078wmb.30.2024.03.09.03.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 03:57:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4D365F85F;
 Sat,  9 Mar 2024 11:57:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] tests/vm: ensure we build everything by default
Date: Sat,  9 Mar 2024 11:57:26 +0000
Message-Id: <20240309115726.1107020-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

The "check" target by itself is not enough to ensure we build the user
mode binaries. While we can't test them with check-tcg we can at least
include them in the build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index f8fd751eb1..4a1af04b9a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -606,7 +606,7 @@ def get_default_jobs():
     parser.add_argument("--build-qemu",
                         help="build QEMU from source in guest")
     parser.add_argument("--build-target",
-                        help="QEMU build target", default="check")
+                        help="QEMU build target", default="all check")
     parser.add_argument("--build-path", default=None,
                         help="Path of build directory, "\
                         "for using build tree QEMU binary. ")
-- 
2.39.2


