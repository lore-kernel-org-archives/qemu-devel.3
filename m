Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2684EC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcd-0008Kp-Rq; Tue, 30 Jul 2024 12:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcc-0008GK-Rj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:46 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpca-0003XL-44
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:46 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so76974521fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356561; x=1722961361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeP5hKI1uEP9cOGS+CMSaW0aT4kqda/WdRmJyVhc0Is=;
 b=XUB8zfiCtvxldLzGwKDAo9BDWsOr08IlBLYuTCsFlfj3UwLvxjm45Iceab3hrbTdie
 WzGNdfYgELCEwgD7nKgHV2lSnI4VvLfVw8S2aTRGt0K/3ZO7crC+amLhoSKXXBzrZtMo
 sqY2fsewVH1WwIdkPP+PCGqM/cOUsocnjR5LgRUM55isPyfFPUc3IN6XYkvlNMpsOUkh
 jR2bc7agBcHQBsVSmycEBu8dZZirPGJvznwmZNxqc4/TYBBX2HR2gL6QRinBMCt/Mt8D
 EWIrrIfHcvYEON7gZpVY/R53jE37z8hEKt73x0zG4HgxudoVeUyg6bMQ+hU9Un+VmW3F
 h09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356561; x=1722961361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeP5hKI1uEP9cOGS+CMSaW0aT4kqda/WdRmJyVhc0Is=;
 b=K9vxoAv5leI2StFE57bYHxqAZ9cO1VQbcrxhPPuTiq3RE/xbr5vgGC9Tx5ZMFPRh+0
 F/vK57PQxiMeyyryt10k9RxjbnlAFl6ta/23whBAjnjmpdPMYlZ+Z7gcjScSOfIStkqn
 teBWBCQ8ltJbFjX3sRmiy0ETvCfR7OHPPIOGv8atzBM1i543+hreWFgInXpfVGyZtBQC
 kS3qDPLqmSYPTlNF9XLIoF1jLkH6QpVDmWoNgdUg233PuuQhDF3rcQhvGwBo6z4fBcxg
 90DhJMa+NakNXvMVVoYI+wIyvahi1yrErOkWilDW449/em6yOTrFZZBnnC3RiaETWG8R
 +Cew==
X-Gm-Message-State: AOJu0YxFRZt2JloF36RmrY956/O88SbdVy39b9Gmb34E/FzBDqzivzGr
 XsLY4J2NeGFTT2WSE4/d9xscB3DzGW5z/lSB6Q/uhWvRRlna8eOL+ErHSyfzD8Y=
X-Google-Smtp-Source: AGHT+IE/i9oz5LWVCbUqq06uVFHAxv8KHygOw8JFEdLuh7x4pxkry1e5ia8L9Lmm6bTT6opwJ6FnZA==
X-Received: by 2002:a2e:8804:0:b0:2ee:8db7:47b7 with SMTP id
 38308e7fff4ca-2f12edd78e8mr71347371fa.26.1722356560649; 
 Tue, 30 Jul 2024 09:22:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac65783704sm7337736a12.88.2024.07.30.09.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CBD35F931;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 04/14] tests/tcg/loongarch64: Use --no-warn-rwx-segments to
 link system tests
Date: Tue, 30 Jul 2024 17:22:27 +0100
Message-Id: <20240730162237.1425515-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Recent debian cross-linker for loongarch issues

  ld: warning: hello has a LOAD segment with RWX permissions

This is partially related to tests/tcg/loongarch64/system/kernel.ld,
but is not fixed by explicitly adding a single LOAD PHDR.
Disable the warning, since it does not apply to kernel images.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240724010733.22129-3-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-5-alex.bennee@linaro.org>

diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
index d5d5c1a7f6..6d4a20fde7 100644
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ b/tests/tcg/loongarch64/Makefile.softmmu-target
@@ -16,7 +16,7 @@ LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
 LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
 CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
 
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
-- 
2.39.2


