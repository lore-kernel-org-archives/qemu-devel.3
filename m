Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A420C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzKh-0001bX-Kk; Tue, 25 Feb 2025 13:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ7-0008KC-0k
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ3-0002CU-HH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so51884815e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506719; x=1741111519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9zEHrLPYFeMG4fULt50R96qgu5RM9N21N5VDqzltXms=;
 b=IiDZ3xGTq471MEaBY3VfhvjA4g1aFEV4aOSjBEXaed0Wxxm+f465jadXRf/GFTi7vy
 L9wRwGW/tWsnogIja2qcGz6Y/zYEKxnzgvlNxYn+1wqcqRxXLcHXxUVH4x9SnJTPncxv
 SQLfNvn0ubW3mWsjPLtqKBXXpK0wCKMyKGiQyW47lhwyUD19HUGC7jd2S6fjhQ9qnFs6
 SvXswoAjGycgPYEp8qYvSKv0jqOLOydYqSgpcVbMf+csVNqaUZyXssAih5ziUG2KG/An
 t237H4Oc0/YaYA9W3ZuDZ3oXicRiI/8H8h/8QlvO8L7zKYXXLk25bSdUY0JW++0TCRcO
 kOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506719; x=1741111519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zEHrLPYFeMG4fULt50R96qgu5RM9N21N5VDqzltXms=;
 b=nRrVGM5RUaq+5NZCyS+meDkMfcURI91xX2aiCQUtpfACA+QJdMzerfb4lIR7KGqdty
 9lb/Pc5uyKssefCYmYCpwbkkN9r2NKxkea93i7SVDDh6XDBJuQI6loW49kGcvecukHhE
 RWtXKQ5+Ol65ooh/Y5yLhifnLPTLAoDyjgQzaWTZXoDOSR5XYT6cGOnJUtC8M9x84N0V
 Ziot7G+eVB+mAPKR9I4dOT7Kw4tReoj4gjbny4YDe8Hk/hWSJbYDI3Ell575KEj3osFR
 bUgKNmu9Uk5c2zGCLhiYDQnAZ2CGxhIn70e44tpXL9wB5q8PW4AevmsJvWpeKS7itb0C
 QV3g==
X-Gm-Message-State: AOJu0Yx630QamGM/VaqBFq0knxQTQnY4qSa6PD1D2sNCk7e/983nBwWH
 TBjTkcl3dCMv0uLB6yG+Uiy3hsgjQCs7wkClADajikbQQnr7ZHnBAjM03EQ/UYBMprSX1MXFNAH
 h
X-Gm-Gg: ASbGnculNlo6ODbeTjZpLaaPKLKxsbjSi6+F5mDLJcj1ZgmhD1f+rNFr9Tl0sV6XqXF
 cKSQsyimYyDfPVR00jRDaRFSHVA1OO2IkNHOEmEUbHkyGnfi1YpGxOzLoP/Ixd+SXeDYsgGtAEu
 K3uWE482u6PwzGcXN4mWLHThUkWRA66MpKdU5etS1OUrGwx+zfdaCYofdT6HiV2dx0YnCPojBCm
 MfrB130xz25YBQ+DGIr8RQ004zvpSYycM+bqnb0kekVAFgNFc8Se+9iK3bIjGRhu9uSybYXg8IQ
 MGpDG1xAtmyTrrCfNL55cuybgUMnENMy
X-Google-Smtp-Source: AGHT+IHae6GBfgySJ9gDDFLlpFl01Xl3vOTKLVvRy8ch/PFQUlfzYrfkLZ3hBjL95p7Buwnid4xkLg==
X-Received: by 2002:a05:600c:1c1e:b0:438:a240:c63 with SMTP id
 5b1f17b1804b1-43ab8fd05d4mr5165795e9.2.1740506719495; 
 Tue, 25 Feb 2025 10:05:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/43] hw/mips/boston: Check for error return from
 boston_fdt_filter()
Date: Tue, 25 Feb 2025 18:04:31 +0000
Message-ID: <20250225180510.1318207-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The function boston_fdt_filter() can return NULL on errors (in which
case it will print an error message).  When we call this from the
non-FIT-image codepath, we aren't checking the return value, so we
will plough on with a NULL pointer, and segfault in fdt_totalsize().
Check for errors here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250206151214.2947842-4-peter.maydell@linaro.org
---
 hw/mips/boston.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 4690b254dda..de6ce1f163d 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -810,6 +810,10 @@ static void boston_mach_init(MachineState *machine)
 
             dtb_load_data = boston_fdt_filter(s, dtb_file_data,
                                               NULL, &dtb_vaddr);
+            if (!dtb_load_data) {
+                /* boston_fdt_filter() already printed the error for us */
+                exit(1);
+            }
 
             /* Calculate real fdt size after filter */
             dt_size = fdt_totalsize(dtb_load_data);
-- 
2.43.0


