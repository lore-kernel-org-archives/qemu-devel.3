Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A229C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYdd-0003yM-Bx; Fri, 23 Feb 2024 11:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYQ6-0005zo-1u
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rdYPo-0007GR-VJ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:29:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4128cfb6b6fso3945625e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708705727; x=1709310527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c62pHsDpP+3tvJg69QO5ZTVqtvkEN32UvVvL0uQMeec=;
 b=QDHQe06D/ZApvzZTM4YqK02AaYhfcTuA0RCh8q0m9IGhjP+GTEV8LQ6rnAeGd8QyhR
 61A2fh9ZVvawSGEWIEC6TU5GgDnBTsvMK6g1VCkItTL4vRlKv9pw0IOSZ7JrGvjmunUm
 clZCkpPd7WClluPrmHGl83Ae26uKeuKIJ0YZ8lG6y2xEULNgG68Y3ZqMilqzY8OLcqY7
 ZEb8vJDwRwMPifZgnNnXQaz3FZqmvDIMpPAQYb/pVUSgglvxHbYprqU+yq3Kn/9gdA9/
 0Xx1My/T8VALtwZF5vUL7fYEozLYaIpSffN9ctD1eIip7XkOwGHUmhaY6RxVZmTpRNIr
 d6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705727; x=1709310527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c62pHsDpP+3tvJg69QO5ZTVqtvkEN32UvVvL0uQMeec=;
 b=AsOVMBfkvw1Tdq/44+suihTfFh5CwSZvt+9T28YTKHdMlDmM5Ui4kuMrQ4WHhYUG7r
 vSMdzjVWWH3kDtj9bGggOzagk6sBasbW8dqRKnMg2vTtK5u0vXaJAgAdBOcpXdVm65SD
 tAX1UeHJSmu/eCGdsN9/3kDhW8C6MsPLxnuurXtCy8bCqgp19Rt4A9kX9CBHnDa2fuCC
 1FoyHFR6hd5v8DWqyNI266flxytebVwKvcH3UWFerVjz3EQFuuBM5L5o7/FWse9+QicN
 rFaPwERBVzgr+20tnpF2Qv89VJ7Gte2HyE1+imsxmKimWvGbFWLN5h6Iy4YQZ24mtXcA
 Ofxg==
X-Gm-Message-State: AOJu0Yz+JmIG3fV/MKKRYM9AFvWFZ5doycBArSIpjWlZT5YboyHR52M0
 SQpy9xPXLvARlNzguCN/szSurV/y7CGQuVwoPuKkyCifKGdgEjTlGCj1XrcQ3zs=
X-Google-Smtp-Source: AGHT+IHA/BxI0yOOqZ9c6ndMS0vbqAyE5u4uMUWcDkPA3DUcuBlme78LC1DRrTWxsx3lBYCmmhpGbw==
X-Received: by 2002:a05:600c:524c:b0:410:c5a9:a24a with SMTP id
 fc12-20020a05600c524c00b00410c5a9a24amr231933wmb.20.1708705727458; 
 Fri, 23 Feb 2024 08:28:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s15-20020a05600c45cf00b0041279707ffbsm2885876wmo.15.2024.02.23.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:28:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D2815F93D;
 Fri, 23 Feb 2024 16:22:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-s390x@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Yanan Wang <wangyanan55@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 27/27] docs/devel: plugins can trigger a tb flush
Date: Fri, 23 Feb 2024 16:22:02 +0000
Message-Id: <20240223162202.1936541-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223162202.1936541-1-alex.bennee@linaro.org>
References: <20240223162202.1936541-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

When scoreboards need to be reallocated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213094009.150349-8-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/multi-thread-tcg.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 7302c3bf534..1420789fff3 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -109,6 +109,7 @@ including:
   - debugging operations (breakpoint insertion/removal)
   - some CPU helper functions
   - linux-user spawning its first thread
+  - operations related to TCG Plugins
 
 This is done with the async_safe_run_on_cpu() mechanism to ensure all
 vCPUs are quiescent when changes are being made to shared global
-- 
2.39.2


