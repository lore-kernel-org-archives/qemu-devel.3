Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FBDC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 01:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWQTx-0003em-43; Tue, 23 Jul 2024 21:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQTs-0003dg-9n
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:07:49 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWQTp-0001um-9S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 21:07:48 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d9400a1ad9so3505543b6e.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721783264; x=1722388064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUPoT7+GTGCB/rwxHsxEdqLi/GCEVozJp9dhj9QBUo4=;
 b=VN92iA0pmGfcSfIMePXswYjoAu1OQXPLheKGvNp7Qm1qUTK71iTbgg0D2CJbnN6s24
 QElhSPd2Iyb1lO479R2PtRVWWcgffvszsO5BGXrqmjtdLlHyyQjiKT9/aGEU9CdZUs3G
 mJrhzf+xLglSdfxBdFhlyf7PQuFOyBmnpn5yPiAKwocWuHd43J2KAmXxgo67h9O/mfDV
 FSqnfXlSFQcQOw3x+axSgShu3KOKhr2BwzwNBhypjff8q0J246P9SdKo/LJRl854CKDn
 NaRMzZFmq41K/wza9TcGMb1lyMWTzjHcja8GBHk9vLdxrrtoBQpMTA4UK5zERzuI3pIu
 uTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721783264; x=1722388064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUPoT7+GTGCB/rwxHsxEdqLi/GCEVozJp9dhj9QBUo4=;
 b=Va/3qVGpc5TvnLkDVtLuJ+VxGZAO1dnXGbZDN6FSHK4WB+c47PMb1VikmmRpue+Ovk
 QQ2UFEklPagilL91XUi/FCQU2lQhSwVlvpkYYlDtrMrI/rOEtC7rtwHFD5QXqUtiiJuF
 9aOXenvuzaaVEHBwtN+K7n5iDoXWvu4zLE0O5YQUbXkxn1aIIVTc5tvPQsRn8xNjCCNd
 usLTiGH+yF5ZBcYvLhJN6GEQAuuFDj9VaQslIlY44ius7ElUHE0jxqk6s3taC5eKhAIV
 EcbLcwTgg74ovo4gJPhR9AvC+BNkBueOszEeoU8vxNOSoQs//IGOzad0FZZdmiee7Le4
 fpaQ==
X-Gm-Message-State: AOJu0YxAjRt2B0WfqYCutkT6nF+my5Q0RA1c1jhL1uDv+sAquECD4IDe
 GFLCMDLbyuVyhjjxuQ1Ba5bsxcQWyI8HqxcEnAkmd1GuhK9Q+W7POMeuEJQOl1KI9IVMbChR+FY
 DmbzoZg==
X-Google-Smtp-Source: AGHT+IFbYVr/2YapyDMJAw0pWHHQ4wos23QHaqfg0nZrisd7G5ty+ILd/5zqmScvwD72dPKtgmS2cw==
X-Received: by 2002:a05:6808:1809:b0:3d9:3f3f:9cd0 with SMTP id
 5614622812f47-3dae5d2d7f4mr17225794b6e.0.1721783263939; 
 Tue, 23 Jul 2024 18:07:43 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0e6c947esm6961093a12.74.2024.07.23.18.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 18:07:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 2/2] tests/tcg/loongarch64: Use --no-warn-rwx-segments to link
 system tests
Date: Wed, 24 Jul 2024 11:07:33 +1000
Message-ID: <20240724010733.22129-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724010733.22129-1-richard.henderson@linaro.org>
References: <20240724010733.22129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

Recent debian cross-linker for loongarch issues

  ld: warning: hello has a LOAD segment with RWX permissions

This is partially related to tests/tcg/loongarch64/system/kernel.ld,
but is not fixed by explicitly adding a single LOAD PHDR.
Disable the warning, since it does not apply to kernel images.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/loongarch64/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.43.0


