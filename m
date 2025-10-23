Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFE3CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBttq-00079C-4H; Thu, 23 Oct 2025 07:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBttV-0006qz-2b
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:54:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBttS-0002h3-M7
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:54:12 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4298b865f84so286816f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220447; x=1761825247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwdGU+8Ecc8JQqbY944iaIzcFK2N7jYfLXWaVKyTPPg=;
 b=XkuuBFxUFFNqSc9997pD9XCiCmTOfJxVpcuxXyAOWFbMjDI7dmj17pj9QkYv09nFQI
 HgwFNB9jNTl1skYCFWmR4xUDRUO3DHvVwfzezMxgl/xlw0kPQRkLK8HVX48sFlez6JsW
 5NCPZiyAo5nW3HveG3Godx6gQpvUSXvxO3vG51T5O3ATWxZVm6fEydg0TDgyhCkzsvqr
 iAuYB8ZHixbLnelc5YOdj7Dx1K2Ga9jzKQJqAv1DRDt26a9z4mQZhPrXiJ5yoFc4872r
 ZFcgUqqCTLyK+YAr0ZcrC+pSnX3FzTutDE0UID3fHjDc9eQHv6U1HZAD+/+HGCnFWtO8
 mp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220447; x=1761825247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwdGU+8Ecc8JQqbY944iaIzcFK2N7jYfLXWaVKyTPPg=;
 b=GKUa0FVsNqFTyf0/kKt5lKM5SdTReqoOJJ63X4qvh7hWFF3plfgcSRTvqKCVjDk2QW
 9zvxQmWGU18UDU0dmdg+I//lDi29DR+vS3DB3Dr7T9+Rzdb/iO+XCYVK4GVvkOEFpY86
 zJe1plt2xyCL/OJDnNF/r+Y0mnTudkXUtodPME+OXZHEkkoJ6R0jlcGnC02kyOkWswi8
 NgeYrGU9Kcu+DddQA+RLX753XxVdyFOCTW+gMAFT7h2Dme8nPDzTNuVuKmybq3qZiKe6
 tRJDdgWTyYKaOgLxmovUdKKH3anWNnnCKHuzOk1RAoquEtFl3NakluGMOSGlp0yRo8Ob
 GXww==
X-Gm-Message-State: AOJu0YzHBI1xD/oQchhDW2rxtnCJ04eUfcGinO6d6z/3z97h/I8LbQds
 PFlcA+YiMaxF3CwWn3+tXIw7uzTTiOQVlsaMRIC93SGF3XqlHxtXbylsopEjgNQPwVdAjR+oeRj
 QRrS31L0=
X-Gm-Gg: ASbGncuIXL1Esn+fPx36AYdG3ahBFor4zLT3jqQYmei8esZVy8inEuvrjUimIf+UbTA
 cz40An/mtAJ8286CyElg0MfudXj828qIdAgGgxotu57PkZy3DSiKon7dnXnqDiPoG5IMBzmP/oW
 aQXyPplTprNITftjLM8bKEockvovpulOAGU9Mh+MKoRURlKOU46vpLm1f0Vw0Ex8etNADo6o9CM
 5X/xBj0Y0rGx8o/b5anm/bNpOzDn36XxvWDHjH9FnXoFQ7syaAMe95iwQERnO+dFRfL0W/meD+7
 g9CTQ8jALv2JAVyv1swI1e36GNnxfoN31cun9pyUnmCDVNxIS87ugzyePR/E857562qLCjiTgRm
 AfPfHpog2TSRIQ/rt+3InJ6rMkKYRBeIA0cKeKAeyN/a0qwa3yWfS3WBC61hRm8z/ra6Q5vfM/d
 9cZH5hfelEYEDa+HN8LHSVUfU6/1FOc34HGTwKmTNXo+0QvXAYS7IBmb9jty72BLsydLtTQQM=
X-Google-Smtp-Source: AGHT+IEyg+aUPhFKlAw/V/LNeN7y+v4DAkNAXRKcFvZ2PKm0nj6AUPECgMCz96ad5W1JYZM9aIcQqA==
X-Received: by 2002:a05:6000:1445:b0:429:8d0f:e91 with SMTP id
 ffacd0b85a97d-4298d0f101fmr95347f8f.3.1761220447443; 
 Thu, 23 Oct 2025 04:54:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897f57cesm3728842f8f.17.2025.10.23.04.54.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:54:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 41/58] accel/hvf: Remove mac_slots
Date: Thu, 23 Oct 2025 13:52:52 +0200
Message-ID: <20251023115311.6944-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This data structure is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 21386acd143..c767e13c212 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -21,15 +21,6 @@
 
 bool hvf_allowed;
 
-struct mac_slot {
-    int present;
-    uint64_t size;
-    uint64_t gpa_start;
-    uint64_t gva;
-};
-
-struct mac_slot mac_slots[32];
-
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
-- 
2.51.0


