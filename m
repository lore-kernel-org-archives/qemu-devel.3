Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F19BCFC5EB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syxLL-00083n-Va; Thu, 10 Oct 2024 13:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxLJ-00081r-Vs
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:52:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxLI-00069H-BV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:52:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-208cf673b8dso12725575ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728582770; x=1729187570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JwLuQdwsSDwOG55iCrMJljY0m0DoEqEMJx/2Ai50hcY=;
 b=Sg7H/xuiwMKJtvT3VbNY/81lD7fcQmPKAq4B28eqW9Fq8ALq744sXM+8Oo91N1rtMq
 c1Iqew3vhaAyrDX6uSmFucHL+t+j6/NwjWtWFj76dADhQVEFs21xFKEcojhJ1+EhWBdn
 uYI3LA0VuBOIFLB+dOlla/Ub4K/O5yAoXJ3XAljthk31ym+vACBW4NMmN93+xtlUyRk9
 gO86rAhw4+uUAolm9vvypl297RFRTKwBciWjNQKao3cKyOkLmRs4YpLwefZr0SbrtAUV
 LC+kuWr6Jfidvb+lGTatTK672Ibvt9KHCgNaVTOhLyeH0Q+qO0ftXGvBQEoQ4oh6hNYB
 Q7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728582770; x=1729187570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JwLuQdwsSDwOG55iCrMJljY0m0DoEqEMJx/2Ai50hcY=;
 b=HL0kYubrwalk4ZIWiEgRifq9y8xys9D4HhfWiFK5jd4syua32YgFF+IJ2DN492R1vo
 U3e3Je5Pfz9gSFrYuVzldW3dAjDyUXtR1OAPsux0PkuxB59GzCZv7j5H441ZSvW7WLzk
 Vlc6Ox8m3E3/ZHTHg2rOPMBitx8lHDZXtXXNHBYtHo57guyhPakPgooNs0AAoItlFIzT
 yDPG4igfiH5LOuiRy3QX3IQ0bKjwDWpjnsB8N7VK6HBPG0rD1qRy1uXX/PrseJU/NTyX
 szAkfsWEZELA47fWPPFRPvHBxYdyFcLUHBWtMaK85xwWvdCW2Lc3DVrEjyWhD0zC3qgS
 sM6A==
X-Gm-Message-State: AOJu0YzBHC+kqQVbAMutVDlbBrZ9O9Tnbd8tbFQLgOxzTrT0Ex7rRdaC
 OQHH70JsWGR7wWS66c42SPXlwUR0N9R9MEEH9xf+y9Pkwhc1tsJxbz2sJrGL7kxeGzH3rOj4UyZ
 x
X-Google-Smtp-Source: AGHT+IGN4vmugcZ94yOE13qJeV71x9gnP7KVGuZbWXWhu2oKMHMBkmetybl5yFYwrTwuHSclVs3gzQ==
X-Received: by 2002:a17:902:d48c:b0:20c:8c0f:f971 with SMTP id
 d9443c01a7336-20c8c0ffb0bmr42369475ad.40.1728582770449; 
 Thu, 10 Oct 2024 10:52:50 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc1a17fsm11920055ad.70.2024.10.10.10.52.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 10:52:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 0/2] gdbstub: Introduce ldtul_$endian_p() helpers
Date: Thu, 10 Oct 2024 14:52:44 -0300
Message-ID: <20241010175246.15779-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
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

Only unreviewed patches from v2:
https://lore.kernel.org/qemu-devel/20241004163042.85922-1-philmd@linaro.org/

Philippe Mathieu-Daudé (2):
  exec/tswap: Massage target_needs_bswap() definition
  gdbstub/helpers: Introduce ldtul_$endian_p() helpers

 include/exec/tswap.h      | 2 +-
 include/gdbstub/helpers.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.45.2


