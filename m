Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021E4C27C55
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAXC-0003lc-1C; Thu, 06 Jun 2024 06:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAX9-0003ky-SK
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:39:52 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFAX6-0002kK-W0
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:39:51 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52961b77655so899211e87.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717670387; x=1718275187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=adDHEXWneXcv52En8RIWLm7+FbdekJO7cHm27ZjigF0=;
 b=hKs0xap40KO5+KpzMnWFAfz8wXn8yq/a7nfDZSbHVktzhK65wEZkdi+LTcsVsRqMvf
 fRcuhiQ7q3hom+qnhYqJzLaf+CIftc7G4bIgRHr6boMqX8ZJkCi/+5BgSJwjL0A2FWpE
 TVxQpt24TpyU+hB+qzC1FFNGlJa8x+PsPUxJm0mLnqxIC7DsbHUSrqdYC6P8dMj6Rcaj
 fIZf6m71h5i6uKsJYDdoJ3VykmG1Nup58HlvAD7PAhASwmWtRF1RkCPDFQjbs3PRazZG
 UHOu0ka10XwMTQ76K4bi5+PFLW9ygxVGK673cP76QJGFr0Gl1CUceZIBGOxFRQUbN5a3
 KOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717670387; x=1718275187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=adDHEXWneXcv52En8RIWLm7+FbdekJO7cHm27ZjigF0=;
 b=C/mstJl5slp2q+W7ithIbe1Uh1wFq6ERYIh9AmmaV+w5gKOm0DxDt1mMjvufsxFG1o
 th83DfbHR1DQxH90SFxpQwlUc6xGF09crvqNCDs3jjgN3kt1eRDq/KajKnfAzgPIz6yz
 nidSf2Wg2oo4KLbbJyH2Q6KuN8RNASZbTocVKeZ5xHiFgUx+w+XFlKTNmzfBswKLlDh8
 QuzFX7La7UrFs9V7kCaYI7Qg7xjUvgQCjWr5JG8amd7UWgceTCk0j/Qezpr58zBdZ7J/
 oazzbB+FeLOXQuzqR9OisQbx2pFcYnNa9p/4S2tgFWWK07S7sv6w801JU1Lx2PrmFE7U
 pyLg==
X-Gm-Message-State: AOJu0YyJJLpigzWIF0jIt5de/+cpC97hB+FqcIfShJnW3CI80KXWYGnR
 Lo1APctJob99eHfAqPPH2XkFLiODMgbDDHqwJKWBDhuE9GsJXcYC4kMwFoOoD9j9D4DXKfi2euY
 STdY=
X-Google-Smtp-Source: AGHT+IGJjP3dxzGxOV9PbaX4tu8w7sv9RYJ43PXrk5lXllScUL4c5WiaE5kmAQZNSAHAvnwIIlMJyg==
X-Received: by 2002:a19:6b08:0:b0:52b:8610:a7fd with SMTP id
 2adb3069b0e04-52bab510606mr2620388e87.67.1717670386794; 
 Thu, 06 Jun 2024 03:39:46 -0700 (PDT)
Received: from localhost.localdomain (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42160a19ae5sm4491515e9.18.2024.06.06.03.39.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Jun 2024 03:39:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] trace: Remove and forbid newline characters in event
 format
Date: Thu,  6 Jun 2024 12:39:38 +0200
Message-ID: <20240606103943.79116-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Trace events aren't designed to be multi-lines.
Few format use the newline character: remove it
and forbid further uses.

Philippe Mathieu-Daudé (5):
  backends/tpm: Remove newline character in trace event
  hw/sh4: Remove newline character in trace events
  hw/usb: Remove newline character in trace events
  hw/vfio: Remove newline character in trace events
  tracetool: Forbid newline character in event format

 backends/tpm/tpm_util.c       | 5 +++--
 backends/tpm/trace-events     | 3 ++-
 hw/sh4/trace-events           | 4 ++--
 hw/usb/trace-events           | 6 +++---
 hw/vfio/trace-events          | 4 ++--
 scripts/tracetool/__init__.py | 2 ++
 6 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.41.0


