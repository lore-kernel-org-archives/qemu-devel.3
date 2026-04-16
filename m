Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E04F8D77A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDTtq-00030U-8t; Thu, 16 Apr 2026 17:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTtj-0002jb-H4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:19 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDTth-00026X-JR
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:05:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d572f7437so5302119f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776373511; x=1776978311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mt229DgUJFktEZhlC93P349/3xu/UrkX5q1qoCrBxmw=;
 b=s221DTg8EHyqYbuXB7/iynbGm3na3ST9k9u5bA95gWFTeOG20HpgwxBf2/qlklMIH2
 ab2ro6oPsABtAumKmFdf6Loy/4zBLOlRu/V1weQdwPb1g2him2g6Vb2yDt6u/li2Yj/f
 mZQA1uiHJ8P37+qduMigaZ5Ys7kyDYLeQ1G7v0KrbSnyB1DLF0a8sLTE9s1uS8HlvPo6
 sJrqtJyY0UCCpPmw8Zu1AN5fCDEtt1GpBSNquhfQ0xbeeFfjxB6sabyCBa8XljjNSv0W
 +LWYr+8F3ADqh92PLYaOn6YipHqOhVZxdanJ8OOiVYYtjHzHopoRlZo0816kj6y3/ue8
 XfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373511; x=1776978311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mt229DgUJFktEZhlC93P349/3xu/UrkX5q1qoCrBxmw=;
 b=ItFd1SjZdso0D5ZylfXCf2U4aMmPJIDGjrt13TW8zpF+yV0VDUWICAgPWu+MjcUc5C
 jP0DlSbzZ9rjoEaYsNt5uEtL00eIE0ee660rUr6tiEY0sRDBGQffLZl9eBoSNszHrTZy
 TZmcaNjwpoCn6GPJTkQMnlKmKa1xIHJvOXcxhBcwJ27/AmW7ghyPoXNlx93UyNT5p5yP
 oKoS8JmPN+NlPesaui2Y+qI1USLCZxP5BJpxmXUgNteDNJv6Qms9puGtCUe6jaeKyq0m
 pUlLMD7gISLNabuK/pPGfmce69E8/AOxyHpLGO1JUi8fXBJbAbPIDlk2x5OtNcJCaU/V
 SNzg==
X-Gm-Message-State: AOJu0YwLON3MWKaqNcNHAe9Nru0eDQIBpE799t7EKnlXCgL8sVjp7XZz
 t3py7UjB99ZJDll1zBkfI/gJ85VlqmWcbyLQGN4H0kw0KElMXznbrEsM6MjelOnONSA9mMM16Gt
 W/ZcjbyA=
X-Gm-Gg: AeBDietkFV6VOViVWA3mnvN9QeGPJrJisl3O9+ZG/Nl9xChfj/guCUx/duETkpb+GOD
 HvYhlFuIql6pYpRX4+ETQhUHhGqw34bfCAMtOFNKTdPYHpN4rAxv3n8ZE8xrtG4XcAp52zz/BAb
 Sur6tDHyYF75rL+Ao8S2QQZho/PMcOfb1q7lEztAlSC9ICy0yVOJdRnV8VX42Oud1wczk3/OmMp
 w51EZW73heFAaQ4n61mZ9D+CKCsGO7hqY0yh0XVf6Dr74wLYkj60WKhpu4bcoF7Y8IxZ0eTdGVM
 Y0yJMkzL0Og4FzpRM21szxZzyrmwxeN6fDExbfcYH5a9/oKA8RFpxk3Bt0e7dn5C09d+AEpUPjW
 opCDJUa9hFVwoO245fBTnpYqff5xyJKQVwO5eI4VtemCAfCvpqc7G+IdkbQB+25x5Sg4t14LnMf
 +FwXp13CjhTQn2NF193gTCZI4dcIQTxb5PbHUapHDg2bWfw3hNuEj5NF+zGsCpJrVsBvy/UyC94
 RlNPSSWG6o=
X-Received: by 2002:a05:6000:1869:b0:43d:9bb5:bd9a with SMTP id
 ffacd0b85a97d-43fe3e08fb7mr115377f8f.23.1776373510783; 
 Thu, 16 Apr 2026 14:05:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3ebaf1sm16837026f8f.33.2026.04.16.14.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 14:05:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/4] target/mips: Replace cpu_ld/st_mmuidx_ra() calls in
 LD/ST Multiple
Date: Thu, 16 Apr 2026 23:05:04 +0200
Message-ID: <20260416210508.30686-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Address Richard review comments on v3 single patch [*]
as its own series.

Do not convert the helper to translation to KISS, since
my goal is simply to kill the cpu_ld/st_mmuidx_ra() API
and these are the last uses \o/

[*] https://lore.kernel.org/qemu-devel/bb8c987a-d46b-48ff-96fa-df558e63b878@linaro.org/

Philippe Mathieu-Daudé (4):
  target/mips: Pass MemOpIdx argument to Load/Store Multiple helpers
  target/mips: Remove unnecessary target_ulong uses in LD/ST Multiple
  target/mips: Inline cpu_ld/st_mmuidx_ra() calls in LD/ST Multiple
  target/mips: Check alignment for microMIPS pre-R6 LD/ST multiple

 target/mips/tcg/ldst_helper.c             | 74 +++++++++++------------
 target/mips/tcg/micromips_translate.c.inc | 32 ++++++----
 2 files changed, 56 insertions(+), 50 deletions(-)

-- 
2.53.0


