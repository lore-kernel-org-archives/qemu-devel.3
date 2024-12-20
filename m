Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0D5E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkaV-0004PX-Dd; Fri, 20 Dec 2024 16:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkaT-0004P0-0f
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkaR-00072q-5t
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:31:08 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so23512865e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730265; x=1735335065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QbAYhbljOfTe/v2IHyy0lhx9IvpThPW6vzP8nvtQH3E=;
 b=lZw6M2DsnyAaONAdo3lCCPl+yNThQGH6mT83gCDjY1PRorwhjKJCJ4+cwb57KoLEII
 XbBGb2lVryPWI/Ixn09oGiKSwaxwoLXKkqgGaNd4pYRGz5KLED3aRbC+89XtgnWwgotb
 Lk2vypl1ez9VAfQu1bJsdMo0gWt2M4YzO1K7HgozfodOeYBDd0lYhOw952pFK37W1ETY
 kGE4kBIMycPTFvkXd5iI8KjrVO2vJM5/KJLN54fClV66L2mPjGd4nOXRXNKhHKFuneuR
 ULzyAqdFIAvmYxU1t0w9vqvk5aCHKIn8ppjDCyxGhIF3Fwot+Pk7lvGSQh+eXhJAMz7S
 3zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730265; x=1735335065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbAYhbljOfTe/v2IHyy0lhx9IvpThPW6vzP8nvtQH3E=;
 b=wstBlrzZbdIHCV6IffSzPQ0o1bDpwAzwVSNKmi/4fSoaY0l9yftajpzelHFaRZexZM
 KLkgw/Mgy/7fbkxx1ZO8hU6QLNFPq2cZWHAWgNO/+ri/uE93UBppvo5kQopFkw3PQwP7
 Zd1h39mG/F07MCKaJ3ygU5a/m0brxXhBbeZWf6AlKE62uHtmK4M7QMsdVed0Na+0Y8PC
 vhpt3S5PQ4BIQbF61bLJctpR0CAuQ6pYihLlHuyyIKCeChs1ZkKq/N9xh2y1F0XeR98Q
 OkZTj3Pglk6lGH8D2srn6dWS1uN/ROD958w8qS1h2dhZm/tgwGbXLw3Cx3z2fE2Xrvji
 0TZw==
X-Gm-Message-State: AOJu0Yziqg9GDt84jAQu9V2kWXKkY5VFpCyOZJVWSwnw9sxgUOEPZGKD
 fxorcfeD6j0VIQ+e6z7PIJaJ9AwhrlJOBmrAjxQJU+meUPs2TqYelnHKojPzBvozGf53TlQIvlW
 D
X-Gm-Gg: ASbGncvBxkTYgtLU7gKxcRi/vug67fL6wy0ddIEy7nsMA5SaZHKypkvEwaAQqPRqY9K
 7uz0Afi4SFVDOREcs8lmLTyzYGYiAkQklQfj1bCASv7aPVNvZjmVy0o/myyECEkCqiepMDdqG9w
 6hWYTmNPnadTZHacFDuczWDJ+d+qMvsj+bHSTvWs/rqwaUM3hWaWrlL1tPuZxyjEyBugF0OhRiX
 3VXbH1P0zRyW79kQWJWYr2f+pD4g4twK2QQI9uTxBis4j3FY6DHZ5S2Nz8xL2XRn0mP2Sf5AGg=
X-Google-Smtp-Source: AGHT+IFX8DjGyewg3m5e5Hgt1xO4VX6wPf8ylvUvPTX/iposHQYX3iXqB3d9D+pP787Di8cIqtCBuA==
X-Received: by 2002:a05:600c:4f0f:b0:434:a8ef:442f with SMTP id
 5b1f17b1804b1-43668b78d5fmr33951625e9.32.1734730265306; 
 Fri, 20 Dec 2024 13:31:05 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8287adsm4873668f8f.16.2024.12.20.13.31.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 13:31:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/6] hw/ppc: Remove tswap() calls
Date: Fri, 20 Dec 2024 22:30:57 +0100
Message-ID: <20241220213103.6314-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Since v3:
- Addressed Nick & Harsh  review comments

Remove the tswap() calls on ePAPR, and convert
them to big-endian LD/ST API on sPAPR.

Build-tested only.

Philippe Mathieu-Daudé (6):
  hw/ppc/spapr: Convert HPTE() macro as hpte_get_ptr() method
  hw/ppc/spapr: Convert HPTE_VALID() macro as hpte_is_valid() method
  hw/ppc/spapr: Convert HPTE_DIRTY() macro as hpte_is_dirty() method
  hw/ppc/spapr: Convert CLEAN_HPTE() macro as hpte_set_clean() method
  hw/ppc/spapr: Convert DIRTY_HPTE() macro as hpte_set_dirty() method
  hw/ppc/epapr: Do not swap ePAPR magic value

 hw/ppc/sam460ex.c     |  2 +-
 hw/ppc/spapr.c        | 63 +++++++++++++++++++++++++++++--------------
 hw/ppc/virtex_ml507.c |  2 +-
 3 files changed, 45 insertions(+), 22 deletions(-)

-- 
2.47.1


