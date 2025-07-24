Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D74C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetgO-0007qV-3o; Thu, 24 Jul 2025 07:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg0-0007Ny-71
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:52 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfy-0007z3-J3
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:51 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae3be3eabd8so199422666b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354789; x=1753959589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaPXysIAXigDqqT+O5iDUgf8CktyyPNEMi6/vXX+IfU=;
 b=JGXtrwnhZuGCZG5eQr7ZxPP7GP8Sujv33y8bjM+qA9EiWwQ8Y+QzhbnMp51aaCQ1NW
 U8yLZ9a5K9YN3KGPRdNPAunxOa5aSKDEIa6/gZP+DlCppFg86ZAxVgJ3BD0omnrEZ0Ql
 3DHhmAQuvPtPMK5+vuizsoPEJDGat3NWDu3499NvbSHIgk5p+rlm3mCLTcQrDtU4hY5A
 EluXGKaEyMNvhDm5kEN2S8edHXiXFy6Qc3cWycLEO4A1gqECeiWhdC2cHAu33px/5iCC
 XcuhwNaj7tEZRGtUnOgNQ/KQngCEyZAmoVVXwnL+UsLL0a0+5uv0LFun4g8Cud1N9cEj
 hT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354789; x=1753959589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaPXysIAXigDqqT+O5iDUgf8CktyyPNEMi6/vXX+IfU=;
 b=Kwr1H8QNcjN+Bq6dqffNbSD5KGqQjynZgr7SmHmwZJj3L/jBxU22tOKor6QwCPBFFy
 ql/nETG0tRqjE7kiq1kYQtPB8bkl50NgXdsOqo1ebgdMnIqLUqvC+oY9braYDD7umwGf
 gAaf8PyR5X1cD0l0HR7Po5i691e0/gJ6gwIdTHDeHU4XfRxoz7kn6sPjV/lgc4lVaSFs
 VDKaBOlPXiIgOmNH5foJB2KFiI4bF2H+nFeCwYdvhpjYk/5nVqTlB2VmGqLF3AMLuVxl
 lS+vLscmxoFD1S+muwNjmvC7jq4ECLm1iqaujQiQ+AmEqEwYAfSQ9WUHxbhWjeKrC8q3
 F0Pw==
X-Gm-Message-State: AOJu0YweNG58EONdMgMG5RAGVAFZ6Wj5blhJsrL6xSCgLKYVdBEQgo5Q
 iQ76h1ECKrN006T0nNJ1//J9vkJgB/PauqRNcjmFLbxaCuCZThGqNS1DRTeWNsm0fvs=
X-Gm-Gg: ASbGncse0xHTacXZfc0C0I8+S6wrlJaIEPzWjoQdSR3G/Nxa0c+HnCNmCCEnrDu2uGy
 1BlyHtdFCdf01hOkI1reD6Tj5TAMxN9LwW4Zg/hMZe8BcVklJ7CsM1EdHKZ6mfrxocPJ3ZloPHP
 TqFzBhineiG/vklVkzxcdsS5nqGCZBPtKBNZRn6dEFMuO61eVsB4MmzYMEOM3mDSUg7aDa4DHs5
 qWKDPRGF8RuNX1LecJ6AslsodTVSNJE53vzfjdy7L43IhwHDBn/GZVFhUESsyuy/q1VwG6xmowj
 EOCR9J8yIVvOaC0OLtPtbo6bZ6c02RVQGhCzZmI2Qm0HUNi0RsuvQilMczOkFHR4pAoyT856Stp
 6cxqQQ0AdAhElfIE1Z2fR31c=
X-Google-Smtp-Source: AGHT+IG/XK6uZFCFCYRVot/2VtzVvfVRLhvo6e6FzwQ7vNDZHUtOVsDhy8wjP5J7KkwdU8+Q/6FE0w==
X-Received: by 2002:a17:906:478a:b0:ae0:7e95:fb with SMTP id
 a640c23a62f3a-af4c1e2633dmr200210166b.5.1753354788845; 
 Thu, 24 Jul 2025 03:59:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47cc6e6f0sm97187366b.46.2025.07.24.03.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CAA3D5F8ED;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 10/13] configure: expose PYTHON to
 test/tcg/config-host.mak
Date: Thu, 24 Jul 2025 11:59:36 +0100
Message-ID: <20250724105939.2393230-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

This will be useful for making $shell calls to something more flexible
than the shell builtins.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 95f67c1a827..825057ebf15 100755
--- a/configure
+++ b/configure
@@ -1800,6 +1800,7 @@ echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
 fi
+echo "PYTHON=$python" >> tests/tcg/$config_host_mak
 
 tcg_tests_targets=
 for target in $target_list; do
-- 
2.47.2


