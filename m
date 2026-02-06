Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC17E9D3F3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDMC-0004Nr-BL; Thu, 05 Feb 2026 23:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDMB-0004Ms-3v
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:11 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM9-0003UV-8M
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:10 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82307c6902eso869856b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351728; x=1770956528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2HC49N+r3FDo4kaSsrqfKOmxBBKt7bfTNmIl3FbGEg=;
 b=c15VwPBAhXc3rlCBggHjwBMtOFapJ/E6RKFuuTOMxfWplVOC6gq+KU3p0YlAcaEHej
 +dOu+Z3Lg1Q1xruAa0iM9rO8F/GGq+bmhAbDmH9oSLQSLiz8inxWCj9acBq+ykWrmJMB
 drziGgARByp3wwExYq/1d3FBePzPNHq/nMt8RUMYBrcmQ2YHJNT2q+6jDQNSe57huwgs
 LUKt6e2EVuhA9PppjlmhuI4yiYVI9eEP0Btj89kRAfP209IBRwmM+Z9+tv+DXHIb2oL5
 Vzy5dbZ6uIKuvwVx5RSoWHLgwbZiIal9JKFCAqlxMa3qa9damkF6dWvYejNk9LYphBBi
 mZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351728; x=1770956528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q2HC49N+r3FDo4kaSsrqfKOmxBBKt7bfTNmIl3FbGEg=;
 b=EAxvndYxL+bnrpOF5qts+Xnm8EdbYxRS6tghSnYj0mZWT4HEP51sySDqK1LAms+MgI
 Jnkh2C0NS/LNylbdGCyL1BbADwj4o7HWrrKiEKW0SpbQclNvk88WK+AzN+W0Dyiza2JC
 jIDNm3/GuUNMIz5gGTQLvYDm1DpnKX5YSbijAZuZJh7wPjjCDbR2XdE/PrpRClsrmcTj
 rAEI+CPOio2HBgCAfPB4kdTymZ0odjS5fsCKzJbiqI8a5Bl5ZJnMyWkPZZCH4Fr8616d
 /eMH/tWSuTUww9LN+GqEQZMbol8YzooDMOws5Jb4FBuGA/+pSOrU3HSzbU/PhpBUs+hd
 X2Yw==
X-Gm-Message-State: AOJu0Yx+jWRa5s+Nw8yEu7mOFlGPi9WlBSDKOFrPEL4N8wCiCB3J9j4E
 QTk8bT7MnRl0VV9/GGXunZlUSZNi+T9AgETjI7GNirKsDMNF+dUWkvnmdqV4RePCWG8w0VqhIWx
 1A+qa
X-Gm-Gg: AZuq6aIErG5FQeJSirmKNc6zYP6GbnBpZ7gxZbRpdy2nFHGRNlu2tYxsdKQKCxifCq7
 PJVN7glzaoNBUDF8jWwB+k18/t/TAN+c9NofsmhC9nsOankEf3qHDSX3gskPn9Ow6EAN21WBEb0
 m16GrBaQ/3UrHctQ/llxmhJkzwUThvggj5mW8DjdYT+5zI8CmCoD8MCQ4FnVa4s4mQQhbNmjLsh
 +PV4DWMaGjsAMD3Ce8c4kJb3mKYqdiOyDRY/OWA+1UF6OZ2DkDPPhbs9BmbonhaW+STyUjVzf1J
 N+Egx3U8wkJQfIqN2AspmUtyqEuATexZlMTp/Z584/FA7YXgA+V7jmCtRrfFRSbkYcN58wBrXAh
 VSpvH8ZKNY9ihs0wkqIEV8YS6cfAgaE6ULqyuXcg/wWM01pyLQ1omnC1dcjL2v6DsYNtvKchU3i
 bw7V6aCH7ES4Osf44HHNLUXWbA/leS35K0lI/Smu+5yLnAmj5X0k3BsaMHVCNn7A1r
X-Received: by 2002:a05:6a00:4acb:b0:823:167a:4790 with SMTP id
 d2e1a72fcca58-824416244a9mr1289097b3a.26.1770351727946; 
 Thu, 05 Feb 2026 20:22:07 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/12] target/arm/tcg/cpu-v7m.c: make compilation unit
 common
Date: Thu,  5 Feb 2026 20:21:47 -0800
Message-ID: <20260206042150.912578-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 12f126c02cd..092ea218c92 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -49,7 +49,7 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
+arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(zlib)
-- 
2.47.3


