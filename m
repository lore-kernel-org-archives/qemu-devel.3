Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3C6C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VX-0001g9-C5; Mon, 16 Sep 2024 04:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7V9-0000b4-Mc
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Us-0005EP-Fj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so39655245e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476853; x=1727081653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXyb7NcpmUG1NyUq2Ba7XIovKN57PGi0mUZtpk0zTz0=;
 b=HOuXcTTuJVilcBBtYm32nGrknUj5JWYdDgjcbs1684MuTX//mgozLWCvRNw1Zg0U0J
 SOzpqUxkfJnsy/Og3M3LvZCIXnhNCD2xS8N67o+Y/GtvGrP3t15bHIZMPkC7gsNil1tQ
 NYqz3JJfydsjVMNwaWUVVUEsbFI/h3UH8Ux0gn8LIt1h1SwEDnrxi5PmFqKkRLQigXF6
 2zPl6Q1bKVS+bGL2yBURQxwUVWeBH7pEUCgbdlgvgxDqxUwAqDHT6DAksPyjGdq0B1xK
 4anrlThj4cxr8jmiow8iYwAW4c7tO4PK6gokGRy/mDf1yFZtpxamm9Rm75IRz/GeR9u6
 cE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476853; x=1727081653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXyb7NcpmUG1NyUq2Ba7XIovKN57PGi0mUZtpk0zTz0=;
 b=RzxZKEdjHpZdr4WGVMSFnN8hJN2rCgC78tjMXvG4TMcX4MGzlq9gzFQrMxFfnjsqA4
 Bci4MXr/V6KDSNUb7oS4V8okL7OSnAwK/NC1qhukzUl4waf3fXpaYJ/KeRkoZk43Ja67
 nan2BCFKdqAH9qvA2CFh9zEmyk36eDyVT0Y9XVdgFTK2xtVzndzsGWm90SoXf9U4sTAj
 mOVLo70VvORkzz6QKPAEuJM4pbv7W5TnxliI8FRhAefhgA2SCwl1TEUnrL6iHSbWSpHS
 6ClC74BD7iScDfys0cZhlcOYSICHVYZfcVst6S7bpuTnl6XQSo6D3LqI+CDWnRHk+268
 KDhw==
X-Gm-Message-State: AOJu0YxEBLLEMiki7fDSMHFlCVxFGmx+dSRzVBIWTJ16/zVGSwW9Dc3G
 TxP9byv7Md7sQ/aCTBiZhDCkI7VaKsoA6gtjBAILVH4PourKtsyKubSCmYih5Xc=
X-Google-Smtp-Source: AGHT+IHAcU59Z9L/lxeAqUYOsbyDshJpXcPuUE/cEuLbb1SV2B9zOPbq0GOrt41b3nrW5wfdkQ/d+g==
X-Received: by 2002:a05:600c:1d1b:b0:42c:b555:43dd with SMTP id
 5b1f17b1804b1-42d9070a3f2mr112008505e9.3.1726476852466; 
 Mon, 16 Sep 2024 01:54:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e72e49bfsm6609974f8f.21.2024.09.16.01.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E7BD5FC7F;
 Mon, 16 Sep 2024 09:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 12/18] tests/tcg: ensure s390x-softmmu output redirected
Date: Mon, 16 Sep 2024 09:53:54 +0100
Message-Id: <20240916085400.1046925-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

The multiarch system tests output serial data which should be
redirected to the "output" chardev rather than echoed to the console.

Comment the use of EXTFLAGS variable while we are at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - don't remove EXTFLAGS, add comment
---
 tests/tcg/s390x/Makefile.softmmu-target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index f60f94b090..be242ba8f1 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -1,6 +1,7 @@
 S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
 VPATH+=$(S390X_SRC)
-QEMU_OPTS+=-action panic=exit-failure -nographic $(EXTFLAGS) -kernel
+# EXTFLAGS can be passed by the user, e.g. to override the --accel
+QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output $(EXTFLAGS) -kernel
 LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
 CFLAGS+=-ggdb -O0
 LDFLAGS=-nostdlib -static
-- 
2.39.5


