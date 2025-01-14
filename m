Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75232E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfO0-0004LI-80; Tue, 14 Jan 2025 06:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNn-0004KG-RS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:56 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNl-0006du-V8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:55 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso2862199f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855211; x=1737460011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO4+dhgDNIyv7ebOS6QWgeVxieJfX0lz0H9vGOgOWgE=;
 b=dtE19hE/aLE2aoOL1e3pdqxs4NQisp+zsSEVCBzF9wAPdME0xKckLY+Wxwz8SU2Ov7
 FmCtenf5++r+duyqxhJKDblmCKBuQfyUASpPyT4Sh2k97hqWO4o532DwFTh1mNjGAnlF
 bZ0GNNtETGkOxsPvE9CxiFV7eXFIv2a50g9z1pr0/uPRVRnVz6Xc08nefvXYawkVa3Xm
 m10/meqRhpJLFVHWA7OptaGIte3HLjdCpUDm/QLl5lINW7QXJ3kd9TzvF08Qd3i5UGiY
 9jL2Kk5cOk4n+W4YgKPfUdwtQ41cgggmuGEF+Bg6x6YXHeSv/TxmawjFsDP7Nk85vGGj
 2YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855211; x=1737460011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tO4+dhgDNIyv7ebOS6QWgeVxieJfX0lz0H9vGOgOWgE=;
 b=Tk2fsPkNhz+kmIEFQPOmNaWBtQLjl5l0n75vXoE9MtbRPC0LwA4ryiDgfqCVt+bozJ
 s3TgjnwtaJh6/JPKAqYZ9iKxlidGQT0McPJkwBNGGw97Z6cMZ6A56p++S4cZGY+Gq9d9
 w561LP4gQg3yzcwH5xpLF0iSe/fjEotFbeUPH5GzpAGIEOOA7gECaPcHvhvOJ1i9DcLB
 /xQGeCLuWKvCp9RkaF3IXLku8EDYhOkuMDdFeOdvVIKE4Va1TzH5ws7C8xys0ZUSZpVq
 pNAVt7D14FeRAPFmD450jlEmdDULF8dIsHkBEpDF+44efmDmIvUQ1QDAXq6ucbML9c1t
 94sg==
X-Gm-Message-State: AOJu0YxO9ko+o3KUbMRYmOdwjVN/MbE669hKVCHFXRU/L5jz1g6wqgSE
 +f6AbTpz+lZN/DVWJg0SwnZsnfF6MS1naxZCXbhCwa8XSAnf/kTcmuTH2QiTWPU=
X-Gm-Gg: ASbGncuOoJznNGh/dUVXG5mPwZ6q5ymAE5fhWAmmr6N39ncjrvAWCmqGnCcjgUCwmal
 FUtHy8BdmHp7VaASr2AnmISjavASS+XcmwSMU1bPBySG9ZMYFMH+D3GiucbxgXQlzx5xspv/u9j
 EG5oXHIt5rx/3INEm95cekEFRLpyenvGuaZYRZt4kmkmqaSDc69eJneqVTmjeg/52523jbs/vmq
 +OKVrFPuJugRlaD4hUmjib18YzftJQJhh5aOFm3KnUK9uVzUn7IEQI=
X-Google-Smtp-Source: AGHT+IEB3pBYYIDgnmQX1/g5jnRvq/4ALSpUHAK5J3XBauCB98xPIxZqO0oro9LWzftri9SaNkDF1Q==
X-Received: by 2002:a5d:47c5:0:b0:38a:6161:2854 with SMTP id
 ffacd0b85a97d-38a872c944amr22677658f8f.1.1736855211340; 
 Tue, 14 Jan 2025 03:46:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80c9sm14473803f8f.84.2025.01.14.03.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0E9035FA6C;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 24/37] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Date: Tue, 14 Jan 2025 11:38:08 +0000
Message-Id: <20250114113821.768750-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250110203401.178532-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/style.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b50079..d025933808 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,26 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Bitfields
+---------
+
+C bitfields can be a cause of non-portability issues, especially under windows
+where `MSVC has a different way to lay them out than GCC
+<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_, or where
+endianness matters.
+
+For this reason, we disallow usage of bitfields in packed structures and in any
+structures which are supposed to exactly match a specific layout in guest
+memory. Some existing code may use it, and we carefully ensured the layout was
+the one expected.
+
+We also suggest avoiding bitfields even in structures where the exact
+layout does not matter, unless you can show that they provide a significant
+usability benefit.
+
+We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
+for bitfields.
+
 Reserved namespaces in C and POSIX
 ----------------------------------
 
-- 
2.39.5


