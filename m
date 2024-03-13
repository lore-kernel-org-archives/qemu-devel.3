Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF46C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTge-0001pH-1f; Wed, 13 Mar 2024 14:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTga-0001ig-N0
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkTgX-0004GK-Ku
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:50:44 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41324a16c9eso1120705e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710355839; x=1710960639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWk3AJvtwG4+M7tAK6vUDxEOFolgTz5/lAeIi0nhTag=;
 b=WQBs14mQmdx4bWTKOZGi9MDsZizypAaGwIHTJrn0xyQQpGx0vrHjbD6XQUOPwtkjMN
 0egPfX+B8/3uwQOa+qWavGBdcJOzruXY5qDHb2rcolYYWZUzsJ+5J6E2C3yzliMEZ8E4
 Ggo6vzpmH/1QtMYM5QX7Kv7IB75HKMw+Ko0sHZsNLz6TPepKty0CKyL2mzWfZKF2fIB1
 CJj57Su3NiaztYBuqQlg7IxyACSk9fszeWEb5n09s+X4HWuqk1EpP0UUfMtWNigGPGbw
 TgNlFfYlXuR2wiw4TBEHilHlnpVtinR6Q/GKai8+DUhqEojxT67Xm2a9au2Qum7/OLji
 E0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710355839; x=1710960639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWk3AJvtwG4+M7tAK6vUDxEOFolgTz5/lAeIi0nhTag=;
 b=DAZ4ko60CgnsB+L7dvNEUk9yvV5zF2syTbcz3HkgLeBaB6GnlqWcXyjKYYcuEZHk/7
 GiQV3hSB7BVwhldJql/UO6nGGp+uPNoXkbrdelyq7/875KG6Su1pmVBUPLvumu3BIrTv
 AMUEv1GvYDHXBn5DCw2KhcRFcAhJwrP+3Nc0ZO4Xk3KZer79ENRWZjsAnbvqroLOI/Q2
 XgDNbMaGyBDevvHqRXyN4bopI94PJlCAWnuGIqlD1cbwPlYOzFviFi95HBKeDzNDX76r
 qpaDWnFlj5twX0tsMNwtBW1d+ahidvGOC78qm/y3eBW2ORGzqGvK1Jl0eCL6afvJDLNq
 48Xw==
X-Gm-Message-State: AOJu0Yx6WVM4t0e5/1WOSj5yJlHd7qM0bapV2EZfloq8qjEmbGVKcaWO
 01HVI8FsaWNhtBRIoT6+nLmIBBbGIuaZcvm8SIPeTOs0GBX5UUKG/1UvPJqosrruPOKCW944DCT
 2
X-Google-Smtp-Source: AGHT+IHVCvYGdXOqSvhG0TkqF8/nwJckNMnZ5dORAkrkWJrRClth+omh0ZGW0c16mbE21+ad/grISA==
X-Received: by 2002:a05:600c:1f94:b0:412:ea32:e7b0 with SMTP id
 je20-20020a05600c1f9400b00412ea32e7b0mr540827wmb.40.1710355838743; 
 Wed, 13 Mar 2024 11:50:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d680a000000b0033e0dd83be1sm12254046wru.91.2024.03.13.11.50.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 11:50:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 4/4] meson: Enable -Wstatic-in-inline
Date: Wed, 13 Mar 2024 19:49:54 +0100
Message-ID: <20240313184954.42513-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313184954.42513-1-philmd@linaro.org>
References: <20240313184954.42513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Compilers are clever enough to inline code when necessary.

The only case we accept an inline function is static in
header (we use C, not C++).

Add the -Wstatic-in-inline CPPFLAG to prevent public and
inline function to be added in the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index b375248a76..f57397aa53 100644
--- a/meson.build
+++ b/meson.build
@@ -591,6 +591,7 @@ warn_flags = [
   '-Wold-style-definition',
   '-Wredundant-decls',
   '-Wshadow=local',
+  '-Wstatic-in-inline',
   '-Wstrict-prototypes',
   '-Wtype-limits',
   '-Wundef',
-- 
2.41.0


