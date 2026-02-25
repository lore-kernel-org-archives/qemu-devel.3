Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D0CFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOCD-000855-GF; Wed, 25 Feb 2026 18:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCB-00084n-U4
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:31 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCA-0004Lq-4u
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:21:31 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so167182f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061688; x=1772666488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dM94jWZifp9IDQaSplzseZaqejpVI8KTowyEc2hsd/c=;
 b=RG8dTG99BBVLgLplTSmrnWxsBT6XN2PMQOjMYfI+SHow4RtB2ALloqmI5XIcJaLmaU
 Psxj6yePt/t989hp7k4UheOwdBrA8pAChTyihpSxl4EfFPIjUjG1PY6Fv3dBpTYFEDz6
 j2rfds54em6rKCxdN3ENZGUL71oU3I9wqh4MN9zWhcBsJP0tuE0FL3ehrLJxuAQpR8xB
 pZHQ9GAHgZa8n0FhGivkAFz/LcTdlh6obW+Sd/H6Tu8/Tsj50uZGGGoX6UVUqJWnaag6
 k38fHAXPAiiodE4OD5PJfxnWFNVMdZpB9n+BW0xjEUSgquA4hzK2FfT1+HJz2inTz1g0
 +DPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061688; x=1772666488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dM94jWZifp9IDQaSplzseZaqejpVI8KTowyEc2hsd/c=;
 b=nqHx9zAKYzW24wZisP8lVJ4p1l5r9osYxeEf6KeogAOTYyp3UJ1bONOc6RNEfnSgmX
 e+i9lHTFWhdN8Eny9vJxQlpAEb0a+u6Q7K2OM7MqtzHCDgr5KzB2bf/4DcwUIJX3ald6
 txucRmxbuwV3Xq3BeNd/jkW1jIkMjRxVd9nLGDaQr4K5ydKlhFVuR0PgpP3/G0eAsPbh
 RBqv/EfuLcPjmyQGT2HeSb9rSFYBM0LYtm7GZ7u5UB7qty3RtAZsUhJa73T9zVshzAuF
 tRDjpCvhS2V0cIcM7HnBRl9TInlVbYRpmOo/iZEQDmnU1Mw7fjoujKA8YlaC8AgHKe6i
 WHLA==
X-Gm-Message-State: AOJu0YyugRljgurREH8QSd0sCPCAfGq70posZuWfxJXngEsc/e4t3X1N
 WvY8AiuXqDaXVAkntoKpueiCZOi0OBWFQjXopue2rCuICOQifNHKC8QcfyfvhHtLVwjfSFFIwHw
 yk4Vj+OE=
X-Gm-Gg: ATEYQzy92Mkl+obCQTvAYJdvJkWg6fEVBPznnY6HG0+MwaYpEgUpzpmLhOpcBtN5cml
 ObvzYI9M5zP/u9rbbyzjt62ZhH7ROUrQOw6u7pOa3wmSBNRJ9tWR0y76xHP/5W3XIMHUhG/tT99
 c9aEll3BtM6mNjLaqAE156woGSGJRuUtrmuzwvUCeVUieYZ6xinfOnd1pn/yCzBde7W0s9wwGFf
 ecmSsA4Ar8F0yAFKJSZ5N0kk6QQ1xZ/9Mon3UysU+BSFSus1mXQrC87m6FPpqz2IP/vsGrdxqI3
 gq+rOGqQae+bkSzFiqqSy0n8t/vI7yT9tor+r+7FCE6Sb81u+jfEmSuZu44yDCq7BqLrg76hn86
 e5IZaroHOGrEX4unfncsM5PBDncEYvtGyWFgB2rNzhoal8MHMBIkjYs69XIsMHEZRFgCwUF+o5Z
 yG7M3Lh02RgffbyFlskgMkR41uYsjTe9Q4TdgGfYPhirTwmzNlFqvGHFcA0Ai1jx4jIH37df9M
X-Received: by 2002:a5d:64c6:0:b0:435:b755:c67e with SMTP id
 ffacd0b85a97d-439942fbd3cmr4320378f8f.49.1772061688069; 
 Wed, 25 Feb 2026 15:21:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c95dsm41138838f8f.33.2026.02.25.15.21.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/70] meson: don't access 'cxx' object without checking cpp
 lang
Date: Thu, 26 Feb 2026 00:14:04 +0100
Message-ID: <20260225231411.96482-65-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260210173355.776365-1-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4eeef552748..d9a17eeefd3 100644
--- a/meson.build
+++ b/meson.build
@@ -3200,7 +3200,7 @@ if host_os == 'windows'
 endif
 
 # Detect if ConvertStringToBSTR has been defined in _com_util namespace
-if host_os == 'windows'
+if host_os == 'windows' and 'cpp' in all_languages
   has_convert_string_to_bstr = cxx.links('''
     #include <comutil.h>
     int main() {
-- 
2.52.0


