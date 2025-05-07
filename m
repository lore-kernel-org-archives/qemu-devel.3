Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5932FC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 20:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uClfa-0007S6-C6; Wed, 07 May 2025 16:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfU-0007Pg-2f
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:47:04 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uClfR-00038u-VB
 for qemu-devel@nongnu.org; Wed, 07 May 2025 16:47:03 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c2c754af3cso340841fac.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746650819; x=1747255619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/N8k3b/sDA03HZspomIHApiPMqRxpbHzeQDKsABlys=;
 b=FlMnNnVOCIqX7jfUFljoln8vbZj46/Mzork8B/0cpu5hl5LYOugHewPkaz5E2VlMiy
 +YiqYLz/ygTeTIRtjmO6IgGicLb1p8hLa+rWvLNyr1cHbpItlpdHZp0Yf4zpUEeFDuK1
 okr5F3+lheMyEnxwLPKqpPIwVHuMyJnyFktH0ytzYwFwBaIrh54VdomT1JXxb6Uyc4k5
 7aoggEw1EcyBLtBnIjQSWtJyKlVKqCWJ+OSmkE/Z3nVQYPssIFqRelnlF3jA6hX1RYHF
 f3C0EA4V1DG6J88F1J7VIlEiIvZ0wbCjZl6FN164KnrLIUtT/d6177NIkKkzMgk2zLWy
 K7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746650819; x=1747255619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/N8k3b/sDA03HZspomIHApiPMqRxpbHzeQDKsABlys=;
 b=xNSVKr8wmx0HP/GaMm3cIEsNSWk/oP8sV15t+ZaOTFNNXhtbE7KB6zXgO5QFQON1da
 yPYOH681kNeZFeKd4vY/G6hK2n+pg2Ew5AORSYvitxXIDpgcQuqqerMdXIadQQoyi4ag
 cBhbdp1WpuNcBS5F15wna5FqO6ro9V80CkuNetlnmO6S3ZtERxDJlvxRqgJ/Qmenjgsh
 jRyyDn7JjE3BR+gC4uDX4cAxFm1KoQyiZCS2FBRO7A1nX0Hu8eUv+55Rh0gshXrG1lOB
 4idxwDemvCMwgFwM0/mn5JSWs8fLke+djJydsMes2+qylyXg+eqKK66VDePlroUmA8Q+
 Cv+Q==
X-Gm-Message-State: AOJu0Yxs0ML4uHfFO7NfKJ259hDP6IIRCvWAtEegYZd7D3gRbJbxCaaC
 MO3eSOq8wQ1Qiq4AwkehkxSArq40mk2xX3bfBuvJTpNIcba7Q62TVMkhk+plMG/ho0GoKZhj7Nj
 WPx0=
X-Gm-Gg: ASbGncvNrcFr6xJF/iW/2HtwRZaz4MeiXyyjtBjCmtYzo9c7gr1/yz7QkPVZVyq4jry
 qQDUo/Q4HWKHb7zXgtXQ+F/44yI111L4QxrUgmk9wTxYnYdmXVu8sNkRvAOliDDaXPu/HsVySOB
 9iglfLtpFOlTv0L0o42eAeyupEEEscjSQ5Sv22rJl3RuWINa4bsCkAjvaGgcGHB384zYdnx8Xlf
 7FJA77IyD+e3SnTfx42PbNarycZMQ/nMOMYwntEkAvZOUoyDikU5yRHbndlG4Hd0JHUVyqWpAHQ
 8+XlcCoA72T3h/ere1ovXtlgoJohJaEC3AgEA651TS27X4EZ
X-Google-Smtp-Source: AGHT+IFzCcqwmOHMaf1lM2/M5wmxFPq+IagYPOn+sasS99jWIL3xB+jjgRkjVVWS63ckpG8midzgcg==
X-Received: by 2002:a05:6870:1713:b0:2d4:ce45:6983 with SMTP id
 586e51a60fabf-2db81400baamr706554fac.10.1746650819363; 
 Wed, 07 May 2025 13:46:59 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbc7d1fsm920933fac.11.2025.05.07.13.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 13:46:58 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 3/3] Fix typo in comments
Date: Wed,  7 May 2025 20:46:26 +0000
Message-Id: <20250507204626.139507-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507204626.139507-1-gustavo.romero@linaro.org>
References: <20250507204626.139507-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x32.google.com
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

Fix the duplicate "in" preposition in a few comments.

Signed-off: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/apple-gfx.m   | 2 +-
 qapi/machine-target.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 2ff1c90df7..8dde1f138d 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -69,7 +69,7 @@ static dispatch_queue_t get_background_queue(void)
     mach_vm_address_t address;
     uint64_t len;
     /*
-     * All unique MemoryRegions for which a mapping has been created in in this
+     * All unique MemoryRegions for which a mapping has been created in this
      * task, and on which we have thus called memory_region_ref(). There are
      * usually very few regions of system RAM in total, so we expect this array
      * to be very short. Therefore, no need for sorting or fancy search
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 541f93eeb7..426ce4ee82 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -350,7 +350,7 @@
 #     migration-safe in the future (since 4.1)
 #
 # @deprecated: If true, this CPU model is deprecated and may be
-#     removed in in some future version of QEMU according to the QEMU
+#     removed in some future version of QEMU according to the QEMU
 #     deprecation policy.  (since 5.2)
 #
 # @unavailable-features is a list of QOM property names that represent
-- 
2.34.1


