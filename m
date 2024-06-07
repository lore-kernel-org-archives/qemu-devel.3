Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8EAC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 08:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFVRM-0006pz-8U; Fri, 07 Jun 2024 04:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFVRK-0006pE-Ah
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 04:59:14 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFVRH-00029X-QI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 04:59:14 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dfaf512483dso794823276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717750748; x=1718355548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3EKBJ8oPgx6RWyKkHBwS8CUXIUj2Ph4UlirUDin8kck=;
 b=Q6vPflOKtu+tZMTuo18tbVzyIpwCPACu5VNgqRc6EPXq3WOCY4DABV3cc4obWdZLpP
 4BOKbd7jYxsuMWEVPpwq7oFGiBwPPb/Qbep+2kojqzlIONjXFVAGftUuZU8EsLJOY7sR
 odNB+S/MHlZwI0u3EsaCev6NHWj9Aa0CihaJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717750748; x=1718355548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3EKBJ8oPgx6RWyKkHBwS8CUXIUj2Ph4UlirUDin8kck=;
 b=AY0nn6E5aTxVXtiH8cWeV11MZ5Gh4rXeakwCvVNtsmwfU17J34O5TTGZvcFPw1dhUt
 tfS38JNsN5WkNohPJTYnb8bpQINhcoMyNI2Gf6q/JYtZxI/ufU6elmSQ1VocL0KBCfrb
 ksnyCryBgExFK9MXSFYDsxiO+oU0Atmlx6Q0ZPYVA5umC92s0YGxEqUXtS4EcUlg98ac
 1Xqe3xk9/lqj0ySFiVmU4kl8i63khyFW38ifERY86MkHjj6w2dxMAqHatwb654cjqrAe
 e0LrlMi6wNsWXjrF5wslJOh/izuYXWEu/wKUa8yBwDJLLWVZ2B9E7LJUkEkS9rUe/wlY
 vwmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEs2T+omZBNMlPPND2ZhOOcplp+TBngb3gvPWjXTLNLL4nxTaroii6YdMWPJSPZ5BPe9P4YyOUJulIgbgz5JZZlVsXQRs=
X-Gm-Message-State: AOJu0Yy7eNkL2qpOZDTOcuQ8gwzNwRWHtZ9J8jZ5eEY9ZRZSdquxqxVV
 /GNWPZS7gCiE5+A0NEKz+/VBQajx3WUnsl/mqcT9vlwDMja20qz59c1e7tiVIg==
X-Google-Smtp-Source: AGHT+IFxdKKJKFazmAdLmFk3VUfxgFa6MFD52r/5XJWUC7rqjbFnQ2jLlzLnlzF/DrLKU0JiCuZvYA==
X-Received: by 2002:a25:adc1:0:b0:df7:8dca:1ef2 with SMTP id
 3f1490d57ef6-dfaf65bfbcemr1785533276.34.1717750747946; 
 Fri, 07 Jun 2024 01:59:07 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b04f989461sm15259936d6.77.2024.06.07.01.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 01:59:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 1/3] tests/acpi: pc: allow DSDT acpi table changes
Date: Fri,  7 Jun 2024 08:58:56 +0000
Message-ID: <20240607085903.1349513-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=ribalda@chromium.org; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..b2c2c10cbc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT",
-- 
2.45.2.505.gda0bf45e8d-goog


