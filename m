Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE29EC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJK-0006Aj-8K; Fri, 04 Sep 2026 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ7-000677-JX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ4-0006nB-S4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so8927985e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525969; x=1789130769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w0T9nP3ZSanwQugvPJzYFxAP3P6umOfUKD8PBONPApY=;
 b=zhzkUJxZ+fZkk5s6iQ/aD3H/2mZwBl4JMhTv41yJ9HxFtTnhA1BQL8riY3N57BnaOM
 a+QfNckA8XEcY/2WVAmyiRs1Y9Mz9qIpiV40BAZfh3rv/XZaC8MxwtpR6SB8bVOeg0Io
 5GNQ00BQjOx4AUjTxt3SGMlJE/v4FZfot3k+iBm+cW31q6H6sH01AXuPOHjXVz+5/hFt
 PdOZmkSYtDX8oL9oG6T8R+TBtlJzZGFuqqyq9I5315MNWt42UMtVrptzzCDY2tMOMs3v
 jbT/CsRY2varjqU729fK8tQlQhPXEd1bnbkCsNcwAEGA4fTqEYlZZRHtpkpz4EVedgah
 CTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525969; x=1789130769;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w0T9nP3ZSanwQugvPJzYFxAP3P6umOfUKD8PBONPApY=;
 b=Hb50A7c4WhfcLRxonREpbXcu9DqZGYVdpyBx/XsD8sdrRDjAr6PXmePV4O1loSPDDP
 yoPO1Kn5Aii2K/iBGsOKZkAUVFThsam9H5JaPFnfH/xgoNKAqvPi/vVDbjIeWcEYWIVH
 5EtHpWmFYCqLPBS0RYW9FCcWLECxAEicLCBYcG6s+Q7vkSKeJbA2R6C9pdW/t2OVpkug
 W6W6pl+peeS8VkcHj7+/mMmiMhhM/4OoOG00krSF7DOMCSezWXqg8OkcXNsImo0pnUnc
 GIx7RmGTGTWDVWCG5es4hRTpI4ULk8D0fACSHVJcptJepWrvilgGeeoM1nkKDXraTt1u
 If4w==
X-Gm-Message-State: AFuF++nDcKvpKBVVFFMStou6K3IKkbs//Lqq3fSk0d5uIKrmNKlGcDSn
 c0ukzYfkS3F1ZxHCSPtAVUSco6/FNsHTR4laxHGP9YRzlN8lN1Me/BF5qggW/S0mwDk=
X-Gm-Gg: AYBFou3IbQzs6Hopgr+VtfOK1vqEqbrUSkXdX7aWqN6bI5f489r7+/z6OHxbozJYREz
 kY4wpA3C/djqREPPhONCL6Rf/R8RWcmE503oHRwdlmwzP82/RjKXSQw5r1EIuinGcOMFRj/iMTt
 IZ1viq5QkAlsZKIRWiAQ0gA8pCIg4IA2Xz7ie4nOxqmpizxOyYuyuMUGIV1Jbxgny36kj2g/V5r
 +dmdHZTSRhEQhgD0R1WUU1ZA3RtjzFL5+19MKD2ITDxlGU95+Wt8KXeKSRmxOtu4dH3jdh3WPA8
 heWKKbz4C464Veowj1BohIHBqRylrHWV8RtHDtY6ugOtVeCPQPPrOstEXz7jYCA7jDz6nrYTDLp
 i4pnyg9nd3EHU0Kvs9ivCrL58FhXio7ndDgu8vprMZ2S24eX6AmckY98mbzxdEmCzm/RmKLwu8O
 gzHNSW0THjkpEQOM2ZFf0OoY1JhHkb/l7DGNWraXpKaT3mpbNEcSWA1ep2Th2I
X-Received: by 2002:a05:600c:8b8c:b0:49c:e3ad:41d3 with SMTP id
 5b1f17b1804b1-49cf7f4aea6mr55336995e9.0.1788525968802; 
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47b9817sm177187135e9.1.2026.09.04.05.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 85C965F9CF;
 Fri, 04 Sep 2026 13:46:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 001/105] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Fri,  4 Sep 2026 13:44:15 +0100
Message-ID: <20260904124604.2207440-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Caught this since by compiling this file with -Wall, -Werror.

../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘init_test_data_s8’:
../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:18: error: unused variable ‘bottom’ [-Werror=unused-variable]
   97 |     uint8_t top, bottom, *ptr = &test_data[0];
      |                  ^~~~~~
../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:13: error: unused variable ‘top’ [-Werror=unused-variable]
   97 |     uint8_t top, bottom, *ptr = &test_data[0];
      |             ^~~
../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘read_test_data_s8’:
../tests/tcg/aarch64/system/../../multiarch/system/memory.c:384:14: error: unused variable ‘ok’ [-Werror=unused-variable]
  384 |         bool ok;
      |

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-2-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 7508f6b916d..adc7ac60c1f 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -94,7 +94,7 @@ static inline uint8_t get_byte(int index, bool neg)
 
 static void init_test_data_s8(bool neg_first)
 {
-    uint8_t top, bottom, *ptr = &test_data[0];
+    uint8_t *ptr = &test_data[0];
     int i;
 
     ml_printf("Filling test area with s8 pairs (%s):",
@@ -381,7 +381,6 @@ static bool read_test_data_s8(int offset, bool neg_first)
 
     for (i = 0; i < max; i++) {
         int16_t first, second;
-        bool ok;
         first = *ptr++;
         second = *ptr++;
 
-- 
2.47.3


