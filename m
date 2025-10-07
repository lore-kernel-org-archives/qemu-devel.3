Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5827CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Ij-0002a1-RI; Tue, 07 Oct 2025 07:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IN-0002XU-Aa
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I9-0001JG-25
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so37079475e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838133; x=1760442933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67l9jRuNrudg5KXPcmgxsYYNncfTr9vIbBY0RDskrEE=;
 b=FBicFG/MbkOvA93rKeT3MPxENlgNldAkjU3X8DTWhLTwoV782xzWacm6BICurDIC4B
 viKDlYkdsnNDGt20mWPiSCZtyr32LT3JSoazAuwx2Svn0L7vp+vQzx870C2lOf/wMwfp
 VraipEVbmyFt3NKpYzwOca4XXcAqStgMPrMzFchBQNSa8mpYg5HBhdML7n4MLgEJIL6G
 VDQG9xq/OHKtLpvYCsXt1e8r7gdE2vj1vwj/bDASRc8oaF31Y24yegLmUNKDSL3RsWrM
 icX5PYv9gYFnoJ5Bn4ryNCUdCPBsLKUpSP7LeQOiQZ+nGkPxlXL9QHzZoYFPv8TdDl82
 DS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838133; x=1760442933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67l9jRuNrudg5KXPcmgxsYYNncfTr9vIbBY0RDskrEE=;
 b=h3YMmbw1mhXisQsYE5w8+da+HY8Stno+yUquHSk/ahBZAn0tfReiaL2iBz/Bg/F8Lj
 wV5JsdQefuQvX9v/rr3COU8oQo07fV/B76XRSEEg17i9XeOpx5HFc+tvo5VSIBLT+qNV
 d54b2hZJe+O17pzGdjUuMB8xoPVTKsJfNo2cKMUk1bbANrNVKWfE7Qrg6SWnQ7lZy1yv
 DjGVVH1CD7xWqD6r407pCVRQgNHQlcMaGJg+5IprCyiPH6y6LHYmU1y20JnoSNdUy6+V
 d28NTQsI4nszZM28anJi0Ewp8HBAI4oNO/4YVm71cRGWXz93qtea1Ky6IUQdb3Yri1SZ
 y8ag==
X-Gm-Message-State: AOJu0YwUCP2MuzVB0awlaiPaX/D7L84LMECJdviuf3BT0lHw0yrB7vCv
 wP3w29ex7dgIdM5N4vFUFLzV2OQezI4qkVfcNJb2ovV63T5TfqY9lwrqqCctcMV4zjc=
X-Gm-Gg: ASbGncuRpNIfMruw4Lj6kpaJk6vOWDe63zmb56XE30mUbEbvd5uRls+/vgPNQfE5nZP
 Uyjb7Efl93BXirLgw+WUDBWUTrFMQIdMbTeqlBpHtGBJxDxqibkZVdQGaX/C4kDfr1Qz7Yo6LY0
 RsjABbLi5br057CzzUsBpLekHcryR8o5+BbwvvmTCOlAyDy3Tk8OnsmkXx6vA1+RDEn3DDkbrOv
 JaqhOqo3a+RirLt++SosJyMQ0U4yXSoq4j5BQ3GZ2enILlsqe0sDfiHGpwofY6QSvSFzM/WhOs9
 t+oLOp3UNZ7mizBUdOBf/n3Y9+tyWFmX5cKlcxG39OWTU8/2tT42ORJ1ZeYI8KaUHaQIF97X949
 zIgqapSmynV4Awaxaai+jWFB+6x6qxDxHzRYQgX6bMWRHuHLyMls=
X-Google-Smtp-Source: AGHT+IFlSTLpFcRaPLzUpyplfbzLbXpxeTm4Q+xMBMnWtSaiO9LF0LcL6Smo9f3eCn+ci15UcPV4Iw==
X-Received: by 2002:a05:600c:c0d6:b0:46e:1b9d:ac6c with SMTP id
 5b1f17b1804b1-46fa29ffeebmr15317475e9.17.1759838132816; 
 Tue, 07 Oct 2025 04:55:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723593d8sm228422255e9.11.2025.10.07.04.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BDDF560031;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/17] python: Install pygdbmi in meson's venv
Date: Tue,  7 Oct 2025 12:55:17 +0100
Message-ID: <20251007115525.1998643-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

The upcoming changes in the reverse_debugging functional test to remove
Avocado as a dependency will require pygdbmi for interacting with GDB,
so install it in meson's venv (located in the build dir's pyvenv/).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20251003141820.85278-3-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/pythondeps.toml b/pythondeps.toml
index 16fb2a989cf..98e99e79005 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
 [testdeps]
 qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
+pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
-- 
2.47.3


