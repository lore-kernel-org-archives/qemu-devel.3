Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF53C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulpcE-0007Ui-0V; Tue, 12 Aug 2025 10:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpcB-0007TL-Ri
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpbz-0007ij-Uf
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-459e210bd2dso19543375e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755007458; x=1755612258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cKcO64ShFrfRsSCI/jgxMemhLXevpF/HYu5Ube0T9Dw=;
 b=CYym3BqVkggzr2BgdEmpzEB27ridZqQFA+58inyrYdeEy52SeHuX8EZ+si0Ridt9yV
 Ty/irVXCXP+Nk6GI2kmPdPB6OGSSxB4QDSDK3NY9Tgv4eGQiVOFbhkR/HN79RA9vgpKO
 E5RhuvcwHKz2V7+pRFhKNcRJoQ2zK/wnoTeu/6PBTXqsO9EQ/ju47KnKU57JZ1647NLa
 GcGlP6Z5CUavquAWqcVViflkW3CBtNAtmVicx+Qj2FxWGm363Pm1gZdERhGT+in22UTP
 Q64nVrWH4kBuLGjLaRIWNOoR+keztJnR8qNMUfEcSCJX/1o9wPoNsoeQfwqmhCxTEvN4
 T7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755007458; x=1755612258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKcO64ShFrfRsSCI/jgxMemhLXevpF/HYu5Ube0T9Dw=;
 b=HThQoHosWLeSSFzSaLXwxxU+LRD+aJ1DbZ0CxkZ3Xam1YU9MFF1QTRJOopTcnZX8GO
 Yxei4nOokoaguT7SNCBzlK9HDwjDgIiUhLX8UjYYYG7Wu+JdEQ2vZP2caBEJl/GeMeIy
 fChT1YBhq/VvTN5fRxV4yAEgLSG9/m8kNd1FZuhW/fwA/xVoO0Yd84bhQjS1cC29BM2Q
 w3IATbnacvUJtzecLOn6MPXg9XxSNE6reoX+zvRQODqMUgKptxVa+emwe5vxCA10DecS
 VtxMm+o6peqh/HTZc2zuygoLjY54aAB2LFveo4qfdLLZ4vrgs6t1xBPEpqlSn/e7t5/l
 17VA==
X-Gm-Message-State: AOJu0YyF+7NLWk/etuKllTzFV5JH2L2bHt7D71A3Wg7Lh6HGDKV755DH
 e7PP4AH6M1puIlEUFqej712J3VGDNfCV2fQZlRZLS6HVa2WkkCCbmrL+AIe9X7rWdFHdFx99IFF
 ZlA2U
X-Gm-Gg: ASbGnctX0EWAng4oqrpJ7hXdvtUsjcppcUAXmLZO9n0244XZlm3r0ZZHQA5YG1V7KZo
 LUj2dBIN4i9uRu3lXXYQi9oYlsbK3FW4mX6lSZeDZgCXsoeZeZRRoneN9t98qDJAnxwLw1ikCdz
 SGmb5a9C64fsH4sRjRDbUZIPg7GV78Aiq7b1T2OZ4wjIu+3zBuC5j6NtdhgHB5G6+6YfbG356Ir
 XMJyzc3813gaGp7vDDFEIDmWUVdyiiPn9f1k7zcN+2khlKYstRkhlh6/8K2OCHf21CcBJ0S8DwC
 G/i85JHRhDIeFGFqHuztHLrLyPuBSrOiMRCQIRx7FBbh3vEOX5veUF7bNjLpqE+xqiGzEEu+v6K
 lCmqgz5ZobQyy8kLQlOKtD9XDP2nAoLLZUtnsMbSvI2QizsoXi3OOorF49292UGMwUFXmroME
X-Google-Smtp-Source: AGHT+IEuLQCtKQ9v1aLGTk00wihP2FSMwAM2oLmxhgJZnMN+IqJPMk9GulkanVpdIlq5XRROJ8WqiA==
X-Received: by 2002:a05:600c:474a:b0:456:ed3:a488 with SMTP id
 5b1f17b1804b1-45a10d47bb9mr35856355e9.1.1755007457657; 
 Tue, 12 Aug 2025 07:04:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8fc28a7b0sm19982238f8f.63.2025.08.12.07.04.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 07:04:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 RESEND RESEND v2 0/3] hw/sd/ssi-sd: Return noise
 (dummy byte) when no card connected
Date: Tue, 12 Aug 2025 16:04:12 +0200
Message-ID: <20250812140415.70153-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Trivial fix for the issue reported by Guenter here:
https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net/

- Return dummy byte when no card is connected
- Add a test
- Document ssi_transfer()

Since v1:
- Reworded patch #1 description (Alex)
- Removed '_' test method prefix (Alex)

Philippe Mathieu-Daudé (3):
  hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
  tests/functional: Test SPI-SD adapter without SD card connected
  hw/ssi: Document ssi_transfer() method

 include/hw/ssi/ssi.h                      | 14 ++++++++++++++
 hw/sd/ssi-sd.c                            |  4 ++++
 tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
 3 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.49.0


