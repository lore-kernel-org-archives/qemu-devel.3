Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7388AC3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57O-0006ep-Hs; Mon, 05 May 2025 19:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57D-0006Sw-JG
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57B-0003es-M8
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224171d6826so73674935ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487248; x=1747092048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEdUza85WO+DzwzEMeWL7z4M0hhaS2RgQrae4P4VTDk=;
 b=vJMuj1K1wfqBPSSUiWnkvT+yN67BKsoHG24Lf8eOwvLAHZRgtviKRs8Pv7tvXnRyRE
 b6TLYxDptHMSAaSy73SByuwLdOrVp5EhWk+YK3ehd4rNex9SsKzdfOpvji4SWkBEDZxM
 oItXhI0a3KuqbfpiIAt5aSHr2zEGVfW3INL9aSQt2kLLXAv5m872ZDA8BWkYXbUCgRXs
 PKTdxYGGytVyZ56xSmSkGxB5N1e0DNMV1gkvWAouZ7oyVCQgd68RVUmNdE97u5WKQLiQ
 gV5z1ABLp1ak8yEdKF765UvCp9Hrfoj6FM9zUcTBpLhzVlOw+TBzF/J7PldOVOpaZCDm
 SA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487248; x=1747092048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEdUza85WO+DzwzEMeWL7z4M0hhaS2RgQrae4P4VTDk=;
 b=wnn98lrCruTIgoV3CNmImgZ9B+aDNtmf7Lwx/BV9UMkhHYygJbiyy7b0WDEe+C5lGv
 jvZXY9Hiqx2pffg+geqPeZvUHHxvQlggFerF6kK4CV6PMjuNcDigEmkaHSOzNhJYAne6
 WDiF33rmz580vJG9TiOFtvA9vmSWX7v8kNtT0fnf4kEZHW/KmrIFmYnegtePOcP2N461
 ev5rw+FdLJfWFfuzlyy++euzxBq7POEGiUqVPsOzsl8EwRB2DloU81WQM8amRqL2YKhE
 OfN9mu+GrAJQgIpIJIr+WlWB1AooSCE7mIruXeDWldEdOg3D8B/sTe53Ok+qKbo8wiHk
 Ys1A==
X-Gm-Message-State: AOJu0Yxt97ZUhjBpggl6tTLqPyOHSffYx440rjgyUErmfKu1cRvFyFh9
 7flzg9ExI9aPvuBHuqK6st4nOmRV0vRaNmnj5T0pzYiSqi7gMCeuKDxOCWbeIFw+D5wLBbcQ8uA
 tZzI=
X-Gm-Gg: ASbGncswnTrSoLwAjDXU9peELWgHaKIIDx5Z6XuxZqAoIZk4CNozG5kQs71Yp6oAwWs
 wE7kAiyjuC/PtviNwQ8dpqlLYTyS3ydqRiR/Y3fKz1QWlORzm99AQ0pFTBcQmCvPd6Psg2Z4GTw
 4vMU4WyVB6pcSUnHihTMItGGgzC6IoNRipKj37aLmzYSLal6EhrXyQbi+RFjUPhqbIHsG7rFzGJ
 24RnO1BQz69Fbdw4/Ij4RS6eLqCcaLiMv6NDMkFqA0I2M7/n3cDJ+kbah8o0hCMnMQFITjqKBi8
 Tchfg6EwclP8MVoTb+s5jMIMssDtMVtPWpkp6nMV
X-Google-Smtp-Source: AGHT+IG1jiJQxBbzAHV3mqZ6REtUe8lv1QX9zvdPySzs6EmfZn2E2GCfq+CiMq6MLVUXpnJYHzmN+w==
X-Received: by 2002:a17:903:1a8b:b0:224:1acc:14db with SMTP id
 d9443c01a7336-22e32baa0b1mr16580805ad.29.1746487248068; 
 Mon, 05 May 2025 16:20:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 31/50] target/arm/ptw: replace target_ulong with int64_t
Date: Mon,  5 May 2025 16:19:56 -0700
Message-ID: <20250505232015.130990-32-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

sextract64 returns a signed value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e0e82ae507f..26c52e6b03e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1660,7 +1660,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     uint64_t ttbr;
     hwaddr descaddr, indexmask, indexmask_grainsize;
     uint32_t tableattrs;
-    target_ulong page_size;
+    uint64_t page_size;
     uint64_t attrs;
     int32_t stride;
     int addrsize, inputsize, outputsize;
@@ -1733,7 +1733,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * validation to do here.
      */
     if (inputsize < addrsize) {
-        target_ulong top_bits = sextract64(address, inputsize,
+        uint64_t top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
-- 
2.47.2


