Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAFCD3000F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1njc-000105-IR; Fri, 18 Oct 2024 10:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1nja-0000xs-5E
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1njY-0006yh-Jp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:13:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so1925962f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729260819; x=1729865619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=603GFU4/OLS3KRoV1w+4LwOlh2l5ru3HKLAtyoHGj6k=;
 b=Asmy1HSgZpIDNtG+gGhN5eCXTIqb5U+weqY5E5vVuLgXVdEYNfGw/Ii4O80FcdQ3Es
 cmtf/CsXuAygz0Nbf2qfI+AhRPZWLCiEpRqhqlv2PPiJTYevqGKb+HIFP46HMKyhRDiR
 oic3ko+Dz4fmueXKQeiOb4OM35ipwE4HpEloXFzB0eU834fJO8QCL7ARxJfYpH05DWnR
 26AoKPcUIuI88BC+ZWjN3D3QAsb6Fr0YRibQ3h2zp0Ivw5G70E0oLB0n2Y9Gs/Di4CNE
 8fdpVyH4kF91uKrynw2mi1B3vzyYG97qje/Qy5V9Dv5+NYyXdFZ6UcotIx2DBksQJ+3v
 upCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729260819; x=1729865619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=603GFU4/OLS3KRoV1w+4LwOlh2l5ru3HKLAtyoHGj6k=;
 b=WceWWAEtSVtqs6JkBhCcUP0bI3tkDvjiBWfXcFdUDj/n88ZYVZlabxzP+FnK8Timyw
 O/uhlw09euXYV4H14lq692cn4EnD+35sj4CieBdvyxYv/S5NoOFH/6wf4crz5fbJJwuu
 H2eFQo5qakQQFoT5F/vd7t2t7qE3gP5RGVciUZd2gpdoHNIYh3Wx2YulQj1AE5anEc6l
 9GHTMe4+4cb54Vaxgy2SSbddgylLZ11dKH4o+Kzs+FqQ6HgyFXSXzh4aVmAr9aE7tNRG
 Uj1ffIpgIe1OdPCrB4GIZywf/kuEXcnlg0DZkb7JoZssvc8jncAUhebzcrJC9yRusXQg
 SLrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuAiNXDkoJ1BDsVhJ5MEiQG1Dv9z1XGBdpO404zstcoW+e2XgVaOfXH6hXItGAXnUcKnRBay3aqmAe@nongnu.org
X-Gm-Message-State: AOJu0YzVDMI5X6A9RgzM64+W95ZtNuvH8pAWdop1T6NIkVwCozTzawtk
 HBe6tpCKuQKxkKXUn1RRI73TZqnqr4KU5lq3VUy1gjilESW5dDFgv95zfy3Uldo=
X-Google-Smtp-Source: AGHT+IHF73B9tmhinpRBOglsd/H16yqanHgOAnnBqlzr388dWbnF0mnyczeVRzn97oJQz/hM0D4Afg==
X-Received: by 2002:adf:f7d1:0:b0:37d:4cd6:e8e with SMTP id
 ffacd0b85a97d-37eb4768f72mr2865236f8f.48.1729260819032; 
 Fri, 18 Oct 2024 07:13:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ecd89sm2040086f8f.78.2024.10.18.07.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:13:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 7/7] docs/system/target-arm.rst: Remove "many boards are
 undocumented" note
Date: Fri, 18 Oct 2024 15:13:32 +0100
Message-Id: <20241018141332.942844-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018141332.942844-1-peter.maydell@linaro.org>
References: <20241018141332.942844-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

We now have at least placeholder documentation for every Arm board,
so we can remove the apologetic note that says that there are
undocumented ones which you can only find out about via the
``--machine help`` option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/target-arm.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1f806cf4a46..9aaa9c414c9 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -63,10 +63,6 @@ large amounts of RAM. It also supports 64-bit CPUs.
 Board-specific documentation
 ============================
 
-Unfortunately many of the Arm boards QEMU supports are currently
-undocumented; you can get a complete list by running
-``qemu-system-aarch64 --machine help``.
-
 ..
    This table of contents should be kept sorted alphabetically
    by the title text of each file, which isn't the same ordering
-- 
2.34.1


