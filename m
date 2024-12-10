Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F77E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 20:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75z-0007Xp-2Q; Tue, 10 Dec 2024 15:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75e-0007DA-HN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75O-00025W-Ss
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:44:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434ab114753so40270465e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863441; x=1734468241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVtfGj1mN7IE9EjKx57fAetrjTJp1RBBY+kA+VK2230=;
 b=uHnyO/6evMqWJli9q16BkWwbBHa8VXk6rt61WylZVBklRCwQNNATWN2PJwQ5LW1eMp
 W2ktVZaOIzZeogsIsWcJuTlgzP0pnqNwTl3mY/zsSxIJZJxgHKacwlSq29jkk5Atn4tP
 nIQi6VuRJyO15pfihRHLqR/tRq9yd0J3wbLqj6H1BFp873AYA7p9AbR/7zFEgn9uwM38
 Z3wCZuWuqmq+fi+zJmRH3XJN7LHYEwGVXCl7I78jf6qGjvPaFqe3LRAPitnFojbATj67
 2KHLjBadeRgHKP5RhyhPfVsvRaJBMao1oi5396pGRLG7B+2UE3Ml6lLOLRXlBFIq7xXM
 aE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863441; x=1734468241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVtfGj1mN7IE9EjKx57fAetrjTJp1RBBY+kA+VK2230=;
 b=VS26ddyAReQzFLtna4HBhsE9mLqehfbHSqgxcInCRD0ZdjIOXhEwEywGMLnSORSOr2
 3VAJhH3Atjw7PBqhBS2PcA5I1Hvet3ReCWSL6I7c8HcOnXpOt5wUol8W7n1Id1oWlKeT
 v5xAdHuYbZS0jHbHYqqy70y6yoStKDS8WG4MF6BLtZ/4urWviyqCX2r5lh5m+tgAsPv8
 4yj1+5t61PB2fOGIAta+G9zDX5FrqujIw8YsljdQM8rgMk8zSX8mUdgXeS/XuvyYoBbl
 6uKTJVIcT4n0Ixo3qmCYD51d8o2Vbm0MKsbuZnvGG/JdDEaift/6W6slIDZ9uvZuU/I+
 Ji8Q==
X-Gm-Message-State: AOJu0YxWMfvI/SrfFynP6imktAIH0aA5ms5JdPdyTJ6zScYZxAKHKVYY
 j7fwudRYrfZ6D0PPPNPafscjHQuQWHF2ns68CdYghki+9scK7m0HaJYAguCJgyQ=
X-Gm-Gg: ASbGncuB2FtHhK4F1v9fyoYMFmnAGm4Lj3KCibQ60SiJu3cg6hcNznJIQcpQEX8w6WJ
 bg2iKQbKX8j4RHnm3Bt3nB6REIIgE7fr7ufV477EZqB2WnWx4fzPExOeM3AZ68x2eMLa+XaiI0Z
 dOI3T55a+GQaO9AWswA834397NGb1O+RugfU9FopkwcVa8qJC0bo/yBDagl26IJeJJyGkwaj4ng
 BgYAP9SP4cPxSgfXqxPBt9omFNPz5QWoprnZylg3WXn5CAHueN+
X-Google-Smtp-Source: AGHT+IGpzKuTYjnEsiUQ9ORnH5wNcjraFmpDwymVpmKioiXY/yJd1V8O5aOeYk6wJ+u5lmdc5dxUCw==
X-Received: by 2002:a05:600c:1d1d:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-4361c419464mr1880575e9.31.1733863441401; 
 Tue, 10 Dec 2024 12:44:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38621fbbe15sm16587772f8f.92.2024.12.10.12.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE7EE603A1;
 Tue, 10 Dec 2024 20:43:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 16/20] util/qemu-timer: fix indentation
Date: Tue, 10 Dec 2024 20:43:45 +0000
Message-Id: <20241210204349.723590-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Purely cosmetic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 util/qemu-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index ffe9a3c5c1..7b71655416 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -680,7 +680,7 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
     aio_context = qemu_get_aio_context();
 
     deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                                      QEMU_TIMER_ATTR_ALL);
+                                          QEMU_TIMER_ATTR_ALL);
     /*
      * A deadline of < 0 indicates this timer is not enabled, so we
      * won't get far trying to run it forward.
-- 
2.39.5


