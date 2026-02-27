Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1CEFEFB5A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzbg-0000Nj-Cm; Fri, 27 Feb 2026 10:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbb-0000MB-1h
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:15 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbZ-0005kh-Cf
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:14 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65f71ed7c6cso3928709a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772205491; x=1772810291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iibMi4Z9nIixnxr3wd8tj43SzYsO1FrCgkGYHjlBSRo=;
 b=fikCIeXdNhXi03/u8EmyWHC6u4v3BsJxwYtuo6/TJB06YqM4MIzszvCyIRjEnAe/mq
 k7q6rxwZl8qHXwftpXC/qLbTPKVKc/Sq/6/AuXRPdS1v8kurnDHKLxvGanyVPKQ3bL4L
 06200HbNdoj/9eUA/2GWY2tZsl0JoF7KPISAgWNgaaAKkIL/h+qyqxsNOdork5XgMNT0
 jV7kB9lj/rzPUSx7IMx1kVrBvoaOkyaNQGXntyl8VkRPsG8EJf7nKxgMExaLEWE8XGNO
 0vuMb2bo+WO1f63VWYi/lkloB2lRxBySBAK9UPDWi0Jt/mq0G90FlonpwP5Trqky/SHP
 aUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772205491; x=1772810291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iibMi4Z9nIixnxr3wd8tj43SzYsO1FrCgkGYHjlBSRo=;
 b=Y6jpM3BUuNAmodmj8bCc+osKuwhr4+sXMpN/iBxmuY1aZEUvmmR8Fs26/xXQgW+DeH
 wGL+pqkZAjRaPkCCjog1S4rnBAM3FRgcR7z9uVtClIN3wyozVPvxBmO0Lbr++Vwb8DjY
 xL5zGYkaZcNWn1Nx7qmhGugwviPLn3IpRhSK6U07UjV4kzPp9exf43/P1dAsKzXNhsy9
 mEX/BjYdYH/DYf+KJn91rxXYYCsh/1+lRvTobOKiPtSh3qvEztRWeu5oQng0shGW0jGs
 BGjKDZtLlVyWXfYV+zO3zz0gJzTpKEWcMlbBof/R5n0BCQQtL/QYy5tCLTicOoez4HOb
 OOsA==
X-Gm-Message-State: AOJu0YyOOCnG/qbqw+Arfswz3d+vE2j6+GH96EOm/asoXEvBA39Cggyq
 r/MnO3cebcJWR90E95d9mf/QYmYkKo6UCZD1apAyRavMWH+blw0bdiI7CWjEWBylSaQ=
X-Gm-Gg: ATEYQzzWURPs9x+5Vs6cMTd2/JAUyzqK2awsSee/33bCCkeMGXey4sLF/OCZEwMqjgC
 bHY2USm3mSLQdmtIhXQBvSX9+HhwzJcSEqABCJEtT/spOJTWL6xCDu6uaqhK5gWywz8RaCu2Kqu
 LNxKZL2sLIXY6f8d8YXMNGtByg16jezWxvfzK101/0nqEL6yhiV1suSK2X3EoxS7N+tH6rVsJXG
 eDSTKgG9tIw44sw2aUM5M+Hh8cpTOtpTFYAWT3O5002I29JTHIL4XbPsfAJwrbzgHMAZOKuACed
 jHXcn9L71yQzRFEbgh0FZuQUhVL+MhZQPXeo1Tp+2vOQkLWyoabkeY+1wxa0xwfsZ8pcNhcam83
 SdjN357K8FDlT1b7YeCuuhhvwgEFn56PbQZUGZOtWso0yVLVtGCCxFswD55mL4CK4amkcQypVHG
 HmAk/1/hjish2uI+aeneDUTBY=
X-Received: by 2002:a05:6402:2750:b0:64b:6e44:217 with SMTP id
 4fb4d7f45d1cf-65fdce8f964mr2263317a12.0.1772205490943; 
 Fri, 27 Feb 2026 07:18:10 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabd362basm1327474a12.4.2026.02.27.07.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:18:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B6745F94E;
 Fri, 27 Feb 2026 15:18:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 5/7] tests/vm: fix interactive boot
Date: Fri, 27 Feb 2026 15:18:02 +0000
Message-ID: <20260227151805.2335641-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227151805.2335641-1-alex.bennee@linaro.org>
References: <20260227151805.2335641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

For reasons still not clear to me passing the single dashed
-interactive would confuse the argument parsing enough we tried to
pass "nterative" as a string to the launch command causing failure and
head scratching.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260226185303.1920021-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 8a5aaedce7a..0a53dc9fdd6 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -154,6 +154,6 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
-		$(if $(ROOT_USER),--interactive-root,-interactive) \
+		$(if $(ROOT_USER),--interactive-root,--interactive) \
 		false, \
 		"  VM-BOOT-SSH $*") || true
-- 
2.47.3


