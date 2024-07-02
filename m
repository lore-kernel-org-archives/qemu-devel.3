Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E81C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfN-0001js-I8; Tue, 02 Jul 2024 01:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfJ-0001Kz-8v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVfG-0007GJ-P2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso29004525e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896569; x=1720501369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IoGL6utQV9KZz7a0NZhlOkuZgg5oZQA8TSNIPaPeX+c=;
 b=pxJRoc9gnLyrVxrTMnue1Z0fOLHpNxnGcGXazHLBw5djDfb3GGDKZOBolVqHgGkbWo
 Zxd1nEsbaJjKQ3AVnUh/rvVRx4eauN5Sm88b3k+I+lFc6LPwsObrnYIsjQ+RW3re3yG5
 DA4lmFoicpsSxKRya91W5EbkmPZxqsvwO05SkU2xGf2w7gbscHmLrzKyN52CMUlhFf06
 8vVCqwlQuLerI1zgDOcd0hyr7lhp5YcpzPNEuXeeBZRM9CuNNjEIZMunkQv6l2ZDERZw
 EfnIkpJOVrXryB0EEDkRQjyjeniyP6qAG+m34rdYIiLZ13P75jFdXgWiUbXtdIQHoLaF
 JcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896569; x=1720501369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IoGL6utQV9KZz7a0NZhlOkuZgg5oZQA8TSNIPaPeX+c=;
 b=Uc3PzVzXLwDw6D4N1guwKQ7E8sKkfJ6216lE0f1XH5aSkGVeGjfMIMhT72pK7kDLqC
 NIR7YYl1pvipwQs8kejbyQ0oXTiTIGFIw0NDYxYHDivgUc1X/8qozZEDZNx49o6KjeLs
 W9IcMlswjrEpMOc4bTyfLLUg+D/V7SbqrQ8hjLWL/HbqeYUCb+p4l5brdn5EVykQzoFY
 emjui1qbqxPeiaS5LfsSO9jU80gRuitvqu8X8moF7QWFKvg3nlj99rxrgaPwniWaBwQJ
 l1z2quMYfi62G8iGtn3lV2TV1FyX8di1B3KOgm+/UCIOYTqb7D1TsJ6D3JfZLh+2TGPm
 QYKg==
X-Gm-Message-State: AOJu0Yw8l9F8QxfCfW36TajAaEEzg3YRjXP+E9hTvFT7x7TxaW2LfT9I
 SioCaHbbTF5KZuHyVuHe41LIOmHr8xBCCxvp1yBKrZOVB26N/CW+rPy86KNQkKPg9OJtscfWDZ5
 c
X-Google-Smtp-Source: AGHT+IFVM6prAhPdX59Xe0UIszUnCIjlrZFwQ2OcgmLo4HyK34MbZmFeg+xhbdSncMOvgFCOT5PWqg==
X-Received: by 2002:a05:600c:3388:b0:425:600a:5e95 with SMTP id
 5b1f17b1804b1-4257a06db61mr43950945e9.39.1719896568880; 
 Mon, 01 Jul 2024 22:02:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af389efsm182140545e9.7.2024.07.01.22.02.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/22] docs: document special exception for machine type
 deprecation & removal
Date: Tue,  2 Jul 2024 07:01:05 +0200
Message-ID: <20240702050112.35907-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This extends the deprecation policy to indicate that versioned machine
types will be marked deprecated after 3 years, and then subject to
removal after a further 3 years has passed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-15-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ff3da68208..bba12d1641 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -11,6 +11,19 @@ releases, the feature is liable to be removed. Deprecated features may also
 generate warnings on the console when QEMU starts up, or if activated via a
 monitor command, however, this is not a mandatory requirement.
 
+As a special exception to this general timeframe, rather than have an
+indefinite lifetime, versioned machine types are only intended to be
+supported for a period of 6 years, equivalent to 18 QEMU releases. All
+versioned machine types will be automatically marked deprecated after an
+initial 3 years (9 QEMU releases) has passed, and will then be deleted after
+a further 3 year period has passed. It is recommended that a deprecated
+machine type is only used for incoming migrations and restore of saved state,
+for pre-existing VM deployments. They should be scheduled for updating to a
+newer machine type during an appropriate service window. Newly deployed VMs
+should exclusively use a non-deprecated machine type, with use of the most
+recent version highly recommended. Non-versioned machine types follow the
+general feature deprecation policy.
+
 Prior to the 2.10.0 release there was no official policy on how
 long features would be deprecated prior to their removal, nor
 any documented list of which features were deprecated. Thus
-- 
2.41.0


