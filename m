Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98130CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby7c-0001nM-5N; Tue, 23 Jun 2026 06:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7a-0001mW-4F
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wby7Y-00073m-LF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:12:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4629d80fa08so5161655f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 03:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782209563; x=1782814363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYi9qbpIREPaLo0UpNm1/FXXAnbHR9c2f/rHOqLOgf8=;
 b=EnijfLvlobNKRL0QV5YVTlsW5dM6gjIwNaXEFbIwtRj/MLHfA7d9Afv0SY4E4G5zxw
 M/S0AMbnzjRr7opPOZ5IsY9+UIL3M9ZmjkcA8zKbUs+GtCYAfJ2eam8qByBjimxdps5k
 iE+o/QoRVZAt7Fcg6PMC1VoI008YvMyNzGnZM8J4pC0byKQNIfQ+Is6vjK6EMuuEaBnQ
 8VaYgfGwrcTCcKGsfMh0BjXtXMzLQbiOjXgsa3Wm7wnZm+B0G6fEL0Dn4nXsNvPStsCx
 kxBEC1QO/MB7VYEuNXtBRRXcNHR43iLKa1hzr6nK6uxNDRVVTzm29zxoPEU0UzybFUQq
 cgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782209563; x=1782814363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYi9qbpIREPaLo0UpNm1/FXXAnbHR9c2f/rHOqLOgf8=;
 b=Zk0B9QQ+j0hmsF8HAOxWABXNpGncQhjlorL20wrE/v3sdYINr5e1Mne7TikK5xhpIo
 BGQLb6oBdsWtDNXnRQZa7STkKbHtcRHoc4XQ+KfgrudkkR9cFVz/biP2su8ohXDLLywL
 f3l7gMp0R1fOraPVgap1hWM2n3uurTGz2al8FPNPrgI37f6mvZc+j3mtcJe/Vw5chDEG
 bblIKxjwZuRDJBQUndU2PtzSbUB2/UuPqTIoC9HXRTP2Y0apZ/Uk1qoPju2dVjL8JUYF
 qo0e+hxAcUJscoJvs8rptgEbp0/vxfiWvLaSLh8GMLlpPTC6kFMZZKDMHDQcXOkHSpYw
 aTUQ==
X-Gm-Message-State: AOJu0Yzv/fNGcFCWVSN/PVoZTMePfPE3X6biaMlItT75bF2JO1y9FB7v
 FhDrDxmj+Ucnklf1BcsOuEilVKDAvdjs3gY3OzP1rBC3xswEO+jIzSOjsnBPL/tGipo=
X-Gm-Gg: AfdE7clDbXzXE5vwNH5bdbfPoxU323lmUrHbTUV89x7NDf3XNqCMwzx/lWrzBg0YkOQ
 nq8/wjKbbJx0fyPMMLen3LItrxo8tDzO52/YbOmoODgiDBoQJKRLEemuN+onRnWnVFk0D4EDUxA
 B3B2I7ergGdu7xP3xzVasU7GuxWBjJ6Q7vXtoWnt5g86eavA8I7mPnNnkj0kD8zyKcYK/61VZws
 SgYpFCIhemsoGU12jysnBLtpzyLpW/vLcyfmtIAed17fu5ZgAxQX/BwsQyl+LlBaLIwoKUS9uRT
 3TZGnIPqQ/LTgTspaOY5tlGsivRAYSah5HcEPBANptm+muaUzdXWn4nA4DJbEuGZmek7PIsbnRY
 un/qyoZPAbFeTiNy7+DdMCYqcNWR7W9usEPoVFlH5tENK+ViVi5JFY/9lZjEMYGAVGkBKG8QGnl
 +aFOhoPq9jWODr
X-Received: by 2002:adf:e5d0:0:b0:45e:651c:47bb with SMTP id
 ffacd0b85a97d-46508535300mr25420847f8f.28.1782209563118; 
 Tue, 23 Jun 2026 03:12:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579dfsm34604180f8f.31.2026.06.23.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 03:12:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5A4D5FA60;
 Tue, 23 Jun 2026 11:12:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL v2 4/7] tests/functional: tell pylint not to check c-modules
Date: Tue, 23 Jun 2026 11:12:35 +0100
Message-ID: <20260623101238.3806547-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623101238.3806547-1-alex.bennee@linaro.org>
References: <20260623101238.3806547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

To fix:

  qemu-test.test_pylint "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83: I1101: Module 'cv2' has no 'imread' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)"

Manually running python3 showed I could indeed import cv2 and call
those functions. Rather than allowing pylint to introspect lets just
tell it to skip c modules.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260619155657.944220-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 049c3e76f12..949bea611fe 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -58,6 +58,7 @@ confidence=HIGH,
 # no Warning level messages displayed, use "--disable=all --enable=classes
 # --disable=W".
 disable=bad-inline-option,
+        c-extension-no-member,
         consider-using-f-string,
         file-ignored,
         fixme,
-- 
2.47.3


