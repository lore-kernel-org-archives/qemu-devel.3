Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BBDC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHU0v-0001V1-Fz; Wed, 12 Jun 2024 15:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU0q-0001UU-TM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:52:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU0p-0001hm-GA
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:52:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70436048c25so179295b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718221922; x=1718826722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPN2j3d8Uxe6THZhv7lreo3SEMvYCFajl10m+bHCIeY=;
 b=A7ArQWLLsVc29Q7cXVekrsltOsPwnk68Lbef9szzmRIdpr2s/a+rni8U/tljst0S94
 Yy3aRQzWUjzI+lLrg1MePRpyG6aB/Q8t0uuMaVkY37yLhmkpSIhO6kTE64DOH5GSfagt
 smbnElUMzprK2GzOl9OwpsPPLW7sO8U7AQ7CcREAAiTSR3td2w2oqKchAExRni92EEo4
 WNQjckxIxrKqv0ZhzDJKggvN+UYpqGI0Tt3eXPxIFIH56otPNyIFHLeoKVuW7hOBsr9J
 9rFRNhjmuHWaykLru+swjH9BQF82bCrCzrEKLUYk9/NNY158IsZc0nJFJaYpvvYvGIKZ
 gCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718221922; x=1718826722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPN2j3d8Uxe6THZhv7lreo3SEMvYCFajl10m+bHCIeY=;
 b=G9aTt3MmkBGKTcGbMdZcdXs5a5bqOjJbvKrh4+Z4RS06PUYc5NtGNCZRTSnu1r5IK/
 5wVUBY4JJZAR7TZuwfs6NwhD7eEhunZ90U+OZ9d7SvDG3PjA8HS3qwrPETlfz7hWTmo2
 0i4m6hVNo4u2w4EPWZugJ2gimvVJdfQjI17VIo4O74337nsruatPdgr2duCDCWPfTXV2
 21k3weFCs8nSDZauUfM0V4HYpR4fTJvOv46lsHfDsV2Bb9vzWXI3sKdW8iq5rblzc6pa
 qSKbXYd1Ws1Z9+3k/0BnI7cP84Gsp4JUVWwK8W5239oRy6lv4XD+WzoqSoIvRhGan/m7
 nwMg==
X-Gm-Message-State: AOJu0Yy+WntQS4Q9agqTE8OJgNokrxDS9fkWajZUtVzGNK9QAe2p7MM8
 MscICjZkBZdmpyep1yffFFwrSmp+7kv+AaTU/BmzefCccKQxiR+OIo3ietQwH9MS2gEb6V1P5l1
 7
X-Google-Smtp-Source: AGHT+IHE1MJIat//Ww4gGPbOdoPRQdtlYUDw1BM9kWVaPUwA9zT8PJHv8osUpZJMra6L10A5BuPnlA==
X-Received: by 2002:a05:6a20:da9a:b0:1b7:406c:107d with SMTP id
 adf61e73a8af0-1b8a9c42286mr3038420637.27.1718221921704; 
 Wed, 12 Jun 2024 12:52:01 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70424c7fc99sm8009927b3a.157.2024.06.12.12.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 12:52:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 1/2] plugins: missing QEMU_PLUGIN_API for time control
Date: Wed, 12 Jun 2024 12:51:46 -0700
Message-Id: <20240612195147.93121-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612195147.93121-1-pierrick.bouvier@linaro.org>
References: <20240612195147.93121-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 80b1637cede..310ee10f301 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -670,6 +670,7 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
  *
  * Returns an opaque handle or NULL if fails
  */
+QEMU_PLUGIN_API
 const void *qemu_plugin_request_time_control(void);
 
 /**
@@ -682,6 +683,7 @@ const void *qemu_plugin_request_time_control(void);
  *
  * Start time is 0.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_update_ns(const void *handle, int64_t time);
 
 typedef void
-- 
2.39.2


