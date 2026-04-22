Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50F9FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkS-0006Ua-KO; Wed, 22 Apr 2026 16:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdk6-0006Db-5R
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdk2-0001c2-Ft
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so54513085e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888008; x=1777492808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ybutfhAkPVOtWuNrtaRdGB1IFne9rrgt1gMWcuzTPkA=;
 b=PsdYsU6tDmBGTwjB/A5PAMXDrT71m+UzziuwNXXM91RCw055I7V+/HflhA+iIgsr4X
 3xtX4wnKAxZ8B2EsJSmyM3LZiaMon5YTWINpaSfblBWoL3VTP4xCrXM19X88y6+p4+xN
 qW94bHt6RUGDK1tCdjsE05G/iJAHeduyBYCwf9GLlyOWiiHFC5rzgz4H8fCV7/qHVzgm
 fdK4XFbJj/SNxP5Hkvvfw0Y1RrDRDzq70tcomCHiyynF1XSy4/xjduRr7VK7lbCAnAob
 KRBMfJJ3YsREkuwNZ+iuhvZ7QjLAGXK3002BEe0NQ0FOFk9BkXJiPIbWX9InoJO5gKj5
 N+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888008; x=1777492808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ybutfhAkPVOtWuNrtaRdGB1IFne9rrgt1gMWcuzTPkA=;
 b=Gby5EOJ/dlDhzxkpfhaKuIN0ez+sXcBsKmLkRZ+e9gYlP1vWmhN+sq8avPKHK20HcI
 rigVlS6B5ipbrVp1/xDW40boKqzfVewPMVDAn3WuebXYTZXEMEtNMLxIIo6/RcnrndzK
 RoFJyOMFPpyCpm09R4U58XOLr/J+AS/rMcVXGJpO4ckMnym5jcdTkIXeur4hjlYcEAPh
 COitcRzCBX45uA1lWeO6aFpmgonHAxNCA8DbzcUtDs9BjXQn5diFdS1PiR/Y0WwwewAQ
 Tr70fAjuvJ6zJFvEoC/nWDlaNZMcCRtHf2aBOC3yYm9c+1l3a9dQYGMfhg3bAcLw7HtR
 vu0Q==
X-Gm-Message-State: AOJu0Yz9zEKI8W9NTX6+n0QXCsf9a4lCkvVkg/yzdX7a2l3opHM9Wsr4
 ZsQgg7+R6P1SH1FApQbH6q5pr48PlTyzTMj19ZaRY3DOj0p+KYhj3zgd/XBpYw7ml5kCu3uTS/2
 JGxfgh28=
X-Gm-Gg: AeBDiesoxcevrQbVsT0ZiMCUUMlkfmno0BOtSO1o9Ocu0OEk5ci1xQZvj2VxHZu0LPy
 rVYnJRl9D9hdy8YB/UuZlnCtOzbf6SnexcPEGWmrFlACA4BKYeUHmJQgc4TekMzmxsuePDePW8/
 0gRWcWbhxuo2OjkWdaRHV3SFsq+TxwVyhIueGolki1qoc7G47xBWCxzivyye4+0q4CeLsyYNWnA
 CMy5L4WhaQ0sKsBbr13MBt+nBH8HjUTeXaFhCjfjPTH98plvFH68JFcicHLQqJuTW38Z3YBKnOE
 nytEdAaYchAGbzPbgvFKbyIn7k90I6lSdE/A7VygWHq7SaTUFc+s/0+mjedxEe0nPwRdU3tVPTN
 d1X6DW1Cn4Wp/mHCk4lp1+Jdjx3WO039e9Wfyydcz7rNkniRESQTmgNvYWvpcPl+bXWZqnoiewY
 MRtrGBXfg+6i6P4GNT26NC+oECpYTaqot6eMgF7+D4gP3awI7VGMUx5gj3dse7ILZ+vX7sLEBHb
 hSHhH7xOa4=
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-488fb784843mr263573585e9.24.1776888008437; 
 Wed, 22 Apr 2026 13:00:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52583fe7sm179913945e9.13.2026.04.22.13.00.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/48] hw/tpm: Add TPMIfClass::ppi_enabled field
Date: Wed, 22 Apr 2026 21:57:18 +0200
Message-ID: <20260422195746.88865-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Each TPM derived device has a @ppi_enabled field, itself
exposed as a QOM property. External layers (like the ACPI
subsystem) wanting to know whether a device implements PPI
has to check for the QOM property available. This can be
simplified by declaring a single field in the TPM interface.

Here we add such field to TPMIfClass, before converting each
TPM devices to use it in the following commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20260317120241.16320-3-philmd@linaro.org>
---
 include/system/tpm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/system/tpm.h b/include/system/tpm.h
index b90dd4e8cb0..9458ad6668a 100644
--- a/include/system/tpm.h
+++ b/include/system/tpm.h
@@ -43,6 +43,7 @@ struct TPMIfClass {
     enum TpmModel model;
     void (*request_completed)(TPMIf *obj, int ret);
     enum TPMVersion (*get_version)(TPMIf *obj);
+    bool ppi_enabled;
 };
 
 #define TYPE_TPM_TIS_ISA            "tpm-tis"
@@ -84,6 +85,9 @@ static inline bool tpm_ppi_enabled(TPMIf *ti)
     if (!ti) {
         return false;
     }
+    if (TPM_IF_GET_CLASS(ti)->ppi_enabled) {
+        return true;
+    }
     return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
 }
 
-- 
2.53.0


