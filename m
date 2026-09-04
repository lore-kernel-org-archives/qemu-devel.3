Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89503C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaY-0006oT-E1; Fri, 04 Sep 2026 09:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZs-0006Nh-2L
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZp-00034n-4u
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so7844225e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527008; x=1789131808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=muK9+MXsKzWAiZjC5VyajksBXCvHL/OHU4Yb9BwJ+8g=;
 b=mngO7tUXxt4uuAEmU+f+K8rQEjz3s9G9i6UwQrs/W33wXCaSd/NPnwM2D+uEA0q2ee
 MaldDh6EEx1p4ebsl/GIDOEGCF1SQqv8sBFrPm2eGqhEfq9Mmf3IsYifOg75vluqWIrM
 nyXo1EYqqDWscclsfw4/ab3sGb771RM/bY/myUywuBJ9N9lJRJnQgXzRzPJQiKD45t4y
 fBROene3KoYwO6CIpqvR3CVs/C/gHiunFUOYQ2ufnG5uzrLq3mMEgC3I26qIRpMiv2SC
 aS8ws3Powg3qIap1MZcGY5+LU8HbL3f9ejOZ9ZFbZWfr92XU0SQTRk13voGiywgWfecu
 IB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527008; x=1789131808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=muK9+MXsKzWAiZjC5VyajksBXCvHL/OHU4Yb9BwJ+8g=;
 b=RooODwywujeErYnmLK9xziKgmDRWlQVV9VQvAMKBSeMM2BQfP7YE+wDKJk2HT/H3OG
 b6fP3tJmfcEv34nof/3i4amr97bXV1YGz7T2Lq7SrB2aVDTlw5V5PfYZuaDwMmZgUZhQ
 dglibeuxCEqEghIM1oH7qpvBCVww40sF6Wr+6Km9CWZfx/s5TGVarcEob/lqbnrQOrl9
 gFQ3kcQXU0ufils6QyZczqfQcPEBxTS7MGUZM2/38JR8k488iQ2Wcsi1kVe0wJ4eYgle
 K22ZTrLzS2eWy0ojdTY/SWa76tMN5bSkJEi/LK3JDUFCQuRQUU5Is5fO9dIMQoY14y1G
 Opzg==
X-Gm-Message-State: AFuF++mCYt9fRQaj6OkXYrc8YnjAQTAJFYtHxkGNY5qjpAtQUac0I8Nv
 SEmfuA7IR9wKzqFfsE0VndElKLRMevvHbpEgikJR84I2W/2MO84CHIPQQP5GU/HIXhA=
X-Gm-Gg: AYBFou1UPWr3LEbg1Ud8uIRgg7Nm5u94p68QayWHAN3UxYIGiet4WIictfezSniog/C
 tb3QoCK4OASJutWXsM2luAbnaUYUqxYIfggKx0ROD2c5xYlsZTLVUZ+cgKL2qEUonTkQGfd2dtO
 W0UmZE12otXwO6XNKacAyqdM5kESdozHZ5m1VEjYqaOWfarwmBmxp9Cfy5hM9LHwqUPGBnSOUUp
 7ouWusqpv8McSDiC/SD40H7/AN4gFISmTC+3b+7ZAiYgwTc3LCjL121AAvgwusdDa4C3EwHXFRt
 UyAvzhqZuV3gMUtSP8tYOkW3bPelS/ppfEoP92VoHIRN/hoSmlgx19r6taG87sed1qlw9XTOsRh
 Go0TkL3XNGvGjtHg1xCh6CfDGT0NQyi3RKxLVQ0L7rBZTAsS8Cymt8u8no/Wy3CRjjYSWcvfVRB
 Eh6fssPOZ6PqX2E1S6tb5CGC8to+o1iU69jSVkeUShvadnZsSdkJ8buSpow/YG
X-Received: by 2002:a05:600c:4e45:b0:49c:f504:2af5 with SMTP id
 5b1f17b1804b1-49cf81dc3ecmr66833455e9.1.1788527007547; 
 Fri, 04 Sep 2026 06:03:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7710aa5sm69107075e9.7.2026.09.04.06.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8822C61E65;
 Fri, 04 Sep 2026 13:46:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 105/105] MAINTAINERS: add maintainer for tcg/tests meson
 infrastructure
Date: Fri,  4 Sep 2026 13:45:59 +0100
Message-ID: <20260904124604.2207440-106-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260827221506.91574-106-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index f524d905236..7183babd6aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -472,6 +472,7 @@ F: tests/tcg/tricore/
 
 Multiarch Linux User Tests
 M: Alex Bennée <alex.bennee@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: tests/tcg/multiarch/
 
@@ -4638,8 +4639,9 @@ F: .gitlab-ci.d/windows.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
-F: tests/tcg/Makefile.target
+F: tests/tcg/meson.build
 
 GitLab custom runners (HW sponsored by Linaro, OSUOSL and IBM)
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.47.3


