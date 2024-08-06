Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04771C52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJhI-0006CN-V0; Tue, 06 Aug 2024 08:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhF-0005n8-WA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:50 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhD-0000H5-SW
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:49 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so601245a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948826; x=1723553626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVol/losEhIcWq2r2tAtbopJaOl9RLGh9SWaxvA4wzc=;
 b=J6JVPJ0XQ5uN+ZsELFsdsiDAMrbd0+7F3iDFAT9V+44ciHkgpMAJP7da0u/T36UzlR
 VHwt+Bd5OAaeXElOsqeYmSClSlihXrkuJlsM+FUY2TAcDUzy1/WcTuv8RRi/GZRl8av3
 w3UtEha3VI+eUwXGDY7ndswrP7zUBkhIg2gwStPirONjIedMjWqKYGZ0MPFlSkJ9sMoW
 93mpwB1W8uv8QT44exYTH2o8yGgWWnQxwuP2BNltmfyCseL1tWHs/+fHlgxYO2nYJOTo
 GkDEFK/VyJRfn8oXYSKDwQynxIkfEIkiI+wMWdj7GN9iSVbHR8ODU6a4mymu86j2zSZQ
 sm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948826; x=1723553626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVol/losEhIcWq2r2tAtbopJaOl9RLGh9SWaxvA4wzc=;
 b=vgFb6tvu+AYeFzIt1pCFCWByxfUN3F3+5qgvEgjvl2e3t/tk93el2y+5gd6nX7ciWj
 LYRC9AOG/cKRearmVEzRaZExHhFM5VtE+ctuigQikeIfi9k3kzn59xqx0tV2q4LOnkpx
 /y71Ijx+sQ/wt2MgebIu0X411otemLAw4YadIC9RUxNRZaynBGJ+qFdbGRfmQesHOfWc
 Tti1edglQ4rTAHt5ogR//HfUGL9qkdbbTBRYo+o9NBMAW7NkXuhcOSlxmW+TjfaT6BLO
 w/8u8VwxUJzffSBRL8dTH8LPd4yR+JuKg0ImZlYJnXLr6jmUh89FW407ccKQKcA1bHPW
 ALOg==
X-Gm-Message-State: AOJu0YwrdvfdAL1n3JPq+W749GowUsHHoyEmhq8qujy509EVqg0QC5TP
 EYVg8UjVzwDTlIgdeysVd2b+pXuATxm/5r6h3nlQp+u74taAgqF5GZDy4FCjFZ+FdyfmqKVS8bH
 z
X-Google-Smtp-Source: AGHT+IGHHerP54nv4N2NYCyun0uQwMPHkgF8j7yp/Tgw8ZIHbU1PZuDcHpxJviX7jlEOJ1HcZnjnPw==
X-Received: by 2002:a05:6402:31a3:b0:5ba:83d:3294 with SMTP id
 4fb4d7f45d1cf-5ba083d343cmr6726452a12.2.1722948825908; 
 Tue, 06 Aug 2024 05:53:45 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5baa6b916b8sm3653114a12.22.2024.08.06.05.53.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/28] hw/sd/sdhci: Reset @data_count index on invalid ADMA
 transfers
Date: Tue,  6 Aug 2024 14:51:45 +0200
Message-ID: <20240806125157.91185-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

We neglected to clear the @data_count index on ADMA error,
allowing to trigger assertion in sdhci_read_dataport() or
sdhci_write_dataport().

Cc: qemu-stable@nongnu.org
Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2455
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240730092138.32443-4-philmd@linaro.org>
---
 hw/sd/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d02c3e3963..8293d83556 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -846,6 +846,7 @@ static void sdhci_do_adma(SDHCIState *s)
                 }
             }
             if (res != MEMTX_OK) {
+                s->data_count = 0;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
                     trace_sdhci_error("Set ADMA error flag");
                     s->errintsts |= SDHC_EIS_ADMAERR;
-- 
2.45.2


