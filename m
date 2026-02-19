Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936BDE9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fa-0005U6-Gt; Thu, 19 Feb 2026 12:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fU-0005QU-P6
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:24 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fT-0000Tn-Bx
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:24 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6580dbdb41eso1528223a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521502; x=1772126302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCDkr1jO2SJrSBq99OhOFgeCFzvnaZH4BPYFgm6DI20=;
 b=U9y3tvTGjJTwQ2i1M3/vRVzYcRWBDC+WkX4CIQioYXmVBUglvHWRh6bZAdnmn4H02E
 9q+H7t8+5v/n80SaJiVPkMLZuwhcrVYULO9uG9hOU6QvkxlFEB/rDbUsmCZRAL1ladeK
 685PKDTHS8KT/o9D2aoE/cahZsIozeLSa1L0E0TwScUVLhBaCTkc4umQOf3XMFXaE/Pn
 LT3mjftswObJ8xz9qk9eNBpWDURIHr4umqvlT0I90RgUcZG8OLOmbnnK5u/lKI5LsbQn
 DB3d/JPywG8DL7KIEWJIZ4Vc2/3Y8GmbtoFrwMi7pyHBqWO62zVIlc9u6o3nsEF2fisS
 WeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521502; x=1772126302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tCDkr1jO2SJrSBq99OhOFgeCFzvnaZH4BPYFgm6DI20=;
 b=D4pYSzHIW2lWYnVR4rjBAD1VrDSQ6m1ypmFxAnSpCfiAd0MTaLlWJzEzKfpZenmJto
 c+14P2YFd6ZmJimYA880a+fC6Dl4ZAmQpKhXjQGd06qCFoC5I8TQ0ojGw4CkHWNKEVme
 XGzLPCyVPzr1MFdXmKE2CiCaROKwDuNNSMf/Qofg5jXieVUv6YLIqDF54JoP3L2V8eU/
 CVvTtFuvTq4WdoID50uZ1tX9zhhwNKBV/FgO0mISuzCVZ6GQIrScYAxxI821yAf5jx+d
 gY/ajEtIEtvDZSA1Lrf51PsgHGT64ONiyZujgwwpXz/8pbLj+2zgB42WtZUaDoSDBitK
 VBeg==
X-Gm-Message-State: AOJu0Yx9BRj2c3Lt4HlPaLKWWIwBQVXxttHOx9i2hQR8ejlqmeTcbRnq
 xAep7775pfGCSYYIfmFxCRrJJptj3zHOfEZMCAMZVHH48/wcBSyCh7pCqQT2KnnMzCA=
X-Gm-Gg: AZuq6aJpk3wVH0857hoDld7nnkicAgPb6mvaORcOevk9SQgnX9yCyFervX9kTJfggMD
 njKKqpF0Oaz+Dn7gr0om7OKD8iWqb7+59Fv89L7APlD2VJRWfWB4+ChccuHzYoFgNYGJrOVBCTR
 NLOz1FsVU3EpOzf0JQbLZdpDxU1q4F2GkwEQOZVhW9tfuCPcfx0H2qxLqt9rBQM/OJgBRtz/Kwh
 W+EnwLbfUHtBRff/zi7/GQnkes2FuJ4AZI8/ldU6TKWKWeD9ABbzt0GwYlWJtrFDb4SaC6eLwPm
 4vcr7KznppMYba9KLHoJS28V1Nhw2oIADG660+fYhgSHnmIo6Ggx38+cMoO2xWFfcm+J+12qc0B
 XqyfmcWd6UFoXMvDbnR2ytW2QvVUP/vxixMVnqn0yQic3KjYL4geOmMZ9lkOAjdwDudbIZTBgE+
 ej78FS4BBO0P4H9fW5WzRNgbc=
X-Received: by 2002:a05:6402:254a:b0:658:15c4:6790 with SMTP id
 4fb4d7f45d1cf-65c76a13a38mr3577387a12.17.1771521501815; 
 Thu, 19 Feb 2026 09:18:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad2a9d1asm3984008a12.15.2026.02.19.09.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BB66C5F8DB;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 14/14] include/hw: expand cpu_reset function docs
Date: Thu, 19 Feb 2026 17:18:10 +0000
Message-ID: <20260219171810.602667-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
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

Add a hint to the developer that this should only be called from a
reset chain.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260108143423.1378674-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ef20cb356a6..89934b8efe2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -815,6 +815,9 @@ void cpu_list_remove(CPUState *cpu);
 /**
  * cpu_reset:
  * @cpu: The CPU whose state is to be reset.
+ *
+ * You should refrain from calling this during CPU realization and
+ * make sure this is called from the reset logic instead.
  */
 void cpu_reset(CPUState *cpu);
 
-- 
2.47.3


