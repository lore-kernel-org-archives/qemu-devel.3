Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8048DC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPel2-0002mt-78; Fri, 05 Jul 2024 04:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeky-0002f2-9m
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:57:28 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPekk-0001uW-1b
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:57:28 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2eaae2a6dc1so19930291fa.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169832; x=1720774632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ho2Bfe7yXa5eu8lKetJ/WAF5D27mUTaA0a7vXnXcLIs=;
 b=mFoAOdUB6/t3Vn+1zMnJuodmIonBo0cOUFmVGgdsJ6CjzgKySr0PU7L3q9nro14D7N
 RvuBDSvlKOIx8jgJ0N+sLC2ZI46AirP31A9g+W0KKDCutt0iBhSj8qFl3nkz1/3yk5h1
 WuXsl/d+MwXddanKK6GnNFMclu+C+SM0zAkVyF9kgktll3L/cBCiVX7CJ5eXaSdZsSNi
 0uzJ51pN6IcsPZxIMmJAm5RlTfnhg1sRzSGcGhMM78q3B+LH1GfOvpwn7CMxOuBGIpBG
 4kqRQdWtzBgD0TDK2E9iXMxB/b+pMhxWG5PMtjxZF1/hTE6mj4YFmq5rV5QejjJPkHI5
 NTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169832; x=1720774632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ho2Bfe7yXa5eu8lKetJ/WAF5D27mUTaA0a7vXnXcLIs=;
 b=ZuyTe2/KtSI7K9aIQeo1KF1gSCU1+ywowzfkbB8Cmm3vH5fhM/4OUmDTjnHwsFLHWP
 mHLRxsuk2UsjtJOKxH7pu18W9Wib3s3pISoNG57aNNxhU06Sda8Ytsyr5z1O1VuwrIRY
 VNcBhdc9dsbH7MrT2rz7/4O1On12y802ZBFm551pP5snVCoUldF/LPsAqY/TmyRFUloj
 fhepCXVx2FdN2liB/5Wcg9wlkY9fq+2WFex4JON17QHETkkaGW8nzxYfwUN8KjJGdIhl
 oEqLWO6aA6nMvhJ0e4w5x91VCMewXgH8ymH+WYD9iYFpdQE+twTdxMuN52mf0SyC16wv
 npsA==
X-Gm-Message-State: AOJu0YxZ0zjyarDfuKFq4O6mFcAV1E3+F20mJwHv9ldFLKO3U+w1qBi+
 U0JuuC4EthTTiphjeY1XhEFo3OqxDrtTia94N7TD4Lu2bJEt9u23POb4/quj+uQ=
X-Google-Smtp-Source: AGHT+IHfZol7NkpqhMgZI+ueTbQskITA3RtbBrKeyqRVZF47QARE14/7WoFDnDzuzhXOLEPchKKOpA==
X-Received: by 2002:a2e:9c8a:0:b0:2ee:80b2:1ea9 with SMTP id
 38308e7fff4ca-2ee8ee21297mr31636331fa.49.1720169831473; 
 Fri, 05 Jul 2024 01:57:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c0117b15sm101350566b.43.2024.07.05.01.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:57:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E720B6213D;
 Fri,  5 Jul 2024 09:40:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 23/40] plugins/lockstep: preserve sock_path
Date: Fri,  5 Jul 2024 09:40:30 +0100
Message-Id: <20240705084047.857176-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

We can't assign sock_path directly from the autofree'd GStrv, take a
copy.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 237543b43a..111ec3fa27 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -347,7 +347,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 return -1;
             }
         } else if (g_strcmp0(tokens[0], "sockpath") == 0) {
-            sock_path = tokens[1];
+            sock_path = strdup(tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", p);
             return -1;
-- 
2.39.2


