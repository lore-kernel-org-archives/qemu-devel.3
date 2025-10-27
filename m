Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41D6CCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 16:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDQTD-0000gl-HM; Mon, 27 Oct 2025 12:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQT9-0000eA-Le
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:53:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDQT3-0000wz-AC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 12:53:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso25712725e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761583987; x=1762188787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mUKEOpc8DZlHgycGgGPp6xBX6hImmBkNEo9NEyKOQj8=;
 b=dsEeBhDj6VnxQS1Q58bxjuyYQL4PHYN7nfiyxggRPtZvzGj5Bqqv3x5Q4bzoGMMKY4
 e4QHDSiHf5GGmz8Zc7CMf9SAKSa9jBIcC3AhtcCSig+cUEKZeakEgGvxH2JsS4kZQeIZ
 RF4YtAFghFUtwhfWrMqAD+pGfXy/RtAyrgYLD6P5bNX6ACf5HY9YT8WkfXIbLk5uFuXq
 3+bj8jf9S1ZhLyk1bl3VfA7VOk8CnfLctbJ8mxDNRlGpw1riaj+Y8UaSh/EhwHHpTCAC
 Vrv4uMCs9YyYPh3ZqHGyK/Lv7Haw09leEQFT0YXEujRaMRxcm15oAQerJoQwxazTe5Zb
 dGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761583987; x=1762188787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUKEOpc8DZlHgycGgGPp6xBX6hImmBkNEo9NEyKOQj8=;
 b=fs3jfdEsVmO0E2shVISFes/n0Q5WLDKsB+i0hQbIhJnLXlLXvcKKNHU9W5bZIzkccs
 Bj3fQ6wZTIlUlsmi0tBUGp7AKEruHkW80SOIypH9q9EBfWuUNoCJ/xvdX7eMSWqfgVYv
 PAV0E+Ii2nCcvoc+eA8fPfGoTEHNkUcaI8RGFSa3ZHCFnzlW/gyOYv2h5v3M+aJsgnoj
 g6PwM7OgoVTVLAx1vU5RBw8pRtg9sOaePuR8gPiYQTeKSsHdr3EhRFVav6ssG1LUSUFQ
 gyJ4H8NcjhsndgGTuiRGtGO75iW9W9DtbVcNOAEkKNirm9bEccy3hmTyUXz9cMkLyXat
 Ad8Q==
X-Gm-Message-State: AOJu0Yxa50C61i1BN8Oaez69CCJl6XGVt1Qw0JCgJwoWoVIXa0WEvtFg
 SEdHAfbR1S46wRjAUzvjd5yQKczmH1sT6+yTTzuvm5slo1XZwLHXN49RkYLaB9mgBAlVitoUhUk
 9SZtbsGg=
X-Gm-Gg: ASbGncvqoPoE7v33JAsYCev964RdF6YEo/t1t3chbfRqL/a1slBekNMUCsLZ4T8DNWi
 oNdnqlCahy8nlTiu6nNR1NdEtBAnG5C85nO6r8SFW/4evdMQEFsUSd5wXXVRa3sDUHiGhhqRgxe
 xyKzCJVXET07IXPSR2xNNZXL0d8FWyHCsHWqf+OnFJoO/heK9Oc10SiPTkZDnJ8iJrzOvAA8KeW
 jApQZpfliKd3eR55zMEULAGAaSJcP8EPVCCN6o3IokZBilcyBxDRVg6LZwcS9VqfsulnrRJE1H6
 NyL4J7MP4DCBpjHC2OG+arcLydjjtv9hUrpEPVlNskX0+IhI/K0CY3JvudUID62pjZ4mWThycJP
 m/+tBR34AXHrLvhRcjNX4TenqjUb/6fhfwoglE37Cl5eX+hJoIdNGzmqlHT5/oNjlWlpFT3Nf2x
 E/Mb5KeP4XUl24a7KxrJY0DiWEGXzf4fF/VOLN/I0ULcwbh2ffvw==
X-Google-Smtp-Source: AGHT+IGRpBk+c+zX1B+k+jE4hZrTq9FPwvtH27WuNxTS/2JjK9xCG5HhCZ7V5eSiX5u+kdvBWLFrPw==
X-Received: by 2002:a05:600c:190a:b0:471:9da:524c with SMTP id
 5b1f17b1804b1-47717dfd4bbmr3333105e9.12.1761583986870; 
 Mon, 27 Oct 2025 09:53:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4a36easm146448155e9.10.2025.10.27.09.53.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 09:53:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] hw/pci-host: Re-use generic pci_host_data_le_ops
 MemoryRegionOps
Date: Mon, 27 Oct 2025 17:52:56 +0100
Message-ID: <20251027165304.98296-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Add the 'config-reg-check-high-bit' property in order to re-use
the generic pci_host_data_le_ops MemoryRegionOps.

Philippe Mathieu-Daudé (7):
  hw/pci/pci_host: Add 'config-reg-check-high-bit' property
  hw/pci-host/astro: Re-use generic pci_host_data_le_ops MemoryRegionOps
  hw/pci-host/dino: Re-use generic pci_host_data_le_ops MemoryRegionOps
  hw/pci-host/sabre: Remove pointless OBJECT() cast
  hw/pci-host/sabre: Include 'host' in host bridge method names
  hw/pci-host/sabre: Re-use generic pci_host_data_le_ops MemoryRegionOps
  hw/pci-host/typhoon: Re-use generic pci_host_data_le_ops
    MemoryRegionOps

 hw/alpha/alpha_sys.h      |  1 -
 include/hw/pci/pci_host.h |  1 +
 hw/alpha/pci.c            | 26 -------------
 hw/alpha/typhoon.c        |  4 +-
 hw/pci-host/astro.c       | 35 ++++-------------
 hw/pci-host/dino.c        | 30 ++++-----------
 hw/pci-host/sabre.c       | 80 +++++++++++++--------------------------
 hw/pci/pci_host.c         | 10 +++--
 hw/pci-host/trace-events  |  4 --
 9 files changed, 52 insertions(+), 139 deletions(-)

-- 
2.51.0


