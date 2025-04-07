Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D606C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oC4-0003wm-PJ; Mon, 07 Apr 2025 11:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nmJ-0002LD-7X; Mon, 07 Apr 2025 10:48:47 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nmH-0001nZ-AS; Mon, 07 Apr 2025 10:48:46 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-aee773df955so3583430a12.1; 
 Mon, 07 Apr 2025 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037323; x=1744642123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEH4N/I/i1s5vyVW9hh0H+Bl+rbHvsyMVIl7sWn6eKY=;
 b=JlbYSzSA8aBDar1D3jrtAuJQmrE+kO7C23PLBvqWso35NtvlJcwraT+eEVw/aZ8xYC
 H5E0t0+b28r1EeWm4aWbYoiBgTE2OTDDVs5RYG1gXoSwALLlRQQ2o/Q9v9mu2sZjsgYR
 hWzuvP/wfGFRCJvllr/2j69lw6IbsW4FrlU3agT8fZXprjo5NWSV4oGU9wCTzJcOtfoi
 6Bf2+2SZ5QbML6OE1GNNj4s4mFwvW0mqjJsCiQjyO5I5Vrp+UPVkdtzF4iF6d6NVa++w
 iHa1x1ZCtq1c2vTV5SGr/m7hzIS/GUvgBtR4ZHG/9cH683QFXLgF9jJQOKg9pnI736pw
 iITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037323; x=1744642123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lEH4N/I/i1s5vyVW9hh0H+Bl+rbHvsyMVIl7sWn6eKY=;
 b=lDKjNZDCHSYp2wTGuOT7K4hBFHfumn9yz/JkmYWnUkqMMB13sgZO/6EoX/aNuF82Vn
 G0b4eDZUENA/2/WRSFji2ROxbpRD/gk80X+5KePOZhuKPNFGvkvpNxTqnShRbliNomkP
 CVtP9/8WGBiVM99D+d2IKN3D1AThETw7jpO+L2bxzfsLep1gYMyKly0dck/5naylhdEq
 2K9uPkHMboGpUGbaLRLmUnhWbSkjN8zFzwrOxwj84ZmepXC9l3Ec8tqFw/NbYoW9TYHh
 hLEs8USK89M6f4pUXkptY8pKV0F86yv7NQ8Ouku4D0Sen75tgWdbukGKAPJHJN8kCQ3i
 9Q6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgJvsG1196/ARie6K22eIGZBKfMJtMLLi9ER/PR1x911/LC/yi6moo+uNV9N9ih/ipVZTsNhQLL/0Fgw==@nongnu.org,
 AJvYcCVplv/sJM5gLTxqDH+M0mRV/VP2WodJrDq8SxZuLd4j649xfguCjUQUZSXbUB53reWcn4CSapsb0TyyEw==@nongnu.org,
 AJvYcCVzsi0mpGJfYEhNzCUj3eIciQkh2Z4QV/gA0aJModv1HFG+aIC/QT87osbs9VZRBOl/Agx5XmEdHQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyufsm+vXUbqYqHVrRwTPubN6XPlgyhfFfzXlQzN+zgggbk/7XF
 HmaUTVvO7FEQL584/9gCUkj14G21yG2Hdy6WsSgiV61oBgZcpRIqNZkPvUzS
X-Gm-Gg: ASbGncusZLwUV9vB4WOZqh8vWaLv8sx+i0sTqfzXvcnSDkUI4jePnqm/wm1Ist2OcKK
 0uCgaJ96rpWnroJVhig21c/GFLKMw7rxRmn0mgVL4gWVjeH5g/TEuI5HGR/V2Uy/wuEWUOcDPiZ
 lidoxGtiPRsmuo2bbUDNFIqA8HNrc6dMm54xU6orWHWs9nFU9+K7x94dr0ZkV1yOI71HLstERsb
 MKL/vh2Th6tKwNO6ilDJobWNDrifDYf+YYdBng/R7xR6mJIlle13c/PyeGqfFIMkLJbyyMwPgJT
 PfJe7jKuPMbmoAHylHyc6/Ap5ZHq4x/gmYdbchnsqNU3rlX1TpmBjUv9nnSIRA==
X-Google-Smtp-Source: AGHT+IFVHb0USmbrtgolvVJ002qQw3Dst2XwZdUHXHObbdn3W+d22R0f9QZhrZRZ9w1sgrYEyRLgeg==
X-Received: by 2002:a17:902:f546:b0:226:194f:48ef with SMTP id
 d9443c01a7336-229765d1ad7mr251187095ad.13.1744037322987; 
 Mon, 07 Apr 2025 07:48:42 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:48:42 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 10/10] MAINTAINERS: Update MAINTAINERS file for wasm-related
 files
Date: Mon,  7 Apr 2025 23:46:01 +0900
Message-Id: <ab804f360d7828dd281c337e897c5817410e075d.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..ea5fde475c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3903,6 +3903,17 @@ F: tcg/tci/
 F: tcg/tci.c
 F: disas/tci.c
 
+WebAssembly TCG target
+M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
+S: Maintained
+F: configs/meson/emscripten.txt
+F: hw/9pfs/9p-util-stub.c
+F: tcg/wasm32/
+F: tcg/wasm32.c
+F: tcg/wasm32.h
+F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+F: util/coroutine-fiber.c
+
 Block drivers
 -------------
 VMDK
-- 
2.25.1


