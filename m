Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8545BCF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 14:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssNdV-0005sg-Ta; Sun, 22 Sep 2024 10:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssNdU-0005oh-Tn
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 10:32:28 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssNdT-0008UM-E7
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 10:32:28 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c51d1df755so30127876d6.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727015545; x=1727620345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e36ZfoJHjFKyIPloG9KFhoN84Whs6fQqjPKWB4YXiC8=;
 b=fTCuOerFdUm31MD/1Y2TrDbpYWyIiYYjI6uNcg3OUCKArksex6UFi3zFy8Z7tw0sCU
 X7IP3e42UyoZNh3pP0IuRI3Fi6OGaSYTj/NKc0QvagxDRJPSiM2rqx0EutHrIcHHw8b7
 1kLvp3YjL683Cgd1iOsvm2pMbWJUWuZhDBmrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727015545; x=1727620345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e36ZfoJHjFKyIPloG9KFhoN84Whs6fQqjPKWB4YXiC8=;
 b=ZvxOG7qVkOIOee2Agl+jbBQ1MRMX6Hq2NJf4dwNwVnEMGexdK8MWhUAzpzKUpA4Bxp
 UxmvVmvufzEp86Hj/z3c5RDBXCfFgLONUiftkaWaMv37fpFR5tgPRiVs01nUZCS85geb
 SwIBUVt73i11uktSgaiwnd7GaNvbiLg3L5CRjnr7y+fspuRnGwsegYYBjKNb7WCf0mDD
 WyJpYUcO25CEgzfmXN3xg6AxL1KUYPUwmphDDtVcjYptLl/wP/VglswhR93uiMQP9f7n
 6rtw2ftIE9jg7BShFWfdHtNuuWj1C4Txr1WbtIniIKy5W1tHLB4VnxMvRy8lbIWMVpxb
 FTww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT2Mk3k/4x9xR0CiFMcmT64+/q/xGnppQuVV+UxQs/be6MmSUy3GKTC+JVlWcLn1HReVCDH0HaRE2S@nongnu.org
X-Gm-Message-State: AOJu0Yxm+W8ukxHgpWWPP6FBeevSpzR631HNG28NDMwO1CLftqxdRUSP
 qNenFv/bR56cuef287fEa3K5HDVZ6GdTq+nwKjGWEEhXlq5Lvi9OADQWtubI2g==
X-Google-Smtp-Source: AGHT+IHnOG69LdDdnXzyx3ecdQUNZvX7KRasBG098wYvvMHQHfnDcBtvGkEcTDVkVgYiNZgI64DPrw==
X-Received: by 2002:a05:6214:2f83:b0:6c5:4f37:2b51 with SMTP id
 6a1803df08f44-6c7bd51f466mr172603916d6.28.1727015545223; 
 Sun, 22 Sep 2024 07:32:25 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e557d6csm37956366d6.98.2024.09.22.07.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 07:32:23 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 2/3] hw/i386/acpi-build: return a non-var package from _PRT()
Date: Sun, 22 Sep 2024 14:31:10 +0000
Message-ID: <20240922143216.662873-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240922143216.662873-1-ribalda@chromium.org>
References: <20240922143216.662873-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=ribalda@chromium.org; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.129,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Windows XP seems to have issues when _PRT() returns a variable package.
We know in advance the size, so we can return a fixed package instead.

https://lore.kernel.org/qemu-devel/c82d9331-a8ce-4bb0-b51f-2ee789e27c86@ilande.co.uk/T/#m541190c942676bccf7a7f7fbcb450d94a4e2da53
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 99cb2c6c7b ("hw/i386/acpi-build: Return a pre-computed _PRT table")
Closes: https://lore.kernel.org/all/eb11c984-ebe4-4a09-9d71-1e9db7fe7e6f@ilande.co.uk/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 hw/i386/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4967aa7459..e7db51afba 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -741,7 +741,7 @@ static Aml *build_prt(bool is_pci0_prt)
     int pin;
 
     method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    rt_pkg = aml_varpackage(nroutes);
+    rt_pkg = aml_package(nroutes);
 
     for (pin = 0; pin < nroutes; pin++) {
         Aml *pkg = aml_package(4);
-- 
2.46.0.792.g87dc391469-goog


