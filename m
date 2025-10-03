Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346B1CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gcX-0004FJ-2O; Fri, 03 Oct 2025 10:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcV-0004Ew-3Q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:18:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcO-0000Lw-8b
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:18:50 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b55197907d1so1532500a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501114; x=1760105914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQJ4n0yAnCwknqPTb+pduA+OkL6+8EPxAIGIZQxicPA=;
 b=QAe549CKhVom9FUNBsT3Tw6bf50l78qbm/TtErPI+VbPlk3l/b1TqAwo81dR/DtNjW
 2NjLOnQvBQspqIdHuVaVhWjusgq9W2SZ+7nJ3Ac2+/RaOaM+o/7/GIDq/mlJVNsqyFZl
 n9CvUJJJrULtzjTUrZR+y13jnnjmz6Q77KBSzWgUF3ThGjk1UEnc9rlRozr6Zgm9XMFY
 gdps1QranTKtOhr7lRmrimdwZJj6Egcs/9eBBVIDRNrlLy79IgcwQ85ntBS1rT30eKE+
 bGCbFZzlq9rBf1Rk/9Og4iPx17jBdbLrU3Zb6xQ1fBfmsaqeF0lDMveWbnSUqZIkcKbL
 5ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501114; x=1760105914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQJ4n0yAnCwknqPTb+pduA+OkL6+8EPxAIGIZQxicPA=;
 b=rDDlYP0mtJvbO+Bzztx7xSd46iAiYHMF8tw4qutfolF/doYVF1hcL64p/dGYVaWes2
 ilPG7U4dPdXXIrC7qj79xb+0uPV0u9wJmBVF2wZqbAUScigaBvYyNsYZspKBTth7u8iT
 MPcaW5hJStyeKG8sck2WmB92G1+9JXKRQDe9R1C4Fp+KZfy7yPuu04EygdTrk6kHT8kc
 AxGxHfIvoNCvE+CUG8AgTnbMgCKtEZlOzALPtUK/NyO2LLRfSVMtMhiPn0+/3WxLGLuS
 3efWEgaFjKA51L+K3KhkrktB6ypBAg9Xj16qvtgqzEr4dHV9njY5aw6ihz2VXY284k+G
 TI4A==
X-Gm-Message-State: AOJu0Yyq1Qw9SeRo9gRlKYeAzYBqC5Zo2chsyjY6LNjL8q4w5Z/5PkJd
 ffbIEVr6JZkqznSpYllYwCCvWnXHHQLg9eIsulQjMrsp4Zc5VMsrF/tLNsDOXA9GBH/R9sU/QKl
 T1caZ
X-Gm-Gg: ASbGncvbsIlN4Kj/ak6k6PtTy0SQZVpx4SEKIGhJ70AAbWWTedTFt/T+i+CbvvXhXxJ
 fULGT2uK3iFgPJ3BcwY9Aaj075oGWCyiAJVXJFPgWwv1MEt08eW88ptQablV+FIEg56A3UFv4uZ
 zZIbPjYy8yEziiR7mRXbsBo1vReYKfuZY7TXAWOmDRI5pU0V+wqeU/+snPgjTV91PNLwSJe8YVX
 FzO7Dx9W35JGRoKg1+DSaTT1rjjq3rDfk0ZPu4Vt77vCPMQfFWU747EzUe/WGaqskuh2lqxx5fM
 ZVWZcvZy0fd/T5DIr/qpVbLlICOFX+ZDqd0MvXJ2OAY2uu5Bq3FZDmoNLcn63f0UR+rstRfh0jU
 roOiSWKGKHVxMH8fnTRyG1gteArS5Oc/dA6a73Rm2bNE27Z+M40Y5qbtb0OUvK/aWImY=
X-Google-Smtp-Source: AGHT+IGpP3y2vUX907I7c8V0i4Iy4V6/IjJSq3UH6RaDK4nWrUcxKZEIWt51H8Zjhr8cUrK6fAO9jQ==
X-Received: by 2002:a17:903:2342:b0:283:c950:a783 with SMTP id
 d9443c01a7336-28e9a6541e0mr41281955ad.56.1759501114553; 
 Fri, 03 Oct 2025 07:18:34 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:34 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 2/9] python: Install pygdbmi in meson's venv
Date: Fri,  3 Oct 2025 14:18:13 +0000
Message-Id: <20251003141820.85278-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The upcoming changes in the reverse_debugging functional test to remove
Avocado as a dependency will require pygdbmi for interacting with GDB,
so install it in meson's venv (located in the build dir's pyvenv/).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 pythondeps.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pythondeps.toml b/pythondeps.toml
index 16fb2a989c..98e99e7900 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
 [testdeps]
 qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
+pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
-- 
2.34.1


