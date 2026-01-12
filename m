Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE90C9EC68
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFDJ-0001g8-G2; Mon, 12 Jan 2026 05:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCr-0001KF-Ms
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:40 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCn-0001it-Px
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:27 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso24966055e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213884; x=1768818684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixr5nOWVnk0SPmYmo1QPQQYqq1YV3cCKo8OoOb8Zakc=;
 b=G5ZhiVn3wlCqEC2oqpjUUPTi2zxfVKd5/R+saaL7+fFXYxSsot6xORB/Fb/KKjlEA4
 E//t1oXJJ1hFzbcYZdIe2xQv6UIf5kWjd5Btulj4FewyhanA5/RWBoPk4APbXw6YX2mI
 ghJzXEtn+k0Xa/0W3O6Q4Vn/RiyUTynXALZQh0KWIn/ctz9EQxf+0s2tYVrQp+BsIjWf
 dwRkIewiEZVYJt5F02WqYHD0+dmBb17tRwRCbIaTbTh6JDRWY3csq3pfyhwY3YUJjYmG
 fnE6OGCp+JI6XsRHxIdzyBTxCdRmRKd6sBwN/K/grmBm6/YdR9W2rRhd3Emv9boYBOee
 +kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213884; x=1768818684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ixr5nOWVnk0SPmYmo1QPQQYqq1YV3cCKo8OoOb8Zakc=;
 b=psBNOIitq7dOVvDM2hss2Top5PzkR/RzW8+H0a19bTKTB6SwsAJvnGd1mk2yK272sk
 YB7e2A4mCiOOlt0YcGtULoBJanEQ09vZxPEEP63oAz0fg2I+a2tcJynDwk0hV6CPhGX5
 OAn1zcEdkFtE9LQBBkaVRSHC9BYVTDI9msjgCWdctXh/f9WoOBuTnUYEN/Cvdd4X2SU+
 ZlGpA97WIiyJ/SWWSSDPBv01ONuMB5/qdV71ME6gVXdX02uOn/9vH7ZS/iuDXDfDJL49
 OhuSGSpQ2GphujlEkfBRJy0rV2BdvXpKhH4Z8zBIBK0YIij5xyRYvQ0+KWGc8KTmGYCE
 BBEg==
X-Gm-Message-State: AOJu0Yy7QRki+yEVUND+kSdrcTztaLUGl7aL7heH3NWOJ1ARk0wVgiTW
 NjApINxU0c4MHs5yuT0iJ9PHprFctYr9RUXGpVYeaYxnYYGZasKhJ0Mqi1MFb/mDA4gGRdkVuXq
 AWJ94M78=
X-Gm-Gg: AY/fxX62KHqXFysjgB6e59FM0JzWsenO7kA1w1+3AtAi73P3w9QqPnkjqFP/h73AmcY
 YEmaYxcFX19nuX2sEWnhRXBqBwZxEl2r5dwyevKRLltTqQV3vjEajeQtrEjCCDMpel11MFKRyi0
 7pqw/d95/osPKNsslaVC5KhaLuHUv2Ok4BUGTQ1GrzmNq8D/0GFshj6fZvB9xQLJ3YrPOJaHJjx
 182K7O1iADdxQJwqLvnaQXctHSQZpBLiGHlXMzxRWBZS5aIP3bi1mEBN040GXY08Yge7R5i1rfK
 NH+tOPIYF1Bnvi8bd9RyVR9VPbKEpZvwKcKxqcPr3fZR6+DiGQACkPnegABanIWlcAwsns8d/vE
 IwJKhqYk3h92b2hA8ewR+T5nslN1UKVi18dpkAOVLS+dx/SNilj44Cmv4CIoYfIIWF2LxQ071+N
 4F878qP2LilVKLHEL0MiCFbi7msmA3rByTAP/rZDFXeiAHpuuC/Isg9ggxOCTA
X-Google-Smtp-Source: AGHT+IFkZ1HZfvCYqYvZPXq14TcyW65q3krj93a9Npo3+rwamgqfZyfRpWz/OHrqjztwwuxyVe/fLA==
X-Received: by 2002:a05:600c:8b33:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-47d84b19f5emr178166915e9.9.1768213884081; 
 Mon, 12 Jan 2026 02:31:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm360206035e9.1.2026.01.12.02.31.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:31:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 07/19] accel/hvf: Move hvf_log_sync to hvf_log_clear
Date: Mon, 12 Jan 2026 11:30:21 +0100
Message-ID: <20260112103034.65310-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Right idea, wrong hook.  log_sync is called before using
dirty bit data (which for hvf is already up-to-date),
whereas log_clear is called before cleaning the range.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/hvf/hvf-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index bbb0403d246..3b6b9d6ea6a 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -224,12 +224,13 @@ static void hvf_log_stop(MemoryListener *listener,
     }
 }
 
-static void hvf_log_sync(MemoryListener *listener,
-                         MemoryRegionSection *section)
+static void hvf_log_clear(MemoryListener *listener,
+                          MemoryRegionSection *section)
 {
     /*
-     * sync of dirty pages is handled elsewhere; just make sure we keep
-     * tracking the region.
+     * The dirty page bits within section are being cleared.
+     * Some number of those pages may have been dirtied and
+     * the write permission enabled.  Reset the range read-only.
      */
     hvf_protect_clean_range(section->offset_within_address_space,
                             int128_get64(section->size));
@@ -254,7 +255,7 @@ static MemoryListener hvf_memory_listener = {
     .region_del = hvf_region_del,
     .log_start = hvf_log_start,
     .log_stop = hvf_log_stop,
-    .log_sync = hvf_log_sync,
+    .log_clear = hvf_log_clear,
 };
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
-- 
2.52.0


