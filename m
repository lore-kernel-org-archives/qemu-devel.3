Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E0CCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TUh-0002WE-GO; Wed, 24 Sep 2025 13:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TUZ-0002Si-F6
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:41:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1TU8-0001La-N3
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:41:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso96031f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758735652; x=1759340452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgP/SlDqzLAkZxB07VH59pvZW9H2es6rdlsD06W1oMQ=;
 b=kXL2q5gU8Bq/wAqQFBJuU55tb1C0Np99ySZ7LzR534vI5rYjrW784bzzUMGox+umwH
 CZGLpotvKDUwQlbXvxZDXTbLsxYs756lFvu5tZI4kAqAnabIC2ZT9GJWgi+ORwiGNxSg
 UfCJ7qDaSSQJKfOHgNWzsHFG2DzJ7JbDD7ORL2OuXl2pJQYZcgW4gKsD+KnMcy8Kjmxn
 bL8IrEL1zVudIOHOXvE3dm6OrNiwGpf1/KEjGEYjBbt76hPVmgCTAdLXSmBEFC7cmvWX
 /AVbWote0ow7FuN8UXdeNIaCpexcdwuJSs0AhHIvQa9svCkSuvX6crs0mcCN7cFzCIYT
 ddNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758735652; x=1759340452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgP/SlDqzLAkZxB07VH59pvZW9H2es6rdlsD06W1oMQ=;
 b=v9K8Nfwdt0bv8POGDRSZj2EDOFMESId/8DO97aCke+FEVOk7giSW7BkwYi+YSCIjED
 EDxCyDveSdHWhefgJEC63Y5QbrUJrvQR9LkGJrviW8VanJ/i/IaOd9b2YS+ZiqPxeLIj
 PkkpcZkAzPTLDY1Gp1GVJR5gBKK+pp/Rk8WdMrZPr/fuQSUAd5v030Yxa+ERV1vAktV0
 /fGLosePmPv2dANTI+BqxDeSydMB0F5QdgoxLPRCRLc0RdsFBEKeMC0LDETxX7INJt6U
 +KopzGa0olSl2JjJyHChWlrs5X4vwtMvw1VebJasaC9D8E1GOUI332r+ajSohcEGWWAv
 nuWw==
X-Gm-Message-State: AOJu0YxwJECqVgOqU7CJIqL2bDU+v3Vu2k7dvjO1mgaCsvitorDM/WSr
 qnk2SLS5qlpkLiv618eXDo6pMh3KBp9q0opCo6SA+d+W+eOzc9KE00obGbH3Uy5WbZtG2EukaRm
 /LHJ/KNi98Q==
X-Gm-Gg: ASbGncsD5r0QGQcOAgS7NFr3E3vPiv1Yr1iPtmuxeqk0Tx4r+MiI1nRx+LK8A6ej8QM
 UK3+KFqmkFc6QlPd85IUJsfmiBThbumVSnowFQoTdNHPJyWZXdCjTc6TNALQEV2mnxvhjsyvkw5
 gc+UQtt1HKQSeArW+eL9clgKbRTS1WPTx/MewlbytFFbCzgOi5dByrWSEEBJtmtcx2zGxFBMEyP
 Od6xe0ZZBIJ1I/+2Y1pSBViLdixex3fB3v+vx2rpsEgFFvC5dV4eFRzUiAbmdqYM0SWyVOGRCnc
 3llriS8NYeY/QlFxfDenxToZEy6PW2bnHo9nlmf5hjFG1I9clajH060uI/osJ6QjzXAEyBFxcVj
 HKxcybk/pz74EohSa9rDqB9owk35b/VVzNpKmaguiujYWaLtYkKyUfUr5DKgId463ZNtJxDgbep
 2rbiJNuo4=
X-Google-Smtp-Source: AGHT+IGKALQvK2IymTzirRSUOCHtCFKE3H2+yLOth9dvEL74oPjnNCpbyZHhVRnc4DTnFOlqOR9/dQ==
X-Received: by 2002:a05:6000:1848:b0:3e7:4719:a024 with SMTP id
 ffacd0b85a97d-40e4a8f9a9emr531836f8f.18.1758735652416; 
 Wed, 24 Sep 2025 10:40:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07412111sm28505631f8f.28.2025.09.24.10.40.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:40:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/2] hw/core/cpu: Expose CPUState::start_powered_off docstring
Date: Wed, 24 Sep 2025 19:40:44 +0200
Message-ID: <20250924174045.54241-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924174045.54241-1-philmd@linaro.org>
References: <20250924174045.54241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

The comment about @start_powered_off is buried within the
CPUState structure. Hoist it to the structure docstring
comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fb788ca1107..f88765e525c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -412,6 +412,7 @@ struct qemu_work_item;
  *   QOM parent.
  *   Under TCG this value is propagated to @tcg_cflags.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
+ * @start_powered_off: Indicates whether the CPU starts in powered-off state.
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_threads: Number of threads within this CPU core.
  * @thread: Host thread details, only live once @created is #true
@@ -496,7 +497,6 @@ struct CPUState {
     bool stop;
     bool stopped;
 
-    /* Should CPU start in powered-off state? */
     bool start_powered_off;
 
     bool unplug;
-- 
2.51.0


