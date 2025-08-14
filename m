Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF2CCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbWI-0008Nr-I5; Thu, 14 Aug 2025 13:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWG-0008NN-Rg
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umbWE-0001pt-0G
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:13:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1b00f187so5442085e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755191615; x=1755796415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uDCZPV6uMGt+mAe6STIf4qoEqC9ni2lBYY7D69qE04=;
 b=hDrkJKsvxc9b63AdrSMSmdu32VWxcpOB1hiCLhKJp2TfRKfyaN36OPDNcqGvMY8i2w
 VjXUROoxD0ih2QLyKbFutVqlygJDKZu7cB3++TbAVGXrDIZga10Fi56aGpyUrPQwoWmS
 BmeopEGkXxOxyKSxgJrRNU+WecZzxbrPsQqiQag+Iomt4aFsK4M0gjQrPYupnlSLkx1Y
 HM1TJ+4ndbCTi0nF9bUnsDSnai7NGOjsAAu/isdBFyvjSOI6R2t0wNRvbzZA9suUlhfu
 bBR9+N9jwovLS/aKoESSqIZeJr4w/melgfDNtr7ucgmFGInpgSk1vQYo0B9w3DUKSgLp
 szlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755191615; x=1755796415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2uDCZPV6uMGt+mAe6STIf4qoEqC9ni2lBYY7D69qE04=;
 b=HWTbdib3PZgS3IvbzWIdLQOUZ3Gx72MbE7QZpv996zsi6/a85fI8pnC4M7e0wlSEya
 0frO/u3Ao3ulIaKwX7cQbmC16IS6JZxl3s3+VggnJTERNXr2FMcbJ5bOmRbzDT2N7RPo
 VVNoVHjjVBKFj+Ig+0isrbmlqstPxqpiBQL1Jq97jHWKYsVKgNn94bHPjt2aN5FI4TxN
 xTkQ7J9eB0wVhAEWk2nTi8YEfNndthmXqZWzMadYWyob3lzEMjdtvcIhGLnB/cFtz50G
 KnlJkugPnFZZFM1AC3xB2hsfCupy5OvO+RNCFzzQbKzruFAyjXluW2shvyWLfuuo9V+a
 0uQw==
X-Gm-Message-State: AOJu0YzOqXcxdCzLRSNenpI/Zbs0q78c1uUNjTP5z6qGKAHigSDSttrV
 50Pj2IadhUihoJrFOQFUEllx8F2x7PUo8peXjbiZSzTnvE4RuJB3yd1/jQzMtsuX2oP/AZ5RY5B
 iLlNb
X-Gm-Gg: ASbGncsIJID7wyZFBrOBdw7VROj09E5Gi7v9qiEwjPACKHIzBgd225dt5RPDsS+4CCV
 XYZPqG2nc2EhGMl4Y7g6A1TXIoRM5BTqzNK1ffVZl+7TYwHLb2m3YtuUXDXQwBcHdrEW0dA+7TM
 r55iNhQQyyrZdRLIh+yUuGf3LikD5Eyaspu90YzynQ0zBELH2ZHgUyAh5WMoHUiOKW4TdBqmbe9
 Js984JDp02jmUjew+bON0i/lK0/F5UPVZLT9hqMCyNeSXWIagRSPwG1n2vAnxDRFGQsnLe0dkR2
 dx6gY/c61+uLv5zx0SZYspZkXINMhUV5oksQfVxrD3puK5F+vFTjLfgo1pK7+EN6nSA9l55qLHq
 LeYGGXSv0gj9fDdX4v3yP2ESLGkwN
X-Google-Smtp-Source: AGHT+IHm0KULiRwpido2Ihp6qyOc0zvX5kwY9AvE1FEpGnoC0tvUhB4NMhEz56MmyzUr7lKQB9HKoQ==
X-Received: by 2002:a05:600c:1908:b0:459:e466:1bec with SMTP id
 5b1f17b1804b1-45a1cc22d1emr26874415e9.2.1755191615047; 
 Thu, 14 Aug 2025 10:13:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm29489165e9.21.2025.08.14.10.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:13:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH for-10.2 8/8] MAINTAINERS: Put kernel-doc under the "docs
 build machinery" section
Date: Thu, 14 Aug 2025 18:13:23 +0100
Message-ID: <20250814171324.1614516-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

We never had a MAINTAINERS entry for the old kernel-doc script; add
the files for the new Python kernel-doc under "Sphinx documentation
configuration and build machinery", as the most appropriate
subsection.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed762..efa59ce7c36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4436,6 +4436,8 @@ F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst
 F: docs/devel/qapi-domain.rst
+F: scripts/kernel-doc
+F: scripts/lib/kdoc/
 
 Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-- 
2.43.0


