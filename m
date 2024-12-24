Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D6CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 13:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ5JO-0005ZP-Ic; Tue, 24 Dec 2024 08:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQ5JM-0005YQ-R8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 08:51:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQ5JL-0001Bg-64
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 08:51:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so3818359f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735048256; x=1735653056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YHkePhHW3fjNje1FWSQGji7mHqmc+wh0noiPp6w6Deg=;
 b=otUo5wQSET2G+DsiyhhyOl7D5caufff4OYEXM6sk6P84t6LOf1lhFwIc6CeLdwgLYw
 lgVt7xZ9O+nUdC/G5mFEJFfNIQ2CspQA743tcrD1FgSAA5jEvoTG3ZGVUJZzE3duBJ+p
 E29f5OVR74Bkvp50IBrXRIL6sJnMsNu6XZAzaBW7sSzh6++gFIJIyg6mY2a8B8ZFvtHY
 YEZy0GTlyvlLnlhRVRiAbShsX87av22bDjwdT2Dy2OZBmhBa11ZpEqLgQkF1fZkZkgDT
 rYKSLew7W77DN8McWxKLEydFZwGxcy9KYkma99QZi1CEUYgidrZkpVfguO1MOqR8Y08+
 cUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735048256; x=1735653056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YHkePhHW3fjNje1FWSQGji7mHqmc+wh0noiPp6w6Deg=;
 b=nWfZ0S/C+ie7M01q5yAS+KWlDKzqi5CLx0kHjwXHo8+5gWXO2P0WfYNaEnoENBiEa3
 kqmaZ0A3QjfS8joiz8W/HpiW4DxLsL+PRdJ6Fdx72O8FEOe8VJHia+RLHFnc+mo7rAnu
 YC1Xbrvg+KfWHwH0ThmquJ6C/2fLYYgrHcTZvzVQG+FZ9CTorlrZTIjHeb2D5GK0gDG4
 kIYrePpke/I+HA9l2ub40IPh+hNGXXtivzYUmEtp+3mH2RHTyD+tQdoynfQFkdVFO/PD
 JnhdReeEKXfcDIIwkXO21BR8TgPOo11Hu7lPbV+qdR9YBU4Hqia7LEd9KsLHa34lQ0hS
 envw==
X-Gm-Message-State: AOJu0YxXA5VLIBNqjLP/6/918GqrB2/QrfqDA2zlRjuqEwPrVFbj4w/y
 iCvtip3qyHKTO5r9jizpb0978MObxG7MtulnlX757sod0gAlMGbTfO/dhAFtbxF6OOT9vYEPhWM
 b
X-Gm-Gg: ASbGncuYgWGG913BEd7pi1DTBJpDS4tF1wR4jKbiCPQvb5eCO4TZ2DunRygTpgUiafo
 PywqJOVXC2sbFLy5wokKnBQqjuxJ7D5EZT2tof28i3OFVF5BNvm++55JxM+UtrfnLjg+5/Dojkb
 8K/jd3oFPR0BZKUom9Gj3ArlqKYort5RnJd3OIob04I3O+KKQ5hLw2A1LlU07SS369UswLIP2DF
 MhL/XqLNfLrTrJWWXDMouNKfdU3Dnx6YZIMuYnuI1gQ5GpHjYvMPbAzjr7LP6XX623wrHjUpFE=
X-Google-Smtp-Source: AGHT+IGANAVEOZlm70TmC8afVvtqWHSkVgHJECIL+TYz/cP9yLlk1aQvCAGAN9HP5gGTLKLjlAosoA==
X-Received: by 2002:a5d:6da3:0:b0:388:c61d:43e0 with SMTP id
 ffacd0b85a97d-38a223feb92mr12513449f8f.48.1735048256343; 
 Tue, 24 Dec 2024 05:50:56 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e357sm14597147f8f.72.2024.12.24.05.50.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 05:50:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] b4-config: Configure Lore masks
Date: Tue, 24 Dec 2024 14:50:54 +0100
Message-ID: <20241224135054.10243-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20241222-b4-config-v1-1-b3667beb30a4@flygoat.com>
---
 .b4-config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.b4-config b/.b4-config
index 5feac156429..af9cfdcd3ed 100644
--- a/.b4-config
+++ b/.b4-config
@@ -8,3 +8,6 @@
     send-auto-to-cmd = echo
     send-auto-cc-cmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback
     prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
+    linkmask = https://lore.kernel.org/qemu-devel/%s
+    linktrailermask = Message-ID: <%s>
-- 
2.47.1


