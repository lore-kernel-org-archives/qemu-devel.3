Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86802FC616A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4q-0006w8-Mt; Fri, 13 Sep 2024 13:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4l-0006Zh-VB
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4d-0005y6-Sl
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:18 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c413cf5de5so3000398a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248430; x=1726853230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsHs41jQS6tBRZCgUdTKbBtzyuLG6Q+tQiFLGPFknkg=;
 b=KDI3uMmA7d4T53D9UFIX1baVVjMi5AJjM7nfZWJl94KrZexKIwZo65CBVEgHKePH+f
 GT3ciE5XhhQdkwknJqcwc3pvXOIqnrRhzwRiS+KkXxd/dcE+cF3+UxeHAHeS7q7I1iTk
 /Ow0k/Hl1tDrk+dECvBJFbeqh+aTxNdsXSH1NHoav7JwYVNVgQbhoTWILKW7zTM4wvFD
 TucmHp/5qYkLuuRUJqr9EG6/V0izeiEtf2W4rE636/ngLbaPoaNNeNI69Pk2hElmNCNw
 b5/lWL0LKp4Klbp0RPDeNGKJDS9YYzwbKBeZ813jHpLshY/P4iftrRNlu0RxZXfSRhC5
 bOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248430; x=1726853230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsHs41jQS6tBRZCgUdTKbBtzyuLG6Q+tQiFLGPFknkg=;
 b=kJd0ns44TT5U21gA6kJ2wiVwNvenSHBIPU/TCd6S8VmhdldOfQ51B1bkDd2QG7mHPy
 6ApjDB3eHYalh577DQlRqiNliRDRCL91gRUCMc9zpEC+Z6aiPZSoj2AjMZv2m0tc0Nx5
 RTq/89TpK1QIhd5WOUUC2ZZjKtODZ9HKXJvRCJRFFit9mhN4NHi1Uycu93uHHM/whxTw
 PhVEBlP4fhrYvUpdzgJyQhRNN9uuqpZaNrkgSQswjAG3Dx6Usxqzt6eiu1sV0tQNgeJ2
 d8x30IYmwPfuYtzp8uNYQNFMcjJHiktcEeH4P69c4KYOfbF2Dyd/IZXZmX++YXR3MBP1
 qWyw==
X-Gm-Message-State: AOJu0YzDTb6MPvv+4ZkR3Kb80Ctlxn5y/EXIvHK9gdaeEE/GYz0R4SjU
 Q1cVhq2q18G1BMHb0OwlgBUA8GGhDs1yOeFAA8EJ1g2fK1Q7sfhCrejL7aa7NxA=
X-Google-Smtp-Source: AGHT+IHqVyJ3JQSoQWNi61RlmzVMjIdfrWP4Wq4BnkPWry0yKIGapa9fUqVBKYGCEMTD0cs4s8Tvlw==
X-Received: by 2002:a17:907:d5a2:b0:a86:96d1:d1f with SMTP id
 a640c23a62f3a-a902943a557mr705628666b.26.1726248429541; 
 Fri, 13 Sep 2024 10:27:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d259528ecsm892292666b.67.2024.09.13.10.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49A515FA40;
 Fri, 13 Sep 2024 18:26:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 12/17] tests/tcg: ensure s390x-softmmu output redirected
Date: Fri, 13 Sep 2024 18:26:50 +0100
Message-Id: <20240913172655.173873-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Remove the unused EXTFLAGS variable while we are at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/s390x/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index f60f94b090..ad681bbe40 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -1,6 +1,6 @@
 S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
 VPATH+=$(S390X_SRC)
-QEMU_OPTS+=-action panic=exit-failure -nographic $(EXTFLAGS) -kernel
+QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output -kernel
 LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
 CFLAGS+=-ggdb -O0
 LDFLAGS=-nostdlib -static
-- 
2.39.2


