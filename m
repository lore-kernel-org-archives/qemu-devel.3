Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ECCD6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsBJ-0001a9-KK; Wed, 17 Dec 2025 09:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsBH-0001ZM-Id
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:07:07 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsBE-0007Xo-Je
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:07:07 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so61119855e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765980421; x=1766585221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RqJbF03pzWIfxDeKZ726tkMdZpAFN0A9E6eDady4CMc=;
 b=YG6Xuh7mnzd4m8p2sW56SkRUe1LtMvHomPTO8xUS6BioUJDJb/TF6TpXYIkQEXam5b
 qRJ+sc1MBqPBJu+BrFcDZSqshdy2eF2GI2Hq3WdZfiuqnZl0Vu1WVHymh+6o0DWo07+N
 FyjQ7l/0zPZnmTU3z1reCoCVAcuakafpnjr168BEWa0OexnWd6ZdfQLlq0bH9P2GMAPI
 26X1Cww4V+CuIdx/C93VmR0jrO52lgaABHAJ/Yofj0JExML06PHmD+C5tbWiFtjX2Sm3
 ZIrNVVHKUDIJ8YDenA1evlKCptJfL6A0zADVXdZDc5hfj8a3yeuD+9k3l1CljuhzttEG
 dvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765980421; x=1766585221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqJbF03pzWIfxDeKZ726tkMdZpAFN0A9E6eDady4CMc=;
 b=uVUMnYfWqhWCdPOO/pWJU2WkrcSOtdekhciqLGAz/8xBMfJBo8U3/MBsRzPydack6L
 e2CokalOf4BraJjr71Cf0MSMsyWrBHUJ8li19/laZbP7EDQlAHiEI6+mfZAai7lVYyEg
 JdNf27+6P2l6iDzVPi04n5RrvGhPjsZvJoMRTEk2WObVdTwjixDXkT5kG7NFw0W23o5f
 93FgxrU/6JmNk3tiTG51hpLQwNGh88NFIJ2GwJfeRLhe/qVYnuc4Nt/NwOGfm3Y1sHIU
 rRG8sWXl5GIGJWUeu/X+C0BE6aOl9FdC3gH112jd9whZrF5qSlUmmtS0unsQNNH3DBHL
 GbnQ==
X-Gm-Message-State: AOJu0Yz776EiI6lzvF14iiXxJGuACRwjBw7cUr21ns+nKBZNNmE6acUR
 +rOuuzmZ38oxBEFI8N9pTuG7F6Nx3kemRRExQQTzLZ3akSaeAfvjzur2ciB8/6jJOCMj9IFftu5
 m18JWAgkvUg==
X-Gm-Gg: AY/fxX75KNabmiNWH4IsNkOCNByekTN1H+ZwJIird0ozz9lVZGcVyMtzpf4bEE47+xL
 My5X+AnL0IXhD8wpLplVtiUCCn4gMgb0fL8SzwF0GpTEmeJZ/QM4orrukRQexrnMDpnFr0zqPuN
 P5/Jv7h5Kflr4nVFsxCAzUPQb5XqALs87TrEvt4Lxu1gtqEBIHnCXXkB4SuNqQ/jMjlubVNYfm3
 JTZWX8a+4NGv9P2AuqyUMzRBlSoIBQx5AJum6U6Tps2ULF3M347Bkw7ezfKexnuFIe6RPObVioU
 LIiac/7M/EtDALVzNt8uSTdCIbPIdX/tMzU3jtIMNSAmuJC4klhAtYnEdpHVnJjeakZw//XK/0U
 VAcUAGH0VIfJ5anjKI9sBsldfOWs45ceX0Wjkv2UaTvSmgCvQ6/4MLkX/tplTL8RJcTc/xOQwD7
 TC4F7XB2jzF5DAi4qTvCHuzkyOTGoi4VhBEIV3DZ4K1LyX6tqrP59fam6NLb5c
X-Google-Smtp-Source: AGHT+IESdHtjJyxKf2Ol08LO4MNbLIp6u4KXLxytMkRgVgGwn3FIJ+6h5KCfo5XIStIzOYP+/npHMA==
X-Received: by 2002:a05:600c:1550:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-47bd9c7d6e1mr47408945e9.18.1765980421053; 
 Wed, 17 Dec 2025 06:07:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc2221e3sm37900445e9.10.2025.12.17.06.06.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:06:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] hw/arm: Deprecate legacy VirtIO devices on big-endian guests
Date: Wed, 17 Dec 2025 15:06:57 +0100
Message-ID: <20251217140658.89715-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We couldn't find a way (guest OS with VirtIO drivers) to test
a legacy VirtIO device on a ARM vCPU running in big-endian.

Deprecate for the v11.0 release, giving 1 year to users who
really care to contribute functional tests.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ac31a2bce42..3a69facb0f1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -515,6 +515,17 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
 only with ``-cpu max`` (which does not guarantee migration compatibility
 across versions).
 
+VirtIO devices
+''''''''''''''
+
+Legacy VirtIO devices on Big-Endian ARM architecture (since 11.0)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+There are no functional tests for legacy virtio devices used by ARM
+machines running in big-endian order, which makes harder to maintain
+the code path while the code base evolve.
+
+
 Backwards compatibility
 -----------------------
 
-- 
2.52.0


