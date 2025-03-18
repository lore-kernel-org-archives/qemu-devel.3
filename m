Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE72CC35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZD-0002JL-G9; Tue, 18 Mar 2025 17:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY7-0001Lm-Tl
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY6-0000qE-7F
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-225d66a4839so1014385ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333553; x=1742938353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhN0H72crR7ocnAMdx8d6CUFaK0puwv/7eMWfuXv8/4=;
 b=xjWR3DXOscRn9v9DDL4iZioHT2HlQYjcO16CkTV4riLuWjFdidqsbBvN5Af8+c/1oB
 sjO7iNLqHuNaaJ9RHhe3M7hjmYdxKheU2sDLO/DQi2h33UJAAoe92LEN1o7cINuJfDhp
 e+P4XHf2dqNsWIQ1cs6W8mcdFu+W6k74K9oRPnqZ62kv/32RrWi+LeCJ7HHQCBfc0n6d
 NO/EtgOFxKvrLT9fC+ViEvxq9gWNxYDRtyNZR9rLlq9YvvjXajl7zuGOhhnSZ35ahso2
 kS5J5+kTUomuWBiRpD7IEeCKDRSGG58G3IM7HpdD+4EBssS1eXsegYhbEkON9Q0Pa9G8
 lTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333553; x=1742938353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhN0H72crR7ocnAMdx8d6CUFaK0puwv/7eMWfuXv8/4=;
 b=pwZ1wzWxe4G5KBZkDnHgRTWCFWiyIjwCo5JDNzCt4yjY7dMH2RsZS1ld9+yqn+aPBJ
 9m4DcvZlHdQ0RV679XxT9uMdx/WE/rkmNJuJ82LvsiyzZKPNW21mooSBBSRbYv6oyZb8
 4hsnmcQgPFD0Q4RKMzAPfBUHCb42PIqfWrMM0SEh9cKXX9zR0T34WKu3E3snQ+1fBUm8
 OzIjH4tfllaYyBZiY4aTuBe3wVDMlUz5fSSLXYFiQgu65dfy/oPKZ6JjYW5cFZta/LWM
 jRIarommAg+dMc72alq0JaI/pR5bApvGvlxUO2rI7uHAl/xizztEVFar76IN3ol0jhE/
 4cOg==
X-Gm-Message-State: AOJu0Yw4/eTrQQ845HRhPB5sbus71HOoLGqkOdP5y5SdS2wZnkyWq24R
 g5rLDKCk30+QhiSpQ1BEsTtoW+XqjiQY51agJnFVBvgLqB7ryVeI+2xfeqdqQpSIPFdXXdHLLf8
 E
X-Gm-Gg: ASbGnct3IU/I32BUVc1qQLuIkcaQskYuib6KK/gqh3OAWtXmjP4Gt5bZswXGkxnJt/5
 9kLUmJM+yK2qZTEXaILSpOUVJeLbYR3rNOS3ZWqrPDfUpCD5axQnHcu5OIjYLtp4cehdQcqupNl
 /PXpTR1bDZ0EUL5SuwH5TYpwkbhZ2b2B6ZGSq1a7xvS5B4pBzNymwWnK95ZNyMVtvCp3FsugRM/
 fRXSVzgYn4KK14aAjVwVdVcWuxc31qbvkyzkEoumP6oZYr1aInUNDUR2OD0K66PX4Fp9onCc4f0
 xv0qBTuSuu9M7Z/QZ0vlqEqOD5T/An5HU/MrlomOh33iHP+Q1o5D8si2V875P7gN6cNbNbawU+Q
 i
X-Google-Smtp-Source: AGHT+IHPHqcmO1aiv/ckrDmBMz8m3MtQNoO+Am8iRCmpE3FgWEOVD8UrddAVOiWth9qy2StcMEddwA==
X-Received: by 2002:a05:6a21:104:b0:1f3:2ae4:82df with SMTP id
 adf61e73a8af0-1fbe26121f3mr451758637.21.1742333553031; 
 Tue, 18 Mar 2025 14:32:33 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 32/42] plugins: Move api.c, core.c to libuser_ss,
 libsystem_ss
Date: Tue, 18 Mar 2025 14:31:57 -0700
Message-ID: <20250318213209.2579218-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Headers used by these files require CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 3be8245a69..5383c7b88b 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,5 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c', 'api.c', 'core.c'))
+libuser_ss.add(files('api.c', 'core.c'))
+libsystem_ss.add(files('api.c', 'core.c'))
+
+common_ss.add(files('loader.c'))
 
-- 
2.43.0


