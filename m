Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BF2C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOM-0004Rg-TM; Tue, 14 Jan 2025 06:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNo-0004KV-Rh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:58 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNl-0006dz-V9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:56 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862a921123so3111601f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855212; x=1737460012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pduzs+UmjW63vib6FEKaDURuILe6p6CLJowHwsN6bcg=;
 b=aIB+xXU372h18WMO1ehatnhVpJWwEdM+Bh5smcISFB9hOJuRo639mz0ZuwIh2zRXV7
 MOlbXfMYGWwiJVuqU+MRdax5S4v8LOpVusJ+7+O+KDxpAIiNxursF61WsZM0G2FQ/qrM
 ImGiYwAPgCKYJXKO+OBE2KaaFkhnUT6U2hkrpb3til1nHSmUP0wZ2OB+4hx/zntMq4Tx
 MKuAXTXrNJsbmaKs25/vTmcn0TM6Nxocjqo0D4GN+Ftu9ea38D/VudB2Ah3Dcfb/Dfzr
 A/LNmr/g/qMdhlRbIFAXRSwPkPVAf0isTzar1Nx/0ckgGcBVihI49DSubU57djTj++u4
 hS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855212; x=1737460012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pduzs+UmjW63vib6FEKaDURuILe6p6CLJowHwsN6bcg=;
 b=hNbPjTrIMRQyZbHHtURCA2M+iI8CdbM2H115J7yLpc3BbZg/E3jQq0k7wh+FYjlKMf
 u8FnQiLaIBnKCUqY9e+7ora9xX+g44N+MR/T4NMuikAjpihSaHQlM67ma+vtXjTA2J/G
 95jki+pHcz0KX2/I8c8L7ZwVuYD1qF+gY59tZHc0gFC3SFmMY97dZQ+Av1yWETXcSBH2
 HyDYr2hQQgTwmsOcF9KYhePPbIdqDvvXwBarqPe4lXsb45LHEJ6/EUeN1ScUaNLW403R
 Fn7ymUBqnah4fZO3FiFM4wMu3HLxp2KCDhSpCJ9NWsTll+F2XHBaaHPP+GOFLr/NpvEi
 iOdA==
X-Gm-Message-State: AOJu0Yz/DqexWmbbJav+vYlEQ8mMYWf+qldYmhQjnUolmLXvval05fov
 5A7ANnsytmpuHdw5AKR3e/MbEzghp2QNlGVV4TdjMArRlP7mZy5riVMUC5OI9GM=
X-Gm-Gg: ASbGncs+8kNpFbBAawsBzBH0eNW8qSQEMgyRVLi0CaUAxHHOfFQ2nOHUsHlcGquYVmW
 La+sd4SCVTl6KX3NLlYBbsl+rpNkXMmu9HHaqgp656m+lUU+rmIo/2WO5UpmgQjMZDpT2AxFgE/
 JE5UvSSMuVffdQKwB0GVjkN1acJv/MHmqayALX2aRtT+y+9XkgNlsvxxjS/FrFkdUSGL9PHhiEM
 7ZTruW4gCrQDDf681VgJ6qi68O/pcg79Ck0K1czPHNuGDf9ihOvpsc=
X-Google-Smtp-Source: AGHT+IGv5bxYmyhPCryfoF3RUrTR35O1qABD4hyyrYXW8FCfAwguGbE8/ORH10G7DucRMyMLtvY7nw==
X-Received: by 2002:a05:6000:1561:b0:38a:9f47:557b with SMTP id
 ffacd0b85a97d-38a9f47568cmr11438776f8f.40.1736855212054; 
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b44sm14746104f8f.90.2025.01.14.03.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5AEFF5FB4D;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 27/37] editorconfig: update for perl scripts
Date: Tue, 14 Jan 2025 11:38:11 +0000
Message-Id: <20250114113821.768750-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

We have two types of perl scripts in the tree. The ones from the
kernel are mostly tab based where as scripts we have written ourselves
use 4 space indentation.

Attempt to codify that in our .editorconfig

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .editorconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.editorconfig b/.editorconfig
index 7303759ed7..a04cb9054c 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -47,3 +47,16 @@ emacs_mode = glsl
 [*.json]
 indent_style = space
 emacs_mode = python
+
+# by default follow QEMU's style
+[*.pl]
+indent_style = space
+indent_size = 4
+emacs_mode = perl
+
+# but user kernel "style" for imported scripts
+[scripts/{kernel-doc,get_maintainer.pl,checkpatch.pl}]
+indent_style = tab
+indent_size = 8
+emacs_mode = perl
+
-- 
2.39.5


