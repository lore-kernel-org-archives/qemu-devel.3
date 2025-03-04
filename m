Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18459C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpami-0001jz-SJ; Tue, 04 Mar 2025 17:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpamC-0008FN-Jo
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:17 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpam2-0007my-M2
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:07 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e535d16180so4085571a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127393; x=1741732193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6DDeqPK1m6ewykNxxzzXStrfWH34KNa8iyzVW/f3D8=;
 b=WGH4L7BanjW/bEYumIveYp434V0zrCNl/AvZz4mX/ln/NV0FsQ7i74eYenOjfSqSHI
 1cohN5AGcL3zOODSlSM8mrBxHKa1anLVzCDjlgra3ZIpfSk9U5FIy5nc9hkDozi57kUj
 UKVGCHYqCiroK/tvIlXQ7636KTqvwz459hrmzaTWYoRL5e/ChHSQoUl4UeON6w15xXZt
 T2cEPBMyBtXCE9BLNZJAYdKmJyirXaNFfz61raVxLK1iRL6etciQupMfEAk7N447O0WK
 /aO2hbVSRHgmWk0s6A0CGMxDKCHQENmwXuK0I8qSnpHi69zdeoXuGOHvzZc6C3WOLQsN
 1thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127393; x=1741732193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6DDeqPK1m6ewykNxxzzXStrfWH34KNa8iyzVW/f3D8=;
 b=GnhsKAs1IEJAfKOP9QSUKzXI3Cr3iqv0J4iC/2yZUw5xFySks64ZDado5AyaSqOLj7
 VNXvnR67tEqsw4ZwuHtt0Bzh66H1BTp9Xjwr8S5BcejYZzcjQFBFCHCMrN2XREHTxZj/
 60OR3Aftl0vaRPxZjgrRlA6s6YbAEW0yoNcqbdlL1lefNe/xTYM/0d8l2X3FhERi6EMI
 nd27I8545NZPSH0tyeE4+dwXtxLiy4x3AelBhE7atb4fbZ+DIb0ZupgVMqjZ+7G+HIOb
 JvKIDj6i1+tbYeTJgc1kPzpjzHs8TuH8jm0PSzqQ7ChW2saq2diDXQAPip9WUeZGlPeR
 6PvA==
X-Gm-Message-State: AOJu0Yw6heJjpTJWHaX9g3X6+Yao1Og4YOj2fKqhLf7yHJYKCYGxOCty
 DaWErjZOIOjwSf/h8fjNLUSxsN0b9ikxVRzsJ1JDnmJ5hq9AsZ8mziTER6f+IFM=
X-Gm-Gg: ASbGncukRhaFnI84Lida6lUFggcrHtHYxPoEYwoeQnrNotlnOnVYs6Er3HGj8c5WGqa
 zVKIzdXYPWhIb07FtsvQXYWgSIX4mkDuGMM32dEEwio5wn9qcHwjb2rrvA8xuFHe2ojhg50XYLx
 QdN1OiN63caJjH4ePW8rzggIv6EJOVIHHbyWsiLVMUCzHonOiH4Ytw26g9ywguDJ4H5Msauhz3O
 t3H57kkpY7DCyPRYDEDxzMjTs2KrFXHZOTcndLTbkvlPsVEsgT6LYPHpUAMuAxjd5lF31i1vmNu
 0l0651mPZNmjoOl0+LI0G35xX62GUcy6pBMpSaqIf+iCI5s=
X-Google-Smtp-Source: AGHT+IFog/uE7lVP2k+1tQ3C39xfQubG9TTt0sA2/UPdk+vaQhliqoLLt2vwMzADmGJAoeiZhZVVyQ==
X-Received: by 2002:a05:6402:35d6:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5e59f3efb5cmr1781860a12.17.1741127393588; 
 Tue, 04 Mar 2025 14:29:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb51e1sm8997174a12.61.2025.03.04.14.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D44360858;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 21/32] plugins/loader: populate target_name with
 target_name()
Date: Tue,  4 Mar 2025 22:24:28 +0000
Message-Id: <20250304222439.2035603-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

We have a function we can call for this, lets not rely on macros that
stop us building once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250226140343.3907080-17-alex.bennee@linaro.org>
---
 plugins/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/loader.c b/plugins/loader.c
index 99686b5466..827473c8b6 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -297,7 +297,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     struct qemu_plugin_desc *desc, *next;
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
 
-    info->target_name = TARGET_NAME;
+    info->target_name = target_name();
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
     info->version.cur = QEMU_PLUGIN_VERSION;
 #ifndef CONFIG_USER_ONLY
-- 
2.39.5


