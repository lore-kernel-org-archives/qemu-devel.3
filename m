Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BDEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4py-0006Ao-7Z; Tue, 10 Sep 2024 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pd-0004t5-I9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:13 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pc-0004be-0e
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c26852af8fso7610781a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989950; x=1726594750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9b0lTkZojj9hYO/C00YAyDV7juvCe44sJPqhBOockE=;
 b=niRGpHpH5EsrPY1FiN7NDMoDWph4ZgorKU0nMTyg9NN/qfDafzZT6mA5ybPux0Xkdd
 aZqK3eE/xsPpeNz800wb7XRU+yAcn53j7J7K74xBp0OEJ3DREZdraSUYitJlS3q0Ld5W
 cfkapTyRWJ6lLxFAfZMBrdVqb0QFJXcbWt7DcQ/Ys4yJ4IhEwjYCuiawiRupz7WdNiM7
 VRDYcsYzLOVqyxAmihnR1duT0HT9AhZSmowO6ROrA9b9N3jcbk9y3Wd/rgdsl3OtUenp
 smA6IRkQhBaX0uvrsz7dIYA1O5OKB2zDuHixCSs2O0nr1V59pS4uw1j+EnTObGcGDvQJ
 Mnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989950; x=1726594750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9b0lTkZojj9hYO/C00YAyDV7juvCe44sJPqhBOockE=;
 b=qM60yoVFk3y8qrvq8SlyJRCT55yohan+WEQitve+87XW8ac/Yy3kTJMf1AW27FF4DE
 huQcwZp60PmgMZlWaVl0ogx4YqLbinApXd3NWy3zB0Lv3qTMs1yfRc3MBM6gPPHsizMO
 Bnxtkfdsu8UtfumrnupB0R8CjXf9dmK1wTmFIF4I5my7ZYGBGX4+905qr4tX+GOnHObi
 5/30BCX4PtX372YQWdjhcscSquzGdoOtIVEbr62GrkUb4TeI9BqViSl078jwMPdyjt+S
 W+U90fCsAxf56vGsDaf1LU3yNA7ZhtafHp7NSdTAJHIyAcP8SslCfGjcW9TXWcBtqaFM
 IKYg==
X-Gm-Message-State: AOJu0YxEWHnF8PXqc94LrF8Tn4Cl7cazGIvBz6azkl0Ofo468LHVWRPf
 HH++aTqz1zrEl7rgHicxkKsczNUkt8yZCJKEdpaLqdvCD7Pot1Tr+sSSyS4nc0M=
X-Google-Smtp-Source: AGHT+IGrxVKIESzIJrGE5gev1YvX+OVp+hxpav5vdJTFtBGEDe6nXHUWkOtTnpFiSYZCl8Bivru0hA==
X-Received: by 2002:a05:6402:3506:b0:5c2:60cd:b814 with SMTP id
 4fb4d7f45d1cf-5c3e9630d6emr9848491a12.12.1725989950314; 
 Tue, 10 Sep 2024 10:39:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd76f96sm4438739a12.74.2024.09.10.10.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4B5045FA14;
 Tue, 10 Sep 2024 18:39:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 09/10] tests/tcg/aarch64: Improve linker script organization
Date: Tue, 10 Sep 2024 18:38:59 +0100
Message-Id: <20240910173900.4154726-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910173900.4154726-1-alex.bennee@linaro.org>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Improve kernel.ld linker script organization by using MEMORY command.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240906143316.657436-5-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/kernel.ld | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index 7b3a76dcbf..5f39258d32 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -1,23 +1,23 @@
 ENTRY(__start)
 
-SECTIONS
-{
-    /* virt machine, RAM starts at 1gb */
-    . = (1 << 30);
+MEMORY {
+    /* On virt machine RAM starts at 1 GiB. */
+
+    /* Align text and rodata to the 1st 2 MiB chunk. */
+    TXT (rx) : ORIGIN = 1 << 30, LENGTH = 2M
+    /* Align r/w data to the 2nd 2 MiB chunk. */
+    DAT (rw) : ORIGIN = (1 << 30) + 2M, LENGTH = 2M
+}
+
+SECTIONS {
     .text : {
         *(.text)
-    }
-    .rodata : {
         *(.rodata)
-    }
-    /* align r/w section to next 2mb */
-    . = ALIGN(1 << 21);
+    } >TXT
     .data : {
         *(.data)
-    }
-    .bss : {
         *(.bss)
-    }
+    } >DAT
     /DISCARD/ : {
         *(.ARM.attributes)
     }
-- 
2.39.2


