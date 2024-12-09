Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EB5E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVe-0006Vi-9R; Mon, 09 Dec 2024 15:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVE-0006Iu-DS
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:12 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVC-0003G3-V0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:12 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so2271940a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776629; x=1734381429;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDfEUP5t3qEfB5+/2Qs/ja/PBzmRbPZf8EVWTjWrIGc=;
 b=J+4JuwqyJBLIFpUlJf+k1RJFDlmTO2jp2tnxbO6P2rE4Cumv1nMMq/EaF0jzwJP1Fh
 Bw57UNf/M8cOishB4aSvIgRoAK7FGI5SOyCObsaSCXolqOTxWC2HRHxF0j61ADmyySCB
 bI9EKk/Weqlr4PNiVcDO2TyTmJuwTdzb9SVe9Stgfz9T8fw9Qu2D7JYM2c439nOO0bCL
 thsaxMtPNkvILwY5z11cG4PzcQw3PYjEfWpQvlpWegq2tR/G5a8XXvFSWLRXgWNzsdJr
 Zmdn+vK6gGHG4pm1NYdOrQq1R0STw+OBPDZyaDhfbLyimVDwrLarGPqlCqPV9LDzI7EX
 xTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776629; x=1734381429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDfEUP5t3qEfB5+/2Qs/ja/PBzmRbPZf8EVWTjWrIGc=;
 b=IF651jSxuXVTa6PIH0JxpVVPf5AIUapt5vVrX5p/nxIF8uWC7rTfVr4eADp/HC5Jjh
 e/eDoaywfF6tUbcnsv5FJ2oydykJnIjmTSyv9ehgebjR0GWDvw/s/FXUfBgXWakQfs7F
 1BLkdx2YyVQjvUYIlxXL8Q7u4PAMS7Qp3pUcTKJnMm9CzMuL9SCoAV6SvTWqM/BOa6XC
 DxRxd9mWXaW+X1C1xlh6+yiOozWap/TdnO7eGvRcRAADLf/WIjz9090m72mO/BJfuxbd
 kUxGTzgMRJPFXK10Eq8bZ5pXMxYj5J2ZVrBKs9YbtoVE6t99BA/m7vIiBP353SAs7bII
 U5Zg==
X-Gm-Message-State: AOJu0YwaRfYB5xLY64JtBSl9fGnz9VwUeKYqPjLC4CWDa0AlcYzJj2xF
 NfDIGoMGueIJM3AiawlfDj3jcjHk8kK8IxQb0NfE1C4PytREkNtNvEGzYLW1Yl6G7FvLJMvBHoW
 3Zg==
X-Gm-Gg: ASbGncvccQVy1G6aWLzKO3+jBAobqw9JUrfubR6KqXsotNxyvo132KBWR43EyfORSPn
 lCVJNHR790jr2wpL68hd4burJJc5m4g0tu4Ae6R+Lfd8czub3dRpjs+oJg/1+Mk0qf9Xyu+FE3y
 tXsW91qoxjBZEKeHUQ1xVM43HtUyUQAa0YAEZC61eZq7yUcJGDC8f7b7pLkz62cFHOz19jnV9hS
 RHGV0eEzwBC2d7CmpQyk19sNiY9Yj43dSs3t7sUQpyy5JPiLqU+BfDJK/jUFQyXrS702uUBEv9G
 HpLRU13Pd2zYHYOabeiqrQcAgYfExQ==
X-Google-Smtp-Source: AGHT+IGezn1JeAQQGfTDfs4KzWxtxZbySAwO0G3EdUJAYJ3BKTlm3vY5tOvZ4e3J/Irwk4yXruunsA==
X-Received: by 2002:a05:6402:3490:b0:5d0:d2ed:ebb with SMTP id
 4fb4d7f45d1cf-5d4184dd0e0mr5226880a12.3.1733776629471; 
 Mon, 09 Dec 2024 12:37:09 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:09 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 10/11] hw/intc/apic: Fixes magic number use,
 removes outdated comment
Date: Mon,  9 Dec 2024 21:36:28 +0100
Message-Id: <20241209203629.74436-11-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::532;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x532.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

This changes replaces the use of an explicit literal constant for
the APIC base address mask with the existing symbolic constant
intended for this purpose.

Additionally, we remove the comment about not being able to
re-enable the APIC after disabling it. This is no longer
the case after the APIC implementation's state machine was
modified in 9.0.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/intc/apic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index add99f01e5..d72cbb2a8f 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -350,9 +350,8 @@ static int apic_set_base(APICCommonState *s, uint64_t val)
         return -1;
     }
 
-    s->apicbase = (val & 0xfffff000) |
+    s->apicbase = (val & MSR_IA32_APICBASE_BASE) |
         (s->apicbase & (MSR_IA32_APICBASE_BSP | MSR_IA32_APICBASE_ENABLE));
-    /* if disabled, cannot be enabled again */
     if (!(val & MSR_IA32_APICBASE_ENABLE)) {
         s->apicbase &= ~MSR_IA32_APICBASE_ENABLE;
         cpu_clear_apic_feature(&s->cpu->env);
-- 
2.39.3 (Apple Git-146)


