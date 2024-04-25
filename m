Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D28C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwtv-0001UA-Am; Thu, 25 Apr 2024 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsn-0008VP-MQ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:38 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsk-00007H-AO
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:16 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2def8e5ae60so4591341fa.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042989; x=1714647789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LU/r9zSSWOAgtXVFmIxCt1qMAeFSfB+B8bTVtMRUbL4=;
 b=WrXR9xds2luym4J6tztK66DnJaf/wuj2yu2EDa583PaxoSFJwEWk1s2L1aNchIx+/r
 bbR9UZz7iFtrCvMuaaKDwy3TZsSwGW9zzUFnkKUtVogRlNYkQ18amTlZR9yb/pPExQ2j
 fjGvhqmzFGItbBbAjuHVlaCBQNbmXskDV7Snl6aLxO67SwCZGLsYvUI6KWzLAQQ/obJ8
 MeQ9254Ek3cXhnTeh1ApAZ9/J5mkzleH+K9rKInF3B7Y1sQ4VXjXN0HdV+sqQ7CRQsXS
 xsVN1HokLi5KiqQA+3m7jZXt90Xy2TAVok0I9hsD2cFYXLzuWsODMcI6TuDobnVQOdTP
 5GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042989; x=1714647789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LU/r9zSSWOAgtXVFmIxCt1qMAeFSfB+B8bTVtMRUbL4=;
 b=nu2s1F0tXocxlkW19Um2yfxIqYJA9NKxfyGXv/B+AQvLbg+7x6k8AufPBtR0/3AswP
 usT0hPoR0qx8jl+L51fCJecDxzd9+/JriR6vcNR8OnB0qklxnf294IAcK6ePZZlym65b
 gAHw3ONgkxcLvkAGBe6zhXfHU0FaXbEMVJgGTXITR2A6wrhC175MtRQPiMz2Ggx88LLA
 QKlg4WeiyFYm4ee7oynGRzYJIo7HqbN2/ckjQjOyu+5NoULjUq6L8gt15TP1MqtPdyOg
 JAOpq7gDBW2uI/zfDaT4Fxvv923evef6gZO4xT2s9rA4vqZO/zIUZbykZsPiF2Oj26Er
 nKCg==
X-Gm-Message-State: AOJu0Yx0dEjt7tKZ93PjPrSS53yX2mzHUmCJGY8xW4J62Ozk6LF9riWn
 xU0Azd2WSeKDZlri3jU+xAwwlI5i2glaLHyzl+8zlFHMvDrqDsa13A5V4y3VguMAyjIqlwTFQlI
 x
X-Google-Smtp-Source: AGHT+IFO8miQl6dbOAeeTD9X+PVLuHZOUwqnZSgopxhCCr33r6EuDuv6CgJsQcLWxILvpMYPwwf/Zw==
X-Received: by 2002:a2e:954f:0:b0:2de:81c9:14b3 with SMTP id
 t15-20020a2e954f000000b002de81c914b3mr2837508ljh.35.1714042988935; 
 Thu, 25 Apr 2024 04:03:08 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c511400b0041a49b10a13sm14955302wms.11.2024.04.25.04.03.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:03:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 12/22] hw/cxl/cxl-cdat: Make ct3_load_cdat() return boolean
Date: Thu, 25 Apr 2024 13:01:45 +0200
Message-ID: <20240425110157.20328-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

So make ct3_load_cdat() return boolean, and this is the preparation for
cxl_doe_cdat_init() returning boolean.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <20240418100433.1085447-2-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cxl/cxl-cdat.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 551545f782..b3e496857a 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -111,7 +111,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     cdat->entry = g_steal_pointer(&cdat_st);
 }
 
-static void ct3_load_cdat(CDATObject *cdat, Error **errp)
+static bool ct3_load_cdat(CDATObject *cdat, Error **errp)
 {
     g_autofree CDATEntry *cdat_st = NULL;
     g_autofree uint8_t *buf = NULL;
@@ -127,11 +127,11 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
                              &file_size, &error)) {
         error_setg(errp, "CDAT: File read failed: %s", error->message);
         g_error_free(error);
-        return;
+        return false;
     }
     if (file_size < sizeof(CDATTableHeader)) {
         error_setg(errp, "CDAT: File too short");
-        return;
+        return false;
     }
     i = sizeof(CDATTableHeader);
     num_ent = 1;
@@ -139,19 +139,19 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
         hdr = (CDATSubHeader *)(buf + i);
         if (i + sizeof(CDATSubHeader) > file_size) {
             error_setg(errp, "CDAT: Truncated table");
-            return;
+            return false;
         }
         cdat_len_check(hdr, errp);
         i += hdr->length;
         if (i > file_size) {
             error_setg(errp, "CDAT: Truncated table");
-            return;
+            return false;
         }
         num_ent++;
     }
     if (i != file_size) {
         error_setg(errp, "CDAT: File length mismatch");
-        return;
+        return false;
     }
 
     cdat_st = g_new0(CDATEntry, num_ent);
@@ -185,6 +185,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
     cdat->entry_len = num_ent;
     cdat->entry = g_steal_pointer(&cdat_st);
     cdat->buf = g_steal_pointer(&buf);
+    return true;
 }
 
 void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
-- 
2.41.0


