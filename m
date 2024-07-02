Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4003C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZht-00017z-Ae; Tue, 02 Jul 2024 05:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhn-00017F-23
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhY-0006QB-9V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:42 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4256f102e89so26449405e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912083; x=1720516883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2posFVIHwJJjgAbr7iDjUeWrApT5m+MP8zp28Zi0QY=;
 b=wnU6ueupR7UviJVu5I+ll/Mp37YvmIKMeTcxNrwzSH7TGnw+1IGYWx9bI+rbMdLAqV
 /orqb7tba2FmrNvKCyjuaDDcDmso0epaamgDmJB71BNHkQIhD3ufkd0HaPWY7lzFcYzm
 S7tbDWA9aGKZg63Y9IFQj9RZrVR64vfLHkPqZYxoNL/mOSfBl5xcAdrXyKpCNTFOBcFd
 4au5a2SrpC8IoNAShFVFB68l1fqra0DuxEVfgxINUWuCdjocREB96RYo1THIBhFr2x8X
 jJZ3H+4lMB7fdTiiJA5LMNrANKBLc/N7zQzrzf8MPobd6H4wyklt0hDEmTfLOsqNM8Ei
 ES4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912083; x=1720516883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2posFVIHwJJjgAbr7iDjUeWrApT5m+MP8zp28Zi0QY=;
 b=KynFcKJFZC39byPyl/ePPDcyBfkPrfeguTFP+1eKZ2ogizbcjIcRLdVVJZZjeZQLc4
 5qO9WVNCLi8mxCTjDKK9mT5/tPBxwxXbS48NX9wiik/NbpNO6P5U2xqgAO8H0QC93ELP
 Ls3obVXswhv9SMRmQEpejX2EqWHOOAIOWjguLaonQM0w9rm+FpCMYiUW6vfsYR0rKd7R
 g+3hN1kC9KPnv5Ui7WulypXlPLCjDq1JNZypLxQ0eszuyJoBhWs2yKSp3GjWUXqwLsaL
 EV+qdQdfBgsasxHbp8KDP+fXF+hOkQM08ucmrCAmDgH1LuxDRLkZwxV+g+pyfh8ZDiXv
 SqMw==
X-Gm-Message-State: AOJu0YxXw+LKmK0iOY/JYACHB7Pq697DYf9wrk067QZ4AKkajpycMJ4F
 O/DryTlN2dHysauPW4VqygNg+CGSNN+2McM7LdLO6iBzh39uXCX1Z6LOi9wob6MfH9cUaEMoLQX
 P
X-Google-Smtp-Source: AGHT+IGte9R6xiYW5SqkLbrW+IB8qetJEeYTqv9WUgIcE2IVzrYUR9SueKv5F136tgSoL07NMqI+tg==
X-Received: by 2002:a05:600c:5cb:b0:424:a4c1:6ee7 with SMTP id
 5b1f17b1804b1-4257a010baamr52164595e9.18.1719912083293; 
 Tue, 02 Jul 2024 02:21:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a102bc5sm12637966f8f.92.2024.07.02.02.21.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/67] hw/sd/sdcard: Restrict SWITCH_FUNCTION to
 sd_transfer_state (CMD6)
Date: Tue,  2 Jul 2024 11:19:48 +0200
Message-ID: <20240702092051.45754-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

SWITCH_FUNCTION is only allowed in TRANSFER state
(See 4.8 "Card State Transition Table).

Fixes: a1bb27b1e9 ("Initial SD card emulation")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-13-philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 396185f240..b5d002e6d7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1204,6 +1204,10 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         if (sd->mode != sd_data_transfer_mode) {
             return sd_invalid_mode_for_cmd(sd, req);
         }
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+
         sd_function_switch(sd, req.arg);
         sd->state = sd_sendingdata_state;
         sd->data_start = 0;
-- 
2.41.0


