Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2BEC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl5P-0003ZS-10; Mon, 11 Mar 2024 15:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4u-0003OC-4V
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:59 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4s-0000Mu-6R
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4133027fa88so3709195e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184368; x=1710789168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9cpC5ONUmKADFIo27SY4dOLo7q+xMFpYIDvQ0gC/LpI=;
 b=nB6Elw1yUAR/a432EzZmxNSWbh5LFnETGOuWQ1wI/NRqv47ZAUn6z0ddafEEQeVBQ+
 IpMR1lPobpYqSB5+gCTAsElVHUwkvYL/PFZAaMbjlvkZBcOhEzd+eU6qjOO4pjoic+wB
 QAL72r8PwHrmUUikLMRfNVD0Utr9pe+qpHJcvQ85+TXsE3Q96+SJCptzzDn0iGLfJjRP
 biAO78VoXRm2ksvOsrwFmsjbJmD98rgeYd+a4yUFRXbCUga0K/gwFExlDjNPIwyJWdM6
 awLkV67AKhaB184vmBs+yhbmjfSPV6/0gM8Fqn4YeUR0XsX7snFTlHCrF7jEVmN7oGa7
 V21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184368; x=1710789168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cpC5ONUmKADFIo27SY4dOLo7q+xMFpYIDvQ0gC/LpI=;
 b=tNj80eVlWHdeHv5mT7umjpqHnYSpnuLiS45njmgdaonwfIoOFIQc29PWL7hhsGTm9v
 +EYJqexqf8mss1mXadf7cX1qu/d6dhIbraNzgT/27EAZEbApbHkCKXx6zQxjzVxJst0T
 X3jrc9NTcHp6Ix0XrfwIOTz+wQSIFbfBNDL6pXIwu4hDM+kf9mjnSDSnbZDVamORhD08
 wuE+Ruej+UQNVJlzvUsPvl2XBKjmfNTLU839sAr6Hky5E4ZhMIk5EhBCC/BBPcrlacWZ
 Php31zFcWoz5KZ0KP3Odz2/xFNLitkOkNUA+50e79PY7j94WPBGQ0C920di/jjLvo5g7
 7C7g==
X-Gm-Message-State: AOJu0YzFrGzlKt1M5DkNp7JW8fYbda340omoNdDOtOFvWEOn+gwh5W97
 tWmH2WSvVnvmTLoi88zNw3nt3Zd3CdWeVe2n43gb8tzpLQ/4Nu4iFyDpdOQgxhf+fw8dt7qRHLs
 0
X-Google-Smtp-Source: AGHT+IEcZIMnyPSb9ur5nMZWc4qywIH7Fssyy551bjDZJXeWlN3KrHX4ALl37OfS2F/U08bE2PJ8MQ==
X-Received: by 2002:a05:600c:4591:b0:413:2a9c:6ce9 with SMTP id
 r17-20020a05600c459100b004132a9c6ce9mr1030978wmo.17.1710184368376; 
 Mon, 11 Mar 2024 12:12:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] contrib/elf2dmp: Always destroy PA space
Date: Mon, 11 Mar 2024 19:12:33 +0000
Message-Id: <20240311191241.4177990-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Destroy PA space even if paging base couldn't be found, fixing memory
leak.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-11-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 9347b0cd5a2..32dc8bac6a3 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -549,7 +549,7 @@ int main(int argc, char *argv[])
     va_space_create(&vs, &ps, state->cr[3]);
     if (!fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
-        goto out_elf;
+        goto out_ps;
     }
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
@@ -634,7 +634,6 @@ out_pdb_file:
     unlink(PDB_NAME);
 out_ps:
     pa_space_destroy(&ps);
-out_elf:
     QEMU_Elf_exit(&qemu_elf);
 
     return err;
-- 
2.34.1


