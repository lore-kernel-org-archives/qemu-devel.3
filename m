Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9CACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GQE-0000Lz-Fz; Mon, 29 Sep 2025 12:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQC-0000LQ-PL
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQA-0004DX-IW
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so22018575e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759162089; x=1759766889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ivEg3ot58LNIVLeR6+U626Yg0Qzw/uJB58eermXxO74=;
 b=h0MRcvqeO8mmv49o0cWWH92/fGUPKNEAJBh8KA0COciNkDBPZC6kzbMjTVdl+auIO6
 TxDs/6Lqc4cGeP7sZzjVyeM3g/iOoD5g57phYjZ/QAohzYvW4bNrzN4TFrVFmI5LwvJR
 ot7m7ezVV4Aog/vOWH6HCJcYxDjvoqQoyJQdzrmJP3ik3nJEIkqwSOm/zLsl661O+ztG
 JE5+Pn02uRZjMEoyLhrPlVz5rhNyc8j8k3/U+shJT7MADt7HU9BTYjEQ/EoSIZhwRhES
 JHbHfC/FZt0hiOqdOYM3mYlrDWqeVsXhm3l/a5WyAAZiDkYpvqdJHOkjVTVqdaW9/3fm
 cUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162089; x=1759766889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivEg3ot58LNIVLeR6+U626Yg0Qzw/uJB58eermXxO74=;
 b=cawdP6Y4mUPTNSq9XyWy3m3yrs9oDy7/Be3P7cPmmnVaOQD11WP11UjwbA6R5Erk3C
 J1PR9XKadc3C+AoO8q5JwhfvTu8N4NohoormW7oMVQaVW9omDfmp4AlSxYYYSEznEEbQ
 X5kxlGfLlpRGxmQBSDKrDzdR9fo+BN38VXQ+zGHu3oivc07ifLlTE6BxwqtaiXGI/nsX
 nMpuFfkvvX0w/zhGK71Lk5kA6fHySwwWRBLvCngp6InOoUoNRK4kkdTZb0Pqj3tb0a0U
 i+sexL5vH2hCtlhMr/8jb13ALmvN9OUbzO0czoPKe8omHORvMvN1AK4IJZoMhFOYbX5p
 bMgg==
X-Gm-Message-State: AOJu0YxCLXb8TlZRhupPWG2VZrAKiqQMMdYpXNIkOid5mFIXyM6O8DSU
 jmt6vSiJLxnr8PsAvP4tQVcmMkQQjRGY92mnGDaTQKWjhBRPUzWhU1dcnPl/UTK22M/uyui4ckS
 Oo5+By6OYrQ==
X-Gm-Gg: ASbGncsfouw6OZFfbBXzgg71HfvWCs06+WbhyASoNO1Vq2APNefqX/pZiOIJpps4OY/
 naqMKobHKBLtr2rKnBAJv3p6FYMJRWYB6S7wEPa26coRh7UjmsMN7Tgqbn4JS1Ns2CW1ynLwP7r
 0qfS9jC+7grj+QDMnTVMq6lhHP/bJookbXSVh1Ir8C3O1YxsSiBUm4bK2vygEfSTESLs5Gbj9KY
 o43t37fBsEpnrh7iaVPjoIv3T7jOvWTcw/MIYXlfWjCsUhHJNfJSJdTo6ixqjJssp1BhGTGTHEg
 w/lkoQK3Ccpi0CGEu3r84jZGmJ6JjcD365qQwcsHzmELDaDSFG3rpBsGOe0Y/F7WIIO2ONIpqFx
 BdOpp5I65ZR/liiQGPNMJgzyp3NYyz4fjvfcV0L6EqhApVKNeGjB0KqhOs3+FRUbN9o4lCymGYU
 J4S6Fdrac=
X-Google-Smtp-Source: AGHT+IFw+UOHF9c68SuAKIImMkgCcGreYyMNqOZEQUJv+1fqaC2Jff8MRO0lwi570yNQf9OximV7bg==
X-Received: by 2002:a05:600c:c176:b0:46e:32a5:bd8d with SMTP id
 5b1f17b1804b1-46e32a5bdb6mr151172355e9.3.1759162089341; 
 Mon, 29 Sep 2025 09:08:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e46de67e1sm99409695e9.6.2025.09.29.09.08.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 09:08:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/vfio: Remove invalid uses of ram_addr_t type
Date: Mon, 29 Sep 2025 18:08:04 +0200
Message-ID: <20250929160807.73626-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Replace ram_addr_t by either hwaddr or uint64_t types.

Philippe Mathieu-Daudé (3):
  system/iommufd: Use uint64_t type for IOVA mapping size
  hw/vfio: Avoid ram_addr_t in vfio_container_query_dirty_bitmap()
  hw/vfio: Use uint64_t for IOVA mapping size in vfio_container_dma_*map

 include/hw/vfio/vfio-container.h | 13 +++++++------
 include/system/iommufd.h         |  6 +++---
 backends/iommufd.c               |  6 +++---
 hw/vfio-user/container.c         |  4 ++--
 hw/vfio/container-legacy.c       |  8 ++++----
 hw/vfio/container.c              | 16 ++++++++--------
 hw/vfio/iommufd.c                |  6 +++---
 7 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.51.0


