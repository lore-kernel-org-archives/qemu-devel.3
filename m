Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A38CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NyJ-0001zk-CW; Wed, 08 Oct 2025 02:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyG-0001za-1X
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyE-0005X5-6b
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso4323926f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759906096; x=1760510896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C7NY/k7OcdrA+sb3+kDS/Wts5ntQ0DzLG892QEuKXY8=;
 b=CmUBwXTW6+QxfDNxIu8MSe/q11BUP2rMH+a02Faz8kSgyeoEbUsa5wK55n1ezPUvJ6
 r4sXKIgr6OEiKVDj2Zn1mZ0NqcCY4sIeq8DmCql/pb/S5aCYzvK55EfOLO+Cevfo1VN7
 1CSVDiYhvQNCB2fKiMzVkYuWjB4DQqSCvGrS49bcTrQ3fcoA8MBEc5Tl5Rv6VmgdvEUT
 yb3ZDFwSfmSWQ16fN9PmlHhuOIfGZGVIl0Iht1vCz1ZQJ6QjswS0k++p4AES/zQlbXfP
 bQb+eNfrb0Ehwe25LEwfxYdSOYPNabz+qiKeKgXGyBJXMuFliF24/5BoG6FXbYXvUGfc
 H35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759906096; x=1760510896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7NY/k7OcdrA+sb3+kDS/Wts5ntQ0DzLG892QEuKXY8=;
 b=a5OMrC1HqGv3NH1zAqaoC9TBtBkDIIVqcqDqEGmJfKK0+ez5ARi+h9ALx27qpZK2/L
 55MLJZScoYC1WSRhL3nfcsKVKSHhfHT0K74AEL8PqPiERuiHe5Ro+zTkadKvX4U2R8TL
 o9MAiZmz063zmWzfwN6haCnnYQqMv34NkW5wX+lLtjxinclIzMJR8ce8eyRnmnLKWom0
 wJiZzJ0MPfTXx57D0R1lTtt0+KeApkgtKxRRu0WAMssIeczF6lF/jjDXuocY0S4b0wZs
 3xR/+BLnKYkywhyfC/e3h1E+f5my8tY1PBbREy0v7+iUBhJCltSmDQZgG4s14xiYF2wA
 Y+IA==
X-Gm-Message-State: AOJu0YwjLdgjfSqtMEmHUprvZkcnOLsb9IfaMdU2KUN1jCvuIPxd9/dm
 5o78ASzkCPICKgvfJ7fbV4cRQ1Sx0gEMyMI8gBpergHX8YmR+M+83rUmOwfDezhIAZ+GMDZoHKm
 rTuuVZzCRZA==
X-Gm-Gg: ASbGncsljRGSo/mIHNlTp2GiJSIWFcvK6vibuzC9sFy6IYDBFmnwKqDt5R1fizfmNiC
 PZeXFmWOSmnJ4n3T9x1nkZI7buUc732GBzNar4JbYpT7HhgYRXrXjrqmsRi5Ay4SL8PmA9mHKmj
 fkfObfVUHrnsFr8FCz2nWFZY75lC0VYoUO3mZvddahL4g28g/oiTRdOM1f8KnGT1FCmlTizzolG
 nAv8MpBooL77POf0VU+28SDwA5EpLFYLt3e5M3Twqkxbq37udRxRALYZtU30wzJEVB0VmaVdB/o
 oOLyIX3FaOXNFiPPfse3WmC2XnThELEw370KNHQrEmgg/aHwsT3v/gc1ImS1Ya/ZCB775Qpl2lv
 qwXsEWAQU2NIpAoMiECkGJEVgSwu+j57COFFG2JPVsHI1hC9Q+RmE3ulk88fTMikQm5EAlZiwrs
 Dv/Ld1x0q+9a5dzeB8P1FHBOM2
X-Google-Smtp-Source: AGHT+IESczl/c26YIaTMZKpgP7XiLUacSFWyjnRr5p5UNINfmNNb9B6pX+jd+X327vNTLcNAGrEj9A==
X-Received: by 2002:a05:6000:2004:b0:425:769e:515a with SMTP id
 ffacd0b85a97d-4266e8dc000mr1138022f8f.42.1759906095716; 
 Tue, 07 Oct 2025 23:48:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab909sm27803330f8f.19.2025.10.07.23.48.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:48:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] target/sh4: Remove all uses of target_ulong type
Date: Wed,  8 Oct 2025 08:48:07 +0200
Message-ID: <20251008064814.90520-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Remove the left over target_ulong uses in SH4 frontend.

Philippe Mathieu-Daudé (6):
  target/sh4: Convert CPUSH4State::sr register to uint32_t type
  target/sh4: Remove target_ulong use in cpu_sh4_is_cached()
  target/sh4: Use hwaddr type for hardware addresses
  target/sh4: Remove target_ulong uses in superh_cpu_get_phys_page_debug
  target/sh4: Use vaddr type for TLB virtual addresses
  target/sh4: Remove target_ulong use in gen_goto_tb()

 target/sh4/cpu.h       |  6 +++---
 target/sh4/helper.c    | 34 +++++++++++++++++-----------------
 target/sh4/translate.c |  6 +++---
 3 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.51.0


