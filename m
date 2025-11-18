Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CD7CED63D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQyf-0003Ae-63; Tue, 18 Nov 2025 14:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyZ-0002mR-O6
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyX-00069E-KF
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so23217125e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492568; x=1764097368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SfS43SeyUePcyfLiF8UaeuQZGAk9CfbaaaGpJCmi7Ug=;
 b=LWFLGQRXIsq3bhUbduBzbzlxzF9P8wxx22NzpyqI+9kLjnsiAUXAi+EvfxIFb4fo9/
 9Xl+W/sEqwpnfiFbBKJwO/RpQe3aYvJAs4SsYB7o6vxVtH1iGyxlGKCMOXSu9rGv9Cm1
 Xdd2w8lrs5OMma9eTrtQxhk0FBpcxC8TL5u7vgZj4cAd/ZebMxNptSc7ayuvaKguA5Xy
 wv9jYzymZ8FhoqVKd0h+X1TQl3c6MxPCL1GrwhxPy+P8ISKid19QvBKUoDIXZf0fq38l
 s/Uyj2jglgzyVzbmGGMorTLb1x1OLo5jUy05WF3i+mCtb4oc7M1dPezOmyhU8XTfoy17
 +iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492568; x=1764097368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SfS43SeyUePcyfLiF8UaeuQZGAk9CfbaaaGpJCmi7Ug=;
 b=CB9d/uv8QCYKHpyHx4Bi08BUhMuLuwJqB9t0sirTJDf6JMPRe1LcxE3KOMpKnky08C
 TSomacY2xgufNnBOpzNV5ktTvYXTEv/aMC45D/SQliP3Q71JUbiGQPo9Feqyek/iHmoK
 tm+RwUmU17i0aME81PcR7FOwEsJv0v1msPmlemziVDCwFie4z0iSHN74A+8lodcChaZV
 OEi1I3nt8uPAfLOlCmulLz8zPCcOl2KlpOrxE+bOXKqQz/ko+2w2GgjqVeg/6el9V5Yr
 m7opvsCW4xZb1XHzxtXcwRBbtJUwfaFkpnrzouBf9t1Qdxvk6Ota6H+aOBXbUqnEOGN7
 TeKw==
X-Gm-Message-State: AOJu0Yyc473jzE1UqWGZFGxlpgmAdKkNsKWHFEzAIPCGuVUFYyCJ6yOq
 Oh/eJE3Q73oR66Q00h9olquMAyS9OuaoVFlib2UFFBm9s4JkMe96c3ieBgtJnlymW2JvsX3HaE/
 U59TJxv/Y63NN
X-Gm-Gg: ASbGncug0yADIkdNRWFOrPWpVoxmuDvhcdOG0JKdffKj/Rcw5t31eGH7gILPyYg8vPw
 BEnH5zEhkfOZMWNO98f2GPO88G1z8OudX5nWR9LEXkJjBunoQxeON0hYlFiDCY+6rBcVRTZGmby
 XnmpXdcJc0KFHFq8/fAeK9/CeZuMR0tHKWFae9PQtXhJJwQ36Pk7xt4m2hCZah6lRzNYV6wKDSb
 haMaPLc6YjQwZ5CohpgNKYrxQDmfb7Zn+yZsVIQ1g1SSBXFo2AYA/7XR9owTHpRx49+U2eMDv8d
 M7CorBPbfb+OVjSf62qSACK7wO4qBLkJmAj1wsy/uuHl6t7QRYf8DI5vPdkkfPjfllCk5SUo9Db
 o1/P5BCRLkaFCsR8/SDiL/Dlsjn2wdcgjgGsGJnV9TPrF99P6N8XZFTWi1euy1N2/hJU71Sxpqp
 HrZopN/1mjMDKZor6aFcvJhB1AL5KKH5iAyEFFtrGZ/2SvTYwHMmumVCd6VjnpGB9JzzwYvzk=
X-Google-Smtp-Source: AGHT+IGstbezbsirOy85ASs1DerzzvzIkTRVlysYfMN355uy25DpNWjDxr4hLQ/cgbl5biyBcVMcsg==
X-Received: by 2002:a05:600c:1993:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-4778feb52b3mr154224175e9.28.1763492567889; 
 Tue, 18 Nov 2025 11:02:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0faf295sm6175365e9.0.2025.11.18.11.02.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] scripts/checkpatch: Check DEVICE_NATIVE_ENDIAN
Date: Tue, 18 Nov 2025 20:00:50 +0100
Message-ID: <20251118190053.39015-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Developers should specify endianess explicitly.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251118085758.3996513-15-djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d0f4537f25e..3a9557417f7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3200,6 +3200,10 @@ sub process {
         if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\baio_bh_new\s*\(/) {
 			ERROR("use aio_bh_new_guarded() instead of aio_bh_new() to avoid reentrancy problems\n" . $herecurr);
 		}
+# check for DEVICE_NATIVE_ENDIAN, use explicit endianness instead
+		if ($line =~ /\bDEVICE_NATIVE_ENDIAN\b/) {
+			ERROR("DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN instead\n" . $herecurr);
+		}
 # check for module_init(), use category-specific init macros explicitly please
 		if ($line =~ /^module_init\s*\(/) {
 			ERROR("please use block_init(), type_init() etc. instead of module_init()\n" . $herecurr);
-- 
2.51.0


