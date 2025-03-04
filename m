Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF04BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpamO-0000Hp-E1; Tue, 04 Mar 2025 17:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpalx-000865-Lv
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:01 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpals-0007lj-93
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:29:53 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso10107263a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127390; x=1741732190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxlbdGkJ13G1o6ELtDmgQA5UFhIUKmW1fQAOczDQAMQ=;
 b=lhmXeaV66TOoPR1GX0c7Mbqbh5IDjMQC3hPEJGvSKlc2JStkxtcTOIbsdDT5cMNrff
 qE9lmKmYeGjJdEzC2TIBqpJnZeEpXNwl+ec2Xdc9vTX9b5zTjw+p9SelDjvY3A53Y0In
 0lTbnP2A193Tg4lWBCNygX1rbOzbyjzwPLB8W13dKGZsx7S6bOvNGW7Dc5nn8iy17JWp
 yn826qYiA4gWzDiV0Pce/35ACtpJaFz6Fat8clZPdFTd3MfwiwmF7Wpf29DlB1rNBPBf
 b2Jn6Kc6fntgVAm67k4GPnQgJ4lb/w44G2qkjnpUpy4/fqNjsnPflF3Z3ZEWGh81hZmR
 OnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127390; x=1741732190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxlbdGkJ13G1o6ELtDmgQA5UFhIUKmW1fQAOczDQAMQ=;
 b=b5w2oA7AZ/pRkskvdRbPoqML9VQk87PYGb7uFWdvRRXKnYHVhG29ZjO09Fi1BQKIoC
 1e9le3rLK/nb3xfrAdwPS6f4CvleaG710e8Y8/0FLUJ4SGo+dbm8QfjCxHNUD9F1/6nI
 fkIjmCTM1AtspaacxCO3PU2VBuY54XLvX4Kdmywyvzb4h8dfrUXHv4HUcQGU6nMAEypn
 8k3Q7F1CUyAgi7XJBAwolDjy0OC/sSID84bIi6n5TpmvCPRq7rONvbvHBZZIwQx8npBl
 OyrwH3a3yexhwR2F2vg5D+Nw+KthOvqNMRorQ5hBEtTTHjtcAqe+2RuyhkPcswRK5W3u
 Qg8Q==
X-Gm-Message-State: AOJu0YyDhDSVnyK5MDgJXzeCh6dKvSjRahATXf+AO3DPNtsrNxF/HfLI
 T6wYOlK6f2DbqUTeCpuKuGTrTiH3FW9EetA2xctNl4VNzEenJC1p7sXnbnJj5zU=
X-Gm-Gg: ASbGncuZNnYFUKZAYYrk4BYcwPnrWA/lvANUicKX7VGOxW6dBv3+bm9ByTEEF1oYCIG
 9AiT9CBNDSjnC/zfL0z1iW13zvOw7za7b+UMjyMX3fgz+eg6wy5O/eSm9DOpZJRa1otAKdOz9gm
 sMbQfGSzfVXLT3ZWn3uZNEHS6H8HF5e54llJ+V+DDpDx2UyybZFHHpa/EQXVBzkj5sLIqNr13PG
 3N6qfhwReGrmPpFSMWlHuUPG0WvCXEUfsidyeWvAIDwaxZNh0FRXJ8GWU7J5qhpLD7LvgJTM31Z
 we6sdU96h77TTUow0VubGeG1Zj3RI4/jzDolo0VoygKpMyc=
X-Google-Smtp-Source: AGHT+IGFy+gvfPj8mh7uLYUxHapY81va7fTg3uLY83O6zVzN+ZlmBUk5wU9n5JDekf5VYh6/3ducrg==
X-Received: by 2002:a17:907:9728:b0:abf:6e6a:885c with SMTP id
 a640c23a62f3a-ac20d8fc704mr94724366b.23.1741127390502; 
 Tue, 04 Mar 2025 14:29:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e57faa1dsm274634466b.95.2025.03.04.14.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94B9F619A7;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 22/32] include/qemu: plugin-memory.h doesn't need cpu-defs.h
Date: Tue,  4 Mar 2025 22:24:29 +0000
Message-Id: <20250304222439.2035603-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

hwaddr is a fixed size on all builds.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250225110844.3296991-4-alex.bennee@linaro.org>
---
 include/qemu/plugin-memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
index 71c1123308..6065ec7aaf 100644
--- a/include/qemu/plugin-memory.h
+++ b/include/qemu/plugin-memory.h
@@ -9,7 +9,6 @@
 #ifndef PLUGIN_MEMORY_H
 #define PLUGIN_MEMORY_H
 
-#include "exec/cpu-defs.h"
 #include "exec/hwaddr.h"
 
 struct qemu_plugin_hwaddr {
-- 
2.39.5


