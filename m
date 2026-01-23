Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B9AD74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbt-0004E2-4X; Fri, 23 Jan 2026 09:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbr-0004C4-5b
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbp-0007lj-GV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:02 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so31715865e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180280; x=1769785080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPLtmm0thKhhqV9CGriELJNIRIeHkZeX7nNkrCOg7E0=;
 b=GY5i03lqA9cqn/SiLhUtjW775NAmOs+YcwkYgckuvlrF+XMon/sr1oWGs7xLIpSL6g
 WTdTb4E46q9S6WIF2SgC67G+i9mySzl9V5wlkmFzCXyb3QfF+C37OR+4KnSJKmBoRHey
 ddqgdQgrFKZj7bz832eeeV0Q158GtNeYfy+3IRx0iHYh5cdNmGKidTbYE8+BtDT5WNsl
 AIS6bkDAbuy7oIKQrTVGz9Uc8JbqhMZ8B0OIr2AgKiEQhCM03jBhIyaNpfk9pwby1b2L
 UltlcSpTqx72lozUst0f5BKtJyeMODW92Y9jK/wdn9Z95/bNH1+BQyBffG/mX1JVKJYS
 kz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180280; x=1769785080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tPLtmm0thKhhqV9CGriELJNIRIeHkZeX7nNkrCOg7E0=;
 b=WpjGPScWYaK2YYuzpZUE0Atm3YtIJ7YG3f1cS7ADlAxKn/4vlLLk+ruHhzy0kZyKml
 gaupdnLel4Od9zQaxrSHIm0xBMUrAQv+FzuSBGI3E9uxz802o7L1/d0J+ioTPvVq/VVu
 uzbCr3VgvQeJ8KOqVAUSWnaSnohrfzYxtakjMlDdAJNRp9PbPj0HtpIjrQq6g1554/hz
 zaYOuGcyM9Pq7VaEk3DDMCILQda8c6sMwPSvg1cdKUCNaGfspdp3pj3D3KBAVCED3dWX
 LHHkSa1mKVawbzbUE8Cw7bSciBo1ysgx4obuGZ+EwVqX0QKgzGxtvvQRguF64GYwHqk+
 MzMg==
X-Gm-Message-State: AOJu0YyApZJrn8ofcyf0rZl+Ls+tbyD7kH/iX9HaSHnGZEftTKmXXgvn
 7cFHJsFaFvCq+MQW7hY5bi6lVy3t5LZENB/mNMPkZ2cg9iKawldjzdag0XNdFPUzzlY=
X-Gm-Gg: AZuq6aKMdexJq8vK/4EkvMQWx93FfPAEChNBdDbH5lvg2LXmItWQ5JHOo2eiMN4++F9
 x/Fwd70IxQ0Qe3uW/MC/LoOx4zIfIDLJKtUIjrVIYfImS5JiZqr9h0Wmm2AaOFRla16R8NN7SjL
 cM7g45lES2u7wsoJ6gSAbCrI26xgIRdbRZlMrRlrmOl81oMINZY647Av6gT4BqHFSQBexVZyUyc
 QcdOGB7SC/4CqRtO46MdDjTHCFlF3fFFuBaqOP6xp1v9AyEGqC3onPGga4N/SJ2jeK60xi6w2/O
 bbM50CIoglvVwoErsnQIEbYKIMxy5FPgoSJQwoWNtPB79HVshr4R8Y4GMxHAY63OFheL8y+ZpMd
 4fc40yHQe6ZNevlVrayFgF9JhWmiK+K8kM7kIwN0xtAd9RDAIAHVUT6vgnb+hlK5s9pvNs+WYYY
 9qhvQaTTW8Ya9A
X-Received: by 2002:a05:600c:1994:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-4804c9d4e9fmr54061545e9.36.1769180280006; 
 Fri, 23 Jan 2026 06:58:00 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d85206fsm62321345e9.6.2026.01.23.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0FA465F8F3;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 07/16] MAINTAINERS: add reviewer for linux-user
Date: Fri, 23 Jan 2026 14:57:40 +0000
Message-ID: <20260123145750.1200879-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I had interest in this area for some time, and would like to help
reviewing it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87ec6f3595b..ee64a528c7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4033,6 +4033,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: linux-user/
 F: configs/targets/*linux-user.mak
-- 
2.47.3


