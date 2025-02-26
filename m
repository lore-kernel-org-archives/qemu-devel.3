Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEBEC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1X-0001He-6P; Wed, 26 Feb 2025 09:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0y-0000zE-KM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0v-0005gE-73
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:56 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390d6426ca8so750847f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578631; x=1741183431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9BfwToqsdAvmr5T1oKvg6QCzmXVNMAZSUhDiWFdTr0=;
 b=ZgJxL4YFLaMVAtReWLJ4HMknLSc7Kg2npbD2WomheDcNVPKbKFC39VVZpbhjYvAqFk
 +vVrmrHGmQZP25kViY5togb4+gtezvRanT0bNbdOYxd5AFjFdGISE+s8SxIPdJKUUCV4
 0ooXhT7UInPoSy2g+E6blAPp2TKS7Bnj77eHUJIddKwJwrrIFXQZuaiES/KglqiYTlYL
 yMNDN0XYvMv681aUisqeJ4WJQoxkVbOVIdXk+aqfGNfc65V0UclT2NoQiiOfFObspkZM
 09AUbqOPm5SA0wUz6kj7Ojtjfy6WfR56YwAmmCt8zlmsEuJ2pSeagQhONDBPujxrSuEk
 dWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578631; x=1741183431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9BfwToqsdAvmr5T1oKvg6QCzmXVNMAZSUhDiWFdTr0=;
 b=vV7R9MaZv8x1h1lk31C0hsesQD2bzIccwel9qZYb7VgtOjNyr0ubg2qMtWFovZk+uO
 F3rP2/+gDAOtTmI8DXYnfjGlKQIuJGMt/dBXNbWQDUe2lGj1/7jKV7YuXggADEP5dxSl
 nlctHy5vw4xw/bwc3MQBPBhTYZNTyH6z4vJ61XAZdQncRhX8F9ssIh38LO6UORTS7gsU
 eZD7BL+fxn1xdXaiMYRAUoz8hNtAC+JovbpJ8rdNpLu8jBFSmKYgy9vNJ0jnudgvYd7E
 XPkl6HRA+5ogBBFQERqzSX/VrgThTg+y2B1n+J02Tz6Vz4JAytA/MwdRNRarYLzozXdQ
 4R/g==
X-Gm-Message-State: AOJu0YyNYhxWY1B2v3GigCnXUS9JHugkGszVjng8CyS7OGi6oKGWjNHt
 iAJVkK8R4kyiYwqJe1uHZ4LCvENGnYJ7cTgomsOCRDDTxKSVr+Rqm4UM29p3izA=
X-Gm-Gg: ASbGncuYXUU4NvmCXtb/5TCW/cG2PdZKIVbXvZb4CruMYGJ0fiW6TN3Z5qPbmnxr0a5
 /M2xlvosBd+vBD6yAAutzCVMlg6VPh4H25yLnPlDNsf8aoh2+v0UanBF4Hp7MuhiMZroT0GSEGd
 OG/ePDuIXAmNnHqtpqhaOmXjkFtcUtZThr8GuuGaGFcllKvNuZoqTk012n/iaFd9fRmcWhofObX
 pazLVWfom3hdWWzRZYS7QmC5GsXxtF3l5couuwqm4K17fwtoxsoXeqmOiEC+PC3udzCwi3E68fv
 /S/ZRNCoNvZoY4E/0oP7l4Q61d+s
X-Google-Smtp-Source: AGHT+IGvUePK0+QJb5QRhze0sm2iwK03g8mGfOkusNYsZqCj5zakXObMp9hUfnIbbmbgCVfBtVy4DA==
X-Received: by 2002:a05:6000:1a86:b0:38c:5bc1:1f03 with SMTP id
 ffacd0b85a97d-390cc5f584dmr6865008f8f.7.1740578630807; 
 Wed, 26 Feb 2025 06:03:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc31fsm5649296f8f.87.2025.02.26.06.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EFC2260384;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 10/25] tests/vm: bump timeout for shutdown
Date: Wed, 26 Feb 2025 14:03:28 +0000
Message-Id: <20250226140343.3907080-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On my fairly beefy machine the timeout was triggering leaving a
corrupted disk image due to power being pulled before the disk had
synced. Double the timeout to avoid this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 6d41ac7574..9e879e966a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -83,7 +83,7 @@ class BaseVM(object):
     # command to halt the guest, can be overridden by subclasses
     poweroff = "poweroff"
     # Time to wait for shutdown to finish.
-    shutdown_timeout_default = 30
+    shutdown_timeout_default = 90
     # enable IPv6 networking
     ipv6 = True
     # This is the timeout on the wait for console bytes.
-- 
2.39.5


