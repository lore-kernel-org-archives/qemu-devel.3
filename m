Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD45C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWRf-0004ht-Qa; Mon, 10 Feb 2025 11:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR2-000489-Bu
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:01 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR0-0001Up-F2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:00 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5de4d4adac9so6064050a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204097; x=1739808897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALPFRjqBCzN5IspKKvq+gGyQjhJlGV0zlBdiRI50u44=;
 b=qrWk3F7Qo+P9t3BXpU3FAF8mqCa878vHuRKnKf+Na5kDSZCkK89ZcrAPOSwuQjdt08
 xtqGO7E2EHPVESs4D0KVaZ3RbQPSG75msyqYPL5Vi9UrgaY4g0Mwo/37NH18w3rbIDVJ
 pVOaFkHJ0XuQZyZ69nKeVw8jhIUof3RPFOLsKxgL9JiKTUNGETl6ETnDcniAw85l/1nf
 a7V2wvCDSuXyPXrIcMd2VI3w2KG/A8F0IpKhY5walszHEBhVHtBsQ7YiJ24K5I0txeb+
 TfVext7UVasrzMWjLD8XdSyMA888rnS7xeHjka2Xr25u3xElo2kam9EuaGlst5nBt07Q
 hE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204097; x=1739808897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALPFRjqBCzN5IspKKvq+gGyQjhJlGV0zlBdiRI50u44=;
 b=hdF1wqaDILAG6iA7xD+TFqc/4+M2a5IemmRZflvZ65KeXPhwqoVGNZWATNHRdaVJkm
 E3a6M7IHs2fdRtjWQwuYejPo7BHhjjbMDXIce1jVx5dJkdG+MWdLDW6D2uMJZG3Lxw47
 ZVx0pLdsp5Tho46X9GUsM2EVA2x8PVThHi9VCSTLfIzyA/XIY66Ccy4m4TrmfWV8X/+P
 AG95X9hFVTTwGWlhkxQ1E6rsx6ENhZJWQG2DInbec9ESzxzW+EfrLIc3FbaJ8QxOTvty
 kauwEC2qs3j21OgBplQHQvhIdvMdRZBoxr+DuhFCRnHe0hsOs72lX8r6kDGOe9Y8u1Bh
 AaGQ==
X-Gm-Message-State: AOJu0YzQGSyKXb/i2JxeIVIGbfaGXd0KFYUrZMLTVUsQxqTHdmMc8HdM
 bmdlQnWeylD0R9LXJK8AYoXyAygtLsUFL82TaOSTYhacIL4li9lshoFLdyCS9Gk=
X-Gm-Gg: ASbGncsTg4Bj3kjvUiuZtPYDEKMkv0OKOxegLdtPTCdfhVNrzjPF51fk3WYEAxaUpIJ
 5nbGa3x8FKpf5JBdGHwx/GQiFrsSzPVVDFHCVXnWbZiub7MuMVCsoSHMo/IEcV1pz8/qoNvuqCp
 9cOkFNEToZkCkpsS6IE4d4YuyVc/KVnQNzkrGkQ23KS71E4icKFDAcvojGTSb++vNJKVUe/V2jj
 QFa/ZPa5Oy0yQi+cWN9wZKN7mF95IZ3AmSwT/e72ic2G/SHrfGfhiquTGzfSPkWo+YpbNGVeR6J
 OTb9o1eymfJD/syYYg==
X-Google-Smtp-Source: AGHT+IErRl2CvwHSOtOdyPyDYD9WUPeegFpG0YcGycdZEE4aU3VltBS7tgdl78Mkg0cQ1H4CEiFaGw==
X-Received: by 2002:a05:6402:194b:b0:5dc:7fbe:730d with SMTP id
 4fb4d7f45d1cf-5de44fe9d71mr17348939a12.6.1739204096717; 
 Mon, 10 Feb 2025 08:14:56 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b73f8csm8003497a12.8.2025.02.10.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 23FB25FB53;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/17] tests/qtest: simplify qtest_process_inbuf
Date: Mon, 10 Feb 2025 16:14:38 +0000
Message-Id: <20250210161451.3273284-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Don't both creating a GString to temporarily hold our qtest command.
Instead do a simpler g_strndup and use autofree to clean up
afterwards.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-5-alex.bennee@linaro.org>

diff --git a/system/qtest.c b/system/qtest.c
index e68ed0f2a8..bb1efba9fd 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -763,25 +763,21 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
     }
 }
 
+/*
+ * Process as much of @inbuf as we can in newline terminated chunks.
+ * Remove the processed commands from @inbuf as we go.
+ */
 static void qtest_process_inbuf(CharBackend *chr, GString *inbuf)
 {
     char *end;
 
     while ((end = strchr(inbuf->str, '\n')) != NULL) {
-        size_t offset;
-        GString *cmd;
-        gchar **words;
-
-        offset = end - inbuf->str;
+        size_t len = end - inbuf->str;
+        g_autofree char *cmd = g_strndup(inbuf->str, len);
+        g_auto(GStrv) words = g_strsplit(cmd, " ", 0);
 
-        cmd = g_string_new_len(inbuf->str, offset);
-        g_string_erase(inbuf, 0, offset + 1);
-
-        words = g_strsplit(cmd->str, " ", 0);
+        g_string_erase(inbuf, 0, len + 1);
         qtest_process_command(chr, words);
-        g_strfreev(words);
-
-        g_string_free(cmd, TRUE);
     }
 }
 
-- 
2.39.5


