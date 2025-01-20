Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD846C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyuv-00022w-JE; Mon, 20 Jan 2025 16:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyug-0001g9-0d
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:28 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyub-0002yL-7i
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:24 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d9f06f8cf2so9469623a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406939; x=1738011739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFe2HzElji14TI185hUsajOPss7t//BADmWsqkIN0JA=;
 b=pMKM+W6GooQ6tIwX770Eqn//b7J8BKK5QKTdpxzmY7cdSarXOKjCc/AHeCju40+AuP
 iPajOWlEjNiNP5n7cOKbU0Gmgo+hyI4N2f6LLBvLmftpJJ0XSBA5T8nVyHUAxmdoPz94
 X7ZTfpORf9ujZbX+cD3407o5vWgBlFx73sJCejKQWakzWFTnIZ0nuPYphtzkOweN61c6
 xZ9qWZf4xCHX7EpAIfZNKqKU7f3DiGWmBvJzAhtEHjXbpZxrNNxsECBk5djL8Po3ggd7
 7gupysOvmZSI4L2uy+uUwnEYNShxeQX2Z7cacUXdJC9+T7ZoevRcF2dEJbNXWr+VCQxb
 d+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406939; x=1738011739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFe2HzElji14TI185hUsajOPss7t//BADmWsqkIN0JA=;
 b=HmgOMJatMdvogHgwmZQwX2oLUHPAeEUGfQqunoyrJESJeNfoKKuXZeJC2qD8QRgpz6
 +IIqyBLd7HNM+Z/TMF4msWUBAz4hOpLkZilLOtAKeqEk7fuFJ1JeNZFsd5R6RbKrY1Gi
 kpy1MOlMshaluHqdjyVNggbr4K51l/5McLhOMTXuyeAM6RbSKJR9B6KKgvSY9b5b+xx3
 UDB+Vv859Smut129uGeG2oT43AMC/B+SHZu+rOow9YRbI2qS7hpKFdshwd0pClByZHQz
 nd8V7XIzc03NH+xsP/Dhxolt95nq2sRkNKDox7bQYUF7vXysdz73oCNrBOij6Hp4Xhqi
 LKEA==
X-Gm-Message-State: AOJu0Yz9+G0WnhMyjYhKF6ejfSBQgAu8aBbzYteCACfeYGIS5liaqABV
 tqNqNJY2mF7CK3lrEVj5Q7kb333mpPeETBiDTbmCRei3mE2KMpb3QVWpPlZLDoo=
X-Gm-Gg: ASbGncsuEQRqfaAhsHoTVDaNNp3d6z4cDA/BYbdnT2qBJgLpPLaP+1UAuEj7Zl27yCL
 SkIiZhxcGk8i8hvLACaR1DiLlAVmwM1tlQgJLbvRePHrCmzIKJznnw6cc6fysC4FDvvB/GIm/b6
 n7ckL6t6GJpv+0T/fKn2HIBR9+sLnZd4RTkN+VZVXpEO6AYks6A6Gmp4Ruwj9qH3lDgFo1RBoKR
 MVUagiKKR2iAoctxpxtsdOsOGMYeOVzW2wL4GXvCRM2LHCRt+h5e1SlPDJWH5w/6DLN
X-Google-Smtp-Source: AGHT+IEFkr0P5M+4UovfrMwhQuhqZaKZ9IknMU5uk9qyiYpNjRLZAUZPwFAjooIvZAWoih2znZZu6g==
X-Received: by 2002:a05:6402:5251:b0:5d2:d72a:77e4 with SMTP id
 4fb4d7f45d1cf-5db7db1234bmr14902156a12.28.1737406939279; 
 Mon, 20 Jan 2025 13:02:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edce5csm6200172a12.75.2025.01.20.13.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:02:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61A675FA1B;
 Mon, 20 Jan 2025 21:02:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/7] tests/qtest: tighten up the checks on clock_step
Date: Mon, 20 Jan 2025 21:02:11 +0000
Message-Id: <20250120210212.3890255-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It is invalid to call clock_step with an implied time to step forward
as if no timers are running we won't be able to advance.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/qtest.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/system/qtest.c b/system/qtest.c
index 28b6fac37c..1a9bfd0b33 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -708,10 +708,15 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else {
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                             QEMU_TIMER_ATTR_ALL);
+            if (ns < 0) {
+                qtest_send(chr, "FAIL "
+                           "no timers for clock_step to follow\n");
+                return;
+            }
         }
         new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
         qtest_sendf(chr, "%s %"PRIi64"\n",
-                    new_ns > old_ns ? "OK" : "FAIL", new_ns);
+                    new_ns > old_ns ? "OK" : "FAIL could not advance time", new_ns);
     } else if (strcmp(words[0], "module_load") == 0) {
         Error *local_err = NULL;
         int rv;
-- 
2.39.5


