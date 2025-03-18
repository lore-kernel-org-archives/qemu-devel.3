Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA5C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZz-0004hE-If; Tue, 18 Mar 2025 17:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueYD-0001ON-3W
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueYB-0000rp-4m
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:40 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2232aead377so139696325ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333558; x=1742938358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfhMo6u4WSJa0m+zVQXeBrRktRhGKRYmsVkZ31uEjlo=;
 b=Is/Q9T7/eWSK3g8Lmin6RHCHW9AmKEBU4nPveWeGf7+83DWXnRsU/4eRz80s6YCCqJ
 l3Pse57RzREtVvEUms9TCbs8X/rsOihgSfnm4uYa2HHDA7Hgeyglmw7JQkmbcMqUYIA+
 htYaOQV6AsCRgL8h2wutuw+8KMu8CSr9L3DO+9NWbNagf2sEJjIBcDQhFjrk2chevhio
 rp//PIyQEnAolXrsmoGaCtoQvl2prVam3j63r1zU+A1OxWIjr2Bg2r63NEHTIk2f/Ak/
 dAzkr50gsYTt/jGzIbW/mUQnK5njxJ3qhjvewOgxUM0Zn96JETEnpzHSCpGRYnhhebYy
 mw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333558; x=1742938358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfhMo6u4WSJa0m+zVQXeBrRktRhGKRYmsVkZ31uEjlo=;
 b=eRDcHczVEla/1QDFLxmRu7HD7S5FfxCaFUVsXLueIYn2IetT1Cz0auUvY0/CK+sf9T
 VStcDnt16SQvwEOjOWqYjWfE43G26pvKnpDiFx7FBNVPXwGw2+J11yOcfWXaHTG6fOtB
 7cidH5rdsuCU2Sm+zHhtLEG7UlmkM6jqD3jcJBxjogc73UIgtaL9c/wCTZyCSDnuHyou
 y1ZdvTpJ3e0b9DVmjJiOBSb/UhDU4x9/TJJ+fY+N7EYHftghcx+sRZEjG0kuWur0jTtf
 k+2+DQ6OJmUG6wTxbHDsRepjul+Qz4no0iFv3myQMKE3/qFALvJVHtep7lSAQLmb/SoC
 8t5Q==
X-Gm-Message-State: AOJu0Ywmp5GzcQyrZWbyIA+co9ZYJrm3gNyJD6RiEnhj3FiyU9cafpVw
 6s2WXckjW6lc5/SqHTbRvlpHHuRFe8+yXVCHPAgYxhASDt7WRuHHTCHOH+dQyRrrpgs6PLtFb5C
 T
X-Gm-Gg: ASbGncu8X5HiNeuGhl7zjggLt9n7NBA2ttOpkRrsvj0nDKrH9V03VZVbq1q/NSWGz8x
 LABMoixIVDLsZLUaCiN9kFOr6sCQrlAVYkaneABeaAfSElrUUzdPwVrVynf4taZJswiGQMg7+YO
 moFapwP8StiGwykYLJBtecxoBMTy550Wpz56L2vow7O7NElAUkYr+BLd9U34fuK4scEWbSsJj6l
 twp8vxLX88Wu607OBrhZKtKHqDoruC7OnXWNT2DxLa/I3Dhh8ME6FqPqd0wj6ACBsfYJAQQlLdN
 ZlgujUEJEYCsw3CFifrcrh64TcC8M/CGxXexAEweEN7aEfOm3UuU65a6AIzekpm8yW0dkMX2kdr
 v
X-Google-Smtp-Source: AGHT+IEURdfnn4qlEekPba8oAMlbNpRDwYfNkgzEINCJAuhpAjBtzq4zgm9AMVwKXyZYyoGXE/VHbw==
X-Received: by 2002:a05:6a20:549c:b0:1f5:84c8:5d03 with SMTP id
 adf61e73a8af0-1fbeaf9381emr377145637.3.1742333557892; 
 Tue, 18 Mar 2025 14:32:37 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 39/42] include/system: Remove ifndef CONFIG_USER_ONLY in
 qtest.h
Date: Tue, 18 Mar 2025 14:32:04 -0700
Message-ID: <20250318213209.2579218-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This is include/system, so CONFIG_USER_ONLY will never be true.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/qtest.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/system/qtest.h b/include/system/qtest.h
index 6ddddc501b..84b1f8c6ee 100644
--- a/include/system/qtest.h
+++ b/include/system/qtest.h
@@ -23,7 +23,6 @@ static inline bool qtest_enabled(void)
     return qtest_allowed;
 }
 
-#ifndef CONFIG_USER_ONLY
 void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
 bool qtest_driver(void);
@@ -33,6 +32,5 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
 void qtest_server_inproc_recv(void *opaque, const char *buf);
-#endif
 
 #endif
-- 
2.43.0


