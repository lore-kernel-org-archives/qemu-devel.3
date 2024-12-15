Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB6E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwY-0001LU-TS; Sun, 15 Dec 2024 14:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwO-0001Hv-P0
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:08 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwK-00014D-6W
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:08 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-29645a83b1bso1753637fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289562; x=1734894362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyO9+T/xLm5SD/T/jpjO4kK53oScK4itFHQX03V3FXI=;
 b=Tp2B2+uze7gjOlpDWDt9Ni6zT2D7zuN+pJXpK6uum05y3pykm3D49MW7AobGhAjuVj
 8slc+8CbLRmln6J/jyBuJ0ka+t3ajbouemtyLa1xepJM5lJiKU018BUk71h75jWbCH/a
 nQicFlFBZqQZZs+aSq/XPszSAhfiJGUWI3lv7c7+3fSpf9B24BFGSL81coxYALLeiY9Q
 FmJFrgC6nlKvSipZmR1bMSOV/s0PsEUDTa9ej8Tx6KO5fKwvbWZrAIp99GqPjWdxXXwL
 +0f/sT9WLQjpgfoncs7MHh4cQBeuAr6eNpuy9dTYapg2JnySJas0SSrsioLNU8qz5NPr
 yWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289562; x=1734894362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyO9+T/xLm5SD/T/jpjO4kK53oScK4itFHQX03V3FXI=;
 b=Nnwb2qflH7g/TbVnI8vV7R3FJ77NXsfJ8eGivhtdMxS9ovDowVCJi/o3hGsGvxu8be
 N///Ov08bmlzyjmuA/4D2IWHgXx+Fn2Ojr3QxNdyC5O5kjPtlS9U2+TZjoX8rz+mHGYT
 pdhNK9KDT7snfqsLgEcVDTbiHeOWoNaoZfZ9s/Kt6RMPxHxa0tHwFDCg2KdaZABtJK73
 m08Q9zkEExCe+P85emOEhpwvS5KX6kjrqYYw/IfyzQQ91hnRN0s2gb/sCJbrQCQ5wLUp
 k6Ho0CpGnzFAqn1lt5rBWm8tL9n47QZ9+qEBxnn4D4KZ2sD+tiQn2hEJ2vd5xxY232PE
 0Xqg==
X-Gm-Message-State: AOJu0YzuL4sjezcyLigmTq5PQF5jRCMY3Gms+wkOjqWllvmDdvYLZm7G
 UNsURxs5F8tGe8IeMVc3PXGk0rieH35G+z/VDqQ++HwVPLQaBnp1hD4Cob9WTlKD0M0cx5zLl5c
 Ak5OPF7yW
X-Gm-Gg: ASbGncvtgVjO1rAOWibmz9ri4mLE29R3U2LcY25zncaDdP4i5jP51V9OHthVma18b1j
 Q3RsrkZJOEYg7m8qNX0aaIvKnLrc9MOW4+0M7aq6BBFGtGFm4RGi8Nb9MkjfQwiYJVQlj2TuZpp
 7ZsV1s/adi3b5V7rwjhJOjXQy3z7bhhIG2aWT2boL3TK17Cp9DrGX9DQFVrFSJLaVHNkMYc/4f/
 SUOVOWJKM7Ua9oFm/wQ/4829AbZ6OuaG4UfbWFaosLf51Zbn972e93eYPW+txBSjALqtg4chxN0
 KOy/h+C2L4Sny09hBAJosxbcTuZos2h7RcS54w1RBSI=
X-Google-Smtp-Source: AGHT+IFJWG6lSCR/qLjGkF93C5qtnpev1nPLWlO8BOLxemyjRah6Wuzpt7eQ+RyqqUcoSO8FiumRkA==
X-Received: by 2002:a05:6870:64a9:b0:29e:d36:6e39 with SMTP id
 586e51a60fabf-2a3ac62510bmr5568975fac.10.1734289562062; 
 Sun, 15 Dec 2024 11:06:02 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/67] hw/avr: Constify all Property
Date: Sun, 15 Dec 2024 13:04:42 -0600
Message-ID: <20241215190533.3222854-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/atmega.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 31c8992d75..ce630ec572 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -355,7 +355,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f, 3);
 }
 
-static Property atmega_props[] = {
+static const Property atmega_props[] = {
     DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState,
                        xtal_freq_hz, 0),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


