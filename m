Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9037C02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temym-00080d-UU; Sun, 02 Feb 2025 22:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyk-0007zP-Uw
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:31 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyi-0002er-TY
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:30 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-219f8263ae0so69179095ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552707; x=1739157507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAfl37xDnFz/0zdZPRXfsa8UPn/22lXCD6HUC3zbL6A=;
 b=IP5uwkmMR/3OqwVfKCLpFY07vV0H32DB+53tZP7jBq+Pf5/KuRiId1QwZhvugCfXzd
 i4fk4LBroSfexomksM/5VrWyU2JEThDO5jnrrl9wmBGOINYIey/YniR2J4LafMxGai8F
 u8/oXIfbbLJKu7+ucbeOuYK4WaXhm7O0ML/Csf3Orl03ry+cimxRXKMFe15MDFKdfY3M
 kTZbvLGVESRWW4a4s0O/4CibFmp4qd0lUTrUxOYN5Yf5/VOXGDvlkuLLQEIAMSHV7pE/
 rJrFO5lX2LYSJN0+42dTj7yBFg+iaCN6MZN9Qe9H+ip65cxE7A2NfoHmaOfKJSLhjULm
 d1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552707; x=1739157507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAfl37xDnFz/0zdZPRXfsa8UPn/22lXCD6HUC3zbL6A=;
 b=idEw9m9sl/C7uzS/2d8kzi4+++AKEfhGOLUUzjqI+2F4spXUiKhUb9ZXFMaiDJShxq
 rsbCt2s1vqPOAALQGiFE6+iNVfUcsDTwI4MNEmTs4BUlh2NEY/NvVLugbS5ykJd7m5lc
 rvVzonhFUh8U8z9f3E1N/kWsAweBgv4CsnepKAWr+JjfKSAkXpcVcggEykD5yWr+1znt
 X3XakTEoGpi0PmRQSxBf7TuhMjNKwO5ieNjTBTnF3ylKUwIIYDxNj5BA/75BMRh/1V1j
 ru65Fiw8+yLGvwa7FK9bnoPUwc3LqNOho5LraIyFaAro1P8kK8nxlGOWamoOp7eNLybF
 ViGA==
X-Gm-Message-State: AOJu0YxJj90eHm9RTrUPP3VMeK/FfFY3FW7rkPYAZI2eymSnb/XhI4yc
 9eRZ+ET1h84bYK4fiCVIu+jGahA7yiF/f5v4Ff+y5j1mAQgOyPtdJb+XHQBZMi44vO3qWqaX/88
 P
X-Gm-Gg: ASbGncsFwedZSDBdDh08UdWjBm2HT5cuAjaJxMATEUsvzKZ/SZ7+CExNZaxKylfZavc
 G63Xnh6/8DSk4LcmHIlNrvXxQNZb5sl2zFVVmph7O31L10YQYmN0rAc/qww3ciRJh+BCecosyT9
 huc4zjEEI7zlJzbtKC0zyObPttyzx6eOFWo8ebpPAXIvS8BDmevVXlSs7Yz5y/1UzcF28Da/L+D
 b5++DgxQXZUQn9tnDtZ1tEC3YxnGqEiw4L+5CghTT+3fXfS4fIDFdd8X30AlDnOgE0HQJnOpNJU
 F2aSSE5ONkBPmi0XyKaQP7OgmU2+OGujWQTz//2xASRsHUM=
X-Google-Smtp-Source: AGHT+IFsT0lMqaFvXVFpixRqd7sjOpA62/A3rL7CCzuBFLS44z0F85UL5uxYuqRd0VGggYuVKlBCdQ==
X-Received: by 2002:a17:903:947:b0:212:4c82:e3d4 with SMTP id
 d9443c01a7336-21dd7df2d2cmr329309785ad.46.1738552707343; 
 Sun, 02 Feb 2025 19:18:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 05/14] tcg: Link only when required in system mode
Date: Sun,  2 Feb 2025 19:18:12 -0800
Message-ID: <20250203031821.741477-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Rather than unconditional linkage via system_ss, conditinally
include the static library via specific_ss.  This will elide
the code when CONFIG_TCG is disabled for a specific target.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/meson.build b/tcg/meson.build
index 2977df5862..8266bcb324 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -49,4 +49,8 @@ libtcg_system = static_library('tcg_system',
 
 tcg_system = declare_dependency(objects: libtcg_system.extract_all_objects(recursive: false),
                                 dependencies: tcg_ss.dependencies())
-system_ss.add(tcg_system)
+
+specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: tcg_system)
+if host_os == 'linux'
+  specific_ss.add(when: 'CONFIG_TCG', if_false: files('perf-stubs.c'))
+endif
-- 
2.43.0


