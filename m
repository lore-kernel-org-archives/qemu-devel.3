Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2791FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8ZK-0005zf-N9; Wed, 29 Oct 2025 11:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Yf-0005Mn-9a
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:59 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003YO-Tz
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:55 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3d196b7eeeso7790066b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753455; x=1762358255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKs9IymYP3ODl1NE7QfWzofFOmRouDqJpq+t2KFOV+0=;
 b=iRUPGe4QX2jlt7BB8JuKB3+T3zh10xOxpyoemn2Jf1mBDE1rjffo1w/1F/c1J5Igx9
 1z2swUFbYc0n0WLdyHc54CWcX9+MsAaO2ItsFD5aX6mokVyzgkz7lwobtEbsriDKaZ09
 ZSYaO1b69v4ZjGv21WsLGRupCcJbJQOZL+S+QXk8F9OOGBCPAN4qLALLtbsC/okbq7ZA
 vNa9+IM6WbqMfqCyiKJ4bSI2arUOh/e0grjEzeVM07Bqj4CgEabipTeg+2rpFAjFX+7O
 XSJC/tbUUW3Jq2s6VuGPPa/eE45+SxOoQCZSLrfVia/UO3fdRW/L1T2Mf2+hr4LvpBin
 Qc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753455; x=1762358255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKs9IymYP3ODl1NE7QfWzofFOmRouDqJpq+t2KFOV+0=;
 b=XXqREOpEyiy9VU81gb8Iq9i1YnvtD0CPFlzoZcQU/oFKxsL4Vj5Ju9HQFmG+WoCKl9
 iZWDh77ObVdehySy6zg1HMbadolUmnakgzTlq8RUWnhRf/aqTHqN02kvD0bxwluRj+LN
 XPYgu4nSfe7ZW/efP3UkSDIJPtf6mqvKIRWVIo1MT6xwxioShgOjF6Dw/5CCU4rUJHD2
 y/vATHUJ9qc2MuxkRoPBUw8o83toad+/3OaFmzn1fG8V4MdU9IbnU8bPMcN7OHL0rAfG
 aVRK8RQvYihk3WtTrSwRkzNCPDTzRqQqF+mdFvMGcDMdno4vhYoy4dSnBk5ynQG59DkY
 jG3w==
X-Gm-Message-State: AOJu0YwNir8dTU/2rkmlLz0WISmlIVPaJMG/45yQCl008kBkS7tM/iXM
 +clXV+30vKwfElvpJb24zJFAE9Akc/TTt2Q0AuFomJpa57UZrZRJJEmOvC7c7FVFhq4=
X-Gm-Gg: ASbGncsW+lOtPbLEV+rZy2GiLJNB2OzLJGM0OMTbuNtoeuYX5jenKwfz8dEr0BORrso
 7wybDyNE9bwGtMuJu/2klU6bghwmKPkydnuskYeo+eXOuJul/JNiM6IWypcZejZFsiNX5cmNMlA
 ccmLHYScVeD9xMruNCXxH4tHeTDw8DeR7YM+0RFcVh2bbBiWKvb24AgiRrevOgfN1LGpbq7uy0k
 rdRXUIf75rs25AhQECLciQ/reyXVeGccY+La8/8Z7bB0+fIzmngjujYnFMt75zaX5uL3GfthjdE
 2rNrAwf6EHdO+iIy/9jscDahKkQWyXGZEgRHqN+zJbOuCaTt9nfbZIFK6ALvF5y9f6klEjVO8il
 0edsaoLi6lxVNDSAGJcjVqRch23RfQGvuZT0jBJwQj61MGzVLyrOlhIJ4HdmXO7hVUOR5DSib5/
 bG
X-Google-Smtp-Source: AGHT+IFojTe/OzwaIUYTq8wn2EYUW1xDmzk+/vGb2Yylt3ska4cqbz4mJtyYYxM52PPSXHkdy9eJhA==
X-Received: by 2002:a17:907:3eaa:b0:b47:c1d9:51c9 with SMTP id
 a640c23a62f3a-b703d5f8bf0mr347879566b.62.1761753454695; 
 Wed, 29 Oct 2025 08:57:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853eeea7sm1478969966b.47.2025.10.29.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DFC26152D;
 Wed, 29 Oct 2025 15:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 35/35] semihosting: Fix GDB File-I/O FLEN
Date: Wed, 29 Oct 2025 15:50:44 +0000
Message-ID: <20251029155045.257802-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Sean Anderson <sean.anderson@linux.dev>

fstat returns 0 on success and -1 on error. Since we have already
checked for error, ret must be zero. Therefore, any call to fstat on a
non-empty file will return -1/EOVERFLOW.

Restore the original logic that just did a byteswap. I don't really know
what the intention of the fixed commit was.

Fixes: a6300ed6b7 ("semihosting: Split out semihost_sys_flen")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251027110344.2289945-36-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 61001267965..c5a07cb947b 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -316,10 +316,7 @@ common_semi_flen_fstat_cb(CPUState *cs, uint64_t ret, int err)
                                 &size, 8, 0)) {
             ret = -1, err = EFAULT;
         } else {
-            size = be64_to_cpu(size);
-            if (ret != size) {
-                ret = -1, err = EOVERFLOW;
-            }
+            ret = be64_to_cpu(size);
         }
     }
     common_semi_cb(cs, ret, err);
-- 
2.47.3


