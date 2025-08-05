Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CBAC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLW8-0008Hs-HL; Tue, 05 Aug 2025 13:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLVq-0008CF-M6
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:31:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLVn-0004r7-NU
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:31:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b77b8750acso85163f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754415102; x=1755019902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4uzNwmW98FQappTG9bvmpD6emypXpuyFoyZHU+E6nY=;
 b=azAklSBOFngtRU7+qBJlg67PSQ9lmu7qv/Cl9jwkQDkHyWG41C/10yGVgWQIxO4jks
 dc0bsc2+E5oALGYQ/FDkaNjbh0n54bvz52+byI9D9hHQAZs42kdJ2gAJ3+R+FfhaIVyG
 RX/a5E8GgZTZUEra8aHrGvhGZRtbmm9jI/3PhXptjcUd0K4fTmdm2pxiv3xkfXiXWcxX
 WwBGK8RWyKjgBF5Ks8tKwxteZVGUxd7OtJEs1JdEOdFT9Wudvf29iY8qRcv8QHt99eus
 H5yG7B/k4tiW+IvS/F3M2o88eVIOdlu+ul007yReJRQX1YlKI+hlC4bdEJHBByf1srwv
 YO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415102; x=1755019902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4uzNwmW98FQappTG9bvmpD6emypXpuyFoyZHU+E6nY=;
 b=mw6PgTLSM3UiXPyzkeim3Wvm8cs2SX+rhLzEzHsNn4p300ihI2qdceVDGN05KPulwK
 r/T1G5JhQvqcV+VSAHOqZ9/IpU4EaxWEviA4ynirzhgTe9DVGf4iMdvxyyMNnnSLP3W/
 vbudGeuaQdEzrdUmtihRXZ4f6bLGFVNPiNivY2+4dCoBdZog3mMo72qiOmdhrIRTHstE
 SS63QL0P/OkEK/dId3/jH7LUusvucDuPWek6I7Yr5UhIsI6s/bo2g3ebU6lqsZHecCym
 CoaPVUdaHIUUMW6jdXkEWhkASQaRntWByp/DsN8WDtfZGSAxIW4KKqkrG0gdPbWkyKN0
 jvow==
X-Gm-Message-State: AOJu0YxAfPypAMQgkSe4BfOrEA9vM6dhQXAJjuHJbmPz6MZ5/c2+TNtF
 FB3MfBihBu7SMIs9UwAPS1IFQVp0XN4rB0SsnKUeWaPuzIPiC/ZNGQVK6tJ1DpD6+iUhX1mIhzc
 1nVH3
X-Gm-Gg: ASbGncudacF81C9dj8gXTSNpIBfmgdbwybF8akgAHwvf5kcASSgUAiJTxZeUIHL+aol
 5fzuTDTtyVqQIp4i1yuTeRMixqVTZA0kArt3izdvJ0vEWUvH2v1N4wHzKt+kKQdWR/z9WtITPow
 jvIFQQ9ISRQ6MApRx5iLJMtuod1TJkaGcVlaEZrOLvgTDNhu55YiIZsOTTuUpJTDUbrZoMlrjGV
 xcJZTns0zYaGky3g0xiRXQQeFcnqRQNYqx1mryZdqUgSjdv8ngQP3ySt9XPwbCAs2fAawZBmBHJ
 T1FTZSf1PF4/uE6WcOmuTyRnjr+OdltlNJjugt9LU5qZIj2HRykehjbyn+QsY1Lx0Tu7VAl9kiG
 1br2nhuGuy/8OIH3hNzhxTupBkP+tcy0Fe3d+1aRK+k6xD1j0Gqhut8rZi/VcBWr65YwKILdM
X-Google-Smtp-Source: AGHT+IErnEge0ZqjMDhPw5DW9Ctt/Sjvk8G+yhKgGYr5kv4XaqHWRuVS0um2UIfVzC9QKVkKbyKz+g==
X-Received: by 2002:a05:6000:2489:b0:3b4:9ade:4e8a with SMTP id
 ffacd0b85a97d-3b8ebebe1f7mr3522846f8f.21.1754415101605; 
 Tue, 05 Aug 2025 10:31:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c489e81sm20129178f8f.68.2025.08.05.10.31.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Aug 2025 10:31:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 01/13] hw/sd/sdcard: Do not ignore errors in
 sd_cmd_to_sendingdata()
Date: Tue,  5 Aug 2025 19:31:22 +0200
Message-ID: <20250805173135.38045-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805173135.38045-1-philmd@linaro.org>
References: <20250805173135.38045-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Unfortunately when adding sd_cmd_to_sendingdata() in commit
f486bf7d109 we neglected to return any possible error. Fix.

Fixes: f486bf7d109 ("hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250804133406.17456-2-philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c275fdda2d0..0bb385268ed 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1305,7 +1305,7 @@ static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            const void *data, size_t size)
 {
     if (sd->state != sd_transfer_state) {
-        sd_invalid_state_for_cmd(sd, req);
+        return sd_invalid_state_for_cmd(sd, req);
     }
 
     sd->state = sd_sendingdata_state;
-- 
2.49.0


