Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D91C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEv2-0007NT-Gx; Wed, 30 Jul 2025 18:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEup-0007IK-2i
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:04:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEun-00020O-B8
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:04:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so303858b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913086; x=1754517886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pg5UGZMexlPnob+VnCajULOONFAP8RYXT5SgpFgIkU8=;
 b=cPvByzEWL5059aMdYos9b5WJnTFO7qgLTQgGFMXcp9o9qCVCuC8iL8R0tA1gicBiUm
 fRcyZyVl2BRwOrFrwb/ybbM6BoWZ935ZJzLEuJOr/sZCYmaIOWXOYvR4/zKozuqHJlGd
 9rYIXWVMP3w7NHQqh+Q2DfZRhoSfkGdiVEL1+WLlazK6Hy46PzAl60K02RW7wR+10vCK
 wWWZHCPpA1kH77ZGx/+JlOfXSjGC2UUyiqvvITVKy/KVl2GDK3/RZdv/gK2zUwDUEfhg
 peVfCSPR01MkXxpo3WeQcJwFhYPDaOU9Po4GhIsF5XVG5YSjfJwgYEAhoOUikaCfPb6w
 4bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913086; x=1754517886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pg5UGZMexlPnob+VnCajULOONFAP8RYXT5SgpFgIkU8=;
 b=GrB1vI8j/cK8/rBSvPsP60orC0p0rSHa5L8b2ookCsvD+X0Q0PqzLLeYtaNxTKU499
 1pwgm5LHFbk6sk3SydrxChvEBUvV8M1x0gJdYl9657ldveRBNue6BrKVVZGQyOfnMbqe
 1KYCn8AvBAKD/oKaKENUHdDUwKPOS5ptUHekpJ7wVLBcnUh2d2MqKc2dAappdnv3/EQH
 V6YccZgAjBOgMPyEyhMw7kznV8XWjwU4e+umikakSpYeg8Cv8jBgd2Ig8by2euFU7Bmn
 POKcA6xz3G/DGQ47gMS4HTAs4yAYqqTI+xPle6konvEdSUjpSZRXNJB+VGs/cqlQ8jid
 4pSg==
X-Gm-Message-State: AOJu0Yx1aDIQlDQLplNOQzX+reH3AljgCRGdy4nic1Dt7KFLgnD8H79O
 AQpd3OoA6h7UbC2Caje8C0dVmMm8gE5MXVZY2Zwv8uNe6ue081ZHaSOpVPw/tlxxNShza7Yf806
 vuY14
X-Gm-Gg: ASbGncvIn5l7VKp2flGgN8XrFyWozP3RWHby3sDC7liHaWpnztA5Q0e24iEJ+uDgAdy
 59hbXsU47ZHJXozuWw9Z8KNhZA0Tr6OsLN5k4x/cyfp3O9WVOZT/jK6vlZJcwx3ZL/DCnGaJnmF
 9DE/KMNOMXwJOh+YpyDAOM2j7wNC6wN4cGpYb/uFTZIvnPZkm+lM/QsVuR/1r7ejhww36Ti5ZvI
 r+mAXUnDECQDEb/iXemYBN/obg8MpuVZpmU8sRqa53m9zw0CWTynaqQ1To4x4kySros423VvG6d
 IIbq/F+YDFymRiiXmiofoaDqB+JxY1kzdYJA7QIANusjBKgLfFMsSs89oi9RRHhLQnOO0oQGtHm
 WdY9j/ZoRYLOxGXqXVSfYxg==
X-Google-Smtp-Source: AGHT+IFigaQibQTnemsDJ//A9QLKyD7OqluljmrroNY3hHLseJ5gN4metgRgfFOtYwd3sIzRmqZaQg==
X-Received: by 2002:a17:903:291:b0:23f:f68b:fa0b with SMTP id
 d9443c01a7336-24096b05b02mr52752245ad.37.1753913086520; 
 Wed, 30 Jul 2025 15:04:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e757sm1095645ad.55.2025.07.30.15.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:04:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/2] single-binary: compile once migration files
Date: Wed, 30 Jul 2025 15:04:33 -0700
Message-ID: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

This series removes target dependencies in migration code.

v2
--

- rebase on top of master (one patch was already merged)

Pierrick Bouvier (2):
  migration: compile migration/ram.c once
  migration/vfio: compile only once

 migration/vfio-stub.c | 16 ++++++++++++++++
 migration/vfio.c      | 14 --------------
 migration/meson.build |  8 ++++----
 3 files changed, 20 insertions(+), 18 deletions(-)
 create mode 100644 migration/vfio-stub.c

-- 
2.47.2


