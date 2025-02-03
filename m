Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCA1C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdc-0003rI-IA; Mon, 03 Feb 2025 09:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdI-0003cs-Mg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:05 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdA-0002No-Qc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:04 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5dcb060ca2dso1609216a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593655; x=1739198455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhXT1GZ1FosRrGUDia524QgRgPZ6Dnd20b35E6F9zyk=;
 b=fAM5l5sFMo+ZDLJDneB2DtWyteAByCRX0zM+gtzG3XCFZdVqjiGwICAMoOFJqTpZiV
 CGTNZ+d2Y1jh6J8i6cFK10MeMIfM5IJV8H+3eO/8+6Ll+8H6WO9hsCRDErXGDfB4xyN8
 Ees/KWd9JQPZfTtwxk//YcEMbZ4WSc9W8I5nuiwAc8m/p1cfvLFSF5SANxzHXzet/ZvP
 QJmYqAm/IlJRg9ciUzQSTcsPijKw8KFWZmgNPjVri40GA10/a08PIoQvbLGeVrpFDlJJ
 DX0+KcgJ/ygqqrcV4NmaglLutgPm7hzUjrPgL7zP1T9g08w2LCUKWrRMOHSSjWdmPo8P
 mhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593655; x=1739198455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhXT1GZ1FosRrGUDia524QgRgPZ6Dnd20b35E6F9zyk=;
 b=sFhT0rKFkFPOmzkvDNX7HDxtNPD+SKU8bOxRSar1hiQ9ErxIq+72a3v+VcaJcR7nl4
 oYVp0RqH+pBqiVy1nSFFxk7PGOqAYplSGLH6+1bvW6JY0+jOR1bgswLHfPZypIvRb2Da
 H0X7/NSYT/r4XloJpCNwUM2X23EEyS5oAFchJcnP51ulgqt/a4z+ZU98VBjVIxndnKCt
 GljUI9Q5M0AxQMoSyoQamcIKASl7Tz4a8Yh6yRaCNNa2P2UwUzyyk27K52hcWUByO53D
 G5yy8sMQ6lQLLN8PCct5kzgGmYw/+oOOZrgj/ysJMsFj0GF59o453/NI9wdBv7DCDoJM
 ryYg==
X-Gm-Message-State: AOJu0Yz3E4J9U71YkEaQt6f+LQ2ZMDelN4bqXMCmsXutbYgvxhVGlzjQ
 QfJ/g8+i9ysn9ZrnfXTxBZS/L0U1IDvk+VqmCLR9szd1TDmgTnAloKgRi7qLO5U=
X-Gm-Gg: ASbGncsZqOkA7Z+kyZES7tLmr+ycLQJIwVsp2eaZHkccUOuQU2cbMux79SKD/eXI6g7
 7ePqXT9szpFmhoZfAVjf7YKLRUH70T4aI7nqWy5p8atFoedqRvkwdqajV88DpwGnM16nbyisK9E
 v3n5WlmgIaddn+5tkQeI07iZGYKsp1d8OggDB6LkKo3JBzKQgQGRsoGO7491rp6819hvpxjdZXL
 lsCDVckifTKHOvExfnfGj/ZAbJiWt5MedgxddE6Pzks5nIjO2qgpjdfpM+/xgDd3Y8WRjl1eu94
 UD4GXGO7Vncu/uLRpA==
X-Google-Smtp-Source: AGHT+IEF55yHkBqlJq6QPgVbWxirBkxKNLZQZIiikbn3ExvNE7aVlzu+OAbmA32EhtV11YstLN903Q==
X-Received: by 2002:a05:6402:4406:b0:5d0:81f3:18bc with SMTP id
 4fb4d7f45d1cf-5dc5efa2fb7mr22965907a12.1.1738593654930; 
 Mon, 03 Feb 2025 06:40:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc723e9fa7sm7741236a12.20.2025.02.03.06.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EBA05FAD2;
 Mon,  3 Feb 2025 14:40:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 06/18] tests/qtest: tighten up the checks on clock_step
Date: Mon,  3 Feb 2025 14:40:36 +0000
Message-Id: <20250203144048.2131117-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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
v3
  - used Peter's suggested wording
  - used plain old if over ternary operator
---
 system/qtest.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 28b6fac37c..12152efbcd 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -708,10 +708,19 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else {
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                             QEMU_TIMER_ATTR_ALL);
+            if (ns < 0) {
+                qtest_send(chr, "FAIL "
+                           "cannot advance clock to the next deadline "
+                           "because there is no pending deadline\n");
+                return;
+            }
         }
         new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
-        qtest_sendf(chr, "%s %"PRIi64"\n",
-                    new_ns > old_ns ? "OK" : "FAIL", new_ns);
+        if (new_ns > old_ns) {
+            qtest_sendf(chr, "OK %"PRIi64"\n", new_ns);
+        } else {
+            qtest_sendf(chr, "FAIL could not advance time\n");
+        }
     } else if (strcmp(words[0], "module_load") == 0) {
         Error *local_err = NULL;
         int rv;
-- 
2.39.5


